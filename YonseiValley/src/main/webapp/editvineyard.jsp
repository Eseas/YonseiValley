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
		<h1>���� �����ϱ�</h1>
		<form action="resulteditvineyard.jsp">
		<input type="text" name="radio2choice" value="<%= radio1choice %>" readonly>�� ���� �����մϴ�.
		
		<%
		result = stmt.executeQuery(find_Vineyard);
		while(result.next()) {%>
			<p>
				<label>���� �̸� : </label>
				<input type=text name="Vineyardname" value = "<%=result.getString("Vineyardname") %>">
			</p>
			
			<p>
				<label>���� ���� : </label>
				<input type=text name="owner" value = "<%= result.getString("owner")%>">
			</p>
			
			<p>
				<label>����ó : </label>
				<input type=text name="tel_number" value = "<%= result.getString("tel_number")%>">
			</p>
			
			<p>
				<label>Red Grape ��� : </label>
				<input type=text name="stock_red" value = "<%= result.getString("stock_red")%>">
			</p>
			
			<p>
				<label>White Grape ��� : </label>
				<input type=text name="stock_white" value = "<%= result.getString("stock_white")%>">
			</p>
			
			<p>
				<label>���� �ڱ� : </label>
				<input type=text name="money" value = "<%= result.getString("money")%>">
			</p>
		<%} %>
		<input type=submit value="�����ϱ�">
		</form>
</body>
</html>