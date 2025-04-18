<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="uri" value="${pageContext.request.requestURI}" />
<aside class="sidebar">
    <div class="sidebar-logo">
        <a href="${pageContext.request.contextPath}/admin/main"><img src="${pageContext.request.contextPath}/img/trustride2.png"></a>
        <a href="${pageContext.request.contextPath}/admin/main"><h3>Trust Ride</h3></a>
    </div>
    <ul>
         <li><a href="${pageContext.request.contextPath}/admin/cars/register">상품등록</a></li>
         <li><a href="${pageContext.request.contextPath}/admin/cars/list">상품관리</a></li>
         <li><a href="${pageContext.request.contextPath}/admin/orderList">주문관리</a></li>

         <li><a href="${pageContext.request.contextPath}/admin/chat">채팅관리</a></li>
	     <li><a href="${pageContext.request.contextPath}/admin/inquiry">문의관리</a></li>
         <li><a href="${pageContext.request.contextPath}/admin/coupons/list">쿠폰관리</a></li>

         <li><a href="${pageContext.request.contextPath}/admin/review">리뷰관리</a></li>
        <li><a href="${pageContext.request.contextPath}/adminNewsList">매거진관리</a></li>
         <li><a href="${pageContext.request.contextPath}/admin/userList">회원관리</a></li>
         <li><a href="${pageContext.request.contextPath}/admin/manage">관리자정보</a></li>
    </ul>
</aside>

<script>
    window.addEventListener("DOMContentLoaded", () => {
        const currentPath = window.location.pathname;
        const links = document.querySelectorAll(".sidebar ul li a");

        links.forEach(link => {
            const href = link.getAttribute("href");
            if (currentPath.includes(href)) {
                link.parentElement.classList.add("selected");
            }
        });
    });
</script>