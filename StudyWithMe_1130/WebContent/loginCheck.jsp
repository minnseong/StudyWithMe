<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

	
<%

	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Statement stmt = null;
	ResultSet rs = null;	
	Connection conn =null;
	
    String dbPW = ""; // db에서 꺼낸 비밀번호를 담을 변수
    int id_exist = -1;
    int x = -1;
    
    // id or pw가 입력되지 않을경우
    if(id == null || id.equals("") || pw == null || pw.equals(""))
    {
%> 
		<script>
		alert("invaild user info.")
		window.location.replace("loginForm.jsp");
		</script>
<%
    }
    
   	try {
   	Class.forName("com.mysql.jdbc.Driver");
   	} catch (ClassNotFoundException e) {
   		System.err.print("ClassNotFoundException :");
   	}

   	
   	
   	try{
   		
   		String jdbcurl= "jdbc:mysql://localhost:3306/sampledb?serverTimezone=UTC";
   		conn = DriverManager.getConnection(jdbcurl , "root","0814");
   		String query= "select * from user_info where id = ?";
   		//stmt = conn.createStatement();
   		PreparedStatement ps = conn.prepareStatement(query);
   		ps.setString(1, id);
		rs=ps.executeQuery();

		
		
			if(rs.next()) // 입려된 아이디에 해당하는 비번 있을경우
	        {
	            dbPW = rs.getString("pw"); // 비번을 변수에 넣는다.
	            if (dbPW.equals(pw)) 
	            {
	            	session.setAttribute("sessionID" , id);
	            	response.sendRedirect("mainPage.jsp");
	            }
	            
	            else                  
	            {%> 
	            	<script>
	            	alert("Password invalid")
	            	window.location.replace("loginForm.jsp");
	            	</script>
	            	<%
	       			//response.sendRedirect("loginForm.jsp");	    	       			
	            }
	        }
			else
			{%>
				<script>
				alert("ID invalid")
            	window.location.replace("loginForm.jsp");
				</script>
				<%
				//response.sendRedirect("loginForm.jsp");
			}
		
	} catch(SQLException e) {
		System.out.println("DB 연결 에러");
	} catch(Exception e) {%>
		<script>
		alert("ID invalid");
    	window.location.replace("loginForm.jsp");
    	</script><%
	} finally {
		if (conn != null) { conn.close(); }
	}
	
%>