<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit wine production data in database</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String winecategory = request.getParameter("winecategory");
		String year = request.getParameter("year");
		String amount = request.getParameter("amount");
		String wineproduceid = request.getParameter("wineproduceid");
		
		
		String insert_value = "UPDATE wineproduction SET categoryID = " + winecategory + ", year = '" + year + "', amount = " + amount + " WHERE WPID = " + wineproduceid + ";";
	
		stmt.executeUpdate(insert_value);
	%>
	<h1>수정 성공 !</h1>
	<p>카테고리 id : <%=winecategory %></p>
	<p>년도 : <%=year %></p>
	<p>판매량 : <%=amount%></p>
	<p>wineproduce id : <%=wineproduceid%></p>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
</body>