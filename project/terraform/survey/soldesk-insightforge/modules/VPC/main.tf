# region 지정
provider "aws" {
  region = "ap-northeast-2"
}

# VPC 생성
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.250.0.0/16"
  tags = {
    Name = "vec-prd-vpc"
  }
}

# 가용영역 2a의 서브넷 지정
resource "aws_subnet" "terraform-BASTION-PUB-2A" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.4.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "VEC-PRD-VPC-BASTION-PUB-2A"
  }
}

resource "aws_subnet" "terraform-NGINX-PUB-2A" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "VEC-PRD-VPC-NGINX-PUB-2A"
  }
}

resource "aws_subnet" "terraform-TOMCAT-PRI-2A" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.2.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "VEC-PRD-VPC-TOMCAT-PRI-2A"
  }
}

resource "aws_subnet" "terraform-DB-PRI-2A" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.3.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "VEC-PRD-VPC-DB-PRI-2A"
  }
}

# 가용영역 2c의 서브넷 지정
resource "aws_subnet" "terraform-NGINX-PUB-2C" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.11.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "VEC-PRD-VPC-NGINX-PUB-2C"
  }
}

resource "aws_subnet" "terraform-TOMCAT-PRI-2C" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.12.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "VEC-PRD-VPC-TOMCAT-PRI-2C"
  }
}

resource "aws_subnet" "terraform-DB-PRI-2C" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.250.13.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "VEC-PRD-VPC-DB-PRI-2C"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "VEC-PRD-IGW"
  }
}

# 퍼블릭 라우트 테이블 생성 및 인터넷 게이트웨이 연결
resource "aws_route_table" "terraform-public-rt" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "VEC-PRD-RT-PUB"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.terraform-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform-igw.id
}

# 퍼블릭 서브넷을 퍼블릭 라우트 테이블에 연결
resource "aws_route_table_association" "pub-rt-assoc-BASTION-2A" {
  subnet_id      = aws_subnet.terraform-BASTION-PUB-2A.id
  route_table_id = aws_route_table.terraform-public-rt.id
}

resource "aws_route_table_association" "pub-rt-assoc-NGINX-2A" {
  subnet_id      = aws_subnet.terraform-NGINX-PUB-2A.id
  route_table_id = aws_route_table.terraform-public-rt.id
}

resource "aws_route_table_association" "pub-rt-assoc-NGINX-2C" {
  subnet_id      = aws_subnet.terraform-NGINX-PUB-2C.id
  route_table_id = aws_route_table.terraform-public-rt.id
}

# NAT 게이트웨이 생성
resource "aws_eip" "terraform-nat-eip" {
  vpc = true
  tags = {
    Name = "VEC-PRD-NAT-EIP-2A"
  }
}

resource "aws_nat_gateway" "terraform-nat-gw" {
  allocation_id = aws_eip.terraform-nat-eip.id
  subnet_id     = aws_subnet.terraform-NGINX-PUB-2A.id
  tags = {
    Name = "VEC-PRD-NGW-2A"
  }
}

# 프라이빗 라우트 테이블 생성 및 NAT 게이트웨이 연결
resource "aws_route_table" "terraform-private-rt" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "VEC-PRD-RT-PRI"
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.terraform-private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.terraform-nat-gw.id
}

# 프라이빗 서브넷을 프라이빗 라우트 테이블에 연결
resource "aws_route_table_association" "pri-rt-assoc-TOMCAT-2A" {
  subnet_id      = aws_subnet.terraform-TOMCAT-PRI-2A.id
  route_table_id = aws_route_table.terraform-private-rt.id
}

resource "aws_route_table_association" "pri-rt-assoc-DB-2A" {
  subnet_id      = aws_subnet.terraform-DB-PRI-2A.id
  route_table_id = aws_route_table.terraform-private-rt.id
}

resource "aws_route_table_association" "pri-rt-assoc-TOMCAT-2C" {
  subnet_id      = aws_subnet.terraform-TOMCAT-PRI-2C.id
  route_table_id = aws_route_table.terraform-private-rt.id
}

resource "aws_route_table_association" "pri-rt-assoc-DB-2C" {
  subnet_id      = aws_subnet.terraform-DB-PRI-2C.id
  route_table_id = aws_route_table.terraform-private-rt.id
}

# 보안 그룹 생성
resource "aws_security_group" "terraform-sg-bastion" {
  vpc_id = aws_vpc.terraform-vpc.id
  name   = "VEC-PRD-VPC-Bastion-PUB-SG-2A"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VEC-PRD-VPC-Bastion-PUB-SG-2A"
  }
}

resource "aws_security_group" "terraform-sg-nginx" {
  vpc_id = aws_vpc.terraform-vpc.id
  name   = "VEC-PRD-VPC-NGINX-PUB-SG-2A"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VEC-PRD-VPC-NGINX-PUB-SG-2A"
  }
}

resource "aws_security_group" "terraform-sg-tomcat" {
  vpc_id = aws_vpc.terraform-vpc.id
  name   = "VEC-PRD-VPC-TOMCAT-PRI-SG-2A"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VEC-PRD-VPC-TOMCAT-PRI-SG-2A"
  }
}

resource "aws_security_group" "terraform-sg-db" {
  vpc_id = aws_vpc.terraform-vpc.id
  name   = "VEC-PRD-VPC-DB-PRI-SG-2A"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VEC-PRD-VPC-DB-PRI-SG-2A"
  }
}
