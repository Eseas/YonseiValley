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
		<h1>���� �����ϱ�</h1>
	</div>
	<p>�� �⿡ ����Ǿ����ϱ�? : <input type="text" id="year"><br></p>
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
		<p><%= Fieldname%>�� �ִ� ���귮�� <%= area %>�Դϴ�.</p>
		<p>�󸶳� �����߽��ϱ�? : <input type="number" id="produce" max="<%=area%>" min="0"></p>
	<%} %>
	<div>
		<input type="submit" value="�����ϱ�">
	</div>
	</form>
</body>
</html>