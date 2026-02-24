# Architecture Documentation

## System Design

### Layer 1: Network Layer (VPC)

**Purpose**: Isolate resources and control traffic flow

- **VPC CIDR**: 10.0.0.0/16 (65,536 IP addresses)
- **Public Subnets**: 2 across AZs for ALB
- **Private Subnets**: 2 across AZs for application & database
- **NAT Gateway**: Enables outbound internet for private subnets
- **Route Tables**: Separate for public and private

**Benefits**:
- Network isolation and security
- Multi-AZ redundancy
- Automatic failover capability

### Layer 2: Load Balancing (ALB)

**Purpose**: Distribute traffic and health checking

- **Type**: Application Load Balancer (Layer 7)
- **Ports**: 80 (HTTP), 443 (HTTPS ready)
- **Health Checks**: Every 30 seconds
- **Connection Draining**: 300 seconds grace period

**Features**:
- Path-based routing capability
- Host-based routing support
- WebSocket support

### Layer 3: Compute (EC2 + ASG)

**Purpose**: Run application workloads with auto-scaling

- **Auto Scaling Group**:
  - Min size: 1
  - Max size: 5
  - Desired: 2 (configurable)
  - Scaling policies based on metrics

- **Instances**:
  - AMI: Amazon Linux 2 (latest)
  - Instance type: t3.micro (free tier eligible)
  - EBS: 20GB gp2
  - Monitoring: Enabled

- **Instance Profile**: IAM role for CloudWatch access

**Auto-Scaling Triggers**:
- CPU > 70% for 10 minutes → Scale up
- CPU < 30% for 10 minutes → Scale down

### Layer 4: Database (RDS)

**Purpose**: Managed relational database

- **Engine**: MySQL 8.0
- **Instance**: db.t3.micro
- **Storage**: 20GB gp2 (encrypted)
- **Deployment**: Multi-AZ (automatic failover)
- **Backups**: Daily, 7-day retention
- **Location**: Private subnets only

**Availability**:
- Synchronous replication to standby
- Automatic failover in < 2 minutes
- Read replicas available for scaling reads

### Layer 5: Monitoring & Alerting

**CloudWatch Metrics**:
- EC2 CPU Utilization
- RDS CPU Utilization
- RDS Connection Count
- RDS Storage Space

**Alarms**:
- High CPU (EC2/RDS)
- Low Storage (RDS)
- High Connection Count (RDS)

**Notifications**:
- SNS Topic → Email
- Customizable alert thresholds
- CloudWatch Dashboard

## Traffic Flow
