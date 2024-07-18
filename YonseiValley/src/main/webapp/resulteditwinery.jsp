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
		
		String radio2choice = request.getParameter("radio2choice");
		String wineryname = request.getParameter("wineryname");
		String owner = request.getParameter("owner");
		String tel_number = request.getParameter("tel_number");
		String stock_red = request.getParameter("stock_red");
		String stock_white = request.getParameter("stock_white");
		String money = request.getParameter("money");
		String gradeID = request.getParameter("gradeID");
		
		
		String update_winery_value = "UPDATE Winery SET Wineryname = '" + wineryname + "', owner = '" + owner + "', tel_number = '" + tel_number +
								"', stock_red = '" + stock_red + "', stock_white = '" + stock_white + "', money = '" + money + "', grade_ID = '" + gradeID + "' WHERE WineryID = " + radio2choice + ";";
								
		stmt.executeUpdate(update_winery_value);
	%>
	<h1>수정되었습니다 !</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		원래 이름 : <%= radio2choice %> <br>
		와인 생산소 이름 : <%= wineryname%> <br>
		와인 생산소 주인 : <%= owner%> <br>
		연락처 : <%= tel_number%> <br>
		red grape 재고: <%= stock_red%> <br>
		white grape 재고 : <%= stock_white%> <br>
		보유 자금 : <%= money%> <br>
		와인 생산소 등급 : <%= gradeID%> <br>
	</p>
	<form action=main.jsp>
		<input type=submit value="메인화면">
	</form>
</body>
</html>