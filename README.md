# Same region and same account VPC Peering

# Work in progress

## Description


### Peering test

To check connenction I created an EC2 instance on each of the VPCs (public subnets) on first instance I put user data and opened port 22 & 80 on seciruty group:
```
#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo “hello world” > /var/www/html/index.html
sudo chown -R apache:apache /var/www/html
```

Both of them were created with local ssh-key so I could ssh into them, after I run command on first instance `curl localhost:80` and it gave me an output `"hello world"`. On the second EC2 instance after ssh ing into it I run command curl private IP of the first instance and port in my case it it looked like this `curl 10.0.2.131:80` and the output is the same `"hello world"`. That's how we know that our peering was successful.

## Resources
- Primary VPC
- Secondary VPC

# Helpful links