function getURLVar(key) {
    var value = [];

    var query = String(document.location).split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }

        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}

function randomString(len) {
    len = len || 32;
    var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';    /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
    var maxPos = $chars.length;
    var pwd = '';
    for (i = 0; i < len; i++) {
        pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
    }
    return pwd;
}

var format = d3.time.format("%m月%d日%H时");
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
            else{
                try
                {
                    if(String(value[k]).indexOf(".")>-1) {
                        num = Number(value[k]);
                        value[k] = num.toFixed(2)
                    }
                }
                catch(err)
                {
                }
            }
        }
    }
}
function changeResult(value, index, ar) {
    normalized(value)
}


function produceChartOption(source_data, option){
    if(option['type'] == 'gridchart'){
        chartOption = {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            legend: {
                data:[]
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis : [
                {
                    type : 'category',
                    data : []
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : []
        };
        for (var j=0; j<option['yaxis'].length; j ++){
            chartOption['legend']['data'].push(option['yaxis'][j]['name']);
            serie = {};
            serie['name'] = option['yaxis'][j]['name'];
            serie['type'] = 'bar';
            serie['data'] = []
            for(var m= 0; m<source_data.length; m++){
                serie['data'].push(source_data[m][option['yaxis'][j]['source']]);
            }
            chartOption['series'].push(serie);
        }
        xaxis_source = option['xaxis']['source'];
        for(var m= 0; m<source_data.length; m++){
            chartOption['xAxis'][0]['data'].push(source_data[m][xaxis_source]);
        }

        return chartOption;

    } else if (option['type'] == 'linechart') {

    }
}

/*
 * 检测对象是否是空对象(不包含任何可读属性)。
 * 方法既检测对象本身的属性，也检测从原型继承的属性(因此没有使hasOwnProperty)。
 */
function isEmpty(obj) {
    for (var name in obj)
    {
        return false;
    }
    return true;
};

/*
 * 检测对象是否是否是object。
 */
function isObject(obj) {
    return Object.prototype.toString.call(obj) === '[object Object]';
}


function syntaxHighlight(json) {
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
            } else {
                cls = 'string';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
        } else if (/null/.test(match)) {
            cls = 'null';
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}


//导出到excel
function AutomateExcel() {
    var html = d3.select("svg")
        .attr("version", 1.1)
        .attr("xmlns", "http://www.w3.org/2000/svg")
        .node().parentNode.innerHTML;

    //console.log(html);
    var imgsrc = 'data:image/svg+xml;base64,' + btoa(unescape(encodeURIComponent(html)));
    var img = '<img src="' + imgsrc + '">';
    d3.select("#svgdataurl").html(img);


    var canvas = document.querySelector("canvas");
    var context = canvas.getContext("2d");

    var image = new Image;
    image.src = imgsrc;
    image.onload = function () {
        context.drawImage(image, 0, 0);

        var canvasdata = canvas.toDataURL("image/png");

        var pngimg = '<img src="' + canvasdata + '">';
        d3.select("#pngdataurl").html(pngimg);

        var a = document.createElement("a");
        a.download = "sample.png";
        a.href = canvasdata;
        a.click();
    };

}

/*
 *   功能:实现VBScript的DateAdd功能.
 *   参数:interval,字符串表达式，表示要添加的时间间隔.
 *   参数:number,数值表达式，表示要添加的时间间隔的个数.
 *   参数:date,时间对象.
 *   返回:新的时间对象.
 *   var now = new Date();
 *   var newDate = DateAdd( "d", 5, now);
 *---------------   DateAdd(interval,number,date)   -----------------
 */
function DateAdd(interval, number, date) {
    switch (interval) {
        case "y ":
        {
            date.setFullYear(date.getFullYear() + number);
            return date;
            break;
        }
        case "q ":
        {
            date.setMonth(date.getMonth() + number * 3);
            return date;
            break;
        }
        case "m ":
        {
            date.setMonth(date.getMonth() + number);
            return date;
            break;
        }
        case "w ":
        {
            date.setDate(date.getDate() + number * 7);
            return date;
            break;
        }
        case "d ":
        {
            date.setDate(date.getDate() + number);
            return date;
            break;
        }
        case "h ":
        {
            date.setHours(date.getHours() + number);
            return date;
            break;
        }
        case "m ":
        {
            date.setMinutes(date.getMinutes() + number);
            return date;
            break;
        }
        case "s ":
        {
            date.setSeconds(date.getSeconds() + number);
            return date;
            break;
        }
        default:
        {
            date.setDate(date.getDate() + number);
            return date;
            break;
        }
    }
}

function setEndDay(date) {
    date.setHours(23);
    date.setMinutes(59);
    date.setSeconds(59);
    return date;
}
function setStartDay(date) {
    date.setHours(0);
    date.setMinutes(0);
    date.setSeconds(0);
    return date;
}


var data_server = ['http://yf-wise-gate44.yf01.baidu.com:8200', 'http://yf-wise-gate46.yf01.baidu.com:8200', 'http://yf-wise-gate47.yf01.baidu.com:8200'];

var zh = d3.locale({
    decimal: ".",
    thousands: ",",
    grouping: [3],
    currency: ["¥", ""],
    dateTime: "%a %b %e %X %Y",
    date: "%Y/%-m/%-d",
    time: "%H:%M:%S",
    periods: ["上午", "下午"],
    days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
    shortDays: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
    months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    shortMonths: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
});
var interval_format = {
    "d": d3.time.format("%m月%d日"),
    "h": d3.time.format("%d日%H时"),
    "M": d3.time.format("%H时%M分")
};
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function makeFunc() {
    var key, numargs = arguments.length;
    for (i = 0; i < numargs; i++) {
        key += arguments[i] + "$$";
    }

    var value = null;
    var args = Array.prototype.slice.call(arguments);
    var jqxhr = $.post("index.php?route=api/dataservice/get",
        {key: key}, function (data) {
            if (data) {
                alert(data)
            }
            else {
                var func = args.shift();
                return function () {
                    value = func.apply(null, args.concat(Array.prototype.slice.call(arguments)));
                };
            }
        });

    $.post("index.php?route=api/dataservice/put",
        {key: key}, function (data) {
            if (data) {
                alert(data);
            }
        });
}

var getFnName = function (callee) {
    var _callee = callee.toString().replace(/[\s\?]*/g, ""),
        comb = _callee.length >= 50 ? 50 : _callee.length;
    _callee = _callee.substring(0, comb);
    var name = _callee.match(/^function([^\(]+?)\(/);
    if (name && name[1]) {
        return name[1];
    }
    var caller = callee.caller,
        _caller = caller.toString().replace(/[\s\?]*/g, "");
    var last = _caller.indexOf(_callee),
        str = _caller.substring(last - 30, last);
    name = str.match(/var([^\=]+?)\=/);
    if (name && name[1]) {
        return name[1];
    }
    return "anonymous"
};

function get_all_parameters(log_source, log_type) {
    var elc_client = new elasticsearch.Client({hosts: data_server});
    esp = elc_client.search({
            size: 1,
            index: ".kibana",
            type: "index-pattern",
            body: build_parameter_query(log_source)
        });
    return esp;
}
function draw_pv_uv_svg(start_day, end_day, svg_container, table_container, query, interval, cards) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
    interval = interval || '24h';
    var format = interval_format.h;
    if (interval == "24h") {
        format = interval_format.d
    }
    if (interval[interval.length - 1] == "M") {
        format = interval_format.M
    }

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 5,
            index: "logstash-search-*",
            body: build_pv_uv_query(start_time_stamp, end_time_stamp, query, interval, cards)
        })
        .then(function (resp) {
            // D3 code goes here.
            $(svg_container).html("<svg xmlns='http://www.w3.org/2000/svg' width='100%'></svg>");

            var data = resp.aggregations.statistics.buckets;

            data.forEach(function (d) {
                d.date = new Date(d.key_as_string);
                d.日期 = format(d.date);
                d.pv = d.PV.value;
                d.uv = d.UV.value;
                d.click = d.Click.value
            });

            var start = data[0].date;
            var end = data[data.length - 1].date;

            var margin = {top: 20, right: 70, bottom: 30, left: 70},
                width = $(svg_container).width(),
                height = 500;
            var container = d3.select(svg_container).select('svg')
                .attr('class', 'collect-svg')
                .attr('width', width)
                .attr('height', height);
            width = width - margin.left - margin.right;
            height = height - margin.top - margin.bottom;
            var svg = container.append('g')
                .attr('class', 'content')
                .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

            // 添加一个table表格
            function tabulate(data, columns) {
                d3.select(table_container).select('table').remove();
                var table = d3.select(table_container).append('table')
                    .attr('width', width + margin.left + margin.right)
                    .attr('height', height + margin.top + margin.bottom)
                    .attr('class', 'xiangyun_table')
                    .attr('id', 'collect-table');

                thead = table.append("thead");
                tbody = table.append("tbody");

                // append the header row
                thead.append("tr")
                    .selectAll("th")
                    .data(columns)
                    .enter()
                    .append("th")
                    .text(function (column) {
                        return column;
                    });

                // create a row for each object in the data
                var rows = tbody.selectAll("tr")
                    .data(data)
                    .enter()
                    .append("tr");

                // create a cell in each row for each column
                var cells = rows.selectAll("td")
                    .data(function (row) {
                        return columns.map(function (column) {
                            return {column: column, value: row[column]};
                        });
                    })
                    .enter()
                    .append("td")
                    .html(function (d) {
                        return d.value;
                    });

                return table;
            };

            var peopleTable = tabulate(data, ["日期", "pv", 'uv', 'click']);

            var x = d3.time.scale()
                .domain([start, end])
                .range([0, width]);

            var y = d3.scale.linear()
                .domain([d3.min(data, function (d) {
                    return Math.min(d.pv, d.uv, d.click);
                }),
                    d3.max(data, function (d) {
                        return Math.max(d.pv, d.uv, d.click);
                    })])
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .tickFormat(format)
                .orient('bottom')
                .ticks(10);

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left')
                .ticks(10);

            svg.append('g')
                .attr('class', 'x axis')
                .attr('transform', 'translate(0,' + height + ')')
                .call(xAxis)
                // 增加坐标值说明
                .append('text')
                .text('日期')
                .attr('transform', 'translate(' + width + ', 0)');

            // 纵坐标
            svg.append('g')
                .attr('class', 'y axis')
                .call(yAxis)
                .attr("y", 6)
                .attr("dy", ".71em")
                .append('text')
                .text('次/天');

            var line_pv = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.pv);
                });

            var line_uv = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.uv);
                });

            var line_click = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.click);
                });

            x.domain(d3.extent(data, function (d) {
                return d.date;
            }));
            y.domain([d3.min(data, function (d) {
                return Math.min(d.pv, d.uv, d.click);
            }),
                d3.max(data, function (d) {
                    return Math.max(d.pv, d.uv, d.click);
                })]);

            var pv_line = svg.append("path")
                .datum(data)
                .attr("class", "line-pv")
                .attr("d", line_pv);

            var uv_line = svg.append("path")
                .datum(data)
                .attr("class", "line-uv")
                .attr("d", line_uv);

            var click_line = svg.append("path")
                .datum(data)
                .attr("class", "line-click")
                .attr("d", line_click);

            svg.append('g').attr('class', 'line-pv-tips');
            svg.append('g').attr('class', 'line-uv-tips');
            svg.append('g').attr('class', 'line-click-tips');

            var g = svg.select('.line-pv-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_pv.x())
                .attr('cy', line_pv.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var g = svg.select('.line-uv-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_uv.x())
                .attr('cy', line_uv.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var g = svg.select('.line-click-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_click.x())
                .attr('cy', line_click.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var tips = svg.append('g').attr('class', 'tips');

            tips.append('rect')
                .attr('class', 'tips-border')
                .attr('width', 200)
                .attr('height', 50)
                .attr('rx', 10)
                .attr('ry', 10);

            var wording1 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 20)
                .text('');

            var wording2 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 40)
                .text('');

            pv_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text('PV' + '：' + d.pv);

                    var x1 = x(d.date),
                        y1 = y(d.pv);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

            uv_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text("uv" + '：' + d.uv);

                    var x1 = x(d.date),
                        y1 = y(d.uv);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

            click_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text("click" + '：' + d.click);

                    var x1 = x(d.date),
                        y1 = y(d.click);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

        });

}

function draw_only_click_svg(start_day, end_day, svg_container, table_container, query, interval, cards) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
    interval = interval || '24h';
    var format = interval_format.h;
    if (interval == "24h") {
        format = interval_format.d
    }
    if (interval[interval.length - 1] == "M") {
        format = interval_format.M
    }

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 5,
            index: "logstash-click-search-*",
            body: build_only_click_query(start_time_stamp, end_time_stamp, query, interval, cards)
        })
        .then(function (resp) {
            // D3 code goes here.
            $(svg_container).html("<svg xmlns='http://www.w3.org/2000/svg' width='100%'></svg>");

            var data = resp.aggregations.statistics.buckets;

            data.forEach(function (d) {
                d.date = new Date(d.key_as_string);
                d.日期 = format(d.date);
                d.click = d.doc_count
            });

            var start = data[0].date;
            var end = data[data.length - 1].date;

            var margin = {top: 20, right: 70, bottom: 30, left: 70},
                width = $(svg_container).width(),
                height = 500;
            var container = d3.select(svg_container).select('svg')
                .attr('class', 'collect-svg')
                .attr('width', width)
                .attr('height', height);
            width = width - margin.left - margin.right;
            height = height - margin.top - margin.bottom;
            var svg = container.append('g')
                .attr('class', 'content')
                .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

            // 添加一个table表格
            function tabulate(data, columns) {
                d3.select(table_container).select('table').remove();
                var table = d3.select(table_container).append('table')
                    .attr('width', width + margin.left + margin.right)
                    .attr('height', height + margin.top + margin.bottom)
                    .attr('class', 'xiangyun_table')
                    .attr('id', 'collect-table');

                thead = table.append("thead");
                tbody = table.append("tbody");

                // append the header row
                thead.append("tr")
                    .selectAll("th")
                    .data(columns)
                    .enter()
                    .append("th")
                    .text(function (column) {
                        return column;
                    });

                // create a row for each object in the data
                var rows = tbody.selectAll("tr")
                    .data(data)
                    .enter()
                    .append("tr");

                // create a cell in each row for each column
                var cells = rows.selectAll("td")
                    .data(function (row) {
                        return columns.map(function (column) {
                            return {column: column, value: row[column]};
                        });
                    })
                    .enter()
                    .append("td")
                    .html(function (d) {
                        return d.value;
                    });

                return table;
            };

            var peopleTable = tabulate(data, ["日期",'click']);

            var x = d3.time.scale()
                .domain([start, end])
                .range([0, width]);

            var y = d3.scale.linear()
                .domain([d3.min(data, function (d) {
                    return d.click;
                }),
                    d3.max(data, function (d) {
                        return d.click;
                    })])
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .tickFormat(format)
                .orient('bottom')
                .ticks(10);

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left')
                .ticks(10);

            svg.append('g')
                .attr('class', 'x axis')
                .attr('transform', 'translate(0,' + height + ')')
                .call(xAxis)
                // 增加坐标值说明
                .append('text')
                .text('日期')
                .attr('transform', 'translate(' + width + ', 0)');

            // 纵坐标
            svg.append('g')
                .attr('class', 'y axis')
                .call(yAxis)
                .attr("y", 6)
                .attr("dy", ".71em")
                .append('text')
                .text('次/天');

            var line_click = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.click);
                });

            x.domain(d3.extent(data, function (d) {
                return d.date;
            }));
            y.domain([d3.min(data, function (d) {
                return  d.click;
            }),
                d3.max(data, function (d) {
                    return d.click;
                })]);


            var click_line = svg.append("path")
                .datum(data)
                .attr("class", "line-click")
                .attr("d", line_click);

            svg.append('g').attr('class', 'line-click-tips');

            var g = svg.select('.line-click-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_click.x())
                .attr('cy', line_click.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var tips = svg.append('g').attr('class', 'tips');

            tips.append('rect')
                .attr('class', 'tips-border')
                .attr('width', 200)
                .attr('height', 50)
                .attr('rx', 10)
                .attr('ry', 10);

            var wording1 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 20)
                .text('');

            var wording2 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 40)
                .text('');

            click_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text("click" + '：' + d.click);

                    var x1 = x(d.date),
                        y1 = y(d.click);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

        });

}

