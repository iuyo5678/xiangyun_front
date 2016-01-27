<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>支付闭环 PV UV 点击统计</h3>
                <p class="description ">目前支付闭环在搜索页面的PV UV 点击数据 包括卡片名为wz_pinpai</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-date-ranger">选择时间范围:</label>
                            <input id="collect-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="collect-interval">选则统计间隔</label>
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
                <h3>用户搜索区域分布统计</h3>

                <p class="description ">统计数值为某一地区在某个时间段内的搜索次数</p>

                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="province-date-ranger">选择时间范围:</label>
                            <input id="province-date-ranger" class="col-md-9">
                        </div>
                    </div>
                    <div id="province-container" style="height:400px"></div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>用户搜索城市分布统计</h3>

                <p class="description ">统计数值为某一地区在某个时间段内的搜索次数</p>

                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="area-date-ranger">选择时间范围:</label>
                            <input id="area-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="area-top">选择top值</label>
                            <select class="col-md-6" id="area-top">
                                <option value=10 selected>10</option>
                                <option value=20>20</option>
                                <option value=20>30</option>
                                <option value=40>40</option>
                                <option value=50>50</option>
                            </select>
                        </div>
                    </div>
                    <div id="map_container" style="height:400px"></div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>用户搜索query统计</h3>

                <p class="description ">统计数值为某个时间段内高频query排序</p>

                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="query-raw-date-ranger">选择时间范围:</label>
                            <input id="query-raw-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="query-raw-top">选择top值</label>
                            <select class="col-md-6" id="query-raw-top">
                                <option value=10 selected>10</option>
                                <option value=20>20</option>
                                <option value=20>30</option>
                                <option value=40>40</option>
                                <option value=50>50</option>
                            </select>
                        </div>
                    </div>
                    <div id="query-raw-container" style="height:400px"></div>
                </div>
            </div>
            <div class="statistics-container">
                <h3>用户搜索query切词统计</h3>

                <p class="description ">统计数值为某个时间段内高频query按词切分后排序</p>

                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="query-date-ranger">选择时间范围:</label>
                            <input id="query-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="query-top">选择top值</label>
                            <select class="col-md-6" id="query-top">
                                <option value=10 selected>10</option>
                                <option value=20>20</option>
                                <option value=20>30</option>
                                <option value=40>40</option>
                                <option value=50>50</option>
                            </select>
                        </div>
                    </div>
                    <div id="query-container" style="height:400px"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        all_cards = ['wz_pinpai'];
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));
        var checkValue = $("#collect-interval").val();
        var area_checkValue = $("#area-top").val();
        var query_raw_checkValue = $("#query-raw-top").val();
        var query_checkValue = $("#query-top").val();

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
            draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue, all_cards);


        });
        $('#collect-date-ranger').data('dateRangePicker').setDateRange(start_time, end_time);

        $('#area-date-ranger').dateRangePicker(
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
            draw_map_data(start_time, end_time, "map_container", "*", area_checkValue, all_cards);


        });
        $('#area-date-ranger').data('dateRangePicker').setDateRange(start_time, end_time);


        $('#query-raw-date-ranger').dateRangePicker(
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
            draw_raw_query_data(start_time, end_time, "query-raw-container", "*", query_raw_checkValue, all_cards, "original_query.raw");

        });
        $('#query-raw-date-ranger').data('dateRangePicker').setDateRange(start_time, end_time);


        $('#query-date-ranger').dateRangePicker(
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
            draw_map_data(start_time, end_time, "map_container", "*", area_checkValue, all_cards);
            draw_raw_query_data(start_time, end_time, "query-raw-container", "*", query_raw_checkValue, all_cards, "original_query.raw");


        });
        $('#query-date-ranger').data('dateRangePicker').setDateRange(start_time, end_time);

        $('#province-date-ranger').dateRangePicker(
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
            draw_province_data(start_time, end_time, "province-container", "*", 50, all_cards, "original_query");
        });
        $('#province-date-ranger').data('dateRangePicker').setDateRange(start_time, end_time);




        $("#collect-interval").change(
                function () {
                    checkValue = $("#collect-interval").val();
                    draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue, all_cards);
                }
        );
        $("#area-top").change(
                function () {
                    area_checkValue = $("#area-top").val();
                    draw_map_data(start_time, end_time, "map_container", "*", area_checkValue, all_cards);
                }
        );
        $("#query-raw-top").change(
                function () {
                    query_raw_checkValue = $("#query-raw-top").val();
                    draw_raw_query_data(start_time, end_time, "query-raw-container", "*", query_raw_checkValue, all_cards, "original_query.raw");
                }
        );
        $("#query-top").change(
                function () {
                    query_checkValue = $("#query-top").val();
                    draw_raw_query_data(start_time, end_time, "query-container", "*", query_checkValue, all_cards, "original_query");
                }
        );
        //draw_pv_uv_svg_adv(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue, all_cards);

        draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue, all_cards);

        draw_map_data(start_time, end_time, "map_container", "*", area_checkValue, all_cards);
        draw_raw_query_data(start_time, end_time, "query-raw-container", "*", query_raw_checkValue, all_cards, "original_query.raw");
        draw_raw_query_data(start_time, end_time, "query-container", "*", query_checkValue, all_cards, "original_query");
        draw_province_data(start_time, end_time, "province-container", "*", 50, all_cards, "province");

    });
</script>