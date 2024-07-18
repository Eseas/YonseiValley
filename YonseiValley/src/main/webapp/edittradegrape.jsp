<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit trade grape</title>
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
		
		String grapeproduceid = request.getParameter("radio4");
		String categoryid = null;
		String year = null;
		String amount = null;
		
		String find_grapeproduce = "SELECT * FROM grapeproduce WHERE GPID = '" + grapeproduceid + "';";
		
		result = stmt.executeQuery(find_grapeproduce);
		while(result.next()){
			year = result.getString("year");
			amount = result.getString("amount");
		}
	%>
		<h1>와인 판매 내역 수정</h1>
		<div>
		<form action="resultedittradegrape.jsp">
		<input type="hidden" id="grapeproduceid" name ="grapeproduceid" value="<%=grapeproduceid %>">
			<p>년도 : <input type="number" id="year" name="year" value="<%=year%>"></p>
			<p>수확량 : <input type="number" id="amount" name="amount" value="<%=amount%>"></p>
			
		<input type="submit" value="수정하기">
		</form>
		</div>
</body>
</html>