<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Vineyard data in database</title>
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
		int stock_red = 0;
		int stock_white = 0;
		int money = 0;
		String VineyardID = null;
		String wineryid = null;
		String Wineryname = request.getParameter("Wineryname");
		String owner = request.getParameter("owner");
		String telnumber = request.getParameter("tel_number");
		stock_red = Integer.parseInt(request.getParameter("stock_red"));
		stock_white = Integer.parseInt(request.getParameter("stock_white"));
		money = Integer.parseInt(request.getParameter("money"));
		String grade = request.getParameter("grade");
		String vineyardid = request.getParameter("VineyardID1");
		
		if (Wineryname == null || owner == null || telnumber == null || stock_red < 1 || stock_white < 1 || money < 1 || grade == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String find_wineryid = "SELECT WineryID FROM Winery WHERE Wineryname = '" + Wineryname + "';";
		
		String insert_value_winery = "INSERT INTO Winery(Wineryname, owner, tel_number, stock_red, stock_white, money, grade_ID) VALUES ('"
				+ Wineryname + "', '" + owner + "', '" + telnumber + "', '" + stock_red + "', '" + stock_white + "', '" + money + "', '"
				+ grade + "');";
				
		String insert_value_VineyardID = null;
				
		VineyardID = request.getParameter("VineyardID1");
		if(VineyardID == "0"){
			insert_value_winery = "INSERT INTO Winery(Wineryname, owner, tel_number, stock_red, stock_white, money, grade_ID, VineyardID) VALUES ('"
					+ Wineryname + "', '" + owner + "', '" + telnumber + "', '" + stock_red + "', '" + stock_white + "', '" + money + "', '"
					+ grade + "', '" + VineyardID + "');";
		}
		stmt.executeUpdate(insert_value_winery);
		
		result = stmt.executeQuery(find_wineryid);
		
		while(result.next()) {
			wineryid = result.getString("WineryID");
		}
		String create_red_winestock = "INSERT INTO winestock(categoryID, amount, WineryID) VALUES (1, 0, " + wineryid +");";
		String create_white_winestock = "INSERT INTO winestock(categoryID, amount, WineryID) VALUES (2, 0, " + wineryid +");";
		String create_blush_winestock = "INSERT INTO winestock(categoryID, amount, WineryID) VALUES (3, 0, " + wineryid +");";
		String create_sparkling_winestock = "INSERT INTO winestock(categoryID, amount, WineryID) VALUES (4, 0, " + wineryid +");";

		stmt.executeUpdate(create_red_winestock);
		stmt.executeUpdate(create_white_winestock);
		stmt.executeUpdate(create_blush_winestock);
		stmt.executeUpdate(create_sparkling_winestock);
	%>
	<div>
	<h1>결과</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		와인 생산소 이름 : <%= Wineryname %> <br>
		소유주 : <%=owner %> <br>
		연락처 : <%=telnumber %> <br>
		red grape 재고 : 	<%=stock_red %> <br>
		white grape 재고 : <%= stock_white%> <br>
		보유 자금 : <%=money %> <br>
	</p>
	</div>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
</body>
</html>