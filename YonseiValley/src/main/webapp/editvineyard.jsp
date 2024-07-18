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
		String find_Vineyard = "SELECT * FROM Vineyard WHERE VineyardID = '" + radio1choice + "';";
		
		result = stmt.executeQuery(find_Vineyard);
		
	%>
		<h1>농장 수정하기</h1>
		<form action="resulteditvineyard.jsp">
		<input type="text" name="radio2choice" value="<%= radio1choice %>" readonly>의 값을 수정합니다.
		
		<%
		result = stmt.executeQuery(find_Vineyard);
		while(result.next()) {%>
			<p>
				<label>농장 이름 : </label>
				<input type=text name="Vineyardname" value = "<%=result.getString("Vineyardname") %>">
			</p>
			
			<p>
				<label>농장 주인 : </label>
				<input type=text name="owner" value = "<%= result.getString("owner")%>">
			</p>
			
			<p>
				<label>연락처 : </label>
				<input type=text name="tel_number" value = "<%= result.getString("tel_number")%>">
			</p>
			
			<p>
				<label>Red Grape 재고 : </label>
				<input type=text name="stock_red" value = "<%= result.getString("stock_red")%>">
			</p>
			
			<p>
				<label>White Grape 재고 : </label>
				<input type=text name="stock_white" value = "<%= result.getString("stock_white")%>">
			</p>
			
			<p>
				<label>보유 자금 : </label>
				<input type=text name="money" value = "<%= result.getString("money")%>">
			</p>
		<%} %>
		<input type=submit value="수정하기">
		</form>
</body>
</html>