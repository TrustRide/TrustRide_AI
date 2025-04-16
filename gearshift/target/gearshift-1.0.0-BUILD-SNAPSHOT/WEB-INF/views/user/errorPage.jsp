<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>오류 처리 페이지</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">



    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        body {
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1; /* 헤더와 푸터를 제외한 영역을 전부 차지 */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .error-container {
            max-width: 700px;
            width: 100%;
            padding: 30px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            text-align: center;
        }

        .error-container h2 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        .error-container p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .error-container a {
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .error-container a:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<main>
    <div class="error-container">
        <h2 style="color: red;">⚠ 오류가 발생했습니다</h2>
        <p>${errorMessage}</p>
        <a href="/user/home">홈으로 돌아가기</a>
    </div>
</main>

<!--  푸터 영역 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

</body>
</html>
