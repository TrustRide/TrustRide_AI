// 📌 면허 만료일 자동 설정
function setLicenseExpiryDate() {
    let issueDate = document.getElementById("licenseIssuedDate").value;
    if (issueDate) {
        let expiryDate = new Date(issueDate);
        expiryDate.setFullYear(expiryDate.getFullYear() + 10);
        document.getElementById("licenseExpiryDate").value = expiryDate.toISOString().split("T")[0];
    }
}

// 📌 유효성 검사용 에러 모달
function openErrorModal(message) {
    document.getElementById("errorMessage").innerText = message;
    document.getElementById("errorModal").style.display = "block";
}

function closeErrorModal() {
    document.getElementById("errorModal").style.display = "none";
}

// 📌 약관 모달들 열고 닫기
function openTermsModal() {
    document.getElementById("termsModal").style.display = "block";
}
function closeTermsModal() {
    document.getElementById("termsModal").style.display = "none";
}
function openIdentificationModal() {
    document.getElementById("identificationModal").style.display = "block";
}
function closeIdentificationModal() {
    document.getElementById("identificationModal").style.display = "none";
}
function openBenefitModal() {
    document.getElementById("benefitModal").style.display = "block";
}
function closeBenefitModal() {
    document.getElementById("benefitModal").style.display = "none";
}
function openThirdPartyModal() {
    document.getElementById("thirdPartyModal").style.display = "block";
}
function closeThirdPartyModal() {
    document.getElementById("thirdPartyModal").style.display = "none";
}

// 📌 배송원 모달
function openDeliveryModal(id) {
    document.getElementById("deliveryModal" + id).style.display = "block";
}
function closeDeliveryModal(id) {
    document.getElementById("deliveryModal" + id).style.display = "none";
}

// 📌 약관 체크박스 동기화
function updateCheckboxValue(checkbox) {
    checkbox.value = checkbox.checked ? "true" : "false";
}
function toggleAllCheckboxes(masterCheckbox) {
    const checkboxes = document.querySelectorAll('.agreement-checkbox');
    checkboxes.forEach(cb => {
        cb.checked = masterCheckbox.checked;
        updateCheckboxValue(cb);
    });
}

// 📌 다음 단계 유효성 검사
function validateForm() {
    const fields = [
        'userName', 'userPhoneNumber', 'holderResident',
        'holderAddr1', 'holderAddr2', 'preferredDate',
        'holderLicense', 'licenseNumber', 'licenseIssuedDate', 'licenseExpiryDate'
    ];

    for (let name of fields) {
        let value = document.querySelector(`[name='${name}']`)?.value.trim();
        if (!value) {
            openErrorModal("모든 필수 정보를 입력해 주세요.");
            return;
        }
    }

    let resident = document.querySelector("[name='holderResident']").value.trim();
    if (resident.length !== 13) {
        openErrorModal("주민등록번호는 13자리여야 합니다.");
        return;
    }

    let licenseNumber = document.querySelector("[name='licenseNumber']").value.trim();
    let licenseRegex = /^[0-9]{2}-[0-9]{2}-[0-9]{6}$/;
    if (!licenseRegex.test(licenseNumber)) {
        openErrorModal("면허 번호는 형식에 맞게 입력해 주세요 (예: 12-34-567890).");
        return;
    }

    const agreePrivacy = document.querySelector("[name='agreePrivacy']").checked;
    const agreeResident = document.querySelector("[name='agreeResident']").checked;
    if (!agreePrivacy || !agreeResident) {
        openErrorModal("모든 필수 약관에 동의해 주세요.");
        return;
    }

    // ✅ 유효성 통과 시 제출
    document.querySelector("form").submit();
}

// 📌 주소 찾기
function execution_daum_address() {
    new daum.Postcode({
        oncomplete: function (data) {
            let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            let extraAddr = '';
            if (data.userSelectedType === 'R') {
                if (data.bname && /[동|로|가]$/g.test(data.bname)) extraAddr += data.bname;
                if (data.buildingName && data.apartment === 'Y') {
                    extraAddr += (extraAddr ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr) addr += ' (' + extraAddr + ')';
            }

            document.querySelector("[name=holderAddr1]").value = data.zonecode;
            document.querySelector("[name=holderAddr2]").value = addr;
            document.querySelector("[name=holderAddr3]").removeAttribute("readonly");
            document.querySelector("[name=holderAddr3]").focus();
        }
    }).open();
}

// 📌 페이지 로드 시 초기 설정 및 이벤트 바인딩
document.addEventListener("DOMContentLoaded", function () {
    // 에러 모달 확인 버튼
    const errorConfirmButton = document.querySelector("#errorModal .confirm-button");
    if (errorConfirmButton) {
        errorConfirmButton.addEventListener("click", closeErrorModal);
    }

    // 오늘 날짜 설정
    let today = new Date().toISOString().split("T")[0];
    const deliveryDateInput = document.getElementById("deliveryDate"); // ← ID 수정
    if (deliveryDateInput) deliveryDateInput.setAttribute("min", today);

    const licenseDateInput = document.getElementById("licenseIssuedDate");
    if (licenseDateInput) {
        licenseDateInput.setAttribute("max", today);
        licenseDateInput.addEventListener("change", setLicenseExpiryDate);
    }

    // 폼 제출 버튼 처리
    const submitBtn = document.querySelector(".submit-btn");
    if (submitBtn) {
        submitBtn.addEventListener("click", function (event) {
            event.preventDefault();

            const selectedDelivery = document.querySelector('input[name="delivery"]:checked');
            if (!selectedDelivery) {
                openErrorModal("배송원을 선택해 주세요.");
                return;
            }

            const [deliveryName, deliveryPhone] = selectedDelivery.value.split(',');
            document.querySelector("[name='deliveryDriverName']").value = deliveryName;
            document.querySelector("[name='driverPhoneNumber']").value = deliveryPhone;

            validateForm();
        });
    }
});