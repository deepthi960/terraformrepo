##### Global Values #######################################################
project_name="demo"
region="us-east-1"
environment="develop"
eks_cluster_name="dev_eks_01"
eks_cluster_version="1.23"

##### VPC Values ###########################################################
vpc_cidr_block="10.0.0.0/16"
availability_zones=["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidr_blocks=["10.0.50.0/24", "10.0.55.0/24", "10.0.60.0/24"]
private_subnet_cidr_blocks=["10.0.0.0/24", "10.0.10.0/24", "10.0.20.0/24"]
db_subnet_cidr_blocks=["10.0.150.0/24", "10.0.151.0/24", "10.0.152.0/24"]
public_subnet_tag_name="dev_eks_01_public_subnet"
private_subnet_tag_name="dev_eks_01_private_subnet"
db_subnet_tag_name="dev_eks_01_db_subnet"
db_subnet_group_name="dev_eks_01_db_subnet_group"
public_rt_tag_name="dev_eks_01_public_rt"
##### Storage Configuration Values ############################################
acl_value="private"
s3-bucket-name="dev-eks-01"
efs_performance_mode="generalPurpose"
efs_throughput_mode="bursting"
efs_encrypted="false"
creation_token="dev_eks_01_efs"
##### EKS Values ##############################################################
endpoint_private_access="true"
endpoint_public_access="true"
eks_cluster_subnet_ids=""
private_subnet_ids=""
public_subnet_ids=""
disk_size="30"
cpu_instance_types=["m5.2xlarge"]
cpu_ami_type="AL2_x86_64"
cpu_min_size="1"
cpu_max_size="1"
cpu_desired_size="1"
general_instance_types=["t3.xlarge"]
general_ami_type="AL2_x86_64"
general_min_size="1"
general_max_size="1"
general_desired_size="1"
asterisk_instance_types=["t3.small"]
asterisk_ami_type="AL2_x86_64"
asterisk_desired_size="1"
asterisk_min_size="1"
asterisk_max_size="1"
release_version="1.21"
capacity_type="ON_DEMAND"  # ON_DEMAND, SPOT"
force_update_version=null
##### RDS Configuration Values ################################################
engine_type="postgres"
engine_version="14.2"
multi_az="true"
database_identifier="dev-eks-01-db"
database_username="postgres"
database_password="PostgreSQL$123"
instance_type="db.t3.micro"
storage_type="io1"
allocated_storage="100"
provisioned_iops="1000"
#enable_storage_autoscaling="true"
max_allocated_storage="110"
storage_encrypted="false"
public_access="false"
port_number="5432"
database_name="callcenter"
parameter_group_name="eks-cluster-pg-db"
backup_retention_period="15"
backup_window="04:00-04:30"
final_snapshot_identifier="dev-eks-01-db-postgresql-final-snapshot"
skip_final_snapshot="false"
copy_tags_to_snapshot="true"
performance_insights_enabled="true"
performance_insights_retention_period="7"
enabled_cloudwatch_logs_exports=["postgresql", "upgrade"]
monitoring_interval="60"
auto_minor_version_upgrade="true"
maintenance_window="sun:04:30-sun:05:30"
deletion_protection="true"
enable_db_security_group="1"