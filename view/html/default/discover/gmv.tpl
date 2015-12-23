<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>各类目GMV查询</h3>

            <p class="description ">查询各个类目在各个日期的gmv</p>

            <div id="content-top">
                <div class="option-container">
                    <div class="row">
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="gmv-date-ranger">时间范围:</label>
                                <input id="gmv-date-ranger" class="col-md-9 input-value">
                            </div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="gmv-interval">统计间隔</label>
                                <select class="col-md-8 input-value" id="gmv-interval">
                                    <option value="12h">12小时</option>
                                    <option value="24h" selected>一天</option>
                                    <option value="1w">一周</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-2 input-label" for=" gmv-value">类目appid:</label>
                                <input id="gmv-value" class="col-md-9 input-value" placeholder="10006">
                            </div>
                            <div class="col-md-2 input-form pull-right">
                                <button id="gmv-search">查询</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="gmv-bdoor-visul"></div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script>
    $(document).ready(function () {
        var gmv_start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var gmv_end_time = DateAdd("d ", -2, setEndDay(new Date()));
        var gmv_checkValue = $("#gmv-interval").val();
        $('#gmv-date-ranger').attr("value", gmv_start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + gmv_end_time.Format("yyyy-MM-dd HH:mm:ss"));
        $('#gmv-date-ranger').daterangepicker({
                    timePicker: true,
                    timePickerIncrement: 30,
                    startDate: gmv_start_time,
                    endDate: gmv_end_time,
                    format: 'YYYY-MM-DD hh:mm:ss'
                },
                function (start, end, label) {
                    gmv_start_time = start;
                    gmv_end_time = end;
                }
        );
        $("#gmv-interval").change(
                function () {
                    gmv_checkValue = $("#gmv-interval").val();
                }
        );


        $("#key-interval").change(
                function () {
                    key_checkValue = $("#key-interval").val();
                }
        );
        $("#gmv-search").click(
                function () {
                    $('#gmv-bdoor-visul').height(400);
                    var query = "order_status:>1 AND NOT order_status:3  AND NOT order_status:4  AND NOT order_status:5  AND NOT order_status:6"
                    var input_value = $("#gmv-value").val();
                    if (input_value != "") {
                        query = query + " AND provider_id :" + input_value
                    }
                    draw_category_gmv_data(gmv_start_time, gmv_end_time, "gmv-bdoor-visul", query, gmv_checkValue);
                }
        );

    });
</script>