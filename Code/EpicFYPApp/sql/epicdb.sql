-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 23, 2018 at 04:15 AM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `epicdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `adminName` varchar(15) NOT NULL,
  `adminPassword` blob NOT NULL,
  `adminSalt` varchar(6) NOT NULL,
  `adminLevel` varchar(30) NOT NULL,
  PRIMARY KEY (`adminName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminName`, `adminPassword`,`adminSalt`, `adminLevel`) VALUES
('admin1', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'superadmin'),
('admin2', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'admin'),
('admin3', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `companyID` int(11) NOT NULL AUTO_INCREMENT,
  `companyEmail` varchar(50) NOT NULL,
  `companyName` varchar(100) NOT NULL,
  `companyContact` int(15) NOT NULL,
  `companyContinent` varchar(100) NOT NULL,
  `companyCountry` varchar(100) NOT NULL,
  `companyState` varchar(100) NOT NULL,
  `companyDescription` varchar(500) NOT NULL,
  `companyPassword` blob NOT NULL,
  `companySalt` varchar(6) NOT NULL,
  PRIMARY KEY (`companyID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`companyID`, `companyEmail`, `companyName`, `companyContact`, `companyContinent`, `companyCountry`, `companyState`, `companyDescription`, `companyPassword`,`companySalt`) VALUES
(1, 'universtar.bt21sg@gmail.com', 'Universtar BT21 Pte Ltd', 63483001, 'Asia', 'South Korea', 'Seoul', 'Universtar Pte Ltd is one of the top recruitment firm in  the region. It provides youths with the opportunity to step out of their comfort zone and experience the working life in another country.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564'),
(2, 'recruitments@daijob.com.jp', 'Daijob Globals', 62211734, 'Asia', 'Japan', 'Tokyo', 'Daijob Globals Japan is one of the largest bilingual recruitment companies in Tokyo, that recruit mainly in IT, Sales & Marketing and Back Office.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564'),
(3, 'find@randstad.com.cn', 'Randstad Canada', 61122335, 'America', 'Canada', 'Toronto', 'Here at Randstad Canada, we believes that the greatest job opportunities lie all around the world. The opportunities out there are endless.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564'),
(4, 'ask@goimr.com', 'International Market Recruiters', 67531443, 'America', 'USA', 'Newark', 'International Market Recruiters is a financial services executive search firm that is home to some of the finest recruiters in the United States.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564'),
(5, 'wideRecruitment@ aliawide.com.au', 'Australia Wide Engineering Recruitment', 92348343, 'Australia', 'Gold Coast', 'Queensland', 'As one of Australia\'s leading technical recruitment firms, we are increasingly being approached by foreign companies to source engineers and other technical staff for international opportunities. We are an attractive source of Australian engineers for international companies because of our long established engineering contacts and databases. Demand for our services has been particularly strong from the Middle East and Asia.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564'),
(6, 'applications@zip.com.ny', 'Zip Recruiter Pte Ltd', 62213458, 'Europe', 'United Kingdom', 'York', 'Being the best in the region, Zip Recruiter believes in delivering a promise to youths that the world is filled with endless internship opportunities.', X'CEFCDD428BC709FB3A732C49B03E5148', '774564');

-- --------------------------------------------------------

--
-- Table structure for table `countryinternship`
--

