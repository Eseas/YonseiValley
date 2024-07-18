<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result produce wine</title>
</head>
<body>
<%	
	int i = 0;
	
	String year = request.getParameter("year");
	String wineryid = request.getParameter("wineryid");
	List<String> winetitle = new ArrayList<String>();
	List<String> winestock = new ArrayList<String>();
	List<String> winecategoryid = new ArrayList<String>();
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
	String dbUser = "root";
	String dbPass = "a1234";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();	 

	String find_winery = "SELECT * FROM winery WHERE Wineryid = '" + wineryid + "';";
	String find_winestock = "SELECT * FROM winestock WHERE Wineryid = '" + wineryid + "' ORDER BY WineStockID ASC;";
	String find_winetitle = "SELECT * FROM winecategory;";
	
	String save_winestock;
	
	String minus_winery;
	
	int stock_red = 0;
	int stock_white = 0;
	
	int origin_red_wine = 0;
	int origin_white_wine = 0;
	int origin_blush_wine = 0;
	int origin_sparkling_wine = 0;
	int save_wine = 0;
	
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
	
	int lengthwinetitle = winetitle.size();
	
	//	red grape(1) -> red wine(1)
	
	result = stmt.executeQuery(find_winery);
	while(result.next()) {
		stock_red = result.getInt("stock_red");
		stock_white = result.getInt("stock_white");
	}
	
	int required_red = 0;
	int required_white = 0;
	int required_producered = 0;
	int required_producewhite = 0;
	int save_stock_red = 0;
	int save_stock_white = 0;
	int origin_wine_amount = 0;
	int result_produce_wine = 0;
	
		
	String find_winerecipe = null;
	
	String[] request_produce = request.getParameterValues("producewine");
	int request_length = request_produce.length;
	int[] produce_wine = new int[request_length];
	for(i = 0; i < request_length; i++) {
		produce_wine[i] = Integer.parseInt(request_produce[i]);
	}
	
	for(i = 0; i < lengthwinetitle; i++){
		if(produce_wine[i] > 0) {
				find_winerecipe = "SELECT * FROM winerecipe WHERE title = '" + winetitle.get(i) + "';";
				result = stmt.executeQuery(find_winerecipe);
				result.next();
				required_red = result.getInt("red");
				required_white = result.getInt("white");
				
				required_producered = produce_wine[i] * required_red;
				required_producewhite = produce_wine[i] * required_white;
				
				result = stmt.executeQuery(find_winery);
				while(result.next()){
					stock_red = result.getInt("stock_red");
					stock_white = result.getInt("stock_white");
				}
				if(stock_red > required_producered || stock_white > required_producewhite) {
					find_winestock = "SELECT * FROM winestock WHERE Wineryid = '" + wineryid + "' && categoryID = '" + winecategoryid.get(i) +"';";
					
					result = stmt.executeQuery(find_winestock);
					
					while(result.next()){
						origin_wine_amount = result.getInt("amount");
					}
					
					save_stock_red = stock_red - required_producered;
					save_stock_white = stock_white - required_producewhite;
					result_produce_wine = origin_wine_amount + produce_wine[i];
					
					String save_winery = "UPDATE Winery SET stock_red = '" + save_stock_red +"', stock_white = '" + save_stock_white + "' WHERE WineryID = '" + wineryid +"';";
					String save_stock = "UPDATE winestock SET amount = " + result_produce_wine + " WHERE WineryID = '" + wineryid + "' && categoryID = '" + winecategoryid.get(i) +"';";
					String save_wineproduction = "INSERT INTO wineproduction SET categoryID = " + winecategoryid.get(i) + ", year = '" + year + "', amount = " + produce_wine[i] + ", WineryID = '" + wineryid + "';";
					
					stmt.executeUpdate(save_winery);
					stmt.executeUpdate(save_stock);
					stmt.executeUpdate(save_wineproduction);
				}
				else
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('wine 생산에 필요한 grape가 부족합니다..')");
					script.println("history.back()");
					script.println("</script>");
				}
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