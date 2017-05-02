<%@page import="web.client.db.ClientDAO"%>
<%@page import="web.client.db.ClientBean"%>
<%@page import="java.util.List"%>
<%@page import="web.product.db.ProductDAO"%>
<%@page import="web.product.db.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<meta name="description" content="Creative One Page Parallax Template">
	<meta name="keywords" content="Creative, Onepage, Parallax, HTML5, Bootstrap, Popular, custom, personal, portfolio" /> 
	<meta name="author" content=""> 
	<title>HIMU - OnePage HTML Parallax template</title> 
	<link href="./css/bootstrap.min.css" rel="stylesheet">
	<link href="./css/main.css" rel="stylesheet">
	<link href="./css/inner.css" rel="stylesheet">
	<link href="./css/header.css" rel="stylesheet">
<style>

#buyer, #product, #pay{
    width: 900px;
    margin: auto;
}
#policy{
    margin-top: 55px;
}
#policy1{
    border: 1px solid;
} 

</style>
<%
String id = "test";
String product_str = request.getParameter("product_num");
String amount_str = request.getParameter("amount"); //����
String vendorId_str = request.getParameter("vendor_id");
String option1_str = request.getParameter("option1");
String option2_str = request.getParameter("option2");
String option3_str = request.getParameter("option3");
String snsId_str = "wndms4142,wndms5555";
ClientBean cb = new ClientBean();
ClientDAO cdao = new ClientDAO();
cb = cdao.getMember(id);
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script>

//���� ����
function pay(){
	if($("input:checkbox[id='policyChecked1']").is(":checked")){
		if($("input:checkbox[id='policyChecked2']").is(":checked")){
			var method = $(":input:radio[name=method]:checked").val();
			if(method == null) alert("���������� �������ּ���");
			else if(method == 'card') card();
	 		else if(method == 'deposit') deposit();
	 		else if(method == 'kakao') card();
		 }else{alert("�������� ������ �������ּ���");}
	}else{alert("�������ܿ� ������ �ּ���");}
}

//ī�� ����
function card(){
	price = document.getElementById('price').innerText;
	point = document.getElementById('myPoint').innerText;
	message = document.getElementById('message').value;
	
	IMP.init('imp29540450');
	IMP.request_pay({
	    pg : 'danal_tpay', //������Ʈ �����ڿ��� danal_tpay�� �⺻PG�� �����Ͻ� ���� ���� ����
	    pay_method : 'card', //card(�ſ�ī��), trans(�ǽð�������ü), vbank(�������), phone(�޴����Ҿװ���)
	    merchant_uid : 'high_' + new Date().getTime(), //�������� �����Ͻô� ���� �ֹ���ȣ�� ����
	    name : '���� ������',
	    amount : price,
	    buyer_email : '<%=cb.getEmail()%>',
	    buyer_name : '<%=cb.getName()%>',
	    buyer_tel : '<%=cb.getPhone()%>', //�����Ǹ� ī��� ������ ������ �� ������ �������ּ���
	    buyer_addr : '<%=cb.getAddress()%>',
	   custom_data: {
		   price : price,
		   amount_str : '<%=amount_str%>',
		   product_str : '<%=product_str%>',
		   point : point,
		   vendorId_str : '<%=vendorId_str%>',
		   snsId_str : '<%=snsId_str%>',
		   message : message,
		   option1_str : '<%=option1_str%>',
		   option2_str : '<%=option2_str%>',
		   option3_str : '<%=option3_str%>',
	   }
	}, function(rsp) {
	    if ( rsp.success ) {
	    	console.log(rsp);
	    	$.ajax({
	    		url: 'PayCompleteAction.pa',
	    		type: 'POST',
	    		data: {
	        		merchant_uid : rsp.merchant_uid,
	        		price : rsp.custom_data.price,
	        		amount_str : rsp.custom_data.amount_str,
	        		product_str : rsp.custom_data.product_str,
	        		point : rsp.custom_data.point,
	        		vendorId_str : rsp.custom_data.vendorId_str,
	        		snsId_str : rsp.custom_data.snsId_str,
	        		message : rsp.custom_data.message,
	        		option1_str : rsp.custom_data.option1_str,
	        		option2_str : rsp.custom_data.option2_str,
	        		option3_str : rsp.custom_data.option3_str,
	    		},
	    		success : function(result, status){
	    			console.log(result);
	    			console.log(status);
	    			location.href="./PayDone.pa?merchant_uid="+rsp.merchant_uid;
	    		},
	    		error: function(xhr, status, error){
	    			console.log(xhr);
	    			console.log(status);
	    			console.log(error);
	    		}
	    	});
	    } else {
	        var msg = '������ �����Ͽ����ϴ�.';
	        msg += '�������� : ' + rsp.error_msg;
	        alert(msg);
	    }
	});
}

//������ �Ա�
function deposit(){
	 window.open("Deposit.pa", "Deposit", "width=500,height=500");
}

//����Ʈ ����
function pointChanged(price, myPoint){
	point =  document.getElementById('usingPoint').value;
	if(myPoint-point>=0){
		document.getElementById('price').innerText = price-point;
		document.getElementById('myPoint').innerText = myPoint-point;
	}else{alert('����Ʈ�� �����մϴ�.');}	
}
 

