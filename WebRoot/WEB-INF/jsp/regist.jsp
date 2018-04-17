<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>会员注册</title>
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/register.css" rel="stylesheet" type="text/css"/>
<jsp:include page="menu.jsp"/>

<script>
	
	var usernameRegex = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
	
	var passwordRegex = /^\w{6,20}$/;
	
	var emailRegex =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	
	var nameRegex = /^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/ ;
	 
	var idRegex=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	
	var phoneRegex =  /^(((1[3456789][0-9]{1})|(15[0-9]{1}))+\d{8})$/;

	var isUValidate=true;
	var isPAValidate=true;
	var isRValidate=true;
	var isEValidate=true;
	var isNValidate=true;
	var isIValidate=true;
	var isPValidate=true;
	var isCValidate=true;
	function checkForm(){
	//校验用户名:
	//获得用户名文本框
	var username=document.getElementById("username").value;
	if(username==null||username==''){
		alert("用户名不能为空！")
		return false;
	}
	var password=document.getElementById("password").value;
	if(password==null||password==''){
		alert("密码不能为空！")
		return false;
	}
	var repassword=document.getElementById("repassword").value;
	if(repassword==null||repassword==''){
		alert("请重复密码！")
		return false;
	}
	var email=document.getElementById("email").value;
	if(email==null||email==''){
		alert("邮箱不能为空！")
		return false;
	}
	var name=document.getElementById("name").value;
	if(name==null||name==''){
		alert("真实姓名不能为空！")
		return false;
	}
	var identification=document.getElementById("identification").value;
	if(identification==null||identification==''){
		alert("身份证号不能为空！")
		return false;
	}
	if(!(isUValidate==true&&isPAValidate==true&&isRValidate==true&&isEValidate==true&&isNValidate==true&&isIValidate==true&&isPValidate==true&&isCValidate==true)){
		alert("信息不全或有误！请仔细检查！")
		return false;
	}
	}

	function checkUsername(node){
		var username=node.value;
		if(!usernameRegex.test(username)){
			if(username==null || username==''){
				document.getElementById("username_span").textContent="用户名不能为空！"
				document.getElementById("username_span").style.color="red";
				isUValidate=false;
			}
			else{
				document.getElementById("username_span").textContent="用户名包含特殊字符"
				document.getElementById("username_span").style.color="red";
				isUValidate=false;
			}
		}
		else{
			// 1.创建异步交互对象
			var xhr = createXmlHttp();
			// 2.设置监听
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4){
					if(xhr.status == 200){
						if(xhr.responseText=="true"){
							document.getElementById("username_span").textContent="用户名已存在"
							document.getElementById("username_span").style.color="red";
							isUValidate=false;

						}else{
							document.getElementById("username_span").textContent="√"
							document.getElementById("username_span").style.color="green";
							isUValidate=true;

						}
					}
			}
			}
			// 3.打开连接
			xhr.open("GET","${pageContext.request.contextPath}/user_findByName.action?time="+new Date().getTime()+"&username="+username,true);
			// 4.发送
			xhr.send(null);
		}
		
		
	}
	
	function createXmlHttp(){
		   var xmlHttp;
		   try{ // Firefox, Opera 8.0+, Safari
		        xmlHttp=new XMLHttpRequest();
		    }
		    catch (e){
		    alert(e.message);
			   try{// Internet Explorer
			         xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			      }
			    catch (e){
			    	alert(e.message);
			      try{
			         xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			      }
			      catch (e){alert(e.message);}
			      }
		    }

			return xmlHttp;
		 }
	function checkPassword(node){
		var password=node.value;
		if(!passwordRegex.test(password)){
			if(password==null || password==''){
				document.getElementById("password_span").textContent="密码不能为空！"
				document.getElementById("password_span").style.color="red";
				isPAValidate=false;
			}else{
				document.getElementById("password_span").textContent="密码长度过短！密码长度6-20位"
				document.getElementById("password_span").style.color="red";
				isPAValidate=false;
			}
		}
		else{
		   	document.getElementById("password_span").textContent="√"
		 	document.getElementById("password_span").style.color="green";
		 	isPAValidate=true;
		}
	}
	function checkRepassword(node){
		repassword=document.getElementById("repassword").value;
		var password=document.getElementById("password").value;
		if(!passwordRegex.test(repassword)){		
			if(repassword==null || repassword==''){
				document.getElementById("repassword_span").textContent="密码不能为空！"
				document.getElementById("repassword_span").style.color="red";
				isRValidate=false;
			}else{
				document.getElementById("repassword_span").textContent="密码长度过短！密码长度6-20位"
				document.getElementById("repassword_span").style.color="red";
				isRValidate=false;
			}
		}
		else{
			if(password==repassword){
		   		document.getElementById("repassword_span").textContent="√"
		   		document.getElementById("repassword_span").style.color="green";
		   		isRValidate=true;
			}
			else{
				document.getElementById("repassword_span").textContent="两次输入的密码不一致！";
				document.getElementById("repassword_span").style.color="red";
				isRValidate=false;
			}	
		}
	}
	function checkEmail(node){
		var email=node.value;
		if(!emailRegex.test(email)){
			if(email==null || email==''){
				document.getElementById("email_span").textContent="邮箱不能为空！"
				document.getElementById("email_span").style.color="red";
				isEValidate=false;
			}
			else{
				document.getElementById("email_span").textContent="邮箱格式不正确"
				document.getElementById("email_span").style.color="red";
				isEValidate=false;
			}
		}
		else{
			document.getElementById("email_span").textContent="√"
			document.getElementById("email_span").style.color="green";
			isEValidate=true;
		}
	}
	function checkName(node){
		var name=node.value;
		if(!nameRegex.test(name)){
			if(name==null || name==''){
				document.getElementById("name_span").textContent="真实姓名不能为空！"
				document.getElementById("name_span").style.color="red";
				isNValidate=false;
			}
			else{
				document.getElementById("name_span").textContent="姓名格式不正确"
				document.getElementById("name_span").style.color="red";
				isNValidate=false;
			}
		}
		else{
			document.getElementById("name_span").textContent="√"
			document.getElementById("name_span").style.color="green";
			isNValidate=true;
		}
	}
	function checkIdentification(node){
		var identification=node.value;
		if(!idRegex.test(identification)){
			if(identification==null || identification==''){
				document.getElementById("identification_span").textContent="身份证号不能为空！"
				document.getElementById("identification_span").style.color="red";
				isIValidate=false;
			}
			else{
				document.getElementById("identification_span").textContent="身份证格式不正确"
				document.getElementById("identification_span").style.color="red";
				isIValidate=false;
			}
		}
		else{
			document.getElementById("identification_span").textContent="√"
			document.getElementById("identification_span").style.color="green";
			isIValidate=true;
		}
	}
	function checkPhone(node){
		var phone=node.value;
		if(!phoneRegex.test(phone)){
			if(phone==null || phone==''){
				document.getElementById("phone_span").textContent=""
				isPValidate=true;
			}
			else{
				document.getElementById("phone_span").textContent="电话号码格式不正确"
				document.getElementById("phone_span").style.color="red";
				isPValidate=false;
			}
		}
		else{
			document.getElementById("phone_span").textContent="√"
			document.getElementById("phone_span").style.color="green";
			isPValidate=true;
		}
	}
	function checkcodeFunction(node){
		var checkcode=node.value;
		if(checkcode==null||checkcode==''){
			document.getElementById("checkcodeActionerror").textContent="验证码不能为空"
			isCValidate=false;
		}else{
			document.getElementById("checkcode_span").textContent=""
			isCValidate=true;
		}
	}
	function change(){
		var img1=document.getElementById("checkImage");
		img1.src="<%=path%>/checkImg.action?"+new Date().getTime();
	}
	window.onload=function(){
	checkUsername(document.getElementById("username"));
	checkEmail(document.getElementById("email"));
	checkName(document.getElementById("name"));
	checkIdentification(document.getElementById("identification"));
	checkPhone(document.getElementById("phone"));
	}
