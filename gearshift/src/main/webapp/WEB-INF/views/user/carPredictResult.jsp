<%-- carPredictResult.jsp : 가격 예측 결과 페이지 --%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>손상 및 가격 예측 결과 - TrustRide</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #FF5C00;
      --primary-hover: #e65200;
      --red: #FF3B30;
      --gray: #8A8D91;
      --dark: #333333;
      --light: #F5F7FA;
      --border: #E2E8F0;
      --radius: 0.75rem;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
      background: linear-gradient(to bottom right, #FFF6F0, #FFF0E6);
      min-height: 100vh;
      color: var(--dark);
      padding: 2rem 1rem;
    }

    .container {
      max-width: 768px;
      margin: 0 auto;
    }

    header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .brand-badge {
      display: inline-flex;
      align-items: center;
      background-color: var(--primary);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 9999px;
      margin-bottom: 0.5rem;
      gap: 0.5rem;
      font-weight: 500;
      font-size: 0.875rem;
    }

    h1 {
      font-size: 1.5rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    @media (min-width: 768px) {
      h1 {
        font-size: 1.875rem;
      }
      body {
        padding: 2rem;
      }
    }

    .card {
      background: white;
      border-radius: var(--radius);
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .result-row {
      display: flex;
      justify-content: space-between;
      padding: 1rem 0;
      border-bottom: 1px solid var(--border);
    }

    .result-row:last-child {
      border-bottom: none;
    }

    .result-label {
      font-weight: 500;
      color: var(--gray);
    }

    .result-value {
      font-weight: 700;
      color: var(--dark);
    }

    .highlight {
      color: var(--red);
    }

    .primary {
      color: var(--primary);
    }

    .image-container {
      margin-top: 1.5rem;
      text-align: center;
    }

    .image-container h2 {
      font-size: 1.25rem;
      margin-bottom: 1rem;
    }

    .car-image {
      width: 100%;
      border-radius: var(--radius);
      margin-bottom: 1.5rem;
    }

    .back-button {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background-color: white;
      color: var(--primary);
      padding: 0.75rem 1.5rem;
      border-radius: var(--radius);
      text-decoration: none;
      font-weight: 500;
      border: 1px solid var(--border);
      transition: all 0.2s;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    }

    .back-button:hover {
      background-color: #FFF8F4;
    }

    footer {
      text-align: center;
      color: var(--gray);
      font-size: 0.75rem;
      margin-top: 2rem;
    }

    .final-price {
      font-size: 1.75rem;
      font-weight: 700;
      color: var(--primary);
      text-align: center;
      padding: 1rem;
      margin: 1rem 0;
      background-color: #FFF8F4;
      border-radius: var(--radius);
    }

    .deduction-reason {
      background-color: #FFF8F4;
      border-left: 4px solid var(--primary);
      padding: 1rem;
      margin: 1rem 0;
      border-radius: 0 var(--radius) var(--radius) 0;
    }

    /* Car icon SVG */
    .car-icon {
      width: 16px;
      height: 16px;
    }
  </style>
</head>
<body>
<div class="container">
  <header>
    <!-- 작고 깔끔한 TrustRide 버튼 -->
    <a href="/gearshift/" class="brand-badge" style="display: inline-flex; align-items: center; text-decoration: none; color: white; gap: 0.5rem;">

      <svg class="car-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="24" height="24">
        <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"></path>
        <circle cx="7" cy="17" r="2"></circle>
        <path d="M9 17h6"></path>
        <circle cx="17" cy="17" r="2"></circle>
      </svg>

      <span style="font-weight: 600; font-size: 1.25rem;">TrustRide</span>
    </a>

    <!-- 타이틀 -->
    <h1 style="margin-top: 1rem;">중고차 가격 예측 결과</h1>
  </header>
</div>



  <main>
    <div class="card">
      <div class="result-row">
        <div class="result-label">모델명 및 트림</div>
        <div class="result-value primary"><c:out value="${modelSummary}" /></div>
      </div>

      <div class="result-row">
        <div class="result-label">예측된 차량 가격</div>
        <div class="result-value"><fmt:formatNumber value="${predictedPrice}" type="number" /> 원</div>
      </div>

      <div class="result-row">
        <div class="result-label">손상 등급</div>
        <div class="result-value highlight"><c:out value="${damageLevel}" /></div>
      </div>

      <div class="result-row">
        <div class="result-label">감가 금액</div>
        <div class="result-value highlight"><fmt:formatNumber value="${priceLoss}" type="number" /> 원</div>
      </div>

      <div class="final-price">
        최종 예측 가격: <fmt:formatNumber value="${finalPrice}" type="number" /> 원
      </div>

      <c:if test="${not empty deductionReason}">
        <div class="deduction-reason">
          <strong>💬 감가 사유:</strong> <c:out value="${deductionReason}" />
        </div>
      </c:if>
    </div>

    <div class="card">
      <div class="image-container">
        <h2>📷 업로드된 차량 이미지</h2>
        <c:if test="${not empty filename}">
          <img class="car-image" src="${pageContext.request.contextPath}/uploads/${filename}" alt="예측 이미지">
        </c:if>
      </div>

      <div style="text-align: center; margin-top: 1rem;">
        <a href="${pageContext.request.contextPath}/carpredict" class="back-button">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="m12 19-7-7 7-7"></path>
            <path d="M19 12H5"></path>
          </svg>
          다시 입력하기
        </a>
      </div>
    </div>
  </main>

  <footer>
    <p>© 2025 TrustRide. 모든 권리 보유.</p>
  </footer>
</div>
</body>
</html>


