<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div id="content" class="<?php echo $class; ?>">

            <div class="statistics-container">
                <h3>黄页-保洁 PV UV 统计</h3>
                <p class="description ">目前保洁卡片在搜索结果下的Pv Uv 点击量数据,卡片名称包块 baojiesimple, baojieweak</p>
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
                        all_cards = ['wz_baojiesimple'];
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
                                    draw_pv_uv_svg(start_time, end_time, "#collect-visul", "#collect-table-tab", '*', checkValue);
                                });
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