function draw_only_pv_uv_svg(start_day, end_day, svg_container, table_container, query, interval, cards) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
    interval = interval || '24h';
    var format = interval_format.h;
    if (interval == "24h") {
        format = interval_format.d
    }
    if (interval[interval.length - 1] == "M") {
        format = interval_format.M
    }

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 5,
            index: "logstash-disp-search-*",
            body: build_only_pv_uv_query(start_time_stamp, end_time_stamp, query, interval, cards)
        })
        .then(function (resp) {
            // D3 code goes here.
            $(svg_container).html("<svg xmlns='http://www.w3.org/2000/svg' width='100%'></svg>");

            var data = resp.aggregations.statistics.buckets;

            data.forEach(function (d) {
                d.date = new Date(d.key_as_string);
                d.日期 = format(d.date);
                d.pv = d.doc_count;
                d.uv = d.UV.value;
            });

            var start = data[0].date;
            var end = data[data.length - 1].date;

            var margin = {top: 20, right: 70, bottom: 30, left: 70},
                width = $(svg_container).width(),
                height = 500;
            var container = d3.select(svg_container).select('svg')
                .attr('class', 'collect-svg')
                .attr('width', width)
                .attr('height', height);
            width = width - margin.left - margin.right;
            height = height - margin.top - margin.bottom;
            var svg = container.append('g')
                .attr('class', 'content')
                .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

            // 添加一个table表格
            function tabulate(data, columns) {
                d3.select(table_container).select('table').remove();
                var table = d3.select(table_container).append('table')
                    .attr('width', width + margin.left + margin.right)
                    .attr('height', height + margin.top + margin.bottom)
                    .attr('class', 'xiangyun_table')
                    .attr('id', 'collect-table');

                thead = table.append("thead");
                tbody = table.append("tbody");

                // append the header row
                thead.append("tr")
                    .selectAll("th")
                    .data(columns)
                    .enter()
                    .append("th")
                    .text(function (column) {
                        return column;
                    });

                // create a row for each object in the data
                var rows = tbody.selectAll("tr")
                    .data(data)
                    .enter()
                    .append("tr");

                // create a cell in each row for each column
                var cells = rows.selectAll("td")
                    .data(function (row) {
                        return columns.map(function (column) {
                            return {column: column, value: row[column]};
                        });
                    })
                    .enter()
                    .append("td")
                    .html(function (d) {
                        return d.value;
                    });

                return table;
            };

            var peopleTable = tabulate(data, ["日期", "pv", 'uv']);

            var x = d3.time.scale()
                .domain([start, end])
                .range([0, width]);

            var y = d3.scale.linear()
                .domain([d3.min(data, function (d) {
                    return Math.min(d.pv, d.uv, d.click);
                }),
                    d3.max(data, function (d) {
                        return Math.max(d.pv, d.uv, d.click);
                    })])
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .tickFormat(format)
                .orient('bottom')
                .ticks(10);

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left')
                .ticks(10);

            svg.append('g')
                .attr('class', 'x axis')
                .attr('transform', 'translate(0,' + height + ')')
                .call(xAxis)
                // 增加坐标值说明
                .append('text')
                .text('日期')
                .attr('transform', 'translate(' + width + ', 0)');

            // 纵坐标
            svg.append('g')
                .attr('class', 'y axis')
                .call(yAxis)
                .attr("y", 6)
                .attr("dy", ".71em")
                .append('text')
                .text('次/天');

            var line_pv = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.pv);
                });

            var line_uv = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.uv);
                });

            x.domain(d3.extent(data, function (d) {
                return d.date;
            }));
            y.domain([d3.min(data, function (d) {
                return Math.min(d.pv, d.uv);
            }),
                d3.max(data, function (d) {
                    return Math.max(d.pv, d.uv);
                })]);

            var pv_line = svg.append("path")
                .datum(data)
                .attr("class", "line-pv")
                .attr("d", line_pv);

            var uv_line = svg.append("path")
                .datum(data)
                .attr("class", "line-uv")
                .attr("d", line_uv);



            svg.append('g').attr('class', 'line-pv-tips');
            svg.append('g').attr('class', 'line-uv-tips');

            var g = svg.select('.line-pv-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_pv.x())
                .attr('cy', line_pv.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var g = svg.select('.line-uv-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_uv.x())
                .attr('cy', line_uv.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });


            var tips = svg.append('g').attr('class', 'tips');

            tips.append('rect')
                .attr('class', 'tips-border')
                .attr('width', 200)
                .attr('height', 50)
                .attr('rx', 10)
                .attr('ry', 10);

            var wording1 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 20)
                .text('');

            var wording2 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 40)
                .text('');

            pv_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text('PV' + '：' + d.pv);

                    var x1 = x(d.date),
                        y1 = y(d.pv);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

            uv_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text("uv" + '：' + d.uv);

                    var x1 = x(d.date),
                        y1 = y(d.uv);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

        });

}

