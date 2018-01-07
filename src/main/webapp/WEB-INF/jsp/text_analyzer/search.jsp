<%@ page import="org.datanewsstudio.www.common.Urls" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <base href="../">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Keywords Searching</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

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

<form class="form-horizontal" style="margin-top:3%;">
    <div class="form-group">
        <div class="col-sm-3"></div>
        <div class="col-sm-5" style="text-align: center">
            <!--这里是表单代码-->
            <input class="form-control" id="inputsearch" type="text" placeholder="Input a keyword">

        </div>
        <div class="col-sm-2" style="text-align: left">
            <a class="btn btn-info" style="font-family: '微软雅黑';font-size: 1em;margin-top: 1%;"
               onclick="searchresult(1)">SEARCH</a>
        </div>
        <div class="col-sm-2"></div>
    </div>
</form>

<div style="padding: 2%">
    <div class="resultArea">
        <div class="resultList">
            <c:forEach items="${result}" var="item">
                <div id="template" class="resultItem">
                    <div class="itemHead">
                        <a id="title" href="JavaScript:void(0);" onclick="modalShow('#bigModal', '', modalDataInit, '${item.filename}', '<%=Urls.TextAnalyzer.content%>');" target="_blank"
                           class="title">${item.title}</a> <span class="divsion">-</span>
                        <span class="fileType">
                                    <span>Keywords: </span>
                            <span id="keywords" class="value">
                                <c:forEach items="${item.keywords}" var="keyword">
                                    <c:out value="${keyword};"/>
                                </c:forEach>
                            </span>
                        </span>
                        &nbsp;&nbsp;
                        <span class="dependValue">
                                    <span>Sentiment: </span>
                            <span id="sentiment" class="value">${item.sentiment}</span>
                        </span>
                    </div>
                    <div id="content" class="itemBody">
                            ${item.content}
                    </div>
                    <div class="itemFoot">
                            <span class="info">
                                    <label>Public Time: </label>
                                    <span id="time" class="value">${item.time}</span>
                            </span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 分页 -->
    <div class="pagination"></div>

</div>

<div class="modal bs-example-modal-lg" onclick="modalHide('#bigModal', '');" id="bigModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" onclick="modalHide('#bigModal', '');" class="close" data-dismiss="modal"><span
                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 id="modal_title" class="modal-title" style="font-size: 2.2em;text-align: center;">Title</h4>
                <p id="modal_time" style="margin-top:1%;text-align: center;font-size: 1.2em;">
                    Public Time：
                </p>
                <p id="modal_keywords" style=";margin-top:0.8%;text-align: center;font-size: 1.2em">
                    Keywords：
                </p>
            </div>

            <div class="modal-content" style="padding-top: 0;background: #F5F5F5;overflow: scroll;height: 600px;">

                <p id="modal_abstract" style="text-align: left; padding-top: 1.5em;font-size: 1.5em">
                    Abstract：
                </p>
                <br/>

                <p id="modal_content" style="text-align: left;font-size: 1.5em">
                    Original Text：
                </p>
            </div>

        </div>
    </div>
</div>

</body>

<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="resources/js/jquery.easing.1.3.js " type="text/javascript"></script>
<!-- Waypoints -->
<script src="resources/js/jquery.waypoints.min.js " type="text/javascript"></script>
<!-- Stellar -->
<script src="resources/js/jquery.stellar.min.js " type="text/javascript"></script>
<!-- Superfish -->
<script src="resources/js/hoverIntent.js " type="text/javascript"></script>
<script src="resources/js/superfish.js " type="text/javascript"></script>
<!-- Main JS (Do not remove) -->
<script src="resources/js/main.js " type="text/javascript"></script>
<script type="text/javascript" src="resources/js/pagination.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/pop.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        function GetQueryString(name) {
            var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)');
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return decodeURIComponent(r[2]);
            return null;
        }

        var term = GetQueryString("term");
        var page = GetQueryString("page");
        $("#inputsearch").val(term);
        if (!page) {
            page = 1;
        }

        $(".pagination").bsPagination({
            totalRecord: <c:out value="${totalHits}"/>,
            recordPerPage: <c:out value="${resultPerPage}"/>,
            currentPage: page,
            setLinkAttr: function (p) {
                return 'href="javascript:searchresult('+p+')"';
            }
        });
    });
</script>

<script type="text/javascript">
    function searchresult(page) {
        var keyword = $('#inputsearch').val();
        if (keyword && keyword.trim().length > 0) {
            page = page && page >=1?page : 1;
            window.location.href = '<%=Urls.TextAnalyzer.search%>?page='+page+'&lang=<c:out value="${lang}"/>&keyword=' + keyword;
        }
    }
</script>

</html>