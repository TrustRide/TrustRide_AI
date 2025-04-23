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
    }
    h2 {
      color: #d35400;
      margin-top: 40px;
    }
    .image-box {
      border: 2px solid #f39c12;
      background-color: #fffaf2;
      display: inline-block;
      padding: 15px;
      margin: 20px auto;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
<h2>📊 PCA MinMax 시각화 결과</h2>
<div class="image-box">
  <img src="${pageContext.request.contextPath}/resources/img/PCA_minmax.jpg" alt="PCA 결과">
</div>

<h2>📈 Silhouette MinMax 시각화 결과</h2>
<div class="image-box">
  <img src="${pageContext.request.contextPath}/resources/img/Silhouette_minmax.jpg" alt="Silhouette 결과">
</div>
</body>
</html>