function draw_pv_uv_svg_adv(start_day, end_day, svg_container, table_container, query, interval, cards) {
    var key = md5([getFnName(arguments.callee), end_day, svg_container, table_container, query, interval, cards].join("$$$"));
    var value = null;
    $.ajax({
        type: "POST",
        url: "index.php?route=api/dataservice/get",
        data: {key: key},
        success: function (data, textStatus) {
        },
        dataType: 'json',
        error: function () {
            var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
            var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
            interval = interval || '24h';
            var format = interval_format.h;
            if (interval == "24h") {
                format = interval_format.d
            }
            if (interval[interval.length - 1] == "M") {
                format = interval_format.M
            }

            var elc_client = new elasticsearch.Client({hosts: data_server});

            esp = elc_client.search({
                    size: 5,
                    index: "logstash-search-*",
                    body: build_pv_uv_query(start_time_stamp, end_time_stamp, query, interval, cards)
                })
                .then(function (resp) {
                    value = resp.aggregations.statistics.buckets;
                });
        }
    }).done(function () {
        // D3 code goes here.
        $(svg_container).html("<svg xmlns='http://www.w3.org/2000/svg' width='100%'></svg>");

        var data = value;

        data.forEach(function (d) {
            d.date = new Date(d.key_as_string);
            d.日期 = format(d.date);
            d.pv = d.PV.value;
            d.uv = d.UV.value;
            d.click = d.Click.value
        });

        var start = data[0].date;
        var end = data[data.length - 1].date;

        var margin = {top: 20, right: 70, bottom: 30, left: 70},
            width = $(svg_container).width(),
            height = 500;
        var container = d3.select(svg_container).select('svg')
            .attr('class', 'collect-svg')
            .attr('width', width)
            .attr('height', height);
        width = width - margin.left - margin.right;
        height = height - margin.top - margin.bottom;
        var svg = container.append('g')
            .attr('class', 'content')
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

        // 添加一个table表格
        function tabulate(data, columns) {
            d3.select(table_container).select('table').remove();
            var table = d3.select(table_container).append('table')
                .attr('width', width + margin.left + margin.right)
                .attr('height', height + margin.top + margin.bottom)
                .attr('class', 'xiangyun_table')
                .attr('id', 'collect-table');

            thead = table.append("thead");
            tbody = table.append("tbody");

            // append the header row
            thead.append("tr")
                .selectAll("th")
                .data(columns)
                .enter()
                .append("th")
                .text(function (column) {
                    return column;
                });

            // create a row for each object in the data
            var rows = tbody.selectAll("tr")
                .data(data)
                .enter()
                .append("tr");

            // create a cell in each row for each column
            var cells = rows.selectAll("td")
                .data(function (row) {
                    return columns.map(function (column) {
                        return {column: column, value: row[column]};
                    });
                })
                .enter()
                .append("td")
                .html(function (d) {
                    return d.value;
                });

            return table;
        };

        var peopleTable = tabulate(data, ["日期", "pv", 'uv', 'click']);

        var x = d3.time.scale()
            .domain([start, end])
            .range([0, width]);

        var y = d3.scale.linear()
            .domain([d3.min(data, function (d) {
                return Math.min(d.pv, d.uv, d.click);
            }),
                d3.max(data, function (d) {
                    return Math.max(d.pv, d.uv, d.click);
                })])
            .range([height, 0]);

        var xAxis = d3.svg.axis()
            .scale(x)
            .tickFormat(format)
            .orient('bottom')
            .ticks(10);

        var yAxis = d3.svg.axis()
            .scale(y)
            .orient('left')
            .ticks(10);

        svg.append('g')
            .attr('class', 'x axis')
            .attr('transform', 'translate(0,' + height + ')')
            .call(xAxis)
            // 增加坐标值说明
            .append('text')
            .text('日期')
            .attr('transform', 'translate(' + width + ', 0)');

        // 纵坐标
        svg.append('g')
            .attr('class', 'y axis')
            .call(yAxis)
            .attr("y", 6)
            .attr("dy", ".71em")
            .append('text')
            .text('次/天');

        var line_pv = d3.svg.line()
            .x(function (d) {
                return x(d.date);
            })
            .y(function (d) {
                return y(d.pv);
            });

        var line_uv = d3.svg.line()
            .x(function (d) {
                return x(d.date);
            })
            .y(function (d) {
                return y(d.uv);
            });

        var line_click = d3.svg.line()
            .x(function (d) {
                return x(d.date);
            })
            .y(function (d) {
                return y(d.click);
            });

        x.domain(d3.extent(data, function (d) {
            return d.date;
        }));
        y.domain([d3.min(data, function (d) {
            return Math.min(d.pv, d.uv, d.click);
        }),
            d3.max(data, function (d) {
                return Math.max(d.pv, d.uv, d.click);
            })]);

        var pv_line = svg.append("path")
            .datum(data)
            .attr("class", "line-pv")
            .attr("d", line_pv);

        var uv_line = svg.append("path")
            .datum(data)
            .attr("class", "line-uv")
            .attr("d", line_uv);

        var click_line = svg.append("path")
            .datum(data)
            .attr("class", "line-click")
            .attr("d", line_click);

        svg.append('g').attr('class', 'line-pv-tips');
        svg.append('g').attr('class', 'line-uv-tips');
        svg.append('g').attr('class', 'line-click-tips');

        var g = svg.select('.line-pv-tips').selectAll('circle')
            .data(data)
            .enter()
            .append('g')
            .append('circle')
            .attr('class', 'linecircle')
            .attr('cx', line_pv.x())
            .attr('cy', line_pv.y())
            .attr('r', 3.5)
            .on('mouseover', function () {
                d3.select(this).transition().duration(500).attr('r', 5);
            })
            .on('mouseout', function () {
                d3.select(this).transition().duration(500).attr('r', 3.5);
            });

        var g = svg.select('.line-uv-tips').selectAll('circle')
            .data(data)
            .enter()
            .append('g')
            .append('circle')
            .attr('class', 'linecircle')
            .attr('cx', line_uv.x())
            .attr('cy', line_uv.y())
            .attr('r', 3.5)
            .on('mouseover', function () {
                d3.select(this).transition().duration(500).attr('r', 5);
            })
            .on('mouseout', function () {
                d3.select(this).transition().duration(500).attr('r', 3.5);
            });

        var g = svg.select('.line-click-tips').selectAll('circle')
            .data(data)
            .enter()
            .append('g')
            .append('circle')
            .attr('class', 'linecircle')
            .attr('cx', line_click.x())
            .attr('cy', line_click.y())
            .attr('r', 3.5)
            .on('mouseover', function () {
                d3.select(this).transition().duration(500).attr('r', 5);
            })
            .on('mouseout', function () {
                d3.select(this).transition().duration(500).attr('r', 3.5);
            });

        var tips = svg.append('g').attr('class', 'tips');

        tips.append('rect')
            .attr('class', 'tips-border')
            .attr('width', 200)
            .attr('height', 50)
            .attr('rx', 10)
            .attr('ry', 10);

        var wording1 = tips.append('text')
            .attr('class', 'tips-text')
            .attr('x', 10)
            .attr('y', 20)
            .text('');

        var wording2 = tips.append('text')
            .attr('class', 'tips-text')
            .attr('x', 10)
            .attr('y', 40)
            .text('');

        pv_line
            .on('mousemove', function () {
                var m = d3.mouse(this),
                    cx = m[0] - margin.left;

                var x0 = x.invert(cx);
                var i = (d3.bisector(function (d) {
                    return d.date;
                }).left)(data, x0, 1);

                var d0 = data[i],
                    d1 = data[i] || {},
                    d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                function formatWording(d) {
                    return '日期：' + format(d.date);
                }

                wording1.text(formatWording(d));
                wording2.text('PV' + '：' + d.pv);

                var x1 = x(d.date),
                    y1 = y(d.pv);

                // 处理超出边界的情况
                var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                x1 -= dx;
                y1 -= dy;

                d3.select('.tips')
                    .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                d3.select('.tips').style('display', 'block');
            })
            .on('mouseout', function () {
                d3.select('.tips').style('display', 'none');
            });

        uv_line
            .on('mousemove', function () {
                var m = d3.mouse(this),
                    cx = m[0] - margin.left;

                var x0 = x.invert(cx);
                var i = (d3.bisector(function (d) {
                    return d.date;
                }).left)(data, x0, 1);

                var d0 = data[i],
                    d1 = data[i] || {},
                    d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                function formatWording(d) {
                    return '日期：' + format(d.date);
                }

                wording1.text(formatWording(d));
                wording2.text("uv" + '：' + d.uv);

                var x1 = x(d.date),
                    y1 = y(d.uv);

                // 处理超出边界的情况
                var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                x1 -= dx;
                y1 -= dy;

                d3.select('.tips')
                    .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                d3.select('.tips').style('display', 'block');
            })
            .on('mouseout', function () {
                d3.select('.tips').style('display', 'none');
            });

        click_line
            .on('mousemove', function () {
                var m = d3.mouse(this),
                    cx = m[0] - margin.left;

                var x0 = x.invert(cx);
                var i = (d3.bisector(function (d) {
                    return d.date;
                }).left)(data, x0, 1);

                var d0 = data[i],
                    d1 = data[i] || {},
                    d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                function formatWording(d) {
                    return '日期：' + format(d.date);
                }

                wording1.text(formatWording(d));
                wording2.text("click" + '：' + d.click);

                var x1 = x(d.date),
                    y1 = y(d.click);

                // 处理超出边界的情况
                var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                x1 -= dx;
                y1 -= dy;

                d3.select('.tips')
                    .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                d3.select('.tips').style('display', 'block');
            })
            .on('mouseout', function () {
                d3.select('.tips').style('display', 'none');
            });

    });
}

