<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head> 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %> 
<%@ page import="java.sql.*" %> 
<% 
	request.setCharacterEncoding("euc-kr"); 
	String realFolder = ""; 
	String filename2 = ""; 
	int maxSize = 1024*1024*5; 
	String encType = "euc-kr"; 
	String savefile = "profit"; 
	ServletContext scontext = getServletContext(); 
	realFolder = scontext.getRealPath(savefile); 
 
	try{ 
		MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy()); 
		Enumeration<?> files = multi.getFileNames(); 
		String file2 = (String)files.nextElement(); 
		filename2 = multi.getFilesystemName(file2); 
		} catch(Exception e) { 
			e.printStackTrace(); 
	} 
 
	String fullpath = realFolder + "\\" + filename2; 
%> 
<title>Insert title here</title> 
</head> 
<body> 
<img src="<%=fullpath%>" width=200 height=200></img> 
<br>�����ʻ���

</body> 
</html> 