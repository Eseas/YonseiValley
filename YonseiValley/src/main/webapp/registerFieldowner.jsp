<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>register Field owner in database</title>
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
		
		String update_query = "";
		
		String Vineyardid = request.getParameter("VineyardID1");
		String fieldid = request.getParameter("fieldID");	
		
		String buy = request.getParameter("buy");
		int money = 0;
		int required_money = 0;
		int save_money = 0;
		String area = null;
		String buy_field = null;
		
		String find_Vineyard = "SELECT * FROM Vineyard WHERE VineyardID = '" + Vineyardid + "';";
		result = stmt.executeQuery(find_Vineyard);
		while(result.next()){
			money = result.getInt("money");
		}
		String update_value = "UPDATE Field SET VineyardID = '" + Vineyardid + "' WHERE FieldID = '" + fieldid + "';";
		
		String find_field = "SELECT * FROM Field WHERE FieldID = " + fieldid + ";";
			
			result = stmt.executeQuery(find_field);
			while(result.next()) {
				area = result.getString("area");
			}
			required_money = Integer.parseInt(area) * 10;
			save_money = money - required_money;
			
			if(save_money < 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('돈이 부족합니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
			buy_field = "UPDATE Vineyard SET money = " + save_money + " WHERE VineyardID = '" + Vineyardid + "';";
			
			stmt.executeUpdate(buy_field);
			}
		stmt.executeUpdate(update_value);
		%>
			<h1>성공</h1>
			<p> 성공적으로 데이터베이스에 등록하였습니다.</p>
			<p class="Lead">
				수행한 SQL Statement :
				<%=update_value %><br>
				<%= buy_field%>
				<%
			System.out.println("Success");
		
				%>
			<div>
				<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
			</div>
</body>
</html>