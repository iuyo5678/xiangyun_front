<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>搜索结果页按键埋点查询</h3>

            <p class="description ">下表中的数值为触发了该埋点的搜索次数</p>

            <div id="content-top">
                <div class="option-container">
                    <div class="row">
                        <div class="col-md-4 input-form">
                            <label class="col-md-3 input-label" for="key-date-ranger">时间范围:</label>
                            <input id="key-date-ranger" class="col-md-9 input-value">
                        </div>
                        <div class="col-md-4 input-form">
                            <label class="col-md-3 input-label" for="key-interval">统计间隔</label>
                            <select class="col-md-9 input-value" id="key-interval">
                                <option value="3h">3小时</option>
                                <option value="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                        <div class="col-md-3 input-form">
                            <label class="col-md-2 input-label" for="key-value">埋点值:</label>
                            <input id="key-value" class="col-md-10 input-value" placeholder="wz_pinpai_*_title(支持通配符)">
                        </div>
                        <div class="col-md-1 input-form">
                            <button id="click-point-search">查询</button>
                        </div>
                    </div>
                </div>
                <ul id="collcet-tab" class="nav nav-tabs">
                    <li class="active"><a href="#key-visul" data-toggle="tab">曲线图</a></li>
                    <li><a href="#key-table-tab" data-toggle="tab">表格</a></li>
                </ul>
                <div id="collectTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="key-visul"></div>
                    <div class="tab-pane fade" id="key-table-tab"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        all_cards = ['wz_weixiusimple', 'wz_weixiuweak', 'wz_banjiasimple', 'wz_banjiaweak', 'wz_baojiesimple', 'wz_baojieweak', 'wz_pinpai', 'wz_peccancy', 'wz_bdoor', 'wz_hy_multi'];
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));

        var key_checkValue = $("#key-interval").val();

        $('#key-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));

        $('#key-date-ranger').daterangepicker({
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
        $("#click-point-search").click(
                function () {
                    var query = $("#key-value").val();
                    if (query == "") {
                        query = "*";
                    }
                    else {
                        query = "clk_detail.action_attribute.tj:" + query
                    }
                    draw_click_svg(start_time, end_time, "#key-visul", "#key-table-tab", query, key_checkValue, all_cards);
                }
        );
    });
</script>