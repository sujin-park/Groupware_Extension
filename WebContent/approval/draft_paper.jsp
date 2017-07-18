<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ include file="/common/member_header.jsp" %>
<script type="text/javascript" src="/moa/js/myajax.js"></script>
<script>
    window.onload = function () {
        var date = new Date();
        document.getElementById("year").value = date.getFullYear();
        document.getElementById("month").value = date.getMonth() + 1;
        document.getElementById("day").value = date.getDate();
    }

    function save() {

        if (document.getElementById("year").value == "") {
            alert("�⵵�� �Է����ּ���");
            return;
        } else if (document.getElementById("month").value == "") {
            alert("���� �Է����ּ���");
            return;
        } else if (document.getElementById("day").value == "") {
            alert("���� �Է����ּ���");
            return;
        } else if (document.getElementById("receiveDept").value == "") {
            alert("���źμ��� �������ּ���");
            return;
        } else if (document.getElementById("subject").value == "") {
            alert("������ �ۼ����ּ���");
            return;
        } else if (document.getElementById("content").value == "") {
            alert("������ �Է����ּ���");
            return;
        } else {
            oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
            document.paperForm.action = "<%=root%>/appcontrol";
            document.paperForm.submit();
        }
    }

    var modal;
    var span;
    var position;
    function doModal(p) {
        position = p;
        modal = document.getElementById("myModal");
        span = document.getElementsByClassName("close")[0];
        modal.style.display = "block";
        sendRequest("/moa/appcontrol", "act=getmember", displayModal, "GET");
    }

    function displayModal() {
        if (httpRequest.readyState == 4) {
            if (httpRequest.status == 200) {
                var tmp = httpRequest.responseText;
                var txt = JSON.parse(tmp);
                var i;
                var x = "";
                var dept = "";
//                var test = "2";
                for (i in txt.info) {
                    if (txt.info[i].dept_num !== dept) {
                        dept = txt.info[i].dept_num;
                        if (i != 0)
                            x += "</ul>";
                        x += "<ul style=\"list-style-type: none\"><b>" + txt.info[i].dept_num + "</b>";

                    }
//                <a href=\"writeModal('" + txt.info[i].emp_num + "')\"</a>
//                    x += "<li id='" + txt.info[i].emp_num + "'>" + txt.info[i].position_num + " " + txt.info[i].name + "</li>";

                    x += "<li onclick='getMember(" + JSON.stringify(txt.info[i]) + ")' id='" + txt.info[i].emp_num + "'>" + txt.info[i].position_num + " " + txt.info[i].name + "</li>";
                }
                x += "</ul>";
                document.getElementById("getmember").innerHTML = x;
//                for (i in txt.info) {
//                    document.getElementById("14").addEventListener("click", getMember(txt.info[i]), false);
//                    $('#txt.info[i].emp_num').click(getMember(txt.info[i]));
//                    console.log("txt.info [i] :  " + txt.info[i].emp_num);
//                }
            } else {
                alert("�����߻� : " + httpRequest.status);
            }
        }
    }

    function getMember(m) {
        var p = position;
//        var txt = JSON.parse(m);
        var confirm = "confirm" + p;
        var sel = "sel" + p;
        var ch = "ch" + p;
        document.getElementById("confirm_line" + p).value = m.emp_num;
        document.getElementById(confirm).innerHTML = m.position_num + " " + m.name;
        document.getElementById(sel).style.display = "none";
        document.getElementById(ch).style.display = "block";
        closeModal();
    }

    function closeModal() {
        modal.style.display = "none";
    }

    function closeModalDept() {
        modal2.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        } else if (event.target == modal2) {
            modal2.style.display = "none";
        }
    }

    var modal2;
    var span2;
    function doModalDept() {
        modal2 = document.getElementById("myModalDept");
        span2 = document.getElementsByClassName("close")[0];
        modal2.style.display = "block";
        sendRequest("/moa/appcontrol", "act=getdept", displayModalDept, "GET");
    }

    function displayModalDept() {
        if (httpRequest.readyState == 4) {
            if (httpRequest.status == 200) {
                var tmp = httpRequest.responseText;
                var txt = JSON.parse(tmp);
                var i;
                var x = "";
                for (i in txt.info) {
                    x += "<input type='checkbox' name='dept'>" + txt.info[i].dept_name + "&nbsp;";
                }
                document.getElementById("getdept").innerHTML = x;
            } else {
                alert("�����߻� : " + httpRequest.status);
            }
        }
    }

    function getDept() {
        var p = position;
//        var txt = JSON.parse(m);
        var confirm = "confirm" + p;
        var sel = "sel" + p;
        var ch = "ch" + p;
        document.getElementById("confirm_line" + p).value = m.emp_num;
        document.getElementById(confirm).innerHTML = m.position_num + " " + m.name;
        document.getElementById(sel).style.display = "none";
        document.getElementById(ch).style.display = "block";
        closeModal();
    }

