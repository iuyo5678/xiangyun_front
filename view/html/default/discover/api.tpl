<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>日志自定挖掘</h3>
            <p class="description ">在此你可以自定义对日志进行分析挖掘按照并且按照你的要求产生结果数据</p>
            <div id="content-top">
                <div class="option-container">
                    <div class="row option-group">
                        <div class="option-title">
                            <p>输入query</p>
                        </div>
                        <div class="col-md-6 input-form">
                            <label class="col-md-3 input-label" for="log-sorce">日志来源:</label>
                            <select class="col-md-8 input-value" id="log-source">
                                <option value="logstash-search-*">检索日志</option>
                                <option value="logstash-click-search-*" selected>检索点击日志</option>
                                <option value="logstash-disp-search-*">检索展现</option>
                                <option value="logstash-middle-hy-*">黄页中间页</option>
                                <option value="logstash-middle-bdoor-*">订单分发中间页</option>
                                <option value="logstash-bdoor-order-*">订单分发订单信息</option>
                            </select>
                        </div>
                        <label class="input-label" for="query-editor">查询语句:</label>
                        <div class="editor" id="query-editor">{
    "query": {
        "filtered": {
            "query": {
                "query_string": {
                     "analyze_wildcard": true,
                     "query": "*"
                }
            },
            "filter": {
                "bool": {
                    "must": [
                        {
                            "range": {
                                "@timestamp": {
                                    "gte": "2015-12-20T16:00:00.792Z",
                                    "lte": "2016-01-05T15:59:59.792Z"
                                }
                            }
                        }
                    ],
                    "must_not": [ ]
                }
            }
        }
    },
    "aggs": {
        "时间聚合": {
            "date_histogram": {
                "field": "@timestamp",
                "interval": "24h",
                "time_zone": "Asia/Shanghai",
                "min_doc_count": 0
            }
        }
    }
}
                        </div>
                        <div class="row">
                            <div>
                                <div id="query-test-option" class="col-md-offset-4  col-md-4 input-form">
                                    <button id="query-test">测设query</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div>
                                <div id="query-test-result" class="editor">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row option-group">
                        <div class="option-title">
                            <p>输入结果处理程序</p>
                        </div>
                        <div class="col-md-6 input-form">
                            <label class="col-md-3 input-label" for="process-type">程序语言:</label>
                            <select class="col-md-8 input-value" id="process-type">
                                <option value="php">php</option>
                                <option value="javascript">js</option>
                                <option value="python" selected>python</option>
                            </select>
                        </div>
                        <label class="input-label" for="query-editor">处理语句:</label>
                        <div class="editor" id="process-editor">#你可以在这里写你的结果处理程序
#函数名称必须为process_result(data)
#包含一个处理参数,里面是传入的数据,pythondict结构
def process_result(data):
    return data
                        </div>
                        <div class="row">
                            <div>
                                <div id="process-test-option" class="col-md-offset-4  col-md-4 input-form">
                                    <button id="process-test">处理测试</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div>
                                <div id="process-test-result" class="editor">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        var editor = ace.edit("query-editor");
        editor.setTheme("ace/theme/monokai");
        editor.getSession().setMode("ace/mode/json");

        var container = $('#query-test-result');
        container.empty();
        container.hide();

        var process_editor = ace.edit("process-editor");
        process_editor.setTheme("ace/theme/monokai");
        process_editor.getSession().setMode("ace/mode/python");

        var container = $('#process-test-result');
        container.empty();
        container.hide();

        $("#log-search").click(
                function () {

                }
        );
        //查询测试结果
        $("#query-test").click(
                function () {
                    var container = $('#query-test-close');
                    container.remove();
                    var query_str = editor.getValue();
                    var log_source = $("#log-source").val();
                    var query_body = JSON.parse(query_str);
                    var query = {};
                    query['size'] = 10;
                    query['index'] = log_source;
                    query['body'] = query_body;
                    var elc_client = new elasticsearch.Client({hosts: data_server});
                    esp = elc_client.search(query);
                    esp.then(function (resp) {
                        var container = $('#query-test-result');
                        var query_result_editor = ace.edit("query-test-result");
                        query_result_editor.setTheme("ace/theme/monokai");
                        query_result_editor.getSession().setMode("ace/mode/json");
                        query_result_editor.setValue(JSON.stringify(resp, null, '\t'))
                        container.show();
                        $('#query-test-option').append('<button id="query-test-close">关闭</button>')
                        $("#query-test-close").click(
                                function () {
                                    var container = $('#query-test-result');
                                    container.hide();
                                    var container = $('#query-test-close');
                                    container.remove();
                                }
                        );
                    });
                }
        );
        //处理测试结果
        $("#process-test").click(
                function () {
                    var container = $('#process-test-close');
                    container.remove();
                    var query_str = editor.getValue();
                    var log_source = $("#log-source").val();
                    var query_body = JSON.parse(query_str);
                    var query = {};
                    query['size'] = 10;
                    query['index'] = log_source;
                    query['body'] = query_body;
                    var elc_client = new elasticsearch.Client({hosts: data_server});
                    esp = elc_client.search(query);
                    esp.then(function (resp) {
                        var process_input = JSON.stringify(resp);
                        var process_type = $('#process-type').val();
                        var process_func  = process_editor.getValue();
                        var send_body = {};
                        send_body['process_input'] = process_input;
                        send_body['process_type'] = process_type;
                        send_body['process_func'] = process_func;
                        $.ajax({
                            url: 'http://127.0.0.1/xiangyun_front/index.php?route=api/dataservice/process',
                            type: 'POST',
                            data: send_body,
                            beforeSend: function() {
                                console.log("beford result")
                            },
                            complete: function() {
                                console.log("complete result")
                            },
                            success: function(data) {
                                console.log("success result data");
                                console.log(data);
                                var container = $('#process-test-result');
                                var process_result_editor = ace.edit("process-test-result");
                                process_result_editor.setTheme("ace/theme/monokai");
                                process_result_editor.getSession().setMode("ace/mode/json");
                                process_result_editor.setValue(JSON.stringify(data, null, '\t'))
                                container.show();
                                $('#process-test-option').append('<button id="process-test-close">关闭</button>')
                                $("#process-test-close").click(
                                        function () {
                                            var container = $('#process-test-result');
                                            container.hide();
                                            var container = $('#process-test-close');
                                            container.remove();
                                        }
                                );
                            }
                        });
                    });
                }
        );

    });
</script>