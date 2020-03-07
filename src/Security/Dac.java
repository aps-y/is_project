package Security;

import DB.MysqlQueries;

public class Dac {

	private MysqlQueries sql;
	
	Dac()
	{
		sql = new MysqlQueries();
	}
	
	public boolean checkDac(String uid, String fid, int permission)
	{
		
		String rights = sql.getDac(fid);
		String[] groups = sql.getGroups(uid);
		String own = sql.getOwn(fid);
		String[] groupOwn = sql.getGroups(own);
		int rgt=0;
		if(uid.compareTo(own)==0)
		{
			String oct = rights.substring(0,1);
			rgt = Integer.parseInt(oct);
			if((rgt&permission) > 0)
				return true;
			else 
				return false;
		}
		
		for(String ug : groups)
		{
			for(String og: groupOwn)
			{
				if(ug.compareTo(og)==0)
				{
					String oct = rights.substring(1,2);
					rgt = Integer.parseInt(oct);
					if((rgt&permission) > 0)
						return true;
					else 
						return false;
				}
			}
		}
		
		String oct = rights.substring(2,3);
		rgt = Integer.parseInt(oct);
		if((rgt&permission) > 0)
			return true;
		else 
			return false;
	}
	
	
	public boolean insertDac(String uid,String fid, String permission)
	{
	
		String own = sql.getOwn(fid);
		if(uid.compareTo(own)==0)
		{
			sql.insertDac(fid, permission);
			return true;
		}
		
		return false;
	}
	
}