function filterNone(element, index, array) {
    return (element.key != "None" && element.key != "-");
}

function draw_map_data(start_day, end_day, map_container, qurey, size, cards) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 0,
            index: "logstash-search-*",
            body: build_term_query(start_time_stamp, end_time_stamp, qurey, size, cards, "city")
        })
        .then(function (resp) {
            // D3 code goes here.
            var x_arrays = [];
            var values = [];
            var data = resp.aggregations.statistics.buckets;
            data = data.filter(filterNone)
            data.forEach(function (d) {
                x_arrays.push(d.key);
                values.push(d.doc_count);
            });

            var map_chart = echarts.init(document.getElementById(map_container));
            option = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['搜索量']
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        magicType: {show: true, type: ['line', 'bar']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: x_arrays
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '搜索量',
                        type: 'bar',
                        data: values,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    }
                ]
            };
            map_chart.setOption(option);
        });
}

function draw_raw_query_data(start_day, end_day, map_container, qurey, size, cards, term) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 0,
            index: "logstash-search-*",
            body: build_term_query(start_time_stamp, end_time_stamp, qurey, size, cards, term)
        })
        .then(function (resp) {
            // D3 code goes here.
            var x_arrays = [];
            var values = [];
            var data = resp.aggregations.statistics.buckets;
            data = data.filter(filterNone);
            data.forEach(function (d) {
                x_arrays.push(d.key);
                values.push(d.doc_count);
            });

            var map_chart = echarts.init(document.getElementById(map_container));
            option = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['搜索query']
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        magicType: {show: true, type: ['line', 'bar']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: x_arrays
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: 'query量',
                        type: 'bar',
                        data: values
                    }
                ]
            };
            map_chart.setOption(option);
        });
}