</script>
</head>
<body>
<div class="container register">
		<div class="span24">
			<div class="wrap">
				<div class="main clearfix">
					<div class="title">
						<strong>会员注册</strong>USER REGISTER
						
					</div>
					<form id="registerForm" action="<%=path %>/user_regist.action"  method="post" novalidate="novalidate" onsubmit="return checkForm();">
						<table>
							<tbody><tr>
								<th>
									<span class="requiredField">*</span>用户名:
								</th>
								<td>
									<input type="text" id="username" name="username" class="text" maxlength="20" onblur="checkUsername(this)" ></input>
									<span id="username_span"></span>
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>密&nbsp;&nbsp;码:
								</th>
								<td>
									<input type="password" id="password" name="password" class="text" maxlength="20" autocomplete="off" onblur="checkPassword(this);checkRepassword(document.getElementById('repassword'))"></input>
									<span id="password_span">密码由字母、小数和符号组成，密码长度6-20位</span>
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>确认密码:
								</th>
								<td>
									<input type="password" id="repassword" name="repassword" class="text" maxlength="20" autocomplete="off"  onblur="checkRepassword(this)"></input>
									<span id="repassword_span"></span>
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>E-mail:
								</th>
								<td>
									<input type="email" id="email" name="email" class="text" maxlength="50"  onblur="checkEmail(this)"></input>
									<span id="email_span"><s:fielderror name="email"/></strong></span>
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>真实姓名:
								</th>
								<td>
									<input type="text" id="name" name="name" class="text" maxlength="20"  onblur="checkName(this)"></input>
									<span id="name_span"></span>
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>身份证号:
								</th>
								<td>
									<input type="text" id="identification" name="identification" class="text" maxlength="18"  onblur="checkIdentification(this)"></input>
									<span id="identification_span"></span>
								</td>
							</tr>
									<tr>
										<th>
											性别:
										</th>
										<td>
												<span class="fieldSet">
														<label>
															<input type="radio" name="sex" value="male">男</input>
														</label>
														<label>
															<input type="radio" name="sex" value="female">女</input>
														</label>
												</span>
										</td>
									</tr>
									<tr>
										<th>
											出生日期:
										</th>
										<td>
												<input type="date" name="date" class="text"></input>
										</td>
									</tr>
																		<tr>
										<th>
											电话:
										</th>
										<td>
												<input type="text" id="phone" name="phone" class="text" onblur="checkPhone(this)"></input>
												<span id="phone_span"></span>
										</td>
									</tr>
									
									<tr>
										<th>
											地址:
										</th>
										<td>
												<input type="text" name="addr" class="text" maxlength="200"></input>
										</td>
									</tr>
								<tr>
									<th>
										<span class="requiredField">*</span>验证码:
									</th>
									<td>
										<span class="fieldSet">
											<input type="text" id="checkcode" name="checkcode" class="text captcha" maxlength="5" autocomplete="off" onblur="checkcodeFunction(this)"></input><img id="checkImage" class="captchaImage" src="<%=path%>/checkImg.action" onclick="change()" ontitle="点击更换验证码">
										</span>
										<span id="checkcode_span"><font color="red"><s:actionerror id="checkcodeActionerror"/></font></span>
									</td>
								</tr>
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									<input type="submit" class="submit" value="同意以下协议并注册"></input>
								</td>
							</tr>
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									注册协议
								</td>
							</tr>
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									<div id="agreement" class="agreement" style="height: 200px;">
										<p>尊敬的用户欢迎您注册成为本网站会员。请用户仔细阅读以下全部内容。如用户不同意本服务条款任意内容，请不要注册或使用本网站服务。如用户通过本网站注册程序，即表示用户与本网站已达成协议，自愿接受本服务条款的所有内容。此后，用户不得以未阅读本服务条款内容作任何形式的抗辩。</p> <p>一、本站服务条款的确认和接纳<br>本网站涉及的各项服务的所有权和运作权归本网站所有。本网站所提供的服务必须按照其发布的服务条款和操作规则严格执行。本服务条款的效力范围及于本网站的一切产品和服务，用户在享受本网站的任何服务时，应当受本服务条款的约束。</p> <p>二、服务简介<br>本网站运用自己的操作系统通过国际互联网络为用户提供各项服务。用户必须:  1. 提供设备，如个人电脑、手机或其他上网设备。 2. 个人上网和支付与此服务有关的费用。</p> <p>三、用户在不得在本网站上发布下列违法信息<br>1. 反对宪法所确定的基本原则的； 2. 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的； 3. 损害国家荣誉和利益的； 4. 煽动民族仇恨、民族歧视，破坏民族团结的； 5. 破坏国家宗教政策，宣扬邪教和封建迷信的； 6. 散布谣言，扰乱社会秩序，破坏社会稳定的； 7. 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的； 8. 侮辱或者诽谤他人，侵害他人合法权益的； 9. 含有法律、行政法规禁止的其他内容的。</p> <p>四、有关个人资料<br>用户同意:  1. 提供及时、详尽及准确的个人资料。 2. 同意接收来自本网站的信息。 3. 不断更新注册资料，符合及时、详尽准确的要求。所有原始键入的资料将引用为注册资料。 4. 本网站不公开用户的姓名、地址、电子邮箱和笔名。除以下情况外:  a) 用户授权本站透露这些信息。 b) 相应的法律及程序要求本站提供用户的个人资料。</p> <p>五、服务条款的修改<br>本网站有权在必要时修改服务条款，一旦条款及服务内容产生变动，本网站将会在重要页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的本网站信息服务。如果用户继续享用本网站信息服务，则视为接受服务条款的变动。</p> <p>六、用户隐私制度<br>尊重用户个人隐私是本网站的一项基本政策。所以，本网站一定不会在未经合法用户授权时公开、编辑或透露其注册资料及保存在本网站中的非公开内容，除非有法律许可要求或本网站在诚信的基础上认为透露这些信息在以下四种情况是必要的:  1. 遵守有关法律规定，遵从本网站合法服务程序。 2. 保持维护本网站的商标所有权。 3. 在紧急情况下竭力维护用户个人和社会大众的隐私安全。 4. 符合其他相关的要求。</p> <p>七、用户的帐号、密码和安全性<br>用户一旦注册成功，将获得一个密码和用户名。用户需谨慎合理的保存、使用用户名和密码。如果你不保管好自己的帐号和密码安全，将负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。你可随时根据指示改变你的密码。用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本网站。   八、 拒绝提供担保 用户明确同意信息服务的使用由用户个人承担风险。本网站不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保，但会在能力范围内，避免出错。</p> <p>九、有限责任<br>如因不可抗力或其它本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等本站会尽可能合理地协助处理善后事宜，并努力使客户免受经济损失，同时会尽量避免这种损害的发生。</p> <p>十、用户信息的储存和限制<br>本站有判定用户的行为是否符合国家法律法规规定及本站服务条款权利，如果用户违背本网站服务条款的规定，本网站有权中断对其提供服务的权利。</p> <p>十一、用户管理<br>用户单独承担发布内容的责任。用户对服务的使用是根据所有适用于本站的国家法律、地方法律和国际法律标准的。用户必须遵循:  1. 使用网络服务不作非法用途。 2. 不干扰或混乱网络服务。 3. 遵守所有使用网络服务的网络协议、规定、程序和惯例。 用户须承诺不传输任何非法的、骚扰性的、中伤他人的、辱骂性的、恐性的、伤害性的、庸俗的，淫秽等信息资料。另外，用户也不能传输何教唆他人构成犯罪行为的资料；不能传输助长国内不利条件和涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法律的资料。未经许可而非法进入其它电脑系统是禁止的。 若用户的行为不符合以上提到的服务条款，本站将作出独立判断立即取消用户服务帐号。用户需对自己在网上的行为承担法律责任。用户若在本站上散布和传播反动、色情或其它违反国家法律的信息，本站的系统记录有可能作为用户违反法律的证据。</p> <p>十二、通告<br>所有发给用户的通告都可通过重要页面的公告或电子邮件或常规的信件传送。服务条款的修改、服务变更、或其它重要事件的通告都会以此形式进行。</p> <p>十三、信息内容的所有权<br>本网站定义的信息内容包括: 文字、软件、声音、相片、录象、图表；在广告中全部内容；本网站为用户提供的其它信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在本网站和广告商授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。本站所有的文章版权归原文作者和本站共同所有，任何人需要转载本站的文章，必须征得原文作者或本站授权。</p> <p>十四、法律<br>本协议的订立、执行和解释及争议的解决均应适用中华人民共和国的法律。用户和本网站一致同意服从本网站所在地有管辖权的法院管辖。如发生本网站服务条款与中华人民共和国法律相抵触时，则这些条款将完全按法律规定重新解释，而其它条款则依旧保持对用户的约束力。</p>
									</div>
								</td>
							</tr>
						</tbody></table>
						<div class="login">
