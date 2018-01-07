<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=emulateIE7"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Keywords Searching</title>
    <link href="css/Search/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/Search/style.css" rel="stylesheet" type="text/css"/>
    <link href="css/Search/result.css" rel="stylesheet" type="text/css"/>
    <link href="css/Search/animate.min.css" rel="stylesheet" type="text/css"/>

</head>

<body>




<div id="hd" class="ue-clear">
    <div>

        <script type="text/javascript">
            function submitBtnClick() {
                window.location.href = "result.html?page=1&term=" + encodeURIComponent($('#inputsearch').val());
            }
        </script>

        <div class="form-group">
            <div class="col-sm-3"></div>
            <div class="col-sm-5" style="text-align: center">
                <!--这里是表单代码-->
                <input class="form-control" id="inputsearch" type="text" placeholder="Input a keyword">

            </div>
            <div class="col-sm-2" style="text-align: left">
                <a class="btn btn-info" style="font-family: '微软雅黑';font-size: 1em;margin-top: 1%;"
                   onclick="submitBtnClick()">SEARCH</a>
            </div>
            <div class="col-sm-2"></div>
        </div>
    </div>
</div>

<div class="sideBarShowHide">
    <a href="javascript:;" class="icon"></a>
</div>
</div>
<div class="resultArea">
    <p class="resultTotal">
        <span class="info">found&nbsp;<span id="result_count" class="totalResult">0</span>&nbsp;results，about<span
                id="result_page" class="totalPage">0</span>page</span>
        <span class="orderOpt">
                    	<a href="javascript:;" class="byTime">sorted by time</a>
                        <a href="javascript:;" class="byDependence">Sort by correlation</a>
                    </span>
    </p>
    <div id="result_list" class="resultList">

    </div>
</div>
<!-- 分页 -->
<div class="pagination ue-clear"></div>
<!-- 相关搜索 -->

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

            <div class="modal-content" style="padding-top: 0em;background: #F5F5F5;">

                <p id="modal_abstract" style="text-align: left; padding-top: 1.5em;font-size: 1.5em">
                    Abstract：
                </p>
                </br>

                <p id="modal_content" style="text-align: left;font-size: 1.5em">
                    Original Text：
                </p>
            </div>

        </div>
    </div>
</div>

</div>
<!-- End of main -->
</div>
<!--End of bd-->
</div>

<div id="template" class="hidden resultItem">
    <div class="itemHead">
        <a id="title" href="JavaScript:void(0);" onclick="modalShow('#bigModal', '', modalDataInit, 0);" target="_blank"
           class="title">{title}</a> <span class="divsion">-</span>
        <span class="fileType">
                            	<span>关键词(KeyWords)：</span>
						<span id="keywords" class="value">{keywords}</span>
						</span>
        <span class="dependValue">
                            	<span>情绪值：</span>
						<span id="sentiment" class="value">{sentiment}</span>
						</span>
    </div>
    <div id="content" class="itemBody">
        {content}
    </div>
    <div class="itemFoot">
						<span class="info">
                            	<label>发布时间：</label>
                                <span id="time" class="value">{time}</span>
						</span>
    </div>
</div>

<script src="js/Search/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/Search/global.js"></script>
<script type="text/javascript" src="js/Search/pagination.js"></script>
<script type="text/javascript" src="js/Search/bootstrap.min.js"></script>
<script type="text/javascript" src="js/Search/Pop.js"></script>
<script>
    function GetQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    }

    var term = GetQueryString("term");
    var page = GetQueryString("page");
    $("#inputsearch").val(term);
    if (page == undefined) {
        page = 1;
    }
    $.ajax({
        url: 'http://localhost/nlp_api/public/search',
        type: 'get',
        data: {'term': term, 'page': page},
        dataType: 'json',
        xhrFields: {
            withCredentials: true
        },
        success: function (data) {
            var tpl = $("#template");
            var resultList = $("#result_list");
            var reg = new RegExp("(" + term + ")", "gi");
            $("#result_count").html(data['count']);
            $("#result_page").html(data['count'] / 10);
            for (var item in data['result']) {
                var template = tpl.clone(true, true);
                template.removeClass("hidden");
                template.find("#title").attr('onclick', "modalShow('#bigModal', '', modalDataInit, '" + data['result'][item]['name'] + "');");
                template.find("#title").html(data['result'][item]['title'].replace(reg, "<span class='keyWord'>$1</span>"));
                template.find("#keywords").html(data['result'][item]['keywords'].toString().replace(reg, "<span class='keyWord'>$1</span>"));
                template.find("#sentiment").html(data['result'][item]['sentiment']);
                template.find("#content").html(data['result'][item]['content'].replace(reg, "<span class='keyWord'>$1</span>"));
                template.find("#time").html(data['result'][item]['time']);
                resultList.append(template);
            }

            //分页
            $(".pagination").pagination(data['count'], {
                current_page: page - 1, //当前页码
                items_per_page: 10,
                display_msg: true,
                callback: function (page_id, jq) {
                    window.location.href = "result.html?page=" + (page_id + 1) + "&term=" + encodeURIComponent(term);
                }
            });
        },
        error: function (request, status) {
            alert("TODO 发生错误：" + request.responseText);
        }
    });
</script>
</body>


<script type="text/javascript">
    $('.searchList').on('click', '.searchItem', function () {
        $('.searchList .searchItem').removeClass('current');
        $(this).addClass('current');
    });

    $.each($('.subfieldContext'), function (i, item) {
        $(this).find('li:gt(2)').hide().end().find('li:last').show();
    });

    $('.subfieldContext .more').click(function (e) {
        var $more = $(this).parent('.subfieldContext').find('.more');
        if ($more.hasClass('show')) {

            if ($(this).hasClass('define')) {
                $(this).parent('.subfieldContext').find('.more').removeClass('show').find('.text').text('自定义');
            } else {
                $(this).parent('.subfieldContext').find('.more').removeClass('show').find('.text').text('更多');
            }
            $(this).parent('.subfieldContext').find('li:gt(2)').hide().end().find('li:last').show();
        } else {
            $(this).parent('.subfieldContext').find('.more').addClass('show').find('.text').text('收起');
            $(this).parent('.subfieldContext').find('li:gt(2)').show();
        }

    });

    $('.sideBarShowHide a').click(function (e) {
        if ($('#main').hasClass('sideBarHide')) {
            $('#main').removeClass('sideBarHide');
            $('#container').removeClass('sideBarHide');
        } else {
            $('#main').addClass('sideBarHide');
            $('#container').addClass('sideBarHide');
        }

    });

    setHeight();
    $(window).resize(function () {
        setHeight();
    });

    function setHeight() {
        if ($('#container').outerHeight() < $(window).height()) {
            $('#container').height($(window).height() - 33);
        }
    }
</script>


</html>