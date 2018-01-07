<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>分析结果</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Template by FREEHTML5"/>
    <meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive"/>
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>

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

    <!-- Modernizr JS -->
    <script src="js/modernizr-2.6.2.min.js"></script>

    <script src="js/jquery.min.js"></script><!--可以没有jquery这个js-->
    <script src="js/d3.min.js"></script>
    <script src="js/d3.layout.cloud.js"></script>

    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div id="fh5co-header">
    <header id="fh5co-header-section">
        <div class="container">
            <div class="nav-header">
                <a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
                <h1 id="fh5co-logo" style="margin-top: 2.5%"><a href="index.html">Content<span>Analyzing</span></a></h1>
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

<div class="fh5co-hero fh5co-hero-2" style="height: 100px">
    <div class="fh5co-overlay" style="height: 100px"></div>
    <div class="fh5co-cover fh5co-cover_2 text-center" data-stellar-background-ratio="0.5"
         style="background-image: url(images/TABG.jpg);height: 100px">

    </div>
</div>


<div class="row" style="margin-top:6%;margin-bottom: 3%">
    <div class="col-sm-4"></div>
    <div class="col-sm-4" style="text-align: center;">
        <label style="font-family: '微软雅黑';text-align:center;font-size: 1.6em;">KEYWORDS SEARCHING</label>
    </div>
    <div class="col-sm-4"></div>
</div>


<script type="text/javascript">
    function submitBtnClick() {
        window.location.href = "result.html?page=1&term=" + encodeURIComponent($('#inputsearch').val());
    }
</script>

<form class="form-horizontal">
    <div class="form-group">
        <div class="col-sm-3"></div>
        <div class="col-sm-6">

            <!--这里是表单代码-->
            <input class="form-control" id="inputsearch" type="text" placeholder="Input a keyword">
            <div class="row" style="margin-top: 1%">
                <div class="col-sm-3"></div>
                <div class="col-sm-6" style="text-align: center">
                    <a class="btn btn-info" style="font-family: '微软雅黑';font-size: 1em;margin-top: 10%;"
                       onclick="submitBtnClick()">SEARCH</a>
                </div>
                <div class="col-sm-3"></div>

            </div>

        </div>
    </div>
</form>

<!--add the words cloud picture  | to show key words of files-->
<div style="text-align: center;margin-top: 10%;">
    <h2 style="font-family: '微软雅黑';margin-bottom: 1%">Keywords in News Texts</h2>
</div>

<div style="height: 500px;width: 85%;margin-left: 8%;text-align: center" id="wordscloud"></div>

<div style="text-align: center;margin-top: 5%;">
    <h2 style="font-family: '微软雅黑';margin-bottom: -5%">Sentiment Analysis</h2>
</div>
<div style="height: 500px;width: 80%;margin-top: 6%;margin-left: 12%;" id="Bar"></div>
<!--change width from 1600px to 85% | to suit different pc screen size-->
<div style="height: 500px;width: 80%;margin-top: 5%;margin-left: 12%;" id="Scatter"></div>


