<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <base href="../">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>分析结果</title>
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
<div style="height: 5em;"></div>
<div class="col-sm-3" style="text-align: right;">
    <label style="font-family: '微软雅黑';text-align:right ;font-size: 1.5em;">搜索关键词</label>
</div>
<div class="col-sm-9">
    <p style="margin-top: 0.5%;">(Input the key words you want to search for)</p>
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
            <input class="form-control" id="inputsearch" type="text" placeholder="输入关键词">
            <div class="col-sm-3">
                <a class="btn btn-info" style="font-family: '微软雅黑';font-size: 1em;margin-top: 10%;"
                   onclick="submitBtnClick()">搜索</a>
            </div>
        </div>
    </div>
</form>

<!--change width from 1600px to 85% | to suit different pc screen size-->
<div style="height: 500px;width: 85%;margin-top: 6%;margin-left: 8%;" id="Scatter"></div>

<!--add the words cloud picture  | to show key words of files-->
<div style="height: 500px;width: 85%;margin-top: 6%;margin-left: 8%;text-align: center" id="wordscloud"></div>

<div style="height: 500px;width: 85%;margin-top: 6%;margin-left: 8%;" id="rose"></div>

<!-- jQuery -->
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

<script type="text/javascript">
    $(document).ready(function () {
        var keywords = [
            <c:forEach items="${keywords}" var="keyword">
            {
                "text": "<c:out value="${keyword.key}"/>",
                "size": 50 + <c:out value="${keyword.value}"/> * 100
            },
            </c:forEach>
        ];

        var fill = d3.scale.category20();

        //append()使用函数在指定元素的结尾添加内容
        //transform:translate(x,y)  定义2d旋转，即平移，向右平移x,向下平移y 也就是设置词云在画布中的相对位置
        function draw(words) {
            d3.select("#wordscloud").append("svg")
                .attr("width", 1000)
                .attr("height", 500)
                .attr("style", "border:1px solid red")
                .append("g")
                .attr("transform", "translate(480,280)")
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

        d3.layout.cloud().size([1000, 500]) //size([x,y])  词云显示的大小 只能以px为单位
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
    $(document).ready(function(){

        var data = [
            <c:forEach items="${scatters}" var="scatter">
            [
                '<c:out value="${scatter[0]}"/>',
                <c:out value="${scatter[1]}"/>,
                '<c:out value="${scatter[2]}"/>'
            ],
            </c:forEach>
        ];

        var MyScatter= echarts.init(document.getElementById('Scatter'));

        var option = {

            backgroundColor: '#fff',
            grid:{},

            tooltip: {
                /*返回需要的信息*/
                formatter: function(param) {
                    var value = param.value;
                    return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 16px;padding-bottom: 7px;margin-bottom: 7px;"> ' + value[2] + '(' + value[1] + ')' +
                        '</div>';
                }
            },
            xAxis: {
                type:'time',
                name:'时间轴',
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
                type:'value',
                name:'情绪值',
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
                symbolSize: 40
            }]
        };
        MyScatter.setOption(option);

        //----------------------------------------------

        var Rose= echarts.init(document.getElementById('rose'));

        var sta1 =0 ;
        var sta2 =0 ;
        var sta3 =0 ;
        var sta4 =0 ;

        var val = 0;

        var len = data.length;

        for(var i=0;i<len;i++){

            val = data[i][1];
            if(-1 <= val && val <= -0.5 ){
                sta1++;
            }else if(-0.5 < val && val <= 0){
                sta2++;
            }else if(0 < val && val <= 0.5){
                sta3++;
            }else {
                sta4++;
            }

        }

        option = {
            title : {
                text: '南丁格尔玫瑰图',
                x:'center'
            },
            legend: {
                x : 'center',
                y : 'bottom',
                data:['negative(-1~-0.5)','light negative(-0.5~0)','light positive(0~0.5)','positive(0.5~1)']
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: ['pie', 'funnel']
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            series : [
                {
                    name:'半径模式',
                    type:'pie',
                    radius : [20, 110],
                    center : ['50%', '50%'],
                    roseType : 'radius',
                    label: {
                        normal: {
                            show: false
                        },
                        emphasis: {
                            show: true
                        }
                    },
                    lableLine: {
                        normal: {
                            show: false
                        },
                        emphasis: {
                            show: true
                        }
                    },
                    data:[
                        {value:sta1/len, name:'negative(-1~-0.5)'},
                        {value:sta2/len, name:'light negative(-0.5~0)'},
                        {value:sta3/len, name:'light positive(0~0.5)'},
                        {value:sta4/len, name:'positive(0.5~1)'}
                    ]
                }
            ]
        };
        Rose.setOption(option);
    });
</script>

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

</html>