function draw_province_data(start_day, end_day, map_container, qurey, size, cards, term) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 0,
            index: "logstash-search-*",
            body: build_term_query(start_time_stamp, end_time_stamp, qurey, size, cards, term)
        })
        .then(function (resp) {
            // D3 code goes here.
            var data = resp.aggregations.statistics.buckets;
            data = data.filter(filterNone);
            data.forEach(function (d) {
                d.name = d.key;
                d.value = d.doc_count;
            });
            var value_max = d3.max(data, function (d) {
                    return d.value;
                }),
                value_min = d3.min(data, function (d) {
                    return d.value;
                })
            var map_chart = echarts.init(document.getElementById(map_container));
            option = {
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    x: 'left',
                    data: ['省份分布']
                },
                dataRange: {
                    min: value_min,
                    max: value_max,
                    x: 'left',
                    y: 'bottom',
                    text: ['高', '低'],           // 文本，默认为数值文本
                    calculable: true
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    x: 'right',
                    y: 'center',
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                series: [
                    {
                        name: '省份分布',
                        type: 'map',
                        mapType: 'china',
                        roam: false,
                        itemStyle: {
                            normal: {label: {show: true}},
                            emphasis: {label: {show: true}}
                        },
                        data: data
                    }
                ]
            };
            map_chart.setOption(option);
        });
}

