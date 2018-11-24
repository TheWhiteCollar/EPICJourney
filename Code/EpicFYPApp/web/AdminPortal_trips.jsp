<%@page import="Model.Dao.CountryTripDAO"%>
<%@page import="Model.Entity.Interest"%>
<%@page import="Model.Dao.InterestDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin Trips</title>
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
                //call get all trips using ajax get method. receives tripJson string
                $.get('/EpicFYPApp/getAllTripsServlet', function (tripJson) {
                    //parse string into JSON object
                    var trips = JSON.parse(tripJson);
                    console.log(trips);
                    var tripHTML = '<div class="table-wrapper"><table>';
                    //loop through each trip and print out as rows in a table
                    $.each(trips, function (index, trip) {
                        tripHTML += '<thead><tr><th>Trip ID : ' + trip.tripID + '</th><th colspan="3">' + trip.tripTitle + "</th></tr></thead>";
                        tripHTML += '<tr><td>Country : ' + trip.tripCountry + "</td><td> Start : " + trip.tripStart + "</td>";
                        tripHTML += "<td>End : " + trip.tripEnd + "</td><td>Price : $" + trip.tripPrice + "</tr>";
                        tripHTML += '<tr><td colspan="4"> Trip Description: ' + trip.tripDescription + '</td></tr>';
                        var number = trip.tripActivation - trip.signedUpEmails.length;
                        if (trip.activated) {
                            tripHTML += '<tr><td colspan="3">Activated</td>';
                        } else {
                            tripHTML += '<tr><td colspan="3">Not Activated : ' + number + " more to activate this trip</td>";
                        }
                        tripHTML += "<td>" + trip.signedUpEmails.length + " signed up</td></tr>";
                        tripHTML += "<tr><td><form class=\"deleteTrip\">";
                        tripHTML += "<input style=\"display: none\" type=\"text\" name=\"tripID\" value=\"" + trip.tripID + "\"/>";
                        tripHTML += "<button class = \"button\" type=\"submit\" id=\"asd" + index + "\">Delete Trip</button></form></td>";
                        tripHTML += "</tr>";
                    });
                    tripHTML += '</table></div>';
                    //adding table html tag into div which has the id "trips"
                    $("#trips").append(tripHTML);

                    //wait for delete trip form to be submited
                    $(".deleteTrip").submit(function (event) {
                        //store the tripid from the form
                        var tripID = "" + $(this).children("input").val();
                        var deleteData = {
                            'id': tripID
                        };
                        console.log("tripID: " + tripID);
                        //send an ajax post request to the delete trip servlet with delete data
                        $.post('/EpicFYPApp/deleteTrip', deleteData, function (response) {
                            if (response === "success") {
                                $.notify({
                                    // options
                                    message: 'Successfully deleted trip'
                                }, {
                                    // settings
                                    type: 'success'
                                });
                            } else {
                                $.notify({
                                    // options
                                    message: 'Fail to delete trip'
                                }, {
                                    // settings
                                    type: 'danger'
                                });
                            }
                            reloadTable();
                        })
                        //prevents form from being submitted
                        event.preventDefault();
                        // validate and process form here
                    });
                });
                // wait for add trip submit event 
                $("#addTrip").submit(function (event) {
                    let tripCountry = $("#tripCountryInput option:selected").val();
                    let tripPrice = $('input[name="tripPrice"]').val();
                    let tripTitle = $('input[name="tripTitle"]').val();
                    let tripDuration = $('input[name="tripDuration"]').val();
                    let tripStart = $('input[name="tripStart"]').val();
                    let tripEnd = $('input[name="tripEnd"]').val();
                    let tripActivation = $('input[name="tripActivation"]').val();
                    let tripInterest = $("#tripInterestInput option:selected").val();
                    let tripDescription = $('textarea[name="tripDescription"]').val();
                    let tripState = $('input[name="tripState"]').val();

                    let tripData = {
                        "tripCountry": tripCountry,
                        "tripPrice": tripPrice,
                        "tripTitle": tripTitle,
                        "tripDuration": tripDuration,
                        "tripStart": tripStart,
                        "tripEnd": tripEnd,
                        "tripActivation": tripActivation,
                        "tripInterest": tripInterest,
                        "tripDescription": tripDescription,
                        "tripState": tripState
                    }

                    console.log(tripData);
                    //send ajax post request to addTrip servlet with tripData
                    $.post('/EpicFYPApp/addTrip', tripData, function (response) {
                        $('button[data-dismiss="modal"]').click();
                        reloadTable();
                        if (response === "success") {
                            $.notify({
                                // options
                                message: 'Successfully inserted trip'
                            }, {
                                // settings
                                type: 'success'
                            });
                        } else {
                            $.notify({
                                // options
                                message: 'Fail to insert trip'
                            }, {
                                // settings
                                type: 'danger'
                            });
                        }
                    });
                    event.preventDefault();
                });

                function reloadTable() {
                    $.get('/EpicFYPApp/getAllTripsServlet', function (tripJson) {
                        //parse string into JSON object
                        var trips = JSON.parse(tripJson);
                        console.log(trips);
                        $("#trips").empty();
                        var tripHTML = '<div class="table-wrapper"><table>';
                        //loop through each trip and print out as rows in a table
                        $.each(trips, function (index, trip) {
                            tripHTML += '<thead><tr><th>Trip ID : ' + trip.tripID + '</th><th colspan="3">' + trip.tripTitle + "</th></tr></thead>";
                            tripHTML += '<tr><td>Country : ' + trip.tripCountry + "</td><td> Start : " + trip.tripStart + "</td>";
                            tripHTML += "<td>End : " + trip.tripEnd + "</td><td>Price : $" + trip.tripPrice + "</tr>";
                            tripHTML += '<tr><td colspan="4"> Trip Description: ' + trip.tripDescription + '</td></tr>';
                            var number = trip.tripActivation - trip.signedUpEmails.length;
                            if (trip.activated) {
                                tripHTML += '<tr><td colspan="3">Activated</td>';
                            } else {
                                tripHTML += '<tr><td colspan="3">Not Activated : ' + number + " more to activate this trip</td>";
                            }
                            tripHTML += "<td>" + trip.signedUpEmails.length + " signed up</td></tr>";
                            tripHTML += "<tr><td><form class=\"deleteTrip\">";
                            tripHTML += "<input style=\"display: none\" type=\"text\" name=\"tripID\" value=\"" + trip.tripID + "\"/>";
                            tripHTML += "<button class = \"button\" type=\"submit\" id=\"asd" + index + "\">Delete Trip</button></form></td>";
                            tripHTML += "</tr>";
                        });
                        tripHTML += '</table></div>';
                        $("#trips").append(tripHTML);

                        $(".deleteTrip").submit(function (event) {
                            var tripID = "" + $(this).children("input").val();
                            var deleteData = {
                                'id': tripID
                            };

                            $.post('/EpicFYPApp/deleteTrip', deleteData, function (response) {
                                if (response === "success") {
                                    $.notify({
                                        // options
                                        message: 'Successfully deleted trip'
                                    }, {
                                        // settings
                                        type: 'success'
                                    });
                                } else {
                                    $.notify({
                                        // options
                                        message: 'Fail to delete trip'
                                    }, {
                                        type: 'danger'
                                    });
                                }
                                reloadTable();
                            })
                            event.preventDefault();
                        });
                    });
                }

                getAllCountries();
                getAllInterests()
            });

            function getAllCountries() {
                $.get('/EpicFYPApp/getAllCountries', function (countriesJSON) {
                    const countries = JSON.parse(countriesJSON);
                    $("#allCountries").empty();
                    let countriesHTML = '';
                    countriesHTML += '<h4 class="align-center">List of Countries</h4><table class="alt">';
                    countriesHTML += "<thead><tr><th>#</th><th colspan='2'>Country Name</th></tr></thead>";
                    var count = 1;
                    for (const country of countries) {
                        countriesHTML += '<tr><td>' + count + '</td><td>' + country + "</td><td><button class = \"button\" value='" + country + "' onclick='deleteCountry(this)'>Delete</button></td></tr>";
                        count += 1;
                    }
                    countriesHTML += '</table>';
                    $("#allCountries").append(countriesHTML);
                });
            }

            function getAllInterests() {
                $.get('/EpicFYPApp/getAllInterest', function (interestsJSON) {
                    const interests = JSON.parse(interestsJSON);
                    $("#allInterests").empty();
                    let interestsHTML = '';
                    interestsHTML += '<h4 class="align-center">List of Interest tags</h4><table class="alt">';
                    interestsHTML += "<thead><tr><th>#</th><th colspan='2'>Name of interest tag</th></tr></thead>";
                    var count = 1;
                    for (const interest of interests) {
                        interestsHTML += '<tr><td>' + count + '</td><td>' + interest + "</td><td><button class = \"button\" value='" + interest + "' onclick='deleteInterest(this)'>Delete</button></td></tr>";
                        count += 1;
                    }
                    interestsHTML += '</table>';
                    $("#allInterests").append(interestsHTML);
                });
            }

            function addCountry() {
                let countryTripName = $("input[name='countryTripName']").val();
                let countryData = {
                    "countryTripName": countryTripName,
                }
                $.post('/EpicFYPApp/addCountry', countryData, function (response) {
                    getAllCountries();
                    if (response === "success") {
                        $.notify({
                            // options
                            message: 'Successfully added country'
                        }, {
                            // settings
                            type: 'success'
                        });
                    } else {
                        $.notify({
                            // options
                            message: 'Fail to add country'
                        }, {
                            type: 'danger'
                        });
                    }
                    $("input[name='countryTripName']").val('');
                });
            }

            function addInterest() {
                let interestName = $("input[name='interestName']").val();
                let interestData = {
                    "interestName": interestName,
                }
                $.post('/EpicFYPApp/addInterest', interestData, function (response) {
                    getAllInterests();
                    if (response === "success") {
                        $.notify({
                            // options
                            message: 'Successfully added interest'
                        }, {
                            // settings
                            type: 'success'
                        });
                    } else {
                        $.notify({
                            // options
                            message: 'Fail to add interest'
                        }, {
                            type: 'danger'
                        });
                    }
                    $("input[name='interestName']").val('');
                });
            }

            function deleteCountry(obj) {
                let countryTripName = $(obj).val();
                let countryData = {
                    "countryTripName": countryTripName
                };
                $.post('/EpicFYPApp/deleteCountry', countryData, function (response) {
                    getAllCountries();
                    if (response === "success") {
                        $.notify({
                            // options
                            message: 'Successfully deleted country'
                        }, {
                            // settings
                            type: 'success'
                        });
                    } else {
                        $.notify({
                            // options
                            message: 'Fail to delete country'
                        }, {
                            type: 'danger'
                        });
                    }
                });
            }

            function deleteInterest(obj) {
                let interestName = $(obj).val();
                let interestData = {
                    "interestName": interestName
                };
                $.post('/EpicFYPApp/deleteInterest', interestData, function (response) {
                    getAllInterests();
                    if (response === "success") {
                        $.notify({
                            // options
                            message: 'Successfully deleted interest'
                        }, {
                            // settings
                            type: 'success'
                        });
                    } else {
                        $.notify({
                            // options
                            message: 'Fail to delete interest'
                        }, {
                            type: 'danger'
                        });
                    }
                });
            }
        </script>
        <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="header.jsp" />
        <jsp:include page="AdminPortalPermission.jsp" />
        <!-- Main -->
        <section id="main" class="wrapper">

            <!-- Tab for: filter, add trip form -->
            <div class ="container">
                <div class="tab">
                    <!-- <button class="tablinks icon fa-filter" onclick="openUser(event, 'filterTab')"> Filtering Options</button> -->
                    <button class="tablinks" onclick="openUser(event, 'addTripTab')">Add a new Trip</button>
                    <button class="tablinks" onclick="openUser(event, 'addCountry')">Manage Country List</button>
                    <button class="tablinks" onclick="openUser(event, 'addInterest')">Manage Interest tags</button>
                </div>

                <!-- For user to choose if they want to login as student or admin -->
                <!--
                <div id="filterTab" class="tabcontent">

                    <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>
                    <form action="filterTrips.jsp" method="post">
                        <p>
                        <div class = "row">
                            <div class="3u 12u(small)">
                <% LocalDate todayDate = java.time.LocalDate.now(); %>

                Date (min):                                                                       
                <input name = "startDate" type="date" min = "<% //out.print(todayDate); %>" >
            </div>
            <div class="3u 12u(small)">
                Date (max):                              
                <input name = "endDate" type="date" min = "<% //out.print(todayDate);%>" >
            </div> 
            <div class="3u 12u(small)">
                Price (min):
                <input type="number" value = "min" min = "0">
            </div>
            <div class="3u 12u(small)">
                Price (max):
                <input type="number" value = "max" min = "0">
            </div>
        </div>
        </p>

        <input type="submit" value="Apply" style="width:100%"> 
    </form> 
