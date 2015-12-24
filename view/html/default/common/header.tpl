<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="ltr" lang="cn" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="ltr" lang="cn" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="zh-Hans" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content= "<?php echo $keywords; ?>" />
    <?php } ?>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php if ($icon) { ?>
    <link href="<?php echo $icon; ?>" rel="icon" />
    <?php } ?>
    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <script src="view/js/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <link href="view/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
    <script src="view/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="view/js/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script src="view/js/d3/d3.min.js" type="text/javascript"></script>
    <script src="view/js/elasticsearch-js/elasticsearch.js" type="text/javascript"></script>
    <script src="view/js/moment.js" type="text/javascript"></script>
    <script src="view/js/md5.min.js"></script>
    <script src="view/js/daterangepicker.js" type="text/javascript"></script>
    <script src="view/js/query.js" type="text/javascript"></script>

    <link href="view/js/jsoneditor/jsoneditor.min.css" rel="stylesheet" type="text/css">
    <script src="view/js/jsoneditor/jsoneditor.min.js"></script>

    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/doc/example/www2/js/echarts-all.js"></script>

    <link href="view/css/main.css" rel="stylesheet">
    <link href="view/css/daterangepicker-bs3.css" rel="stylesheet">
    <script src="view/js/common.js" type="text/javascript"></script>
    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
</head>
<body class="<?php echo $class; ?>">
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-brand" href="<?php echo $base; ?>"><img alt="Brand" src="<?php echo $logo; ?>"></a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="<?php echo $base; ?>">汇总</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">黄页<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<?php echo $yp_collect; ?>">汇总</a></li>
                        <li><a href="<?php echo $yp_repair; ?>">维修</a></li>
                        <li><a href="<?php echo $yp_move; ?>">搬家</a></li>
                        <li><a href="<?php echo $yp_clean; ?>">保洁</a></li>
                        <li><a href="<?php echo $yp_multi; ?>">多类目</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">订单分发<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<?php echo $bdoor_collect; ?>">汇总</a></li>
                        <li><a href="<?php echo $bdoor_massage; ?>">按摩</a></li>
                        <li><a href="<?php echo $bdoor_nail; ?>">美甲</a></li>
                        <li><a href="<?php echo $bdoor_peccancy; ?>">违章</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">支付闭环<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<?php echo $payment_telecom; ?>">电信充值</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">提交</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">探索<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<?php echo $discover_keys; ?>">埋点查询</a></li>
                        <li><a href="<?php echo $discover_gmv; ?>">gmv查询</a></li>
                        <li><a href="<?php echo $discover_logsearch; ?>">日志查询</a></li>
                        <li><a href="<?php echo $discover_statistical; ?>">统计分析</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">账号<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">待开发</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>