package dev.josborn.model.dao;

import java.util.List;

import dev.josborn.model.Tool;

public interface ToolDao {
	public List<Tool> findTool(String toolName);
	public boolean haveTool(String toolName);
	
	public void addTool(Tool tool);
	
	public void removeTool(Tool tool);
	
}
