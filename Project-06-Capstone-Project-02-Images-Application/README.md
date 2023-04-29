# Project-06 : Image Add Application With Description (PHP) deployed on AWS Application Load Balancer with Auto Scaling, S3, Relational Database Service(RDS), VPC's Components, Elastic File System(EFS) and Cloudfront with Route 53

## Description

The Image Insertion Application With Description aims to deploy  as a web application written PHP on AWS Cloud Infrastructure. This infrastructure has Application Load Balancer with Auto Scaling Group of Elastic Compute Cloud (EC2) Instances and Relational Database Service (RDS) on defined VPC. Also, The Cloudfront and Route 53 services are located in front of the architecture and manage the traffic in secure. Data is stored in EFS. User is able to upload pictures, add description to this pictures on own page and this pictures are kept on S3 Bucket.  

## Problem Statement

![Project_06](images/AWS-Capstone-2.jpg)

- Your company has recently ended up a project that aims to serve as Image Insertion Application with description on isolated VPC environment. You and your colleagues have started to work on the project. Your Developer team has developed the application and you are going to deploy the app in production environment.

- Application is coded by Fullstack development team and given you as DevOps team. App allows users to write their image information data should be kept in separate MySQL database in AWS RDS service and pictures should be kept in S3 bucket.  

- The web application will be deployed using PHP.

- The Web Application should be accessible via web browser from anywhere in secure.

- You are requested to push your program to the project repository on the Github. You are going to pull it into the webservers in the production environment on AWS Cloud. 

In the architecture, you can configure your infrastructure using the followings,

  - The application stack should be created with new AWS resources.

  - Specifications of VPC:

    - VPC has two AZs and every AZ has 1 public and 1 private subnets.

    - VPC has Internet Gateway

    - One of public subnets has NAT Instance.

    - You might create new instance as Bastion host on Public subnet or you can use NAT instance as Bastion host.

    - There should be managed private and public route tables.

    - Route tables should be arranged regarding of routing policies and subnet associations based on public and private subnets.

  - You should create Application Load Balancer with Auto Scaling Group of Amazon Linux 2 EC2 Instances within created VPC.

  - You should create RDS instance within one of private subnets on created VPC and configure it on application.

  - The Auto Scaling Group should use a Launch Template in order to launch instances needed and should be configured to;

    - use all Availability Zones on created VPC.

    - set desired capacity of instances to  ` 2`

    - set minimum size of instances to  ` 2`

    - set maximum size of instances to  ` 4`

    - set health check grace period to  ` 90 seconds`

    - set health check type to  ` ELB`

    - Scaling Policy --> Target Tracking Policy

      - Average CPU utilization (set Target Value ` %70`)

      - seconds warm up before including in metric ---> `200`

      - Set notification to your email address for launch, terminate, fail to launch, fail to terminate instance situations

  - ALB configuration;
    
    - Application Load Balancer should be placed within a security group which allows HTTP (80) and HTTPS (443) connections from anywhere. 
    
    - Certification should be created for secure connection (HTTPS) 
      - To create certificate, AWS Certificate Manager can be utilized.

    - ALB redirects to traffic from HTTP to HTTPS

    - Target Group
      - Health Check Protocol is going to be HTTP

  - The Launch Template should be configured to;

    - Prepare PHP environment on EC2 instance based on Developer Notes,

    - Download the "cloud-my-projects/capstone-project-blog-page" folder from Github repository,

    - Deploy the PHP application on port 80.

    - Launch Template only allows HTTP (80) and HTTPS (443) ports coming from ALB Security Group and SSH (22) connections from anywhere.

    - EC2 Instances type can be configured as `t2.micro`.

    - Instance launched should be tagged `AWS Capstone Project-02`

    - Since Django App needs to talk with S3, S3 full access role must be attached EC2s. 

  - For RDS Database Instance;
  
    - Instance type can be configured as `db.t2.micro`

    - Database engine can be `MySQL` with version of `8.0.32`.

    - RDS endpoint should be addressed within settings file of application that is explained developer notes.

    - Please read carefully "Developer notes" to manage RDS sub settings.

  - Cloudfront should be set as a cache server which points to Application Load Balance with following configurations;

    - The cloudfront distribution should communicate with ALB securely.

    - Origin Protocol policy can be selected as `HTTPS only`.

    - Viewer Protocol Policy can be selected as `Redirect HTTP to HTTPS`

  - As cache behavior;

    - GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE methods should be allowed.

    - Forward Cookies must be selected All.

    - Newly created ACM Certificate should be used for securing connections. (You can use same certificate with ALB)

  - Route 53 

    - Connection must be secure (HTTPS). 

    - Your hostname can be used to publish website.

    - Failover routing policy should be set while publishing application
      
      - Primary connection is going to be Cloudformation

      - Secondary connection is going to be a static website placed another S3 bucket. This S3 bucket has just basic static website that has a picture said "the page is under construction" given files within S3_static_Website folder

      - Healthcheck should check If Cloudfront is healthy or not. 

  - As S3 Bucket

    - First S3 Bucket

      - It should be created within the Region that you created VPC

      - Since development team doesn't prefer to expose traffic between S3 and EC2s on internet, Endpoint should be set on created VPC. 

      - S3 Bucket name should be addressed within configuration file of blog application that is explained developer notes.
    
    - Second S3 Bucket 
      
      - This Bucket is going to be used for failover scenario. It has just a basic static website that has a picture said "the page is under construction"

  - To write the objects of S3 on DynamoDB table
    
    - Lambda Function 

      - Lambda function is going to be Node.js 12.x

      - Node.js Function can be found in github repo

      - S3 event is set as trigger

      - `S3 Event` must be created first S3 Bucket to trigger Lambda function

