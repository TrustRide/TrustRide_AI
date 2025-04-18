<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<c:set var="loginId" value="${sessionScope.userId}" />

<html>
<head>
    <title>${newsDto.newsTitle}</title>
    <style>
        /* ===== 기본 레이아웃 ===== */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            background-color: #ffffff;
            color: #222;
            font-size: 15px;
        }

        /* ===== 메인 래퍼 ===== */
        .main-wrapper {
            margin-left: 200px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* ===== 뉴스 헤더 영역 ===== */
        .header2 {
            background-color: #888;
            padding: 30px 20px;
            color: #fff;
            margin-top: 50px;
            margin-left:87px ;
            text-align: center;
            width: 1310px;
            box-sizing: border-box;
        }
        .header2 .category {
            font-size: 13px;
            margin-bottom: 6px;
        }
        .header2 .title {
            font-size: 28px;
            font-weight: bold;
            line-height: 1.4;
        }
        .header2 .meta {
            font-size: 13px;
            margin-top: 8px;
            color: #eee;
        }

        /* ===== 컨텐츠 컨테이너 ===== */
        .container {
            max-width: 800px;
            width: 100%;
            padding: 0 16px 60px 16px;
            box-sizing: border-box;
        }

        /* ===== 본문 내용 ===== */
        .content {
            font-size: 15px;
            line-height: 1.7;
            margin-bottom: 30px;
            word-break: break-word;
            white-space: pre-line;
        }
        .content {
            margin-left: 120px;
            margin-top: 60px;
            padding: 20px;
            width: calc(100% - 250px);
        }

        /* ===== 이미지 영역 ===== */
        .news-images {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
            margin-bottom: 40px;
        }
        .news-images img {
            width: 100%;
            max-width: 500px;
            height: auto;
            margin-left: 230px;
            object-fit: contain;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        /* ===== 버튼 영역 ===== */
        .btn-back,
        .btn-delete {
            margin-top: 10px;
            display: inline-block;
            padding: 8px 16px;
            font-size: 13px;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-back {
            background-color: #007bff;
            color: white;
        }
        .btn-back:hover {
            background-color: #0056b3;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            margin-left: 8px;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }

        /* ===== 버튼을 하나의 영역으로 정렬 ===== */
        .container > div:last-child {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        /* ===== 사이드바 ===== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 200px;
            height: 100vh;
            background: #222;
            color: #fff;
            padding: 20px;
            box-sizing: border-box;
            z-index: 999;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar li {
            padding: 10px;
        }
        .sidebar li:hover {
            background: #444;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #fff;
            display: block;
            cursor: pointer;
        }
        .sidebar-logo {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 20px 0;
        }
        .sidebar-logo a {
            text-decoration: none;
            color: #fff;
            text-align: center;
        }

        /* ===== 반응형 대응 ===== */
        @media (max-width: 768px) {
            .main-wrapper {
                margin-left: 0;
            }

            .header2 .title {
                font-size: 22px;
            }

            .container {
                padding: 0 12px;
            }

            .btn-back, .btn-delete {
                font-size: 12px;
                padding: 6px 12px;
            }

            .news-images img {
                max-width: 90%;
            }
        }
    </style>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp" />

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp" />

<!-- 메인 콘텐츠 래퍼 시작 -->
<div class="main-wrapper">

    <!-- 뉴스 헤더 -->
    <div class="header2">
        <div class="category">car 매거진</div>
        <div class="title">${newsDto.newsTitle}</div>
        <div class="meta">관리자 ·
            <fmt:formatDate value="${newsDto.newsRegDate}" pattern="yyyy.MM.dd" />
        </div>
    </div>

    <div class="container">

        <!-- 본문 내용 -->
        <div class="content">
            <c:out value="${newsDto.newsContent}" escapeXml="false" />
        </div>

        <!-- 이미지 출력 -->
        <c:if test="${not empty imageList}">
            <div class="news-images">
                <c:forEach var="img" items="${imageList}">
                    <img src="${pageContext.request.contextPath}${img.newsImageUrl}" alt="뉴스 이미지" />
                </c:forEach>
            </div>
        </c:if>

        <!-- 버튼 -->
        <div>
            <a class="btn-back" href="javascript:history.back()">← 목록으로</a>
            <a class="btn-delete"
               href="<c:url value='/newsDelete?newsId=${newsDto.newsId}'/>"
               onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</a>
        </div>

    </div>
</div>

</body>
</html>
