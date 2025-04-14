
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String title = request.getParameter("title");
    if (title == null) {
        title = "명의를 선택해 주세요.";  // 기본 메시지
    }
%>
<html>
<head>
    <title>배송지 입력</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/user/deliveryInformation.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">


    <style>
        /* ✅ 중앙 컨텐츠 여백 추가 */
        .container {
            margin-top: 11px; /* 헤더 아래 여백 */
            margin-bottom: 100px; /* 푸터 위 여백 */
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>



<div class="container">

    <!-- 왼쪽 폼 섹션 -->
    <div class="form-section">

        <h2><%= title %>를 선택했습니다.</h2> <!-- 선택한 버튼에 따라 제목 변경됨 -->

        <p>이제 명의자 정보와 배송 정보를 입력해 주세요.</p>



        <form action="/gearshift/user/payment/select" method="post">
            <!-- 명의자 타입 여부 -->
            <input type="hidden" name="ownershipType" value="${carDto.ownershipType}">
            <input type="hidden" name="isJointOwnership" value="${carDto.isJointOwnership}">

            <input type="hidden" name="userId" value="${userDto.userId}">


            <!--회원 이름 값 안넘김 -->
            <label>회원 이름</label>
            <input type="text" name="userName" value="${userDto.userName}" readonly>

            <!--명의자 전화번호 값 넘김 -->
            <label>회원 휴대폰 번호</label>
            <input type="text" name="userPhoneNumber" value="${userDto.userPhoneNumber}" readonly>


            <!-- 명의자 이름 값 넘김 -->
            <label>명의자 이름</label>
            <input type="text" name="holderName" >

            <!-- 명의자 전화번호 값 넘김 -->
            <label>명의자 전화번호</label>
            <input type="text" name="holderPhoneNumber">


            <!-- 명의자 주민등록번호 값 넘김 -->
            <label>명의자 주민등록번호</label>
            <input type="text" id="holderResident" name="holderResident" placeholder="13자리 입력" maxlength="13">



            <!--명의자 주소 값 넘김 -->
            <div class="address_wrap">
                <label>명의자 주민등록 주소지</label>
                <input type="text" name="holderAddr1" readonly placeholder="우편번호">
                <button type="button" class="address_button" onclick="execution_daum_address()">우편번호 찾기</button>
                <input type="text" name="holderAddr2" readonly placeholder="도로명 주소 또는 지번 주소">
                <input type="text" name="holderAddr3" placeholder="상세주소 입력">
            </div>


            <label for="preferredDate">희망 배송일</label>
            <input type="date" id="preferredDate" name="preferredDate" min="">
            <label for="deliveryRequest">요청사항</label>
            <input type="text" id="deliveryRequest" name="deliveryRequest">




            <!-- 면허 종류 선택 -->
            <h3>면허 정보 입력</h3>
            <div class="license-grid">
                <!-- 면허 종류 선택 값넘김 -->
                <div class="license-field">
                    <label for="holderLicense">면허 종류</label>
                    <select id="holderLicense" name="holderLicense">
                        <option value="">면허 종류 선택</option>
                        <option value="1종 보통">1종 보통</option>
                        <option value="1종 대형">1종 대형</option>
                        <option value="2종 보통">2종 보통</option>
                        <option value="2종 소형">2종 소형</option>
                    </select>
                </div>

                <input type="hidden" name="deliveryFee" value="0">

                <!-- 면허 번호 입력  안넘김-->
                <div class="license-field">
                    <label for="licenseNumber">면허 번호</label>
                    <input type="text" id="licenseNumber" name="licenseNumber" placeholder="예: 12-34-567890">
                </div>



                <!-- 면허 발급일 선택  값 안넘김-->
                <div class="license-field">
                    <label for="licenseIssuedDate">면허 발급일</label>
                    <input type="date" id="licenseIssuedDate" name="licenseIssuedDate" onchange="setLicenseExpiryDate()">
                </div>


                <!-- 면허 만료일 (자동 계산) 값 안넘김 -->
                <div class="license-field">
                    <label for="licenseExpiryDate">면허 만료일</label>
                    <input type="date" id="licenseExpiryDate" name="licenseExpiryDate" readonly>
                </div>
            </div>




            <div class="terms-container">
                <!-- 배송원1 -->
                <div class="terms-box">
                    <label><input type="radio" name="delivery" class="terms-checkbox" value="김철수,010-1234-5678" required> 배송원1</label>
                    <a href="#" onclick="openDeliveryModal(1)">보기</a>
                </div>

                <!-- 배송원2 -->
                <div class="terms-box">
                    <label><input type="radio" name="delivery" class="terms-checkbox" value="이영희,010-2345-6789"> 배송원2</label>
                    <a href="#" onclick="openDeliveryModal(2)">보기</a>
                </div>

                <!-- 배송원3 -->
                <div class="terms-box">
                    <label><input type="radio" name="delivery" class="terms-checkbox" value="박민수,010-3456-7890" required> 배송원3</label>
                    <a href="#" onclick="openDeliveryModal(3)">보기</a>
                </div>

                <!-- 배송원4 -->
                <div class="terms-box">
                    <label><input type="radio" name="delivery" class="terms-checkbox" value="최진호,010-4567-8901"> 배송원4</label>
                    <a href="#" onclick="openDeliveryModal(4)">보기</a>
                </div>
            </div>


            <div id="deliveryModal1" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal(1)">&times;</span>
                    <h2>배송원1 정보</h2>
                    <div class="modal-image">
                        <img src="<c:url value='/resources/img/di1.jpg' />" alt="배송원 1" class="logo-img"></a>
                    </div>
                    <p>배송원1 이름: 김철수</p>
                    <p>배송원1 연락처: 010-1234-5678</p>
                    <p>배송원1 주소: 서울시 강남구</p>
                    <p>배송원1 경력: Trust Ride 근무 3년차</p>
                    <button class="confirm-button" onclick="closeDeliveryModal(1)">확인</button>
                </div>
            </div>

            <!-- 모달 2 - 배송원2 정보 -->
            <div id="deliveryModal2" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal(2)">&times;</span>
                    <h2>배송원2 정보</h2>
                    <div class="modal-image">
                        <img src="<c:url value='/resources/img/di1.jpg' />" alt="배송원 2" class="logo-img"></a>
                    </div>
                    <p>배송원2 이름: 이영희</p>
                    <p>배송원2 연락처: 010-2345-6789</p>
                    <p>배송원2 주소: 서울시 송파구</p>
                    <p>배송원 2 경력: Trust Ride 근무 2년차</p>
                    <button class="confirm-button" onclick="closeDeliveryModal(2)">확인</button>
                </div>
            </div>

            <!-- 모달 3 - 배송원3 정보 -->
            <div id="deliveryModal3" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal(3)">&times;</span>
                    <h2>배송원3 정보</h2>
                    <div class="modal-image">
                        <img src="<c:url value='/resources/img/di1.jpg' />" alt="배송원 3" class="logo-img"></a>
                    </div>
                    <p>배송원3 이름: 박민수</p>
                    <p>배송원3 연락처: 010-3456-7890</p>
                    <p>배송원3 주소: 서울시 강북구</p>
                    <p>배송원 3 경력: Trust Ride 근무 6년차</p>
                    <button class="confirm-button" onclick="closeDeliveryModal(3)">확인</button>
                </div>
            </div>

            <!-- 모달 4 - 배송원4 정보 -->
            <div id="deliveryModal4" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal(4)">&times;</span>
                    <h2>배송원4 정보</h2>
                    <div class="modal-image">
                        <img src="<c:url value='/resources/img/di1.jpg' />" alt="배송원 4" class="logo-img"></a>
                    </div>
                    <p>배송원4 이름: 최진호</p>
                    <p>배송원4 연락처: 010-4567-8901</p>
                    <p>배송원4 주소: 서울시 용산구</p>
                    <p>배송원 4 경력: Trust Ride 근무 5년차</p>
                    <button class="confirm-button" onclick="closeDeliveryModal(4)">확인</button>
                </div>
            </div>


            <div class="terms-container">
                <h3>약관 동의</h3>


                <!-- 개별 약관 -->
                <div class="terms-box">
                    <label>
                        <input type="checkbox" class="agreement-checkbox" name="agreePrivacy" value="false" required onchange="updateCheckboxValue(this)">
                        개인정보 수집/이용 동의 (필수)
                    </label>
                    <a href="#" onclick="openTermsModal()">보기</a>
                </div>

                <div class="terms-box">
                    <label>
                        <input type="checkbox" class="agreement-checkbox" name="agreeThirdParty" value="false" onchange="updateCheckboxValue(this)">
                        개인정보 제3자 제공/이용 동의 (선택)
                    </label>
                    <a href="#" onclick="openThirdPartyModal()">보기</a>
                </div>

                <div class="terms-box">
                    <label>
                        <input type="checkbox" class="agreement-checkbox" name="agreeResident" value="false" required onchange="updateCheckboxValue(this)">
                        고유식별정보 수집/이용 동의 (필수)
                    </label>
                    <a href="#" onclick="openIdentificationModal()">보기</a>
                </div>

                <div class="terms-box">
                    <label>
                        <input type="checkbox" class="agreement-checkbox" name="agreeMarketing" value="false" onchange="updateCheckboxValue(this)">
                        맞춤 서비스 제공 등 혜택/정보 수신 동의 (선택)
                    </label>
                    <a href="#" onclick="openBenefitModal()">보기</a>
                </div>
            </div>

            <input type="hidden" name="carInfoId" value="${carDto.carInfoId}">
            <!--배송원 정보 -->

            <input type="hidden" name="deliveryDriverName">
            <input type="hidden" name="driverPhoneNumber">
            <!-- 다음 버튼 -->
            <button type="submit" class="submit-btn">다음</button>
        </form>

    </div>


    <div class="summary-section">
        <div class="order-box">
            <hr>

            <div class="order-progress">

                <div class="step-title">배송지 입력</div> <!--  단계 이름 -->
                <div class="progress-bar-wrapper">
                    <div class="progress-bar-fill" style="width: 50%;"></div> <!--  2단계 진행률 -->
                </div>
                <div class="step-count">2/4</div> <!--  단계 표시 -->
            </div>


            <c:choose>
                <c:when test="${not empty carDto.images}">
                    <img src="${pageContext.request.contextPath}${carDto.images[0].imageUrl}" alt="대표 이미지"
                         style="width: 100%; max-width: 320px; border-radius: 8px; margin-bottom: 15px;" />
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/자동차7.png" alt="기본 이미지"
                         style="width: 100%; max-width: 320px; border-radius: 8px; margin-bottom: 15px;" />
                </c:otherwise>
            </c:choose>

            <h3>${carDto.modelName}</h3>
            <p>${carDto.carNum} | ${carDto.manufactureYear}식 ·${carDto.mileage}km ·  ${carDto.fuelType}</p>

            <div class="info-buttons">
                <button class="info-button">차량옵션</button>
                <button class="info-button">성능·상태 점검기록부</button>
                <button class="info-button">Trust Ride 진단서</button>
                <button class="info-button">보험이력조회</button>
            </div>

            <hr>
            <div class="price-summary">
                <h3>예상 결제 금액</h3>
                <div class="price-item">
                    <span class="label">차량가격</span>
                    <span class="value">${carDto.carPrice}만원</span>
                </div>


                <div class="price-item">
                    <span class="label">이전등록비</span>
                    <span class="value">${carDto.previousRegistrationFee}만원</span>
                </div>


                <div class="price-item">
                    <span class="label">등록대행수수료</span>
                    <span class="value">${carDto.agencyFee}만원</span>
                </div>


                <div class="price-item">
                    <span class="label">배송비</span>
                    <span class="value">0원</span>

                </div>

                <hr>

                <div class="price-item total">
                    <span class="label">총 합계</span>
                    <span class="value">${carDto.carAmountPrice}만원</span>
                </div>
            </div>




        </div>
    </div>
</div>


<div id="errorModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <p id="errorMessage">모든 필수 정보를 입력해 주세요.</p>
        <button class="confirm-button" onclick="closeModal()">확인</button>
    </div>
</div>

<!-- 개인정보 수집/이용 동의 모달 -->
<div id="termsModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeTermsModal()">&times;</span>
        <h2>[필수] 개인정보 수집/이용 동의</h2>
        <p><strong>개인정보수집동의</strong></p>
        <p>
            - Trust Ride는 매매계약 체결과 관련하여 아래와 같은 개인의 정보를 수집 및 이용하고자 하오니 동의하여 주시기 바랍니다.
            *계약 체결을 위한 필수적 동의입니다.
        </p>

        <p><strong>- 수집항목:</strong></p>
        <ul>
            <li><strong>[개인]:</strong> 이름, 휴대전화번호, 주소, 주민등록번호, 배송지 정보 등</li>
            <li><strong>[개인사업자]:</strong> 명의자 이름, 휴대전화번호, 주소, 사업자등록번호, 사업장 주소</li>
            <li><strong>[법인사업자]:</strong> 법인 이름, 휴대전화번호, 법인등록번호, 사업자등록번호, 사업장 주소</li>
        </ul>

        <p><strong>- 이용목적:</strong></p>
        <p>매매계약상 의무이행 목적(대금청구서 송부, 대금결제, 탁송, 등록대행 포함), 본인확인 목적 등</p>

        <p><strong>- 이용/보관기간:</strong></p>
        <p>계약상 분쟁 해결을 위한 정보보관 기간이 종료되면 해당 정보를 파기하는 것을 원칙으로 합니다(5년).</p>

        <p><strong>제공 및 변경에 관한 세부 사항</strong></p>
        <p>Trust Ride는 위 제공 업체에게 개인정보를 제공할 경우, 상기한 목적 범위 내에서 제공합니다.</p>

        <button class="confirm-button" onclick="closeTermsModal()">확인</button>
    </div>
</div>


<div id="thirdPartyModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeThirdPartyModal()">&times;</span>
        <h2>[선택] 개인정보 제3자 제공/이용 동의</h2>
        <p>Trust Ride는 한국도로공사의 하이패스 고객정보 현행화와 임차인 변경 서비스를 위해 아래와 같이 고객의 개인정보를 제3자에게 제공하고 있습니다.</p>


        <table class="terms-table">
            <thead>
            <tr>
                <th>제공받는 자</th>
                <th>항목</th>
                <th>이용 목적</th>
                <th>보유 기간</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>한국도로공사</td>
                <td>성명, 휴대전화번호, 주소, 차량번호, 이메일</td>
                <td>하이패스 고객정보 현행화 및 미납 통행료 임차인 변경</td>
                <td>이용 목적과 관련된 사고조사, 분쟁 해결, 법령상 의무이행을 위한 필요 범위 내에서만 보유/이용</td>
            </tr>
            </tbody>
        </table>

        <p>귀하는 동의를 거부할 권리가 있으나, 동의하지 않을 경우 사용 목적 서비스가 제한됩니다.</p>
        <p>단, 당사 사정으로 하이패스 명의변경 (고객정보 현행화) 서비스 이용이 원활하지 않을 수 있습니다.</p>

        <button class="confirm-button" onclick="closeThirdPartyModal()">확인</button>
    </div>
</div>


<div id="identificationModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeIdentificationModal()">&times;</span>
        <h2>[필수] 고유식별정보 수집/이용 동의</h2>
        <p>당사는 자동차관리법 제12조, 자동차등록규칙 제33조에 의거 자동차 소유권 이전등록을 위한 목적으로 신청자의 고유식별정보(주민등록번호)를 수집·이용 합니다.</p>

        <!-- 🚗 테이블 -->
        <table class="terms-table">
            <thead>
            <tr>
                <th>수집항목</th>
                <th>이용목적</th>
                <th>이용/보관기간</th>
                <th>동의 거부 시 불이익</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>주민등록번호</td>
                <td>자동차 소유권 이전등록</td>
                <td>계약상 분쟁 해결을 위한 정보 보관 기간이 종료되면 해당 정보를 파기하는 것을 원칙으로 합니다. (5년)<br>
                    단, 관계법령에 따라 개인정보를 보존해야 하는 경우, 관계 법령에서 정하는 기간까지 보존합니다.
                </td>
                <td>계약 체결 불가</td>
            </tr>
            </tbody>
        </table>

        <p>귀하는 동의를 거부할 권리가 있으나, 동의하지 않을 경우 자동차 소유권 이전등록이 불가능합니다.</p>

        <button class="confirm-button" onclick="closeIdentificationModal()">확인</button>
    </div>
</div>


<div id="benefitModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeBenefitModal()">&times;</span>
        <h2>[선택] 맞춤 서비스 제공 등 혜택/정보 수신 동의</h2>
        <p>Trust Ride는 고객에게 맞춤형 서비스와 혜택을 제공하기 위해 아래와 같이 개인정보를 수집·이용합니다.</p>

        <!-- 📌 테이블 -->
        <table class="terms-table">
            <thead>
            <tr>
                <th>활용하는 개인정보 항목</th>
                <th>개인정보의 수집 이용 목적</th>
                <th>개인정보의 보유 및 이용 기간</th>
                <th>동의 거부에 따른 불이익 내용</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>성명, 휴대전화번호</td>
                <td>새로운 서비스/신상품이나 이벤트 정보 안내, 서비스 제공 및 광고 발송, 통계 및 유효성 확인</td>
                <td>회원 탈퇴 시 즉시 삭제 (단, 신규 서비스 제공을 위한 5년 보관)</td>
                <td>동의하지 않아도 회원가입은 가능하나, 이벤트 혜택 및 맞춤 서비스 제공 불가</td>
            </tr>
            </tbody>
        </table>

        <p>귀하는 동의를 거부할 권리가 있으나, 동의하지 않을 경우 맞춤 서비스 제공이 제한될 수 있습니다.</p>


        <button class="confirm-button" onclick="closeBenefitModal()">확인</button>

    </div>
</div>



<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>




<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/deliveryInformation.js"></script>







</body>
</html>
