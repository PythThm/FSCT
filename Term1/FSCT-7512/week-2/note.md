Week 2 

AWS Region and Availability Zone
    - Seperate geographic area, isolated data ceters called availability, min 2 
    - All connected, physical centers and high speed and close by to eachother 

Each AZ have there own identity and specific name
    - It is important because we choose which AZ when creating resources in AWS 

All Regions are connected by the Private global network backbone, low latency somehow

The latency between AZ are very low

Special region in china
    - only companies in china can use that 

AWS special region in US gov
    - Degsined to host sensitive data
    - Top government customers

AWS secret and top secret
    - for FBI CIA
    - DoD data classifications

TCO ( Total cost of ownership )
    - how much will it cost you 
    - aws TCO calculator

Ways to manage AWS Resources
    - Web UI
    - CLI
    - SDK - software development kit / API

Services we need to know
    - Familiar with Adminstration services
    - Amazon workspaces (Remote call center)

Auto Scaling
    - Horizontal Scaling
    - Based on Utilizations
    - Done Automatically
    - To add more machine to match demand

Manual Scaling
    - Vertical
    - Need to stop
    - Can add more resources to it
    - Restart server

AWS Organisation    
    How attackers get in
        - Phishing emails
        - SIM swaps (Porting phone number and giving the SIM to the attacker)
            * Instagram is where people gets targetted
            * Your phone loses receiption
            * Call the customer service
            * Make sure you receive the SMS message
        - IAM access control
    
    AWS OR - Organization Root - Master account
    AWS OU - Organization Units - sub-units
    AWS Accounts - single personal accounts with restricted access

    && EXAMPLE TIME &&
    - Accountant
    - Freaky Email telling we are switching banks
    - Tells deposit money into another account
    - A year goes by
    - Management be like weird no payment for a year
    - Shit was spoofed
    - LMAO

    IAM - Identity and Access management
    - Assign users with access
    - Manage who is authenticated and authorized
    - like s3 bucket access level, only read or write access, or you can do anything with the bucket
    - its a JSON code
    - Create users or group or Roles
        > Users: Individuals or services that interact with AWS resources, with unique security credentials and permissions
        > Groups: Collection of IAM users
        > Roles: Delegate permission to users, application or service without sharing long-term credentials, temporary
    
    By review the permission, we know who have access to what resource, logs contains important information ot us during a forensics investigation (also something you can set up like what time someone can login)

    When creating AWS account, you start with root user, then create an IAM user to be more secure (access control)


How to access AWS 
    1. MFA
    2. API (Does not expire)
    3. STS (Security Token Service) - Temporary, limited privilage credentials
    4. IAM Roles assigned to AWS resources - Common target for abuse

Cloudtrail Logs 
    - it will log when where how many times, what happened 
    - with or without mfa console output

Most popular Services
    1. EC2 - Elastic Compute cloud
        - Virtual Servers
        - Different types of server for different usage
        - All kinds of OS
        - Free tier or not free
        - Letter contributes to their Purposes

    2. EBS - Elastic Block Store
        - Different types of storage
        - Cost performance ratio
        - Under the Volume tab
    
    3. EC2 Security Groups
        - Each outlines what rules to connect to a machine
        - The ports, traffic to where or from where
    
    4. EC2 Auto Scaling
        - Horizontal Scaling
        - Auto detects usage and scales off it
        > Load Balancing
            - Traffic redirection
    
    5. VPC - Virtual Private Cloud
        - An area inside your private infrastructure in aws when you create an instance
        - Like a virtual network
        - Can create other resource from within
        - You can create another VPC to create Remote instances
        - Secure environment
        - VPC flow logs
            > We FI have access to it
            > Everything means something
        
    6. S3 - Simple Storage Service
        - Scalable
        - 99% durable, always available
        - Secure as long as you define it (proper setup)
        - Types of storages for different pricing options
        - Integrate with other AWS services
        - Common use case
            > Backups and Restore
            > Data Analytics
            > Content Storage and Distribution
            > Disaster Recovery
    
    7. Cloud Trail
        - Log events to your resources
        - Access, flow logs, system activities
        - Event records
        - Can be monitored and alarms can be triggered 

