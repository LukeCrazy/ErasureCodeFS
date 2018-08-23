<%@ page import="Model.FileInfo" %>
<%@ page import="Model.OptInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.hadoop.hdfs.protocol.DatanodeInfo" %><%--
  Created by IntelliJ IDEA.
  User: luke
  Date: 18-2-27
  Time: 下午7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;char set=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<div id="header"></div>
<div id="main">
    <div id="filePanel">
        <span>FileList</span>
        <ul id="fileList">
            <% ArrayList<FileInfo> fileList = (ArrayList<FileInfo>) session.getAttribute("fileList"); %>
            <% for (int i = 0; i < fileList.size(); i++) {
                FileInfo tempFile = fileList.get(i);
            %>
            <li><%=tempFile.getFileName()%>
            </li>
            <%
                }
            %>
        </ul>
        <ul>
            <li>
                <form id="downloadFile" action="/downloadFile" method="post">
                    <label>Download File: Input file name</label>
                    <input type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
                    <input type="text" name="fileName"/>
                    <input id="download" type="submit" value="Download File"/>
                </form>
                <form id="deleteloadFile" action="/deleteFile" method="post">
                    <label>Delete File: Input file name</label>
                    <input type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
                    <input type="text" name="fileName"/>
                    <input id="delete" type="submit" value="Delete File"/>
                </form>
            </li>
        </ul>
    </div>
    <div id="uploadPanel">
        <form id="fileForm" action="/uploadFile" method="post" enctype="multipart/form-data">
            <input type="hidden" name="count" value="<%=(String)session.getAttribute("count")%>">
            <label>Choose one Algorithm</label>
            <select id="algorithm" name="algorithm">
                <option value="0">Replication</option>
                <option value="1">EVENODD</option>
                <option value="2">LREVENODD</option>
            </select>
            <label>Parameter K</label>
            <input id="paramK" type="text" name="paramK"/>
            <label>Parameter N</label>
            <input id="paramN" type="text" name="paramN"/>
            <label>Choose File</label>
            <input type="file" name="file">
            <input id="upload" type="submit" value="Upload File"/>${error}
        </form>
    </div>
    <div id="infoPanel">
        <ul id="infoList">
            <% ArrayList<OptInfo> optList = (ArrayList<OptInfo>) session.getAttribute("optList"); %>
            <% for (int i = 0; i < optList.size(); i++) {
                OptInfo tempOpt = optList.get(i);
            %>
            <li><%=tempOpt.getFileName()%>|<%=tempOpt.getUserName()%>|<%=tempOpt.getAlgName()%>
                |<%=tempOpt.getOptType()%>|<%=tempOpt.getOptTime()%>|<%=tempOpt.getOptLastTime()%>
                |<%=tempOpt.getOptUsedBytes()%>|
            </li>
            <%
                }
            %>
        </ul>
        <form id="refreshOptList" action="/refreshOptList" method="post">
            <input id="refresh" type="submit" value="Refresh">
        </form>

    </div>
</div>
<div>
    <form method="get" action="NodeInfo">
    <input type="submit" value="NodeInfo" /></form>
</div>
</body>
</html>