<div class="ad">
					<dl>
	<dt>
		注册即享受
	</dt>
	<dd>
		正品保障、正规发票
	</dd>
	<dd>
		货到付款、会员服务
	</dd>
	<dd>
		自由退换、售后上门
	</dd>
</dl>
</div>							<dl>
								<dt>已经拥有账号了？</dt>
								<dd>
									立即登录即可体验在线购物！
									<a href="./会员登录.htm">立即登录</a>
								</dd>
							</dl>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<div class="container footer">
	<div class="span24">
		<div class="footerAd">
					<img src="<%=path%>/image/footer.jpg" width="950" height="52" alt="我们的优势" title="我们的优势"></img>
</div>	</div>
	<div class="span24">
		<ul class="bottomNav">
					<li>
						<a >关于我们</a>
						|
					</li>
					<li>
						<a >联系我们</a>
						|
					</li>
					<li>
						<a >招贤纳士</a>
						|
					</li>
					<li>
						<a>法律声明</a>
						|
					</li>
					<li>
						<a >友情链接</a>
						|
					</li>
					<li>
						<a  target="_blank">支付方式</a>
						|
					</li>
					<li>
						<a  target="_blank">配送方式</a>
						|
					</li>
					<li>
						<a>服务声明</a>
						|
					</li>
					<li>
						<a >广告声明</a>
						
					</li>
		</ul>
	</div>
	<div class="span24">
		<div class="copyright">Copyright © 2005-2015 网上商城 版权所有</div>
	</div>
</div>
</body>
