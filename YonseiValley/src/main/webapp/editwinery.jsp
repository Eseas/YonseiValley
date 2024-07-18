<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
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
		
		String radio2choice = request.getParameter("radio2");
		String find_Vineyard = "SELECT * FROM Winery WHERE WineryID = '" + radio2choice + "';";
		
		result = stmt.executeQuery(find_Vineyard);
		 
	%>
		<h1>농장 수정하기</h1>
		<form action="resulteditwinery.jsp">
		<input type="text" name="radio2choice" value="<%= radio2choice %>" readonly>의 값을 수정합니다.
		
		<% while(result.next()) { %>
			<p>
				<label>와인 생산소 이름 : </label>
				<input type=text name="wineryname" value = "<%=result.getString("Wineryname") %>">
			</p>
			
			<p>
				<label>와인 생산소 주인 : </label>
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
			<p>
				<label>와인 생산소 등급 : </label>
				<select name="gradeID">
					<option value="1st">1st</option>
					<option value="2nd">2nd</option>
					<option value="3rd">3rd</option>
				</select>
			</p>
			<%} %>
		<input type=submit value="수정하기">
		</form>
</body>
</html>