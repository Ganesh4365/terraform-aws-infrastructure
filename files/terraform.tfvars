# Example values - Copy to terraform.tfvars and customize

aws_region         = "us-east-1"
project_name       = "myapp"
environment        = "dev"
vpc_cidr            = "10.0.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
enable_nat_gateway  = true
enable_vpn_gateway  = false
instance_type       = "t3.micro"
desired_capacity    = 2
min_size            = 1
max_size            = 5
db_instance_class   = "db.t3.micro"
allocated_storage   = 20
db_name             = "appdb"
db_username         = "admin"
db_password         = "ChangeMe123!@#"
alert_email         = "your-email@example.com"