DROP TABLE IF EXISTS `countryinternship`;
CREATE TABLE IF NOT EXISTS `countryinternship` (
  `countryName` varchar(100) NOT NULL,
  `countryContinent` varchar(100) NOT NULL,
  PRIMARY KEY (`countryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countryinternship`
--

INSERT INTO `countryinternship` (`countryName`, `countryContinent`) VALUES
('Canada', 'America'),
('Gold Coast', 'Australia'),
('Hong Kong', 'Asia'),
('Japan', 'Asia'),
('Newark', 'America'),
('South Korea', 'Asia'),
('Thailand', 'Asia'),
('United Kingdom', 'Europe');

-- --------------------------------------------------------

--
-- Table structure for table `countrytrip`
--

DROP TABLE IF EXISTS `countrytrip`;
CREATE TABLE IF NOT EXISTS `countrytrip` (
  `countryTripName` varchar(100) NOT NULL,
  PRIMARY KEY (`countryTripName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countrytrip`
--

INSERT INTO `countrytrip` (`countryTripName`) VALUES
('China'),
('India'),
('Myanmar'),
('Singapore'),
('South Korea'),
('Australia'),
('Indonesia'),
('Malaysia'),
('Greece');

-- --------------------------------------------------------

--
-- Table structure for table `fieldofstudy`
--

DROP TABLE IF EXISTS `fieldofstudy`;
CREATE TABLE IF NOT EXISTS `fieldofstudy` (
  `fieldOfStudyName` varchar(40) NOT NULL,
  PRIMARY KEY (`fieldOfStudyName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fieldofstudy`
--

INSERT INTO `fieldofstudy` (`fieldOfStudyName`) VALUES
('Accountancy'),
('Arts & Social Sciences'),
('Business'),
('Computing'),
('Dentistry'),
('Design & Environment'),
('Engineering'),
('History'),
('Hospitality & Tourism'),
('Law'),
('Medicine'),
('Music'),
('Others'),
('Science');

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

DROP TABLE IF EXISTS `interest`;
CREATE TABLE IF NOT EXISTS `interest` (
  `interestName` varchar(40) NOT NULL,
  PRIMARY KEY (`interestName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `interest`
--

INSERT INTO `interest` (`interestName`) VALUES
('Academic & Business'),
('Nature & Culture'),
('Service & Social Innovation');

-- --------------------------------------------------------

--
-- Table structure for table `internship`
--

DROP TABLE IF EXISTS `internship`;
CREATE TABLE IF NOT EXISTS `internship` (
  `internshipID` int(11) NOT NULL AUTO_INCREMENT,
  `internshipName` varchar(100) NOT NULL,
  `internshipFieldOfStudy` varchar(500) NOT NULL,
  `internshipDescription` varchar(1000) NOT NULL,
  `internshipStart` date NOT NULL,
  `internshipEnd` date NOT NULL,
  `internshipPay` decimal(13,2) NOT NULL,
  `internshipSupervisor` varchar(100) NOT NULL DEFAULT '',
  `internshipSupervisorEmail` varchar(100) NOT NULL DEFAULT '',
  `internshipVacancy` int(100) NOT NULL DEFAULT '0',
  `internshipPartnerID` int(11) NOT NULL DEFAULT '1',
  `internshipDatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`internshipID`),
  KEY `internshippartnerid` (`internshipPartnerID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `internship`
--

INSERT INTO `internship` (`internshipID`, `internshipName`, `internshipFieldOfStudy`, `internshipDescription`, `internshipStart`, `internshipEnd`, `internshipPay`, `internshipSupervisor`, `internshipSupervisorEmail`, `internshipVacancy`, `internshipPartnerID`, `internshipDatetime`) VALUES
(1, 'Data Analytics Intern', 'Business, Accountancy', 'This intern position is within the Business Intelligence Department and will support the team with data analysis, model development, data visualizations and decision support for various departments.', '2018-11-11', '2019-11-11', '1000.00', 'Tommy Lau', 'tommy.lau@xwy.com', 3, 1, '2018-08-08 12:40:30'),
(2, 'Business and Science Intern', 'Business, Science', 'This intern position is within the Business Science Department. Interns will have to conduct science experiments with a business angle, and acheive suitable actionable results for the company to take.', '2018-11-11', '2019-11-11', '1000.00', 'Tommy Lau', 'tommy.lau@xwy.com', 4, 1, '2018-08-08 12:40:30'),
(3, 'Music Assistant', 'Music', 'Intern is required to have strong foundational knowledge in music. At least of Grade 5. Strong sight-reading skills is required.', '2018-11-11', '2019-11-11', '1000.00', 'Tommy Lau', 'tommy.lau@xwy.com', 2, 1, '2018-08-08 12:40:30'),
(4, 'Tour Guide Intern', 'History, Hospitality & Tourism', 'Interns are expected to have strong command of knowledge with regards to important historical sites. Interns should be able to vocalise and impart knowledge effectively and clearly.', '2018-11-11', '2019-11-11', '1000.00', 'Tommy Lau', 'tommy.lau@xwy.com', 2, 1, '2018-08-08 12:40:30'),
(5, 'Robotics Discovery Intern', 'Engineering', 'Intern is expected to be self-directed and self-motivated. Intern is expected to explore the different uses of robotics, and  how it can be applied into the daily life.', '2018-11-11', '2019-11-11', '1000.00', 'Bob Ma', 'bob.ma@xwy.com', 1, 2, '2018-08-08 12:40:30'),
(6, 'Archives Intern', 'Law', 'Intern will be in charge of managing the Law archives. These includes retrieving appropriate texts, and opportunities to closely collaborate with full time lawyers building their cases.', '2018-11-11', '2019-11-11', '1000.00', 'Bob Ma', 'tommy.ma@xwy.com', 1, 2, '2018-08-08 12:40:30'),
(7, 'Nurse Intern', 'Medicine', 'Possess strong emotional strength. It is preferrable if intern is able to speak in dialect.', '2018-11-11', '2019-11-11', '1000.00', 'Mary Tan', 'mary.tan@xwy.com', 1, 3, '2018-08-08 12:40:30'),
(8, 'Machine Learning Intern', 'Computing', 'Intern is expected to be self-directed and motivated. Project requires strong foundational knowledge of Machine Learning concepts. ', '2018-11-11', '2019-11-11', '1000.00', 'Mary Tan', 'mary.tan@xwy.com', 2, 3, '2018-08-08 12:40:30'),
(9, 'English Researcher Intern', 'History', 'Interns will be researching into the history of words, and curating how the language has evolved overtime. If intern has the language capabilities, he/she might have the opportunity to collaborate in a research paper.', '2018-11-11', '2019-11-11', '1000.00', 'Sally Pi', 'sally.pi@xwy.com', 3, 4, '2018-08-08 12:40:30');

-- --------------------------------------------------------

--
-- Table structure for table `internshipassigned`
--

DROP TABLE IF EXISTS `internshipassigned`;
CREATE TABLE IF NOT EXISTS `internshipassigned` (
  `internshipAssignedID` int(11) NOT NULL,
  `internshipID` int(11) NOT NULL,
  `internshipStudentID` int(11) NOT NULL,
  PRIMARY KEY (`internshipAssignedID`),
  KEY `internshipID` (`internshipID`),
  KEY `internshipStudentID` (`internshipStudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `internshipassigned`
--

INSERT INTO `internshipassigned` (`internshipAssignedID`, `internshipID`, `internshipStudentID`) VALUES
(1, 5, 11);

-- --------------------------------------------------------

--
-- Table structure for table `internshipstudent`
--

DROP TABLE IF EXISTS `internshipstudent`;
CREATE TABLE IF NOT EXISTS `internshipstudent` (
  `internshipStudentID` int(11) NOT NULL AUTO_INCREMENT,
  `internshipUserEmail` varchar(50) NOT NULL,
  `internshipStudentContinent` varchar(15) NOT NULL,
  `internshipStudentStatus` varchar(90) NOT NULL,
  `internshipStudentDatetime` datetime NOT NULL,
  `internshipStudentStatusAction` int(1) NOT NULL,
  PRIMARY KEY (`internshipStudentID`),
  KEY `internshipUserEmail` (`internshipUserEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `internshipstudent`
--

INSERT INTO `internshipstudent` (`internshipStudentID`, `internshipUserEmail`, `internshipStudentContinent`, `internshipStudentStatus`, `internshipStudentDatetime`, `internshipStudentStatusAction`) VALUES
(1, 'mediani.2015@sis.smu.edu.sg', 'Asia', 'User submitted application - Admin to review application', '2018-04-05 12:32:21', 1),
(2, 'mediani.2015@sis.smu.edu.sg', 'Asia', 'Application fails application review - No further actions', '2018-10-02 12:32:21', 0),
(3, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'User submitted application - Admin to review application', '2018-11-22 14:46:00', 1),
(4, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Admin approves application - Send email with internship details for interest confirmation', '2018-11-22 14:50:00', 1),
(5, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Sent interest email - Waiting for user reply', '2018-11-22 15:13:00', 2),
(6, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'User accepts - Send email to schedule interview', '2018-11-22 15:15:00', 1),
(7, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Sent interview schedule email - Waiting for user reply', '2018-11-22 15:20:00', 2),
(8, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Interview scheduled - Pending interview', '2018-11-22 15:25:00', 2),
(9, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Interview completed - Review interview', '2018-11-22 15:30:00', 1),
(10, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Internship offered - Pending user internship acceptance', '2018-11-22 15:35:00', 2),
(11, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'User accepted internship offer - No further action', '2018-11-22 15:40:00', 3),
(12, 'mediani.2015@sis.smu.edu.sg', 'Europe', 'Internship Cancelled - No further action', '2018-11-22 16:00:00', 4),
(13, 'rachael.low.2015@sis.smu.edu.sg', 'America', 'User submitted application - Admin to review application', '2018-11-23 11:11:00', 1),
(14, 'rachael.low.2015@sis.smu.edu.sg', 'America', 'Application fails application review - No further action', '2018-11-23 11:20:00', 0),
(15, 'suhailahs.2015@smu.edu.sg', 'Europe', 'User submitted application - Admin to review application', '2018-11-23 11:20:00', 1),
(16, 'suhailahs.2015@smu.edu.sg', 'Europe', 'Admin approves application - Send email with internship details for interest confirmation', '2018-11-23 11:30:00', 1),
(17, 'suhailahs.2015@smu.edu.sg', 'Europe', 'Sent interest email - Waiting for user reply', '2018-11-23 11:40:00', 2),
(18, 'suhailahs.2015@smu.edu.sg', 'Europe', 'Application withdrawn - No interview scheduled', '2018-11-23 11:50:00', 0),
(19, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'User submitted application - Admin to review application', '2018-11-23 13:10:00', 1),
(20, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'Admin approves application - Send email with internship details for interest confirmation', '2018-11-23 13:20:00', 1),
(21, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'Sent interest email - Waiting for user reply', '2018-11-23 13:30:00', 2),
(22, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'User accepts - Send email to schedule interview', '2018-11-23 13:40:00', 1),
(23, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'Sent interview schedule email - Waiting for user reply', '2018-11-23 13:50:00', 2),
(24, 'yijing.oon.2015@smu.edu.sg', 'Australia', 'User withdraws from scheduled interview - No further action', '2018-11-23 14:00:00', 0),
(25, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'User submitted application - Admin to review application', '2018-11-21 13:14:00', 1),
(26, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Admin approves application - Send email with internship details for interest confirmation', '2018-11-21 14:20:00', 1),
(27, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Sent interest email - Waiting for user reply', '2018-11-21 15:03:00', 2),
(28, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'User accepts - Send email to schedule interview', '2018-11-21 15:33:00', 1),
(29, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Sent interview schedule email - Waiting for user reply', '2018-11-22 10:12:00', 2),
(30, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Interview scheduled - Pending interview', '2018-11-22 13:13:00', 2),
(31, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Interview completed - Review interview', '2018-11-22 13:50:00', 1),
(32, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'Internship offered - Pending user internship acceptance', '2018-11-22 14:15:00', 2),
(33, 'rachael.low.2015@sis.smu.edu.sg', 'Europe', 'User rejects internship offer- No further action', '2018-11-22 18:19:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `tripStudentID` int(11) NOT NULL,
  `paymentMode` varchar(15) NOT NULL,
  `paymentTransaction` varchar(100) NOT NULL,
  `paymentAmount` double NOT NULL,
  PRIMARY KEY (`paymentID`),
  KEY `tripStudentID` (`tripStudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`paymentID`, `tripStudentID`, `paymentMode`, `paymentTransaction`, `paymentAmount`) VALUES
(1, 3, 'PayNow', 'Sh-123-123', 400);

-- --------------------------------------------------------

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
CREATE TABLE IF NOT EXISTS `trip` (
  `tripID` int(11) NOT NULL AUTO_INCREMENT,
  `tripTitle` varchar(100) NOT NULL,
  `tripPrice` double NOT NULL DEFAULT '0',
  `tripItinerary` mediumblob,
  `tripDescription` varchar(1000) NOT NULL,
  `tripCountry` varchar(100) NOT NULL,
  `tripState` varchar(100) NOT NULL,
  `tripStart` date DEFAULT NULL,
  `tripEnd` date DEFAULT NULL,
  `tripDuration` int(11) NOT NULL DEFAULT '0',
  `tripActivation` int(3) NOT NULL DEFAULT '0',
  `tripInterest` varchar(500) NOT NULL,
  `tripTotalSignUp` int(11) DEFAULT '0',
  `tripPicture` varchar(100) NOT NULL,
  PRIMARY KEY (`tripID`),
  KEY `tripCountry` (`tripCountry`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trip`
--

INSERT INTO `trip` (`tripID`, `tripTitle`, `tripPrice`, `tripItinerary`, `tripDescription`, `tripCountry`, `tripState`, `tripStart`, `tripEnd`, `tripDuration`, `tripActivation`, `tripInterest`, `tripTotalSignUp`, `tripPicture`) VALUES
(1, 'EPIC Journey to South Korea - Seoul', 2500, NULL, 'The top 3 highlights of the trip is being able to witness social innovations throughout the city, taking part in community service and being part with Nature & Culture.', 'South Korea', 'Seoul', '2018-12-12', '2018-12-18', 6, 3, 'Nature and Culture, Academic and Business', 1, ''),
(2, 'EPIC Journey to Australia - Sydney', 2200, NULL, 'The main highlights of the trip is to have a deeper understanding of the heritage & culture of Australia, You will also have an opportunity to partake in the community services organized by a local voluntary group to reach out to the people who are in needs. Additionally, you will also be a chance to join a Design Thinking Workshop. ', 'Australia', 'Sydney', '2018-12-24', '2018-09-29', 5, 4, 'Nature and Culture', 0, ''),
(3, 'EPIC Journey to Myanmar - Yongon', 1800, NULL, 'The top 3 highlights of the trip is being able to witness social innovations throughout the city, taking part in community service and being part with Nature & Culture.', 'Myanmar', 'Yangon', '2018-11-27', '2018-12-04', 7, 4, 'Nature and Culture, Academic and Business', 10, ''),
(4, 'EPIC Journey to Indonesia - Jakarta', 2000, NULL, 'The main highlights of the trip is to have a deeper understanding of the heritage & culture of Indonesia, You will also have an opportunity to partake in the nature exploration and admire the beauty that nature provides.', 'Indonesia', 'Jakarta', '2018-12-03', '2018-12-08', 5, 6, 'Nature and Culture', 10, ''),
(5, 'EPIC Journey to Greece - Athens', 2300, NULL, 'Highlights of the trip would include nature exploration around the caves of Athens and also to understand the problems revolving around sustainable tourism. Heritage & Culture of Athens will also be shared with the students.', 'Greece', 'Athens', '2018-11-30', '2018-12-05', 5, 5, 'Nature and Culture', 15, ''),
(6, 'EPIC Journey to India - Mumbai', 2800, NULL, 'Highlights of the trip would include nature exploration around the mountains and also to understand the problems revolving around sustainable tourism. Heritage & Culture of Inle will also be shared with the students.', 'India', 'Mumbai', '2018-12-27', '2018-12-31', 4, 5, 'Nature and Culture', 10, '');

-- --------------------------------------------------------

--
-- Table structure for table `tripstudent`
--

DROP TABLE IF EXISTS `tripstudent`;
CREATE TABLE IF NOT EXISTS `tripstudent` (
  `tripStudentID` int(11) NOT NULL AUTO_INCREMENT,
  `tripUserEmail` varchar(50) NOT NULL,
  `tripID` int(11) NOT NULL,
  `tripStudentStatus` varchar(25) DEFAULT '',
  `tripStudentTimestamp` datetime NOT NULL,
  PRIMARY KEY (`tripStudentID`),
  KEY `tripUserEmail` (`tripUserEmail`),
  KEY `tripID` (`tripID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tripstudent`
--

INSERT INTO `tripstudent` (`tripStudentID`, `tripUserEmail`, `tripID`, `tripStudentStatus`, `tripStudentTimestamp`) VALUES
(1, 'mediani.2015@sis.smu.edu.sg', 1, 'Applied interest', '2018-11-19 02:21:59'),
(2, 'mediani.2015@sis.smu.edu.sg', 1, 'Pending Deposit', '2018-11-19 02:22:01'),
(3, 'mediani.2015@sis.smu.edu.sg', 1, 'Deposit Made', '2018-11-19 02:22:07'),
(4, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Applied interest', '2018-11-23 08:24:00'),
(5, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Pending Deposit', '2018-11-23 08:26:00'),
(6, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Deposit Made', '2018-11-23 08:31:00'),
(7, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Trip Activated', '2018-11-23 08:35:00'),
(8, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Pending Full Payment', '2018-11-26 08:40:00'),
(9, 'rachael.low.2015@sis.smu.edu.sg', 4, 'Full Payment Deposit', '2018-11-23 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userEmail` varchar(50) NOT NULL,
  `userFirstName` varchar(50) NOT NULL,
  `userLastName` varchar(50) NOT NULL,
  `userPhone` int(15) NOT NULL,
  `userGender` varchar(1) NOT NULL,
  `userCitizenship` varchar(50) NOT NULL,
  `userDOB` year(4) NOT NULL,
  `userInterest` varchar(1000) DEFAULT NULL,
  `userPassword` blob NOT NULL,
  `userSalt` varchar(6) NOT NULL,
  `userOccupation` varchar(40) NOT NULL,
  `userResume` mediumblob,
  `userIsEmailConfirm` varchar(10) NOT NULL DEFAULT 'pending',
  `userHighestEducation` varchar(40) NOT NULL,
  `userFieldOfStudy` varchar(40) DEFAULT NULL,
  `userDescription` varchar(500) DEFAULT NULL,
  `userSchool` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userEmail`, `userFirstName`, `userLastName`, `userPhone`, `userGender`, `userCitizenship`, `userDOB`, `userInterest`, `userPassword`, `userSalt`, `userOccupation`, `userResume`, `userIsEmailConfirm`, `userHighestEducation`, `userFieldOfStudy`, `userDescription`, `userSchool`) VALUES
('mediani.2015@sis.smu.edu.sg', 'Mediani', 'Law', 83036983, 'F', 'Singapore PR', 1996, 'Service & Social Innovation, Academic & Business', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'Student', NULL, 'pending', 'Bachelor Degree', 'Law', 'I love the exercise! It is my favourite thing. It makes me happy and beautiful.', 'SMU'),
('rachael.low.2015@sis.smu.edu.sg', 'Rachael', 'Low', 91234567, 'M', 'Algerian', 1995, 'Academic & Business', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'Student', NULL, 'confirmed', 'ITE', 'History', 'Weeee. The life of greatness and happiness is amazinggggg.', 'NTU'),
('suhailahs.2015@smu.edu.sg', 'Nurul', 'Suhailah', 81290722, 'F', 'Singaporean', 1993, 'Academic & Business, Nature & Culture', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'Student', NULL, 'pending', 'bachelor', 'Business', 'I love travelling.', 'Singapore Management University'),
('xiuwen.yeo@gmail.com', 'Xiu Wen', 'Yeo', 98769876, 'F', 'Singaporean', 1994, 'Nature & Culture', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'Student', NULL, 'pending', 'Postgraduate Diploma', 'Computing', 'I am really into helping others. When others feel happy, I feel happy too.', 'SMU'),
('yijing.oon.2015@smu.edu.sg', 'Yi Jing', 'Oon', 98766789, 'F', 'Singapore PR', 1993, 'Nature & Culture, Service & Social Innovation', X'CEFCDD428BC709FB3A732C49B03E5148', '774564', 'Student', NULL, 'confirmed', 'Masters/Doctorate', 'Computing', 'Greatness is in the eye of the beholder. I believe with great power comes great responsibility.', 'NTU');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `internship`
--
ALTER TABLE `internship`
  ADD CONSTRAINT `internshippartner_fk` FOREIGN KEY (`internshipPartnerID`) REFERENCES `company` (`companyID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `internshipassigned`
--
ALTER TABLE `internshipassigned`
  ADD CONSTRAINT `internshipassigned_fk1` FOREIGN KEY (`internshipID`) REFERENCES `internship` (`internshipID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `internshipassigned_fk2` FOREIGN KEY (`internshipStudentID`) REFERENCES `internshipstudent` (`internshipStudentID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `internshipstudent`
--
ALTER TABLE `internshipstudent`
  ADD CONSTRAINT `internshipstudent_fk1` FOREIGN KEY (`internshipUserEmail`) REFERENCES `user` (`userEmail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_fk1` FOREIGN KEY (`tripStudentID`) REFERENCES `tripstudent` (`tripStudentID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trip`
--
ALTER TABLE `trip`
  ADD CONSTRAINT `tripcountry_fk1` FOREIGN KEY (`tripCountry`) REFERENCES `countrytrip` (`countryTripName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tripstudent`
--
ALTER TABLE `tripstudent`
  ADD CONSTRAINT `tripstudent_fk1` FOREIGN KEY (`tripUserEmail`) REFERENCES `user` (`userEmail`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tripstudent_fk2` FOREIGN KEY (`tripID`) REFERENCES `trip` (`tripID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
