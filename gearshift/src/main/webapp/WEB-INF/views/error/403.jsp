<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>403 - 접근 금지</title>
    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            background-color: #fefefe;
            text-align: center;
            padding-top: 100px;
            color: #333;
        }
        .emoji {
            font-size: 80px;
        }
        .message {
            font-size: 24px;
            margin-top: 20px;
        }
        .sub-message {
            font-size: 16px;
            color: #777;
            margin-top: 10px;
        }
        a {
            display: inline-block;
            margin-top: 30px;
            color: #0066cc;
            text-decoration: none;
            font-size: 18px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="emoji">🚫</div>
<div class="message">접근이 제한된 페이지입니다</div>
<div class="sub-message">이 페이지에 대한 권한이 없어요.</div>
<a href="javascript:history.back()">← 이전 페이지로 돌아가기</a>
</body>
</html>