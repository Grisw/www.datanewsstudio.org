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
    <title>文本分析工具</title>
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
    <link rel="stylesheet" href="resources/css/text_analyzing.css"/>
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
                        <h1 id="fh5co-logo"><a href="index.jsp">Data<span>news</span></a></h1>
                        <!-- START #fh5co-menu-wrap -->
                        <nav id="fh5co-menu-wrap" role="navigation">
                            <ul class="sf-menu" id="fh5co-primary-menu">
                                <li>
                                    <a href="index.jsp">主页</a>
                                </li>
                                <li>
                                    <a href="portfolio.html" class="fh5co-sub-ddown">数据新闻</a>
                                </li>
                                <li class="active">
                                    <a href="#" class="fh5co-sub-ddown">分析工具</a>
                                </li>
                                <li>
                                    <a href="about.html">HistoryMap</a>
                                </li>
                                <li>
                                    <a href="blog.html">模板</a>
                                </li>
                                <li>
                                    <a href="contact.html">关于我们</a>
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
                    <h2 style="font-family: '微软雅黑',sans-serif;letter-spacing: 0.1em;font-size: 2.8em;">文本分析工具</h2>
                    <span style="font-size: 2.4em;letter-spacing: 0.1em">Text Analyzing</span>
                </div>
            </div>
        </div>
        <!-- end:header-top -->

        <div class="row row-bottom-padded-lg" style="margin-top: 12%;">
            <div class="col-md-3 "></div>
            <div class="col-md-6 " style="text-align: center;">
                <label class="control-label" style="font-size: 2.5em; margin-bottom: 0;">UPLOAD NEWS</label>
                <p style="font-size:1em;font-family: '微软雅黑',sans-serif;margin-bottom: 0;">请按照规定的txt格式上传</p>
                <p style="font-size:1em;font-family: '微软雅黑',sans-serif;">(Please follow the specific txt format)</p>

                <form id="fileinput" enctype="multipart/form-data" method="post">
                    <div>
                        <h4 class="center-block">选择语言(Choose Language)</h4>
                        <select name="lang" class="form-control center-block" style="width: 15%;margin-bottom: 5%;">
                            <option value="zh-cn">中文</option>
                            <option value="en">English</option>
                        </select>
                    </div>
                    <input id="input-6" name="files" type="file" multiple class="file-loading"
                           style="text-align: center;">
                </form>

                <!-- 这里是文件上传-->

                <div style="text-align:center;">
                    <button type="button" class="btn btn-info"
                            style="margin-top: 8%;margin-bottom:5%;font-family: '微软雅黑',sans-serif;font-size: 1.1em;"
                            onclick="upload()">开始分析
                    </button>
                </div>
            </div>
        </div>

        <div class="row" style="margin-bottom:15%;">
            <div class="col-md-4"></div>
            <div class="col-md-4 col-sm-2">
                <div class="fh5co-grid animate-box" style="background-image: url(resources/img/summary.jpg);">
                    <a class="image-popup text-center" href="http://121.250.213.32/">
                    </a>
                </div>
            </div>
        </div>


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
<script src="resources/js/jquery.form.js"></script>
<!-- Stellar -->
<script src="resources/js/jquery.stellar.min.js "></script>
<!-- Superfish -->
<script src="resources/js/hoverIntent.js "></script>
<script src="resources/js/superfish.js "></script>
<script src="resources/js/bootstrap.fileinput.min.js "></script>
<!-- Main JS (Do not remove) -->
<script src="resources/js/main.js "></script>
<script src="resources/js/filein.js"></script>

</body>

</html>