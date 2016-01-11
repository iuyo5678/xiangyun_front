<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="statistics-container">
            <h3>日志统计分析</h3>
            <p class="description ">在此你可以对日志进行统计分析,生成报表,计算一些统计值等</p>
            <div id="content-top">
                <div class="option-container">
                    <div class="row option-group">
                        <div class="option-title">
                            <p>日志选项</p>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-sorce">日志来源:</label>
                                <select class="col-md-8 input-value" id="log-source">
                                    <option value="logstash-search-*">检索日志</option>
                                    <option value="logstash-click-search-*" selected>检索点击日志</option>
                                    <option value="logstash-disp-search-*">检索展现</option>
                                    <option value="logstash-middle-hy-*">黄页中间页</option>
                                    <option value="logstash-middle-bdoor-*">订单分发中间页</option>
                                    <option value="logstash-bdoor-order-*">订单分发订单信息</option>
                                </select>
                            </div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-3 input-label" for="log-date-ranger">时间范围:</label>
                                <input id="log-date-ranger" class="col-md-9 input-value">
                            </div>
                        </div>
                        <div>
                            <div class="col-md-6 input-form">
                                <label class="col-md-2 input-label" for="log-query">过滤条件:</label>
                                <input id="log-query" class="col-md-9 input-value" placeholder="*">
                            </div>
                        </div>
                    </div>
                    <div class="row option-group">
                        <div>
                            <p class="option-title">统计选项</p>
                        </div>
                        <?php $statistics_row = 0; ?>
                        <table id="statistics" class="agg-table">
                            <tbody>
                            <tr id="statistics-row<?php echo $statistics_row; ?>">
                                <td style="width: 90%">
                                    <div>
                                        <div class="col-md-6 input-form">
                                            <label class="col-md-2 input-label"
                                                   for="statistic-name<?php echo $statistics_row; ?>">统计名称:</label>
                                            <input id="statistic-name<?php echo $statistics_row; ?>"
                                                   class="col-md-9 input-value"
                                                   value="日志条目<?php echo $statistics_row; ?>">
                                        </div>
                                    </div>
                                    <div class="col-md-6 input-form">
                                        <label class="col-md-3 input-label"
                                               for="statistic-type<?php echo $statistics_row; ?>">统计类型:</label>
                                        <select class="col-md-8 input-value" type="statistic-type-select"
                                                id="statistic-type<?php echo $statistics_row; ?>"
                                                onchange="statisticalChange(this)">
                                            <option value="count" selected>日志条目</option>
                                            <option value="avg">平均值</option>
                                            <option value="sum">求和</option>
                                            <option value="median">中位数</option>
                                            <option value="min">最小值</option>
                                            <option value="max">最大值</option>
                                            <option value="extended_stats">标准差</option>
                                            <option value="cardinality">去重计数</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 input-form"
                                         id="statistic-filed-input<?php echo $statistics_row; ?>" style="display: none">
                                        <label class="col-md-3 input-label"
                                               for="statistic-field<?php echo $statistics_row; ?>">选择字段:</label>
                                        <select class="col-md-8 input-value field-select" type="number"
                                                id="statistic-field<?php echo $statistics_row; ?>">
                                        </select>
                                    </div>
                                </td>
                                <td style="width: 10%">
                                    <button type="button"
                                            onclick="$('#statistics-row<?php echo $statistics_row; ?>').remove();"
                                            data-toggle="tooltip" title="移除该统计" class="btn btn-danger"><i
                                                class="fa fa-minus-circle"></i></button>
                                </td>
                            </tr>
                            </tbody>
                            <?php $statistics_row++; ?>
                            <tfoot>
                            <tr id="statistics-row<?php echo $statistics_row; ?>">
                                <td style="width: 90%">
                                </td>
                                <td style="width: 10%">
                                    <button type="button" onclick="addStatistics();" data-toggle="tooltip"
                                            title="添加新的统计项" class="btn btn-primary"><i class="fa fa-plus-circle"></i>
                                    </button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="row option-group">
                        <div>
                            <p class="option-title">聚合维度</p>
                        </div>
                        <?php $aggs_row = 0; ?>
                        <table id="aggs" class="agg-table">
                            <tbody>
                            <tr id="aggs-row<?php echo $aggs_row; ?>">
                                <td style="width: 90%">
                                    <div>
                                        <div class="col-md-6 input-form">
                                            <label class="col-md-2 input-label" for="aggs-name<?php echo $aggs_row; ?>">聚合名称:</label>
                                            <input id="aggs-name<?php echo $aggs_row; ?>" class="col-md-9 input-value"
                                                   value="时间聚合<?php echo $aggs_row; ?>">
                                        </div>
                                    </div>
                                    <div class="col-md-6 input-form">
                                        <label class="col-md-3 input-label" for="aggs-type<?php echo $aggs_row; ?>">聚合类型:</label>
                                        <select class="col-md-8 input-value" id="aggs-type<?php echo $aggs_row; ?>"
                                                onchange="aggsChange(this)">
                                            <option value="date_histogram" selected>时间聚合</option>
                                            <option value="terms">字段聚合</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 input-form" id="input-aggs-field<?php echo $aggs_row; ?>">
                                        <label class="col-md-3 input-label" for="aggs-field<?php echo $aggs_row; ?>">选择字段:</label>
                                        <select class="col-md-8 input-value field-select" type="date"
                                                id="aggs-field<?php echo $aggs_row; ?>"></select>
                                    </div>
                                    <div class="col-md-6 input-form" id="input-aggs-interval<?php echo $aggs_row; ?>">
                                        <label class="col-md-3 input-label" for="aggs-interval<?php echo $aggs_row; ?>">时间间隔:</label>
                                        <select class="col-md-8 input-value" id="aggs-interval<?php echo $aggs_row; ?>">
                                            <option value="3h">3小时</option>
                                            <option value="6h">6小时</option>
                                            <option value="12h">12小时</option>
                                            <option value="24h" selected>24小时</option>
                                        </select>
                                    </div>
                                </td>
                                <td style="width: 10%">
                                    <button type="button" onclick="$('#aggs-row<?php echo $aggs_row; ?>').remove();"
                                            data-toggle="tooltip" title="移除该聚合" class="btn btn-danger"><i
                                                class="fa fa-minus-circle"></i></button>
                                </td>
                            </tr>
                            </tbody>
                            <?php $aggs_row++; ?>
                            <tfoot>
                            <tr>
                                <td style="width: 90%"></td>
                                <td style="width: 10%">
                                    <button type="button" onclick="addAggs();" data-toggle="tooltip"
                                            title="添加新的聚合" class="btn btn-primary"><i class="fa fa-plus-circle"></i>
                                    </button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div>
                        <div class="col-md-offset-4  col-md-4 input-form">
                            <button id="log-search">查询</button>
                        </div>
                    </div>
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
</div>
<?php echo $footer; ?>
<script>
    var aggs_row =<?php echo  $aggs_row; ?>;
    var statistics_row = <?php echo $statistics_row; ?>;

    var aggs = [];
    var statistics = [];
    var statistic_result = null;


    function statisticalChange(changeObject) {
        console.log("this is test");
        var id_name = changeObject.id;
        var statistic_row = (id_name.substr(id_name.length - 1));
        var field_id = "#statistic-filed-input" + statistic_row;
        var select_field_id = "#statistic-field" + statistic_row;
        if (changeObject.value != "count" && changeObject.value != "cardinality" ) {
            $(field_id).show();
            var log_source = $("#log-source").val();
            var para_array = get_all_parameters(log_source);
            para_array.then(function (resp) {
                var data = JSON.parse(resp.hits.hits[0]._source.fields);
                var result = [];
                for (var i = 0; i < data.length; i++) {
                    if (data[i].type == 'number' && data[i].name[0] != "_" &&
                            data[i].name.substring(0, 5) != "geoip")
                        result.push(data[i].name)
                }
                var select_con = $(select_field_id);
                select_con.empty();
                select_con.attr('type', "number")
                for (var item in result) {
                    select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                }
            });
        } else if (changeObject.value == "cardinality") {
            $(field_id).show();
            var log_source = $("#log-source").val();
            var para_array = get_all_parameters(log_source);
            para_array.then(function (resp) {
                var data = JSON.parse(resp.hits.hits[0]._source.fields);
                var result = [];
                for (var i = 0; i < data.length; i++) {
                    if (data[i].type != 'date' && data[i].name[0] != "_" &&
                            data[i].name.substring(0, 5) != "geoip")
                        result.push(data[i].name)
                }
                var select_con = $(select_field_id);
                select_con.empty();
                select_con.attr('type', "str");
                for (var item in result) {
                    select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                }
            });
        } else {
            $(field_id).hide();
        }
        var show_text = $('#statistic-type' + statistic_row + ' option[value=\'' + changeObject.value + '\']').text().trim()
        $('#statistic-name' + statistic_row).attr('value', show_text + statistic_row);
    }
    function aggsChange(changeObject) {
        console.log("this is test");
        var id_name = changeObject.id;
        var aggs_row = (id_name.substr(id_name.length - 1));
        var aggs_con = $('#aggs-row' + aggs_row + ' td:first');
        if (changeObject.value == "date_histogram") {
            html = '<div class="col-md-6 input-form" id="input-aggs-interval' + aggs_row + '"> ' +
                    '<label class="col-md-3 input-label" for="aggs-interval' + aggs_row + '">时间间隔:</label>' +
                    '<select class="col-md-8 input-value" id="aggs-interval' + aggs_row + '">' +
                    '<option value="3h">3小时</option>' +
                    '<option value="6h">6小时</option>' +
                    '<option value="12h">12小时</option>' +
                    '<option value="24h" selected>24小时</option></select></div>';
            aggs_con.append(html);
            var field_id = '#aggs-field' + aggs_row;
            var log_source = $("#log-source").val();
            var para_array = get_all_parameters(log_source);
            $('#aggs-name' + aggs_row).attr('value', "时间聚合" + aggs_row);
            para_array.then(function (resp) {
                var data = JSON.parse(resp.hits.hits[0]._source.fields);
                var result = [];
                for (var i = 0; i < data.length; i++) {
                    if (data[i].type == 'date' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                        result.push(data[i].name)
                }
                var select_con = $(field_id);
                select_con.empty();
                select_con.attr('type', "date")
                for (var item in result) {
                    select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                }
            });

        } else if (changeObject.value == "terms") {
            $('#input-aggs-interval' + aggs_row).remove();
            var field_id = '#aggs-field' + aggs_row;
            var log_source = $("#log-source").val();
            var para_array = get_all_parameters(log_source);
            $('#aggs-name' + aggs_row).attr('value', "字段聚合" + aggs_row);
            para_array.then(function (resp) {
                var data = JSON.parse(resp.hits.hits[0]._source.fields);
                var result = [];
                for (var i = 0; i < data.length; i++) {
                    if (data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                        result.push(data[i].name)
                }
                var select_con = $(field_id);
                select_con.empty();
                select_con.attr('type', "str");
                for (var item in result) {
                    select_con.append($("<option>").attr('value', result[item]).text(result[item]));
                }
            });
        } else {
            console.log("unknown command!")
        }
    }

    function addStatistics() {
        html = '<tr id="statistics-row' + statistics_row + '">'
        html += '<td style="width: 90%">' +
                '<div><div class="col-md-6 input-form">' +
                '<label class="col-md-2 input-label" for="statistic-name' + statistics_row + '">统计名称:</label>' +
                '<input id="statistic-name' + statistics_row + '" class="col-md-9 input-value" value="日志条目' + statistics_row + '">' +
                '</div></div>' +
                '<div class="col-md-6 input-form">' +
                '<label class="col-md-3 input-label" for="statistic-type' + statistics_row + '">统计类型:</label>' +
                '<select class="col-md-8 input-value" type="statistic-type-select" id="statistic-type' + statistics_row + '" onchange="statisticalChange(this)"><option value="count" selected>日志条目</option>' +
                '<option value="avg">平均值</option>' +
                '<option value="sum">求和</option>' +
                '<option value="median">中位数</option>' +
                '<option value="min">最小值</option>' +
                '<option value="max">最大值</option>' +
                '<option value="extended_stats">标准差</option>' +
                '<option value="unique_count">去重计数</option></select></div>' +
                '<div class="col-md-6 input-form" id="statistic-filed-input' + statistics_row + '" style="display: none">' +
                '<label class="col-md-3 input-label" for="statistic-field' + statistics_row + '">选择字段:</label>' +
                '<select class="col-md-8 input-value field-select" type="number" id="statistic-field' + statistics_row + '">' +
                '</select></div></td><td style="width: 10%">' +
                '<button type="button" onclick="$(\'#statistics-row' + statistics_row + '\').remove();"' +
                'data-toggle="tooltip" title="移除该统计" class="btn btn-danger"><i class="fa fa-minus-circle"></i>' +
                '</button></td></tr>';
        $('#statistics tbody').append(html);

        statistics_row++;
    }
    function addAggs() {
        html = '<tr id="aggs-row' + aggs_row + '">';
        html += '<td style="width: 90%">' +
                '<div><div class="col-md-6 input-form">' +
                '<label class="col-md-2 input-label" for="aggs-name' + aggs_row + '">聚合名称:</label>' +
                '<input id="aggs-name' + aggs_row + '" class="col-md-9 input-value" value="时间聚合' + aggs_row + '">' +
                '</div></div>' +
                '<div class="col-md-6 input-form"><label class="col-md-3 input-label" for="aggs-type' + aggs_row + '">聚合类型:</label>' +
                '<select class="col-md-8 input-value" id="aggs-type' + aggs_row + '" onchange="aggsChange(this)">' +
                '<option value="date_histogram" selected>时间聚合</option>' +
                '<option value="terms">字段聚合</option>' +
                '</select></div>' +
                '<div class="col-md-6 input-form" id="input-aggs-field' + aggs_row + '">' +
                '<label class="col-md-3 input-label" for="aggs-field' + aggs_row + '">选择字段:</label>' +
                '<select class="col-md-8 input-value" id="aggs-field' + aggs_row + '"></select>' +
                '</div><div class="col-md-6 input-form" id="input-aggs-interval' + aggs_row + '"> ' +
                '<label class="col-md-3 input-label" for="aggs-interval' + aggs_row + '">时间间隔:</label>' +
                '<select class="col-md-8 input-value field-select" type="date" id="aggs-interval' + aggs_row + '">' +
                '<option value="3h">3小时</option>' +
                '<option value="6h">6小时</option>' +
                '<option value="12h">12小时</option>' +
                '<option value="24h" selected>24小时</option></select></div>' +
                '</td>' +
                '<td style="width: 10%">' +
                '<button type="button" ' +
                'onclick="$(\'#aggs-row' + aggs_row + '\').remove();" ' +
                'data-toggle="tooltip" title="移除该聚合" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>' + '</td>'
        html += '</tr>';

        $('#aggs tbody').append(html);

        var field_id = '#aggs-field' + aggs_row;
        var log_source = $("#log-source").val();
        var para_array = get_all_parameters(log_source);
        para_array.then(function (resp) {
            var data = JSON.parse(resp.hits.hits[0]._source.fields);
            var result = [];
            for (var i = 0; i < data.length; i++) {
                if (data[i].type == 'date' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                    result.push(data[i].name)
            }
            var select_con = $(field_id);
            select_con.empty();
            for (var item in result) {
                select_con.append($("<option>").attr('value', result[item]).text(result[item]));
            }
        });

        aggs_row++;
    }

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
    function normalized(value){
        if (value.hasOwnProperty('key_as_string')) {
            if (value['key_as_string'].length == 29){
            var log_date = new Date(value.key_as_string);
            value.time = format(log_date);
            delete value.key_as_string;
            }
        }
        for (var k in value){
            if (value.hasOwnProperty(k)) {
                if(isObject(value[k]))
                {
                    if(value[k].hasOwnProperty('buckets')){
                        value[k] = value[k]['buckets'];
                    }
                    normalized(value[k])
                    if(value[k].hasOwnProperty('value')){
                        value[k] = value[k]['value'];
                    }
                    if(value[k].hasOwnProperty('std_deviation_bounds')){
                        value[k]['upper'] = value[k]['std_deviation_bounds']['upper'];
                        value[k]['lower'] = value[k]['std_deviation_bounds']['lower'];
                        delete value[k]['std_deviation_bounds'];
                        delete value[k]['min'];
                        delete value[k]['max'];
                        delete value[k]['count'];
                        var num = new Number(value[k]['avg']);
                        value[k]['avg'] = num.toFixed(2)
                        num = Number(value[k]['variance']);
                        value[k]['avriance'] = num.toFixed(2)
                        num = Number(value[k]['std_deviation']);
                        value[k]['std_deviation'] = num.toFixed(2)
                        num = Number(value[k]['upper']);
                        value[k]['upper'] = num.toFixed(2)
                        num = Number(value[k]['lower']);
                        value[k]['lower'] = num.toFixed(2)
                        value[k] = [value[k]];
                    }
                }
            }
        }
    }
    function changeResult(value, index, ar) {
        normalized(value)
    }
    $(document).ready(function () {
        var container = $('#query-result').css('display', 'none');
        var start_time = DateAdd("d ", -17, setStartDay(new Date()));
        var end_time = DateAdd("d ", -2, setEndDay(new Date()));
        var date_ranger = $('#log-date-ranger');
        date_ranger.attr("value", start_time.Format("yyyy-MM-dd HH:mm:ss") + " - " + end_time.Format("yyyy-MM-dd HH:mm:ss"));

        date_ranger.daterangepicker({
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

        var field_id = '#aggs-field0';
        var log_source = $("#log-source").val();
        var para_array = get_all_parameters(log_source);
        para_array.then(function (resp) {
            var data = JSON.parse(resp.hits.hits[0]._source.fields);
            var result = [];
            for (var i = 0; i < data.length; i++) {
                if (data[i].type == 'date' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                    result.push(data[i].name)
            }
            var select_con = $(field_id);
            select_con.empty();
            for (var item in result) {
                select_con.append($("<option>").attr('value', result[item]).text(result[item]));
            }
        });


        $("#log-source").change(
                function () {
                    statistic_result = null;
                    aggs = [];
                    statistics = [];
                    var select_cons = $('.field-select');
                    select_cons.empty()
                    var log_source = $("#log-source").val();
                    var para_array = get_all_parameters(log_source);
                    para_array.then(function (resp) {
                        var data = JSON.parse(resp.hits.hits[0]._source.fields);
                        for (var index = 0; index < select_cons.length; index++) {
                            var result = [];
                            var jquery_object = $(select_cons[index]);
                            if (jquery_object.attr('type') == "str") {
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].type != 'date' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                                        result.push(data[i].name)
                                }
                                for (var item in result) {
                                    jquery_object.append($("<option>").attr('value', result[item]).text(result[item]));
                                }

                            } else if (jquery_object.attr('type') == "date") {
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].type == 'date' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                                        result.push(data[i].name)
                                }
                                for (var item in result) {
                                    jquery_object.append($("<option>").attr('value', result[item]).text(result[item]));
                                }

                            } else if (jquery_object.attr('type') == "number") {
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].type == 'number' && data[i].name[0] != "_" && data[i].name.substring(0, 5) != "geoip")
                                        result.push(data[i].name)
                                }
                                for (var item in result) {
                                    jquery_object.append($("<option>").attr('value', result[item]).text(result[item]));
                                }

                            } else {

                            }
                        }
                    });
                }
        );

        $("#log-search").click(
                function () {
                    statistic_result = null;
                    aggs = [];
                    statistics = [];
                    var log_source = $("#log-source").val();
                    var query = $("#log-query").val();
                    var statistics_obj = $('#statistics tbody tr');
                    for (var index = 0; index < statistics_obj.length; index++) {
                        var jquery_object = $(statistics_obj[index]);
                        var select_cons = jquery_object.children('td:first').children('div').children('select');
                        var input_cons = jquery_object.children('td:first').children('div').children('div').children('input');
                        var name = $(input_cons[0]).val();
                        var type = $(select_cons[0]).val();
                        if (type != "count") {
                            var field = $(select_cons[1]).val();
                        }
                        statistics.push({name, type, field});
                    }

                    var aggs_obj = $('#aggs tbody tr');
                    for (var index = 0; index < aggs_obj.length; index++) {
                        var jquery_object = $(aggs_obj[index]);
                        var select_cons = jquery_object.children('td:first').children('div').children('select');
                        var input_cons = jquery_object.children('td:first').children('div').children('div').children('input');
                        var name = $(input_cons[0]).val();
                        var type = $(select_cons[0]).val();
                        var field = $(select_cons[1]).val();
                        var interval = $(select_cons[2]).val();
                        aggs.push({name, type, field, interval});
                    }

                    var elas_query = build_query(start_time, end_time, query, statistics, aggs);

                    var log_data = get_log_statistics(log_source, start_time, end_time, elas_query);
                    log_data.then(function (resp) {
                        var aggs_name = aggs[0].name;
                        var aggs_type = aggs[0].type;
                        statistic_result = resp.aggregations[aggs_name].buckets;

                        format = d3.time.format("%m月%d日%H时");
                        statistic_result.forEach(changeResult);

                        draw_data(statistic_result, 'source');
                    });
                }
        );
        $("#result-source").click(
                function () {
                    draw_data(statistic_result, 'source');
                });
        $("#result-table").click(
                function () {
                    draw_data(statistic_result, 'table');
                });


    });
</script>