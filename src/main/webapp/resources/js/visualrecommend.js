$(document).ready(function () {
    $("#input-6").fileinput({
        showUpload: false,
        showPreview: false,
        maxFileCount: 1,
        allowedFileExtensions : ['xls', 'xlsx'],
        allowedPreviewTypes: [],
        mainClass: "input-group-lg"
    });

    var container = document.getElementById('table');
    var hot = new Handsontable(container, {
        rowHeaders: true,
        colHeaders: true,
        autoWrapRow: true,
        minRows: 24,
        minCols: 8,
        // currentRowClassName：当前行样式的名称,
        // currentColClassName：当前列样式的名称,
        manualColumnResize: true,//当值为true时，允许拖动，当为false时禁止拖动
        manualRowResize: true,//当值为true时，允许拖动，当为false时禁止拖动
        stretchH: "all",     //last:延伸最后一列,all:延伸所有列,none默认不延伸。
        manualColumnMove: true,// 当值为true时，列可拖拽移动到指定列
        manualRowMove: true,// 当值为true时，行可拖拽至指定行
        columnSorting: true,//允许排序
        sortIndicator: true,
        contextMenu: true,//显示右键菜单
        autoColumnSize: true //当值为true且列宽未设置时，自适应列大小
    });

    $("#input-6").change(function() {
        if(!$("#input-6").prop("files")) {
            return;
        }
        var f = $("#input-6").prop("files")[0];
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            var wb = XLSX.read(data, {
                type: 'binary'
            });
            var sheet = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
            var tmp = [];
            var logx = true;
            sheet.forEach(function (value) {
                if(logx){
                    var x = [];
                    for (var k in value) {
                        x.push(k);
                    }
                    tmp.push(x);
                    logx = false;
                }
                var d = [];
                for (var k in value) {
                    d.push(value[k]);
                }
                tmp.push(d);
            });
            hot.loadData(tmp);
        };
        reader.readAsBinaryString(f);
    });
});