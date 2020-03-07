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
	
	
	void insertFile(String fname, String type, String parent, String own, String lvl_from, String lvl_to, String[] dids)
	{
		
		try {
		ResultSet count = myStatement.executeQuery("select count(*) as cnt from files_dir");
		count.first();
		int id = Integer.parseInt(count.getString("cnt"));
		id++;
		String sql = "insert into files_dir values('"+id+"','"+fname+"','"+type+"','"+parent+"','"+own+"','"+lvl_from+"','"+lvl_to+"')";
		myStatement.executeUpdate(sql);
		
		for(String did : dids)
		{
			sql = "insert into file_domains values('"+id+"'"+did+"')";
			myStatement.executeUpdate(sql);
		}
		
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	public void insertUser(String uname, String lvl_from, String lvl_to, String[] dids ,String groups[]) 
	{
		try {
			ResultSet count = myStatement.executeQuery("select count(*) as cnt from user");
			count.first();
			int id = Integer.parseInt(count.getString("cnt"));
			id++;
			String sql = "insert into user values('"+id+"','"+uname+"','"+lvl_from+"','"+lvl_to+"')";
			myStatement.executeUpdate(sql);

			for(String did : dids)
			{
				sql = "insert into user_domains values('"+id+"'"+did+"')";
				myStatement.executeUpdate(sql);
			}
			
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
	
	public String getParent(String fid)
	{
		try {
			ResultSet myResult = myStatement.executeQuery("select parent from files_dir where fid = '"+fid+"'");
		
			if(myResult.next())
				return myResult.getString("parent");
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
			String sql = "select gid from user_groups where uid='"+uid+"'";
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
	
	public int[] getUserLvl(String uid)
	{
		try {
			String sql = "select lvl_from, lvl_to from user where uid='"+uid+"'";
			ResultSet myResult = myStatement.executeQuery(sql);
			int[] lvl = new int[2];
			
			myResult.first();
				lvl[0]= Integer.parseInt(myResult.getString("lvl_from"));
				lvl[1]= Integer.parseInt(myResult.getString("lvl_to"));
			return lvl;
		}
		catch(Exception e)
		{
			System.out.println(e);
			return null;
		}
		
	}

	public int[] getFileLvl(String fid)
	{
		try {
			String sql = "select lvl_from, lvl_to from files_dir where fid='"+fid+"'";
			ResultSet myResult = myStatement.executeQuery(sql);
			int[] lvl = new int[2];
			
			myResult.first();
				lvl[0]= Integer.parseInt(myResult.getString("lvl_from"));
				lvl[1]= Integer.parseInt(myResult.getString("lvl_to"));
			return lvl;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			return null;
		}
		
	}
	
	public String[] getUserDomain(String uid)
	{
		try {
			String sql = "select did from user_domains where uid='"+uid+"'";
			ResultSet myResult = myStatement.executeQuery(sql);
			ArrayList<String> list = new ArrayList<String>();
			while(myResult.next())
			{
				list.add(myResult.getString("did"));
			}
			String[] val = (String[]) list.toArray();
			return val;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		return null;
	}

	public String[] getFileDomain(String fid)
	{
		try {
			String sql = "select did from file_domains where fid='"+fid+"'";
			ResultSet myResult = myStatement.executeQuery(sql);
			ArrayList<String> list = new ArrayList<String>();
			while(myResult.next())
			{
				list.add(myResult.getString("did"));
			}
			String[] val = (String[]) list.toArray();
			return val;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		return null;
	}
	
}









