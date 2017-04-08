# AWS How-to

### Prerequisite
In order to get the sample codes in this repository to work properly, it is assumed that you 
already have an AWS account and that the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
are configured.

### How to setup the AWS Credentials Environment Variable
1. Login to AWS Console at https://console.aws.amazon.com/console/home

2. Navigate to IAM

3. Under IAM Resources select Users

4. Select Add User. Select Programmatic Access and AWS Management Console Access. Leave console password as autogenerated and select the checkbox that require password to be reset at next sign-in

5. At this point, you may only have the administrator group. Assign the newly created account to this group.

6. Click Create User

7. Copy the ACCESS key ID and click the show link to show the Secret key access

8. Open you ~/.bashrc and create the following environment variables  

   export AWS_ACCESS_KEY_ID=<ACCESS KEY ID from Step 7>  
   export AWS_SECRET_ACCESS_KEY=<Secret Access Key from Step 7>  

9. Enable to newly created environment variables
   ```bash
   $ source ~/.bashrc
   ```

10. Verify that AWS Credentials are exported properly
   ```bash
   $ env | grep AWS
   ```
