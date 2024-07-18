<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit trade wine</title>
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

		String WineryID = request.getParameter("radio1");
		String query1 = "SELECT * FROM Winery WHERE WineryID = '" + WineryID + "';";
		String query2 = "SELECT * FROM WineStock WHERE WineryID = '" + WineryID + "';";
		String query3 = "SELECT * FROM Wineproduction WHERE WineryID = '" + WineryID + "';";
		String query4 = "SELECT * FROM Winetrade WHERE WineryID = '" + WineryID + "';";
		
		String wineproduceid = request.getParameter("radio4");
		String categoryid = null;
		String year = null;
		String amount = null;
		
		String find_wineproduction = "SELECT * FROM wineproduction WHERE WPID = '" + wineproduceid + "';";
		
		result = stmt.executeQuery(find_wineproduction);
		while(result.next()){
			categoryid = result.getString("categoryID");
			year = result.getString("year");
			amount = result.getString("amount");
		}
	%>
		<h1>와인 생산 내역 수정</h1>
		<div>
		<form action="resulteditproducewine.jsp">
		<input type="hidden" id="wineproduceid" name ="wineproduceid" value="<%=wineproduceid %>">
			<p>와인 종류 :
			<select id="winecategory" name="winecategory">
	<%			String find_winecategory = "SELECT * FROM winecategory;";
				result = stmt.executeQuery(find_winecategory);
				while(result.next()){
		%>			<option value="<%=result.getString("categoryID")%>"><%=result.getString("title")%></option> 
				<%}
	%>		</select>
			<p>년도 : <input type="number" id="year" name="year" value="<%=year%>">
			<p>판매량 : <input type="number" id="amount" name="amount" value="<%=amount%>">
			
		<input type="submit" value="수정하기">
		</form>
		</div>
</body>
</html>