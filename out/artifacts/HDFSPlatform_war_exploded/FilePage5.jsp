<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.FileInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.OptInfo" %>
<%@ page import="Model.PerInfo" %>
<html>
<head>
    <title>Main</title>
</head>
<link rel="icon" href="image/sign1.png" type="image/x-icon"/>

<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap-theme.css">
<script src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<script type="text/javascript"
        src="jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
        src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
      href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet"
      href="bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
<link rel="stylesheet"
      href="css/FIlePage1_css.css">
<script>
    var message_error = "${message}";
    if (message_error != "") {
        alert(message_error);
        message_error = "";
    }
</script>
<script>
    $(document).ready(function () {
        $("#two_log").hide();
        $("#fileForm1").hide();

        $("#btn_one_log").click(function () {
            $("#one_log").hide();
            $("#two_log").show();
        });
        $("#btn_two_log").click(function () {
            $("#one_log").show();
            $("#two_log").hide();
        });

    });

    function formSubmit_delete(n) {
        var a = confirm("是否确认删除?");
        if (a == false) {
            return false;
        }
        document.getElementById(n).submit();
        return true;
    }

    function formSubmit_download(n) {
        var a = confirm("是否确认下载?");
        if (a == false) {
            return false;
        }
        document.getElementById(n).submit();
        return true;
    }
</script>
<script type="text/javascript">
    var impr_fileName = "";

    function loadBlock(de_blockName, fileName) {
        document.getElementById('ta_block').innerHTML = "";
        impr_fileName = fileName;
        var type = "";
        var recoverFlage = "";
        var count = document.getElementById("count").value;
        var xmlhttp;
        if (de_blockName != "" && de_blockName != "recover") {
            var a = confirm("是否确认删除?");
            if (a == false) {
                de_blockName = "";
            }
            else {
                type = "delete";
            }
        }
        if (de_blockName == "recover") {
            recoverFlage = "recover";
            type = "recover";
            de_blockName = "";
        }
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var result = eval("(" + xmlhttp.responseText + ")");

                var table = document.getElementById("ta_block");
                var newtr;
                var newtd0;
                var newtd1;
                var newtd2;
                for (var i = 0; i < result.blockInfo.length - 1; i++) {
                    newtr = table.insertRow();
                    newtd0 = newtr.insertCell();
                    newtd1 = newtr.insertCell();
                    newtd2 = newtr.insertCell();
                    newtd0.innerHTML = i + 1;
                    if (result.blockInfo[i].check == 1) {
                        newtd1.innerHTML = "<span class='glyphicon glyphicon-hdd'></span>&nbsp;&nbsp;&nbsp;" + result.blockInfo[i].blockname;
                        newtd2.innerHTML = "<button class='delete_block btn btn-default' id='delete_block' onclick='loadBlock(&quot;" + result.blockInfo[i].blockname + "&quot;,&quot;" + fileName + "&quot;)'>删除</button>";
                    }
                    else {
                        newtd1.innerHTML = "<span class='glyphicon glyphicon-hdd'></span>&nbsp;&nbsp;&nbsp;<span style='color:red;'>" + result.blockInfo[i].blockname + "</span>";
                        newtd2.innerHTML = "<button class='delete_block btn btn-default' disabled='disabled' id='delete_block'>删除</button>";
                    }
                }
                if (type == "delete" || type == "recover") {
                    alert(result.blockInfo[result.blockInfo.length - 1].flag);
                    type = "";
                }
            }
        }
        xmlhttp.open("GET", "/showBlock?count=" + count + "&fileName=" + fileName + "&de_blockName=" + de_blockName + "&recoverFlage=" + recoverFlage, false);
        // xmlhttp.open("GET","/showBlock?count="+count+"&fileName="+fileName,true);
        xmlhttp.send();
    }

    function getFilename() {
        var fileName = impr_fileName;
        loadBlock("recover", fileName);
    }
</script>
<script>
    function ca1() {
        $("#table_inside").animate({left: '-=2000px'}, 800);
        setTimeout("sshow()", 400);
    }

    function ca2() {
        $("#table_inside").animate({left: '+=2000px'}, 1000);
        setTimeout("hhide()", 100);
    }

    function sshow() {
        $("#tinyinterface").show("slow");
    }

    function hhide() {
        $("#tinyinterface").hide("slow");
    }

    $(document).ready(function () {
        $("#tinyinterface").hide();
    });
