package DB;

import java.sql.*; 
import java.util.ArrayList;



public class MysqlQueries {

	private Statement myStatement;
	
	
	public MysqlQueries()
	{
		try {
			String dburl = "jdbc:mysql://localhost:3306/isproject";
			String uName = "root";
			String pswd = "khanaganda";
			Connection myConnection = DriverManager.getConnection(dburl,uName,pswd);
			myStatement = myConnection.createStatement();
		}catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	
	void insertFile(String fname, String type, String parent, String own)
	{
		
		try {
		ResultSet count = myStatement.executeQuery("select count(*) as cnt from files_dir");
		count.first();
		int id = Integer.parseInt(count.getString("cnt"));
		id++;
		String sql = "insert into files_dir values('"+id+"','"+fname+"','"+type+"','"+parent+"','"+own+"')";
		//System.out.println(id);
		myStatement.executeUpdate(sql);
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	public void insertUser(String uname, String groups[]) 
	{
		try {
			ResultSet count = myStatement.executeQuery("select count(*) as cnt from user");
			count.first();
			int id = Integer.parseInt(count.getString("cnt"));
			id++;
			String sql = "insert into user values('"+id+"','"+uname+"')";
			//System.out.println(id);
			myStatement.executeUpdate(sql);
			
			for(String str: groups)
			{
				sql = "insert into user_groups values('"+id+"','"+str+"')";
				myStatement.executeUpdate(sql);
			}
			
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	public void insertDac(String fid, String acc)
	{
		try {
			ResultSet myResult = myStatement.executeQuery("select * from dac where fid='"+fid+"'");
			String sql="";
			if(myResult.next())
				sql="update dac set rights='"+acc+"' where fid='"+fid+"'";
			else
			sql = "insert into dac values('"+fid+"','"+acc+"')";
			
			myStatement.executeUpdate(sql);
			
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	public String getDac(String fid)
	{
		try {
			ResultSet myResult = myStatement.executeQuery("select rights from dac where fid='"+fid+"'");
		
			if(myResult.next())
				return myResult.getString("rights");
			else
			return "000";
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			return "000";
		}
	}
	
	public String getOwn(String fid)
	{
		try {
			ResultSet myResult = myStatement.executeQuery("select own from files_dir where fid = '"+fid+"'");
		
			if(myResult.next())
				return myResult.getString("own");
			else
			return null;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			return null;
		}
	}
	
	public String[] getGroups(String uid)
	{
		try {
			String sql = "select gname from groups where gid in (select gid from user_groups where uid='"+uid+"')";
			ArrayList<String> list = new ArrayList<>();
			ResultSet myResult = myStatement.executeQuery(sql);
			
			while(myResult.next())
			{
				String gname = myResult.getString("gname");
				list.add(gname);
			}
			String[] groups = (String[])list.toArray();
			return groups;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return null;
	}
	
}









