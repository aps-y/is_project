package Test;


import java.sql.*; 


public class mysqlTest {

	public static void main(String args[])
	{
		try {
			String dburl = "jdbc:mysql://localhost:3306/isproject";
			String uName = "root";
			String pswd = "khanaganda";
			Connection myConnection = DriverManager.getConnection(dburl,uName,pswd);
			Statement myStatement = myConnection.createStatement();
			ResultSet myResult = myStatement.executeQuery("Select * from test");
			
			while(myResult.next()) {
				System.out.println("Student full name : "+ myResult.getString("name")+" "+myResult.getString("age"));
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
}