</script>
<style>
    /* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 250px;
        top: 0;
        width: 100%; /* Full width */
        /*height: 100%; !* Full height *!*/
        overflow: auto; /* Enable scroll if needed */
        /*background-color: rgb(255, 255, 255); !* Fallback color *!*/
        /*background-color: rgba(255, 105, 75, 0.4); !* Black w/ opacity *!*/
    }

    /* Modal Content */
    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 10px;
        border: 1px solid #888;
        width: 700px;
    }

    /* The Close Button */
    .close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
</style>
<script type="text/javascript" src="/moa/editor/js/service/HuskyEZCreator.js" charset="EUC-KR"></script>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">���ڰ��繮��</h1>
            <%--<div id="payment-list" style="position: relative; float: left;">--%>
            <%@include file="list.jsp" %>

            <div class="col-lg-9">

                <div id="myModal" class="modal col-lg-4">

                    <!-- Modal content -->
                    <div class="modal-content" align="center">
                        <span class="close" onclick="closeModal();">&times;</span>
                        <div id="getmember"></div>
                    </div>

                </div>

                <div id="myModalDept" class="modal col-lg-4">

                    <!-- Modal content -->
                    <div class="modal-content" align="center">
                        <span class="close" onclick="closeModal();">&times;</span>
                        <div id="getdept"></div>
                        <div align="center">
                            <input type="button" value="Ȯ��" onclick="getDept()">
                            <input type="button" value="���" onclick="closeModalDept()">
                        </div>
                    </div>

                </div>

                <div align="center" style="font-size: 30px">��ȼ�</div>
                <form name="paperForm" method="post" action="">
                    <input type="hidden" id="confirm_line1" name="confirm_line1" value="">
                    <input type="hidden" id="confirm_line2" name="confirm_line2" value="">
                    <input type="hidden" id="confirm_line3" name="confirm_line3" value="">
                    <input type="hidden" name="act" value="write">
                    <table class="table table-bordered">
                        <tr>
                            <th>������ȣ</th>
                            <td>123-333<input type="checkbox">������ȣ ���</td>
                            <th rowspan="2">����</th>
                            <td id="confirm" rowspan="2">
                                <div id="confirm1"></div>
                                <input type="button" value="����" id="sel1" onclick="doModal(1);" style="display: block">
                                <input type="button" value="����" id="ch1" onclick="doModal(1);" style="display: none">

                            </td>
                            <td rowspan="2">
                                <div id="confirm2"></div>
                                <input type="button" value="����" id="sel2" onclick="doModal(2);" style="display: block">
                                <input type="button" value="����" id="ch2" onclick="doModal(2);" style="display: none">
                            </td>
                            <td rowspan="2">
                                <div id="confirm3"></div>
                                <input type="button" value="����" id="sel3" onclick="doModal(3);" style="display: block">
                                <input type="button" value="����" id="ch3" onclick="doModal(3);" style="display: none">
                            </td>
                        </tr>
                        <tr>
                            <th>��������</th>
                            <td>��ȼ�</td>

                        </tr>
                        <tr>
                            <th>�����</th>
                            <td>
                                <input type="text" id="year" name="year" size="7">��
                                <input type="text" id="month" name="month" size="7">��
                                <input type="text" id="day" name="day" size="7">��
                            </td>
                            <th>���źμ�</th>
                            <td colspan="3">
                                <input type="text" id="receiveDept" name="receiveDept">
                                <input type="button" name="selectDept" id="selectDept" onclick="doModalDept();" value="���źμ�����">
                                <%--<input type="button" name="viewDept" id="viewDept" value="���źμ�����">--%>
                            </td>
                        </tr>
                        <tr>
                            <th>�����</th>
                            <td>���</td>
                            <th>�μ�</th>
                            <td colspan="3"></td>
                        </tr>
                        <tr>
                            <th>����</th>
                            <td colspan="5">
                                <input type="text" size="100%" id="subject" name="subject">
                            </td>
                        </tr>
                        <%-- Naver SmartEditor --%>
                        <tr>
                            <td colspan="6">
                            <textarea name="content" id="content" cols="" rows="30" style="width: 100%;">
                            </textarea>
                                <script type="text/javascript">
                                    var oEditors = [];
                                    nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "content",
                                        sSkinURI: "/moa/editor/SmartEditor2Skin.html",
                                        htParams: {
                                            // ���� ��� ���� (true:���/ false:������� ����)
                                            bUseToolbar: true,
                                            // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
                                            bUseVerticalResizer: false,
                                            // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
                                            bUseModeChanger: true,
                                            fOnBeforeUnload: function () {

                                            }
                                        },
                                        fCreator: "createSEditor2"
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="center">
                                <input type="button" value="����" onclick="javascript:save();">
                                <input type="reset" value="���">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->


</body>
</html>