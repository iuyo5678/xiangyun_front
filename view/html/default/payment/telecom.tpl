<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>支付闭环-电信 PV UV 统计</h3>
                <p class="description ">目前电信充值在搜索页面的PV UV 卡片名wz_pinpai 过滤条件:展示url中带有6128913</p>
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
                <h3>支付闭环-电信 点击 统计</h3>
                <p class="description ">目前支付闭环-电信在搜索页面的 点击统计 卡片名wz_pinpai 过滤条件:点击url中带有e.189.cn</p>
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
        all_cards = ['wz_pinpai'];
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
            draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_pinpai AND disp_detail.url:*6128913*', checkValue);


        });
        $('#collect-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);

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
            draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_pinpai AND clk_detail.clk_url:*e.189.cn*', clickCheckValue);

        });
        $('#click-date-ranger').data('dateRangePicker')
                .setDateRange(start_time, end_time);

        $("#collect-interval").change(
                function(){
                    checkValue = $("#collect-interval").val();
                    draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_pinpai AND disp_detail.url:*6128913*', checkValue);
                }
        );
        draw_only_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", 'disp_detail.disp_result_type:wz_pinpai AND disp_detail.url:*6128913*', checkValue, all_cards);

        var clickCheckValue = $("#click-interval").val();
        $("#collect-interval").change(
                function(){
                    checkValue = $("#collect-interval").val();
                    draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_pinpai AND clk_detail.clk_url:*e.189.cn*', clickCheckValue);
                }
        );
        draw_only_click_svg(start_time, end_time, "#click-visul", "#click-table-tab", 'clk_detail.aladdin_source_id:wz_pinpai AND clk_detail.clk_url:*e.189.cn*', clickCheckValue, all_cards);
    });
</script>