(function ($) {
    var ajax = $.ajax;

    $.ajax = function (options) {
        var jqXHR;
        if ($.isFunction(options.message)) {
            if ($.isFunction(options.xhr)) {
                options._xhr = options.xhr;
            }
            options.xhr = function () {
                try {
                    var xmlhttp = $.isFunction(this._xhr) ? this._xhr() : new XMLHttpRequest();

                    var self = this;
                    xmlhttp.streaming = {
                        oldResponseLength: 0
                    };

                    var hexdec = function (hex_string) {
                        hex_string = (hex_string + '').replace(/[^a-f0-9]/gi, '');
                        return parseInt(hex_string, 16);
                    };

                    /**
                     * 将HTTP协议中定义分块大小的长度部分移除
                     *
                     * @see http://zh.wikipedia.org/wiki/%E5%88%86%E5%9D%97%E4%BC%A0%E8%BE%93%E7%BC%96%E7%A0%81
                     * @param data
                     * @returns string
                     */
                    var format = function (data) {
                        if (data === "0\r\n\r\n") return '';   //分块输出结束符

                        data = $.trim(data);
                        var d = data.indexOf("\r\n");
                        if (d) {
                            var len = hexdec(data.substr(0, d));

                            if (len > 0 && len + 2 + d === data.length) {
                                data = data.substr(d + 2);
                            }
                        }

                        return data;
                    };

                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState === 3) {
                            var data = this.responseText;
                            if (this.streaming.oldResponseLength > 0) {
                                data = data.substr(this.streaming.oldResponseLength);
                            }
                            this.streaming.oldResponseLength = this.responseText.length;

                            data = format(data);
                            if (data.length > 0) {
                                jqXHR.currentResponseText = data;
                                self.message.call(self, jqXHR, 'stream');
                            }
                        }
                    };
                    return xmlhttp;
                } catch (e) {
                }
            };

            var obs = null;
            if ($.isFunction(options.beforeSend)) {
                obs = options.beforeSend;
            }

            options.beforeSend = function (xhr) {
                jqXHR = xhr;
                if (obs) return obs.apply(this, arguments);
            };
        }

        return ajax(options);
    }
})(jQuery);