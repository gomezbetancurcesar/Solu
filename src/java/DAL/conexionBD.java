package DAL;

import java.sql.*;
import static java.lang.System.out;
import javax.naming.Context;
import javax.naming.InitialContext;

public class conexionBD {
  
    public static Connection Conectar(String database)throws Exception
    {
        Connection con = null;
        try
        {           
           Context env = (Context)new InitialContext().lookup("java:comp/env");
//           String user = (String)env.lookup("user");
//           String pass = (String)env.lookup("pass");
           String user = "root";
           String pass = "123456";
           String driverClassName = "com.mysql.jdbc.Driver";
           String driverUrl = "jdbc:mysql://127.0.0.1/"+database;
           Class.forName(driverClassName);
           con = DriverManager.getConnection(driverUrl, user, pass);
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
        }
        return con;
    }
}
