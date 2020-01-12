package dev.josborn.model.dao.jdbc;

import java.util.List;

import dev.josborn.model.Tool;
import dev.josborn.model.dao.ToolDao;

public class JdbcToolDao implements ToolDao{

	@Override
	public List<Tool> findTool(String toolName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean haveTool(String toolName) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void addTool(Tool tool) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeTool(Tool tool) {
		// TODO Auto-generated method stub
		
	}

}
