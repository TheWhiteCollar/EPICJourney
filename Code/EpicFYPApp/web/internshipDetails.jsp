<%@page import="java.util.Calendar"%>
<%@page import="Model.Dao.InternshipStudentDAO"%>
<%@page import="Model.Dao.FieldOfStudyDAO"%>
<%@page import="Model.Entity.CountryInternship"%>
<%@page import="Model.Dao.CountryInternshipDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="Model.Entity.Admin"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="Model.Entity.Trip"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Overseas study missions/internships for all</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>


        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
        <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->

    </head>
    <body>

        <!-- Header -->        
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <section id="main" class="wrapper ">
            <div class="container">

                <%
                    String contient = request.getParameter("cont");
                %>

                <header class="major align-center">
                    <h2>You are interested in <%out.print(contient);%> internships </h2>

                </header>
                <div class="row 50% uniform">                       
                    </br>
                    <div class="5u 12u(xsmall))">
                        <h3 class="align-center">Partnering country/countries in <%out.print(contient);%>:</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th class="align-center">#</th>
                                    <th>Country Name</th>
                                </tr> 
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<CountryInternship> allCountries = CountryInternshipDAO.getAllCountryInternship(contient);
                                    int count = 0;
                                    if (allCountries != null) {
                                        for (int i = 0; i < allCountries.size(); i++) {
                                            CountryInternship ci = allCountries.get(i);
                                            count += 1;
                                %>

                                <tr>
                                    <td class="align-center"><%out.print(count);%></td>
                                    <td><%out.print(ci.getCountryName());%></td>
                                </tr>

                                <%
                                        }
                                    }

                                %>
                            </tbody>
                        </table>
                    </div> 
                    <div class="7u 12u(xsmall)">
                        <%                            
                            User User = (User) session.getAttribute("User");
                            if (User != null) {
                                String email = User.getUserEmail();
                                String firstName = User.getUserFirstName();
                                String lastName = User.getUserLastName();
                                int phone = User.getUserPhone();
                                String citizenship = User.getUserCitizenship();
                                String highest_qualification = User.getUserHighestEducation();
                                String school = User.getUserSchool();
                                String userFOS = User.getUserFieldOfStudy();
                                int year = Calendar.getInstance().get(Calendar.YEAR);
                                if (InternshipStudentDAO.countInternshipStudentByCont(email, contient, year) != 0) {
                                    //you alr signed up
                        %>
                        <h3 class="align-center">You have already signed up for an internship to <%out.print(contient);%></h3>  
                        <div align="center"><a href = "studentPortal_main.jsp" class = "button">View your sign ups</a></div>
                        <%
                        } else {
                            //show them the sign up
                        %>
                        <h3 class="align-center">Please confirm your particulars</h3>
                        <div align="center"><p>Note: These fields will be used by the system to track your application process</p></div>

                        <form action="addNewInternshipStudent" method="post" enctype="multipart/form-data">
                            <div class="12u 12u(xsmall)">
                                <div class="table-wrapper">
                                    <table class="blank">
                                        <tbody>                                           
                                            <tr>
                                                <td>First Name:</td>
                                                <td><input type ="text" name ="firstName" value =" <% out.print(firstName);%>"/> </td>
                                            </tr>
                                            <tr>
                                                <td>Last Name:</td>
                                                <td><input type ="text" name ="lastName" value =" <% out.print(lastName);%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Citizenship:</td>
                                                <td>
                                                    <select name ="citizenship">
                                                        <option selected value ="<% out.print(citizenship);%>"/><% out.print(citizenship);%></option>
                                                        <option value="Singaporean">Singaporean</option>
                                                        <option value="Singapore PR">Singapore PR</option>
                                                        <option value="Afghan">Afghan</option>
                                                        <option value="Albanian">Albanian</option>
                                                        <option value="Algerian">Algerian</option>
                                                        <option value="American">American</option>
                                                        <option value="Andorran">Andorran</option>
                                                        <option value="Angolan">Angolan</option>
                                                        <option value="Antiguans">Antiguans</option>
                                                        <option value="Argentinean">Argentinean</option>
                                                        <option value="Armenian">Armenian</option>
                                                        <option value="Australian">Australian</option>
                                                        <option value="Austrian">Austrian</option>
                                                        <option value="Azerbaijani">Azerbaijani</option>
                                                        <option value="Bahamian">Bahamian</option>
                                                        <option value="Bahraini">Bahraini</option>
                                                        <option value="Bangladeshi">Bangladeshi</option>
                                                        <option value="Barbadian">Barbadian</option>
                                                        <option value="Barbudans">Barbudans</option>
                                                        <option value="Batswana">Batswana</option>
                                                        <option value="Belarusian">Belarusian</option>
                                                        <option value="Belgian">Belgian</option>
                                                        <option value="Belizean">Belizean</option>
                                                        <option value="Beninese">Beninese</option>
                                                        <option value="Bhutanese">Bhutanese</option>
                                                        <option value="Bolivian">Bolivian</option>
                                                        <option value="Bosnian">Bosnian</option>
                                                        <option value="Brazilian">Brazilian</option>
                                                        <option value="British">British</option>
                                                        <option value="Bruneian">Bruneian</option>
                                                        <option value="Bulgarian">Bulgarian</option>
                                                        <option value="Burkinabe">Burkinabe</option>
                                                        <option value="Burmese">Burmese</option>
                                                        <option value="Burundian">Burundian</option>
                                                        <option value="Cambodian">Cambodian</option>
                                                        <option value="Cameroonian">Cameroonian</option>
                                                        <option value="Canadian">Canadian</option>
                                                        <option value="Cape verdean">Cape Verdean</option>
                                                        <option value="Central african">Central African</option>
                                                        <option value="Chadian">Chadian</option>
                                                        <option value="Chilean">Chilean</option>
                                                        <option value="Chinese">Chinese</option>
                                                        <option value="Colombian">Colombian</option>
                                                        <option value="Comoran">Comoran</option>
                                                        <option value="Congolese">Congolese</option>
                                                        <option value="Costa rican">Costa Rican</option>
                                                        <option value="Croatian">Croatian</option>
                                                        <option value="Cuban">Cuban</option>
                                                        <option value="Cypriot">Cypriot</option>
                                                        <option value="Czech">Czech</option>
                                                        <option value="Canish">Danish</option>
                                                        <option value="Cjibouti">Djibouti</option>
                                                        <option value="Dominican">Dominican</option>
                                                        <option value="Dutch">Dutch</option>
                                                        <option value="East timorese">East Timorese</option>
                                                        <option value="Ecuadorean">Ecuadorean</option>
                                                        <option value="Egyptian">Egyptian</option>
                                                        <option value="Emirian">Emirian</option>
                                                        <option value="Equatorial guinean">Equatorial Guinean</option>
                                                        <option value="Eritrean">Eritrean</option>
                                                        <option value="Estonian">Estonian</option>
                                                        <option value="Ethiopian">Ethiopian</option>
                                                        <option value="Fijian">Fijian</option>
                                                        <option value="Filipino">Filipino</option>
                                                        <option value="Finnish">Finnish</option>
                                                        <option value="French">French</option>
                                                        <option value="Gabonese">Gabonese</option>
                                                        <option value="Gambian">Gambian</option>
                                                        <option value="Georgian">Georgian</option>
                                                        <option value="German">German</option>
                                                        <option value="Ghanaian">Ghanaian</option>
                                                        <option value="Greek">Greek</option>
                                                        <option value="Grenadian">Grenadian</option>
                                                        <option value="Guatemalan">Guatemalan</option>
                                                        <option value="Guinea-bissauan">Guinea-Bissauan</option>
                                                        <option value="Guinean">Guinean</option>
                                                        <option value="Guyanese">Guyanese</option>
                                                        <option value="Haitian">Haitian</option>
                                                        <option value="Herzegovinian">Herzegovinian</option>
                                                        <option value="Honduran">Honduran</option>
                                                        <option value="Hungarian">Hungarian</option>
                                                        <option value="Icelander">Icelander</option>
                                                        <option value="Indian">Indian</option>
                                                        <option value="Indonesian">Indonesian</option>
                                                        <option value="Iranian">Iranian</option>
                                                        <option value="Iraqi">Iraqi</option>
                                                        <option value="Irish">Irish</option>
                                                        <option value="Israeli">Israeli</option>
                                                        <option value="Italian">Italian</option>
                                                        <option value="Ivorian">Ivorian</option>
                                                        <option value="Jamaican">Jamaican</option>
                                                        <option value="Japanese">Japanese</option>
                                                        <option value="Jordanian">Jordanian</option>
                                                        <option value="Kazakhstani">Kazakhstani</option>
                                                        <option value="Kenyan">Kenyan</option>
                                                        <option value="Kittian and nevisian">Kittian and Nevisian</option>
                                                        <option value="Kuwaiti">Kuwaiti</option>
                                                        <option value="Kyrgyz">Kyrgyz</option>
                                                        <option value="Laotian">Laotian</option>
                                                        <option value="Latvian">Latvian</option>
                                                        <option value="Lebanese">Lebanese</option>
                                                        <option value="Liberian">Liberian</option>
                                                        <option value="Libyan">Libyan</option>
                                                        <option value="Liechtensteiner">Liechtensteiner</option>
                                                        <option value="Lithuanian">Lithuanian</option>
                                                        <option value="Luxembourger">Luxembourger</option>
                                                        <option value="Macedonian">Macedonian</option>
                                                        <option value="Malagasy">Malagasy</option>
                                                        <option value="Malawian">Malawian</option>
                                                        <option value="Malaysian">Malaysian</option>
                                                        <option value="Maldivan">Maldivan</option>
                                                        <option value="Malian">Malian</option>
                                                        <option value="Maltese">Maltese</option>
                                                        <option value="Marshallese">Marshallese</option>
                                                        <option value="Mauritanian">Mauritanian</option>
                                                        <option value="Mauritian">Mauritian</option>
                                                        <option value="Mexican">Mexican</option>
                                                        <option value="Micronesian">Micronesian</option>
                                                        <option value="Moldovan">Moldovan</option>
                                                        <option value="Monacan">Monacan</option>
                                                        <option value="Mongolian">Mongolian</option>
                                                        <option value="Moroccan">Moroccan</option>
                                                        <option value="Mosotho">Mosotho</option>
                                                        <option value="Motswana">Motswana</option>
                                                        <option value="Mozambican">Mozambican</option>
                                                        <option value="Namibian">Namibian</option>
                                                        <option value="Nauruan">Nauruan</option>
                                                        <option value="Nepalese">Nepalese</option>
                                                        <option value="New zealander">New Zealander</option>
                                                        <option value="Ni-vanuatu">Ni-Vanuatu</option>
                                                        <option value="Nicaraguan">Nicaraguan</option>
                                                        <option value="Nigerien">Nigerien</option>
                                                        <option value="North korean">North Korean</option>
                                                        <option value="Northern irish">Northern Irish</option>
                                                        <option value="Norwegian">Norwegian</option>
                                                        <option value="Omani">Omani</option>
                                                        <option value="Pakistani">Pakistani</option>
                                                        <option value="Palauan">Palauan</option>
                                                        <option value="Panamanian">Panamanian</option>
                                                        <option value="Papua new guinean">Papua New Guinean</option>
                                                        <option value="Paraguayan">Paraguayan</option>
                                                        <option value="Peruvian">Peruvian</option>
                                                        <option value="Polish">Polish</option>
                                                        <option value="Portuguese">Portuguese</option>
                                                        <option value="Qatari">Qatari</option>
                                                        <option value="Romanian">Romanian</option>
                                                        <option value="Russian">Russian</option>
                                                        <option value="Rwandan">Rwandan</option>
                                                        <option value="Saint lucian">Saint Lucian</option>
                                                        <option value="Salvadoran">Salvadoran</option>
                                                        <option value="Samoan">Samoan</option>
                                                        <option value="San marinese">San Marinese</option>
                                                        <option value="Sao tomean">Sao Tomean</option>
                                                        <option value="Saudi">Saudi</option>
                                                        <option value="Scottish">Scottish</option>
                                                        <option value="Senegalese">Senegalese</option>
                                                        <option value="Serbian">Serbian</option>
                                                        <option value="Seychellois">Seychellois</option>
                                                        <option value="Sierra leonean">Sierra Leonean</option>
                                                        <option value="Slovakian">Slovakian</option>
                                                        <option value="Slovenian">Slovenian</option>
                                                        <option value="Solomon islander">Solomon Islander</option>
                                                        <option value="Somali">Somali</option>
                                                        <option value="South african">South African</option>
                                                        <option value="South korean">South Korean</option>
                                                        <option value="Spanish">Spanish</option>
                                                        <option value="Sri lankan">Sri Lankan</option>
                                                        <option value="Sudanese">Sudanese</option>
                                                        <option value="Surinamer">Surinamer</option>
                                                        <option value="Swazi">Swazi</option>
                                                        <option value="Swedish">Swedish</option>
                                                        <option value="Swiss">Swiss</option>
                                                        <option value="Syrian">Syrian</option>
                                                        <option value="Taiwanese">Taiwanese</option>
                                                        <option value="Tajik">Tajik</option>
                                                        <option value="Tanzanian">Tanzanian</option>
                                                        <option value="Thai">Thai</option>
                                                        <option value="Togolese">Togolese</option>
                                                        <option value="Tongan">Tongan</option>
                                                        <option value="Trinidadian or tobagonian">Trinidadian or Tobagonian</option>
                                                        <option value="Tunisian">Tunisian</option>
                                                        <option value="Turkish">Turkish</option>
                                                        <option value="Tuvaluan">Tuvaluan</option>
                                                        <option value="Ugandan">Ugandan</option>
                                                        <option value="Ukrainian">Ukrainian</option>
                                                        <option value="Uruguayan">Uruguayan</option>
                                                        <option value="Uzbekistani">Uzbekistani</option>
                                                        <option value="Venezuelan">Venezuelan</option>
                                                        <option value="Vietnamese">Vietnamese</option>
                                                        <option value="Welsh">Welsh</option>
                                                        <option value="Yemenite">Yemenite</option>
                                                        <option value="Zambian">Zambian</option>
                                                        <option value="Zimbabwean">Zimbabwean</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Phone number:</td>
                                                <td><input type ="number" name ="phone" value ="<%out.print(phone);%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Highest Qualification:</td>
                                                <td>
                                                    <select name="highest_qualification" >
                                                        <option selected value="<%out.print(highest_qualification);%>"> <%out.print(highest_qualification);%></option>
                                                        <option value="primary">Primary School</option>
                                                        <option value="secondary" >Secondary School</option>
                                                        <option value="post-secondary" >Post-secondary (non-tertiary) School</option>
                                                        <option value="polytechnic" >Polytechnic Diploma</option>
                                                        <option value="ite" >ITE</option>
                                                        <option value="bachelor" >Bachelor Degree</option>
                                                        <option value="postgraduate" >Postgraduate Diploma</option>
                                                        <option value="Masters/Doctorate" >Masters/Doctorate</option>
                                                    </select>                                              
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>School:</td>
                                                <td><input type ="text" name ="school" value =" <%out.print(school);%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Field of Study:</td>
                                                <td>
                                                    <select name="fos">
                                                        <option selected value="<%out.print(userFOS);%>"><%out.print(userFOS);%></option>
                                                        <%
                                                            ArrayList<String> allFieldOfStudy = FieldOfStudyDAO.getFieldOfStudies();

                                                            if (!allFieldOfStudy.isEmpty()) {
                                                                for (int i = 0; i < allFieldOfStudy.size(); i++) {
                                                                    String fos = allFieldOfStudy.get(i);

                                                        %>
                                                        <option value="<%out.print(fos);%>"><%out.print(fos);%></option>
                                                        <%    }
                                                            }

                                                        %>
                                                    </select> 

                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" align="center"><input type="file" name="uploadedfile" id="file-1" class="inputfile inputfile-1" accept=".pdf" style="display:none"/>

                                                    <label for="file-1"><svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> 
                                                        <span>Upload Resume (.pdf only)</span>
                                                    </label> 
                                                </td> 
                                            </tr>                                          
                                        </tbody>
                                    </table>

                                    <input type="hidden" name="userEmail" value="<%out.print(email);%>">
                                    <input type="hidden" name="cont" value="<%out.print(contient);%>">
                                    <input type="submit" value="Submit" class="full_width">
                                </div>
                            </div>

                        </form>
                    </div>

                </div>


            </div>


            <%

                }

            %>



            <%            } else {
            %>
            <h3 class="align-center">Log in/Sign up to register</h3>
            <div align="center"><a href = "login.jsp?comefrom=internshipDetails&cont=<%out.print(contient);%>" class = "button">Log in/sign up to apply</a></div>



            <%
                }

            %>

        </section>




        <!-- Footer -->
        <jsp:include page="footer.jsp" />


        <script src="js/custom-file-input.js"></script>
    </body>
</html>