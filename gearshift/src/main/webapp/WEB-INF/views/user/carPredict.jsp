<!-- carPredict.jsp : 가격 예측 페이지 -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- JSTL 변수 선언 -->
<c:set var="brandList" value="${fn:split('BMW,KG모빌리티(쌍용),기아,랜드로버,르노코리아(삼성),마세라티,미니,벤츠,쉐보레(GM대우),아우디,캐딜락,포드,포르쉐,폭스바겐,현대', ',')}" />
<c:set var="vehicleTypeList" value="${fn:split('CUV,SUV,세단,소형,픽업트럭', ',')}" />
<c:set var="modelNames" value="${fn:split('카니발 4세대,더 뉴 그랜저 IG,쏘렌토 4세대,그랜저 IG,아반떼 (CN7),K5 3세대,스포티지 4세대,팰리세이드,싼타페 TM,모하비 더 마스터,제네시스 G80,GV70,GV80,K7 프리미어,그랜저 HG,쏘렌토 3세대,쏘나타 DN8,투싼 NX4,스포티지 5세대', ',')}" />
<c:set var="trimKeywords" value="${fn:split ('디젤,2.0,프리미엄,4WD,하이리무진,2WD,럭셔리,노블레스,시그니처,스페셜,플러스,1.6,2.5,3.3,GDI,터보,스탠다드,밸류,베이직,프레스티지,LPI,LPG,가솔린,9인승,카고,5인승,SE,LE,스마트,AWD', ',')}" />

<!DOCTYPE html>
<html>
<head>
  <title>중고차 가격 예측 서비스</title>
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

    .subtitle {
      color: var(--gray);
      max-width: 32rem;
      margin: 0 auto;
    }

    .card {
      background: white;
      border-radius: var(--radius);
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .form-group {
      margin-bottom: 1.25rem;
    }

    label {
      display: block;
      font-weight: 500;
      margin-bottom: 0.5rem;
      color: var(--dark);
    }

    input, select {
      width: 100%;
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      border: 1px solid var(--border);
      font-family: inherit;
      font-size: 1rem;
      transition: all 0.2s;
    }

    input:focus, select:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 2px rgba(255, 92, 0, 0.2);
    }

    input[type="file"] {
      padding: 0.5rem 0;
    }

    button {
      width: 100%;
      padding: 0.75rem;
      border-radius: var(--radius);
      border: none;
      background-color: var(--primary);
      color: white;
      font-weight: 500;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.2s;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    button:hover {
      background-color: var(--primary-hover);
    }

    footer {
      text-align: center;
      color: var(--gray);
      font-size: 0.75rem;
      margin-top: 2rem;
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
    <header style="text-align: center; padding: 2rem 0;">
        <a href="${pageContext.request.contextPath}/"
           class="brand-badge"
           style="display: inline-flex; align-items: center; text-decoration: none; color: white; gap: 0.5rem;">

            <svg class="car-icon" xmlns="http://www.w3.org/2000/svg"
                 viewBox="0 0 24 24" fill="none"
                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 width="24" height="24">
                <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/>
                <circle cx="7" cy="17" r="2"/>
                <path d="M9 17h6"/>
                <circle cx="17" cy="17" r="2"/>
            </svg>

            <span style="font-weight: 600; font-size: 1.25rem;">TrustRide</span>
        </a>

        <h1 style="font-size: 2rem; margin-top: 1rem;">중고차 가격 예측 서비스</h1>
        <p class="subtitle" style="color: #666; font-size: 1rem; margin-top: 0.5rem;">
            인공지능을 활용하여 사진과 차량 정보로 <br />정확한 중고차 가격과 손상 등급을 예측해 드립니다.
        </p>
    </header>


    <main>
    <div class="card">
      <form method="post" action="/gearshift/carpredict" enctype="multipart/form-data">
        <div class="form-group">
          <label for="brand">브랜드 선택</label>
          <select id="brand" name="brand" required>
            <c:forEach var="brand" items="${brandList}">
              <option value="${brand}">${brand}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="model_name">모델명 선택</label>
          <select id="model_name" name="model_name" required>
            <c:forEach var="model" items="${modelNames}">
              <option value="${model}">${model}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="trim_summary">옵션 선택</label>
          <select id="trim_summary" name="trim_summary" required>
            <c:forEach var="trim" items="${trimKeywords}">
              <option value="${trim}">${trim}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="vehicle_type">차종 선택</label>
          <select id="vehicle_type" name="vehicle_type" required>
            <c:forEach var="type" items="${vehicleTypeList}">
              <option value="${type}">${type}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="year">연식 선택</label>
          <select id="year" name="year" required>
            <c:forEach var="year" begin="2015" end="2024">
              <option value="${year}">${year}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="fuel_type">연료 종류</label>
          <select id="fuel_type" name="fuel_type" required>
            <option value="가솔린">가솔린</option>
            <option value="디젤">디젤</option>
            <option value="LPG">LPG</option>
            <option value="하이브리드">하이브리드</option>
          </select>
        </div>

        <div class="form-group">
          <label for="km_driven">주행 거리 (km)</label>
          <input type="number" id="km_driven" name="km_driven" required>
        </div>

        <div class="form-group">
          <label for="file">차량 이미지 업로드</label>
          <input type="file" id="file" name="file" accept="image/*" required>
        </div>

        <button type="submit">
          예측하기
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M5 12h14"></path>
            <path d="m12 5 7 7-7 7"></path>
          </svg>
        </button>
      </form>
    </div>
  </main>

  <footer>
    <p>© 2025 TrustRide. 모든 권리 보유.</p>
  </footer>
</div>
</body>
</html>


