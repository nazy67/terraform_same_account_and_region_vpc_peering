# Provider region
aws_region        = "us-east-1"
# VPC
primary_vpc_cidr_block    = "10.0.0.0/16"
secondary_vpc_cidr_block  = "10.1.0.0/16"

instance_tenancy  = "default"
is_enabled_dns_support = true
is_enabled_dns_hostnames = true
rt_cidr_block  = "0.0.0.0/0"

# Subnet primary
first_subnet_azs         = ["us-east-1a", "us-east-1b","us-east-1c"  ]
first_pub_cidr_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
first_priv_cidr_subnet = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

# Subnet secondary
second_subnet_azs         = ["us-east-1a", "us-east-1b","us-east-1c"  ]
second_pub_cidr_subnet  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24" ]
second_priv_cidr_subnet = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]

# Tags
env               = "dev"