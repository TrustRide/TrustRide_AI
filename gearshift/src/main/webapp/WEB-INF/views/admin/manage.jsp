<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/custom.css">
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="include/header.jsp"/>

    <!-- 사이드바 포함 -->
    <jsp:include page="include/sidebar.jsp"/>

    <!-- 본문 컨텐츠 -->
    <main class="content">
        <h2>관리자정보</h2>
        <a href="${pageContext.request.contextPath}/admin/register" class="register-btn">＋ 관리자등록</a>

        <table class="table">
            <thead>
            <tr>
                <th>#</th>
                <th>이름</th>
                <th>부서</th>
                <th>직급</th>
                <th>이메일</th>
                <th>핸드폰번호</th>
                <th>성별</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody>
            <!-- 여기에 관리자 목록 반복 출력 -->
            <c:forEach var="a" items="${admins}" varStatus="status">
                <tr>
                    <td>${paging.offset + status.index + 1}</td>
                    <td>${a.adminName}</td>
                    <td>${a.department}</td>
                    <td>${a.position}</td>
                    <td>${a.adminEmail}</td>
                    <td>${a.adminPhone}</td>
                    <td>${a.gender}</td>
                    <td>
                        <c:choose>
                            <c:when test="${!a.isDeleted}">
                                <button class="deactivate-btn" onclick="toggleStatus(${a.adminId}, true)">사용중지</button>
                            </c:when>
                            <c:otherwise>
                                <button class="activate-btn" onclick="toggleStatus(${a.adminId}, false)">사용전환</button>
                            </c:otherwise>
                        </c:choose>
                    </td>
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

    <script>
        function toggleStatus(adminId, isCurrentlyActive) {
            const targetUrl = isCurrentlyActive
                ? "${pageContext.request.contextPath}/admin/deactivate"
                : "${pageContext.request.contextPath}/admin/activate";

            fetch(targetUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ adminId: adminId })
            })
            .then(response => {
                if (response.ok) {
                    alert("상태가 변경되었습니다!");
                    location.reload();
                } else {
                    alert("상태 변경 실패!");
                }
            })
            .catch(error => {
                console.error("에러 발생:", error);
                alert("요청 중 에러가 발생했습니다.");
            });
        }
    </script>
</body>
</html>