<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js "></script>
<!-- Bootstrap -->
<script src="js/bootstrap.min.js "></script>
<!-- Waypoints -->
<script src="js/jquery.waypoints.min.js "></script>
<!-- Stellar -->
<script src="js/jquery.stellar.min.js "></script>
<!-- Superfish -->
<script src="js/hoverIntent.js "></script>
<script src="js/superfish.js "></script>
<script src="js/bootstrap.fileinput.js "></script>
<!-- Main JS (Do not remove) -->
<script src="js/main.js "></script>
<script src="js/diagrams/echarts.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var keywords = [

            {
                "text": "决赛",
                "size": 50 + 0.008955223880597015 * 100
            },

            {
                "text": "C",
                "size": 50 + 0.030450669914738125 * 100
            },

            {
                "text": "球",
                "size": 50 + 0.02679658952496955 * 100
            },

            {
                "text": "法国",
                "size": 50 + 0.01616161616161616 * 100
            },

            {
                "text": "精神病",
                "size": 50 + 0.01380897583429229 * 100
            },

            {
                "text": "辆",
                "size": 50 + 0.01532567049808429 * 100
            },

            {
                "text": "俄罗斯",
                "size": 50 + 0.010101010101010102 * 100
            },

            {
                "text": "万",
                "size": 50 + 0.02967359050445104 * 100
            },

            {
                "text": "月",
                "size": 50 + 0.0111731843575419 * 100
            },

            {
                "text": "边防",
                "size": 50 + 0.017482517482517484 * 100
            },

            {
                "text": "三",
                "size": 50 + 0.012269938650306749 * 100
            },

            {
                "text": "公路",
                "size": 50 + 0.005747126436781609 * 100
            },

            {
                "text": "手",
                "size": 50 + 0.0081799591002045 * 100
            },

            {
                "text": "涅夫",
                "size": 50 + 0.006060606060606061 * 100
            },

            {
                "text": "死亡",
                "size": 50 + 0.009578544061302681 * 100
            },

            {
                "text": "某某",
                "size": 50 + 0.011507479861910242 * 100
            },

            {
                "text": "跌",
                "size": 50 + 0.02967359050445104 * 100
            },

            {
                "text": "名",
                "size": 50 + 0.01870480172738801 * 100
            },

            {
                "text": "医院",
                "size": 50 + 0.015645746658404888 * 100
            },

            {
                "text": "患者",
                "size": 50 + 0.02186421173762946 * 100
            },

            {
                "text": "苏",
                "size": 50 + 0.023880597014925373 * 100
            },

            {
                "text": "巴黎",
                "size": 50 + 0.010101010101010102 * 100
            },

            {
                "text": "朝鲜",
                "size": 50 + 0.017985611510791366 * 100
            },

            {
                "text": "道",
                "size": 50 + 0.02158273381294964 * 100
            },

            {
                "text": "事故",
                "size": 50 + 0.013409961685823755 * 100
            },

            {
                "text": "罗",
                "size": 50 + 0.03654080389768575 * 100
            },

            {
                "text": "战",
                "size": 50 + 0.01791044776119403 * 100
            },

            {
                "text": "发射",
                "size": 50 + 0.02877697841726619 * 100
            },

            {
                "text": "地震",
                "size": 50 + 0.01048951048951049 * 100
            },

            {
                "text": "女孩",
                "size": 50 + 0.024539877300613498 * 100
            },

            {
                "text": "洛宁县",
                "size": 50 + 0.014959723820483314 * 100
            },

            {
                "text": "发生",
                "size": 50 + 0.009578544061302681 * 100
            },

            {
                "text": "运动员",
                "size": 50 + 0.013966480446927373 * 100
            },

            {
                "text": "女足",
                "size": 50 + 0.029850746268656716 * 100
            },

            {
                "text": "足协杯",
                "size": 50 + 0.011940298507462687 * 100
            },

            {
                "text": "中",
                "size": 50 + 0.017482517482517484 * 100
            },

            {
                "text": "治疗",
                "size": 50 + 0.01048951048951049 * 100
            },

            {
                "text": "公斤",
                "size": 50 + 0.013966480446927373 * 100
            },

            {
                "text": "年",
                "size": 50 + 0.02249266802305405 * 100
            },

            {
                "text": "债券",
                "size": 50 + 0.008902077151335312 * 100
            },

            {
                "text": "导弹",
                "size": 50 + 0.017985611510791366 * 100
            },

            {
                "text": "人",
                "size": 50 + 0.022494887525562373 * 100
            },

            {
                "text": "场",
                "size": 50 + 0.013398294762484775 * 100
            },

            {
                "text": "债",
                "size": 50 + 0.02373887240356083 * 100
            },

            {
                "text": "航展",
                "size": 50 + 0.012121212121212121 * 100
            },

            {
                "text": "飞行",
                "size": 50 + 0.02877697841726619 * 100
            },

            {
                "text": "达",
                "size": 50 + 0.03560830860534125 * 100
            },

        ];

        var fill = d3.scale.category20();

        //append()使用函数在指定元素的结尾添加内容
        //transform:translate(x,y)  定义2d旋转，即平移，向右平移x,向下平移y 也就是设置词云在画布中的相对位置
        function draw(words) {
            d3.select("#wordscloud").append("svg")
                .attr("width", 800)
                .attr("height", 400)
                .attr("style", "border:1px solid red")
                .append("g")
                .attr("transform", "translate(390,210)")
                .selectAll("text")
                .data(words)
                .enter().append("text")
                .style("border", "1px solid blue")
                .style("font-size", function (d) {
                    return d.size + "px";
                })
                .style("font-family", "Impact")
                .style("fill", function (d, i) {
                    return fill(i);
                })//fill 在前面15行定义为颜色集
                .attr("text-anchor", "middle")
                .attr("transform", function (d) {
                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                })
                .text(function (d) {
                    return d.text;
                });
        }

        d3.layout.cloud().size([800, 400]) //size([x,y])  词云显示的大小 只能以px为单位
            .words(keywords)
            //~~的作用是单纯的去掉小数部分，不论正负都不会改变整数部分
            //这里的作用是产生0 1
            .rotate(function () {
                return ~~(Math.random() * 2) * 90;
            })
            .font("Impact")
            .fontSize(function (d) {
                return d.size;
            })
            .on("end", draw)//结束时运行draw函数
            .start();
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {

        var data = [

            [
                '2017-04-05 07:02:00',
                0.9947093760814028,
                '韩国军方：朝鲜今晨发射1枚弹道导弹 飞行距离约60公里'
            ],

            [
                '2017-06-23',
                0.9999999999290421,
                '﻿白沙女孩不幸溺水 同伴施救致3人同时溺亡'
            ],

            [
                '2017-06-22',
                0.9989824480395064,
                '俄代表团团长巴黎航展期间遭抢劫 法方表示遗憾'
            ],

            [
                '2017-04-01 19:57',
                -0.5913626456902517,
                '河南一精神病院患者用筷子袭击女患者，致三死一重伤'
            ],

            [
                '2017-06-23',
                -0.6718668892830519,
                '﻿巴西发生一起严重连环车祸 已致21死22伤'
            ],

            [
                '2017-06-23',
                0.9999998138286403,
                '﻿我省运动员黄婷举重世青赛夺冠'
            ],

            [
                '2017-06-22',
                0.9999999999999996,
                '﻿苏宁女足足协杯强势夺冠'
            ],

            [
                '2017-06-22',
                1.0,
                '﻿汶川地震“最悲惨女孩”探访边防“亲人”'
            ],

            [
                '2017-06-21',
                -0.166240255006457,
                '还有谁!C罗连续8届世界大赛破门,足球史上第1'
            ],

            [
                '2017-06-22',
                -0.9423803539175879,
                '万达多只债券大跌，万达电影股价跌9.87%逼近跌停'
            ],

        ];

        var MyScatter = echarts.init(document.getElementById('Scatter'));

        var option = {

            backgroundColor: '#fff',
            grid: {},

            tooltip: {
                /*返回需要的信息*/
                formatter: function (param) {
                    var value = param.value;
                    return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 16px;"> ' + value[2] + '(' + value[1] + ')' +
                        '</div>';
                }
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {
                        show: true,
                        type: ['bar']
                    },
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            xAxis: {
                type: 'time',
                name: 'TimeLine',
                splitLine: {
                    show: true,
                },
                axisTick: {
                    show: false
                },
                axisLabel: {
                    show: true,
                }
            },
            yAxis: {
                type: 'value',
                name: 'Value of Sentiment',
                splitLine: {
                    show: false,
                },
                axisLabel: {
                    show: true,
                },
                axisTick: {
                    show: false
                },
                max: 1,
                min: -1,
            },
            series: [{
                name: '',
                data: data,
                type: 'scatter',
                symbolSize: 35
            }]
        };
        MyScatter.setOption(option);

        //----------------------------------------------

        var Bar = echarts.init(document.getElementById('Bar'));

        var sta1 = 0;
        var sta2 = 0;
        var sta3 = 0;
        var sta4 = 0;

        var val = 0;

        var len = data.length;

        for (var i = 0; i < len; i++) {

            val = data[i][1];
            if (-1 <= val && val <= -0.5) {
                sta1++;
            } else if (-0.5 < val && val <= 0) {
                sta2++;
            } else if (0 < val && val <= 0.5) {
                sta3++;
            } else {
                sta4++;
            }

        }

        option = {
//            title: {
//                //text: 'Emotion Analyzing',
//               // x: 'center'
//            },
            itemStyle: {
                normal: {
                    color: function (params) {
                        //首先定义一个数组
                        var colorList = [
                            '#668B8B', '#96CDCD', '#FF8C69', '#CD2626'
                        ];
                        return colorList[params.dataIndex]
                    }
                }
            },
            legend: {
                show: true,
                x: 'center',
                y: 'bottom',
                data: ['negative(-1~-0.5)', 'light negative(-0.5~0)', 'light positive(0~0.5)', 'positive(0.5~1)']
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {
                        show: true,
                        type: ['bar']
                    },
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
//            xAxis:{
//                data:[
//                    value:['negative(-1~-0.5)', 'light negative(-0.5~0)', 'light positive(0~0.5)', 'positive(0.5~1)'],
//
//              ]},
            xAxis: {
                data: ['negative(-1~-0.5)', 'light negative(-0.5~0)', 'light positive(0~0.5)', 'positive(0.5~1)'],
            },
            yAxis: [
                {
                    type: 'value'
                }

            ],
            calculable: true,
            series: [
                {
                    name: 'Emotion Analyzing',

                    type: 'bar',
                    barWidth: '40%',
                    data: [sta1 / len, sta2 / len, sta3 / len, sta4 / len]
                }

            ]
        };
        Bar.setOption(option);
    });
</script>
<script type="text/javascript" src="js/jquery.form.js"></script>
</br>
</br>
</br>

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

</html>