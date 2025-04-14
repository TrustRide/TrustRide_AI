<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>쿠폰 생성</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

        body {
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f0f4f8;
            margin: 0;
            padding: 40px 0;
        }

        .container {
            width: 450px;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            overflow-y: auto;
        }

        h1 {
            text-align: center;
            position: sticky;
            top: 0;
            background: white;
            padding-bottom: 10px;
            z-index: 100;
            border-bottom: 2px solid #f0f0f0;
        }

        label {
            font-weight: 500;
            display: block;
            margin-top: 15px;
            color: #555;
            font-size: 15px;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 14px;
        }

        input:focus, select:focus {
            border-color: #ff6b6b;
            box-shadow: 0 0 8px rgba(255, 107, 107, 0.2);
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background: linear-gradient(to right, #ff6b6b, #f06595);
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(255, 107, 107, 0.3);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(255, 107, 107, 0.35);
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff6b6b;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #e05555;
        }

        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background-color: #ff6b6b;
            border-radius: 20px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 28px;
            margin-top: 10px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0;
            right: 0; bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #ff6b6b;
        }

        input:checked + .slider:before {
            transform: translateX(22px);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>쿠폰 생성</h1>
    <form action="${pageContext.request.contextPath}/admin/coupons/create" method="post">
        <label>쿠폰명:</label>
        <input type="text" name="couponName" value="${couponDto.couponName}" required><br>

        <label>최소 주문 금액:</label>
        <input type="number" name="minOrderAmount" value="${couponDto.minOrderAmount}" required><br>

        <label>할인 금액:</label>
        <input type="number" name="discountAmount" value="${couponDto.discountAmount}" required><br>

        <label>시작 날짜:</label>
        <input type="date" name="startDate" value="${couponDto.startDate != null ? couponDto.startDate : ''}"><br>

        <label>종료 날짜:</label>
        <input type="date" name="endDate" value="${couponDto.endDate != null ? couponDto.endDate : ''}"><br>

        <label>활성 여부:</label><br>
        <label class="switch">
            <input type="checkbox" name="isActive" ${couponDto.isActive ? 'checked' : ''}>
            <span class="slider"></span>
        </label>

        <button type="submit">쿠폰 생성</button>
    </form>
</div>
<a href="${pageContext.request.contextPath}/admin/coupons" class="back-button">목록으로 돌아가기</a>
</body>
</html>
