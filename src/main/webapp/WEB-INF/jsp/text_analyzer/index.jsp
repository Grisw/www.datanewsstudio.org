<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>News Text Analyzing</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Template by FREEHTML5"/>
    <meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive"/>

    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content=""/>
    <meta name="twitter:image" content=""/>
    <meta name="twitter:url" content=""/>
    <meta name="twitter:card" content=""/>

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <link rel="shortcut icon" href="favicon.ico">

    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,300' rel='stylesheet' type='text/css'>

    <!-- Animate.css -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="css/icomoon.css">
    <!-- Bootstrap  -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Superfish -->
    <link rel="stylesheet" href="css/superfish.css">

    <link rel="stylesheet" href="css/style.css">

    <link rel="stylesheet" href="css/fileinput.min.css">
    <link rel="stylesheet" type="text/css" href="css/text_analyzing.css"/>
    <script src="js/jquery.js"></script>
    <!-- Modernizr JS -->
    <script src="js/modernizr-2.6.2.min.js"></script>

    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        li {
            font-family: "微软雅黑";
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
                        <h1 id="fh5co-logo"><a href="index.html">Content<span>Analyzing</span></a></h1>
                        <!-- START #fh5co-menu-wrap -->
                        <nav id="fh5co-menu-wrap" role="navigation">
                            <ul class="sf-menu" id="fh5co-primary-menu">
                                <li>
                                    <a href="index.html">HOME</a>
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
                 style="background-image: url(images/TABG.jpg);">
                <div class="desc animate-box">
                    <h2 style="font-family: '微软雅黑';letter-spacing: 0.1em;font-size: 2.2em;margin-top: 4%">NEWS TEXT
                        ANALYZING</h2>

                </div>
            </div>
        </div>
        <!-- end:header-top -->

        <div id="fh5co-work-section" style="margin-top: 1%">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center heading-section animate-box" style="margin-bottom: 2%">
                        <h1 style="font-family: '微软雅黑';margin-bottom: 1%;">UPLOAD NEWS</h1>
                    </div>
                </div>
            </div>
            <div class="row row-bottom-padded-lg">

                <div class="col-md-3 "></div>
                <div class="col-md-6 " style="text-align: center;">
                    <p style="font-size:1.4em;font-family: '微软雅黑';margin-bottom: -1%" >please follow the specific txt format</p>
                    <a href="text_analyzing.html" style="font-size: 1.1em;"> click here to get a sample format</a>
                    <form id="fileinput" enctype="multipart/form-data" method="post">
                        <div style="margin-top: 5%">
                            <!--<h4 class="center-block">Choose a Language</h4>-->
                            <select name="lang" class="form-control center-block" style="width: 15%;margin-bottom: 5%;">
                                <option value="en">English</option>
                                <option value="zh-CN">中文</option>

                            </select>
                        </div>
                        <input id="input-6" name="files[]" type="file" multiple class="file-loading"
                               style="text-align: center;">
                    </form>

                    <!-- 这里是文件上传-->

                    <div style="text-align:center;">
                        <button type="button" class="btn btn-info"
                                style="margin-top: 10%;margin-bottom:3%;font-family: '微软雅黑';font-size: 1.1em;"
                                onclick="upload()">Start Analyzing
                        </button>
                    </div>
                </div>
            </div>


        </div>
        <!-- END fh5co-page -->



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
    <!-- END fh5co-wrapper -->
    <!-- jQuery -->

    <script src="js/jquery.min.js "></script>

    <!-- jQuery Easing -->

    <script src="js/jquery.easing.1.3.js "></script>
    <!-- Bootstrap -->
    <script src="js/bootstrap.min.js "></script>
    <!-- Waypoints -->
    <script src="js/jquery.waypoints.min.js "></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>
    <!-- Stellar -->
    <script src="js/jquery.stellar.min.js "></script>
    <!-- Superfish -->
    <script src="js/hoverIntent.js "></script>
    <script src="js/superfish.js "></script>
    <script src="js/bootstrap.fileinput.js "></script>
    <!-- Main JS (Do not remove) -->
    <script src="js/main.js "></script>
    <script src="js/diagrams/FileIn.js"></script>

</body>

</html>