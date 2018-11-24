<%@page import="Model.Dao.FieldOfStudyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Partner Internships</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap-notify.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>

        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>

        <script>
            $(function () {
                //call get all internships using ajax get method. receives internshipJson string
                $.get('/EpicFYPApp/getAllInternshipsServlet', function (internshipJson) {
                    //parse string into JSON object
                    var internships = JSON.parse(internshipJson);
                    console.log(internships);
                    var internshipHTML = '<div class="table-wrapper"><table>';
                    //loop through each internship and print out as rows in a table
                    $.each(internships, function (index, internship) {
                        internshipHTML += '<thead><tr><th>Internship ID : ' + internship.internshipID + '</th><th colspan="3">' + internship.internshipName + "</th></tr></thead>";
                        internshipHTML += '<tr><td>Internship Description : ' + internship.internshipDescription + "</td><td> Start : " + internship.internshipStart + "</td>";
                        internshipHTML += "<td>End : " + internship.internshipEnd + "</td><td>Pay : $" + internship.internshipPay + "</tr>";
                    });
                    internshipHTML += '</table></div>';
                    //adding table html tag into div which has the id "internships"
                    $("#internships").append(internshipHTML);
                });
                // wait for add internship submit event 
                $("#addPartnerInternship").submit(function (event) {
                    let internshipName = $('input[name="internshipName"]').val();
                    let internshipStart = $('input[name="internshipStart"]').val();
                    let internshipEnd = $('input[name="internshipEnd"]').val();
                    let internshipPay = $('input[name="internshipPay"]').val();
                    let internshipVacancy = $('input[name="internshipVacancy"]').val();
                    let internshipSupervisor = $('input[name="internshipSupervisor"]').val();
                    let internshipSupervisorEmail = $('input[name="internshipSupervisorEmail"]').val();
                    let internshipFieldOfStudy = $("#internshipFieldOfStudyInput option:selected").val();
                    let internshipDescription = $('textarea[name="internshipDescription"]').val();
                    let internshipPartnerID = $('input[name="internshipPartnerID"]').val();
                    let internshipData = {
                        "internshipName": internshipName,
                        "internshipStart": internshipStart,
                        "internshipEnd": internshipEnd,
                        "internshipPay": internshipPay,
                        "internshipVacancy": internshipVacancy,
                        "internshipSupervisor": internshipSupervisor,
                        "internshipSupervisorEmail": internshipSupervisorEmail,
                        "internshipFieldOfStudy": internshipFieldOfStudy,
                        "internshipPartnerID": internshipPartnerID,
                        "internshipDescription": internshipDescription
                    }
                    console.log(internshipData);
                    
                    $.post('/EpicFYPApp/addPartnerInternship', internshipData, function (response) {
                        $('button[data-dismiss="modal"]').click();
                        reloadTable();
                        if (response === "success") {
                            $.notify({
                                // options
                                message: 'Successfully inserted internship'
                            }, {
                                // settings
                                type: 'success'
                            });
                        } else {
                            $.notify({
                                // options
                                message: 'Fail to insert internship'
                            }, {
                                // settings
                                type: 'danger'
                            });
                        }
                    });
                    event.preventDefault();
                });
                
                function reloadTable() {
                    $.get('/EpicFYPApp/getAllInternshipsServlet', function (internshipJson) {
                        //parse string into JSON object
                        var internships = JSON.parse(internshipJson);
                        $("#internships").empty();
                        var internshipHTML = '<div class="table-wrapper"><table>';
                        $.each(internships, function (index, internship) {
                        internshipHTML += '<thead><tr><th>Internship ID : ' + internship.internshipID + '</th><th colspan="3">' + internship.internshipName + "</th></tr></thead>";
                        internshipHTML += '<tr><td>Internship Description : ' + internship.internshipDescription + "</td><td> Start : " + internship.internshipStart + "</td>";
                        internshipHTML += "<td>End : " + internship.internshipEnd + "</td><td>Pay : $" + internship.internshipPay + "</tr>";
                    });
                        internshipHTML += '</table></div>';
                        $("#internships").append(internshipHTML);
                    });
                }
            });
        </script>
    </head>
    <body>

        <jsp:include page="header.jsp" />
        
        <jsp:include page="PartnerPortalPermission.jsp" />

        <!-- Main -->
        <section id="main" class="wrapper">
            <div class ="container">
                <div class="tab">
                    <button class="tablinks" onclick="openUser(event, 'addInternshipTab')" id="defaultOpen">Add a new Internship</button>
                </div>

                <div id="addInternshipTab" class="tabcontent">
                    <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>
                    <form id="addPartnerInternship" enctype="multipart/form-data">
                        
                        <div class = "row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Internship Position: <input required type="text" name="internshipName" placeholder="E.g: Data Analytics Intern">
                                </p>
                            </div>
                            
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Field of Study:  
                                <select id="internshipFieldOfStudyInput" name="internshipFieldOfStudy" required>
                                    <option disabled selected value style="display:none"> - Select field of study - </option>
                                    <%
                                        ArrayList<String> result = FieldOfStudyDAO.getFieldOfStudies();
                                        if (!result.isEmpty()) {
                                            for (int i = 0; i < result.size(); i++) {
                                                String fos = result.get(i);
                                    %>
                                    <option value="<%out.print(fos);%>"><%out.print(fos);%></option>
                                        <%  }
                                        }
                                    %>
                                </select>
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Salary ($): <input name="internshipPay" required type="number" min="1" placeholder="E.g: 900">
                                </p>
                            </div>
                        </div>

                        <div class = "row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <% LocalDate todayDate = java.time.LocalDate.now(); %>
                                <p>
                                    Start Date (dd-mm-yyyy): <input name="internshipStart" id="internshipStart" required type="date" min = "<% out.print(todayDate); %>">
                                </p>
                            </div>
                                
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    End Date (dd-mm-yyyy): <input name="internshipEnd" id="internshipEnd" required type="date" min = "<% out.print(todayDate); %>">
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Vacancy: <input name="internshipVacancy" required type="number" min="1" placeholder="E.g: 3">
                                </p>
                            </div>
                        </div>
                 

                        <div class ="row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Supervisor Name: <input name="internshipSupervisor" required type="text" placeholder="E.g: Tommy Tan">
                                </p>
                            </div>
                            
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Supervisor Email: <input name="internshipSupervisorEmail" required type="text" placeholder="E.g: tommy.tan@psa.com.sg">
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Description: <textarea rows="4" cols="50" name="internshipDescription" required placeholder="E.g: Interns are expected to have strong command of knowledge with regards to important historical sites."></textarea>
                                </p>
                            </div>
                        </div>
                                <br>
                        <input type="submit" value="Create an Internship!" style="width:100%">
                    </form>
                </div>
            </div>

        </section>
    <script src="js/custom-file-input.js"></script>
    <script src="js/tabs.js"></script>
</body>
</html>

