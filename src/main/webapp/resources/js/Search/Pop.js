    
    $(document).ready(function(){
    $.fn.extend({
            animateCss: function (animationName) {
                var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
                this.addClass('animated ' + animationName).one(animationEnd, function() {
                    $(this).removeClass('animated ' + animationName);
                });
            }
        });
        
        /**
         * 显示模态框方法
         * @param targetModel 模态框选择器，jquery选择器
         * @param animateName 弹出动作
         * @ callback 回调方法
         */
        modalShow = function(targetModel, animateName, callback, arg){
            var animationIn = "bounceInDown";
            if(!animateName || animationIn.indexOf(animateName)==-1){
                console.log(animationIn.length);
                var intRandom =  Math.floor(Math.random()*animationIn.length);
                animateName = animationIn;
            }
            console.log(targetModel + " " + animateName);
            $(targetModel).show().animateCss(animateName);
            if(callback != undefined)
            	callback.call(this, arg);
        }
        /**
         * 隐藏模态框方法
         * @param targetModel 模态框选择器，jquery选择器
         * @param animateName 隐藏动作
         * @ callback 回调方法
         */
        modalHide = function(targetModel, animateName, callback){
            var animationOut = "bounceOutUp";

            if(!animateName || animationOut.indexOf(animateName)==-1){
                console.log(animationOut.length);
                var intRandom =  Math.floor(Math.random()*animationOut.length);
                animateName = animationOut;
            }
            $(targetModel).children().click(function(e){e.stopPropagation()});
            $(targetModel).animateCss(animateName);
            $(targetModel).delay(900).hide(1,function(){
                $(this).removeClass('animated ' + animateName);
            });
            if(callback != undefined)
            	callback.call(this);
        }

        modalDataInit = function(name){
            $.ajax({
                url: 'http://localhost/nlp_api/public/content',
                type:'post',
                data:{'name':name},
                dataType:'json',
                xhrFields: {
                    withCredentials: true
                },
                success:function (data) {
                    $('#modal_title').html(data['title']);
                    $('#modal_time').html("发布时间："+data['time']);
                    $('#modal_keywords').html("关键词："+data['keywords'].toString());
                    $('#modal_abstract').html("        文章摘要："+data['abstract']);
                    $('#modal_content').html("        原文文本："+data['content']);
                },
                error:function (request,status) {
                    alert("TODO 发生错误："+request.responseText);
                }
            });
        }
        });