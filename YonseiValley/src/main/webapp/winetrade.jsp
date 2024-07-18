<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Grape Trade</title>
</head>
<body>
	<%
	/*
		1.winery 가겨오기 (winery_find)
		2.winery의 stock을 가지고 온다. (stock_find)
		3.stock에서 categoryID를 찾아왔으니 categoryID로 winetitle을 가지고 온다.
		
	*/
	
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String wineryID = request.getParameter("radio4");
		String wineryname = null;
		int money = 0;
		
		int i = 0;
		
		String find_wineryname = "SELECT Wineryname, grade_ID FROM Winery WHERE WineryID = '" + wineryID + "';";
		String find_winestock = "SELECT categoryID, amount FROM winestock WHERE WineryID = '" + wineryID + "';";
		String find_winetitle = "SELECT * FROM winecategory;";
		int stock_red = 0;
		int stock_white = 0;
		int stock_blush = 0;
		int stock_sparkling = 0;
		
		int category_amount = 0;
		String winegrade = null;
		
		List<String> winetitle = new ArrayList<String>();
		List<String> winestock = new ArrayList<String>();
		List<String> winecategoryid = new ArrayList<String>();
		
		//작업 시작 1.
		result = stmt.executeQuery(find_wineryname);
	
		while(result.next()) {
			winegrade = result.getString("grade_ID");
			wineryname = result.getString("Wineryname");
		}
		// wineryname 찾았음 winestock을 찾기 시작
		
		result = stmt.executeQuery(find_winestock);
		
		while(result.next()) {
			winecategoryid.add(result.getString("categoryID"));
			winestock.add(result.getString("amount"));
		}
		
		//winestock 찾음 Winetitle을 찾아야함
		result = stmt.executeQuery(find_winetitle);
		
		while(result.next()){
			winetitle.add(result.getString("title"));
		}
	%>	
	
		<h1>와인 판매</h1>
		<form action="resulttradewine.jsp">
		<input type="hidden" value="<%=wineryID %>" name="wineryid">
		<input type="hidden" value="<%=winegrade %>" name="gradeid">
		<div>
		<label>이 <%=wineryID %>와인 생산소 재고 상황 :</label> <br>
	<%
		int lengthwinetitle = winetitle.size();
		for(i = 0; i < lengthwinetitle; i++){ %>
			<label><%=winetitle.get(i) %> : <%=winestock.get(i) %></label>
	<%	}
	%>	
		<br><br><label>현재는 몇 년입니까? : <input type="text" name="year"></label> <br> <br>
		
		<label>얼마나 판매하시겠습니까? : </label>
		
		<div>
	<%
		for(i = 0; i < lengthwinetitle; i++) { %>
			<label> <%=winetitle.get(i) %> : <input type="number" name="tradewine"></label> <br><br>
	<%	}
	%>
		</div>
		</div>
		<input type="submit" value="구매하기">
		</form>
</body>
</html>