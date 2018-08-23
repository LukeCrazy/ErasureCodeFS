<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/8 0008
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style type="text/css">
    .top {
        height:204px;
        line-height: 204px;
    }
    .bgImg {
        background: url("pdflogo.png");
        height: 165px;
        line-height: 165px;
        margin: 0 auto;
    }
    .middle {
        width: 1000px;
        margin: 0 auto;
    }
    .pdfImg{
        float: left;
        position: relative;
        right:-15px;
        width: 428px;
    }
    .midInfo{
        float: left;
        width: 359px;
        margin-left: 19px;
    }
    .leftNav{
        float: right;
        width: 186px;
    }
    .hotInfo{
        float: left;
        width: 807px;
        margin-top: 10px;
    }
    .readList{
        float: right;
        width: 186px;
        margin-top:10px;
    }
    .now_page{
        background: #006eb3;
        color: #FFFFFF;
        padding: 0 5px;
        font-weight: bolder;
        float: left;
        width: 150px;
        font-size: 14px;
    }
    .his_num{
        float: right;
        font-weight: bolder;
        color: #006eb3;
        font-size: 14px;
    }
    /*.pageInfo{*/
    /*padding: 8px 0 0;*/
    /*overflow-y: auto;*/
    /*height: 536px;*/
    /*background: #dddddd;*/
    /*}*/
    .scrollPanel{
        padding: 8px 0 0;
        overflow-y: auto;
        height: 536px;
        background: #dddddd;
    }
    .realContent{
        color: #666;
        font-size: 12px;
        padding: 10px;
    }
    .readContent h1{
        color: #333;
        font-size:14px;
    }
    .pageContent{
        padding: 8px;
        overflow-y: auto;
        height: 536px;
        background: #dddddd;
        font-size:12px;
        color: #666;
    }
    .realNav {
        padding: 8px 0 0;
        height: 306px;
        width: 100%;
        background: #dddddd;
    }
    .pageDir{
        display: block;
        width: 176px;
        background: #006eb3;
        color: #FFFFFF;
        padding: 0 5px;
        font-weight: bolder;
        float: left;
        font-size: 14px;
    }
    ul{
        list-style: none;
    }
    ul,li{
        margin:0;
        padding:0;
    }
    li{
        line-height: 24px;
    }
    li span,a{
        width: 100%;
        display: block;
        padding-left: 22px;
        color: #24537a;
        font-weight: 900;
        font-size: 13px;
    }
    li a{
        width: 164px;
        margin: 5px 0;
    }
    li span:hover, a:hover{
        background: #a06d3e;
        color: #FFFFFF;
        cursor: pointer;
    }
    li p{
        padding: 0 24px;
        font-size:12px;
        color: #666;
    }
    .nowShowing{
        background: #a06d3e;
        color: #FFFFFF;
        cursor: pointer;
    }
    /*.autoscroll{*/
    /*padding: 8px 0 0;*/
    /*height: 306px;*/
    /*width: 100%;*/
    /*background: #dddddd;*/
    /*}*/
    .autoscroll span{
        width:785px;
    }
</style>
<body>
<%
    int blockNum = 3;
    //当前版面所有新闻标题
    String[] newsTitle = new String[]{"东坡区土地流转实现上网交易","",""};
    //当前版面所有新闻详细内容
    String[] newsContent = new String[]{"详细新闻内容1","详细新闻内容2","详细新闻内容3"};
    //当前版面所有新闻简介
    String[] newsAbstract = new String[]{"“我今年在这里流转三宗1000 亩土地,计划全部种植‘凤凰李’和‘国庆桃...","本报讯 近日，四川大学华西广安医院泌尿外科利用微创技术，成功为一名中年男性患者...","本报讯  近日,眉山市东坡区科技局联合区扶贫移民局、广济乡政府、连鳌村村组干部..."};
    //报纸总刊数
    String newspaperNum = "二";
    //报纸编印时间
    String newspaperDate = "2018-4-27";
%>
<div class="top">
    <div class="bgImg">
    </div>
    <div class="nav"></div>
