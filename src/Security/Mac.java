package Security;

import java.util.ArrayList;

import DB.MysqlQueries;

public class Mac {
	
	private MysqlQueries sql;
	
	Mac()
	{
		sql = new MysqlQueries();
	}
	
	boolean isSubset(ArrayList<String> userDom, ArrayList<String> fileDom)
	{
		int length=0;
		
		for(String fdom: fileDom)
		{
			for(String udom: userDom)
			{
				if(udom.compareTo(fdom)==0)
				{
					length++;
					break;
				}
			}
		}
		if(length== fileDom.size())
		return true;
		
		return false;
	}
	
	int level_comparision(int[] userLvl, int[] fileLvl)
	{
		if(userLvl[1]<fileLvl[0])
			return 4;
		else if(userLvl[0]>fileLvl[1])
			return 2;
		else 
			return 7;
	}
	
	
	public boolean checkPermission(String uid, String fid, int permission)
	{
		if(fid.compareTo("0")==0)
			return true;
		if(checkMac(uid,fid,permission))
		return true;
	
		return false;
	}
	
	
	public boolean checkMac(String uid, String fid, int permission)
	{
		int[] userLvl = sql.getUserLvl(uid);
		int[] fileLvl = sql.getFileLvl(fid);
		ArrayList<String> userDom = sql.getUserDomain(uid);
		ArrayList<String> fileDom = sql.getFileDomain(fid);
		if(isSubset(userDom,fileDom))
		{
			int rgt = level_comparision(userLvl,fileLvl);
			if((rgt&permission) == permission)
				return true;
		}
		return false;
	}

}