</div>
                -->
                <!--                <form id="myDownloadServlet" action="AdminExcelFileDownload" method="post">
                                    <input type="text" id="fileName" name="fileName" />
                                    <input type="submit" id="btnDownload" name="btnDownload" value="Download Excel File" />
                                </form>     -->

                <!-- Adding a trip -->
                <div id="addTripTab" class="tabcontent">
                    <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>
                    <form id="addTrip" enctype="multipart/form-data">
                        <div class = "row 50% uniform">
                            <div class = "6u 12u(xsmall)">
                                <p>
                                    Programme Title: <input required type="text" name="tripTitle" placeholder="e.g: Winter Study Trip">
                                </p>
                            </div>

                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Country of visit: 
                                    <select id="tripCountryInput" name="tripCountry" required>
                                        <option disabled selected value style="display:none"> - Select a country - </option>
                                        <%
                                            ArrayList<String> result = CountryTripDAO.getAllCountryTrip();
                                            if (!result.isEmpty()) {
                                                for (int i = 0; i < result.size(); i++) {
                                                    String country = result.get(i);
                                        %>
                                        <option value="<%out.print(country);%>"><%out.print(country);%></option>
                                        <%  }
                                            }
                                        %>
                                    </select>
                                </p>
                            </div>
                        </div>

                        <div class = "row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Trip Start (dd-mm-yyyy): <input name="tripStart" id="tripStart" required type="date" min = "<% out.print(todayDate); %>">
                                </p>
                            </div>

                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Trip End (dd-mm-yyyy): <input name="tripEnd" id="tripEnd" required type="date" min = "<% out.print(todayDate); %>">
                                </p>
                            </div>

                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Trip Duration (days): 
                                    <input required type="text" min="1" step="1" placeholder="days" name="tripDuration" id="tripDuration" value="0" onclick="dateDiff()">
                                </p>
                            </div>
                        </div>

                        <div class ="row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Price ($): <input name="tripPrice" required type="number" min="1" placeholder="e.g: 100">
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Activation number: <input name="tripActivation" required type="number" min="1" placeholder="e.g: 4">
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Programme Category tag: 
                                    <select name="tripInterest" id="tripInterestInput" required>
                                        <option disabled selected value style="display:none"> - select a programme category - </option>
                                        <%
                                            ArrayList<String> allInterest = InterestDAO.getInterests();
                                            if (!allInterest.isEmpty()) {
                                                for (int i = 0; i < allInterest.size(); i++) {
                                                    String interest = allInterest.get(i);
                                        %>
                                        <option value="<%out.print(interest);%>"><%out.print(interest);%></option>
                                        <%  }
                                            }
                                        %>
                                    </select>
                                </p>
                            </div>
                        </div>

                        <div class ="row 50% uniform">
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    Description: <textarea rows="4" cols="50" name="tripDescription" required placeholder="E.g: The beautiful Lake Inle will wait for no one. Enjoy the beauty before global warming mars it's beauty forever."></textarea>
                                </p>
                            </div>
                            <div class = "4u 12u(xsmall)">
                                <p>
                                    State: <input name="tripState" required type="text" placeholder="E.g: Johor">
                                </p>
                            </div>

                        </div>

                        <!--
            <div class = "row 50% uniform">
                <div class = "12u 12u(xsmall)">
                    <p>
                        <input type="file" name="tripItineray" id="file-1" class="inputfile inputfile-1" style="visibility:hidden" accept=".pdf"/>
                        <label for="file-1" class = "button special"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> 
                            <span>Upload Trip Itinerary</span>
                        </label>
                    </p>
                </div>
            </div> 
                        -->

                        <br>

                        <input type="submit" value="Create a Trip!" style="width:100%">
                    </form>
                </div>
            </div>
            <div id="addCountry" class="tabcontent">
                <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>              
                <div class = "row 50% uniform">
                    <div class = "5u 12u(xsmall) table-wrapper" id="allCountries"></div>
                    <div class="7u 12u(xsmall)">
                        <table>
                            <tbody>
                                <tr>
                                    <td colspan="2"><h4 class="align-center">Add a new Country</h4></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="countryTripName" placeholder="E.g. Singapore" /></td>
                                    <td><button onclick="addCountry()" class="button">Add Country</button></td>
                                </tr>
                            </tbody>
                        </table>                
                    </div>
                </div>
            </div>

            <div id="addInterest" class="tabcontent">
                <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>
                <div class = "row 50% uniform">
                    <div class = "5u 12u(xsmall) table-wrapper" id="allInterests"></div>
                    <div class="7u 12u(xsmall)">
                        <table>
                            <tbody>
                                <tr>
                                    <td colspan="2"><h4 class="align-center">Add a new Interest tag</h4></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="interestName" placeholder="E.g. Business" /></td>
                                    <td><button onclick="addInterest()" class="button">Add Interest</button></td>
                                </tr>
                            </tbody>
                        </table>                
                    </div>
                </div>
            </div>
        </div>

        <!-- this contains all the trips -->
        <div class ="container">
            <br>
            <h2 class="align-center">All Listed Trips</h2>
            <div id="trips" class ="container"></div>
        </div>

        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">List of Users</h4>
                    </div>
                    <div class="modal-body">

                        <table class = "alt" id = "tripUsers">
                            <thead>
                            <td>Number</td> 
                            <td>Name</td>
                            <td>Email</td>
                            <td>Phone</td>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Number</td> 
                                    <td>Name</td>
                                    <td>Email</td>
                                    <td>Phone</td> 
                                </tr>
                                <tr>
                                    <td>Number</td> 
                                    <td>Name</td>
                                    <td>Email</td>
                                    <td>Phone</td> 
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="button" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        function dateDiff() {
            var date1 = document.getElementById('tripStart').value;
            date1 = new Date(date1);
            var date2 = document.getElementById('tripEnd').value;
            date2 = new Date(date2);
            var d1 = Date.parse(date1);
            var d2 = Date.parse(date2);
            if (d1 < d2) {
                var timeDiff = Math.abs(date2 - date1);
                var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                diffDays += 1;
                document.getElementById("tripDuration").value = diffDays;
            } else {
                alert("Start date must be earlier than End date!");
            }
        }
    </script>
    <script src="js/custom-file-input.js"></script>
    <script src="js/tabs.js"></script>
</body>
</html>