</div>
<div class="middle">
    <div class="pdfImg">
        <img width="400" height="550" src="page3.png"> </img>
    </div>
    <div class="midInfo">
        <div style="height: 30px;">
            <span class="now_page">第三版：地方报道</span>
            <span class="his_num">总第<%=newspaperNum%>期：<%=newspaperDate%>编印</span>
        </div>
        <div class="scrollPanel" id="pageInfo">
            <ul>
                <% for(int i=0; i<blockNum; i++){%>
                <li>
                    <span onclick="switchPage(<%=i%>)"><%=newsTitle[i]%></span>
                    <p><%=newsAbstract[i]%></p>
                </li>
                <%}%>
                <li>
                    <span onclick="switchPage(0)">东坡区土地流转实现上网交易</span>
                    <p>“我今年在这里流转三宗1000 亩土地,计划全部种植‘凤凰李’和‘国庆桃...</p>
                </li>
                <li>
                    <span onclick="switchPage(1)">华西广安医院成功开展首例腹腔镜下前列腺癌根治手术</span>
                    <p>本报讯 近日，四川大学华西广安医院泌尿外科利用微创技术，成功为一名中年男性患者...</p>
                </li>
                <li>
                    <span onclick="switchPage(2)">积极创建“绿色基地”</span>
                    <p>本报讯  近日,眉山市东坡区科技局联合区扶贫移民局、广济乡政府、连鳌村村组干部...</p>
                </li>
            </ul>
        </div>
        <div class="scrollPanel" id="pageContent" style="display: none;">
            <div class ="realContent" id="realContent">

            </div>
            <button class="returnBtn" onclick="switchPage2()">返回</button>
        </div>
    </div>
    <div class="leftNav">
        <div style="height: 30px;">
            <span class="pageDir">版面目录</span>
        </div>
        <div class="realNav">
            <ul>
                <li>
                    <a>第一版：新闻</a>
                </li>
                <li>
                    <a>第二版：综合新闻</a>
                </li>
                <li>
                    <a class="nowShowing">第三版：地方报道</a>
                </li>
                <li>
                    <a>第四版：社区科普</a>
                </li>
                <li>
                    <a>第五版：科技扶贫</a>
                </li>
                <li>
                    <a>第六版：法制农村</a>
                </li>
                <li>
                    <a>第七版：教育帮扶</a>
                </li>
                <li>
                    <a>第八版：生活百事</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="hotInfo">
        <div style="height: 30px;">
            <span class="pageDir">本期热点</span>
        </div>
        <div class="scrollPanel">
            <ul>
                <li>
                    <span>标题</span>
                    <p>内容</p>
                </li>
                <li>
                    <span>标题</span>
                    <p>内容</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="readList">
        <div style="height: 30px;">
            <span class="pageDir">阅读排行</span>
        </div>
        <div class="realNav">
            <ul>
                <li>
                    <a>1</a>
                </li>
                <li>
                    <a>2</a>
                </li>
                <li>
                    <a>3</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="footer"></div>
