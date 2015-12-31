<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>日志统计分析</h3>
            <p class="description ">在此你可以对日志进行统计分析,生成报表,计算一些统计值等</p>
            <div id="content-top">
                <div class="option-container">
                    <div class="row option-group">
                        <div class="option-title">
                            <p>日志选项</p>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-sorce">日志来源:</label>
                                <select class="col-md-8 input-value" id="log-source">
                                    <option value="logstash-search">检索日志</option>
                                    <option value="logstash-click-search" selected>检索点击日志</option>
                                    <option value="logstash-disp-search">检索展现</option>
                                    <option value="logstash-middle-hy">黄页中间页</option>
                                    <option value="logstash-middle-bdoor">订单分发中间页</option>
                                    <option value="logstash-bdoor-order">订单分发订单信息</option>
                                </select>
                            </div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-date-ranger">时间范围:</label>
                                <input id="log-date-ranger" class="col-md-9 input-value">
                            </div>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-2 input-label" for="log-query">过滤条件:</label>
                                <input id="log-query" class="col-md-9 input-value" placeholder="*">
                            </div>
                        </div>
                    </div>
                    <div class="row option-group">
                        <div>
                            <p class="option-title">统计选项</p>
                        </div>
                        <div class="col-md-6 input-form">
                            <label class="col-md-3 input-label" for="log-type">统计类型:</label>
                            <select class="col-md-8 input-value" id="log-type">
                                <option value="count" selected>日志条目</option>
                                <option value="avg">平均值</option>
                                <option value="sum">求和</option>
                                <option value="median">中位数</option>
                                <option value="min">最小值</option>
                                <option value="max">最大值</option>
                                <option value="standard_deviation">标准差</option>
                                <option value="unique_count">去重计数</option>
                            </select>
                        </div>
                        <div class="col-md-6 input-form" id="input-log-field" style="display: none">
                            <label class="col-md-3 input-label" for="log-field">选择字段:</label>
                            <select class="col-md-8 input-value" id="log-field">
                            </select>
                        </div>
                    </div>
                    <div class="row option-group">
                        <div>
                            <p class="option-title">聚合维度</p>
                        </div>
                        <div class="col-md-6 input-form">
                            <label class="col-md-3 input-label" for="aggs-type">聚合类型:</label>
                            <select class="col-md-8 input-value" id="aggs-type">
                                <option value="date_histogram" selected>时间聚合</option>
                                <option value="histogram" >数值聚合</option>
                                <option value="range" >数值范围聚合</option>
                                <option value="date_range" >时间范围聚合</option>
                                <option value="terms" >字段聚合</option>
                            </select>
                        </div>
                        <div class="col-md-6 input-form" id="input-aggs-field" style="display: none">
                            <label class="col-md-3 input-label" for="aggs-field">选择字段:</label>
                            <select class="col-md-8 input-value" id="aggs-field">
                            </select>
                        </div>
                        <div class="col-md-6 input-form" id="input-aggs-interval">
                            <label class="col-md-3 input-label" for="aggs-interval">时间间隔:</label>
                            <select class="col-md-8 input-value" id="aggs-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div>
                            <div class="col-md-offset-4  col-md-4 input-form">
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
        var date_ranger = $('#log-date-ranger');
        date_ranger.attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));

        date_ranger.daterangepicker({
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
        $("#log-type").change(
                function () {
                    var log_type_value = $("#log-type").val();
                    if( log_type_value != "count" ){
                        $('#input-log-field').show();
                        var log_source = $("#log-source").val();
                        var para_array = get_all_parameters(log_source);
                        para_array.then(function(resp) {
                            var data = JSON.parse(resp.hits.hits[0]._source.fields);
                            var result = [];
                            for (var i=0; i<data.length; i++)
                            {
                                if (data[i].type == 'number' && data[i].name[0] != "_" &&
                                        data[i].name.substring(0,5) != "geoip")
                                    result.push(data[i].name)
                            }
                            var select_con = $('#log-field');
                            select_con.empty();
                            for(var item in result){
                                select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                            }
                        });
                    } else {
                        $('#input-log-field').hide();
                    }
                }
        );

        $("#log-source").change(
                function () {
                    var log_type_value = $("#log-type").val();
                    if( log_type_value != "count" ){
                        $('#input-log-field').show();
                        var log_source = $("#log-source").val();
                        var para_array = get_all_parameters(log_source);
                        para_array.then(function(resp) {
                            var data = JSON.parse(resp.hits.hits[0]._source.fields);
                            var result = [];
                            for (var i=0; i<data.length; i++)
                            {
                                if (data[i].type == 'number')
                                    result.push(data[i].name)
                            }
                            var select_con = $('#log-field');
                            select_con.empty();
                            for(var item in result){
                                select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                            }
                        });
                    } else {
                        $('#input-log-field').hide();
                    }
                }
        );

        $("#aggs-type").change(
                function () {

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
    });
</script>