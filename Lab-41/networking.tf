resource "aws_vpc" "cluster_1" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "name" = "cluster_1"
  }
}

resource "aws_vpc" "cluster_2" {
  provider = aws.eu-west-2
  cidr_block           = "172.17.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "name" = "cluster_2"
  }
}

resource "aws_internet_gateway" "IGW_1" {
  vpc_id = aws_vpc.cluster_1.id

  tags = {
    Name = "IGW_1"
  }
}

resource "aws_internet_gateway" "IGW_2" {
  provider = aws.eu-west-2
  vpc_id = aws_vpc.cluster_2.id

  tags = {
    Name = "IGW_2"
  }
}

# Create two public and two private subnets in different AZs
resource "aws_subnet" "cluster_1" {
  count = 2

  vpc_id                  = aws_vpc.cluster_1.id
  cidr_block              = "172.16.${1 + count.index}.0/24"
  availability_zone       = element(var.availability_zones_1, count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "cluster_2" {
  provider = aws.eu-west-2
  count = 2

  vpc_id                  = aws_vpc.cluster_2.id
  cidr_block              = "172.17.${1 + count.index}.0/24"
  availability_zone       = element(var.availability_zones_2, count.index)
  map_public_ip_on_launch = true
}

# Create two route tables and two associations each per subnet

resource "aws_route_table" "cluster_1" {
  vpc_id = aws_vpc.cluster_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_1.id
  }

  tags = {
    Name = "cluster_1"
  }
}

resource "aws_route_table_association" "cluster_1" {
  count          = 2
  route_table_id = aws_route_table.cluster_1.id
  subnet_id      = count.index % 2 == 0 ? aws_subnet.cluster_1[0].id : aws_subnet.cluster_1[1].id
}


resource "aws_route_table" "cluster_2" {
  provider = aws.eu-west-2
  vpc_id = aws_vpc.cluster_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_2.id
  }

  tags = {
    Name = "cluster_2"
  }
}

resource "aws_route_table_association" "cluster_2" {
  provider = aws.eu-west-2
  count          = 2
  route_table_id = aws_route_table.cluster_2.id
  subnet_id      = count.index % 2 == 0 ? aws_subnet.cluster_2[0].id : aws_subnet.cluster_2[1].id
}

#### Peering ####

# Requesters side of the connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.cluster_1.id # owner and requester
  peer_vpc_id = aws_vpc.cluster_2.id # acceptor 
  
  peer_region = "eu-west-2"
  peer_owner_id = data.aws_caller_identity.peer.account_id
  auto_accept   = false

  tags = {
    Name = "peer"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "Accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
  provider = aws.eu-west-2

  tags = {
    Side = "Accepter"
  }
}

# Add new route from cluster 1 to cluster 2 via the peer 
resource "aws_route" "cluster_1_to_cluster_2" {
  route_table_id              = aws_route_table.cluster_1.id
  destination_cidr_block = aws_vpc.cluster_2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Add new route from cluster 2 to cluster 1 via the peer 
resource "aws_route" "cluster_2_to_cluster_1" {
  route_table_id              = aws_route_table.cluster_2.id
  destination_cidr_block = aws_vpc.cluster_1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  provider = aws.eu-west-2
}