</script>
<% String count = (String) session.getAttribute("count");
    String[][] a = (String[][]) session.getAttribute("a");
    if (a == null) {
        a = new String[2][3];
        a[0][0] = "none";
        a[0][1] = "none";
        a[0][2] = "none";
        a[1][0] = "none";
        a[1][1] = "none";
        a[1][2] = "none";
    }%>
<body>
<div class="beautiful">
    <br>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td align="center"><img src="image/sign1.png" class="sign"></td>
        </tr>
        <td align="center"><label>纠删码性能测试平台</label></td>
        </tr>
        <tr>
    </table>
</div>
<div class="user_info">
    <p>欢迎,<%=count%></p>
    <a href="LoginPage1.jsp"><button>退出登录</button></a>
</div>
<div class="file_info">
    <div class="table_inside" id="table_inside">
        <table width="98%">
            <tr>
                <td><label class="slave_info_tit">文件 <span class="green">信息</span></label></td>
            </tr>
        </table>
        <table class="ta_file">
            <tr>
                <td width="10%">文件名称</td>
                <td width="10%">文件大小</td>
                <td width="10%">文件类型</td>
                <td width="10%">分块大小</td>
                <td width="30%">上传时间</td>
                <td width="10%">下载文件</td>
                <td width="10%">删除文件</td>
                <td width="10%">文件分块</td>
            </tr>
        </table>
        <div class="ta_inside_inside">
            <table class="table table-striped ta_file1">
                <% ArrayList<FileInfo> fileList = (ArrayList<FileInfo>) session.getAttribute("fileList"); %>
                <% for (int i = 0, j = 50; i < fileList.size(); i++, j++) {
                %>
                <tr>
                    <td width="10%"><%=fileList.get(i).getFileName()%>
                    </td>
                    <td width="10%"><%=fileList.get(i).getFileSize()%>
                    </td>
                    <td width="10%"><%=fileList.get(i).getFileType()%>
                    </td>
                    <td width="10%"><%=fileList.get(i).getLogicBlockSize()%>
                    </td>
                    <td width="30%"><%=fileList.get(i).getUploadTime()%>
                    </td>
                    <td width="10%">
                        <form action="/downloadFile" method="post" id="do_<%=i%>">
                            <input type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
                            <input type="hidden" name="fileName" value="<%=fileList.get(i).getFileName()%>">
                            <a href="#" onclick="return formSubmit_download('do_'+<%=i%>)"><span class="de_bl"><u>下载</u></span></a>
                        </form>
                    </td>
                    <td width="10%">
                        <form action="/deleteFile" method="post" id="de_<%=i%>">
                            <input type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
                            <input type="hidden" name="fileName" value="<%=fileList.get(i).getFileName()%>">
                            <a href="#" onclick="return formSubmit_delete('de_'+<%=i%>)"><span
                                    class="de_bl"><u>删除</u></span></a>
                        </form>
                    </td>
                    <td width="10%">
                        <input id="count" type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
                        <input id="fileName" class="fileName" type="hidden" name="fileName"
                               value="<%=fileList.get(i).getFileName()%>">
                        <a href="#" id="showblock"
                           onclick="loadBlock('','<%=fileList.get(i).getFileName()%>');ca1();"><span
                                class="green"><u>节点</u></span></a>
                    </td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="tinyinterface" id="tinyinterface">
        <label class="slave_info_tit">分块 <span class="green">信息</span></label><br>
        <div class="ta_block_isinside">
            <table id="ta_block" class="ta_block">
                <tr>
                    <td>#</td>
                    <td>分块名称</td>
                    <td>删除</td>
                </tr>
            </table>
        </div>
        <p class="block_interface_introduction">
            这里展示了此文件所有的磁盘分块
            你可以 <span class="green">删除</span> 部分分块 或 <span class="green">恢复</span> 所有分块。<br>
        </p>
        <div class="modal-footer">
            <button type="submit" class="tiny_interface_btn" onclick="getFilename();">
                <span class="green">恢复</span>
            </button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" class="tiny_interface_btn" id="back" onclick="ca2();">返回</button>
        </div>
    </div>
</div>
<br>
<div class="part">
    <div class="slave_info">
        <table>
            <tr>
                <td><label class="slave_info_tit">节点 <span class="green">信息</span></label></td>
            </tr>
        </table>
        <table class="table ta_slave">
            <tr>
                <td>节点名称</td>
                <td>节点地址</td>
            </tr>
            <tr>
                <td><%=a[0][0]%>
                </td>
                <td><%=a[0][1]%>
                </td>
            </tr>
            <tr>
                <td>磁盘</td>
                <td>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped" role="progressbar"
                             aria-valuenow="2" aria-valuemin="0" aria-valuemax="100"
                             style="min-width: 0px; width: <%=a[0][2]%>%;">
                            <%=a[0][2]%>%
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>节点名称</td>
                <td>节点地址</td>
            </tr>
            <tr>
                <td><%=a[1][0]%>
                </td>
                <td><%=a[1][1]%>
                </td>
            </tr>
            <tr>
                <td>磁盘</td>
                <td>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped" role="progressbar"
                             aria-valuenow="2" aria-valuemin="0" aria-valuemax="100"
                             style="min-width: 0px; width: <%=a[1][2]%>%;">
                            <%=a[1][2]%>%
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <div class="jumbotron">
        </div>
    </div>
    <div class="operation">
        <div class="operation_Upload" id="upload">
            <span class="label label-primary operation_tit">上传</span>
            <div class="do_operation">
                <form id="fileForm" action="/uploadFile" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="count"
                           value="<%=(String)session.getAttribute("count")%>">
                    <table class="ta_upload">
                        <tr>
                            <td height="25%">
                                <span>选择算法:</span>
                                <select id="algorithm" name="algorithm" class="btn btn-default">
                                    <option value="0">Replication</option>
                                    <option value="1">EVENODD</option>
                                    <option value="2">LREVENODD</option>
                                    <option value="3">RDP</option>
                                    <option value="4">LRRDP</option>
                                    <option value="5">RS</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td height="50%">
                                <%--<table>--%>
                                <%--<tr>--%>
                                <%--<td width="50%">parameter K:&nbsp;&nbsp;</td>--%>
                                <%--<td><input id="paramK1" type="text" class="form-control parameter"--%>
                                <%--name="paramK">--%>
                                <%--</td>--%>
                                <%--</tr>--%>
                                <%--<tr>--%>
                                <%--<td>&nbsp;</td>--%>
                                <%--</tr>--%>
                                <%--<tr>--%>
                                <%--<td width="50%">parameter N:&nbsp;&nbsp;</td>--%>
                                <%--<td><input id="paramN1" type="text" class="form-control parameter"--%>
                                <%--name="paramN">--%>
                                <%--</td>--%>
                                <%--</tr>--%>
                                <%--</table>--%>
                                <table>
                                    <tr>
                                        <td width="50%">参数 P:&nbsp;&nbsp;</td>
                                        <td><input id="paramP" type="text" class="form-control parameter" name="paramP">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="50%">分块大小:&nbsp;&nbsp;</td>
                                        <td><input id="blocksize" type="text" class="form-control parameter"
                                                   name="blocksize">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="25%">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="file" name="file">
                                        <td>
                                            <input type="submit" class="btn btn-default btn_up" value="上传">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
                <form id="fileForm1" action="/uploadFile" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="count"
                           value="<%=(String)session.getAttribute("count")%>">
                    <table class="ta_upload">
                        <tr>
                            <td height="25%">
                                <span>选择算法:</span>
                                <select id="algorithm1" name="algorithm" class="btn btn-default">
                                    <option value="0">Replication</option>
                                    <option value="1">EVENODD</option>
                                    <option value="2">LREVENODD</option>
                                    <option value="3">RDP</option>
                                    <option value="4">LRRDP</option>
                                    <option value="5">RS</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td height="50%">
                                <table>
                                    <tr>
                                        <td>参数 K:&nbsp;&nbsp;</td>
                                        <td><input id="paramK1" type="text" class="form-control parameter1"
                                                   name="paramK">
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>参数 N:&nbsp;&nbsp;</td>
                                        <td><input id="paramN1" type="text" class="form-control parameter1"
                                                   name="paramN">
                                        </td>
                                        <td>&nbsp;&nbsp;大小:&nbsp;&nbsp;</td>
                                        <td><input id="blocksize1" type="text" class="form-control parameter1"
                                                   name="blocksize">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="25%">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="file" name="file">
                                        </td>
                                        <td>
                                            <input type="submit" class="btn btn-default btn_up" value="上传">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="show_opt" id="show_opt">
            <div id="one_log">
                <table class="opt_tit_no">
                    <tr>
                        <td>
                            <label class="slave_info_tit">操作 <span class="green">日志</span></label>
                            &nbsp;/&nbsp;<button class="change_log" id="btn_one_log"><span class="se_log">性能信息</span>
                        </button>
                        </td>
                        <td align="right">
                            <button class="btn btn-default btn-xs btn_operation"><a href="/refreshOptList">刷新</a>
                            </button>
                            <button class="btn btn-default btn-xs btn_operation"><a href="/exportData">导出日志</a>
                            </button>
                        </td>
                    </tr>
                </table>
                <div class="ta_inside_opt">
                    <table class="ta_opt table table-bordered">
                        <tr>
                            <td>文件名称</td>
                            <td>用户名</td>
                            <td>算法</td>
                            <td>操作</td>
                            <td>时间</td>
                            <td>用时</td>
                            <td>计算用时</td>
                            <td>流量</td>
                        </tr>
                        <% ArrayList<OptInfo> optList = (ArrayList<OptInfo>) session.getAttribute("optList"); %>
                        <% for (int i = 0; i < optList.size(); i++) {
                            OptInfo tempOpt = optList.get(i);
                        %>
                        <tr>
                            <td><%=tempOpt.getFileName()%>
                            </td>
                            <td><%=tempOpt.getUserName()%>
                            </td>
                            <td><%=tempOpt.getAlgName()%>
                            </td>
                            <td><%=tempOpt.getOptType()%>
                            </td>
                            <td><%=tempOpt.getOptTime()%>
                            </td>
                            <td><%=tempOpt.getOptLastTime()%>
                            </td>
                            <td><%=tempOpt.getOptPartTime()%>
                            </td>
                            <td><%=tempOpt.getOptUsedBytes()%>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="two_log">
                <table class="opt_tit_no">
                    <tr>
                        <td>
                            <label class="slave_info_tit">性能 <span class="green">信息</span></label>
                            &nbsp;/&nbsp;<button class="change_log" id="btn_two_log"><span class="se_log">操作日志</span>
                        </button>
                        </td>
                        <td align="right">
                            <button class="btn btn-default btn-xs btn_operation"><a href="/refreshOptList">刷新</a>
                            </button>
                            <button class="btn btn-default btn-xs btn_operation"><a href="/exportPerInfo">导出信息</a>
                            </button>
                        </td>
                    </tr>
                </table>
                <div class="ta_inside_opt">
                    <table class="ta_opt1 table table-bordered">
                        <tr>
                            <td>文件名称</td>
                            <td>算法</td>
                            <td>操作类型</td>
                            <td>时间</td>
                            <td>操作时间</td>
                            <td>流量</td>
                            <td>速度(b/ms)</td>
                            <td>速度(ms/b)</td>
                            <td>带宽</td>
                        </tr>
                        <% ArrayList<PerInfo> perList = (ArrayList<PerInfo>) session.getAttribute("perList"); %>
                        <% for (int i = 0; i < perList.size(); i++) {
                            PerInfo tempOpt = perList.get(i);
                        %>
                        <tr>
                            <td><%=tempOpt.getFileName()%>
                            </td>
                            <td><%=tempOpt.getAlgName()%>
                            </td>
                            <td><%=tempOpt.getOptType()%>
                            </td>
                            <td><%=tempOpt.getOptTime()%>
                            </td>
                            <td><%=tempOpt.getOptLastTime()%>
                            </td>
                            <td><%=tempOpt.getOptUsedBytes()%>
                            </td>
                            <td><%=tempOpt.getSizeinms()%>  <%--速度--------------------------------------------%>
                            </td>
                            <td><%=tempOpt.getMsinsize()%>   <%--速度--------------------------------------------%>
                            </td>
                            <td>
                                <%
                                    if (tempOpt.getBandWidth() != null) {
                                        for (int j = 0; j < tempOpt.getBandWidth().length; j++) {
                                %>
                                <%=tempOpt.getBandWidth()[i]%>/
                                <%
                                        }
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>

    $("#algorithm").change(function () {
        var selectedValue = $(this).val();
        if (selectedValue == 5) {
            $("#fileForm").hide();
            $("#fileForm1").show();
            $("#algorithm1").val(5);
        }
    });
    $("#algorithm1").change(function () {
        var selectedValue = $(this).val();
        if (selectedValue != 5) {
            $("#fileForm1").hide();
            $("#fileForm").show();
            $("#algorithm").val($("#algorithm1").val());
        }
    });
</script>