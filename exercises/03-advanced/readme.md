<!--Exercise 03 — -->
Set Up an AWS Application Load Balancer

<!--# Exercise 03 — Set Up an AWS Application Load Balancer-->

 In this exercise, you will create an **Application Load Balancer (ALB)** in AWS and use it to distribute HTTP traffic to a small group of EC2 instances.

 You will work with a load balancer, target group, listener, and EC2 instances. By the end, you should be able to access your application through the ALB instead of connecting directly to an individual server.

 ## Objectives

 By the end of this exercise, you should be able to:

- create an Application Load Balancer
- create and configure a target group
- register EC2 instances as targets
- configure an HTTP listener
- configure security groups for the load balancer and instances
- verify that the ALB routes requests to healthy targets
- understand basic ALB health checks

 ## Estimated time

 `45–60 minutes`

 ## Before you start

 You should already understand:

- basic AWS concepts
- EC2 instances
- VPCs, subnets, and security groups
- HTTP basics
- how to connect to an EC2 instance

 Read:

 - [AWS Application Load Balancer documentation](<https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html>)
- [AWS security groups documentation](<https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html>)

 You will need:

- an AWS account
- access to the AWS Management Console
- permission to create EC2 and Elastic Load Balancing resources
- a VPC with at least **two subnets in different Availability Zones**
- two running EC2 instances

 > **Cost note:** AWS resources created during this exercise may incur charges. Delete the resources when you are finished. [Reade here for more infomation on the costs](https://aws.amazon.com/elasticloadbalancing/pricing/)

 ## Task

 Starting from two running EC2 instances with a simple HTTP application:

 1. Make sure both EC2 instances can serve HTTP traffic on port `80`.
2. Create a security group for the Application Load Balancer.
3. Configure the ALB security group to allow inbound HTTP traffic on port `80` from the internet.
4. Create a security group for the EC2 instances.
5. Configure the EC2 security group to allow HTTP traffic on port `80` **only from the ALB security group**.
6. Create a target group:
   - Target type: `Instances`
   - Protocol: `HTTP`
   - Port: `80`
   - Health check protocol: `HTTP`
   - Health check path: `/`
7. Register both EC2 instances as targets.
8. Create an **Application Load Balancer**:
   - Scheme: `Internet-facing`
   - IP address type: `IPv4`
   - Select at least two Availability Zones
   - Select the ALB security group you created earlier
9. Create an HTTP listener:
   - Protocol: `HTTP`
   - Port: `80`
   - Default action: forward traffic to your target group
10. Wait for the target health checks to complete.
11. Verify that both EC2 instances appear as **healthy** targets.
12. Copy the DNS name of the ALB and open it in your browser.
13. Confirm that your application is returned through the load balancer.
14. Stop one EC2 instance and refresh the ALB URL several times.
15. Observe what happens when one target becomes unhealthy.

 Don't look at the solution until you've tried it yourself.

 ## 💡 Hint 1

 The ALB should be the public entry point to your application.

 <details> 
 <summary>Show hint</summary> 
 Users should connect to the ALB, not directly to the EC2 instances.

 The traffic flow should look like:

```
Internet
   |
   v
Application Load Balancer
   |
   +--------> EC2 Instance 1
   |
   +--------> EC2 Instance 2
```

 </details> 
 
 ## 💡 Hint 2

 Your EC2 instances should not need to accept HTTP traffic from everywhere.

 <details> 
 <summary>Show hint</summary> 
 Instead of allowing:

```
0.0.0.0/0 → TCP 80
```

 on the EC2 security group, allow HTTP traffic from the **ALB security group**.

 This means:

```
Internet → ALB → EC2
```

 rather than:

```
Internet → EC2
```

 </details> 
 
 ## 💡 Hint 3

 A target can be registered but still be unusable.

 <details> 
 <summary>Show hint</summary> 
 Check the target group's **Health status**.

 If a target is unhealthy, verify:

 - the application is running
- the application is listening on port `80`
- the health check path `/` exists
- the EC2 security group allows traffic from the ALB security group
- the instance is in a reachable subnet

 </details> 
 
 ## Challenge

 Once the basic setup works, try the following:

 - Change the response on each EC2 instance so you can identify which server handled the request.
- Refresh the ALB URL repeatedly and observe which instances receive requests.
- Stop one instance and verify that the ALB continues serving traffic.
- Start the instance again and wait for it to become healthy.
- Investigate how long it takes for the ALB to detect an unhealthy target.

 For example, your two servers could return:

```
Hello from Server 1
```

 and:

```
Hello from Server 2
```

 This makes it easier to observe load balancing.

 ## Verify your solution

 You should be able to answer **yes** to all of the following:

 - [ ] The ALB has been created successfully.
- [ ] The ALB has an HTTP listener on port `80`.
- [ ] The target group contains both EC2 instances.
- [ ] Both targets become healthy.
- [ ] The ALB DNS name loads the application.
- [ ] Traffic reaches the EC2 instances through the ALB.
- [ ] The EC2 instances do not need to allow HTTP traffic from the entire internet.
- [ ] The application remains available when one healthy target is stopped.
- [ ] The stopped instance is eventually reported as unhealthy.
- [ ] The stopped instance is reported as healthy again and started serving.

 ## Clean up

 When you are finished, remove the AWS resources you created for this exercise to avoid unnecessary charges. The sandbox will take care of the cleaning but it is good to develop the habit as part of the exercises.

 At minimum, make sure to remove:

 - the Application Load Balancer
- the target group
- EC2 instances created specifically for this exercise
- unused security groups
- other resources created specifically for the exercise

 <!--## 🏁 Done?

 Once your ALB successfully routes traffic to healthy EC2 instances:

 ➡️ Continue to **Exercise 04**-->