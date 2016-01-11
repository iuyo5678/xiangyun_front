<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>订单分发-按摩 PV UV 统计</h3>
                <p class="description ">目前按摩在搜索页面的PV UV 卡片名wz_bdoor 过滤条件:展示url中带有5833761</p>
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
                <h3>订单分发-按摩 点击 统计</h3>
                <p class="description ">目前按摩在搜索页面的 点击统计 卡片名wz_bdoor 过滤条件:lightapp_id为5833761</p>
                <div id="content-top">
                    <div class="option-container">
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-date-ranger">选择时间范围:</label>
                            <input id="click-date-ranger" class="col-md-9">
                        </div>
                        <div class="col-md-6">
                            <label class="col-lg-3" for="click-interval">选则统计间隔</label>
                            <select class="col-md-6" id="click-interval">
                                <option value ="3h">3小时</option>
                                <option value ="6h">6小时</option>
                                <option value="12h">12小时</option>
                                <option value="24h" selected>24小时</option>
                            </select>
                        </div>
                    </div>
                    <ul id="click-tab" class="nav nav-tabs">
                        <li class="active"><a href="#click-visul" data-toggle="tab">曲线图</a></li>
                        <li><a href="#click-table-tab" data-toggle="tab">表格</a></li>

                    </ul>
                    <div id="collectTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="click-visul"></div>
                        <div class="tab-pane fade" id="click-table-tab"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        all_cards = ['wz_bdoor'];
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time= DateAdd("d ", -2, setEndDay(new Date()));
        var checkValue = $("#collect-interval").val();
        $('#collect-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
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
                    draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_bdoor AND disp_detail.url:*5833761*', checkValue);
                });
        $("#collect-interval").change(
                function(){
                    checkValue = $("#collect-interval").val();
                    draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_bdoor AND disp_detail.url:*5833761*', checkValue);
                }
        );
        draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_bdoor AND disp_detail.url:*5833761*', checkValue, all_cards);

        var clickCheckValue = $("#click-interval").val();
        $('#click-date-ranger').attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#click-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: start_time,
                    endDate: end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    start_time = start;
                    end_time = end;
                    draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_bdoor AND clk_detail.lightapp_id:5833761', clickCheckValue);
                });
        $("#collect-interval").change(
                function(){
                    checkValue = $("#collect-interval").val();
                    draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_bdoor AND clk_detail.lightapp_id:5833761', clickCheckValue);
                }
        );
        draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_bdoor AND clk_detail.lightapp_id:5833761', clickCheckValue, all_cards);
    });
</script>