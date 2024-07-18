<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result trade grape</title>
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
		
		String wineryname = request.getParameter("wineryname");
		int trade_red = Integer.parseInt(request.getParameter("trade_red"));
		int trade_white = Integer.parseInt(request.getParameter("trade_white"));
		
		if(trade_red < 0 || trade_white < 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못 입력된 곳이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String wineryid = "";
		String vineyardid = "";
		int winery_red = 0;
		int winery_white = 0;
		int vineyard_red = 0;
		int vineyard_white = 0;
		int winery_money = 0;
		int vineyard_money = 0;
		String year = request.getParameter("year");
		
		int savewineryred = 0;
		int savewinerywhite = 0;
		int savewinerymoney = 0;

		int savevineyardred = 0;
		int savevineyardwhite = 0;
		int savevineyardmoney = 0;
		
		String find_winery = "SELECT * FROM Winery WHERE Wineryname = '" + wineryname + "';";
		String record_trade_red = "";
		String record_trade_white = "";
		
		result = stmt.executeQuery(find_winery);
		
		while (result.next()){
			wineryid = result.getString("WineryID");
			vineyardid = result.getString("VineyardID");
			winery_money = result.getInt("money");
			winery_red = result.getInt("stock_red");
			winery_white = result.getInt("stock_white");
			savewineryred = winery_red + trade_red;
			savewinerywhite = winery_white + trade_white;
			savewinerymoney = winery_money - (trade_red + trade_white);
		}
		String find_vineyard = "SELECT * FROM Vineyard WHERE VineyardID = '" + vineyardid + "';";
		
		result = stmt.executeQuery(find_vineyard);
		
		while(result.next()){
			vineyard_red = result.getInt("stock_red");
			vineyard_white = result.getInt("stock_white");
			vineyard_money = result.getInt("money");
			savevineyardred = vineyard_red - trade_red;
			savevineyardwhite = vineyard_white - trade_white;
			savewinerymoney = winery_money + (trade_red + trade_white);
		}
		
		record_trade_red = "INSERT INTO grapetrade (year, variety, amount, VineyardID, WineryID)"
					+ "VALUES ("+ year + ", 'red', " + trade_red + ", '" + vineyardid + "', '" + wineryid + "')";
		record_trade_white = "INSERT INTO grapetrade (year, variety, amount, VineyardID, WineryID)"
					+ "VALUES (" + year + ", 'white', " + trade_white + ", '" + vineyardid + "', '" + wineryid + "')";
		
		String plus_winery = "UPDATE Winery SET stock_red = '" + savewineryred + "', stock_white = '" + savewinerywhite + "', money ='"+ savewinerymoney + "' WHERE WineryID = '" + wineryid + "';";
		String minus_vineyard = "UPDATE Vineyard SET stock_red = '" + savevineyardred + "', stock_white = '" + savevineyardwhite + "', money ='"+ savevineyardmoney +"' WHERE VineyardID = '" + vineyardid + "';";
		
		stmt.executeUpdate(record_trade_red);
		stmt.executeUpdate(record_trade_white);
		stmt.executeUpdate(plus_winery);
		stmt.executeUpdate(minus_vineyard);
	%>
	<h1>거래가 성사됐습니다.</h1>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
</body>
</html>