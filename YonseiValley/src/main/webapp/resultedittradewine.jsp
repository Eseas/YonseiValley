<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit wine trade data in database</title>
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
		String winetradeid = request.getParameter("winetradeid");
		
		
		String insert_value = "UPDATE winetrade SET categoryID = " + winecategory + ", year = '" + year + "', amount = " + amount + " WHERE WTID = " + winetradeid + ";";
	
		stmt.executeUpdate(insert_value);
	%>
	<h1>���� ���� !</h1>
	<p>ī�װ� id : <%=winecategory %></p>
	<p>�⵵ : <%=year %></p>
	<p>�Ǹŷ� : <%=amount%></p>
	<p>wt id : <%=winetradeid%></p>
	<input type="button" Onclick="location.href='main.jsp'" value="��������">
</body>
</html>