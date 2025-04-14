<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- ✅ 마이페이지 sidebar 전용 CSS -->

<nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px;" id="mySidebar">
    <div class="w3-container w3-padding-16">
        <h3 class="w3-wide"><b>MY PAGE</b></h3>
    </div>
    
    <div class="mypage-section">
        <div class="mypage-section-title">MY 쇼핑</div>
        <a href="${pageContext.request.contextPath}/user/orders/status/orderList" class="mypage-link">주문목록/배송조회</a>
        <a href="${pageContext.request.contextPath}/user/orders/refundable" class="mypage-link">환불신청</a>
    </div>

    <div class="mypage-section">
        <div class="mypage-section-title">MY 혜택</div>
        <a href="${pageContext.request.contextPath}/user/coupons/list" class="mypage-link">쿠폰함</a>
    </div>

    <div class="mypage-section">
        <div class="mypage-section-title">MY 활동</div>
        <a href="${pageContext.request.contextPath}/user/inquiry" class="mypage-link">문의하기</a>
        <a href="${pageContext.request.contextPath}/user/review/list" class="mypage-link">리뷰하기</a>
        <a href="${pageContext.request.contextPath}/user/wishlist" class="mypage-link">찜 리스트</a>
    </div>

    <div class="mypage-section">
        <div class="mypage-section-title">MY 정보</div>
        <a href="${pageContext.request.contextPath}/user/userForm" class="mypage-link">개인정보확인/수정</a>
    </div>
</nav>



