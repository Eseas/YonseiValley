<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit field</title>
</head>
<body>
	<form action="resulteditfield.jsp">
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String radio1choice = request.getParameter("radio1");
		String find_field = "SELECT * FROM Field WHERE FieldID = '" + radio1choice + "';";
		
		result = stmt.executeQuery(find_field);
		String fieldname = null;
		String location = null;
		String area = null;
		
		while(result.next()){
			fieldname = result.getString("Fieldname");
			location = result.getString("location");
			area = result.getString("area");
		}
		
	%>
		<h1>밭 수정하기</h1>
		<input type="text" name="radio1choice" value="<%= radio1choice %>" readonly>의 값을 수정합니다.
		
			<p>
				<label>밭 이름 : </label>
				<input type=text name="fieldname" value="<%=fieldname%>">
			</p>
			
			<p>
				<label>밭 위치 : </label>
				<input type=text name="location"value="<%=location%>">
			</p>
			
			<p>
				<label>밭 크기 : </label>
				<input type=number name="area"value="<%=area%>">
			</p>
			
			<p>
				<label>포도 종류 : </label>
				<input type=radio name="grape" value="red">red
				<input type=radio name="grape" value="white">white
			</p>
		<input type=submit value="수정하기">
		</form>
</body>
</html>