<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<html>
<head>
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        #top {
            height: 150px;
            width: 60%;
            margin: auto;
            text-align: center;
            background-color: rgb(231, 228, 225);
            line-height: 150px;
        }

        #loginForm {
            width: 60%;
            height: 75%;
            background-color: rgb(255, 255, 255);
            margin: auto;
            padding: 20px 0;
            text-align: center;
            border-radius: 10px;
        }

        #login {
            width: 50%;
            background-color: white;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: gray;
            font-size: 50px;
            margin-bottom: 20px;
        }

        input[type="text"], input[type="password"] {
            width: 80%;
            height: 40px;
            margin: 10px 0;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="checkbox"] {
            margin-right: 5px;
        }

        label {
            font-size: 14px;
            color: #555;
        }

        input[type="submit"], button {
            width: 85%;
            height: 45px;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 15px;
        }

        input[type="submit"] {
            background-color: #d6d5d5;
            color: white;
            border: none;
        }

        input[type="submit"]:hover {
            background-color: #686868;
        }

        button {
            background-color: #ffffff;
            color: #2c5288;
            border: 1px solid #2c5288;
        }

        button:hover {
            background-color: #d2ddf8;
        }

        #msg {
            color: red;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .header {
            padding: 30px;
            text-align: center;
            background: white;
        }

        .header h1 {
            font-size: 50px;
        }

        /* 네비게이션 바 */
        .topnav {
            overflow: hidden;
            background-color: #818181;
        }

        .topnav a {
            float: right;
            display: block;
            color: #ffffff;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .topnav a:hover {
            background-color: #ffffff;
            color: black;
        }

        .footer {
            padding: 20px;
            text-align: center;
            background: #ddd;
            margin-top: 20px;
        }

        h5 {
            color: #a8a8a8;
        }
        #msgS1 {
            color: red;
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>

    <%
        String savedId = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("id")) {
                    savedId = c.getValue();
                }
            }
        }
    %>

</head>
<body>
<div class="header">
    <h1>로그인 화면</h1>
    <p>로그인화면 테스트</p>
</div>

<div class="topnav">
    <a href="${pageContext.request.contextPath}/loginTest">로그인테스트</a>
    <a href="#">내정보&nbsp&nbsp&nbsp&nbsp|</a>
    <a href="#">회원가입&nbsp&nbsp&nbsp&nbsp|</a>
    <a href="#">자유게시판&nbsp&nbsp&nbsp&nbsp| </a>
</div>

<form action="<c:url value='/loginTest'/>" method="post" onsubmit="return formCheck(this)">
    <div id="loginForm">
        <div id="login">


            <div id="msgS1">${param.msg}</div>
            <div id="msg"></div>

            <h1>아이디</h1>
            <input type="text" name="id" value="<%=savedId%>" placeholder="id 입력" autofocus>
            <br>
            <h1>비밀번호</h1>
            <input type="password" name="pwd" placeholder="pwd 입력">
            <br>
            <label><input type="checkbox" name="rememberId" <%= savedId.isEmpty() ? "" : "checked" %>> 아이디 저장</label>
            <br>
            <input type="submit" value="로그인">

            <p><h5>개인정보 보호를 위해 공용 PC에서 사용 시 로그아웃 상태를 꼭 확인해 주세요.</h5></p>

            <button type="button" onclick="">회원가입</button>
        </div>
    </div>

    <div class="footer">
        <h2>Footer</h2>
    </div>

    <script>
        function formCheck(frm) {
            let msg = '';

            if (frm.id.value.trim().length === 0) {
                setMessage('아이디를 입력해주세요.', frm.id);
                return false;
            }

            if (frm.pwd.value.trim().length === 0) {
                setMessage('비밀번호를 입력해주세요.', frm.pwd);
                return false;
            }

            return true;
        }

        function setMessage(msg, element) {
            let msgDiv = document.getElementById("msg");
            msgDiv.innerText = msg;
            msgDiv.style.display = "block";

            if (element) {
                element.focus();
            }
        }
    </script>

</form>

</body>
</html>
