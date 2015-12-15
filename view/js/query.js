/**
 * Created by zhangguhua on 15/12/7.
 */

function build_query(start, end, query_str, interval) {
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
                    "PV": {
                        "sum": {
                            "script": "doc['disp_statistics.wz_weixiusimple'].value + doc['disp_statistics.wz_weixiuweak'].value + doc['disp_statistics.wz_banjiasimple'].value + doc['disp_statistics.wz_banjiaweak'].value + doc['disp_statistics.wz_baojiesimple'].value + doc['disp_statistics.wz_baojieweak'].value + doc['disp_statistics.wz_pinpai'].value + doc['disp_statistics.wz_bdoor'].value + doc['disp_statistics.wz_hy_multi'].value"
                        }
                    },
                    "Click": {
                        "sum": {
                            "script": "doc['clk_statistics.wz_weixiusimple'].value + doc['clk_statistics.wz_weixiuweak'].value + doc['clk_statistics.wz_banjiasimple'].value + doc['clk_statistics.wz_baojiesimple'].value + doc['clk_statistics.wz_baojieweak'].value + doc['clk_statistics.wz_pinpai'].value + doc['clk_statistics.wz_bdoor'].value + doc['clk_statistics.wz_hy_multi'].value"
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
