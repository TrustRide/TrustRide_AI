<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- JSTL 변수 선언 -->
<c:set var="brandList" value="${fn:split('BMW,KG모빌리티(쌍용),기아,랜드로버,르노코리아(삼성),마세라티,미니,벤츠,쉐보레(GM대우),아우디,캐딜락,포드,포르쉐,폭스바겐,현대', ',')}" />
<c:set var="vehicleTypeList" value="${fn:split('CUV,SUV,세단,소형,픽업트럭', ',')}" />
<c:set var="modelNames" value="${fn:split('카니발 4세대,더 뉴 그랜저 IG,쏘렌토 4세대,그랜저 IG,아반떼 (CN7),K5 3세대,스포티지 4세대,팰리세이드,싼타페 TM,모하비 더 마스터,제네시스 G80,GV70,GV80,K7 프리미어,그랜저 HG,쏘렌토 3세대,쏘나타 DN8,투싼 NX4,스포티지 5세대', ',')}" />
<c:set var="trimKeywords" value="${fn:split ('디젤,2.0,프리미엄,4WD,하이리무진,2WD,럭셔리,노블레스,시그니처,스페셜,플러스,1.6,2.5,3.3,GDI,터보,스탠다드,밸류,베이직,프레스티지,LPI,LPG,가솔린,9인승,카고,5인승,SE,LE,스마트,AWD', ',')}" />
<html>
<head>
  <title>중고차 가격 예측 시스템</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; padding: 2rem; background: #f4f4f4; }
    .form-container {
      background: #fff;
      border-radius: 8px;
      padding: 30px;
      max-width: 600px;
      margin: auto;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    input, select, button {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      margin-bottom: 20px;
      border-radius: 4px;
      border: 1px solid #ccc;
      font-size: 16px;
    }
    button {
      background-color: #007bff;
      color: white;
      border: none;
    }
    h2 { color: #333; text-align: center; }
  </style>
</head>
<body>

<div class="form-container">
  <h2>🚘 중고차 가격 및 손상 예측</h2>

  <form method="post" action="/gearshift/carpredict" enctype="multipart/form-data">

    <!-- 브랜드 선택 -->
    <label>브랜드 선택</label>
    <select name="brand" required>
      <c:forEach var="brand" items="${brandList}">
        <option value="${brand}">${brand}</option>
      </c:forEach>
    </select>

    <!-- 모델명 선택 -->
    <label>모델명 선택</label>
    <select name="model_name" required>
      <c:forEach var="model" items="${modelNames}">
        <option value="${model}">${model}</option>
      </c:forEach>
    </select>

    <!-- 옵션 선택(트림_요약) -->
    <label>옵션 선택</label>
    <select name="trim_summary" required>
      <c:forEach var="trim" items="${trimKeywords}">
        <option value="${trim}">${trim}</option>
      </c:forEach>
    </select>

    <!-- 차종 선택 -->
    <label>차종 선택</label>
    <select name="vehicle_type" required>
      <c:forEach var="type" items="${vehicleTypeList}">
        <option value="${type}">${type}</option>
      </c:forEach>
    </select>

    <!-- 연식 선택 -->
    <label>연식 선택</label>
    <select name="year" required>
      <c:forEach var="year" begin="2015" end="2024">
        <option value="${year}">${year}</option>
      </c:forEach>
    </select>

    <!-- 연료 타입 선택 -->
    <label>연료 종류</label>
    <select name="fuel_type" required>
      <option value="가솔린">가솔린</option>
      <option value="디젤">디젤</option>
      <option value="LPG">LPG</option>
      <option value="하이브리드">하이브리드</option>
    </select>


    <!-- 주행 거리 -->
    <label>주행 거리 (km)</label>
    <input type="number" name="km_driven" required>

    <!-- 차량 이미지 업로드 -->
    <label>차량 이미지 업로드</label>
    <input type="file" name="file" accept="image/*" required>

    <button type="submit">예측하기</button>
  </form>
</div>

</body>
</html>

