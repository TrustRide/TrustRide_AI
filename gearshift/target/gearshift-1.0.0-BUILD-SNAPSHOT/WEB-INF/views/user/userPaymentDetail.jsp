<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <title>결제 상세 페이지</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/userPaymentDetail.css' />">


  <script>
    function handlePayment() {
      var paymentMethod = document.getElementById("paymentMethod").value;
      var form = document.getElementById("paymentForm");
      if (paymentMethod === "현금") {
        document.getElementById("accountModal").style.display = "block";
      } else {
        form.action = "/gearshift/user/payment/creditCard";
        form.submit();
      }
    }

    function proceedToNextPage() {
      var form = document.getElementById("paymentForm");
      form.action = "/gearshift/user/orders/status/cash";
      form.submit();
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="container-detail">
  <section class="payment-detail-section">
    <main>
      <div>
        <h3>총 결제금액</h3>
        <h2>${carInfo.carAmountPrice}만원</h2>
      </div>

      <div style="display: flex; background: white; border: 1px solid #eee; border-radius: 8px; margin-top: 20px;">
        <!-- 왼쪽 설명 영역 -->
        <div style="flex: 1; padding: 20px;">
          <h4 style="font-size: 16px; margin-bottom: 14px;">결제 상세</h4>

        </div>

        <!-- 오른쪽 결제 금액 박스 -->
        <div style="flex: 1.5; background: #f9f9f9; padding: 20px; border-left: 1px solid #ddd;">
          <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">

          </div>

          <div style="margin-top: 12px;">
            <div style="display: flex; justify-content: space-between; padding: 6px 0;">
              <span>차량가</span>
              <span>${carInfo.carPrice}만원</span>
            </div>
            <div style="display: flex; justify-content: space-between; padding: 6px 0;">
              <span>관리비용</span>
              <span>${carInfo.maintenanceCost}만원</span>
            </div>
            <div style="display: flex; justify-content: space-between; padding: 6px 0;">
              <span>등록신청대행수수료</span>
              <span>${carInfo.agencyFee}만원</span>
            </div>


            <div style="display: flex; justify-content: space-between; padding: 6px 0;">
              <span>배송비</span>
              <span> ${carDetailDto.deliveryFee}원</span>
            </div>
          </div>

          <div style="display: flex; justify-content: space-between; font-weight: bold; border-top: 1px solid #ccc; padding-top: 12px; margin-top: 12px; color: #b40000;">
            <span>총 가격</span>
            <span>${carInfo.carAmountPrice}만원</span>
          </div>
        </div>
      </div>
      <!-- form 태그: 결제가 완료되는 순간 서버로 데이터를 넘김 -->
      <form id="paymentForm" method="post">
        <!-- 선택한 결제 수단 -->
        <input type="hidden" name="paymentMethod" id="paymentMethod" value="${carDetailDto.paymentMethod}">

        <input type="hidden" name="carInfoId" value="${carInfo.carInfoId}">
        <input type="hidden" name="deliveryFee" value="${carDetailDto.deliveryFee}">
        <input type="hidden" name="driverPhoneNumber" value="${carDetailDto.driverPhoneNumber}">
        <input type="hidden" name="preferredDate" value="${carDetailDto.preferredDate}">
        <input type="hidden" name="deliveryRequest" value="${carDetailDto.deliveryRequest}">
        <input type="hidden" name="deliveryDriverName" value="${carDetailDto.deliveryDriverName}">
        <input type="hidden" name="carAmountPrice" value="${carInfo.carAmountPrice}">

        <input type="hidden" name="holderName" value="${carDetailDto.holderName}">
        <input type="hidden" name="holderPhoneNumber" value="${carDetailDto.holderPhoneNumber}">
        <input type="hidden" name="holderResident" value="${carDetailDto.holderResident}">
        <input type="hidden" name="holderAddr1" value="${carDetailDto.holderAddr1}">
        <input type="hidden" name="holderAddr2" value="${carDetailDto.holderAddr2}">
        <input type="hidden" name="holderAddr3" value="${carDetailDto.holderAddr3}">
        <input type="hidden" name="holderLicense" value="${carDetailDto.holderLicense}">
        <input type="hidden" name="ownershipType" value="${carDetailDto.ownershipType}">
        <input type="hidden" name="isJointOwnership" value="${carDetailDto.isJointOwnership}">
      </form>

      <!-- 결제 버튼 -->
      <button class="submit-button" onclick="handlePayment()">즉시 결제</button>
    </main>


  </section>

  <section class="order-summary-section">

    <!-- 오른쪽 주문 섹션 -->
    <div class="right-section">

      <div class="order-box">

        <!-- 프로그래스 바  -->
        <div class="order-progress">
          <div class="step-title">결제 상세</div> <!--  단계 이름 -->
          <div class="progress-bar-wrapper">
            <div class="progress-bar-fill" style="width: 100%;"></div> <!--  2단계 진행률 -->
          </div>
          <div class="step-count">4/4</div> <!--  단계 표시 -->
        </div>
        <img src="${pageContext.request.contextPath}${carInfo.images[0].imageUrl}" alt="대표 이미지"
             style="width: 100%; border-radius: 8px; margin-bottom: 15px;" />
        <h3>${carInfo.modelName}</h3>
        <p>${carInfo.carNum} | ${carInfo.manufactureYear} 식  · ${carInfo.mileage}km · ${carInfo.fuelType}</p>

        <div class="info-buttons">
          <button class="info-button">차량옵션</button>
          <button class="info-button">성능·상태 점검기록부</button>
          <button class="info-button">Trust Ride 진단서</button>
          <button class="info-button">보험이력조회</button>
        </div>

        <div class="price-summary">
          <h3>예상 결제 금액</h3>
          <div class="price-item">
            <span class="label">차량가격</span>
            <span class="value">${carInfo.carPrice}만원</span>
          </div>
          <div class="price-item">
            <span class="label">이전등록비</span>
            <span class="value">${carInfo.previousRegistrationFee}만원</span>
          </div>
          <div class="price-item">
            <span class="label">등록대행수수료</span>
            <span class="value">${carInfo.agencyFee}만원</span>
          </div>
          <div class="price-item">
            <span class="label">배송비</span>
            <span class="value">${carDetailDto.deliveryFee}원</span>
          </div>
          <div class="price-item total">
            <span class="label">총 합계</span>
            <span class="value">${carInfo.carAmountPrice}만원</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<!-- 계좌번호 안내창 모달창 -->
<div id="accountModal" style="display:none; position:fixed; top:50%; left:50%;  transform:translate(-50%, -50%);
      background:white; padding:20px; border-radius:10px; box-shadow: 0 0 10px rgba(0,0,0,0.3);">
  <p>계좌번호: <strong>123-4567-8901</strong></p>
  <button type="button" onclick="proceedToNextPage()">확인</button>
</div>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>