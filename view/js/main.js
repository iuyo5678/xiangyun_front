/**
 * Created by zhangguhua on 15/12/7.
 */
define(['view/js/d3/d3', 'view/js/elasticsearch-js/elasticsearch'], function (d3, elasticsearch) {
    "use strict";
    var client = new elasticsearch.Client( {hosts : ['http://yf-wise-gate44.yf01.baidu.com:8200']});
    client.search({
        index: 'logstash-search-*',
        size: 5,
        body: {
            "query": {
                "filtered": {
                    "query": {
                        "query_string": {
                            "analyze_wildcard": true,
                            "query": "*"
                        }
                    },
                    "filter": {
                        "bool": {
                            "must": [
                                {
                                    "range": {
                                        "@timestamp": {
                                            "gte": 1448899200000,
                                            "lte": 1451577599999,
                                            "format": "epoch_millis"
                                        }
                                    }
                                }
                            ],
                            "must_not": []
                        }
                    }
                }
            },
            "highlight": {
                "pre_tags": [
                    "@kibana-highlighted-field@"
                ],
                "post_tags": [
                    "@/kibana-highlighted-field@"
                ],
                "fields": {
                    "*": {}
                },
                "require_field_match": false,
                "fragment_size": 2147483647
            },
            "aggs": {
                "datetime": {
                    "date_histogram": {
                        "field": "@timestamp",
                        "interval": "24h",
                        "time_zone": "Asia/Shanghai",
                        "min_doc_count": 0,
                        "extended_bounds": {
                            "min": 1448899200000,
                            "max": 1451577599999
                        }
                    }
                }
            },
            "fields": [
                "*",
                "_source"
            ],
            "script_fields": {},
            "fielddata_fields": [
                "@timestamp",
                "clk_detail.stat_date"
            ]
        }
    }).then(function (resp) {
        console.log(resp);
        // D3 code goes here.
        var datetime = resp.aggregations.datetime.buckets;
    });
});