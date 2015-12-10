<h3>PV UV 统计</h3>
<div id="content-top">
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
        draw_pv_uv_svg(-40, -38, "#collect-visul", "#collect-table-tab", '*');
    });
</script>