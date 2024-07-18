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
	<h1>결과</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		농장 이름 : <%= Vineyardname %> <br>
		농장 주인 : <%= owner %> <br>
		연락처 : <%= tel_number %> <br>
		red grape 재고 : <%= stock_red %> <br>
		white grape 재고 : <%= stock_white%> <br>
		보유 자금 : <%= money %> <br>
	</p>
	</div>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
	<%} catch (NumberFormatException e) {%>
		<h1>올바른 정보를 입력해주세요.</h1>
	<%}%>
</body>
</html>