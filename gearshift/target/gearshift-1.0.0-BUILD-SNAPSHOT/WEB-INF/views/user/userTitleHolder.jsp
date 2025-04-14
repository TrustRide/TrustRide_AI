<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>차량 명의 선택</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userTitleHolder.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
</head>
<body>

<!-- ✅ 헤더 (고정, 건들지 않음) -->
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<!-- ✅ 본문은 main부터 시작 -->
<main>
    <div class="container">

        <!-- 🔹 왼쪽 섹션 -->
        <div class="left-section">
            <h2>차량 명의자를 선택해 주세요.</h2>

            <button class="option-button" onclick="selectOption('개인 명의', this)">개인 명의로 등록할게요.</button>
            <button class="option-button" onclick="selectOption('개인 명의', this)">개인 명의로 등록하고, 공동 명의자가 있어요.</button>
            <button class="option-button" onclick="selectOption('개인사업자 명의', this)">개인사업자 명의로 등록할게요.</button>
            <button class="option-button" onclick="selectOption('개인사업자 명의', this)">개인사업자 명의로 등록하고, 공동 명의자가 있어요.</button>
            <button class="option-button" onclick="selectOption('법인사업자 명의', this)">법인사업자 명의로 등록할게요.</button>

            <div class="info-box">
                차량 계약 및 배송을 위해 회원정보를 사용할게요.<br>
                계약 정보를 사용하면 명의자 이름, 휴대폰번호, 배송지 등 차량 계약 및 배송에 필요한 정보가 자동으로 입력됩니다.
            </div>

            <div class="info-box">
                <p>차량 계약 및 배송을 위해 회원정보를 사용할게요.</p>
                <label><input type="radio" name="agreement" value="agree"> 동의함</label>
                <label><input type="radio" name="agreement" value="disagree"> 동의하지 않음</label>
            </div>

            <button class="next-button" onclick="goToDelivery()">다음</button>
        </div>

        <!-- 🔹 오른쪽 섹션 -->
        <div class="right-section">
            <div class="order-box">
                <div class="order-progress">
                    <div class="step-title">명의자 선택</div>
                    <div class="progress-bar-wrapper">
                        <div class="progress-bar-fill"></div>
                    </div>
                    <div class="step-count">1/4</div>
                </div>

                <c:choose>
                    <c:when test="${not empty carDto.images}">
                        <img src="${pageContext.request.contextPath}${carDto.images[0].imageUrl}" alt="대표 이미지"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/resources/img/자동차7.png" alt="기본 이미지"/>
                    </c:otherwise>
                </c:choose>

                <h3>${carDto.modelName}</h3>
                <p>${carDto.carNum} | ${carDto.manufactureYear}식 · ${carDto.mileage}km · ${carDto.fuelType}</p>

                <div class="info-buttons">
                    <button class="info-button">차량옵션</button>
                    <button class="info-button">성능·상태 점검기록부</button>
                    <button class="info-button">Trust Ride 진단서</button>
                    <button class="info-button">보험이력조회</button>
                </div>

                <hr>

                <div class="price-summary">
                    <h3>예상 결제 금액</h3>
                    <div class="price-item"><span class="label">차량가격</span><span class="value">${carDto.carPrice}만원</span></div>
                    <div class="price-item"><span class="label">이전등록비</span><span class="value">${carDto.previousRegistrationFee}만원</span></div>
                    <div class="price-item"><span class="label">등록대행수수료</span><span class="value">${carDto.agencyFee}만원</span></div>
                    <div class="price-item"><span class="label">배송비</span><span class="value">0</span></div>
                    <hr>
                    <div class="price-item total"><span class="label">총 합계</span><span class="value">${carDto.carAmountPrice}만원</span></div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ✅ 푸터 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<!-- ✅ 모달 -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <p id="modal-message">메시지</p>
        <button class="confirm-button" onclick="closeModal()">확인</button>
    </div>
</div>

<!-- ✅ 스크립트 -->
<script>
    let selectedTitle = "";
    let selectedButton = null;
    let isJointHolder = false;  // 기본값은 false

    function selectOption(selection, button) {
        if (selectedButton === button) {
            selectedButton.classList.remove('active');
            selectedTitle = "";
            isJointHolder = false;  // 선택 해제 시 공동 명의 여부를 false로 설정
            selectedButton = null;
        } else {
            document.querySelectorAll('.option-button').forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            selectedTitle = selection;

            // 버튼 텍스트에 "공동 명의자가 있어요"가 포함되어 있을 경우 공동 명의로 처리
            if (button.textContent.includes("공동 명의자") || button.textContent.includes("법인사업자")) {
                isJointHolder = true;  // "공동 명의자"라는 텍스트가 포함된 경우 true로 설정
            } else {
                isJointHolder = false;  // 그 외에는 false로 설정
            }

            selectedButton = button;
        }
    }

    function goToDelivery() {
        if (selectedTitle === "") {
            showModal("차량 명의자를 선택해 주세요.");
            return;
        }

        const agreement = document.querySelector("input[name='agreement']:checked");
        if (!agreement || agreement.value === "disagree") {
            showModal("회원정보 이용에 동의해야 진행할 수 있습니다.");
            return;
        }

        const carInfoId = ${carDto.carInfoId};

        // isJointHolder 값과 selectedTitle을 함께 전달
        window.location.href = "/gearshift/user/delivery?title=" + encodeURIComponent(selectedTitle)
            + "&carInfoId=" + carInfoId
            + "&isJointHolder=" + isJointHolder;
    }
</script>

</body>
</html>
