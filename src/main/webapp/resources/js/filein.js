$(document).ready(function () {
    $("#input-6").fileinput({
        showUpload: false,
        maxFileCount: 2000,
        allowedFileExtensions : ['txt'],
        allowedPreviewTypes: [],
        mainClass: "input-group-lg"
    });
});

function upload() {
    $.ajax({
        type: 'POST',
        url: '/text_analyzer/analyze',
        xhrFields: {
            withCredentials: true
        },
        cache: false,
        contentType: false,
        processData: false,
        data: new FormData($('#fileinput')[0]),
        complete: function () {
            window.location.href = '/text_analyzer/result'
        },
        message: function (xhr) {
            var jsons = xhr.currentResponseText.split('}{');
            jsons.forEach(function (value, index) {
                if(index === 0 && jsons.length > 1){
                    value = value + '}';
                }else if(index === jsons.length - 1 && jsons.length > 1){
                    value = '{' + value;
                }else if(jsons.length > 1){
                    value = '{' + value + '}';
                }
                var json = JSON.parse(value);
                var filename = json["object"];
                var indicator = $('#fileinput').find('.file-preview>.file-drop-disabled>.file-preview-thumbnails>div[title="'+filename+'"]>.file-thumbnail-footer>.file-upload-indicator');
                var i = indicator.children('i');
                if(json["code"] === 0){
                    indicator.attr("title", "Upload success");
                    i.attr("class", "glyphicon glyphicon-ok text-success");
                }else{
                    indicator.attr("title", json["message"]);
                    i.attr("class", "glyphicon glyphicon-remove text-danger");
                }
            });
        },
        error: function (ex) {
            alert("Unknown error.");
        }
    });
}
	