function draw_click_svg(start_day, end_day, svg_container, table_container, qurey, interval, cards) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
    interval = interval || '24h';
    var format = interval_format.h;
    if (interval == "24h") {
        format = interval_format.d
    }
    if (interval[interval.length - 1] == "M") {
        format = interval_format.M
    }
    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 5,
            index: "logstash-click-search-*",
            body: build_click_query(start_time_stamp, end_time_stamp, qurey, interval, cards)
        })
        .then(function (resp) {
            // D3 code goes here.
            $(svg_container).html("<svg xmlns='http://www.w3.org/2000/svg' width='100%'></svg>");

            var data = resp.aggregations.statistics.buckets;

            data.forEach(function (d) {
                d.date = new Date(d.key_as_string);
                d.日期 = format(d.date);
                d.click = d.doc_count
            });

            var start = data[0].date;
            var end = data[data.length - 1].date;

            var margin = {top: 20, right: 70, bottom: 30, left: 70},
                width = $(svg_container).width(),
                height = 500;
            var container = d3.select(svg_container).select('svg')
                .attr('class', 'collect-svg')
                .attr('width', width)
                .attr('height', height);
            width = width - margin.left - margin.right;
            height = height - margin.top - margin.bottom;
            var svg = container.append('g')
                .attr('class', 'content')
                .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

            // 添加一个table表格
            function tabulate(data, columns) {
                d3.select(table_container).select('table').remove();
                var table = d3.select(table_container).append('table')
                    .attr('width', width + margin.left + margin.right)
                    .attr('height', height + margin.top + margin.bottom)
                    .attr('class', 'xiangyun_table')
                    .attr('id', 'collect-table');

                thead = table.append("thead");
                tbody = table.append("tbody");

                // append the header row
                thead.append("tr")
                    .selectAll("th")
                    .data(columns)
                    .enter()
                    .append("th")
                    .text(function (column) {
                        return column;
                    });

                // create a row for each object in the data
                var rows = tbody.selectAll("tr")
                    .data(data)
                    .enter()
                    .append("tr");

                // create a cell in each row for each column
                var cells = rows.selectAll("td")
                    .data(function (row) {
                        return columns.map(function (column) {
                            return {column: column, value: row[column]};
                        });
                    })
                    .enter()
                    .append("td")
                    .html(function (d) {
                        return d.value;
                    });

                return table;
            };

            var peopleTable = tabulate(data, ["日期", 'click']);

            var x = d3.time.scale()
                .domain([start, end])
                .range([0, width]);

            var y = d3.scale.linear()
                .domain([d3.min(data, function (d) {
                    return d.click;
                }),
                    d3.max(data, function (d) {
                        return d.click;
                    })])
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .tickFormat(format)
                .orient('bottom')
                .ticks(10);

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left')
                .ticks(10);

            svg.append('g')
                .attr('class', 'x axis')
                .attr('transform', 'translate(0,' + height + ')')
                .call(xAxis)
                // 增加坐标值说明
                .append('text')
                .text('日期')
                .attr('transform', 'translate(' + width + ', 0)');

            // 纵坐标
            svg.append('g')
                .attr('class', 'y axis')
                .call(yAxis)
                .attr("y", 6)
                .attr("dy", ".71em")
                .append('text')
                .text('次/天');

            var line_click = d3.svg.line()
                .x(function (d) {
                    return x(d.date);
                })
                .y(function (d) {
                    return y(d.click);
                });

            x.domain(d3.extent(data, function (d) {
                return d.date;
            }));
            y.domain([d3.min(data, function (d) {
                return d.click;
            }),
                d3.max(data, function (d) {
                    return d.click;
                })]);

            var click_line = svg.append("path")
                .datum(data)
                .attr("class", "line-click")
                .attr("d", line_click);

            svg.append('g').attr('class', 'line-click-tips');


            var g = svg.select('.line-click-tips').selectAll('circle')
                .data(data)
                .enter()
                .append('g')
                .append('circle')
                .attr('class', 'linecircle')
                .attr('cx', line_click.x())
                .attr('cy', line_click.y())
                .attr('r', 3.5)
                .on('mouseover', function () {
                    d3.select(this).transition().duration(500).attr('r', 5);
                })
                .on('mouseout', function () {
                    d3.select(this).transition().duration(500).attr('r', 3.5);
                });

            var tips = svg.append('g').attr('class', 'tips');

            tips.append('rect')
                .attr('class', 'tips-border')
                .attr('width', 200)
                .attr('height', 50)
                .attr('rx', 10)
                .attr('ry', 10);

            var wording1 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 20)
                .text('');

            var wording2 = tips.append('text')
                .attr('class', 'tips-text')
                .attr('x', 10)
                .attr('y', 40)
                .text('');

            click_line
                .on('mousemove', function () {
                    var m = d3.mouse(this),
                        cx = m[0] - margin.left;

                    var x0 = x.invert(cx);
                    var i = (d3.bisector(function (d) {
                        return d.date;
                    }).left)(data, x0, 1);

                    var d0 = data[i],
                        d1 = data[i] || {},
                        d = x0 - d0.date > d1.date - x0 ? d1 : d0;

                    function formatWording(d) {
                        return '日期：' + format(d.date);
                    }

                    wording1.text(formatWording(d));
                    wording2.text("click" + '：' + d.click);

                    var x1 = x(d.date),
                        y1 = y(d.click);

                    // 处理超出边界的情况
                    var dx = x1 > width ? x1 - width + 200 : x1 + 200 > width ? 200 : 0;

                    var dy = y1 > height ? y1 - height + 50 : y1 + 50 > height ? 50 : 0;

                    x1 -= dx;
                    y1 -= dy;

                    d3.select('.tips')
                        .attr('transform', 'translate(' + x1 + ',' + y1 + ')');

                    d3.select('.tips').style('display', 'block');
                })
                .on('mouseout', function () {
                    d3.select('.tips').style('display', 'none');
                });

        });

}

