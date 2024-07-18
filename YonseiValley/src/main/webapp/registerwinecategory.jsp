<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert winecategory in database</title>
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
		
		String title = null;
		int standardPrice = 0;
		
		title = request.getParameter("title");
		standardPrice = Integer.parseInt(request.getParameter("standardPrice"));
		String required_red = request.getParameter("required_red");
		String required_white = request.getParameter("required_white");
		if(standardPrice <= 0 || title == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 값이 있습니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		
		String insert_value = "INSERT INTO winecategory(title, standardPrice) VALUES ('" + title + "', '" + standardPrice + "');";
		String find_wineryid = "SELECT wineryID FROM Winery;";
		String find_categoryID = "SELECT categoryID FROM winecategory WHERE title = '" + title + "';";
		String insert_recipe = "INSERT INTO winerecipe(title, red, white) VALUES ('" + title + "', '" + required_red + "', '" + required_white + "');";
		String insert_stock;
		int categoryID = 0;
		String wineryid = null;
		
		stmt.executeUpdate(insert_value);
		stmt.executeUpdate(insert_recipe);
		
		result = stmt.executeQuery(find_categoryID);
		while(result.next()){
			categoryID = result.getInt("categoryID");
		}
		
		result = stmt.executeQuery(find_wineryid);
		while(result.next()){
			wineryid = result.getString("WineryID");
			insert_stock = "INSERT INTO winestock(categoryID, amount, WineryID) VALUES ('" + categoryID + "', 0, '" + wineryid +"')";
			stmt.executeUpdate(insert_stock);
		}
	%>
	<div>
	<h1>데이터베이스에 전송 성공하였습니다.</h1>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
	</div>
	<%} catch (NumberFormatException e) {%>
		<h1>올바른 정보를 입력해주세요.</h1>
	<%}%>
</body>
</html>