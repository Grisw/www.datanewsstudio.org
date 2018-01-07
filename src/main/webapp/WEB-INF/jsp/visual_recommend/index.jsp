<%@ page import="org.datanewsstudio.www.common.Urls" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
    <base href="../">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Visualization Recommendation</title>
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
    <link rel="stylesheet" href="resources/css/fileinput.min.css">
    <link rel="stylesheet" href="resources/css/handsontable.full.min.css">
    <!-- Modernizr JS -->
    <script src="resources/js/modernizr-2.6.2.min.js"></script>

    <!--[if lt IE 9]>
    <script src="/resources/js/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        li {
            font-family: "微软雅黑", sans-serif;
        }
    </style>
</head>

<body>
<div id="fh5co-wrapper">
    <div id="fh5co-page">
        <div id="fh5co-header">
            <header id="fh5co-header-section">
                <div class="container">
                    <div class="nav-header">
                        <a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
                        <h1 id="fh5co-logo"><a href="<%=Urls.index%>">Content<span>Analyzing</span></a></h1>
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

        <div class="fh5co-hero fh5co-hero-2">
            <div class="fh5co-overlay"></div>
            <div class="fh5co-cover fh5co-cover_2 text-center" data-stellar-background-ratio="0.5"
                 style="background-image: url(resources/img/TABG.jpg);">
                <div class="desc animate-box">
                    <h2 style="font-family: '微软雅黑',sans-serif;letter-spacing: 0.1em;font-size: 2.2em;margin-top: 4%">VISUALIZATION RECOMMENDATION</h2>

                </div>
            </div>
        </div>
        <!-- end:header-top -->

        <div id="fh5co-work-section" style="margin-top: 1%">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center heading-section animate-box" style="margin-bottom: 2%">
                        <h1 style="font-family: '微软雅黑',sans-serif;margin-bottom: 1%;">UPLOAD DATA</h1>
                    </div>
                </div>
            </div>
            <div class="row">

                <div class="col-md-3 "></div>
                <div class="col-md-6 " style="text-align: center;">
                    <p style="font-size:1.4em;font-family: '微软雅黑',sans-serif;margin-bottom: -1%" >please follow the specific xls/xlsx format</p>
                    <a href="todo" style="font-size: 1.1em;">click here to get a sample format</a>
                    <div style="margin-top: 5%;">
                        <input id="input-6" name="files" type="file" class="file-loading" style="text-align: center;">
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
            <div class="row row-bottom-padded-lg">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div id="table" style="overflow: auto; height: 600px; width: 100%;margin-top: 5%"></div>

                    <div style="text-align:center;">
                        <button type="button" class="btn btn-info"
                                style="margin-top: 5%;margin-bottom:3%;font-family: '微软雅黑',sans-serif;font-size: 1.1em;"
                                onclick="todo">Start Analyzing
                        </button>
                    </div>
                </div>
                <div class="col-md-2"></div>
            </div>

        </div>
        <!-- END fh5co-page -->



        <footer>
            <div id="footer">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3 text-center">
                            <p style="color: #F9F9F9;">Copyright 2016 山东大学数据新闻工作室 SDUDataNewStudio</p>

                        </div>
                    </div>
                </div>
            </div>
        </footer>

    </div>
    <!-- END fh5co-page -->

</div>
<!-- END fh5co-wrapper -->

<!-- jQuery -->
<script src="resources/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="resources/js/jquery.easing.1.3.js "></script>
<!-- jQuery Chunked -->
<script src="resources/js/plugins/jquery.chunked.js "></script>
<!-- Bootstrap -->
<script src="resources/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="resources/js/jquery.waypoints.min.js"></script>
<!-- Stellar -->
<script src="resources/js/jquery.stellar.min.js "></script>
<!-- Superfish -->
<script src="resources/js/hoverIntent.js "></script>
<script src="resources/js/superfish.js "></script>
<script src="resources/js/bootstrap.fileinput.min.js "></script>
<script src="resources/js/handsontable.full.min.js "></script>
<script src="resources/js/xlsx.full.min.js "></script>
<!-- Main JS (Do not remove) -->
<script src="resources/js/main.js "></script>
<script src="resources/js/visualrecommend.js "></script>

</body>

</html>