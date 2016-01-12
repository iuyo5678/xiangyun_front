<div class="statistics-container">
    <h3>PV UV 点击汇总统计</h3>

    <p class="description ">目前所有卡片在搜索结果下的Pv Uv 点击量数据,包含黄页,维修等</p>

    <div id="content-top">
        <div class="option-container">
            <div class="col-md-6">
                <label class="col-lg-3" for="collect-date-ranger">选择时间范围:</label>
                <input id="collect-date-ranger" class="col-md-9">
            </div>
            <div class="col-md-6">
                <label class="col-lg-3" for="collect-interval">选则统计间隔</label>
                <select class="col-md-6" id="collect-interval">
                    <option value="3h">3小时</option>
                    <option value="6h">6小时</option>
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
    <h3>订单gmv统计</h3>
    <p class="description ">目前订单分发所有的gmv的统计值(单位元)</p>
    <div id="content-top">
        <div class="option-container">
            <div class="col-md-6">
                <label class="col-lg-3" for="gmv-bdoor-date-ranger">选择时间范围:</label>
                <input id="gmv-bdoor-date-ranger" class="col-md-9">
            </div>
            <div class="col-md-6">
                <label class="col-lg-3" for="gmv-bdoor-interval">选则统计间隔</label>
                <select class="col-md-6" id="gmv-bdoor-interval">
                    <option value="3h">3小时</option>
                    <option value="6h">6小时</option>
                    <option value="12h">12小时</option>
                    <option value="24h" selected>24小时</option>
                </select>
            </div>
        </div>
        <div id="gmv-bdoor-visul" style="height:400px"></div>
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
        <div id="province-container" style="min-height:600px"></div>
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
<script>
    $(document).ready(function () {
        all_cards = ['wz_weixiusimple', 'wz_weixiuweak', 'wz_banjiasimple', 'wz_banjiaweak', 'wz_baojiesimple', 'wz_baojieweak', 'wz_pinpai', 'wz_peccancy', 'wz_bdoor', 'wz_hy_multi'];

        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));
        var checkValue = $("#collect-interval").val();
        var area_checkValue = $("#area-top").val();
        var query_raw_checkValue = $("#query-raw-top").val();
        var query_checkValue = $("#query-top").val();

        $('#collect-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#area-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#query-raw-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#query-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#province-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));

        $('#gmv-bdoor-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));



        $('#collect-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue);
                });
        $('#area-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_map_data(start_time, end_time, "map_container", "*", area_checkValue, all_cards);
                });
        $('#query-raw-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_raw_query_data(start_time, end_time, "query-raw-container", "*", query_raw_checkValue, all_cards, "original_query.raw");
                });
        $('#query-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_raw_query_data(start_time, end_time, "query-container", "*", query_checkValue, all_cards, "original_query");
                });
        $('#province-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_province_data(start_time, end_time, "province-container", "*", 50, all_cards, "original_query");
                });

        $('#gmv-bdoor-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_gmv_data(start_time, end_time, "gmv-bdoor-visul", "order_status:>1 AND NOT order_status:3  AND NOT order_status:4  AND NOT order_status:5  AND NOT order_status:6", 50);
                });

        $("#collect-interval").change(
                function () {
                    checkValue = $("#collect-interval").val();
                    draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue);
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
        draw_gmv_data(start_time, end_time, "gmv-bdoor-visul", "order_status:>1 AND NOT order_status:3  AND NOT order_status:4  AND NOT order_status:5  AND NOT order_status:6", 50);

    });
</script>
