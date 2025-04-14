<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 / 비밀번호 찾기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/login.css">
</head>
<body>
    <div class="container">
        <h2>아이디 / 비밀번호 찾기</h2>

        <div class="tab-menu">
          <div class="tab active" id="idTab" onclick="switchTab('id')">아이디 찾기</div>
          <div class="tab" id="pwTab" onclick="switchTab('pw')">비밀번호 찾기</div>
        </div>

        <div id="idForm">
            <div class="input-group">
                <input type="text" id="idName" placeholder="이름" required>
            </div>
            <div class="input-group">
                <input type="tel" id="idPhone" placeholder="전화번호 (- 없이)" required>
            </div>
            <button class="login-btn" id="findIdBtn">아이디 찾기</button>
            <div id="idResult" style="margin-top: 15px; font-size: 14px;"></div>
        </div>

        <div id="pwForm" class="hidden">
            <div class="input-group">
                <input type="email" id="pwEmail" placeholder="이메일" required>
            </div>
            <div class="input-group">
                <input type="tel" id="pwPhone" placeholder="전화번호 (- 없이)" required>
            </div>
            <button class="login-btn" id="findPwBtn">이메일로 임시 비밀번호 받기</button>
            <div id="pwResult" style="margin-top: 15px; font-size: 14px;"></div>
        </div>

        <div class="links">
            <a href="${pageContext.request.contextPath}/login.do">로그인</a> |
            <a href="${pageContext.request.contextPath}/register">회원가입</a>
        </div>
    </div>

    <script>

        function switchTab(tab) {
            const idTab = document.getElementById('idTab');
            const pwTab = document.getElementById('pwTab');
            const idForm = document.getElementById('idForm');
            const pwForm = document.getElementById('pwForm');

            if (tab === 'id') {
                idTab.classList.add('active');
                pwTab.classList.remove('active');
                idForm.classList.remove('hidden');
                pwForm.classList.add('hidden');
            } else {
                idTab.classList.remove('active');
                pwTab.classList.add('active');
                idForm.classList.add('hidden');
                pwForm.classList.remove('hidden');
            }
        }

        document.getElementById("findIdBtn").addEventListener("click", function () {
            const name = document.getElementById("idName").value.trim();
            const phone = document.getElementById("idPhone").value.trim();
            const resultBox = document.getElementById("idResult");

            if (!name || !phone) {
              alert("이름과 전화번호를 입력해주세요.");
              return;
            }

            <%--fetch(`/find-email?name=${encodeURIComponent(name)}&phone=${encodeURIComponent(phone)}`)--%>
            <%--    .then(response => response.json())--%>
            <%--    .then(data => {--%>
            <%--      resultBox.innerText = data.email--%>
            <%--              ? `가입하신 이메일은 ${data.email} 입니다.`--%>
            <%--              : "일치하는 정보가 없습니다.";--%>
            <%--    });--%>
        });

        document.getElementById("findPwBtn").addEventListener("click", function () {
            const email = document.getElementById("pwEmail").value.trim();
            const phone = document.getElementById("pwPhone").value.trim();
            const resultBox = document.getElementById("pwResult");

            if (!email || !phone) {
                alert("이메일과 전화번호를 입력해주세요.");
                return;
            }

            <%--fetch(`/send-reset-password?email=${encodeURIComponent(email)}&phone=${encodeURIComponent(phone)}`)--%>
            <%--    .then(response => response.json())--%>
            <%--    .then(data => {--%>
            <%--      resultBox.innerText = data.sent--%>
            <%--              ? "비밀번호 재설정 링크를 이메일로 발송했습니다."--%>
            <%--              : "일치하는 정보가 없습니다.";--%>
            <%--    });--%>
        });
    </script>
</body>
</html>