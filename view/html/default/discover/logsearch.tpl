<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>搜索日志查询</h3>
            <p class="description ">查询某些条件的搜索日志</p>
            <div id="content-top">
                <div class="option-container">
                    <div class="row">
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-sorce">日志来源</label>
                                <select class="col-md-8 input-value" id="log-source">
                                    <option value="logstash-search-*">检索日志</option>
                                    <option value="logstash-click-search-*" selected>检索点击日志</option>
                                    <option value="logstash-disp-search-*">检索展现</option>
                                    <option value="logstash-hy-middle-*">黄页中间页</option>
                                    <option value="logstash-bdoor-middle-*">订单分发中间页</option>
                                    <option value="logstash-bdoor-order-*">订单分发订单信息</option>
                                </select>
                            </div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-date-ranger">时间范围:</label>
                                <input id="log-date-ranger" class="col-md-9 input-value">
                            </div>
                        </div>
                        <div>

                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-top">展示条数</label>
                                <select class="col-md-8 input-value" id="log-top">
                                    <option value="20">20</option>
                                    <option value="40" selected>40</option>
                                    <option value="60">60</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-2 input-label" for="log-query">查询query</label>
                                <input id="log-query" class="col-md-9 input-value" placeholder="*">
                            </div>
                            <div class="col-md-2 input-form pull-right">
                                <button id="log-search">查询</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="query-result">
                    <div id="result">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));

        $('#log-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));

        $('#log-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                }
        );
        $("#log-search").click(
                function () {
                    var log_top = $("#log-top").val();
                    var log_source = $("#log-source").val();
                    var query = $("#log-query").val();
                    var log_data = get_log_data(log_source, start_time, end_time, log_top, query);

                    log_data.then(function (resp) {
                        result = resp.hits.hits;
                       //var container = document.getElementById("result");

                        var container = $('#result');
                        container.empty();


                        var editor = new JSONEditor(container[0]);
                        // set json
                        editor.set(result);

                    });

                }
        );
        /*
        var container = document.getElementById("result");
        var editor = new JSONEditor(container);

        // set json
        var json = {
            "Array": [1, 2, 3],
            "Boolean": true,
            "Null": null,
            "Number": 123,
            "Object": {"a": "b", "c": "d"},
            "String": "Hello World"
        };
        editor.set(json);

        // get json
        var json = editor.get();
        */
    });
</script>