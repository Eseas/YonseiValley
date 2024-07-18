<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Information</title>
</head>
<body>
	<%	//-------------------------------------------------
		//	작업 선택
		//------------------------------------------------- %>
	<label>무엇을 하려고 합니까? : </label>
	<select id="show" class="show" name="show">
	<option>Insert Field</option>
	<option>Insert Vineyard</option>
	<option>Insert Winery</option>
	<option>designate field owner</option>
	<option>wine category</option>
	<option>wine grade</option>
	</select>
	<%	//-------------------------------------------------
		//	페이지 전환
		//------------------------------------------------- %>
	<button onclick="OnDisplay()">보기</button> <input type="button" Onclick="location.href='main.jsp'" value="메인으로">
		<script>
			function OnDisplay(){
				var selectOption = document.getElementById("show");
				selectOption = selectOption.options[selectOption.selectedIndex].value;
				if(selectOption == 'Insert Field') {
					document.getElementById("field").style.display="block";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// 밭 정보 입력 %>
				else if(selectOption == 'Insert Vineyard') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="block";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// 포도 농장 정보 입력 %>
				else if(selectOption == 'Insert Winery') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="block";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// 와인 생산소 정보 입력 %>
				else if(selectOption == 'designate field owner') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="block";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// 밭 소유주 지정 %>
				else if(selectOption == 'wine category') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="block";
					document.getElementById("winegrade").style.display="none";
				}	<%// 밭 소유주 지정 %>
				else if(selectOption == 'wine grade') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="block";
				}	<%// 밭 소유주 지정 %>
			}
		</script>
	
	<%	//-------------------------------------------------
		//	database 정보
		//------------------------------------------------- %>	
	
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String query1 = "Select owner FROM Vineyard ORDER BY owner ASC";
	%>
	
	<%	//-------------------------------------------------
		//	Field 정보 입력 시작
		//------------------------------------------------- %>
	
	<div id="field" style="display:none">
		<form action="registerField.jsp" method="post">
		<div>
			<h1>Field 입력</h1>
			<p>밭 정보를 입력해주십시오.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>밭의 이름이 무엇입니까?</p>
			<label>밭의 이름 : </label>
			<input type="text" name="fieldname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>밭은 어디에 있습니까?</p>
			<label>밭의 위치 : </label>
			<input type="text" name="location" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>밭의 크기는 얼마나 됩니까?</p>
			<label>밭의 크기 : </label>
			<input type="number" min="1" name="area" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>재배되는 포도는 무엇입니까?</p>
			<label>포도 종류 : </label>
			<input type=radio name="grape" value="red">red
			<input type=radio name="grape" value="white">white
		</div>
		<div>
			<p></p>													
			<input type=submit value = "데이터베이스에 저장">	
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	Vineyard 정보 입력 시작
		//------------------------------------------------- %>
	
	<div id="vineyard" style="display:none">
	<form action="registerVineyard.jsp" method="post">
		<div>
			<h1>Vineyard 입력</h1>
			<p>포도 농장의 정보를 입력해주십시오.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>농장의 이름이 무엇입니까?</p>
			<label>농장의 이름 : </label>
			<input type="text" name="Vineyardname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>소유주의 이름이 무엇입니까?</p>
			<label>소유주의 이름 : </label>
			<input type="text" name="owner" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>연락처는 무엇입니까?</p>
			<label>연락처 : </label>
			<input type="text" name="tel_number" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>Red Grape를 몇 개 가지고 있습니까?</p>
			<label>Red Grape 재고 : </label>
			<input type="number" min="0" name="stock_red" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>White Grape를 몇 개 가지고 있습니까?</p>
			<label>White Grape 재고 : </label>
			<input type="number" min="0" name="stock_white" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>보유 자금은 얼마입니까?</p>
			<label>보유 자금 : </label>
			<input type="number" min="0" name="money" required>
		</div>
			<p>--------------------------------------</p>
		
		<div>
		<p>어느 밭을 소유하고 있습니까?</p>
	<table border = "1">
		<tr>
			<td width="100">밭 ID</td>
			<td width="100">밭 이름</td>
			<td width="50">선택</td>
		</tr>
		<%
		String query3 = "SELECT * FROM Field WHERE VineyardID IS NULL;";
		result = stmt.executeQuery(query3);
		String FieldID1 = null;
		while(result.next())
		{
			
			%>	
		<tr>
			<td><%= result.getString("FieldID")%></td>
			<td><%= result.getString("Fieldname") %></td>
			<%FieldID1 = result.getString("FieldID");%>
			<td><input type="checkbox" name="checkbox1" value="<%= FieldID1%>"></td>
		</tr>
	<% }%>
	</table>
	
	</div>
		<div>
			<p></p>
			<input type=submit value = "데이터베이스에 저장">
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	Winery 정보 입력 시작
		//------------------------------------------------- %>
	
	<div id="winery" style="display:none">
		<form action="registerWinery.jsp" method="post">
		<div>
			<h1>Winery 입력</h1>
			<p>와인 생산소의 정보를 입력해주십시오.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>와인 생산소의 이름이 무엇입니까?</p>
			<label>와인 생산소의 이름 : </label>
			<input type="text" name="Wineryname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>소유주의 이름이 무엇입니까?</p>
			<label>소유주의 이름 : </label>
			<input type="text" name="owner" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>연락처는 무엇입니까?</p>
			<label>연락처 : </label>
			<input type="text" name="tel_number" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>red grape가 얼마나 있습니까?</p>
			<label>red grape 재고 : </label>
			<input type="number" name="stock_red" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>white grape가 얼마나 있습니까?</p>
			<label>white grape 재고 : </label>
			<input type="number" name="stock_white" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>보유 자금은 얼마입니까?</p>
			<label>보유 자금 : </label>
			<input type="number" name="money" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>이 와인 생산소는 몇등급입니까?</p>
			<label>와인 생산소 등급 : </label>
			<%
			String query4 = "SELECT title FROM winegrade";
			
			result = stmt.executeQuery(query4);
		
			while(result.next())
			{
				String grade = result.getString("title");
			%>
			<input type=radio name="grade" value="<%= grade%>"> <%=grade %>
	<% }%>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>이 와인 생산소는 어느 포도농장과 계약했습니까?</p>
			<label>거래할 포도 농장 : </label>
			<select name="VineyardID1">
			<option value="0">--------</option>
			<%
			String query5 = "SELECT * FROM Vineyard;";
			
			result = stmt.executeQuery(query5);
			
			while(result.next()){
				%>		<option value="<%= result.getString("VineyardID")%>"> <%=result.getString("Vineyardname")%> </option>
				<%	} %>
			</select>
		</div>	
	
		<div>
			<p></p>
			<input type=submit value = "데이터베이스에 저장">
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	밭 소유주 지정 시작
		//------------------------------------------------- %>
	
	<div id="fieldowner" style="display:none">
	<form action="registerFieldowner.jsp">
	<div>
		<h1>밭 소유주 등록</h1>
		<p>소유할 밭과 소유주의 정보를 입력해주십시오.</p>
	</div>
	<div>
		<p>--------------------------------------</p>
		<p>소유할 밭은 무엇입니까?</p>
		<label>밭의 이름 :</label>
		<select name = fieldID>
			<%
				String query6 = "SELECT FieldID, Fieldname FROM Field ORDER BY Fieldname ASC";
			
				result = stmt.executeQuery(query6);
				while(result.next()){
					String FieldID = result.getString("FieldID");
			%>		<option value="<%= FieldID%>"> <%=result.getString("fieldname") %> </option>
			<%	} %>
		</select>
	</div>
	<div>
		<p>--------------------------------------</p>
		<p>누가 밭을 샀습니까?</p>
		<label>소유 농장 :</label>
		<select name="VineyardID1">
			<%
				String query7 = "SELECT VineyardID, Vineyardname FROM Vineyard ORDER BY VineyardID ASC";
		
				result = stmt.executeQuery(query7);
				while(result.next()){
					String VineyardID = result.getString("VineyardID");
			%>
			<option value="<%= VineyardID%>"><%=result.getString("Vineyardname") %></option>
			<%} %>
		</select>
	</div>
	<div>
		<p>--------------------------------------</p>
		<input type=submit value = "Field 소유주 지정">	
	</div>
	</form>
	</div>
	<%//-------------------------------------------------- %>
	<div id="winecategory" style="display:none">
	<form action="registerwinecategory.jsp">
	<div>
		<h1>와인 카테고리 등록</h1>
		<p>와인 카테고리 등록</p>
		<p>--------------------------------------</p>
	</div>
		와인 이름 : <input type="text" name="title" required> <br><br>
		와인 기준 가격 : <input type="number" name="standardPrice" required><br><br>
		필요 red grape 개수 : <input type="number" name="required_red" required><br><br>
		필요 white grape 개수 : <input type="number" name="required_white" required><br><br>
	<div>
		<p>--------------------------------------</p>
		<input type="submit" value = "wine category 등록">	
	</div>
	</form>
	</div>
	<%//-------------------------------------------------- %>
	<div id="winegrade" style="display:none">
	<form action="registerwinegrade.jsp">
	<div>
		<h1>와인 생산소 등급 등록</h1>
	</div>
	<div>
		생산소 등급 : <input type="text" name="title" required> <br><br>
		와인 가격 비율 : <input type="number" step='0.1' name="ratio" required>
	</div>
	<div>
		<p>--------------------------------------</p>
		<input type=submit value = "grade 등록">
	</div>
	</form>
	</div>
</body>
</html>