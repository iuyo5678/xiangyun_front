/**
 * Created by zhangguhua on 15/12/7.
 */


function build_chart_param(char_type, option){
    if (char_type == 'gridchat'){

    }
}

function build_query(start_time, end_time, query_str, statistics, aggs) {
    query_str = query_str || '*';

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start_time,
                                        "lte": end_time
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        }
    };
    var last_aggs =  false;
    var aggs_result = {};

    for(var index=statistics.length; index > 0; index--){
        var statistics_type = statistics[index-1].type;
        var statistics_name = statistics[index-1].name;
        if(statistics[index-1].type == "count"){
            continue
        }else{
            var temp_agg = {};
            temp_agg[statistics_type] = {};
            temp_agg[statistics_type]['field'] = statistics[index-1].field;
            aggs_result[statistics_name] = temp_agg;
        }
    }

    for(var index=aggs.length; index > 0; index--){
        var aggs_type = aggs[index-1].type;
        var aggs_name = aggs[index-1].name;
        var aggs_temp = {};
        if(aggs[index-1].type == "date_histogram"){
            aggs_temp[aggs_name] = {
                    "date_histogram": {
                        "field": aggs[index-1].field,
                        "interval":aggs[index-1].interval,
                        "time_zone": "Asia/Shanghai",
                        "min_doc_count": 0,
                }
            }
        }else{
            aggs_temp[aggs_name] = {};
            aggs_temp[aggs_name][aggs_type] = {};
            aggs_temp[aggs_name][aggs_type]['field'] = aggs[index-1].field;
          }

        if (!isEmpty(aggs_result)){
            aggs_temp[aggs_name]['aggs'] = aggs_result;
        }

        aggs_result= aggs_temp;
    }
    query.aggs = aggs_result;
    return query;
}


function build_only_click_query(start, end, query_str, interval, cards) {
    query_str = query_str || '*';

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "date_histogram": {
                    "field": "@timestamp",
                    "interval": interval,
                    "time_zone": "Asia/Shanghai",
                    "min_doc_count": 0,
                    "extended_bounds": {
                        "min": start,
                        "max": end
                    }
                }
            }
        }
    };
    return query;
}

function build_only_pv_uv_query(start, end, query_str, interval, cards) {
    query_str = query_str || '*';

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "date_histogram": {
                    "field": "@timestamp",
                    "interval": interval,
                    "time_zone": "Asia/Shanghai",
                    "min_doc_count": 0,
                    "extended_bounds": {
                        "min": start,
                        "max": end
                    }
                },
                "aggs": {
                    "UV": {
                        "cardinality": {
                            "field": "baiduid"
                        }
                    }
                }
            }
        }
    };
    return query;
}

function build_pv_uv_query(start, end, query_str, interval, cards) {
    query_str = query_str || '*';
    var pv_query = "";
    var click_query = "";
    for (var i=0; i<cards.length;i++)
    {
        pv_query += "doc['disp_statistics." + cards[i] +"'].value + "
    }
    for (var i=0; i<cards.length;i++)
    {
        click_query += "doc['clk_statistics." + cards[i] +"'].value + "
    }

    pv_query = pv_query.substring(0, pv_query.length-3);

    click_query = click_query.substring(0, click_query.length-3);

    if ( query != "*" && cards.length > 0 ){
        query_str = "";
    }

    for (var i =0; i<cards.length;i++)
    {
        query_str += "_exists_: disp_statistics." + cards[i] +" OR "
    }

    query_str = query_str.substring(0, query_str.length-4);

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "date_histogram": {
                    "field": "@timestamp",
                    "interval": interval,
                    "time_zone": "Asia/Shanghai",
                    "min_doc_count": 0,
                    "extended_bounds": {
                        "min": start,
                        "max": end
                    }
                },
                "aggs": {
                    "PV": {
                        "sum": {
                            "script": pv_query
                        }
                    },
                    "Click": {
                        "sum": {
                            "script": click_query
                        }
                    },
                    "UV": {
                        "cardinality": {
                            "field": "baiduid"
                        }
                    }
                }
            }
        }
    };
    return query;
}

function build_parameter_query(log_source) {
    query = {
        "query": {
        "filtered": {
            "query": {
                "query_string": {
                    "query": "title:" + log_source,
                        "analyze_wildcard": true
                }
            }
        }
    }
    }
    return query
}
function build_term_query(start, end, query_str, size, cards, term) {
    query_str = query_str || '*';
    size = size || 5;

    if ( query != "*" && cards.length > 0 ){
        query_str += " AND  (";
    }

    for (var i=0; i<cards.length;i++)
    {
        query_str += "_exists_: disp_statistics." + cards[i] +" OR "
    }

    query_str = query_str.substring(0, query_str.length-4) + ')';

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "terms": {
                    "field": term,
                    "size": size,
                    "order": {
                        "_count":"desc"
                    }
                }
            }
        }
    };
    return query;
}


function build_click_query(start, end, query_str, interval, cards) {
    query_str = query_str || '*';

    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "date_histogram": {
                    "field": "@timestamp",
                    "interval": interval,
                    "time_zone": "Asia/Shanghai",
                    "min_doc_count": 0,
                    "extended_bounds": {
                        "min": start,
                        "max": end
                    }
                }
            }
        }
    };
    return query;
}


function build_gmv_query(start, end, query_str) {
    query_str = query_str || '*';
    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "terms": {
                    "field": "provider_id",
                    "size": 5,
                    "order": {
                        "GMV": "desc"
                    }
                },
                "aggs": {
                    "GMV": {
                        "sum": {
                            "field": "total_amount"
                        }
                    }
                }
            }
        }
    };
    return query;
}

function build_category_gmv_query(start, end, query_str, interval) {
    query_str = query_str || '*';
    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        },
        "aggs": {
            "statistics": {
                "date_histogram": {
                    "field": "@timestamp",
                    "interval": interval,
                    "time_zone": "Asia/Shanghai",
                    "min_doc_count": 1,
                    "extended_bounds": {
                        "min": start,
                        "max": end
                    }
                },
                "aggs": {
                    "GMV": {
                        "sum": {
                            "field": "total_amount"
                        }
                    },
                    "income": {
                        "sum": {
                            "field": "payment_paid_amount"
                        }
                    }
                }
            }
        }
    };
    return query;
}

function build_log_query(start, end, query_str) {
    query_str = query_str || '*';
    var query = {
        "query": {
            "filtered": {
                "query": {
                    "query_string": {
                        "analyze_wildcard": true,
                        "query": query_str
                    }
                },
                "filter": {
                    "bool": {
                        "must": [
                            {
                                "range": {
                                    "@timestamp": {
                                        "gte": start,
                                        "lte": end
                                    }
                                }
                            }
                        ],
                        "must_not": []
                    }
                }
            }
        }
    };
    return query;
}