<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		
		String radio1choice = request.getParameter("radio1choice");
		String fieldname = request.getParameter("fieldname");
		String location = request.getParameter("location");
		String area = request.getParameter("area");
		String Grape = request.getParameter("grape");
		
		String update_field_value = "UPDATE Field SET fieldname = '" + fieldname + "', location = '" + location + "', area = '" + area +
								"', variety = '" + Grape + "' WHERE FieldID = '" + radio1choice + "';";
								
		stmt.executeUpdate(update_field_value);
	%>
	<h1>수정되었습니다 !</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		원래 이름 : <%= radio1choice %> <br>
		밭 이름 : <%= fieldname %> <br>
		위치 : <%=location %> <br>
		밭 크기 : <%=area %> <br>
		재배하는 종류 : 	<%=Grape %> <br>
	</p>
	<form action=main.jsp>
		<input type=submit value="메인화면">
	</form>
</body>
</html>