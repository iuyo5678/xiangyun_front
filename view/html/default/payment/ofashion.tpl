<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>支付闭环ofashion PV UV 统计</h3>
                <p class="description ">目前支付闭环ofashion 在搜索页面的PV UV 数据 包括卡片名为wz_ofashion_*</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-date-ranger">时间范围:</label>
                            <input id="collect-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-interval">统计间隔</label>
                            <select class="col-md-6" id="collect-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-type">统计类型</label>
                            <select class="col-md-6" id="collect-type">
                                <option value="all" selected>ofasion卡片</option>
                                <option value="gen-all">ofasion卡片泛需求</option>
                                <option value="per-all">ofasion卡片精确需求</option>
                                <option value="gen-6169047">ofasion卡片泛需求-6169047</option>
                                <option value="gen-6901752">ofasion卡片泛需求-6901752</option>
                                <option value="per-6169047">ofasion卡片精确需求-6169047</option>
                                <option value="per-6901752">ofasion卡片精确需求-6901752</option>
                            </select>
                        </div>
                    </div>
                    <div id="result-container">
                    </div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>支付闭环ofashion 点击统计</h3>
                <p class="description ">目前支付闭环ofashion 在搜索页面的点击数据 包括卡片名为wz_ofashion_genericity</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-date-ranger">时间范围:</label>
                            <input id="click-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-interval">统计间隔</label>
                            <select class="col-md-6" id="click-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-type">统计类型</label>
                            <select class="col-md-6" id="click-type">
                                <option value="all" selected>ofasion卡片</option>
                                <option value="gen-all">ofasion卡片泛需求</option>
                                <option value="per-all">ofasion卡片精确需求</option>
                                <option value="gen-6169047">ofasion卡片泛需求-6169047</option>
                                <option value="gen-6901752">ofasion卡片泛需求-6901752</option>
                                <option value="per-6169047">ofasion卡片精确需求-6169047</option>
                                <option value="per-6901752">ofasion卡片精确需求-6901752</option>
                            </select>
                        </div>
                    </div>
                    <div id="click-result-container">
                    </div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>支付闭环ofashion展现query分析</h3>
                <p class="description ">目前支付闭环ofashion 在搜索页面的展现query分析</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="disp-query-date-ranger">时间范围:</label>
                            <input id="disp-query-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="disp-query-interval">统计间隔</label>
                            <select class="col-md-6" id="disp-query-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="disp-query-type">统计类型</label>
                            <select class="col-md-6" id="disp-query-type">
                                <option value="all" selected>ofasion卡片</option>
                                <option value="gen-all">ofasion卡片泛需求</option>
                                <option value="per-all">ofasion卡片精确需求</option>
                                <option value="gen-6169047">ofasion卡片泛需求-6169047</option>
                                <option value="gen-6901752">ofasion卡片泛需求-6901752</option>
                                <option value="per-6169047">ofasion卡片精确需求-6169047</option>
                                <option value="per-6901752">ofasion卡片精确需求-6901752</option>
                            </select>
                        </div>
                    </div>
                    <div id="disp-query-result-container">
                    </div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>支付闭环ofashion 点击query统计</h3>
                <p class="description ">目前支付闭环ofashion 在搜索页面的点击query分析 包括卡片名为wz_ofashion_*</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-query-date-ranger">时间范围:</label>
                            <input id="click-query-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-query-interval">统计间隔</label>
                            <select class="col-md-6" id="click-query-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-query-type">统计类型</label>
                            <select class="col-md-6" id="click-query-type">
                                <option value="all" selected>ofasion卡片</option>
                                <option value="gen-all">ofasion卡片泛需求</option>
                                <option value="per-all">ofasion卡片精确需求</option>
                                <option value="gen-6169047">ofasion卡片泛需求-6169047</option>
                                <option value="gen-6901752">ofasion卡片泛需求-6901752</option>
                                <option value="per-6169047">ofasion卡片精确需求-6169047</option>
                                <option value="per-6901752">ofasion卡片精确需求-6901752</option>
                            </select>
                        </div>
                    </div>
                    <div id="click-query-result-container">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function(e) {
        window.onresize()// activated tab
    });
    $(document).ready(function () {
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));
        var log_source = 'logstash-disp-search*';

        var statistics = [
            {
                'name':"PV",
                'type': "count"
            },
            {
                'name':"平均展现位置",
                'type': "avg",
                'field':'disp_detail.abs_disp_pos'
            },
            {
                field: "baiduid",
                name: "UV",
                type: "cardinality"
            }
        ];


        var aggs = [
            {
                'field': "@timestamp",
                'interval': "24h",
                'name': "时间聚合0",
                'type': "date_histogram"
            }
        ];

        var draw_option = {
            'type':'gridchart',
            'xaxis': {
                'source': 'time',
                'name': '时间'
            },
            'yaxis':[
                {
                    'source':'doc_count',
                    'name': 'PV'
                },
                {
                    'source':'平均展现位置',
                    'name': '平均展现位置'
                },
                {
                    'source':'UV',
                    'name':'UV'
                }
            ]
        };
        var query = "disp_detail.disp_result_type:wz_ofashion_*";
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
            draw_result(start_time, end_time, log_source, query, statistics, aggs, draw_option, '#result-container', "table#gridchart");

        });
        $("#collect-interval").change(
                function () {
                    aggs[0]['interval'] = $("#collect-interval").val();
                    draw_result(start_time, end_time, log_source, query, statistics, aggs, draw_option, '#result-container', "table#gridchart")
                }
        );
        $("#collect-type").change(
                function () {
                    var collect_type = $("#collect-type").val();
                    if (collect_type=='all'){
                        query = "disp_detail.disp_result_type:wz_ofashion_*";
                    } else if(collect_type=='gen-all'){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity";
                    } else if(collect_type=="per-all"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise";
                    } else if(collect_type=="gen-6169047"){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity AND disp_detail.subresult:*6169047*";
                    } else if(collect_type == "gen-6901752"){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity AND disp_detail.subresult:*6901752*";
                    } else if(collect_type=="per-6169047"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise AND disp_detail.subresult:*6169047*";
                    } else if(collect_type=="per-6901752"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise AND disp_detail.subresult:*6901752*";
                    }else{
                        query = "disp_detail.disp_result_type:wz_ofashion_*";
                    }
                    draw_result(start_time, end_time, log_source, query, statistics, aggs, draw_option, '#result-container', "table#gridchart")
                }
        );
        $('#collect-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);

        draw_result(start_time, end_time, log_source, query, statistics, aggs, draw_option, '#result-container', "gridchart#table")


        var disp_query_statistics = [
            {
                'name':"数量",
                'type': "count"
            }
        ];


        var disp_query_aggs = [
            {
                "field": "normalized_query.raw",
                "size": 40,
                "order": {
                    "_count": "desc"
                },
                "type":"terms",
                "name":"query"
            }
        ];


        var disp_query_draw_option = {
            'type':'gridchart',
            'xaxis': {
                'source': 'key',
                'name': 'query'
            },
            'yaxis':[
                {
                    'source':'doc_count',
                    'name': '数量'
                },
            ]
        };

        $('#disp-query-date-ranger').dateRangePicker(
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
            draw_result(start_time, end_time, log_source, query, disp_query_statistics, disp_query_aggs, disp_query_draw_option, '#disp-query-result-container', "gridchart#table");

        });
        $("#disp-query-interval").change(
                function () {
                    aggs[0]['interval'] = $("#collect-interval").val();
                    draw_result(start_time, end_time, log_source, query, disp_query_statistics, disp_query_aggs, disp_query_draw_option, '#disp-query-result-container', "gridchart#table");
                }
        );
        $("#disp-query-type").change(
                function () {
                    var collect_type = $("#collect-type").val();
                    if (collect_type=='all'){
                        query = "disp_detail.disp_result_type:wz_ofashion_*";
                    } else if(collect_type=='gen-all'){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity";
                    } else if(collect_type=="per-all"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise";
                    } else if(collect_type=="gen-6169047"){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity AND disp_detail.subresult:*6169047*";
                    } else if(collect_type == "gen-6901752"){
                        query = "disp_detail.disp_result_type:wz_ofashion_genericity AND disp_detail.subresult:*6901752*";
                    } else if(collect_type=="per-6169047"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise AND disp_detail.subresult:*6169047*";
                    } else if(collect_type=="per-6901752"){
                        query = "disp_detail.disp_result_type:wz_ofashion_precise AND disp_detail.subresult:*6901752*";
                    }else{
                        query = "disp_detail.disp_result_type:wz_ofashion_*";
                    }
                    draw_result(start_time, end_time, log_source, query, disp_query_statistics, disp_query_aggs, disp_query_draw_option, '#disp-query-result-container', "gridchart#table");
                }
        );
        $('#disp-query-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);

        draw_result(start_time, end_time, log_source, query, disp_query_statistics, disp_query_aggs, disp_query_draw_option, '#disp-query-result-container', "gridchart#table");


        var click_log_source = 'logstash-click-search*';
        var click_statistics = [
            {
                'name':"点击",
                'type': "count"
            },
        ];
        var click_draw_option = {
            'type':'gridchart',
            'xaxis': {
                'source': 'time',
                'name': '时间'
            },
            'yaxis':[
                {
                    'source':'doc_count',
                    'name': '点击'
                }
            ]
        };
        var click_query = "clk_detail.aladdin_source_id:wz_ofashion_*";
        $('#click-date-ranger').dateRangePicker(
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
            draw_result(start_time, end_time, click_log_source, click_query, click_statistics, aggs, click_draw_option, '#click-result-container', "gridchart#table")

        });
        $('#click-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);
        $("#click-interval").change(
                function () {
                    aggs[0]['interval'] = $("#collect-interval").val();
                    draw_result(start_time, end_time, click_log_source, click_query, click_statistics, aggs, click_draw_option, '#click-result-container', "gridchart#table")
                }
        );
        $("#click-type").change(
                function () {
                    var collect_type = $("#click-type").val();
                    if (collect_type=='all'){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_*";
                    } else if(collect_type=='gen-all'){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity";
                    } else if(collect_type=="per-all"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise";
                    } else if(collect_type=="gen-6169047"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity AND clk_detail.action_attribute.event_url:*6169047* ";
                    } else if(collect_type == "gen-6901752"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity AND clk_detail.action_attribute.event_url:*6901752*";
                    } else if(collect_type=="per-6169047"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise AND clk_detail.action_attribute.event_url:*6169047*";
                    } else if(collect_type=="per-6901752"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise AND clk_detail.action_attribute.event_url:*6901752*";
                    }else{
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_*";
                    }
                    draw_result(start_time, end_time, click_log_source, click_query, click_statistics, aggs, click_draw_option, '#click-result-container', "gridchart#table")
                }
        );
        $('#click-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);
        draw_result(start_time, end_time, click_log_source, click_query, click_statistics, aggs, click_draw_option, '#click-result-container', "gridchart#table")


        var click_query_statistics = [
            {
                'name':"query",
                'type': "count"
            },
        ];
        var click_query_aggs = [
            {
                "field": "normalized_query.raw",
                "size": 40,
                "order": {
                    "_count": "desc"
                },
                "type":"terms",
                "name":"query"
            }
        ];

        var click_query_draw_option = {
            'type':'gridchart',
            'xaxis': {
                'source': 'key',
                'name': 'query'
            },
            'yaxis':[
                {
                    'source':'doc_count',
                    'name': '数量'
                },
            ]
        };

        $('#click-query-date-ranger').dateRangePicker(
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
            draw_result(start_time, end_time, click_log_source, click_query, click_query_statistics, click_query_aggs, click_query_draw_option, '#click-query-result-container', "gridchart#table")

        });
        $('#click-query-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);
        $("#click-query-interval").change(
                function () {
                    aggs[0]['interval'] = $("#collect-interval").val();
                    draw_result(start_time, end_time, click_log_source, click_query, click_query_statistics, click_query_aggs, click_query_draw_option, '#click-query-result-container', "gridchart#table")
                }
        );
        $("#click-query-type").change(
                function () {
                    var collect_type = $("#click-type").val();
                    if (collect_type=='all'){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_*";
                    } else if(collect_type=='gen-all'){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity";
                    } else if(collect_type=="per-all"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise";
                    } else if(collect_type=="gen-6169047"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity AND clk_detail.action_attribute.event_url:*6169047* ";
                    } else if(collect_type == "gen-6901752"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_genericity AND clk_detail.action_attribute.event_url:*6901752*";
                    } else if(collect_type=="per-6169047"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise AND clk_detail.action_attribute.event_url:*6169047*";
                    } else if(collect_type=="per-6901752"){
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_precise AND clk_detail.action_attribute.event_url:*6901752*";
                    }else{
                        click_query = "clk_detail.aladdin_source_id:wz_ofashion_*";
                    }
                    draw_result(start_time, end_time, click_log_source, click_query, click_query_statistics, click_query_aggs, click_query_draw_option, '#click-query-result-container', "gridchart#table")
                }
        );
        $('#click-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);
        draw_result(start_time, end_time, click_log_source, click_query, click_query_statistics, click_query_aggs, click_query_draw_option, '#click-query-result-container', "gridchart#table")


    });
</script>