function draw_gmv_data(start_day, end_day, svn_container, query, interval) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 0,
            index: "logstash-bdoor-order-*",
            body: build_gmv_query(start_time_stamp, end_time_stamp, query)
        })
        .then(function (resp) {
            var data = resp.aggregations.statistics.buckets;
            data = data.filter(filterNone);
            var appid = [];
            data.forEach(function (d) {
                d.name = d.key;
                d.value = d.GMV.value/100;
                appid.push(d.name)
            });
            console.log(data);
            var value_max = d3.max(data, function (d) {
                    return d.value;
                }),
                value_min = d3.min(data, function (d) {
                    return d.value;
                });
            var map_chart = echarts.init(document.getElementById(svn_container));
            option = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient : 'vertical',
                    x : 'left',
                    data:appid
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel'],
                            option: {
                                funnel: {
                                    x: '25%',
                                    width: '50%',
                                    funnelAlign: 'left',
                                    max: value_max
                                }
                            }
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'gmv',
                        type:'pie',
                        radius : '55%',
                        center: ['50%', '60%'],
                        data:data
                    }
                ]
            };
            map_chart.setOption(option);

        });
}

function draw_category_gmv_data(start_day, end_day, svn_container, query, interval) {
    var start_time_stamp = start_day || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    var end_time_stamp = end_day || DateAdd("d ", -2, setEndDay(new Date())).getTime();
    var format = interval_format.h;
    if (interval == "24h") {
        format = interval_format.d
    }
    if (interval[interval.length - 1] == "M") {
        format = interval_format.M
    }
    if (interval[interval.length - 1] == "w") {
        format = interval_format.d
    }
    var elc_client = new elasticsearch.Client({hosts: data_server});

    esp = elc_client.search({
            size: 0,
            index: "logstash-bdoor-order-*",
            body: build_category_gmv_query(start_time_stamp, end_time_stamp, query, interval)
        })
        .then(function (resp) {
            // D3 code goes here.

            var data = resp.aggregations.statistics.buckets;
            data = data.filter(filterNone);
            var gross_gmv = [];
            var success_gmv = [];
            var date = [];
            data.forEach(function (d) {
                d.date = new Date(d.key_as_string);
                gross_gmv.push(d.GMV.value);
                success_gmv.push(d.income.value);
                date.push(format(d.date));
            });
            var value_max = d3.max(data, function (d) {
                    return d.value;
                }),
                value_min = d3.min(data, function (d) {
                    return d.value;
                })

            var map_chart = echarts.init(document.getElementById(svn_container));

            option = {
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['gmv','纯收入']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : date
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                series : [
                    {
                        name:'GMV',
                        type:'bar',
                        data: gross_gmv,
                        markPoint : {
                            data : [
                                {type : 'max', name: '最大值'},
                                {type : 'min', name: '最小值'}
                            ]
                        },
                        markLine : {
                            data : [
                                {type : 'average', name: '平均值'}
                            ]
                        }
                    },
                    {
                        name:'纯收入',
                        type:'bar',
                        data: success_gmv,
                        markPoint : {
                            data : [
                                {type : 'max', name: '最大值'},
                                {type : 'min', name: '最小值'}
                            ]
                        },
                        markLine : {
                            data : [
                                {type : 'average', name : '平均值'}
                            ]
                        }
                    }
                ]
            };

            map_chart.setOption(option);
        });
}