## Project Skeleton 

```text
blog_page_project (folder)
|
|----Readme.md               # Given (Definition of the project)
|----src (folder)            # Given (PHP Application's )
|----ImageResize.zip      # Given (python file)
|----developer_notes.txt     # Given (txt file)
```

## Expected Outcome

![Phonebook App Search Page](images/cloud-project3.jpg)

### At the end of the project, following topics are to be covered;

- Bash scripting

- AWS EC2 Launch Config

- AWS VPC Configuration
  - VPC
  - Private and Public Subnets
  - Private and Public Route Tables
  - Managing routes
  - Subnet Associations
  - Internet Gateway
  - NAT Gateway
  - Bastion Host
  - Endpoint

- AWS EC2 Application Load Balancer Configuration

- AWS EC2 ALB Target Group Configuration

- AWS EC2 ALB Listener Configuration

- AWS EC2 Auto Scaling Group Configuration

- AWS Relational Database Service Configuration

- AWS EC2, RDS, ALB Security Groups Configuration

- IAM Roles configuration

- S3 configuration

- Static website configuration on S3

- Lambda Function configuration

- Get Certificate with AWS Certification Manager Configuration

- AWS Cloudfront Configuration

- Route 53 Configuration

- Git & Github for Version Control System

### At the end of the project, you will be able to;

- Construct VPC environment with whole components like public and private subnets, route tables and managing their routes, internet Gateway, NAT Instance. 

- Configure connection to the `MySQL` database.

- Demonstrate bash scripting skills using `user data` section within launch template to install and setup web application on EC2 Instance.

- Create a Lambda function using S3.

- Demonstrate their configuration skills of AWS VPC, EC2 Launch Config, Application Load Balancer, ALB Target Group, ALB Listener, Auto Scaling Group, S3, RDS, Cloudfront, Route 53.

- Apply git commands (push, pull, commit, add etc.) and Github as Version Control System.

## Steps to Solution
  
- Step 1: Create dedicated VPC and whole components

- Step 2: Create Security Groups (ALB ---> EC2 ---> RDS ---> EFS)

- Step 3: Create three S3 Buckets and set one of these as static website.

- Step 4: Create IAM Role.

- Step 5: Create Lambda-Function 

- Step 6: Create NAT Instance in Public Subnet

- Step 7: Create EC2 to be used as template

- Step 8: Connect to the NAT instance and download PHP and apache

- Step 9: Create EFS

- Step 10: Connect to Template-EC2 and mount EFS

- Step 11: Create RDS

- Step 12: Connect to Template-EC2 and login mysql, create table

- Step 13: Update add.php and view.php files

- Step 14: Connect to Template-EC2 upload edited add.php and view.php files to EC2

- Step 15: Create AMI from Template EC2

- Step 16: Create Target Group and Application Load Balancer

- Step 17: Create Launch Configurations and Auto Scaling groups

- Step 18: Create AWS Certificate Manager (ACM) for Cloudfront

- Step 19: Create Cloudfront in front of ALB

- Step 20: Create Route 53 with Failover settings

## Notes

- RDS database should be located in private subnet. just EC2 machines that has ALB security group can talk with RDS.

- RDS is located on private groups and only EC2s can talk with it on port 3306

- ALB is located public subnet and it redirects traffic from http to https

- EC2's are located in private subnets and only ALB can talk with them

## Contact

- Please contact me to access the project files.
    * yasinkaya.devops@gmail.com