</body>
<script>
    function switchPage(type){
        var newsTitle=[];
        var newsContent=[];
        <% for(int i=0;i<blockNum;i++){%>
        newsTitle.appendData(<%=newsTitle[i]%>);
        newsContent.appendData(<%=newsContent[i]%>);
        <%}%>
        document.getElementById("pageInfo").setAttribute("style","display:none");
        document.getElementById("pageContent").setAttribute("style","display:block");
        document.getElementById("realContent").innerHTML = "<h1>"+newsTitle[type]+"</h1>"+newsContent[type]+"</br></br>"
//        if(type==0){
//            document.getElementById("realContent").innerHTML="<h1>东坡区土地流转实现上网交易</h1>详细新闻内容</br></br>";
////            document.getElementById("realContent").innerHTML = "我今年在这里流转三宗1000 亩土地,计划全部种植‘凤凰李’和‘国庆桃’，同时发展乡村旅游。”近日，从眉山市彭山区到东坡区复盛乡投资的业主王雪梅告诉记者，“我能从外区县来这个陌生的地方流转土地，是从市公共资源交易中心东坡区分中心网上得知的信息。”由此,王雪梅成为该区通过政府挂牌流转农村土地承包经营权的第一个业主。"+
////            "为进一步规范和促进农村土地承包经营权有效流转，今年初开始，东坡区按照已流转面积和预流转面积须达到总面积的70%以上的要求，首先选定在复盛、复兴两个乡启动土地流转为重点的农村产权交易改革试点。"+
////"复盛乡在充分尊重群众意愿的基础上、采取村、组、农广申请和委托方式，由乡土地流转服务公司将全乡22 宗3580 亩的预流转土地,统一汇总后交区农业部门审批备案，由区公共资源中心上网挂牌交易，省内外投资业主都可以来此揭牌。"+
////    "王雪梅从网上得知信息后到复盛乡中桂村实地考察，很快看中当地三宗土地共1000 亩,在与该村签订流转合同和完备其他相关手续以后，王雪梅立即去区交易中心揭牌。她告诉记者:“我之所以把流转土地的目光选择在中桂村，一是通过政府平台发布的土地流转信息可信度高、权威信强,投资更放心。二是这里区位优势突出，离眉山城区仅儿公里，交通便利。三是紧邻著名的桂化湖风景区，具有乡村旅游发展优势。四是复盛乡具有“小水果基地乡’之称，全村李子、桃子、樱桃等小水果种植已初具规模，我在这里把水果产业做大，可以起到示范带动作用。因此，乡、村干部和当地群众也非常重视和支持，全力为我创造发展环境，让我在这里扎下根干下去,当好乡村振兴的领头羊。"+
////    "谈起土地承包经营权流转通过政府挂牌交易的好处,复盛乡土地流转服务中心负责人李青松感叹道，以往土地流转大多靠亲朋好友、近邻熟人、乡村干部等介绍，或者是业主自己打听到找上广了来，不仅信息范围受到局限，而且靠流转方自己发布的信息的权威性和可信度也不高。同时，个别地方还存在缺少统一规划和商业发展方向不同明的问题、士地的利用率和经济效益不高，示范引领作用不强。区上选择在复盛和复兴两个乡试点的目的，就是为了使农村土地承包经营权流转工作更加完善和规范，以适应乡村振兴对农村土地流转的新需求，开创现代特色农业发展新局面。    （陶广汉 袁晟佩 王丽霞 熊霞 本报记者 苏文保）";
//        }
//        else if(type==1){
//            document.getElementById("realContent").innerHTML = "<h1>华西广安医院成功开展首例腹腔镜下前列腺癌根治手术</h1>详细新闻内容</br></br>";
//        }
//        else if(type==2){
//            document.getElementById("realContent").innerHTML = "<h1>积极创建“绿色基地”</h1>详细新闻内容</br></br>";
//        }
    }
    function switchPage2(){
        document.getElementById("pageInfo").setAttribute("style","display:block");
        document.getElementById("pageContent").setAttribute("style","display:none");
    }
    document.onclick=function(ev){
        var oEvent=ev||event;
        var x = oEvent.clientX;
        var y = oEvent.clientY;
        //
        //
        //
        // alert(x);
        //左边
        var blockNum = 2;
        var posXArray = [[194,392],[194,392]];
        var posYArray = [[214,361],[361,545]];
        for(var i=0; i<blockNum; i++){
            if(x>posXArray[i][0] && x<posXArray[i][1] && y>posYArray[i][0] && y<posYArray[i][1]){
                switchPage(i);
            }
        }
//        //右边
//        else if(257<x && x<488){
//            if(214<y && y<304){
//                document.getElementById("text").innerHTML = '加快大数据产业发展。。。';
//            }
//            else if(304<y && y<432){
//                document.getElementById("text").innerHTML = '建设是一项系统的工程。。。';
//            }
//            else if(432<y && y<596){
//                document.getElementById("text").innerHTML = '四、结论。。。';
//            }
//        }
    };
</script>
</html>
