<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>개인정보확인/수정</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userForm.css' />">


    <script>
        function checkPassword() {
            const password = document.getElementById("checkPassword").value;
            fetch("${pageContext.request.contextPath}/user/userForm/check-password", {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({password: password})
            })
                .then(res => res.json())
                .then(data => {
                    if (data.verified) {
                        alert("비밀번호 확인 완료");
                        document.getElementById("passwordCheckArea").style.display = "none";
                        document.getElementById("profileForm").style.display = "block";
                        document.getElementById("deleteForm").style.display = "block";
                        document.getElementById("newPasswordRow").style.display = "block";
                        document.getElementById("currentPassword").value = password;
                        document.getElementById("currentPasswordDel").value = password;
                    } else {
                        alert("비밀번호가 일치하지 않습니다.");
                    }
                });
        }
    </script>

</head>

<body class="w3-content" style="max-width:1200px">
<%
    request.setAttribute("hideSearch", true);
%>
<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>
<main class="profile-main">

<!-- 본문: 회원정보 수정 -->
    <div class="content-box">
        <h2>회원 프로필</h2>

        <section class="password-check-section">
        <div id="passwordCheckArea">
            <label>비밀번호:</label>
            <input type="password" id="checkPassword" />
            <button onclick="checkPassword()">확인</button>
        </div>
        </section>

        <section class="profile-edit-section">
        <form id="profileForm" action="${pageContext.request.contextPath}/user/userForm/update" method="post">
            <input type="hidden" name="userId" value="${user.userId}" />
            <input type="hidden" name="currentPassword" id="currentPassword" />

            <label>고객명:</label>
            <input type="text" name="userName" value="${user.userName}" readonly /><br/>

            <label>이메일:</label>
            <input type="email" name="userEmail" value="${user.userEmail}" /><br/>

            <label>연락처:</label>
            <input type="text" name="userPhoneNumber" value="${user.userPhoneNumber}" /><br/>

            <div id="newPasswordRow">
                <label>새 비밀번호:</label>
                <input type="password" name="userPassword" /><br/>
            </div>

            <button type="submit">변경하기</button>
        </form>
        </section>

        <section class="delete-account-section">
        <form id="deleteForm" action="${pageContext.request.contextPath}/user/userForm/delete" method="post"
              onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
            <input type="hidden" name="currentPassword" id="currentPasswordDel" />
            <button type="submit" style="background-color:#f44336; color:white;">탈퇴하기</button>
        </form>
        </section>
    </div>
</main>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
