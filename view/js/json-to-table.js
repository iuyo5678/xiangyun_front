function tableCreator(e, t) {
    function i(e, t) {
        var n = "";
        var r = "";
        var s = "";
        $.each(t[0], function(e, t) {
            s += "<th>" + e + "</th>"
        });
        $.each(t, function(e, t) {
            r += "<tr>";
            $.each(t, function(e, t) {
                var n = 1 + Math.floor(Math.random() * 90 + 10);
                var s = $.isPlainObject(t);
                var o = [];
                if (s) {
                    o = $.makeArray(t)
                }
                if ($.isArray(t) && t.length > 0) {
                    r += "<td><div><a href='#" + n + "' data-toggle='collapse' data-parent='#msgReport'><span class='glyphicon glyphicon-plus'></span></a><div id='" + n + "' class='panel-collapse collapse'>" + i(e, t) + "</div></div></td>"
                } else {
                    if (o.length > 0) {
                        r += "<td><div><a href='#" + n + "' data-toggle='collapse' data-parent='#msgReport'><span class='glyphicon glyphicon-plus'></span></a><div id='" + n + "' class='panel-collapse collapse'>" + i(e, o) + "</div></div></td>"
                    } else {
                        r += "<td>" + t + "</td>"
                    }
                }
            });
            r += "</tr>"
        });
        n += "<table class='table table-bordered table-hover table-condensed'><thead>" + s + "</thead><tbody>" + r + "</tbody></table>";
        return n
    }
    $(t).empty();
    $(t).append("<table id='parentTable' class='table table-bordered table-hover table-condensed'><thead></thead><tbody></tbody></table>");
    var n = "";
    var r = "";
    $.each(e, function(e, t) {
        n += "<th>" + e + "</th>";
        var s = 1 + Math.floor(Math.random() * 90 + 10);
        var o = $.isPlainObject(t);
        var u = [];
        if (o) {
            u = $.makeArray(t)
        }
        if ($.isArray(t) && t.length > 0) {
            r += "<td><div id='accordion'><a href='#" + s + "' data-toggle='collapse' data-parent='#msgReport'><span class='glyphicon glyphicon-plus'></span></a><div id='" + s + "' class='panel-collapse collapse'>" + i(e, t) + "</div></div></td>"
        } else {
            if (u.length > 0) {
                r += "<td><div id='accordion'><a href='#" + s + "' data-toggle='collapse' data-parent='#msgReport'><span class='glyphicon glyphicon-plus'></span></a><div id='" + s + "' class='panel-collapse collapse'>" + i(e, u) + "</div></div></td>"
            } else {
                r += "<td>" + t + "</td>"
            }
        }
    });
    $("#parentTable thead").append("<tr>" + n + "</tr>");
    $("#parentTable tbody").append("<tr>" + r + "</tr>");
    $(".glyphicon ").on("click", function() {
        var e = $(this).attr("class");
        switch (e) {
            case "glyphicon glyphicon-plus":
                $(this).removeClass("glyphicon-plus").addClass("glyphicon-minus");
                break;
            case "glyphicon glyphicon-minus":
                $(this).removeClass("glyphicon-minus").addClass("glyphicon-plus");
                break;
            default:
        }
    })
}

function recurse(sel) {
    // sel is a d3.selection of one or more empty tables
    sel.each(function(d) {
        // d is an array of objects
        var colnames,
            tds,
            table = d3.select(this);

        // obtain column names by gathering unique key names in all 1st level objects
        // following method emulates a set by using the keys of a d3.map()
        colnames = d                                                          // array of objects
            .reduce(function(p,c) { return p.concat(d3.keys(c)); }, [])       // array with all keynames
            .reduce(function(p,c) { return (p.set(c,0), p); }, d3.map())      // map with unique keynames as keys
            .keys();                                                          // array with unique keynames (arb. order)

        // colnames array is in arbitrary order
        // sort colnames here if required

        // create header row using standard 1D data join and enter()
        table.append("thead").append("tr").selectAll("th")
            .data(colnames)
            .enter().append("th")
            .text(function(d) { return d; });

        // create the table cells by using nested 2D data join and enter()
        // see also http://bost.ocks.org/mike/nest/
        tds = table.append("tbody").selectAll("tr")
            .data(d)                            // each row gets one object
            .enter().append("tr").selectAll("td")
            .data(function(d) {                 // each cell gets one value
                return colnames.map(function(k) { // for each colname (i.e. key) find the corresponding value
                    return d[k] || "";              // use empty string if key doesn't exist for that object
                });
            })
            .enter().append("td");

        // cell contents depends on the data bound to the cell
        // fill with text if data is not an Array
        tds.filter(function(d) { return !(d instanceof Array); })
            .text(function(d) { return d; });
        // fill with a new table if data is an Array
        tds.filter(function(d) { return (d instanceof Array); })
            .append("table")
            .call(recurse);
    });
}