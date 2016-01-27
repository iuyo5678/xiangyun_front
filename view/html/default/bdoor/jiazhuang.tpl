<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>订单分发-家装 PV UV 点击统计</h3>
                <p class="description ">目前家装在搜索页面的PV UV 点击数据 卡片名zdh_jiazhuangknowledge</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-date-ranger">时间范围:</label>
                            <input id="collect-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-interval">统计间隔</label>
                            <select class="col-md-6" id="collect-interval">
                                <option value ="3h">3小时</option>
                                <option value ="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <ul id="collcet-tab" class="nav nav-tabs">
                        <li class="active"><a href="#collect-visul" data-toggle="tab">曲线图</a></li>
                        <li><a href="#collect-table-tab" data-toggle="tab">表格</a></li>
                    </ul>
                    <div id="collectTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="collect-visul"></div>
                        <div class="tab-pane fade" id="collect-table-tab"></div>
                    </div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>订单分发-家装 中间页 PV UV 统计</h3>
                <p class="description ">目前家装中间页的PV UV数据: 过滤条件为wise_action_name:decoration*</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="middle-date-ranger">时间范围:</label>
                            <input id="middle-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="middle-interval">统计间隔</label>
                            <select class="col-md-6" id="middle-interval">
                                <option value ="3h">3小时</option>
                                <option value ="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div id="query-result">
                        <div id="result-con">
                        </div>
                        <div class="row">
                            <div id="result-option" class="col-md-offset-3  col-md-6 input-form">
                                <button class="result-option" id="result-source">原始数据</button>
                                <button class="result-option" id="result-table">表格数据</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>订单分发-家装 中间页 点击 统计</h3>
                <p class="description ">目前家装中间页的PV UV数据: 过滤条件为wise_action_name:jump AND wise_statistics:bdoor_decoration* </p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="middle-click-date-ranger">时间范围:</label>
                            <input id="middle-click-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="middle-click-interval">统计间隔</label>
                            <select class="col-md-6" id="middle-click-interval">
                                <option value ="3h">3小时</option>
                                <option value ="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div id="middle-query-result">
                        <div id="middle-result-con">
                        </div>
                        <div class="row">
                            <div id="middle-result-option" class="col-md-offset-3  col-md-6 input-form">
                                <button class="result-option" id="middle-result-source">原始数据</button>
                                <button class="result-option" id="middle-result-table">表格数据</button>
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
    function draw_data(result, flag) {
        var container = $('#result-con');
        container.empty();
        $('#data_export').remove();
        container.append('<div class="editor" id="result"></div>');
        var aggs_name = aggs[0].name;
        var aggs_type = aggs[0].type;
        if (flag == "source") {
            var query_result_editor = ace.edit("result");
            query_result_editor.setTheme("ace/theme/monokai");
            query_result_editor.getSession().setMode("ace/mode/json");
            query_result_editor.setValue(JSON.stringify(result, null, '\t'));
        } else {

            d3.select("#result").selectAll("table")
                    .data([result])
                    .enter().append("table")
                    .attr('class', 'result-table')
                    .call(recurse);
            $('.result-table').each(function () {
                var $table = $(this);
                var $button = $("<button class='result-option' id='data_export' type='button'>");
                $button.text("导出数据");
                $button.insertAfter($('#result-table'));
                $button.click(function () {
                    var csv = $table.table2CSV({
                        delivery: 'value'
                    });
                    window.location.href = 'data:text/csv;charset=UTF-8,'
                            + encodeURIComponent(csv);
                });
            });
        }
        $('#query-result').css('display', 'block');

    }
    $(document).ready(function () {
        all_cards = ['zdh_jiazhuangknowledge'];
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time= DateAdd("d ", -2, setEndDay(new Date()));
        var checkValue = $("#collect-interval").val();

        $('#collect-date-ranger').dateRangePicker(
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
            draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue);

        });
        $('#collect-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);

        $("#collect-interval").change(
                function(){
                    checkValue = $("#collect-interval").val();
                    draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue);
                }
        );
        draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '_exists_:zdh_jiazhuangknowledge', checkValue, all_cards);

        log_source = 'logstash-middle-bdoor-*';
        statistics = [
            {
                'name':"PV",
                'type': "count"
            },
            {
                field: "event_baiduid",
                name: "UV",
                type: "cardinality"
            }
        ];
        aggs = [
                {
                    'field': "@timestamp",
                    'interval': "24h",
                    'name': "时间聚合0",
                    'type': "date_histogram"
                }
        ];
        query = "wise_action_name:decora*";

        var elas_query = build_query(start_time, end_time, query, statistics, aggs);

        var log_data = get_log_statistics(log_source, start_time, end_time, elas_query);
        log_data.then(function (resp) {
            var aggs_name = aggs[0].name;
            var aggs_type = aggs[0].type;
            statistic_result = resp.aggregations[aggs_name].buckets;

            format = d3.time.format("%m月%d日%H时");
            statistic_result.forEach(changeResult);
            draw_data(statistic_result, 'table');
        });
        $("#result-source").click(
                function () {
                    draw_data(statistic_result, 'source');
                });
        $("#result-table").click(
                function () {
                    draw_data(statistic_result, 'table');
                });

        statistics = [
            {
                'name':"click",
                'type': "count"
            }
        ];

        middle_click_query = "wise_action_name:jump AND wise_statistics:bdoor_decoration*";

        var elas_query = build_query(start_time, end_time, query, statistics, aggs);

        var middle_log_data = get_log_statistics(log_source, start_time, end_time, elas_query);
        middle_log_data.then(function (resp) {
            var aggs_name = aggs[0].name;
            var aggs_type = aggs[0].type;
            statistic_result = resp.aggregations[aggs_name].buckets;

            format = d3.time.format("%m月%d日%H时");
            statistic_result.forEach(changeResult);
            draw_data(statistic_result, 'table');
        });

    });


</script>