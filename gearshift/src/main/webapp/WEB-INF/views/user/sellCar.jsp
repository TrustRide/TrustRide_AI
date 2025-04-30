

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내차 팔기 - TrustRide</title>
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
            max-width: 960px;
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
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
        }

        .subtitle {
            color: var(--gray);
            max-width: 32rem;
            margin: 0 auto 2rem;
        }

        @media (min-width: 768px) {
            h1 {
                font-size: 2.25rem;
            }
            body {
                padding: 2.5rem;
            }
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

        input, select, textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            font-family: inherit;
            font-size: 1rem;
            transition: all 0.2s;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(255, 92, 0, 0.2);
        }

        button {
            width: 100%;
            padding: 0.875rem 1.25rem;
            border-radius: var(--radius);
            border: none;
            background-color: var(--primary);
            color: white;
            font-weight: 600;
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

        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
        }

        @media (min-width: 768px) {
            .grid {
                grid-template-columns: 1fr 1fr;
            }
        }

        .benefit-card {
            padding: 1.5rem;
            border-radius: var(--radius);
            background-color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .benefit-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .icon-wrapper {
            width: 3.5rem;
            height: 3.5rem;
            background-color: rgba(255, 92, 0, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .step-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            margin: 2rem 0;
        }

        @media (min-width: 768px) {
            .step-container {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .step-card {
            background-color: white;
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
            position: relative;
        }

        .step-number {
            position: absolute;
            top: -1rem;
            left: 50%;
            transform: translateX(-50%);
            background-color: var(--primary);
            color: white;
            width: 2rem;
            height: 2rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        footer {
            text-align: center;
            color: var(--gray);
            font-size: 0.875rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .car-icon {
            width: 16px;
            height: 16px;
        }

        .required-mark {
            color: var(--red);
            margin-left: 0.25rem;
        }
    </style>
</head>
<body>


<div class="container">
    <header>
        <a href="${pageContext.request.contextPath}/"
           class="brand-badge"
           style="display: inline-flex; align-items: center; text-decoration: none; color: white; gap: 0.5rem;">

            <svg class="car-icon" xmlns="http://www.w3.org/2000/svg"
                 viewBox="0 0 24 24" fill="none"
                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 width="24" height="24">
                <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5
             c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/>
                <circle cx="7" cy="17" r="2"/>
                <path d="M9 17h6"/>
                <circle cx="17" cy="17" r="2"/>
            </svg>

            <span style="font-weight: 600; font-size: 1.25rem;">TrustRide</span>
        </a>

        <h1>내 차 팔기 신청</h1>
        <p class="subtitle">빠르고 정확한 내차 견적부터 등록, 소유권 이전까지 한 번에 처리해 드립니다.</p>
        <!-- 배너 컨테이너 -->
        <div style="width: 960px; height: 300px; display: flex; justify-content: center; align-items: center; background-color: ghostwhite; margin: 0 auto;">
            <div style="position: relative;">
            <img src="${pageContext.request.contextPath}/resources/img/sellcar_top_banner.png"
                 alt="AI 견적 배너"
                 width="444"
                 height="300"
                 style="object-fit: contain;" />

            <!-- 버튼을 이미지 아래에 배치 -->
            <div style="position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%);">
                <a href="${pageContext.request.contextPath}/carpredict"
                   style="background-color: #ff5c00; color: white; padding: 12px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">
                    눌러서 견적 확인 &gt;
                </a>
            </div>
        </div>

    </header>

    <main>

        <div class="card">
            <h2 style="margin-bottom: 1.5rem; font-size: 1.25rem; text-align: center;">TrustRide 내차팔기의 장점</h2>

            <div style="display: grid; grid-template-columns: 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                <div class="benefit-card">
                    <div class="icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m8 3 4 8 5-5 5 15H2L8 3z"></path>
                        </svg>
                    </div>
                    <h3 style="margin-bottom: 0.75rem; font-size: 1.125rem;">빠른 견적과 당일 입금</h3>
                    <p style="color: var(--gray);">견적 확인 후 내차팔기 신청, 그리고 당일 입금까지 ! 빠르게 가능합니다.</p>
                </div>

                <div class="benefit-card">
                    <div class="icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10"></path>
                        </svg>
                    </div>
                    <h3 style="margin-bottom: 0.75rem; font-size: 1.125rem;">안전한 거래 보장</h3>
                    <p style="color: var(--gray);">허위견적 ZERO, 안전한 소유권 이전으로 믿고 거래할 수 있습니다.</p>
                </div>

                <div class="benefit-card">
                    <div class="icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 12h-4l-3 9L9 3l-3 9H2"></path>
                        </svg>
                    </div>
                    <h3 style="margin-bottom: 0.75rem; font-size: 1.125rem;">AI 자동차 분석</h3>
                    <p style="color: var(--gray);">최신 AI 기술로 차량을 정확하게 분석하여 최적의 가격을 제안합니다.</p>
                </div>
            </div>

            <h3 style="margin: 2rem 0 1rem; font-size: 1.125rem; text-align: center;">이렇게 진행됩니다</h3>

            <div class="step-container">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <h4 style="margin-top: 0.5rem; margin-bottom: 0.5rem;">신청서 작성</h4>
                    <p style="color: var(--gray); font-size: 0.875rem;">내차팔기 신청서를 작성하고 제출합니다.</p>
                </div>

                <div class="step-card">
                    <div class="step-number">2</div>
                    <h4 style="margin-top: 0.5rem; margin-bottom: 0.5rem;">방문 견적</h4>
                    <p style="color: var(--gray); font-size: 0.875rem;">차량 평가 전문가가 방문하여 차량을 확인합니다.</p>
                </div>

                <div class="step-card">
                    <div class="step-number">3</div>
                    <h4 style="margin-top: 0.5rem; margin-bottom: 0.5rem;">계약 및 입금</h4>
                    <p style="color: var(--gray); font-size: 0.875rem;">계약 체결 후 당일 대금이 입금됩니다.</p>
                </div>
            </div>
        </div>
    </main>

    <section style="margin: 2rem 0; text-align: center;">
        <h3 style="margin-bottom: 1rem; font-size: 1.25rem;">상담 및 방문 가능 시간</h3>
        <div style="display: grid; grid-template-columns: 1fr; gap: 1rem; max-width: 32rem; margin: 0 auto;">
            <div style="background-color: white; padding: 1rem; border-radius: var(--radius); box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                <p style="font-weight: 500; margin-bottom: 0.5rem;">상담 운영 시간</p>
                <p style="color: var(--gray);">평일 09:00~18:00, 토요일/일요일 09:00~18:00</p>
            </div>
            <div style="background-color: white; padding: 1rem; border-radius: var(--radius); box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                <p style="font-weight: 500; margin-bottom: 0.5rem;">차량 평가 전문가 방문 가능 시간</p>
                <p style="color: var(--gray);">평일 09:00~18:00 (법정공휴일 휴무/일요일 휴무)</p>
            </div>
        </div>
    </section>

    <footer>
        <p>© 2025 TrustRide. 모든 권리 보유.</p>
    </footer>
</div>
</body>
</html>

