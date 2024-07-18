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
	<h1>결과</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		밭 이름 : <%= fieldname %> <br>
		위치 : <%=location %> <br>
		밭 크기 : <%=area %> <br>
		재배하는 종류 : 	<%=Grape %> <br>
	</p>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
	<%} catch (NumberFormatException e) {%>
		<h1>올바른 정보를 입력해주세요.</h1>
	<%}%>
</body>
</html>