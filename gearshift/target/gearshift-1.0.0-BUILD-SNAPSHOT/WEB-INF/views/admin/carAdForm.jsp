<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자동차 문구 생성기</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-b from-orange-50 to-white min-h-screen flex flex-col">
<header class="bg-orange-500 text-white p-4 text-lg font-bold flex justify-between items-center">
    <span>🚗 오토 스크라이브</span>
    <span class="text-sm">자동차 문구로 AI 글 생성</span>
</header>

<main class="flex-1 flex flex-col items-center justify-center px-4">
    <div class="max-w-2xl w-full text-center">
        <h1 class="text-3xl font-bold text-gray-800 mt-10">자동차 문구 생성기</h1>
        <p class="text-gray-600 mt-4">
            브랜드, 연료 유형, 차종을 선택하면 AI가 자동차 광고 문구를 만들어 드립니다.
        </p>

        <form action="/gearshift/ad/generate" method="post"
              class="bg-white shadow-md rounded-lg mt-8 p-6 flex flex-col md:flex-row gap-4 items-center">
            <input name="keyword" type="text" placeholder="예: 현대, 기아, 가솔린, 디젤 등"
                   class="flex-1 border border-gray-300 rounded px-4 py-2 w-full"/>

            <select name="category" class="border border-gray-300 rounded px-4 py-2 w-full md:w-40">
                <option value="">전체 차종</option>
                <option>세단</option>
                <option>SUV</option>
                <option>CUV</option>
                <option>소형</option>
                <option>픽업트럭</option>
            </select>

            <button type="submit"
                    class="bg-orange-500 text-white rounded px-4 py-2 hover:bg-orange-600 w-full md:w-auto">
                글 생성하기
            </button>
        </form>

        <c:if test="${not empty result}">

            <div class="mt-6 text-left">
                <h2 class="text-lg font-semibold mb-2">생성된 문구</h2>
                <pre class="bg-white p-4 border border-gray-200 rounded text-gray-800 whitespace-pre-wrap">${fn:trim(result)}</pre>
            </div>
        </c:if>

        <c:if test="${empty result}">
            <div class="mt-6 text-center text-gray-500">
                아직 결과가 없습니다.
            </div>
        </c:if>
    </div>
</main>

<footer class="bg-orange-100 text-sm text-center text-gray-600 py-4">
    © 2025 오토 스크라이브 | 자동차 문구 생성기<br>
    인공지능으로 자동차 관련 콘텐츠를 손쉽게 작성하세요
</footer>
</body>
</html>
