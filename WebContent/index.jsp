<%@ page import="java.io.*,java.util.*,java.sql.*, argo.jdom.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>SELECT Cloudfoundry Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://us-cdbr-iron-east-03.cleardb.net/ad_fb6d9a69a978ff1"
     user="ba7d71d583f42e"  password="f3ed3870"/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from employee;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Name</th>
   <th>Salary<th>
  
</tr>
<%

String vcap_services = System.getenv("VCAP_SERVICES");

String vcap_application = System.getenv("VCAP_APPLICATION");

System.out.println("*********** "+ vcap_services);

System.out.println("*********** "+ vcap_application);

String hostip =  System.getenv("CF_INSTANCE_IP");

System.out.println("&&&&&&&&&&& Host "+ hostip);

Connection dbConnection = null;

if (vcap_services != null && vcap_services.length() > 0) {
    try {
        
    	 //Class.forName("com.mysql.jdbc.Driver");
        // dbConnection = DriverManager.getConnection("jdbc:mysql://173.194.249.121:3306/guestbook", "rajrana2", "rajrana2");
    	
    	
    	
    	// Use a JSON parser to get the info we need from  the
        // VCAP_SERVICES environment variable. This variable contains
        // credentials for all services bound to the application.
        // In this case, MySQL is the only bound service.
        JsonRootNode root = new JdomParser().parse(vcap_services);

        JsonNode mysqlNode = root.getNode("cleardb");
        System.out.println("*********** "+ mysqlNode);
        JsonNode credentials = mysqlNode.getNode(0).getNode("credentials");
        System.out.println("*********** Credentials: "+ credentials);
        // Grab login info for MySQL from the credentials node
        String jdbcUrl = credentials.getStringValue("jdbcUrl");
        System.out.println("*********** JdbcUrl: "+ jdbcUrl);
        String dbname = credentials.getStringValue("name");
        String hostname = credentials.getStringValue("hostname");
        System.out.println("*********** hostname: "+ hostname);
        String user = credentials.getStringValue("username");
        System.out.println("*********** username: "+ user);
        String password = credentials.getStringValue("password");
        System.out.println("*********** password: "+ password);
        String port = credentials.getStringValue("port");
        System.out.println("*********** port: "+ port);

        String dbUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;

        // Connect to MySQL
        out.println("Connecting to MySQL...");

        Class.forName("com.mysql.jdbc.Driver");
        dbConnection = DriverManager.getConnection(jdbcUrl, user, password);
        
       
        
    } catch (Exception e) {
        System.out.println("Caught error: ");
        e.printStackTrace();
    }
}

try {
    if (dbConnection != null && !dbConnection.isClosed()) {
        out.print("Connected to MySQL!");

        // creating a database table and populating some values
        Statement statement = dbConnection.createStatement();

        //ResultSet rs = statement.executeQuery("SELECT \"Hello World!\"");
        
        //out.print("Executed query \"SELECT \"Hello World!\"\".");
        ResultSet rs = statement.executeQuery("SELECT * from employee");
        out.print("Executed query \"SELECT * from employee\"\".");

        ResultSetMetaData rsmd = rs.getMetaData();
        int columnsNumber = rsmd.getColumnCount();

        while (rs.next()) {
            for (int i = 1; i <= columnsNumber; i++) {
                if (i > 1) System.out.print(",  ");
                String columnValue = rs.getString(i);

                // Since we are selecting a string literal, the column
                // value and column name are both the same. The values
                // could be retrieved with the line commented out below.
                //writer.println("Column value: " + columnValue + " column name " + rsmd.getColumnName(i));

                out.print("Result: " + columnValue);
            }
        }
	
        statement.close();
    } else {
        out.print("Failed to connect to MySQL");
    }
}
catch (Exception e) {
    out.print("Exception caught while executing DB queries.");
}
%>

<tr>
   <td>Connecting to Google mysql</td>
   <td> User Provided service example</td>
   
</tr>

</table>
 <%


 dbConnection = null;

if (vcap_services != null && vcap_services.length() > 0) {
    try {
        
    	 //Class.forName("com.mysql.jdbc.Driver");
        // dbConnection = DriverManager.getConnection("jdbc:mysql://173.194.249.121:3306/guestbook", "rajrana2", "rajrana2");
    	
    	
    	
    	// Use a JSON parser to get the info we need from  the
        // VCAP_SERVICES environment variable. This variable contains
        // credentials for all services bound to the application.
        // In this case, MySQL is the only bound service.
        JsonRootNode root = new JdomParser().parse(vcap_services);

        JsonNode userprovided = root.getNode("user-provided");
        System.out.println("*********** "+ userprovided);
        JsonNode credentials = userprovided.getNode(0).getNode("credentials");
        System.out.println("*********** Credentials: "+ credentials);
        // Grab login info for MySQL from the credentials node
        String jdbcUrl = credentials.getStringValue("url");
        System.out.println("*********** JdbcUrl: "+ jdbcUrl);
        String dbname = credentials.getStringValue("dbname");
        String hostname = credentials.getStringValue("host");
        System.out.println("*********** hostname: "+ hostname);
        String user = credentials.getStringValue("username");
        System.out.println("*********** username: "+ user);
        String password = credentials.getStringValue("password");
        System.out.println("*********** password: "+ password);
        String port = credentials.getStringValue("port");
        System.out.println("*********** port: "+ port);

        String dbUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;

        

        Class.forName("com.mysql.jdbc.Driver");
        dbConnection = DriverManager.getConnection(jdbcUrl, user, password);
        
     // Connect to MySQL
        out.println("Connecting to User Provided Google MySQL...");
        
    } catch (Exception e) {
        System.out.println("Caught error: ");
        e.printStackTrace();
    }
}

try {
    if (dbConnection != null && !dbConnection.isClosed()) {
        out.print("Connecting to User Provided Google MySQL...!");

        // creating a database table and populating some values
        Statement statement = dbConnection.createStatement();
        //ResultSet rs = statement.executeQuery("SELECT \"Google MySQL connected. Hello World!\"");
        ResultSet rs = statement.executeQuery("SELECT * from entries");
        out.print("Executed query \"SELECT \"Entries from Google MySql!\"\".");

        ResultSetMetaData rsmd = rs.getMetaData();
        int columnsNumber = rsmd.getColumnCount();

        while (rs.next()) {
            for (int i = 1; i <= columnsNumber; i++) {
                if (i > 1) System.out.print(",  ");
                String columnValue = rs.getString(i);

                // Since we are selecting a string literal, the column
                // value and column name are both the same. The values
                // could be retrieved with the line commented out below.
                //writer.println("Column value: " + columnValue + " column name " + rsmd.getColumnName(i));

                out.print("Result: " + columnValue);
            }
        }

        statement.close();
    } else {
        out.print("Failed to connect to MySQL");
    }
}
catch (Exception e) {
    out.print("Exception caught while executing DB queries.");
}
%>
 
</body>
</html>