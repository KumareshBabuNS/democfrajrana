# MySQL Java 

This is a simple JSP-based Java webapp. 

Purpose of this application is to demonstrate creation and binding of service and user provided service. 


1) First step is to create the MySql instance with the service name 'mysql' (same is used in code)in your cloud foundry login. 

  cf create-service cleardb spark mysql
  
  You would see the sql service instance created in management console (run.pivotal.io)
  
2)Second step is to create user provided service. That is access the mysql database outside the Cloud Foundry. To demonstrate this we will be connecting and 
access MySQL database instance already created on Google cloud ( url:jdbc:mysql://173.194.249.121:3306/guestbook  username:rajrana2 and password: rajrana2)

cf cups gmysqldb -p "host,port,dbname,username,password,url"

host> 173.194.249.121

port> 3306

dbname> guestbook

username> rajrana2

password> rajrana2

url> jdbc:mysql://173.194.249.121:3306/guestbook  


   You would get the confirmation message and see the service instance created in Services section
   
3)Now that service instances are created you can bind your application to this services in two ways

    a)Remove service info/section from manifest.yml 
    Deploy the application: cf push democloudfoundry -p   target/DemoCloudFoundry-1.0.war
    
    cf bind-service democloudfoundry gmysqldb
    
    and
    
    cf bind-service democloudfoundry mysql
    
    
    Since the manifest has entries of the services the services will get bound
    
    Using CLI  cf bind-service appname  gmysqldb
    
    OR
    
    b)Since service info/section is present in manifest.yml the application would get bound to service when application is deployed.
    
    cf push democloudfoundry -p   target/DemoCloudFoundry-1.0.war
    
4)Now access the application from the url through the link in Route section     

5)The application would give error or connect since the tables access by application are not present now.

6) You can connect to mysql database existing on CloudFoundry using SQL Workbench from your desktop using credentials/info in enviroment variable in Enviroment section in management console for the application deployed.

7) When connecting to Mysql on run.pivotal.io you need to shutdown you application since no of connection provided for free mysql db are limited. The Employee.sql is provided.   

    
    
  