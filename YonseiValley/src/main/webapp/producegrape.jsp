<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Produce Grape</title>
</head>
<body>
	<form action="resultproducegrape.jsp">
	<div>
		<h1>포도 생산하기</h1>
	</div>
	<p>몇 년에 생산되었습니까? : <input type="text" id="year"><br></p>
	<%
	String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
	String dbUser = "root";
	String dbPass = "a1234";

	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	
	String VineyardID = request.getParameter("radio3");
	
	String find_field = "SELECT * FROM Field WHERE VineyardID = '" + VineyardID + "';";
	
	int maxproduce = 0;
	
	result = stmt.executeQuery(find_field);
	
	while(result.next()) {
		int area = result.getInt("area");
		maxproduce = maxproduce + area;
		int FieldID = result.getInt("FieldID");
		String Fieldname = result.getString("Fieldname");
	%>	
		<p><%= Fieldname%>의 최대 생산량은 <%= area %>입니다.</p>
		<p>얼마나 생산했습니까? : <input type="number" id="produce" max="<%=area%>" min="0"></p>
	<%} %>
	<div>
		<input type="submit" value="생산하기">
	</div>
	</form>
</body>
</html>