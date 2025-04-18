<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>뉴스 리스트</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            background-color: #fff;
            color: #333;
        }

        .news-list {
            max-width: 720px;
            margin: 80px 0 0 700px; /* 헤더와 사이드바 공간 확보 */
            padding: 20px;
            box-sizing: border-box;
        }

        .news-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn-register {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-register:hover {
            background-color: #0056b3;
        }

        .news-item {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }

        .news-content {
            flex: 1;
            padding: 0 15px;
        }

        .news-title {
            font-size: 16px;
            font-weight: 500;
            line-height: 1.4em;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .news-image {
            width: 70px;
            height: 70px;
            flex-shrink: 0;
            border-radius: 8px;
            object-fit: cover;
        }

        .news-link {
            color: inherit;
            text-decoration: none;
        }

        .news-link:hover .news-title {
            text-decoration: underline;
        }

        /* 헤더 스타일 */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 60px;
            background-color: #333;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
            z-index: 1000;
        }

        .logo {
            font-size: 20px;
            font-weight: bold;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .user-info {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 15px;
            margin-right: 20px;
        }

        .logout-btn {
            background-color: #555;
            color: #fff;
            border: none;
            padding: 8px 14px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            white-space: nowrap;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #777;
        }

        /* 사이드바 스타일 */
        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 200px;
            height: calc(100vh - 60px);
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

        /* 페이징 스타일 */
        .pagination {
            text-align: center;
            margin: 30px 0;
        }

        .pagination a {
            margin: 0 5px;
            padding: 6px 12px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination a:hover {
            background-color: #0056b3;
            color: white;
            border-color: #0056b3;
        }
    </style>


</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<div class="news-list">

    <!-- 상단 헤더 및 등록 버튼 -->
    <div class="news-header">
        <h2>뉴스 목록</h2>
        <a href="${pageContext.request.contextPath}/news" class="btn-register">뉴스 등록</a>
    </div>

    <c:choose>
        <c:when test="${empty list}">
            <p style="text-align:center; color: #888; padding: 20px;">게시물이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="newsDto" items="${list}" varStatus="status">
                <div class="news-item">

                    <!-- 썸네일 이미지 출력 -->
                    <c:if test="${not empty newsDto.newsThumbnailUrl}">
                        <img class="news-image" src="${pageContext.request.contextPath}${newsDto.newsThumbnailUrl}" alt="썸네일">
                    </c:if>

                    <!-- 뉴스 제목 -->
                    <div class="news-content">
                        <a href="<c:url value='/adminNewsDetail?newsId=${newsDto.newsId}'/>" class="news-link">
                            <div class="news-title">${newsDto.newsTitle}</div>
                        </a>
                    </div>

                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <!-- 페이징 -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">« 이전</a>
        </c:if>
        <c:forEach begin="1" end="${totalPages}" var="page">
            <a href="?page=${page}" class="${currentPage == page ? 'active' : ''}">${page}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">다음 »</a>
        </c:if>
    </div>

</div>


</body>
</html>
