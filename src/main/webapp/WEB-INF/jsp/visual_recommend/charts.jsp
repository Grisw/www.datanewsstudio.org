<%@ page import="org.datanewsstudio.www.common.Urls" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <base href="../">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Analyzed Result</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,300' rel='stylesheet' type='text/css'>
    <!-- Animate.css -->
    <link rel="stylesheet" href="resources/css/animate.css">
    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="resources/css/icomoon.css">
    <!-- Bootstrap  -->
    <link rel="stylesheet" href="resources/css/bootstrap.css">
    <!-- Superfish -->
    <link rel="stylesheet" href="resources/css/superfish.css">

    <link rel="stylesheet" href="resources/css/style.css">
    <!-- Modernizr JS -->
    <script src="resources/js/modernizr-2.6.2.min.js"></script>

    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="/resources/js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div id="fh5co-header">
    <header id="fh5co-header-section">
        <div class="container">
            <div class="nav-header">
                <a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
                <h1 id="fh5co-logo" style="margin-top: 2.5%"><a href="<%=Urls.index%>">Content<span>Analyzing</span></a></h1>
                <!-- START #fh5co-menu-wrap -->
                <nav id="fh5co-menu-wrap" role="navigation">
                    <ul class="sf-menu" id="fh5co-primary-menu">
                        <li>
                            <a href="<%=Urls.index%>">HOME</a>
                        </li>

                    </ul>
                </nav>
            </div>
        </div>
    </header>

</div>

<div class="fh5co-hero fh5co-hero-2" style="height: 100px">
    <div class="fh5co-overlay" style="height: 100px"></div>
    <div class="fh5co-cover fh5co-cover_2 text-center" data-stellar-background-ratio="0.5"
         style="background-image: url(resources/img/TABG.jpg);height: 100px">

    </div>
</div>


<div class="row" style="margin-top:6%;margin-bottom: 3%">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" style="text-align: center;">
        <label style="font-family: '微软雅黑',sans-serif;text-align:center;font-size: 1.6em;">RECOMMEND CHART</label>
    </div>
    <div class="col-sm-4"></div>
</div>

<div style="height: 500px;width: 80%;margin-top: 3%;margin-left: 12%;" id="recommend-chart"></div>

<script src="resources/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="resources/js/jquery.easing.1.3.js "></script>
<!-- Bootstrap -->
<script src="resources/js/bootstrap.min.js "></script>
<!-- Waypoints -->
<script src="resources/js/jquery.waypoints.min.js "></script>
<!-- Stellar -->
<script src="resources/js/jquery.stellar.min.js "></script>
<!-- D3 -->
<script src="resources/js/d3.min.js"></script>
<script src="resources/js/d3.layout.cloud.js"></script>
<!-- Superfish -->
<script src="resources/js/hoverIntent.js "></script>
<script src="resources/js/superfish.js "></script>
<!-- Main JS (Do not remove) -->
<script src="resources/js/main.js "></script>
<!-- EChart -->
<script src="resources/js/diagrams/echarts.js"></script>

<br />
<br />
<br />

<footer>
    <div id="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3 text-center">
                    <p style="color: #F9F9F9;">Copyright 2016 山东大学数据新闻工作室 SDUDataNewStudio

                </div>
            </div>
        </div>
    </div>
</footer>
</body>

<script type="text/javascript">
    $(document).ready(function () {

        var axis = [
            <c:forEach items="${recommendation.axisData}" var="item">
                '<c:out value="${item}"/>',
            </c:forEach>
        ];

        var chart = echarts.init(document.getElementById('recommend-chart'));

        var option = {
            backgroundColor: '#fff',
            grid: {},
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            <c:if test='${!recommendation.chartTypes[0].equals("pie")}'>
                xAxis: {
                    type: 'category',
                    name: 'x',
                    splitLine: {
                        show: true
                    },
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        show: true
                    },
                    data: axis
                },
                yAxis: {
                    type: 'value',
                    name: 'y',
                    splitLine: {
                        show: true
                    },
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        show: true
                    }
                },
            </c:if>
            series: [
                <c:forEach items="${recommendation.data}" var="y">
                {
                    type: '<c:out value="${recommendation.chartTypes[0]}"/>',
                    symbolSize: 10,
                    data: [
                        <c:if test='${recommendation.chartTypes[0].equals("pie")}'>
                            <c:forEach items="${y}" var="item" varStatus="status">
                                {
                                    name: '<c:out value="${recommendation.axisData.get(status.index)}"/>',
                                    value: <c:out value="${item}"/>
                                },
                            </c:forEach>
                        </c:if>
                        <c:if test='${!recommendation.chartTypes[0].equals("pie")}'>
                            <c:forEach items="${y}" var="item">
                                <c:out value="${item}"/>,
                            </c:forEach>
                        </c:if>
                    ]
                },
                </c:forEach>
            ]
        };
        chart.setOption(option);
    });
</script>

</html>