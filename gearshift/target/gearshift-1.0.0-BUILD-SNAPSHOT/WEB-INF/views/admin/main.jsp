<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>차량 데이터 분석</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Pretendard', sans-serif; background-color: #f4f6f8; }
        .content { margin-left: 220px; padding: 40px; box-sizing: border-box; }
        h1 { text-align: center; margin-bottom: 40px; }
        .charts { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; max-width: 1200px; margin: auto; }
        .chart-container { background-color: #fff; border-radius: 12px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        canvas { width: 100% !important; height: 300px !important; }
    </style>
</head>
<body>

<jsp:include page="include/header.jsp"/>
<jsp:include page="include/sidebar.jsp"/>

<main class="content">
    <h1>📊 차량 데이터 분석</h1>

    <div class="charts">
        <!-- 판매 상태 비율 차트 -->
        <div class="chart-container">
            <h3>🚗 판매 상태 비율</h3>
            <canvas id="statusChart"></canvas>
        </div>

        <!-- 연료 타입 분포 차트 -->
        <div class="chart-container">
            <h3>⛽️ 연료 타입 분포</h3>
            <canvas id="fuelChart"></canvas>
        </div>

    </div>
</main>

<script>
    const carList = [
        <c:forEach var="car" items="${carList}" varStatus="status">
        {
            status: "${car.soldStatus}",
            fuel: "${car.fuelType}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const statusCounts = {};
    const fuelCounts = {};

    carList.forEach(car => {
        statusCounts[car.status] = (statusCounts[car.status] || 0) + 1;
        fuelCounts[car.fuel] = (fuelCounts[car.fuel] || 0) + 1;
    });

    const statusChart = new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: Object.keys(statusCounts),
            datasets: [{
                data: Object.values(statusCounts),
                backgroundColor: ['#4caf50', '#ff9800', '#f44336']
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { position: 'bottom' } }
        }
    });

    const fuelChart = new Chart(document.getElementById('fuelChart'), {
        type: 'bar',
        data: {
            labels: Object.keys(fuelCounts),
            datasets: [{
                label: '연료 종류별 차량 수',
                data: Object.values(fuelCounts),
                backgroundColor: '#2196f3'
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
        }
    });
</script>

</body>
</html>