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
                                    <option value="logstash-middle-bdoor-*">订单分发中间页</option>
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
                    <div>
                        <p id="result-desc"></p>
                    </div>
                    <div class="editor" id="result">
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

        $('#log-date-range').dateRangePicker(
                {
                    language:'cn',
                    startOfWeek: 'monday',
                    separator: ' ~ ',
                    format: 'YYYY.MM.DD HH:mm:ss',
                    time: {
                        enabled: true
                    },
                    lookBehind: true,
                    endDate: end_time,
                    showShortcuts: true,
                    shortcuts: {
                        'prev-days': [3, 5, 7],
                        'prev': ['week', 'month', 'year'],
                        'next-days': null,
                        'next': null
                    }
                }
        ).bind('datepicker-change',function(event,obj)
        {
            start_time = obj.date1;
            end_time = obj.date2;
        });
        $('#log-date-range').data('dateRangePicker')
                .setDateRange(start_time, end_time);

        $("#log-search").click(
                function () {
                    var log_top = $("#log-top").val();
                    var log_source = $("#log-source").val();
                    var query = $("#log-query").val();
                    var log_data = get_log_data(log_source, start_time, end_time, log_top, query);

                    log_data.then(function (resp) {
                        var result = resp.hits.hits;
                        var take_time = resp.took;
                        var count = resp.hits.total;
                       //var container = document.getElementById("result");
                        var desp = "".concat("总计耗时: ", take_time, "毫秒. 找到日志共计: ", count, "条 下面是其中的", log_top, "条.");
                        var desc_container = $('#result-desc');
                        desc_container.text(desp);
                        var container = $('#result');
                        var container = $('#query-test-result');
                        var query_result_editor = ace.edit("result");
                        query_result_editor.setTheme("ace/theme/monokai");
                        query_result_editor.getSession().setMode("ace/mode/json");
                        query_result_editor.setValue(JSON.stringify(result, null, '\t'))
                        container.show();

                    });

                }
        );
    });
</script>