function get_log_data(log_source, start_time, end_time, log_top, query) {

    start_time = start_time || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    end_time = end_time  || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});
    var result;
    esp = elc_client.search({
            size: log_top,
            index: log_source,
            body: build_log_query(start_time, end_time, query)
        });

    return esp
}

function get_log_statistics(log_source, start_time, end_time, query) {

    start_time = start_time || DateAdd("d ", -17, setStartDay(new Date())).getTime();
    end_time = end_time  || DateAdd("d ", -2, setEndDay(new Date())).getTime();

    var elc_client = new elasticsearch.Client({hosts: data_server});
    var result;
    esp = elc_client.search({
        size: 0,
        index: log_source,
        body: query
    });

    return esp
}

function draw_result_data(data, result_container, draw_type, draw_args){
    var tag = randomString(6);
    $(result_container).empty();
    draw_args = draw_args || {};
    $(result_container).append('<ul id="instraction-tab" class="nav nav-tabs"></ul><div id="chart-container" class="tab-content"></div>');
    var draw_type_list = draw_type.split("#")
    for (var i=0;i<draw_type_list.length;i++)
    {
        if (draw_type_list[i] == 'source'){
            if(i == 0){
                $(result_container).children("#instraction-tab").append('<li class="active"><a href="#source' + tag + '" data-toggle="tab">原始结果</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade active in" id="source' + tag + '"></div>');
            }else{
                $(result_container).children("#instraction-tab").append('<li><a href="#source' + tag + '" data-toggle="tab">原始结果</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade" id="source' + tag + '"></div>');
            }


            var el = $(result_container).children("#chart-container").children('#source');
            var editor = ace.edit(el[0]);
            editor.setTheme("ace/theme/monokai");
            editor.getSession().setMode("ace/mode/json");
            editor.setValue(JSON.stringify(data, null, '\t'));

        }else if (draw_type_list[i] == 'table'){
            if(i == 0){
                $(result_container).children("#instraction-tab").append('<li class="active"><a href="#table' + tag + '" data-toggle="tab">表格</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade active in" id="table' + tag + '"></div>')
            }else{
                $(result_container).children("#instraction-tab").append('<li><a href="#table' + tag + '" data-toggle="tab">表格</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade" id="table' + tag + '"></div>')
            }
            d3.select(result_container).select("#chart-container").select('#table'+tag)
                .selectAll("table")
                .data([data])
                .enter().append("table")
                .attr('class', 'result-table')
                .call(recurse);
        }else if (draw_type_list[i] == 'gridchart'){
            if(i == 0){
                $(result_container).children("#instraction-tab").append('<li class="active"><a href="#gridchart' + tag + '" data-toggle="tab">柱状图</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade active in" id="gridchart' + tag + '"></div>');
            }else{
                $(result_container).children("#instraction-tab").append('<li><a href="#gridchart' + tag + '" data-toggle="tab">柱状图</a></li>');
                $(result_container).children("#chart-container").append('<div class="editor tab-pane fade" id="gridchart' + tag + '"></div>');
            }

            var el = $(result_container).children("#chart-container").children('#gridchart'+tag);
            var map_chart = echarts.init(el[0]);
            map_chart.setOption(draw_args);
            map_chart.resize();
            window.onresize = map_chart.resize
        }else {

        }
    }

}

function draw_result(start_time, end_time, log_source, query, statistics, aggs, draw_option, container, draw_type)
{
    var elas_query = build_query(start_time, end_time, query, statistics, aggs);

    var middle_log_data = get_log_statistics(log_source, start_time, end_time, elas_query);
    middle_log_data.then(function (resp) {
        var aggs_name = aggs[0].name;
        var aggs_type = aggs[0].type;
        var statistic_result = resp.aggregations[aggs_name].buckets;
        statistic_result.forEach(changeResult);
        var option = produceChartOption(statistic_result, draw_option)
        draw_result_data(statistic_result, container, draw_type, option);
    });

}