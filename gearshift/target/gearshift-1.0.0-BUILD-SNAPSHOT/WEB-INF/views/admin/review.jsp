<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/custom.css">
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="include/header.jsp"/>

    <!-- 사이드바 포함 -->
    <jsp:include page="include/sidebar.jsp"/>

    <!-- 본문 컨텐츠 -->
    <main class="content">
        <h2>리뷰관리</h2>
        <a href="${pageContext.request.contextPath}/admin/review/?page=${page}&isAnswered=false"><button class="deactivate-btn">미완료답변 보기</button></a>
        <a href="${pageContext.request.contextPath}/admin/review/?page=${page}"><button class="activate-btn">전체 보기</button></a>

        <table class="table">
            <thead>
            <tr>
                <th>글번호</th>
                <th>상태</th>
                <th>제목</th>
                <th>이름</th>
                <th>메일</th>
                <th>주문번호(주문ID)</th>
                <th>구매상품</th>
                <th>작성일시</th>
            </tr>
            </thead>
            <tbody>
            <!-- 여기에 관리자 목록 반복 출력 -->
            <c:forEach var="r" items="${reviews}">
                <tr>
                    <td>${r.reviewId}</td>
                    <td>
                        <c:choose>
                            <c:when test="${!r.isAnswered}">
                                <a href="${pageContext.request.contextPath}/admin/review/${r.reviewId}"><button class="deactivate-btn">답변미완료</button></a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/review/${r.reviewId}"><button class="activate-btn">보기</button></a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${r.reviewTitle}</td>
                    <td>${r.userName}</td>
                    <td>${r.userEmail}</td>
                    <td>${r.orderId}</td>
                    <td>${r.modelName}</td>
                    <td>${r.formattedCreatedAt}</td>
                </tr>
            </c:forEach>
            <!-- 반복 끝 -->
            </tbody>
        </table>

        <br>

        <div class="pagination">
            <c:if test="${paging.hasPrev}">
                <a href="?page=${paging.startPage - 1}">&lt;</a>
            </c:if>

            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                <a href="?page=${i}" class="${i == paging.page ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${paging.hasNext}">
                <a href="?page=${paging.endPage + 1}">&gt;</a>
            </c:if>
        </div>
    </main>

</body>
</html>