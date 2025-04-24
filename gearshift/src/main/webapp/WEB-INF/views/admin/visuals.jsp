<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>정적 이미지 보기</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #fff8f0;
      text-align: center;
      padding: 50px;
      color: #333;
      outline: none;
      caret-color: transparent;
    }
    h2 {
      color: #d35400;
      margin-top: 40px;
    }
    .image-box {
      border: 2px solid #fff8f0;
      background-color: #fff8f0;
      display: inline-block;
      padding: 15px;
      margin: 20px auto;
      border-radius: 12px;
    }
    img {
      max-width: 90%;
      height: auto;
      border-radius: 8px;
    }
  </style>
</head>
<body>

<!-- 관리자 공통 헤더/사이드바 포함 -->
<jsp:include page="include/header.jsp"/>
<jsp:include page="include/sidebar.jsp"/>


<div class="image-box">
  <img src="${pageContext.request.contextPath}/resources/img/PCA_minmax.jpg" alt="PCA 결과">
</div>


</body>
</html>
