<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Field data in database</title>
</head>
<body>
	<%
	try{
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String fieldname = request.getParameter("fieldname");
		String location = request.getParameter("location");
		int area = Integer.parseInt(request.getParameter("area"));
		String Grape = request.getParameter("grape");
		
		String insert_value = "INSERT INTO field(Fieldname, location, area, variety) values('"
				+ fieldname + "', '" + location + "', '" + area + "', '" + Grape + "');";
		
		stmt.executeUpdate(insert_value);
	%>
	<div>
	<h1>���</h1>
	<p>���۵� ������ ������ �����ϴ�.</p>
	<p>
		�� �̸� : <%= fieldname %> <br>
		��ġ : <%=location %> <br>
		�� ũ�� : <%=area %> <br>
		����ϴ� ���� : 	<%=Grape %> <br>
	</p>
	<input type="button" Onclick="location.href='main.jsp'" value="��������">
	</div>
	<%} catch (NumberFormatException e) {%>
		<h1>�ùٸ� ������ �Է����ּ���.</h1>
	<%}%>
</body>
</html>