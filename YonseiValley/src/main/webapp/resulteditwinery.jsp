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
	<h1>�����Ǿ����ϴ� !</h1>
	<p>���۵� ������ ������ �����ϴ�.</p>
	<p>
		���� �̸� : <%= radio2choice %> <br>
		���� ����� �̸� : <%= wineryname%> <br>
		���� ����� ���� : <%= owner%> <br>
		����ó : <%= tel_number%> <br>
		red grape ���: <%= stock_red%> <br>
		white grape ��� : <%= stock_white%> <br>
		���� �ڱ� : <%= money%> <br>
		���� ����� ��� : <%= gradeID%> <br>
	</p>
	<form action=main.jsp>
		<input type=submit value="����ȭ��">
	</form>
</body>
</html>