</script>
</head>
<body>
<jsp:include page="../inc/header.jsp"/>
<!-- Page Content -->
<%
String[] amount = amount_str.split(",");
ProductDAO pdao = new ProductDAO();
List<ProductBean> product_list = pdao.getProduct(product_str);
int list_size = product_list.size(); 
int price=0;
%>
<div class="container">
	<div class="more_content">
		<div id="title">
			<h1>�ֹ�/����</h1>
			<hr>
  		</div>
	<div id="user_info">
  		<div id="title_in"><h2>������ ����</h2></div>
		<table id="buyer" border="1">
			<tr><td style="width: 150px;">�̸�</td><td>������</td></tr>
			<tr><td>����ּ�</td><td>�λ걤���� ���� ����Ƽ��</td></tr>
			<tr><td>����ó</td><td>010-000-0000</td></tr>
			<tr><td>��� ��û �޼���</td><td><input type="text" id="message"></td></tr>
		</table>
	</div>
	<div id="product_info">
		<div id="title_in"><h2>��ǰ ����</h2></div>
		<table id="product" border="1">
			<tr><th rowspan="<%=list_size+1 %>"  style="width: 150px;">��ۻ�ǰ</th><th>��ۻ�ǰ �̸�</th><th>����</th><th>����</th></tr>
 			<%for(int i=0; i<list_size; i++){ 
				ProductBean pb = (ProductBean)product_list.get(i);%>
 				<tr><td><%=pb.getSubject() %></td><td><%=amount[i] %></td><td><%=pb.getPrice()*Integer.parseInt(amount[i]) %></td></tr>
				<%price += pb.getPrice()*Integer.parseInt(amount[i]);} %>
		</table>
	</div>
	<div id="product_info">
		<div id="title_in"><h2>���� ����</h2></div>
		<table id="pay" border="1">
			<tr><td style="width: 150px;">��ǰ����</td><td><%=price %></td></tr>
			<tr><td>����Ʈ���</td><td><input type="number" id="usingPoint"> <button onclick="pointChanged(<%=price%>,<%=cb.getPoint()%>)">����</button><span style="float: right;" id="myPoint"><%=cb.getPoint() %></span></td></tr>
			<tr><td>�Ѱ����ݾ�</td><td><span id="price"><%=price %></span></td></tr>
			<tr><td>�������</td>
				<td><input type="radio" value="card" name="method">�ſ�ī��
            		<input type="radio" value="deposit" name="method">�������Ա�
            		<input type="radio" value="kakao" name="method">īī������</td>
			</tr>
		</table>
		<input type="checkbox" id="policyChecked1">������ ������������ ���� ���� �̿뿡 �����մϴ�. (����)
	</div>
	<div id="policy">
		<div id="policy1">
		<p>
			 �������� �� 3�� ���� ����
			ȸ���� ���������� ����� ����������޹�ħ�� ���� �����ϰ� ��ȣ�˴ϴ�.
			��ȸ�硱�� �̿��ڵ��� ���������� "�������� ��޹�ħ�� ���������� ���� �� �̿����"���� ������ ���� ������ ����ϸ�, �̿����� ���� ���� ���̴� �� ������ �ʰ��Ͽ� �̿��ϰų� ��Ģ������ �̿����� ���������� �ܺο� �������� �ʽ��ϴ�.
			ȸ�簡 �����ϴ� ���񽺸� ���Ͽ� �ֹ� �� ������ �̷���� ��� ������ Ȯ�� �� ������ �� �ŷ������� ���Ͽ� ���õ� ������ �ʿ��� ���� ������ �ŷ� ��ü���� �����մϴ�.
			��ǰ��
			�����޴���	��������	��������	���� �� �̿�Ⱓ
			���ʺ��� ������ ���� ���ö�� �Ͱ���, ���
			���ʺ���	���� ����, �������, ������Ȯ��, ������	����, �޴���ȭ��ȣ(�Ǵ� �Ƚɹ�ȣ), ������ּ�, �̸���
			�� �����ڿ� �������� �ٸ� ��쿡�� �������� ����(�ؿ� ��� ��ǰ�� �������������ȣ �Ǵ� ���ǹ�ȣ ����)�� ������ �� �ֽ��ϴ�.	��ȭ �Ǵ� ������ ������ �Ϸ�� ��� �ı� (��, ������ɿ� ������ ������ ���� �����Ⱓ ���� ����)
			�� ���� �źα� � ���� ����
			�������� ������ ���� �̿��� ���� �� �ʿ��մϴ�. �������� ������ �ź��Ͻ� �� ������, �� ��� ���� �̿��� ���ѵ� �� �ֽ��ϴ�.
		</p>
		</div>
		<div id="policy1_check"><input type="checkbox" id="policyChecked2">������ �������� ��3�� ���� ���ǿ� ���� ������ ��� �����Ͽ����� �̿� �����մϴ�.</div>
	</div>
	<div style="text-align: center; margin-top: 50px;">
		<input type="button" value="�����ϱ�" onclick="pay()">
		<input type="button" value="����ϱ�">
	</div>
	</div>
	<hr>
	<!-- Footer -->
	<footer>
		<div class="row">
			<div class="col-lg-12">
			<p>Copyright &copy; Your Website 2014</p>
			</div>
		</div>
	</footer>
</div>
<!-- /.container -->
</body>
</html>