$(document).ready(function () {
    $("#input-6").fileinput({
        showUpload: false,
        maxFileCount: 2000,
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
            console.log('done');
        },
        message: function (xhr) {
            console.log(xhr.currentResponseText);
        },
        error: function (ex) {
            alert(ex);
        }
    });
}
	

