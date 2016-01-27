<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">
            <div class="statistics-container">
                <h3>订单分发-违章缴费 PV UV 点击统计</h3>
                <p class="description ">目前订单分发在搜索页面的PV UV 点击数据 卡片名wz_peccancy</p>
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
                <script>
                    $(document).ready(function () {
                        all_cards = ['wz_peccancy'];
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
                        draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue, all_cards);

                    });
                </script>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>