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
	try{
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String radio2choice = request.getParameter("radio2choice");
		String Vineyardname = request.getParameter("Vineyardname");
		String owner = request.getParameter("owner");
		String tel_number = request.getParameter("tel_number");
		String stock_red = request.getParameter("stock_red");
		String stock_white = request.getParameter("stock_white");
		String money = request.getParameter("money");
		
		String update_Vineyard_value = "UPDATE Vineyard SET Vineyardname = '" + Vineyardname + "', owner = '" + owner + "', tel_number = '"
				+ tel_number + "', stock_red = '" + stock_red + "', stock_white = '" + stock_white + "', money = '" + money +
				"' WHERE VineyardID = '" + radio2choice + "';";
				
		stmt.executeUpdate(update_Vineyard_value);
	%>
	<div>
	<h1>���</h1>
	<p>���۵� ������ ������ �����ϴ�.</p>
	<p>
		���� �̸� : <%= Vineyardname %> <br>
		���� ���� : <%= owner %> <br>
		����ó : <%= tel_number %> <br>
		red grape ��� : <%= stock_red %> <br>
		white grape ��� : <%= stock_white%> <br>
		���� �ڱ� : <%= money %> <br>
	</p>
	</div>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="��������">
	</div>
	<%} catch (NumberFormatException e) {%>
		<h1>�ùٸ� ������ �Է����ּ���.</h1>
	<%}%>
</body>
</html>