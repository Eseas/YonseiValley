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
		//	�۾� ����
		//------------------------------------------------- %>
	<label>������ �Ϸ��� �մϱ�? : </label>
	<select id="show" class="show" name="show">
	<option>Insert Field</option>
	<option>Insert Vineyard</option>
	<option>Insert Winery</option>
	<option>designate field owner</option>
	<option>wine category</option>
	<option>wine grade</option>
	</select>
	<%	//-------------------------------------------------
		//	������ ��ȯ
		//------------------------------------------------- %>
	<button onclick="OnDisplay()">����</button> <input type="button" Onclick="location.href='main.jsp'" value="��������">
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
				}	<%// �� ���� �Է� %>
				else if(selectOption == 'Insert Vineyard') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="block";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// ���� ���� ���� �Է� %>
				else if(selectOption == 'Insert Winery') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="block";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// ���� ����� ���� �Է� %>
				else if(selectOption == 'designate field owner') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="block";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="none";
				}	<%// �� ������ ���� %>
				else if(selectOption == 'wine category') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="block";
					document.getElementById("winegrade").style.display="none";
				}	<%// �� ������ ���� %>
				else if(selectOption == 'wine grade') {
					document.getElementById("field").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("winery").style.display="none";
					document.getElementById("fieldowner").style.display="none";
					document.getElementById("winecategory").style.display="none";
					document.getElementById("winegrade").style.display="block";
				}	<%// �� ������ ���� %>
			}
		</script>
	
	<%	//-------------------------------------------------
		//	database ����
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
		//	Field ���� �Է� ����
		//------------------------------------------------- %>
	
	<div id="field" style="display:none">
		<form action="registerField.jsp" method="post">
		<div>
			<h1>Field �Է�</h1>
			<p>�� ������ �Է����ֽʽÿ�.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� �̸��� �����Դϱ�?</p>
			<label>���� �̸� : </label>
			<input type="text" name="fieldname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� ��� �ֽ��ϱ�?</p>
			<label>���� ��ġ : </label>
			<input type="text" name="location" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� ũ��� �󸶳� �˴ϱ�?</p>
			<label>���� ũ�� : </label>
			<input type="number" min="1" name="area" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���Ǵ� ������ �����Դϱ�?</p>
			<label>���� ���� : </label>
			<input type=radio name="grape" value="red">red
			<input type=radio name="grape" value="white">white
		</div>
		<div>
			<p></p>													
			<input type=submit value = "�����ͺ��̽��� ����">	
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	Vineyard ���� �Է� ����
		//------------------------------------------------- %>
	
	<div id="vineyard" style="display:none">
	<form action="registerVineyard.jsp" method="post">
		<div>
			<h1>Vineyard �Է�</h1>
			<p>���� ������ ������ �Է����ֽʽÿ�.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>������ �̸��� �����Դϱ�?</p>
			<label>������ �̸� : </label>
			<input type="text" name="Vineyardname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>�������� �̸��� �����Դϱ�?</p>
			<label>�������� �̸� : </label>
			<input type="text" name="owner" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>����ó�� �����Դϱ�?</p>
			<label>����ó : </label>
			<input type="text" name="tel_number" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>Red Grape�� �� �� ������ �ֽ��ϱ�?</p>
			<label>Red Grape ��� : </label>
			<input type="number" min="0" name="stock_red" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>White Grape�� �� �� ������ �ֽ��ϱ�?</p>
			<label>White Grape ��� : </label>
			<input type="number" min="0" name="stock_white" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� �ڱ��� ���Դϱ�?</p>
			<label>���� �ڱ� : </label>
			<input type="number" min="0" name="money" required>
		</div>
			<p>--------------------------------------</p>
		
		<div>
		<p>��� ���� �����ϰ� �ֽ��ϱ�?</p>
	<table border = "1">
		<tr>
			<td width="100">�� ID</td>
			<td width="100">�� �̸�</td>
			<td width="50">����</td>
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
			<input type=submit value = "�����ͺ��̽��� ����">
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	Winery ���� �Է� ����
		//------------------------------------------------- %>
	
	<div id="winery" style="display:none">
		<form action="registerWinery.jsp" method="post">
		<div>
			<h1>Winery �Է�</h1>
			<p>���� ������� ������ �Է����ֽʽÿ�.</p>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� ������� �̸��� �����Դϱ�?</p>
			<label>���� ������� �̸� : </label>
			<input type="text" name="Wineryname" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>�������� �̸��� �����Դϱ�?</p>
			<label>�������� �̸� : </label>
			<input type="text" name="owner" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>����ó�� �����Դϱ�?</p>
			<label>����ó : </label>
			<input type="text" name="tel_number" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>red grape�� �󸶳� �ֽ��ϱ�?</p>
			<label>red grape ��� : </label>
			<input type="number" name="stock_red" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>white grape�� �󸶳� �ֽ��ϱ�?</p>
			<label>white grape ��� : </label>
			<input type="number" name="stock_white" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>���� �ڱ��� ���Դϱ�?</p>
			<label>���� �ڱ� : </label>
			<input type="number" name="money" min="0" required>
		</div>
		<div>
			<p>--------------------------------------</p>
			<p>�� ���� ����Ҵ� �����Դϱ�?</p>
			<label>���� ����� ��� : </label>
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
			<p>�� ���� ����Ҵ� ��� ��������� ����߽��ϱ�?</p>
			<label>�ŷ��� ���� ���� : </label>
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
			<input type=submit value = "�����ͺ��̽��� ����">
		</div>
		</form>
	</div>
	
	<%	//-------------------------------------------------
		//	�� ������ ���� ����
		//------------------------------------------------- %>
	
	<div id="fieldowner" style="display:none">
	<form action="registerFieldowner.jsp">
	<div>
		<h1>�� ������ ���</h1>
		<p>������ ��� �������� ������ �Է����ֽʽÿ�.</p>
	</div>
	<div>
		<p>--------------------------------------</p>
		<p>������ ���� �����Դϱ�?</p>
		<label>���� �̸� :</label>
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
		<p>���� ���� ����ϱ�?</p>
		<label>���� ���� :</label>
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
		<input type=submit value = "Field ������ ����">	
	</div>
	</form>
	</div>
	<%//-------------------------------------------------- %>
	<div id="winecategory" style="display:none">
	<form action="registerwinecategory.jsp">
	<div>
		<h1>���� ī�װ� ���</h1>
		<p>���� ī�װ� ���</p>
		<p>--------------------------------------</p>
	</div>
		���� �̸� : <input type="text" name="title" required> <br><br>
		���� ���� ���� : <input type="number" name="standardPrice" required><br><br>
		�ʿ� red grape ���� : <input type="number" name="required_red" required><br><br>
		�ʿ� white grape ���� : <input type="number" name="required_white" required><br><br>
	<div>
		<p>--------------------------------------</p>
		<input type="submit" value = "wine category ���">	
	</div>
	</form>
	</div>
	<%//-------------------------------------------------- %>
	<div id="winegrade" style="display:none">
	<form action="registerwinegrade.jsp">
	<div>
		<h1>���� ����� ��� ���</h1>
	</div>
	<div>
		����� ��� : <input type="text" name="title" required> <br><br>
		���� ���� ���� : <input type="number" step='0.1' name="ratio" required>
	</div>
	<div>
		<p>--------------------------------------</p>
		<input type=submit value = "grade ���">
	</div>
	</form>
	</div>
</body>
</html>