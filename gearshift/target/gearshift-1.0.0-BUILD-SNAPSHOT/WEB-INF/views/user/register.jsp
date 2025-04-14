<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/register.css">
</head>
<body>
    <h2>회원가입</h2>
    <div class="container">
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="input-group email-check-group">
                <label for="email">이메일 *</label>
                <div class="input-with-button">
                    <input type="email" id="email" name="userEmail" placeholder="이메일 입력">
                    <button type="button" id="emailBtn">중복 확인</button>
                </div>
                <small id="emailMessage" class="message"></small>
            </div>

            <div class="input-group">
                <label for="password">비밀번호 *</label>
                <input type="password" id="password" name="userPassword" placeholder="비밀번호 입력">
                <small id="passwordMessage" class="message">
                    8~16자의 영문과 숫자를 포함해야 하며, 특수문자는 선택입니다.
                </small>
            </div>

            <div class="input-group">
                <label for="password">비밀번호 확인 *</label>
                <input type="password" id="confirmPassword" placeholder="비밀번호 입력">
                <small id="matchMessage" class="message">
                    비밀번호가 일치하지 않습니다.
                </small>
            </div>

            <div class="input-group">
                <label for="name">이름 *</label>
                <input type="text" id="name" name="userName" placeholder="이름 입력">
                <small id="nameMessage" class="message">
                    2~12자의 한글만 사용 가능합니다.
                </small>
            </div>

            <div class="input-group">
                <label for="phone">휴대폰번호 *</label>
                <input type="text" id="phone" name="userPhoneNumber" placeholder="휴대폰번호 '-'제외하고 입력">
                <small id="phoneMessage" class="message">
                    휴대폰 번호를 입력하여 주세요.
                </small>
            </div>

            <button class="signup-btn">가입하기</button>
        </form>
    </div>

    <!-- 인증번호 입력 모달 -->
    <div id="emailModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeModal">&times;</span>
            <h3>✉️ 이메일 인증</h3>
            <p>이메일로 발송된 인증번호를 입력해주세요.</p>
            <p id="emailTimer" style="color: #555; font-weight: bold;">남은 시간: 03:00</p>
            <div class="input-with-button">
                <input type="text" id="emailCodeInput" placeholder="인증번호 입력">
                <button id="verifyEmailCodeBtn">확인</button>
            </div>
            <small id="emailCodeMessage" style="color: red; visibility: hidden;">인증번호가 일치하지 않습니다.</small>
        </div>
    </div>

    <script>
        const emailBtn = document.getElementById("emailBtn");
        let isEmailChecked = false;

        const emailInput = document.getElementById("email");
        emailInput.addEventListener("input", function () {
            const emailMessage = document.getElementById("emailMessage");
            emailMessage.innerText = "";

            // 버튼을 이메일 인증에서 중복 확인용으로 변경
            isEmailChecked = false;
            emailBtn.style.backgroundColor = "red";
            emailBtn.innerText = "중복 확인";
        });

        const emailModal = document.getElementById("emailModal");

        emailBtn.addEventListener("click", function () {
            const email = document.getElementById("email").value;
            const emailMessage = document.getElementById("emailMessage");
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!email) {
                emailMessage.innerText = "이메일을 입력해주세요.";
                emailMessage.style.color = "red";
                emailMessage.style.display = "block";
                return;
            }

            if (!emailRegex.test(email)) {
                emailMessage.innerText = "유효한 이메일 형식이 아닙니다.";
                emailMessage.style.color = "red";
                emailMessage.style.display = "block";
                return;
            }

            // 이메일 중복 체크 단계
            if (!isEmailChecked) {
                fetch("${pageContext.request.contextPath}/check-email", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ email: email })
                })
                .then(res => res.json())
                .then(data => {
                    if (data.duplicate) {
                        emailMessage.innerText = "이미 가입된 이메일입니다.";
                        emailMessage.style.color = "red";
                        emailMessage.style.display = "block";
                        checkInputs();
                    } else {
                        emailMessage.innerText = "사용 가능한 이메일입니다.";
                        emailMessage.style.color = "green";
                        emailMessage.style.display = "block";

                        // 버튼을 이메일 인증용으로 변경
                        isEmailChecked = true;
                        emailBtn.style.backgroundColor = "green";
                        emailBtn.innerText = "이메일 인증";

                        checkInputs();
                    }
                })
                .catch(error => {
                    console.error("이메일 중복 확인 에러:", error);
                    emailMessage.innerText = "오류가 발생했습니다.";
                    emailMessage.style.color = "red";
                    emailMessage.style.display = "block";
                    checkInputs();
                });
            }
            // "이메일 인증" 버튼 누르면 모달 열기
            else {
                emailModal.style.display = "block";
                document.getElementById("emailCodeInput").value = '';

                // 인증메일 전송 요청
                fetch("${pageContext.request.contextPath}/send-auth-email", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ email: email })
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        console.log("인증 메일 전송 성공!");

                        startEmailTimer();
                        document.getElementById("verifyEmailCodeBtn").disabled = false;
                    } else {
                        console.error("인증 메일 전송 실패!");
                        emailModal.style.display = "none";
                        alert("인증 메일 전송에 실패했습니다. 다시 시도해주세요.");
                    }
                })
                .catch(error => {
                    console.error("인증 메일 전송 중 오류:", error);
                    emailModal.style.display = "none";
                    alert("서버 오류로 인증 메일 전송에 실패했습니다.");
                });
            }
        });

        // 모달 닫기
        const closeModal = document.getElementById("closeModal");
        closeModal.addEventListener("click", function () {
            emailModal.style.display = "none";
        });


        // 이메일 인증
        const verifyEmailCodeBtn = document.getElementById("verifyEmailCodeBtn");

        verifyEmailCodeBtn.addEventListener("click", function () {
            const email = document.getElementById("email").value;
            const code = document.getElementById("emailCodeInput").value;
            const emailCodeMessage = document.getElementById("emailCodeMessage");

            fetch("${pageContext.request.contextPath}/verify-email-code", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ email: email, code: code })
            })
                .then(res => res.json())
                .then(data => {
                    if (data.verified) {
                        // 인증 성공
                        emailCodeMessage.style.color = "green";
                        emailCodeMessage.innerText = "인증에 성공했습니다.";
                        emailCodeMessage.style.visibility = "visible";

                        // 이메일 input을 수정 못하게 readonly 처리
                        document.getElementById("email").readOnly = true;

                        // 인증 버튼 비활성화 or 텍스트 변경
                        const emailBtn = document.getElementById("emailBtn");
                        emailBtn.disabled = true;
                        emailBtn.innerText = "인증 완료";
                        emailBtn.style.backgroundColor = "gray";
                        emailBtn.style.cursor = "default";

                        checkInputs();
                        // 모달 닫기
                        document.getElementById("emailModal").style.display = "none";
                    } else {
                        // 인증 실패
                        emailCodeMessage.style.color = "red";
                        emailCodeMessage.innerText = "인증번호가 일치하지 않습니다.";
                        emailCodeMessage.style.visibility = "visible";
                    }
                })
                .catch(error => {
                    console.error("인증번호 확인 중 오류:", error);
                    alert("서버 오류로 인증 확인에 실패했습니다.");
                });
        });




        const passwordInput = document.getElementById("password");
        const confirmPasswordInput = document.getElementById("confirmPassword");
        const passwordMessage = document.getElementById("passwordMessage");
        const matchMessage = document.getElementById("matchMessage");

        function validatePassword() {
            const password = passwordInput.value;
            const isValid = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,16}$/.test(password);

            if (!isValid && password !== "") {
                passwordMessage.style.display = "block";
            } else {
                passwordMessage.style.display = "none";
            }

            checkInputs();
        }

        function validatePasswordMatch() {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;

            if (confirmPassword && password !== confirmPassword) {
                matchMessage.style.display = "block";
            } else {
                matchMessage.style.display = "none";
            }

            checkInputs();
        }

        // 이벤트 리스너 연결
        passwordInput.addEventListener("input", validatePassword);
        confirmPasswordInput.addEventListener("input", validatePasswordMatch);



        const nameInput = document.getElementById("name");
        const nameMessage = document.getElementById("nameMessage");

        function validateNameMatch() {
            const name = nameInput.value;
            const isValid = /^[가-힣]{2,12}$/.test(name);

            if (!isValid && name !== "") {
                nameMessage.style.display = "block";
            } else {
                nameMessage.style.display = "none";
            }

            checkInputs();
        }

        nameInput.addEventListener("input", validateNameMatch);


        const phoneInput = document.getElementById("phone");
        const phoneMessage = document.getElementById("phoneMessage");

        phoneInput.addEventListener("input", function () {
            // 숫자만 입력되게 처리
            this.value = this.value.replace(/[^0-9]/g, "");

            const phone = phoneInput.value;
            const isValid = /^01[016789]\d{7,8}$/.test(phone);

            if (!isValid && phone !== "") {
                phoneMessage.style.display = "block";
            } else {
                phoneMessage.style.display = "none";
            }

            checkInputs();
        });



        const inputs = document.querySelectorAll(".input-group input");
        const signupBtn = document.querySelector(".signup-btn");

        function checkInputs() {
            // 모든 입력 필드가 채워졌는지 확인
            const allFilled = Array.from(inputs).every(input => input.value.trim() !== "");

            // 모든 small.message 요소를 가져와서 색상이 빨간색인지 확인
            const messages = document.querySelectorAll(".message");
            const hasRedMessage = Array.from(messages).some(msg =>
                getComputedStyle(msg).color === "rgb(255, 0, 0)" &&
                msg.style.display !== "none" // 숨겨진 건 무시
            );

            //const isEmailReadonly = emailInput.readOnly; // 이메일 인증 관련 주석 처리

            // if (allFilled && !hasRedMessage && isEmailReadonly) { // 이메일 인증 관련 주석 처리
            if (allFilled && !hasRedMessage) {
                signupBtn.classList.add("active"); // 빨간색으로 변경
                signupBtn.removeAttribute("disabled"); // 버튼 활성화
            } else {
                signupBtn.classList.remove("active"); // 회색으로 변경
                signupBtn.setAttribute("disabled", "true"); // 버튼 비활성화
            }
        }

        // 모든 입력 필드에 이벤트 리스너 추가
        inputs.forEach(input => {
            input.addEventListener("input", checkInputs);
        });




        // 이메일 3분 내 인증
        let emailTimer; // 타이머 변수
        let timeLeft = 180; // 3분 = 180초

        function startEmailTimer() {
            document.getElementById("verifyEmailCodeBtn").disabled = false;
            document.getElementById("emailTimer").textContent = "남은 시간: 03:00";

            clearInterval(emailTimer); // 기존 타이머 제거 (중복 방지)
            timeLeft = 180;

            updateEmailTimerDisplay();

            emailTimer = setInterval(() => {
                timeLeft--;

                if (timeLeft <= 0) {
                    clearInterval(emailTimer);
                    document.getElementById("emailTimer").textContent = "⏰ 인증 시간이 만료되었습니다.";
                    document.getElementById("verifyEmailCodeBtn").disabled = true;
                    return;
                }

                updateEmailTimerDisplay();
            }, 1000);
        }

        function updateEmailTimerDisplay() {
            console.log("timeLeft:", timeLeft, typeof timeLeft);
            const minutes = String(Math.floor(timeLeft / 60)).padStart(2, '0');
            const seconds = String(timeLeft % 60).padStart(2, '0');
            document.getElementById("emailTimer").textContent = "남은 시간: " + minutes + ":" + seconds;
        }

    </script>
</body>
</html>
