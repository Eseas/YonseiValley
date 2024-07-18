<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result produce wine</title>
</head>
<body>
<%	
	String year = null;
	String winery_grade = request.getParameter("gradeid");
	float ratio = 0.1f;
	int i;
	List<String> winetitle = new ArrayList<String>();
	List<String> winestock = new ArrayList<String>();
	List<String> winecategoryid = new ArrayList<String>();
	
	year = request.getParameter("year");
	String wineryid = request.getParameter("wineryid");
	String gradeid = request.getParameter("gradeid");
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
	String dbUser = "root";
	String dbPass = "a1234";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();	
		
	if(year == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못 입력된 항목이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	String find_winery = "SELECT * FROM winery WHERE Wineryid = '" + wineryid + "';";
	
	String find_StandardPrice = null;
	String find_winerecipe = null;
	String find_ratio = null;
	String find_origin_wine = null;
	String save_winery = null;
	String save_stock = null;
	String save_winetrade = null;
	
	
	int origin_money = 0;
	int origin_wine = 0;
	int result_trade = 0;
	int result_money = 0;
	int StandardPrice = 0;
	int Price_wine;
	int[] trade_wine1 = null;
	
	
	String find_winecategoryid = "SELECT * FROM winecategory;";
	String find_winetitle = "SELECT * FROM winecategory;";
	
	int lengthwinetitle = winetitle.size();
	
	//winestock 찾음 Winetitle을 찾아야함
	result = stmt.executeQuery(find_winetitle);
		
	while(result.next()){
		winetitle.add(result.getString("title"));
	}
	result = stmt.executeQuery(find_winecategoryid);
	while(result.next()) {
		winecategoryid.add(result.getString("categoryID"));
	}
	
	String[] request_trade = request.getParameterValues("tradewine");
	
	int request_length = request_trade.length;
	trade_wine1 = new int[request_length];
	
	for(i = 0; i<request_length; i++) {
		trade_wine1[i] = Integer.parseInt(request_trade[i]);
	}
	
	
	for(i = 0; i < request_length; i++){
		find_origin_wine = "SELECT amount FROM winestock WHERE categoryID = " + winecategoryid.get(i) + " && WineryID = " + wineryid +";";
		result = stmt.executeQuery(find_origin_wine);
		while(result.next()) {
			origin_wine = result.getInt("amount");
		}
		if(origin_wine > trade_wine1[i]) {
			find_StandardPrice = "SELECT standardPrice FROM winecategory WHERE title = '" + winetitle.get(i) + "';";
			find_ratio = "SELECT ratio FROM winegrade WHERE title = '" + winery_grade + "';";
			
			result = stmt.executeQuery(find_ratio);
			while(result.next()) {
				ratio = result.getFloat("ratio");
			}
			result = stmt.executeQuery(find_StandardPrice);
			while(result.next()) {
				StandardPrice = result.getInt("standardPrice");
			}
			Price_wine = (int) (ratio * StandardPrice);
			
			result = stmt.executeQuery(find_winery);
			while(result.next()) {
				origin_money = result.getInt("money");
			}
			
			result_money = origin_money + (trade_wine1[i] * Price_wine);
			result_trade = origin_wine - trade_wine1[i];
		
			save_winery = "UPDATE winery SET money = " + result_money + " WHERE WineryID = '" + wineryid + "';";
			save_stock = "UPDATE winestock SET amount = " + result_trade + " WHERE WineryID = " + wineryid + " && categoryID = " + winecategoryid.get(i) + ";";
			save_winetrade = "INSERT INTO winetrade(categoryID, year, amount, WineryID) VALUES(" + winecategoryid.get(i) + ", '" + year + "', " + trade_wine1[i] +", '" + wineryid + "');";
			
			stmt.executeUpdate(save_winery);
			stmt.executeUpdate(save_stock);
			stmt.executeUpdate(save_winetrade);
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못 입력된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
%>
	
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
</body>
</html>