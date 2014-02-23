package com.infox.test;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.infox.junit.BaseJunitCase;
import com.infox.sysmgr.service.BaseDataBackServiceI;

public class TestDB extends BaseJunitCase {
	
	@Autowired
	private BaseDataBackServiceI j ;
	
	@Test
	public void testDB() throws SQLException {
		
		List<Map<String, String>> listTables = j.listTables("infos");
		
		for (Map<String, String> map : listTables) {
			System.out.println(map);
		}
		
	}
	
	
	
}
