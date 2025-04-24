<!-- carPredictResult.jsp-->

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<head>
  <meta charset="UTF-8">
  <title>손상 및 가격 예측 결과</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; padding: 2rem; background: #f4f4f4; }
    .result-box {
      background: #fff;
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 25px;
      max-width: 700px;
      margin: auto;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h2 { color: #333; }
    .highlight { color: #d9534f; font-weight: bold; }
    .image-box { margin-top: 1.5rem; text-align: center; }
    img { max-width: 100%; border: 1px solid #ccc; border-radius: 4px; }
    .back { margin-top: 1.5rem; display: inline-block; }
    p { font-size: 1.1rem; line-height: 1.6; }
  </style>
</head>
<body>

<div class="result-box">
  <h2>중고차 예측 결과</h2>

  <p><strong>모델명 및 트림:</strong> <span class="highlight"><c:out value="${modelSummary}" /></span></p>
  <p><strong>예측된 차량 가격:</strong> <span class="highlight"><fmt:formatNumber value="${predictedPrice}" type="number" /> 원</span></p>
  <p><strong>손상 등급:</strong> <span class="highlight"><c:out value="${damageLevel}" /></span></p>
  <p><strong>감가 금액:</strong> <span class="highlight"><fmt:formatNumber value="${priceLoss}" type="number" /> 원</span></p>
  <p><strong>최종 예측 가격:</strong> <span class="highlight"><fmt:formatNumber value="${finalPrice}" type="number" /> 원</span></p>

  <c:if test="${not empty deductionReason}">
    <p><strong>💬 감가 사유:</strong> <c:out value="${deductionReason}" /></p>
  </c:if>

  <div class="image-box">
    <h3>📷 업로드된 차량 이미지</h3>
    <c:if test="${not empty filename}">
      <img src="${pageContext.request.contextPath}/uploads/${filename}" alt="예측 이미지">
    </c:if>
  </div>

  <a href="${pageContext.request.contextPath}/user/carpredict" class="back">← 다시 입력하기</a>
</div>

</body>
</html>




