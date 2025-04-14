<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>결제 수단 선택</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/userChoosePayment.css' />">

</head>
<body>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<div class="container">
  <!-- 왼쪽 결제 영역 -->
  <section class="payment-section">
    <!-- 주문 안내 -->
    <div class="order-guide">
      <h2>주문 내역 확인</h2>
      <p>주문 내역을 확인하고 원하시는 결제 방법을 선택해 주세요.</p>
      <div class="total-price-box">
        <strong>총 결제 금액을 확인하고, 결제 방법을 선택해 주세요.</strong>
        <ul>
          <li>구매 후 3일 동안은 위약금 없이 변경하실 수 있습니다.</li>
          <li>타던 차를 가지고 직접 방문하셔서 견적 확인 후 추가금액 결제로 새로운 차량 교환도 가능합니다.</li>
        </ul>
        <div class="action-buttons">

        </div>
      </div>
    </div>

    <!-- 결제 방법 -->
    <div class="payment-method-section">
      <h3>결제방법</h3>
      <p>결제 방법 여러 개를 등록하여 금액을 나누어 결제하실 수 있습니다.</p>
      <div class="payment-options">
        <div class="payment-option selected" onclick="selectPaymentMethod('현금')">현금</div>

        <div class="payment-option" onclick="selectPaymentMethod('신용카드')">신용카드</div>
      </div>
    </div>

    <!-- 결제 폼 -->
    <form action="/gearshift/user/payment/detail" method="post">
      <!-- 선택한 결제 수단 -->
      <input type="hidden" name="paymentMethod" id="paymentMethod">

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

      <!-- 결제 버튼 -->

      <button type="submit" class="submit-button">결제</button>


    </form>
  </section>




  <!-- 오른쪽 주문 요약 -->
  <section class="right-section">

    <!-- 프로그래스 바  -->
    <div class="order-progress">
      <div class="step-title">주문 내역 확인</div> <!--  단계 이름 -->
      <div class="progress-bar-wrapper">
        <div class="progress-bar-fill" style="width: 75%;"></div> <!--  2단계 진행률 -->
      </div>
      <div class="step-count">3/4</div> <!--  단계 표시 -->
    </div>


    <img src="${pageContext.request.contextPath}${carInfo.images[0].imageUrl}" alt="대표 이미지" />
    <h3>${carInfo.modelName}</h3>
    <p>${carInfo.carNum} | ${carInfo.manufactureYear} 식  ·  ${carInfo.mileage}km · ${carInfo.fuelType}</p>

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
  </section>

</div>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
<script>
  function selectPaymentMethod(method) {
    document.getElementById("paymentMethod").value = method;

    const options = document.querySelectorAll('.payment-option');
    options.forEach(opt => opt.classList.remove('selected'));
    options.forEach(opt => {
      if (opt.textContent.trim() === method) {
        opt.classList.add('selected');
      }
    });
  }
</script>
</body>
</html>
