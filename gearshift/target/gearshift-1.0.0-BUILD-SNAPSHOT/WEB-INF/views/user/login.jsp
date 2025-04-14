<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  <%-- 이 줄 추가 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/login.css">
</head>
<body>
    <c:set var="loginType" value="${empty param.loginType ? 'personal' : param.loginType}" />
    <h2>안녕하세요.<br>Trust Ride 로그인입니다.</h2>
    <p style="color:red;">
        ${param.error == 'true' ? '아이디 또는 비밀번호가 올바르지 않습니다.' : '🚗'}
    </p>

    <div class="container">

        <form id="loginForm" action="${pageContext.request.contextPath}/loginUser" method="post">
            <sec:csrfInput/> <%-- CSRF 토큰 추가 --%>
            <input type="hidden" id="roleType" name="roleType" value="USER">

            <div class="tab-menu">
                <div class="tab ${loginType eq 'personal' ? 'active' : ''}" id="personalTab" onclick="switchTab('personal')">개인회원</div>
                <div class="tab ${loginType eq 'admin' ? 'active' : ''}" id="adminTab" onclick="switchTab('admin')">관리자</div>
            </div>
            <div class="input-group">
                <input type="text" id="emailInput" name="userEmail" placeholder="이메일" value="${userEmail}">
            </div>
            <div class="input-group">
                <input type="password" name="userPassword" placeholder="비밀번호">
            </div>

            <div class="save-id">
                <input type="checkbox" id="saveId">
                <label for="saveId">이메일 저장</label>
            </div>

            <button class="login-btn" type="submit">로그인</button>
        </form>

        <div class="links">
<%--            <a href="${pageContext.request.contextPath}/findInfo">아이디 · 비밀번호 찾기</a> |--%>
            <a href="${pageContext.request.contextPath}/register">회원가입</a>
        </div>
        <br>
        <div class="quick-login" style="display: none">
            <p>간편 로그인</p>
            <img src="${pageContext.request.contextPath}/img/login/btn_naver.svg" alt="네이버 로그인">
            <img src="${pageContext.request.contextPath}/img/login/btn_kakao.svg" alt="카카오 로그인">
            <img src="${pageContext.request.contextPath}/img/login/btn_google.svg" alt="구글 로그인">
        </div>
    </div>


    <script>
        <c:if test="${not empty completeMessage}">
            alert("${completeMessage}");
        </c:if>

        window.addEventListener("DOMContentLoaded", function () {
            const defaultTab = "${loginType}"; // 'personal' or 'admin'
            switchTab(defaultTab); // 초기 탭 상태 설정
        });

        const personalTab = document.getElementById('personalTab');
        const adminTab = document.getElementById('adminTab');
        const quickLogin = document.querySelector('.quick-login');
        const links = document.querySelector('.links');
        const loginForm = document.getElementById('loginForm');
        const emailInput = document.getElementById('emailInput');
        const roleTypeInput = document.getElementById('roleType');

        function switchTab(tab) {
            if (tab === 'personal') {
                personalTab.classList.add('active');
                adminTab.classList.remove('active');
                quickLogin.classList.remove('hidden');
                links.classList.remove('hidden');
                roleTypeInput.value = 'USER';
            } else {
                personalTab.classList.remove('active');
                adminTab.classList.add('active');
                quickLogin.classList.add('hidden');
                links.classList.add('hidden');
                roleTypeInput.value = 'ADMIN';
            }
        }

        loginForm.addEventListener('submit', function (e) {
            const role = roleTypeInput.value; // "USER" or "ADMIN"
            const email = emailInput.value;

            if (role === 'USER') {
                emailInput.value = "user:" + email;
            } else if (role === 'ADMIN') {
                emailInput.value = "admin:" + email;
            }
        });
    </script>
</body>
</html>
