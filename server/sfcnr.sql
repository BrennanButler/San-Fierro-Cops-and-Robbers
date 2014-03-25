-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2013 at 10:59 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sfcnr`
--

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE IF NOT EXISTS `atm` (
  `ATMID` int(20) NOT NULL AUTO_INCREMENT,
  `robbery` int(20) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `location` varchar(24) NOT NULL,
  PRIMARY KEY (`ATMID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `username` varchar(24) NOT NULL,
  `time` varchar(100) NOT NULL,
  `reason` text NOT NULL,
  `admin` varchar(24) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `issued` varchar(50) NOT NULL,
  `active` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bizadvertisements`
--

CREATE TABLE IF NOT EXISTS `bizadvertisements` (
  `BizID` int(20) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE IF NOT EXISTS `business` (
  `owner` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business_objects`
--

CREATE TABLE IF NOT EXISTS `business_objects` (
  `bizid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE IF NOT EXISTS `house` (
  `id` int(14) NOT NULL AUTO_INCREMENT,
  `owner` varchar(24) NOT NULL,
  `owned` tinyint(1) NOT NULL,
  `interiorname` varchar(100) NOT NULL,
  `pass` varchar(400) NOT NULL,
  `Xpos` double NOT NULL,
  `Ypos` double NOT NULL,
  `Zpos` double NOT NULL,
  `price` int(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`id`, `owner`, `owned`, `interiorname`, `pass`, `Xpos`, `Ypos`, `Zpos`, `price`) VALUES
(19, 'thefatshizms', 1, 'Sex shop', '', -2029.04248, 1276.762817, 7.190702, 0),
(20, 'BoSS', 1, 'Strip club', '', -2073.517578, 265.922607, 35.377025, 0);

-- --------------------------------------------------------

--
-- Table structure for table `house_objects`
--

CREATE TABLE IF NOT EXISTS `house_objects` (
  `modelid` int(20) NOT NULL,
  `X_pos` float NOT NULL,
  `Y_pos` float NOT NULL,
  `Z_pos` float NOT NULL,
  `RX_pos` float NOT NULL,
  `RY_pos` float NOT NULL,
  `RZ_pos` float NOT NULL,
  `houseid` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kicks`
--

CREATE TABLE IF NOT EXISTS `kicks` (
  `Kicked` varchar(24) NOT NULL,
  `Kicker` varchar(24) NOT NULL,
  `Reason` varchar(120) NOT NULL,
  `Date` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kicks`
--

INSERT INTO `kicks` (`Kicked`, `Kicker`, `Reason`, `Date`) VALUES
('thefatshizms', 'thefatshizms', 'fgt', '04/05/2013'),
('thefatshizms', 'BoSSPEED', 'Maximum ammount of warnings', '08/05/2013'),
('thefatshizms', 'BoSSPEED', 'Maximum ammount of warnings', '08/05/2013'),
('Johan', 'thefatshizms', 'reconnect to get rid of lag', '11/07/2013'),
('Johan', 'Johan', 'relog', '29/07/2013'),
('Stel_Power', 'thefatshizms', 'go away', '05/08/2013'),
('Riki_Ball', 'BoSS', 'DM', '16/08/2013');

-- --------------------------------------------------------

--
-- Table structure for table `pilot`
--

CREATE TABLE IF NOT EXISTS `pilot` (
  `desc` text NOT NULL,
  `Fx` double NOT NULL,
  `Fy` double NOT NULL,
  `Fz` double NOT NULL,
  `Tx` double NOT NULL,
  `Ty` double NOT NULL,
  `Tz` double NOT NULL,
  `payment` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pm`
--

CREATE TABLE IF NOT EXISTS `pm` (
  `pm_from` varchar(24) NOT NULL,
  `pm_to` varchar(24) NOT NULL,
  `message` text NOT NULL,
  `date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pm`
--

INSERT INTO `pm` (`pm_from`, `pm_to`, `message`, `date`) VALUES
('thefatshizms', 'thefatshizms', 'hai man', '1'),
('thefatshizms', 'thefatshizms', 'i really like you', '1'),
('thefatshizms', 'thefatshizms', 'really really like you..', '1'),
('thefatshizms', 'thefatshizms', 'lets have sex!', '1'),
('thefatshizms', 'thefatshizms', '*makes sex noises', '1'),
('thefatshizms', 'thefatshizms', 'climax*', '1'),
('thefatshizms', 'thefatshizms', 'omfg u nub', '01/04/2013'),
('jose2015', 'thefatshizms', 'ESTE ES TU SERVER', '01/04/2013'),
('thefatshizms', 'jose2015', 'what?', '01/04/2013'),
('jose2015', 'thefatshizms', 'NOT ESPANI', '01/04/2013'),
('thefatshizms', 'jose2015', 'i speak only english', '01/04/2013'),
('jose2015', 'thefatshizms', 'NOT SPEAK ENGLISH', '01/04/2013'),
('thefatshizms', 'jose2015', 'huh?', '01/04/2013'),
('jose2015', 'thefatshizms', 'This is your server', '01/04/2013'),
('thefatshizms', 'jose2015', 'no, why?', '01/04/2013'),
('jose2015', 'thefatshizms', 'I can be admin it helped you visited this server', '01/04/2013'),
('thefatshizms', 'jose2015', 'what?', '01/04/2013'),
('jose2015', 'thefatshizms', 'I can be admin', '01/04/2013'),
('thefatshizms', 'jose2015', 'i cant make you admin', '01/04/2013'),
('thefatshizms', 'jose2015', 'im not the owner', '01/04/2013'),
('jose2015', 'thefatshizms', 'asorry', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'he not in staff?', '01/04/2013'),
('thefatshizms', '[SFCNR]Hawk4man', 'i dont know him', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'how did he get ip?', '01/04/2013'),
('thefatshizms', '[SFCNR]Hawk4man', 'its on the sa-mp internet list', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'ok', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'but ', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', '-_-', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'dude im the guy with the minigun!', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'ok', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'im going now', '01/04/2013'),
('thefatshizms', '[SFCNR]Hawk4man', 'cya', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'be back tonight so we can do create bizz?', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'i mean taht shit', '01/04/2013'),
('thefatshizms', '[SFCNR]Hawk4man', 'ye', '01/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', 'gimme back admin', '11/04/2013'),
('[SFCNR]Hawk4man', 'thefatshizms', '4', '11/04/2013'),
('BoSSPEED', '[Sfcnr]Josip', 'i iz specing him xd', '17/04/2013'),
('[Sfcnr]Josip', 'BoSSPEED', 'test', '17/04/2013'),
('BoSSPEED', '[Sfcnr]Josip', ':D', '17/04/2013'),
('[Sfcnr]Josip', 'BoSSPEED', 'admin abuse.', '17/04/2013'),
('BoSSPEED', '[Sfcnr]Josip', 'LOL', '17/04/2013'),
('[Sfcnr]Josip', 'BoSSPEED', 'reported to glen', '17/04/2013'),
('[Sfcnr]Josip', 'BoSSPEED', 'u still in lsrcr?', '17/04/2013'),
('BoSSPEED', '[Sfcnr]Josip', 'u mean play?', '17/04/2013'),
('[Sfcnr]Josip', 'BoSSPEED', 'ye', '17/04/2013'),
('BoSSPEED', '[Sfcnr]Josip', 'ye', '17/04/2013'),
('BoSSPEED', 'thefatshizms', 'how to remove spike?', '17/04/2013'),
('thefatshizms', 'BoSSPEED', '/delspike', '17/04/2013'),
('BoSSPEED', 'thefatshizms', 'no work', '17/04/2013'),
('BoSSPEED', 'thefatshizms', ':c', '17/04/2013'),
('thefatshizms', 'BoSSPEED', 'hai', '08/05/2013'),
('BoSSPEED', 'thefatshizms', 'no', '08/05/2013'),
('BoSSPEED', 'thefatshizms', 'holy TP', '08/05/2013'),
('BoSSPEED', 'thefatshizms', 'UR IGNORED.', '08/05/2013'),
('BoSSPEED', 'thefatshizms', 'O K', '08/05/2013'),
('Johan', 'thefatshizms', 'I am not admin :P', '20/07/2013'),
('thefatshizms', 'meno', 'sup', '20/07/2013'),
('thefatshizms', 'Ivan', 'we had like 8 people in at once', '20/07/2013'),
('thefatshizms', '', 'what are you doing lol', '20/07/2013'),
('Ivan', 'thefatshizms', 'nicee', '20/07/2013'),
('thefatshizms', 'Ivan', 'as you can see', '20/07/2013'),
('thefatshizms', 'Ivan', 'need to re map swat', '20/07/2013'),
('Ivan', 'thefatshizms', 'nice base..', '20/07/2013'),
('thefatshizms', 'Ivan', 'xD', '20/07/2013'),
('thefatshizms', 'Ivan', 'les gets some wanted peoples', '20/07/2013'),
('Ivan', 'thefatshizms', 'yeaah.', '20/07/2013'),
('Ivan', 'thefatshizms', 'i am boreeed..', '20/07/2013'),
('thefatshizms', 'Ivan', 'lol', '20/07/2013'),
('Ivan', 'thefatshizms', 'gonna play some minecraft..', '20/07/2013'),
('Ivan', 'thefatshizms', 'your gay.', '20/07/2013'),
('thefatshizms', 'Ivan', 'says the one playing minecraft :)', '20/07/2013'),
('Ivan', 'thefatshizms', 'says the one who is playing samp, samp is for dumb people :P', '20/07/2013'),
('thefatshizms', 'Ivan', 'right.. when on minecraft you break bricks and place brick..', '20/07/2013'),
('Ivan', 'thefatshizms', 'going to forum..', '20/07/2013'),
('thefatshizms', 'Ivan', 'on samp all you have to do is code?', '20/07/2013'),
('thefatshizms', 'Ivan', 'very dumb :D', '20/07/2013'),
('thefatshizms', 'Ivan', 'okay', '20/07/2013'),
('Ivan', 'thefatshizms', 'and you can make beautiful creations, here you can drive and do nothing lol', '20/07/2013'),
('thefatshizms', 'Ivan', 'and code', '20/07/2013'),
('thefatshizms', 'Ivan', 'and make stuff with mapping', '20/07/2013'),
('thefatshizms', 'Ivan', 'and do stuff you could never do in minecraft', '20/07/2013'),
('thefatshizms', 'Ivan', 'if you wanted you could make minecraft in samp :)', '20/07/2013'),
('Ivan', 'thefatshizms', 'you are jelous ;)', '20/07/2013'),
('thefatshizms', 'Ivan', 'nope :)', '20/07/2013'),
('Johan', 'thefatshizms', 'givem  :d', '30/07/2013'),
('Johan', 'thefatshizms', '/rob', '06/08/2013'),
('Johan', 'thefatshizms', 'ops', '06/08/2013'),
('thefatshizms', 'Toni', 'I left in the vehicle bunny hop thing', '06/08/2013'),
('thefatshizms', 'Toni', 'press caps lock', '06/08/2013'),
('thefatshizms', 'Johan', 'OOPS', '06/08/2013'),
('thefatshizms', 'Johan', 'xd', '06/08/2013'),
('Toni', 'thefatshizms', 'awww summ', '06/08/2013'),
('Johan', 'thefatshizms', 'I can get my moderator status :P bored', '06/08/2013'),
('Johan', 'thefatshizms', 'Yay<3', '06/08/2013'),
('Johan', 'thefatshizms', '8 players', '06/08/2013'),
('BoSS', 'thefatshizms', '.', '07/08/2013'),
('BoSS', 'thefatshizms', 'specing', '07/08/2013'),
('thefatshizms', 'BoSS', 'feg', '07/08/2013'),
('BoSS', 'thefatshizms', 'how i stop spectate', '07/08/2013'),
('thefatshizms', 'BoSS', '/specoff', '07/08/2013'),
('BoSS', 'thefatshizms', 'ah', '07/08/2013'),
('thefatshizms', 'BoSS', 'blood bowl', '07/08/2013'),
('BoSS', 'thefatshizms', 'how i leave', '07/08/2013'),
('BoSS', 'thefatshizms', 'PC still overheating', '07/08/2013'),
('thefatshizms', 'BoSS', 'lel', '07/08/2013'),
('BoSS', 'thefatshizms', 'pick me in water', '07/08/2013'),
('BoSS', 'thefatshizms', 'yo go to the pplt', '07/08/2013'),
('BoSS', 'thefatshizms', 'i will clamp them', '07/08/2013'),
('BoSS', 'thefatshizms', 'trolol', '07/08/2013'),
('thefatshizms', 'BoSS', '/setwanted 1 4', '07/08/2013'),
('BoSS', 'thefatshizms', 'why i ths damn bike popeed', '07/08/2013'),
('thefatshizms', 'BoSS', 'admin abuse!', '07/08/2013'),
('thefatshizms', 'BoSS', '/demote 0 admin abuse', '07/08/2013'),
('BoSS', 'thefatshizms', 'NUUU', '07/08/2013'),
('thefatshizms', 'BoSS', 'stahp /tp to us den', '07/08/2013'),
('BoSS', 'thefatshizms', 'im not', '07/08/2013'),
('BoSS', 'thefatshizms', 'im just pro', '07/08/2013'),
('thefatshizms', 'BoSS', 'lol', '07/08/2013'),
('BoSS', 'thefatshizms', 'kill me', '07/08/2013'),
('Boki123', 'Tinca_Capone', 'are you a cop', '16/08/2013'),
('Tinca_Capone', 'Boki123', 'yup', '16/08/2013'),
('Boki123', 'Tinca_Capone', 'ok :(', '16/08/2013'),
('Boki123', 'Tinca_Capone', 'can you change ', '16/08/2013'),
('Tinca_Capone', 'Boki123', 'how? i just installed multiplayer', '16/08/2013'),
('Boki123', 'Tinca_Capone', 'go to commands ', '16/08/2013'),
('Tinca_Capone', 'Boki123', 'and', '16/08/2013'),
('thefatshizms', 'BoSS', 'is it?', '16/08/2013'),
('BoSS', 'thefatshizms', 'idk', '16/08/2013'),
('BoSS', 'thefatshizms', 'maybe', '16/08/2013'),
('BoSS', 'thefatshizms', 'thats croation', '16/08/2013'),
('BoSS', 'thefatshizms', 'i think', '16/08/2013'),
('BoSS', 'thefatshizms', 'let me go to them', '16/08/2013'),
('thefatshizms', 'BoSS', 'okay', '16/08/2013'),
('BoSS', 'thefatshizms', 'change the wheater', '16/08/2013'),
('thefatshizms', 'BoSS', 'never!', '16/08/2013'),
('thefatshizms', 'BoSS', 'it will change soon.. it changes every hour', '16/08/2013'),
('BoSS', 'thefatshizms', '1 is in army base', '16/08/2013'),
('BoSS', 'thefatshizms', 'clamped him LOL', '16/08/2013'),
('thefatshizms', 'BoSS', 'did you see? josip applied for army on lsrcr', '16/08/2013'),
('BoSS', 'thefatshizms', 'ye', '16/08/2013'),
('BoSS', 'thefatshizms', 'I dont think its him', '16/08/2013'),
('BoSS', 'thefatshizms', 'damn bugger', '16/08/2013'),
('BoSS', 'thefatshizms', 'clamped them', '16/08/2013'),
('BoSS', 'thefatshizms', 'give me admin', '16/08/2013'),
('BoSS', 'thefatshizms', 'NOOO I WANTED TO DO THAT', '16/08/2013'),
('BoSS', 'thefatshizms', 'gimme admin', '16/08/2013'),
('BoSS', 'thefatshizms', 'fast', '16/08/2013'),
('thefatshizms', 'BoSS', 'lol!', '16/08/2013'),
('BoSS', 'thefatshizms', '-_-', '16/08/2013'),
('BoSS', 'thefatshizms', 'let me sepc these nubs', '16/08/2013'),
('thefatshizms', 'BoSS', 'okay', '16/08/2013'),
('thefatshizms', 'BoSS', 'i spec', '16/08/2013'),
('BoSS', 'thefatshizms', 'these guys trying to mess the vehicles up', '16/08/2013'),
('BoSS', 'thefatshizms', 'they are gonna blow us up hlei', '16/08/2013'),
('BoSS', 'thefatshizms', 'heli', '16/08/2013'),
('BoSS', 'thefatshizms', 'LOL', '16/08/2013'),
('thefatshizms', 'BoSS', 'wat', '16/08/2013'),
('BoSS', 'thefatshizms', 'his hunter blow up?', '16/08/2013'),
('BoSS', 'thefatshizms', 'or somethin?', '16/08/2013'),
('thefatshizms', 'BoSS', 'dunno', '16/08/2013'),
('BoSS', 'thefatshizms', 'it just disapperd', '16/08/2013'),
('BoSS', 'thefatshizms', 'bug', '16/08/2013'),
('thefatshizms', 'BoSS', '?', '16/08/2013'),
('BoSS', 'thefatshizms', 'I muted 1 guy and I cant mute the other', '16/08/2013'),
('BoSS', 'thefatshizms', 'Says already muted', '16/08/2013'),
('thefatshizms', 'BoSS', 'why?', '16/08/2013'),
('thefatshizms', 'BoSS', 'o', '16/08/2013'),
('BoSS', 'thefatshizms', 'HAHAHHAH', '16/08/2013'),
('BoSS', 'thefatshizms', 'HAHAHHAHHAHHAHAHHAAHAH', '16/08/2013'),
('BoSS', 'thefatshizms', 'he took the plane and I did /dveh ROFL', '16/08/2013'),
('BoSS', 'thefatshizms', 'he fell in water', '16/08/2013'),
('thefatshizms', 'BoSS', 'ahah', '16/08/2013'),
('BoSS', 'thefatshizms', 'LMFAO!', '16/08/2013'),
('BoSS', 'thefatshizms', 'i think', '16/08/2013'),
('BoSS', 'thefatshizms', 'thats josip and his friend', '16/08/2013'),
('thefatshizms', 'BoSS', 'I doubt it is :/ as he deleted his gta and "got a life"', '16/08/2013'),
('BoSS', 'thefatshizms', '...', '16/08/2013'),
('BoSS', 'thefatshizms', 'Are u serious?.', '16/08/2013'),
('thefatshizms', 'BoSS', 'yes', '16/08/2013'),
('BoSS', 'thefatshizms', 'He did ARMY test', '16/08/2013'),
('BoSS', 'thefatshizms', 'He does have GTA', '16/08/2013'),
('thefatshizms', 'BoSS', 'I know', '16/08/2013'),
('thefatshizms', 'BoSS', 'xd', '16/08/2013'),
('BoSS', 'thefatshizms', 'These guys are trolling', '16/08/2013'),
('thefatshizms', 'BoSS', 'xd', '16/08/2013'),
('BoSS', 'thefatshizms', 'expllode me', '16/08/2013'),
('BoSS', 'thefatshizms', 'I need to die', '16/08/2013'),
('BoSS', 'thefatshizms', 'yo', '16/08/2013'),
('BoSS', 'thefatshizms', 'go to ', '16/08/2013'),
('BoSS', 'thefatshizms', 'lsrcr', '16/08/2013'),
('BoSS', 'thefatshizms', 'and spawn', '16/08/2013'),
('BoSS', 'thefatshizms', 'we need that!', '16/08/2013'),
('thefatshizms', 'BoSS', 'why', '16/08/2013'),
('BoSS', 'thefatshizms', 'try it', '16/08/2013'),
('thefatshizms', 'BoSS', 'what is it', '16/08/2013'),
('BoSS', 'thefatshizms', 'Try it', '16/08/2013'),
('BoSS', 'thefatshizms', 'cant explain', '16/08/2013'),
('thefatshizms', 'BoSS', 'what is it', '16/08/2013'),
('thefatshizms', 'BoSS', 'do you click on a textdraw or something?', '16/08/2013'),
('BoSS', 'thefatshizms', 'its like the vehicle thing', '16/08/2013'),
('BoSS', 'thefatshizms', 'but for skins', '16/08/2013'),
('thefatshizms', 'BoSS', 'oh.. gay.', '16/08/2013'),
('BoSS', 'thefatshizms', 'this is for wanted', '16/08/2013'),
('thefatshizms', 'BoSS', 'wat', '16/08/2013'),
('BoSS', 'thefatshizms', 'gonna dm', '16/08/2013'),
('BoSS', 'thefatshizms', 'OMG ', '16/08/2013'),
('BoSS', 'thefatshizms', 'cant rfreeze other', '16/08/2013'),
('BoSS', 'thefatshizms', 'DONT', '16/08/2013'),
('thefatshizms', 'BoSS', 'no', '16/08/2013'),
('BoSS', 'thefatshizms', 'shh', '16/08/2013'),
('BoSS', 'thefatshizms', 'i need to see if they will dm', '16/08/2013'),
('BoSS', 'thefatshizms', 'so i can dm', '16/08/2013'),
('BoSS', 'thefatshizms', 'disarm me', '16/08/2013'),
('BoSS', 'thefatshizms', 'Robbed him and he went flying', '16/08/2013'),
('thefatshizms', 'BoSS', 'lel', '16/08/2013'),
('thefatshizms', 'BoSS', 'lel', '16/08/2013'),
('BoSS', 'thefatshizms', 'he jumped off', '16/08/2013'),
('thefatshizms', 'BoSS', '._.', '16/08/2013'),
('BoSS', 'thefatshizms', 'LOL', '16/08/2013'),
('thefatshizms', 'BoSS', 'lmfao', '16/08/2013'),
('thefatshizms', 'BoSS', 'I think he needs help flying', '16/08/2013'),
('BoSS', 'thefatshizms', 'should i /dveh?', '16/08/2013'),
('thefatshizms', 'BoSS', 'nein not yet', '16/08/2013'),
('BoSS', 'thefatshizms', 'rofl', '16/08/2013'),
('BoSS', 'thefatshizms', 'RIP', '16/08/2013'),
('BoSS', 'thefatshizms', 'shit', '16/08/2013'),
('thefatshizms', 'BoSS', 'nub', '16/08/2013'),
('BoSS', 'thefatshizms', 'u dont get wanted?', '16/08/2013'),
('thefatshizms', 'BoSS', 'lets go run them over', '16/08/2013'),
('BoSS', 'thefatshizms', 'wat?', '16/08/2013'),
('thefatshizms', 'BoSS', 'I am wanted', '16/08/2013'),
('BoSS', 'thefatshizms', 'Ur white ..', '16/08/2013'),
('thefatshizms', 'BoSS', 'den its a bug', '16/08/2013'),
('BoSS', 'thefatshizms', '/lock', '16/08/2013'),
('BoSS', 'thefatshizms', 'fail', '16/08/2013'),
('thefatshizms', 'BoSS', '?', '16/08/2013'),
('BoSS', 'thefatshizms', 'flipped off', '16/08/2013'),
('BoSS', 'thefatshizms', 'and died', '16/08/2013'),
('thefatshizms', 'BoSS', 'lel', '16/08/2013'),
('thefatshizms', 'BoSS', 'you have', '16/08/2013'),
('thefatshizms', 'BoSS', '/flip', '16/08/2013'),
('BoSS', 'thefatshizms', 'remvove it', '16/08/2013'),
('thefatshizms', 'BoSS', 'why', '16/08/2013'),
('BoSS', 'thefatshizms', 'no good', '16/08/2013'),
('BoSS', 'thefatshizms', 'LOL', '16/08/2013'),
('BoSS', 'thefatshizms', 'ROFL', '16/08/2013'),
('thefatshizms', 'BoSS', 'lmao', '16/08/2013'),
('thefatshizms', 'BoSS', 'idiots', '16/08/2013'),
('thefatshizms', 'BoSS', 'idiots everywhere', '16/08/2013'),
('BoSS', 'thefatshizms', 'lmfao', '16/08/2013'),
('BoSS', 'thefatshizms', 'feel like asswholes xD', '16/08/2013'),
('thefatshizms', 'BoSS', 'xd', '16/08/2013'),
('thefatshizms', 'BoSS', 'kill me', '16/08/2013'),
('thefatshizms', 'BoSS', 'actually dw', '16/08/2013'),
('thefatshizms', 'BoSS', 'lmao', '16/08/2013'),
('BoSS', 'thefatshizms', 'whats with the gate?', '16/08/2013'),
('thefatshizms', 'BoSS', 'it was because of him', '16/08/2013'),
('BoSS', 'thefatshizms', 'Oh', '16/08/2013'),
('BoSS', 'thefatshizms', 'We lost two customers of our new server!', '16/08/2013'),
('thefatshizms', 'BoSS', 'oh who cares xd they were breaking the rules and all we were doing was punishing', '16/08/2013'),
('BoSS', 'thefatshizms', 'Dmer', '16/08/2013'),
('BoSS', 'thefatshizms', 'troll', '16/08/2013'),
('BoSS', 'thefatshizms', 'LOL', '16/08/2013'),
('thefatshizms', 'BoSS', 'I want to die', '16/08/2013'),
('BoSS', 'thefatshizms', 'THey going fishing', '16/08/2013'),
('thefatshizms', 'BoSS', 'lol @ our average players inside the server is 0.20', '16/08/2013'),
('BoSS', 'thefatshizms', 'Bug after I jail it respawns me', '16/08/2013'),
('BoSS', 'thefatshizms', 'ha', '16/08/2013'),
('thefatshizms', 'BoSS', 'its a bug', '16/08/2013'),
('thefatshizms', 'BoSS', '/bug', '16/08/2013'),
('BoSS', 'thefatshizms', 'they beating each other', '16/08/2013'),
('BoSS', 'thefatshizms', 'lmfao', '16/08/2013'),
('thefatshizms', 'BoSS', 'xd', '16/08/2013'),
('BoSS', 'thefatshizms', 'brb', '16/08/2013'),
('Nor15', 'thefatshizms', 'got a problem.', '19/08/2013'),
('thefatshizms', 'Nor15', '?', '19/08/2013'),
('Nor15', 'thefatshizms', 'when i do /harvest it say wait until 25:54 and there is no 25:55 , so shall i wait til 1:55 ?', '19/08/2013'),
('thefatshizms', 'Nor15', 'oops', '19/08/2013'),
('Nor15', 'thefatshizms', 'ok', '19/08/2013'),
('sam_k', 'thefatshizms', 'hi brennan.', '21/08/2013'),
('thefatshizms', 'sam_k', 'hay', '21/08/2013'),
('sam_k', 'thefatshizms', 'trololololo', '21/08/2013'),
('sam_k', 'thefatshizms', 'lol its syeef', '21/08/2013'),
('thefatshizms', 'sam_k', 'I know', '21/08/2013'),
('sam_k', 'thefatshizms', 'how can u know..', '21/08/2013'),
('thefatshizms', 'sam_k', 'only you know spanish', '21/08/2013'),
('thefatshizms', 'sam_k', 'si', '21/08/2013'),
('sam_k', 'thefatshizms', 'NEIN', '21/08/2013'),
('sam_k', 'thefatshizms', '?', '21/08/2013'),
('sam_k', 'thefatshizms', 'so?', '21/08/2013'),
('sam_k', 'thefatshizms', 'did u want some maps..?', '21/08/2013'),
('sam_k', 'thefatshizms', '(i can use map edit thingy really well now)', '21/08/2013'),
('thefatshizms', 'sam_k', 'oops', '21/08/2013'),
('sam_k', 'thefatshizms', '...?', '21/08/2013'),
('thefatshizms', 'sam_k', '?', '21/08/2013'),
('sam_k', 'thefatshizms', '(i can use map edit thingy really well now)', '21/08/2013'),
('sam_k', 'thefatshizms', 'did u want some maps..?', '21/08/2013'),
('sam_k', 'thefatshizms', 'i owe u from the pz site.. so', '21/08/2013'),
('sam_k', 'thefatshizms', 'ok', '21/08/2013'),
('sam_k', 'thefatshizms', 'well let me know if u want any maps..', '21/08/2013'),
('thefatshizms', 'sam_k', 'k', '21/08/2013'),
('thefatshizms', 'sam_k', 'how did you get this ip btw', '21/08/2013'),
('thefatshizms', 'sam_k', 'website?', '21/08/2013'),
('sam_k', 'thefatshizms', 'shit load of guessin mixed with the site', '21/08/2013'),
('sam_k', 'thefatshizms', 'tried like play.sf-cnr etc', '21/08/2013'),
('sam_k', 'thefatshizms', 'this one worked :p', '21/08/2013'),
('thefatshizms', 'sam_k', '._.', '21/08/2013'),
('thefatshizms', 'sam_k', 'if you went on sf-cnr.co.uk', '21/08/2013'),
('sam_k', 'thefatshizms', 'not to tricky :)', '21/08/2013'),
('sam_k', 'thefatshizms', 'meh', '21/08/2013'),
('thefatshizms', 'sam_k', 'you would see there is a big button saying "PLAY SERVER"', '21/08/2013'),
('sam_k', 'thefatshizms', 'meh', '21/08/2013'),
('sam_k', 'thefatshizms', 'who mapped this shit? not bad', '21/08/2013'),
('thefatshizms', 'sam_k', 'famous', '21/08/2013'),
('sam_k', 'thefatshizms', 'why didnt he put windows.. :/', '21/08/2013'),
('thefatshizms', 'sam_k', 'there is', '21/08/2013'),
('thefatshizms', 'sam_k', 'you blind?', '21/08/2013'),
('sam_k', 'thefatshizms', 'theres a gaping hole where no glass is lmao', '21/08/2013'),
('sam_k', 'thefatshizms', 'its a window hole..', '21/08/2013'),
('thefatshizms', 'sam_k', 'I probably shot the glass', '21/08/2013'),
('sam_k', 'thefatshizms', 'why not use the 1 dont break..?', '21/08/2013'),
('thefatshizms', 'sam_k', 'not realistic', '21/08/2013'),
('sam_k', 'thefatshizms', 'ye but nubs just break it', '21/08/2013'),
('thefatshizms', 'sam_k', 'the window respawns', '21/08/2013'),
('BoSS', 'thefatshizms', 'Whos Cro_Man?', '26/08/2013'),
('BoSS', 'thefatshizms', 'Oh', '26/08/2013'),
('BoSS', 'thefatshizms', 'Add /break -_-', '26/08/2013'),
('thefatshizms', 'BoSS', 'there is', '26/08/2013'),
('thefatshizms', 'BoSS', 'umm', '26/08/2013'),
('BoSS', 'thefatshizms', 'Nope', '26/08/2013'),
('thefatshizms', 'BoSS', '/destroy', '26/08/2013'),
('BoSS', 'thefatshizms', 'Oh', '26/08/2013'),
('Josip', 'thefatshizms', 'gimme powers', '26/08/2013'),
('thefatshizms', 'Josip', 'dont xd', '26/08/2013'),
('thefatshizms', 'Josip', '/stopcar', '26/08/2013'),
('BoSS', 'thefatshizms', 'haz jet', '26/08/2013'),
('BoSS', 'thefatshizms', 'haz jetpack', '26/08/2013'),
('BoSS', 'thefatshizms', '/dveh', '26/08/2013'),
('thefatshizms', 'BoSS', 'nein!', '26/08/2013');

-- --------------------------------------------------------

--
-- Table structure for table `sweeper`
--

CREATE TABLE IF NOT EXISTS `sweeper` (
  `weight` float NOT NULL,
  `Xpos` float NOT NULL,
  `Ypos` float NOT NULL,
  `Zpos` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sweeper`
--

INSERT INTO `sweeper` (`weight`, `Xpos`, `Ypos`, `Zpos`) VALUES
(200, -2026.85, 148.949, 28.0906),
(40, -2007.5, 177.106, 26.7891),
(50, -2008.61, 193.857, 26.7891),
(55, -1994.25, 205.064, 26.9375),
(60, -2007.3, 219.919, 26.8963);

-- --------------------------------------------------------

--
-- Table structure for table `trucking`
--

CREATE TABLE IF NOT EXISTS `trucking` (
  `desc` text NOT NULL,
  `Fx` double NOT NULL,
  `Fy` double NOT NULL,
  `Fz` double NOT NULL,
  `Tx` double NOT NULL,
  `Ty` double NOT NULL,
  `Tz` double NOT NULL,
  `payment` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(25) COLLATE latin1_general_ci NOT NULL,
  `password` varchar(400) COLLATE latin1_general_ci NOT NULL,
  `score` int(8) NOT NULL,
  `money` int(20) NOT NULL,
  `bank` int(20) NOT NULL,
  `stat` int(8) NOT NULL,
  `army` int(8) NOT NULL,
  `swat` int(8) NOT NULL,
  `admin` int(8) NOT NULL,
  `cop` int(8) NOT NULL,
  `regdate` varchar(12) COLLATE latin1_general_ci NOT NULL,
  `prison` int(8) NOT NULL,
  `vip` int(8) NOT NULL,
  `arrest` int(8) NOT NULL,
  `surender` int(8) NOT NULL,
  `rob` int(8) NOT NULL,
  `rape` int(8) NOT NULL,
  `heal` int(8) NOT NULL,
  `hitman` int(8) NOT NULL,
  `sales` int(8) NOT NULL,
  `wep` int(8) NOT NULL,
  `drug` int(8) NOT NULL,
  `taze` int(8) NOT NULL,
  `truck` int(8) NOT NULL,
  `cookies` int(20) NOT NULL,
  `STD` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `prisontime` int(20) NOT NULL,
  `mayor` tinyint(1) NOT NULL,
  `teroist` int(8) NOT NULL,
  `fix` int(8) NOT NULL,
  `kidnapper` int(8) NOT NULL,
  `pedo` int(8) NOT NULL,
  `taxi` int(8) NOT NULL,
  `pilot` int(8) NOT NULL,
  `pizza` int(8) NOT NULL,
  `farmer` int(8) NOT NULL,
  `miner` int(8) NOT NULL,
  `salt` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=237 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `score`, `money`, `bank`, `stat`, `army`, `swat`, `admin`, `cop`, `regdate`, `prison`, `vip`, `arrest`, `surender`, `rob`, `rape`, `heal`, `hitman`, `sales`, `wep`, `drug`, `taze`, `truck`, `cookies`, `STD`, `prisontime`, `mayor`, `teroist`, `fix`, `kidnapper`, `pedo`, `taxi`, `pilot`, `pizza`, `farmer`, `miner`, `salt`, `id`, `ip`) VALUES
('Fuli', '71A31A83955ECBF8ED3743D2E6729B5D4284EE47902F6FD04E362B62C29AA1FD9C0A153649388E89AAB06AEAD28DE68668916F8AC182D32C94B78572EA5D1A74', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '1Gcm63bStH55EEwK9QZ5PV0Ol6e8Hnu8W002T4tSg894542l9s374f9Ooo6Q9v9TJdd4K7i16U5v5Qag09Kf410g1380LQ1i6p90', 1, ''),
('edu_killer', '61B53AAB0DBE75B597B6AF4425BC5F7BC6F19E693847333CE32EA6534D47B2FA8FA0973270DA1E8F1F6AABF60C7FD6062D74D58CCAA8BA3020769B65B4A6483D', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'DijF8v07953yNxXy641boK6H9613P4UlPMmn5b6l3Nd0Wk5t5AoZ7Lhr8mKfr7zq8928A5LAw14N6Sfp8yxJ4Kyh9cT5eP019N54', 2, ''),
('Dj_Buldogoas', '812C0FB22897B8C190A4823429230D58C3343D00F82593C7F14753E8BADD705047654A2DDDC21F5626EE24C5E9F225855603BCF4D0F37D5507FAA75BB5F167C8', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '459093oF17A9q17C55e3i4Zfvp1t45n0q0U9Icm3b05PO230pY5o395Iq7T0wjL8zsVXs00J09Od63cSu24F1JR636Oorz6zTKFS', 3, ''),
('federica', '9AC0AB4FF28F1378B14E67A3E55FD73F11C1F163D55474515F56D115B046A0D7C9177621E0AAF971721D5B75A778D377BD654BD1FE561F0FE59026B3A4A692D0', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'b2950i100W9gS85A048Lf4U5ubA9U0xDn2H8982y247X58jU7165AqrhTs7lA666k2597l9aBGC75337hF14KV957sf3md22wquy', 4, ''),
('Fuzzy', '415634C0E5304ECF042CFB5F755EC6031424F116726A8386BD9634ADFA50E2996B8204AF6DDC7483074376CCDD599C978CE685F98A30751BE65432BBD82B7582', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'DxSl4Q58t8s0wZ4qD3K758QiYDL45TMC1A6M80qhY43if3wywCO2tJ0144DH9H516PlJ8E3U2T5x6sv2f39Vb9uXC8U38K6q82IS', 5, ''),
('Stel_Power', 'A985CCB5F8EC8837E705F007269B340A604A41512AB2426840A348D142241ABD6FA2A2CE6E7CA16839D662DE79693A97915A42A70E1E8610915F94CB116764F1', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'H65a977GOcrX15997uXw77094m2H49ZY7C7jJ874g7dMO1910980b4OT4LUOnN1Of77S90jCR7990iwX60TI6278O0893Aj10173', 6, ''),
('Nathan_O_Neill', 'B130B2313D60A1572053FA2EFA5E4908F0654EA1C8A8C795A70E3B04B76C3C8ED0A5447F821BEBEC1A0E23D34521F46122EF93515B6CD3D0E823C653211DFDBE', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '93T0TvgDYwq80nhk6G21G56KSs0B8oH7397DrV38q7397s2rO864608C431361678dd8a8k720c0G4g7209D56S63Sd80211dKu8', 7, ''),
('marcus_rodreges', '3BBCD8449FC094731D07F26151EE05262B064649C0299F0BD761FF80858CC4CAD689DA66FD80175E85B14D14C181DA1716598C8B9924A3BB6829E41AA5C09FEC', 5, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '85K3Dmrz5760h8rdbB1Lk7S98fHNX58YZ46k475C0be205r19vMSLEc531e58GT6z2G81901o8180t7MBJPz909427L1161735gI', 8, ''),
('Yigit', 'B5C5D5BB59378860FDF5F25884460692C1D3217D3F365018ECD329440A818E5CF4FB365DFF51CDA7128FD1CEC192EFF453A41CE5DA652D2C461489C008EC2015', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'S4wAjN9m27hI31T2M3XEO7GkLbV5u1D9b98iIrNlmQJLj55O4686IO7NM60Z45FRcxL75xF3rD8C8QPb86B906p4h966oW12mD5w', 9, ''),
('Umutcan', '055D2DA90D2F094B113869725356170E1D154F5CE42842775ECFB51CF559CF90043EC64E6209CA87C5ABF647D29BCF6031B8EB790505F87985E4642F1C670A49', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'dEKpbx4x3Ku6k140un5DwV72dW0kYePpeI0Ct8M47l924707EhnIs456892wZK6PM19F9gEf3TnUt0A3291Qf03L1N3GDVqK405V', 10, ''),
('Rafael_Santos', '9492CDBB70802164FCD7FDDC0611C93F1BF22842F97F5A5748671CC3BD070948400B815A827ABAC66C0EDB6F26593EEA5D8A4945E660047A6BDFA41AB5E9D6F5', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'sb0291E9t48A91m137208gdil737036cd44658DAd3s245SVUKwWhS019K67w3866kdvnzdT047J07K46qG4514e3fJdHE570M3Z', 11, ''),
('vandizel', '7B73985EA327A788582A4FC548FB4C94EB78192D48C6BDC022B1FDE40D6D00B67A75210F18DD7B01407C124E4D9DF49F941D877D60DB7CAB1F6624774CD1B9F5', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B5g0J93M20QKV8xZ6mu8G2r0Uy1v552P1J80m1fz1T74E5c7sOBLl643Msum9QE3fCBDg2315658Av0610yV7an2894gLdS28i23', 12, ''),
('WJ@player', 'C55A79D7C1EED819D08B541FA0EE60E8FCEC0EE0B3CEA7D2357FCAE8205D9F26E5EFB45653FF3780AF8037CFC7E553AE9307C7E54400BAA3F5DC1C858EE092A6', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'D9efs6EN07LkfO7jxP4P46EF06938m2FW5SjK6VE9i6r30JXM2L7O93wC597n82999mi91cRX468086dSR0mAiOqpdkRTgM5383S', 13, ''),
('Thomas96', '89E11C5D48FC74D644EFFA6F721EEAAA53FC73F3B07338F4B07B9B9850063981F974380A008018A95D5E5EAE5BFBA5AA84B2EA74B6398AEFCA1127AD8827F9A3', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ICk8k50Pa29xP5oS76p23dQ470MP328R29qTn1E3M5JHDVCi8u9FiJ413xE23dza1220a7z650bRNzMs5TlPiAkcRkX42mI344iJ', 14, ''),
('rami08', '2B516AF0AEC7110FA68E85F7D4259C8B688716868F44456B7983324F765B78A3F6267736C13DB84904431E7B4CE427B820F27087642893AB89B88002F3995284', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '67PM41N8ae4r3dj9del0ov007G34MD4P38ehTr171Y33vnoTY264yu1JF3siSbX7JVbb12I8zpcWU27rt524O7acE6hg8q0X9Z07', 15, ''),
('IDONTKNOWMYPASS', 'B945F0F79359E66183FEE45F8797C4D03BA52A515A025C55EF44963816BC4F2F66D23BF88DFE964403EF9164FEB0034E70B63982C955511E6E44D7702589E523', 1, 40, 0, 0, 0, 0, 0, 0, '03/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6P8V26M75Th808492E2wlYbNj0l2ZCQK8759kTgesIExl7I8G94rKF350P93N776617238YZ88J09z708BW463vhD2869L21T2v6', 16, ''),
('thefatshizms2', '153A07C01BBDB06CB6E1BF06358A2BDAA84FF50C5E6525D35CD96B0F832C7F44E452F16E5CD70B6C1E31E6E32D29B847DC91E73FD09D5F7DFC0436B07475E701', 0, 0, 0, 0, 0, 0, 0, 0, '30/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'qP4HvV625QYv677Gqs85O33Y591kI0c949jSx7Hc6R7157F2U3F7975E05D09B7biHp1r57b31RJc8FJ4B8335z7539Ib1g06suU', 17, ''),
('Ma2ter', 'F809C37EF4AB48CFB3C4851232D845D6D5BBE3476F0C82996E2A776CF6FCCF674921C9356AEE83316E419A1B854D80509E05E253947FEC86C1FA46CC974CE112', 34, 133762, 0, 0, 0, 0, 0, 0, '30/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0D5qY81808Xh67J4J1z8IPP7q3JAz7vX841GpRk0hE4qdAPI937t2h83002Y4UC5Jx3252g0u9dHA4n8U8Wt77a1U8a1OQ0d557g', 18, ''),
('Shkruje_Emrin', 'C55DB791D3FB68AA824191043489AD98AE976E40C9EC1F2868AA8216F2190FCA3434A1EF6A6083B57F0BAECF910D972753692B36100F157B4100EAB9CAE91C07', 0, 0, 0, 0, 0, 0, 0, 0, '30/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '85Zt120T9G71183Kf9tU6081ef5FXN2T77u528xMY964ZNd75f0G01E7a510777Us94J1xF2D8CC0M195VUdv95fj5IW845j6oGi', 19, ''),
('Chicken', '612206B19CD01F3B6F84C0954857C7347ED7A73739D893CA791E319884470E4ECD6707E08E4B0B9550BD078667B9FFE832B24D2DDBAA2E9BEA6039D4EAB9EC12', 30, 0, 0, 0, 0, 0, 0, 0, '30/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'r2p8Y076s2o71A241889e47Y20018Tf66U30WJP244SBXea5N947w2N0M9eCIx8Iya9J657FM7z5frID30V61o01a200h598n2j5', 20, ''),
('chickenbeans', '18CA4795DD2A81E3B51AC691931E6680E570C004800FC45B0ED6E247B2A81A565734FB8AEF5F339DF954E6D0FEE875F26DEA837064B5F114EAAF38D460649BC0', 0, 0, 0, 0, 0, 0, 0, 0, '30/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'G4yd3CK4Q64h6978083v32K9nbv729OJ22g852Fr3q2p9f1IrJ76f0MlWTUj85603GL1Xwp5J85U59FE6mnrx5278B9151127C00', 21, ''),
('saif.afzal', '03694D1ECD9C41D31F30EA23A88C9FCEC72AF8F6FEC141F66FA735072BF56852335C2C14F0BA9FF5676936E6281D5C12FEB756AEBA64C75707F054B9E189AA3E', 0, 0, 0, 0, 0, 0, 0, 0, '26/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '37Tf5t60FFq72E7193E9r26R16G216t1857741V38pv9x09x95S3IlW92u57O7wxNn8040k77I5o2M46OI739IsH16H2s3qVm98O', 22, ''),
('mobeen_ali', '7C20681EE801CE9744F4714A897C6B6229F3E1B94C4A88EBDA40396BAC92C8DD4CFFB0402EBF4064D5BC6119BD144A80AA3A8E981CDB40890F36CD37DFCA6FBD', 0, 0, 0, 0, 0, 0, 0, 0, '26/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'O8pj8C30YE945j372n0s76x8xJIC4197n031e99833t0zN6538d72SFjN94ybHjP8nz51v704306dT1S76z9628b3h2qfMebp9SC', 23, ''),
('Omar_bakhsh', '90B8E821C7EA7182EDDC392131BB13C86B003A2712E0D765C838381AC2ED99E25B8BB379755C2CE58228824214E479F6620A2D28FFFA33AC6DE1E2C5952CDD49', 0, 0, 0, 0, 0, 0, 0, 0, '26/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7k1u868VbC80534T5J1p74R6eH80nuVZ4l6E64m177leOFX8809dv26fPGgH5241Jkl46evj01P99W5k05Hw6OG5CjDawMv0xifs', 24, ''),
('BoSSPEED', '6BD3474998E0221D596A58F4680829508635C9FF9EC7B0A265F435C6ADFF1E77FCC1C5E2C19DD040F5FE9A00186A63D0502D631F72B687BEE31395366D83BFD1', 22, 42, 0, 0, 0, 0, 0, 0, '22/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '9U27Jxu3Fzj0XwA0lE118x713552uVHm8Gmo6V2532U01vubAHg63msPTr6766W150ZTa1Zoq1Y4ZREQW2G1j1p16HS6HO5h20bL', 25, ''),
('guazon.l.', 'FCEF46883A2C304A0F19662E2736DBEC349240252ECB6617358002E0D56BBA9246082EEB7EA841771CE814A0F49BEB5D994C16917520A844661A4EB2FFFBF947', 0, 0, 0, 0, 0, 0, 0, 0, '21/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0DsYk93crKql30B8187P724mt9F353035FvEa4y0040l7iF27v56bQ9hx2P99cKli842i44T68359OuQmb3t3h625W555udt9DLQ', 26, ''),
('ninja_skrillex', '5856868C4C36438CF6A1FDCEE2FA0346A4AEF6D64671E47190C58B95E070869DDACEB40BD2184715BBCCDA36955399D2A9ADCBD1CB93F149480CC0495EFE9BE4', 21, 2807, 0, 0, 0, 0, 0, 0, '21/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'vPIZ216p5p9G02492L2293f6T8cw25Kei7k5fC5ajxC1EX13hHFB48RmH4L09VQ2g51yY4A940uqyWsI54w8w7202Sn3J5B197qJ', 27, ''),
('osval2002', 'B1A8B3502D51ADCD952F2257287EBCF7C281E9ED31B3489721E9B78F187DF4616DA515E86D2784CE64E15B5E6AFADFE3165EE911EC9208F07F0E57E44AA94748', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'x0nGx76bP9x3188456Pw8jVU5ha97dnJneRl9753qEHqkhw698AKWx3ua292bX1MX10N8V29r4DK4Dx227k7S7cJ53P13TfNYIy5', 28, ''),
('Marshall_skrillex', 'DBAABAD95E1EA8A1DA4541FDF55FFD259E7D9EA85743EF6358241916058C23CA94472C5EF1459BD1F5D019E09FABF3F4B9E551793349A42448047145FB842C7D', 0, 1116, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '1mzZ850Nw5kraCaH62z4P1i08Fno09Gtk043yY070w4H0935q4183965w7fzr8lAqT24pV5H0E0PJw21O70ZY07XvfkdvhLY5Jw6', 29, ''),
('tanker', 'D21A58E018ED1F6A09403383BCD3B2A6E8434A28686C0214F8A251601279DE1605E87A4E42BB820BF6729E5648574862DBF282D360FFD397FB7B98AB2A9845AF', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '15yK4P52979gX738aZ84T726z1fO4Tu630Fu1dEQ036Zub12p390VWdu16969c1Y1L7Q738x76czbo782M3g43jP9936026XL4Ym', 30, ''),
('Ivan', 'FCB3CEED65655657D6D4F2494ED752CC90499918B1706DFFCF16A46B21077D5A8FD5AAC16413B203744C53D3773ACAD0F48F16FA59694E777A9706686820DE21', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'lg7SL5CrW0gZ908ZBnYc32645h6Wdg9rE5016230cd378ExN3s2a4dy60128Owy05oV811p5j01TFjViF785y92N4350b5fLPRz5', 31, ''),
('Emin3m', 'DBD284CA1FDEBE0A8299FE0233848B11374C79E1DA1F88CF2C2594A691F77AFB06A74C88F32A2B31C9EC13E95924CBE1846DF36657D7485CC974E35303565E25', 21, 939, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'aV1q8Z1c7N7X059U4n2AK1D2uqqAadtjud91L08615403t8Dl574485hr684e5L6Zi1m9zXG9j274YWXf0ChXPC148414w8DwX5R', 32, ''),
('meno', '35F14F6B53D2F8C91C297714EA0D7201AEDE8B94D94CBC5E1B6D2EEF440CC24C330B7204441B42955DFE3DE0DDE10146A462AFB0C3448496AF77AFAA7F24D617', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8V6o4A89r4006w74fBg4c0Y50f6w439Q9Ry2sV3sHdLP47262154X933p7VlZ6529Mp2CKr1s2IncdycA9l531DIr1cnM2352S9K', 33, ''),
('DKOY', '044E0B06CB37FE0B7254ECB958956DECE8529E2C4DFB75F10E335FFA0A2B8946606C243273A4D55882D97BFEF9C92887B36D33E43A5A05508AB07D4BFD2A37FF', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'q14Gp40jt7T29UkGWbwA3jtB6c7K4586Pn80CuBo4DGm4t8l171nM455JO449285E8p9sCb9E4a3fZkD37kGXU62fg4960ML4S73', 34, ''),
('joel_escobar', 'A0D7D212FB7A93800B93B31F0BB1EC972788DED0C0564BFEEB7BB66591017EABDBC2A52F5472D274528DDCEED62EF237135FF26F6F7577270C5ED9ABBE1019DB', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'l6f8VbV9IpM1G8C14vTO8SY7S6OBT273o5E10868r707dO8h6pokB163CP29U3f17LyCTSd4ZX188pa2u8Xwvr9WN044WN99L983', 35, ''),
('mahan', 'C89D82289E8705F6BFE60B41B748BEA0A29BFC15B1965C2934A2F7D533C02C03CCC1EBA87E01FA264D51500205115443F68ED63CF584BCA51570EEA513D49999', 0, 55, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '9t1b2s5Z5W13Q32e6I20B9aJ9N55264pV05863w2mIJnd3O67ns9640L3Q8C1l2Qo56R21Jy03d5W851H3883996988jinX5vIuK', 36, ''),
('Iorga', '517DE6634A5D9821F9DC610F56E2F82D95CD8E3FF199ECBB9F903144832EC486DD2A030B353CBCB0EC3045C658462A4820B87202433043AAF1CC41474AE90FBB', 0, 37, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7780507T85s70ul0aGOL52FxJS319U5ad69dwy1J185Xk0RZhH36f0p07217yPUJac04GJ3G4aVp9g1312z61q3364Xx25G8365c', 37, ''),
('pixas2001', '1C12CD1D7E3D63A4429768A3087273C4C213B581941DFE1010A1366E3094499C42FF73EE0385E9B0E074AC001C229637F4124DC6E7810901DE52A611FF074F4A', 20, 1170, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'U79n1U3g9q43FRr3G47T60i7I3N157N3h27OZha76I2r11D43xYxynA5037s11QJp5Kv21488t784205e75d66hi8w664a1TV61E', 38, ''),
('rubikes2001', '51BB16044DE3D0675E8BA488C09D66DBE2D57370C68B89A6167DFE0327C1B3F9A8014560BA909F6A94E2BE6D6A454176FB2E90174B30BD5DA0CCCF31F85BFCBF', 0, 28, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'o22w9n6V96jW0bKY41GWsF95oY276212d7GmS8LN7P2VE2NQb9y0F8m025883U490l3QDAu4ZP2ZP2R736921C87FB426K3Og4r0', 39, ''),
('domi9467', 'FCA0EAD48FE18D78CCFEE42CA5210AD8F4021B8A4ECD877F1E06DDA606C358212EABD413F6667ABA7DB825DE964876DF3825C86AF82F4C0DED4AC78E9EF25496', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A7i1171PP064Zdj4H7HVhtPW1kz1m257cP16tv7If24cjhRT152P668OG26132k6eH6BG0s5b6ei63qe5gq3w26K840L64AtHH78', 40, ''),
('Soony08', '7E7BA8EEE5D7C4AD2347A0FF4603B73DF109EA9220322D73DA1AA4AE560A6DA3D3DA7F931A16AA4C4C0BDD18EEEC5BBCFB944C151DAB29F406382E625C7AF872', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '78xByJTE9c77x6cW1U6gr04Z18SSI3E30OYldbA36gF54XbMyqn8551P5r8IC439Na9eCq3HSvd71Gi1J5kn11en3o22bwo4R7i4', 41, ''),
('Johan', '2FA97C828BF0965F50FEE739BF29BD2D986F66209C94A544A6B8C2A1F48C282E5F4C106C0CC0C4AA75DBA209B598CCBA8BB80C5150A77B7351AE009250B6B041', 20, 32623, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '87311j99KwQvKZ015R3925O950g4515Fp56dqvFxji9V4DjC0529IAO0G3kCAgEH7xS4E509MRqO5eatoKIjL901Xhf6L2u7Xx8Q', 42, ''),
('domi9465', '8186564BA8668C7D53372754DC6F601B11664D1D633A7EEB903DF5B5409753F1E60065C7E5D7FFA5D9B275479FD977E52A1D4A2211676F91DBD6F2AF3962EF05', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'i0En853wKsYk7u7e95WxZUiw51b5UR1565KlhJN4ZVexNR4YE4B01Z88S98OvO14LTm6qw8RDf2zae15F3u86e159qQ46bWgq361', 43, ''),
('Yousef', '913787C7B3C04A29CCDF8636F46AE159EB05B64E643DD5EDD15DA991E3A8002EA66D80A7FC1DDA52105BD5F1EF5E310623B7EF945E0E0FEC9D6B9BFFED759832', 0, 0, 0, 0, 0, 0, 0, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'jz6192Lqwk34VSCXoJ93nKZ5aU8q9n8d0562340Ql6UQ1H91s5eKW94Ti42N4mIi38yhM465y4625FdbRcJAm1057v5o4N9IPGRF', 44, ''),
('thefatshizms', 'B7E105FB99C2E4A2C8D20BDAD4A65D3AE95F2B03C1CD67699CF7340F86C3498FB28F0E6FA7609AD20D20C13968056C67A36DB1313BA86A55B735B5251AA606F7', 58, 321982, 39374, 0, 0, 0, 4, 0, '20/07/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'C94I08H3775O5969x9fkVj44p36DE9130u7y6H8ga0437u1k1X8Irc732VWuYci1vwp3zwvr4b341f3WCLL2014uG4S4AeD53l55', 45, ''),
('Mateo', 'B8E8F8A510095D0CFBC23DB069A35C69A67BF4318B1A239D33B08DE6ADFAD63388F5752280A6524A0382AECC1E613787C50E5F35AAE80A160F2D6C74AA106540', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Z6i3BtYWz15C9ZWn109EP5B2G32WN4348zP03315uc5O56A0K4QkgcW31wuS60Pl2G696n1915Y742ALv74wJB7pID4t4B7i51ga', 46, ''),
('EL_ALE_UY', '00E9BA02B1D59FEAA0C1877ED49C7B79EE6D3A7BBE99FA6A93D3D701F44B6D55CE1A33D7AFD203A2AA9870070A40B70C01A02005A3FE2CA962F8B37820D15A2E', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '909b92z7J87146Ax29n6Crj6dh91s5y46ue699845j60V420p5060T0c97ltBD19PV602190zXN2Nc7520Glyj8wt4m02860Y221', 47, ''),
('FaNsTe', 'D88417B9C0016640D08078E6C31B424C7EA880DA5E03ECAA8611C7F0B2CDE0B6640067CF25D1020D5AC1F3A178CD04B105600750A59DED9BD5B761B1BB6437FA', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '45f2c8BS7h5i55141gx2bW26VUKB775C56BzV16B5b872K0E43wN6Ja49r36Fux897u4v568Z1Z825R8nUL6HCO40K97u346A146', 48, ''),
('xXRebootXx', 'DCA12BB0C3702DED9EDCDB4FBF00DF4D02A13A58173724C67B1C63AB8C86A0C3854B750947E70CEAAB404D971604710F7196A3E010CE7B9A7DFDBFF5DD265D7D', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'S17P1sp00w8vW3sNMaa53vCDo9DzQxEmAq9W734617wK743208Kj8o76IQp23VWQ21vTFMkf694578707Rs8cg78zy527bZqCY7K', 49, ''),
('Attila.Opra', 'D53BEEDF71AD2C710B946D9A28379B30055106CC309282DA26D1A1EF643248D952EC9618B0F3E420F93559050C05F105F369CFBE409B5D4D848064FC110E41A2', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '799m28073330cNt7PP1a7F74bKl3Ph3e7TG1005Ue3613618e9Wb0lOOB78y61WP0RO3843Gmu0Q4h80Q13f8w4c67098E2PM7D9', 50, ''),
('Vlad_Sobolev', '30D34E1FD2FEC880FE5B47639426CAA93CD969172F3C81408C17F9B51701344FB50FEA38E5536AF5EA433D6DFE0986E587A5CB334EC00A3305E15A7278D91D90', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ku64m0p4LNv1Yj1309331wa1Rh24Wg427mD97jd0j4q8mrlU8l4Vd7z5I10t11g2202z2n1eJ9o0572XspT8bv09Li321fDfXIUg', 51, ''),
('kev', '50728BC13DEB0265C9DAD3083DB068F37D0D7522653B712B699AA74F55CBC88AE654747D9ED69AD522B741CDF47C7DF3CBA09ED075AFFC7DE2459AEB06C66317', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2H9JS4S61098xT3Mq3L0w23b6Q28H7t8xAAM7z732tCRgp59H78i8QS6126sjLP1C5dMqR40w95emro54592rXv2a4HXt3V0s81S', 52, ''),
('Julius_Bolt', '475F26E1624750666EE652FC665D13425E626A48032A2654D2406A506FB99BC4A1EC88E501C88E5D0CAF2BDA505E099EFBD86A85AEBA130059456E6EC6DE4B68', 0, 0, 0, 0, 0, 0, 0, 0, '05/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '3DS48lUhXrW78zrM0s114mFOUWg25q6i071n8C9u265Zx96eRw16Zb2d79w486HDu2c013VQGum8AD175W4fsViwli19I9E8d9bZ', 53, ''),
('Maya_Taufiq', '45EDFD653549D7E2A05D849281FB07C8062FF6CD5DD26581F76B399AF79E80565DE1963707D8715DB291F8821BC1B4AB355EC6E42BF2F6E25B322A77557C0E31', 6, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '51fsFO3E9d6lR8IdCMm8887u96ctd8E8ICTTv285W6Z0ir1fj611o6e9l4VNDUv2am2Vo7UO3qq2jS7Sh1D6I500AejDKHnX5zIQ', 54, ''),
('Maxim_jee', '5173D62C01F8A7C221C843FA656670C6D77B253E016022F2C11C1EB37CCC23C9E70CCADCE9801DBE03C3AAD876BEEB14E64265BF41A99CF636F340A65C8F9A96', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '89b4k546OLv059N8qX61mx1i30J2GgV2079sR19juo2118pgkYj169aC1Z0Wp2ZR3416t3475wR123503FL329wWL3enPf04X4Hb', 55, ''),
('[SAS]anlylmz', '6D1E1957AF16F631B74C0A3A8E35EA3DFFE803F4CF3F4FAF263F6EEC12CB656006E584841D9405B960A7ED980D5A60626DC1F48D0EFD64C6A6DD50B4C8FEA0BF', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RPcRk7KvjdjAuX84r64jGl8y06eB00tS4Gz2M255sv65l665MMSV11465qhQbw3299SoiGvaVOv1sE31nA59e9D858ll5469d7Pg', 56, ''),
('Matn1xs', '7BF866CE7E0C4955F7BC7FD50C6FEF7DA6A2963CE9D866378CA6EF8045059E617EB4142CADEEC9540E605A8E52057A1FACD66EAA78BBAEDD325E9662B8284AF0', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '74z95e8462t0x3eP1a0112BojN2dz47Bg323lNrRUCg59179k08053376aXj1NH5q7R18dUx3Bl5q7DU5485Cm1291298g1Yd0l4', 57, ''),
('SaphiR_jusan', '91E185623AD66E3BC47CD5D9198DC2F6CB0FFA7882EDBCFFFD338DAC3707D972D9C00F28C7F5263DFB069101FC97B1E795A60DE1274BC154E7082644A38AC5FC', 1, 20272, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'L095v1Zq5h6a620216rgzMktin6gp650ZKbMknFq45F30OGPvR68tTT718f135Ax2VFf466t00kVR916L706x011P94dVrCQ12a8', 58, ''),
('Taladond', 'C3E688CCF6323E38A435EA36C16B47942FDB79B4F337FDF283C9D9E07675528DBB20A36E0FFD6CEB7FAF25DDF289B5859E15507AF3D3F609485D6792860D31DC', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7T592PuXS145DH4Fy9i8R52773a8G9Dg1k0vl46v595Y87M41008J82g0y8107487hrBD9T70p67m9NRG98s307mOD8ybm651W8O', 59, ''),
('petit_me', 'C5C0766A6E3934D7394761CB6BE072A9CE109E092F5A9DCD1FEA321FB3E7589D6D68DEB93BC984D1CCF919EB1BDDB4DC16BEA785D39C8B47043BE3DD49B18499', 1, 14611, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '14Gn40p1B8eRg877vMu29j93g871T4v58U03x5BODQGS8692I24928I52J312LykSYxF3s5nep0330y88u917R75323Ic9650Le5', 60, ''),
('Painwithin', 'FC83E3ACAD792A96E4BD1E0B655BDEA72A1347629482EE68D708793B68B2122BDD8693B08FBDE4B96AF20CD282A98EE4451D6F48C6A87B2B64078303CAA9A689', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '29kqy29S1Iotibn8GfPU121c2iDT4f5AZpCcJ41Da4U9h575nbD48829431N09V3k2837h6LoOcS2wI7SwhIhab56755dKZq4M2I', 61, ''),
('Ruben_Garcia', '2747DC321FA07DB978D1E8B8CC13BD9168E679B71B31674219191E1CC047449343537ABE06D523AC40CA4DF3073F31D888BAD74B3CC68A2FFED5E8C0F200ACE2', 1, 24641, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5D879j0w6Ga4E05N6Pw583x814890v0B4JF151oO51EWTdu4Vm7s268a6uJ7W7kKRr50A5pVH979266K37t3CQWCvQa310990y2R', 62, ''),
('dogman1', '7E97DE156128C3A3D4902829B55EBFDB27F731900DCF1484C7E74E7A82EC9837176A121089F93C310BC34FA97BA859135FB674736A636A0BF5912A83865D17DA', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'JN8ng8vE765y7O2VNm8643XpH0QBC55U50A2Q3J99eYHk848t0I3rn96Fjl3w473Cv60ecTh53D03RF118wx9pLE373Lw8G5ii95', 63, ''),
('Honza_love', 'C7A24AB5F5913903D34128D6C977629AC3C9372A06762FA74E4F150401118B2C437CFD116CFA2CBCE39C4B7F8529F8B68D8D36B66FCEE26242FACB46A66D1602', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '494d2P3Ws1Yuo9zP637499ekqn3b40l4i5pQ2Z2tG1xM54675rW19zan9jZP78L73L01rC8z03X923xV9rHJ61Lfh0lEH6NP6e6M', 64, ''),
('CaptainShy', 'CA3CE66955236C741465CE34A5B42FE9D2C4075F664057DD845DA6051468B65E3F02276ECB3F749207E402149C801562CC6498C31C41C9D4CCAA876B6083BE20', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Y9R62007nYQ967760339609qx2QCB727a3N8m25mFKUzn2646h2BW00645P851209u337i6Z3828v82t1948S092kxAdro1luD59', 65, ''),
('RealCop228', '1A7DC900163AD630E84C95B0AC2E52F99836E2608A97FF21DBCE25821C52CB5C8B1ECBACD4EB98A352674FA2944BFAB28B6859EFAB1E1D0DA269AB55DE081CA4', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '77WR6g656CRR6230zV2284pAeI364x7N9P3632s29J0k079W9q3Nee4Ml7Gtko9H9TrB4260Q1P135Md80FMI6O39y5812vie7u9', 66, ''),
('BoSS', 'EF2717F32A94681D0C788B95F4C9B3C1668AC92328FE43A2471C434214061F47B4897502B6838A9707DD50380C54ED2FA72BD0710ECDFD534DD00C84B564FB43', 57, 900, 410286, 0, 0, 0, 4, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'dS88T0AU4a7039xm8135igf4RC25HkD353e629zYT8IyG1g1CB5pYT5u1mN600t4M845666KE7R36Ia1dVkguj4eHZ2e3309W5b5', 67, ''),
('Matn1x', 'D19F1DEDBDAE7025BF541484F6494AE5A765EBB2C505183C14728E2AB5721F523E17F6516E4907699DE771688674D795D8D093E864A3375C124D75AAAB57481E', 1, 150, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '36c310Dc7w1Ih553lRv0U609G0JGTC46qx4E37gZELU0i6o89l603PIY2758R1149nH308GY8h47Q6IOKhRD3ZX8jhOn96ZAv49W', 68, ''),
('Greg', '7E7B62EE928FA54EEAD72D23A159A3B875344084C22B457BC2E7CE23B67CAA985287907F8D65BF88B9CB0D12876C45A40BB31AF303E33E6D8FCF5D0786DDFC04', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8m97X28fM6Hf22guR363060DmYvp95UH0D77I861WwC76jKT3J13nit32511S921zn9MGmf11o5eq4242Lac861Ftt8Daf81MfS8', 69, ''),
('Toni', '0A0E3D4DA1492F895B8EFE4CB2F1AD32038EE472E96746515904721AC960C3A1A3C3B99BECFFC99182D66D2A97B968F7595C7A130842C6CED8E172D203AAD38E', 6, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'yH88Pyw8921817497ocKgb08k1xloUpATvuG2J8V52270f4O1T3d3Z5YG9jg3X5lwIC9353P7Rfv70Pe0NV2T8C0570dToU3dW4Y', 70, ''),
('Unix', '499095935AB3D38303115A7D43288F77EF60F4A223D974242E74C7544C4DC164F183392791D47A783CC6F94D857BA5F9AC97F4D304BCB76004171B1A87CF675C', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4bw36271v18052KMLI82uFS142a0Sy1kj9T5RJ97Nz4Kr608DO1l8ay78STQ22CIw4bXRh746rt077EF3HMJ4V28333QuiTE9pgf', 71, ''),
('I_love_you', '1FE41C6B86112B6FDE56C8E86BE14CD899755EBC5D44E582A8E34FE3AC92595240A77FBD768CB6F8440840B82F1B7F2ADED88984BC0A07E3C855E499DA66E28F', 6, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '76Sx2Q45XKbzJgL98e0XCR8qHCP7z5627EabG19js79Sbp57N5810m95v1P3U1y13tA90y73767376GMQ3zn33b125s2C3467FZg', 72, ''),
('Timonenluca', 'A780DC247BC6BB78B92FD90416C6811FDFD023AAEE0BE9D3CCF2824713A01B873AF8F074DE545E62886476DD98381E6B264207CA4657173166910B9D415D82A0', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5j023MMA486nH1fNH8t08316kR7095L4LMsHu58dq9LAcUST0966404306q3Bj5wt334x6605lx7324JdeO3T5I6e8507D49Usvm', 73, ''),
('Awsomedude', '754A4BA68CEDEE8FE1F11CBC357E5A9DEB0E54DB38C2A4001729969BDE00F62C2459D4F1F202321FDC0AB6831BC91C4DB6496F1DFD1E235922E087575E13E8A3', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kl458GTkbC4085Z556b2Ka5376vvA48JK0lh514r94CC4B8lHrX974IVp68169qgV421jyxzW2o51oY3s4S8LN470616q0F1k0f9', 74, ''),
('JANSISH', '0FED80A66BB3A8D2C34E5EAB538CA52188542E01D3BAD699AC16C8614C8709DD8BD6DA3FC3CFD0B1B02BD6EC528611D2992DE59BEF016D4DEA9DC1979290FB76', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Z9O02993o5r6J719195YT513Jd2Px8W8XZ76s1b7O25Eku1f30784x80ghI70Y8zH1g8tO92vGN36Lg604QUln25u5309897jfl3', 75, ''),
('Rzzy', '8296B83969A2FB5E96995650828536316D5717E9FDCE746099A9D2AB032D0633533CDF97D2BFA00D0AF95ADA3B695FA1B90DDEA18016E03F5B336C5D7893CC56', 6, 51189, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '16458YmU26bU7JO0t6B84mGEF52L45p7CA8948y82x2CPOf991Yen3AD362kRz1997R39715t0vY4ppz94Rq73425goX92e141L0', 76, ''),
('zakaria', 'CCC0C81C53C4593B55A47683DE9A2B7EC9689C35D85E42D77C5AE6C37D6650558D22294D91113F746EB32C3E9F4CFD381C9EA0DA00DF4CD94370E8C79CC507C3', 0, 0, 0, 0, 0, 0, 0, 0, '06/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '839lB8IYb175T5umcP16ZZe7O0E3Grd44P7480640WD4D2AW0kP47311MG2Oa9910uM99778dlgKtQU2p432tvru5701e4g842h7', 77, ''),
('gooby', 'E47CE57355774E4EDA893981CB55676CF3EA520E25CC490439BA50CB44E92F027A095A2ED354697159F2EA332666C1FA69996F03F1E763B596B84B44B751D005', 14, 4004, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6Rx3kH23145e2vvlof9U9c02y4nac39qPHc48K7e2f0jc9J95o1745ajH9glb2Qi5M91kx32tK4aF869151Ic10C7YI20x8397L9', 78, ''),
('Nor15', 'A76B39F951B44B7724AF11B258BA1996CD9BBB6172CC6FC5A72F62E6C975904E75A9919FF00EFC65F03E4CCDA09282CEAF75F6274E4186A657BFA9016523E823', 23, 0, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '9G0zo6Uze6R2Qj49ZO330r6h67f79Y72srQpNVkYnx4ueX54FSB8f6Y29eMz8iKm10PqA5l26v1NqA7e5197I65H427M09kg1B83', 79, ''),
('dani', '1C74CF82DD0DCD19419A550C6FCA5681DECC2261ABABD6C7AAA06123F0D737F3FE4CE64FB38728D6A4522EF0ECCED5A1B1C8EF8295781E6C44E6E8046BC28AAC', 0, 0, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Y3E3t6lJ8KlIIu8269m58mlj4K0KYPXf269E2P6sp1bh299w2s9p0VFZYn8km4Jo9QK3sk0xU7Uv5P0U386UglFKJpH7z09N0j64', 80, ''),
('Hiddos', '9AD8CFC9DED0B0BE8CF25D2A26EEC99765618FF54847C2EBBA24C03C942C13A9FB9F5912735B8FA1F2754094C069EF19CD431FBB00D818D96BFE43C514317504', 0, 0, 4301, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'N2WoX8499yF57rmu2152zkuQh905yQ5H2Wh4RX3210b5835uJ901129PL189sOT11lgp92A70jt019ch150d1kZSS87B6fxAy5iK', 81, ''),
('Zeka_Bacelei', '079A7FB3A4305773075807F034A03F2F2DD8A7159DCD2FE5041B432D6050170520FDCD323CA298E6FB13DF74E51E5D980D6277F7A2A96AFB939A10A2DDB28EAA', 0, 0, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2bQ2Kv2Y811el69r287UQWB15047wvEvc5035IweGpgDYd1uC11vC19o1T812tb3481t3B13f6445l6u540OLt079J4wB47ah7m3', 82, ''),
('Killer_Rami', '0AD2FFEE02E5A2A814460AAC75B3B5D582CA2F5BDF2617BAB76DBFAF2B97BA13A1F51527A9451691295B981392AB93CF2C0CB4FB3BC324C1EE69E0E2E0CEC26D', 2, 47726, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '72W04bz9152J9o0zEY9vE1FW6gx65199sLrE8Gh87z1nth6A4vX5Nm919h9j9jD8aQ407Z2604354H1M32cA5i6hZ377w8v35MLg', 83, ''),
('D3xTeR', '254E8D3AF5F7A6105A022A557C998C07D135E23A0078D2EE1CF8CF91924945707B7A3AA30CD9AFE66A4304C8618F4F73CA7939D998A8A6BF9CF5ED626E0BB830', 0, 0, 6007676, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '84518VD374l1SV3b0ZqZi1Z864H37JLqwXog6WM02073k95asH3OEz2W672cI2lb5VtWxJFO65G4tOJD648Ure98M2281j8500G9', 84, ''),
('[HC]GamerX54', 'BA87CF11E3415A272B89F32D0AF2389BDED40F8CC68BB1C4079E6A5E446101100B59C1794D2A7594E9D5D2E175DC912F60666C9FD58E10D46A4B9B4B1E2DCEC3', 4, 0, 6007676, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'qK2V7Yo7Qu14U13CV314g6o3nki06cU5dQ6016UR44WFjDqX3047q8878kA638BlmA13SPqhXL17U23FV2fY6IHBzt9ElW2tzSG6', 85, ''),
('Nemi_Mili', '60F36BF03E2FEE68F3B5C9C1EA6D014325CF90DB5216C6A5DA76D76112D400A0CFA1D5929D3CB2119BA95F2D7F0A3F4BAE52840B446AF4D6E42AF7B260530488', 0, 0, 6007676, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5n8P1eo9080c92I0Z53v75yEO63r843z48jWF43NqwOTeH7k0bI02QfC96MRQ34DQ37v0R509LJ8B3hTOQ1Q82SP8y62h78nu1eq', 86, ''),
('Andrey_Pilyuhin', 'DBC11D100DDD258C2E02BDCEF843E6ACBDB5F515293A5F54AA1358B468ED407593F82AA328639423D22A5EF54CF960995E995DCFA8535FF3FA9BE71BDF997A99', 0, 6900, 6007676, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dd6h5UDNBG33H7vk9wi12Az77RxaJn73493k2LvtA6Yi050b39741r48M8V69lnh02A342H6E782rp1eTd1D8S3N1I84Ucp90l91', 87, ''),
('jhgjjhjjhjkl', 'BA16E7501E6FEACB8067503FF2DED44CF82143AB715114E09538E9A10278CBC20C2052BEEE292D11EEDA5CAF34779E9E52DB50AEB7B6CBA9BB235C03C248E8EE', 8, 21404, 6007676, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'N9R3l6u951k94Q69h1dZX8rfIF9402Ckze71I142d355p735424MOaT28M9t0r49792406828gVx78V8pB1k6L2wnxuMgn5b2Qx7', 88, ''),
('Famous', '6E394D884029BC32DB0F1745E0EDB24B07F7D8AEDEDE70D62D7B1A1B52395983C30467F57D5BE6247C0ADBAABCFB93CE0923B5D19C730493DF441ED053AAF265', 8, 30031, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6uIHL734938ep1Q029zWJ3a91196omeB5yp365KHYz21N6428s46339nQH988PoJe4aVG086rvO4drq8TzR75N57b960NWLfo6vQ', 89, ''),
('John_Steel', '98183C14590FED343A05B9D3FDA74DED51D65ABC4DF6273EF39B0456CB9E273E343C130536962FF11B6768C5F5948A8B49079496277AB6BC70909D2F00791FB7', 0, 0, 0, 0, 0, 0, 0, 0, '07/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'xxv4JOPO1GZi8Z5I55T8YWb824JD4766S9un3YX4925q5697FgUR565i25LW2j7GD09b792mp8N9DE8H6KU4esk78w2fdexRj0m5', 90, ''),
('kurva6', '41913A09F3C6FFDE4F5655B5339E7FF5C1B13808790CE50CCF94B178284E4C4EFC2A0D6534764A97B96BA598C1CF245C0F9B938BBBA2F55E70BA59AF64220C46', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '3XcbF0o6mzf6yHRo9461Q0G1BX2PeZqL4p4z3v692Ok1m06IT05D2YE46943D5bA5130XX9v09901P558c2mX69z02rh3oLpiO10', 91, ''),
('hbk', '69AC67275715DABB13A7F27A9E4D984C2AF06607264AB6630CC6E1D30BD12F12866001B2F3829A7B0816E2768CFADA7D7C51152DFB1652636C4CB7C2C407297B', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '618039PI6BoS0VrGTGtbaRP9FNs6q2v881M7s18gER6GF1U2ItJ187l2Eg3f71n3c45BZ9pi45W3VHAQgxF6109vTN02026Fc6Og', 92, ''),
('Omer', '3BA3DB2669EEE0731D5C5EF87ED8B975505CAA3BE7E13C8115FC6E3C6043B7DAC9904CE43A12F9500132A96173C89C32C2C3E89CF239C98D976A103153C96331', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'siT9guKRskV5r435J1aFbe2TIH3604uw3VujGuHi5WJ71z63e79155bU109j9r95vi9Ll1Kx41o58A83y96tA339s96ok9G1kv18', 93, ''),
('Vule', 'FC07149F8B7CB2ED5BE2B2EC897D508E1518A31287C34CD3F7082C42943085FD568DED673EAAC2E0F1D7AA5A466378C261429EA3F0AAD6B69B825044A4CC2E0A', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '68Hf640B37hzG4430929TdX65fu4L9ew5UEGDKSU6dRj990dW41C947397761G3686Lkai10B28Na3074IoSdae9bf6fA59t4o2n', 94, ''),
('Karter', 'E568AF005EAF17FB31A7B4EF1D8E84C5DDB56B16B2CE147B2729B5C5B49720E60F7790F5288F56D7E60C4AE16E3557F8DEEE9DDDF1DCABC5E5CCE0065969D37C', 1, 7813, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '96K54694U9l142a1S72ep5H3Q5mw7664a2a25r80MO48kX99KM547M56XM11f33zzekZbb98S1fG8gP8vT5yv0CH3GUP88497zPL', 95, ''),
('loirinho', '68BE805AC4F241A69481C16127F6483875A49F933B67759A4D7166A363FE9E688352BC6B22D5192E86A6BFAF9A3B8E5FD960C497B01F8577F83E0E7753E3E176', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '206B37g5plw4OZrYhn90A8Sx3OjOx98O9H8qH4CKP11Rq527x2m155jPcRKeW4VK153zi74i8aI292w8j84y7F766822EGNRBd2U', 96, ''),
('fucker', '0B1AA3BE03A82E2D203795F8B059961670A78DE0351ABFB13E574E90C7A959EC32AD8967049746C6757685FF5F759B506C3F098BE332872B327653CE05BA80A8', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5H72u7Ro67N2W3H9O722PBD7T98uh6gsV2iNO80b2011h909903CA3x135e399fHOu1I497j41Dsb965G5W8cHoZ5pyZ3j4688h2', 97, ''),
('[Si]Wench', '9008FF1D4699E62D36A19ABE3A494351E164C81E6F2CAEC94A307FCD6C1AF406A5D2B860D9913E788682F91A03A931475BAE7A979526AF8F150A2872DDE17409', 0, 0, 0, 0, 0, 0, 0, 0, '08/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'el91u4wS0t714ecl7873c330NaM29892zE8zYx4u22NS61it115980s5Thk12KH0X84868dr971X99KI59A3V05ylNr5005200cQ', 98, ''),
('Salah_Metwally', 'E44CE864E9E959E3E693CAD8B4866304CC7617B601A371A1E634BDE45DB6AFB1810A8BD5B925F80041638464EE69B88AED05844C57F131E4D5583DE859F18CA9', 1, 20524, 0, 0, 0, 0, 0, 0, '09/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'a9p2688020V253x1X56Sp3066P8A3pW8mzKfb06gFg1kW8O2uWR9MxF7QG4v51WE6Qt62225Z19tPF24392KR65E0v5QqSy092up', 99, ''),
('Luisma', '67DCAACE970F2F93EBC4828B4C7510CBD42B545353771950E14D3F036380E5FF84C744930AEFCB99D32C5702B580E5FB649A0B29ED7BA2691DF178B955468F47', 0, 0, 0, 0, 0, 0, 0, 0, '09/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'qVt606lEzCv9V89T31AYm20uu6Y27u7e20H569qA9o9a94xY3tcL93hU5r9Z77yP3a8UD96ZD2P8Y070B389FYz6J22LioWN41ax', 100, ''),
('HighC253', 'BBCD4F05DCE70A512B4CD31F3CDD931CE50DA14AC8E49EAF832FC91402B35706C0A337952F4D35994B5642C444BA403D05F041E883B48F5B0B5C90941A13450A', 0, 0, 0, 0, 0, 0, 0, 0, '09/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RQ8H5J51Z8E8LKU7r717XNfG4m6k54B6sT0F6P4mmesbX65r5Vc65aKx6l84uGR5e5029c49HRM0FAH489fc037VoWj78U3M9N79', 101, ''),
('Trevor12515', '2DF04A1F14A3099A377821596AF8CD6756443071FFF6A20AC8FFE662002AB6349A76E3C8796D4B2F333EEC47FDF2BE00037CCA7151997BFD5255E94126D6F165', 0, 0, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'fdi53FWuOlg19eEIl6n0oWg2mmIA6EGUSw2d3h587p051J22J9P9DJ4L137bun42g0xn05yRs5ecp40X2Vnf077678WrHNYiMD78', 102, ''),
('cokedragon', 'B4C51CAD777EDD1FCC93C4F53EF399CE2ECECA424C2AA7E4F4CCE53E35882786F409315B85D7E0BFBF2EC99357521751966322B81309D8C42A9EAFB610F88779', 0, 0, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '36tQ87HTr848C45e64k3037Z9o5RDld1821iOZ29II8t0l16k9Cz4Vk2Ixmpa06AE0O08m2E7939DqV590gO269821Qa9R185zkb', 103, ''),
('imacunt', '0A448081A1E7DDEAAD3CC3030F257C88085221C0A91B3B34A18D1ADF0984CFE689BCA6BA0535E1D36B1ECD8B6297F8CE978F493242441DAB9AD35DC9D372E113', 0, 2324343, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'S344ny59qWWZQ9777R5Zk5xPB0ie4S35F1X76g65935ak2FT32716V69014f54Jxo9G8XWjmp8GR0Sb9K647OE6p7147785946Dv', 104, ''),
('GilbertoReach20', '566466E18D829E747A332EFDC0AEDAB17AEF492E5A2420223D7C4F3BE65F1CEF91E551A778839D3943E9F9C54DCA33687CE5D40766F5295589B16B23A04A138A', 0, 0, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'h23J6H0o2mm514U819JYOVJ691N8N46TZ672HH9Q104137485lrlx9eq0ib998V46142pyD881Mkof3Z9R294O25203T5G1537KK', 105, ''),
('andrei', '6066E5D1B5D9D88E20D88EE9E2F32C25E513E51AF2EA7BBE59448A6616F94EA7BF4D8F0ACCE95B4A4CC33F599AC247246D3EAB070DD655BAAD11D0EE5DA91E0E', 0, 0, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gp9B63b1438jV01349V181gj26e48UY44j1B49Xx03N2Ds6b8vO27oySMQffsVd1Q69GO25gE0h15u75pS5klS33A1JT266U6sg9', 106, ''),
('dicks', '31FDD051249C88F3DF0B982BBA699B597DCACAD92F4C437EC5CE3D069ADFD14D5BDA2ED8BAC34FBE3519BC16581251B07822D5F55ADC5B1A3185FE521C3B5303', 0, 999999799, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0CcVH70j0bm6u6r19Js6F91G36d7765T5547N8AUkJ871hq1cx2POp48W6hjidt17diA2Emm3U847q279973gs55p0gZ088Q99Zb', 107, ''),
('Dean_Jackson', '69FAF83775204C151CF27B055F280827777E3FF9D131ABC123053EF217A3D731FCC4EC3AB3EA2DFEA86A784741893194FF643FACB45B32CAC2B04E636A6834C2', 0, 0, 0, 0, 0, 0, 0, 0, '10/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '287qKOAjW8016Kvnjc5DU0t5c0xl8kiGz653iC0EfKm72202sgmib27y325u9A6ZIYuYEPqYMTX40fVy3a8UFJ7555581mN11aR1', 108, ''),
('antoniox5', '47634580260DDBB3D1EB27BFEDA153BE58A2C19E530CD9CC411A0E0DBF7A7FE1B7F5B25BD89C1847F83267EE549F0A419350A5009183F73CFC22E06E1EDA0E5B', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '74XOlw75X1Pxe7836H4HEm6ng7A10Bkt360eG586r89b8hVt89118ohe36Bo05pYa9c3v0gM9j7ra89v2P70aVgIHJ5vjL9t369K', 109, ''),
('YENDITO', 'BE1BF55EA37D2FD98D3353761C416C51A9E6C8CB07AC7EA636AA27A1041138AEC7A4BA2672BCF04982A5C4E564D02B57AE3A25BCC354382D4EC2C10074BB548E', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'hQjzJ566s120b16lch4O4H0819irYOF26i6T318511Y15o08bWSfzHpbW3g63290E965oYDc6g1Nk435Z8i5396b36R9RR7E1w4U', 110, ''),
('Kaua', 'E88C03FD195AD181B14A3E4656B1988E95574CBFFCC93759C2AC9B30393DE892A9E8B4A6F5E4CEFDD251ECD736B42C097498825646826FB3BD526DB2DA0043AC', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '51x3gJ72e7r9S9672Y1YBb9YdN5261Jx7Q30b85102I9r387o9wp3861Y5lPENr1N7tS45RAw155P583312uci42VpE2d505AmJX', 111, ''),
('swagger', '293B127C6E3AB7D0FC54C2BE4BE90953D639007F82E7A67D44062F02FCA6BF676E3596D15C409667692F6636FC955C5C2BB1B24E0E4A964FF5425A09B9DDE81C', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '87h7761Aeyhsnq9K8262Vf5tl60u50QX8x46E75CU49Q144irRs0rb0hAf8P0O594zJ5nY1144473A3Tq6p4o7k778M58zZX46j9', 112, ''),
('Kirill_PaliOnOv', 'DC7FB8520C57F38A59F4D032B5D950F6BF55F3EEB1B3B96ECBE8A106B1BB506C7757F3B7F52CFB8C073290753B201AD110763FA0006A08EAA774AAB8FD77909A', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '692290012W6bqkN811w2x013121507e3D9D54Q3l989Jgq093jTF1FFH49zNhtj6C72t3h936oghb580TZ5J8T9rXo94a4zi8H8m', 113, ''),
('rafiwidi2404', '40F6E78FDF5759BB55E91DEBB64D378E465FF72882C608D9BE8883086C1F18183F319EDCEA25CCA1FAC17ECE50FA2150F78D4056E2BEE38E04319BF3337D440F', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'hp76bX436150C62S5wP49Mo6KC4A13343sma7664Ftva44M82A7r3276bPb7h0p2240X11A3WGR0ch693w4j929LsSI4vtKt7N0W', 114, ''),
('Chopper', '2BE76856FD288889D0BC5C26D5BD90ED25FEB5F95906203E6A861B42923B82F22E85FBCC96AAE25E911F86A9B7036D0ECB57DC23E37CDBC3AA077CFBF7073F1F', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'oG1n31236723OzoOwuX06Zx46Jlw480l7gWB68c9uvv3HC195iAQ9K6I86H11c6473o9STmj4F2irfl035UU77QxGC3382NpX7n1', 115, ''),
('John_Bezz', 'F76DE815D38206CD8FBEFAB3116A8EAECE83BFD7887FF79A16EFE6628296B9EC783F072527F2B0249E32BD8DD04075374180E6D0743D6D447848A620F1D40E9F', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'uPb5377R33991z6lO0njx10Lc37423yoX90o165D0iu6L3R6457R8163vJwGn584s0wbg869donNr1nKdKcT9d16D0ln81xad69X', 116, ''),
('[NSC]FarCry', 'B30B14F9E3CB90B99433E5408F7AC7B1C3C040CE051D9FD5BD96677D3C3E6E56249F8A53A112AA9C239250E5A775D9DCE2C8EEB6310257DAC6701D96E77C8311', 1, 35276, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7716yG51776nhkEjYK8j812jvjy3365o6a202j9GF727y7Io4dr570670WeA62zY1FQ0n8L82uYCP54V63d1AY8128m42p88o3Bd', 117, ''),
('valentin', 'DA528AC5E1E55C8F1ACAB578F83929437CA19B71004C02724A5FCB2032CC5E464E926B7A4783DD1E0B5621F3FDCD1AC9784F932E098807202788688E359FDD44', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ka75mZPg48Y7e6j2ry9B77e5565gfL1uzl0Io1Q33wl50zO8aJ403553Os18G9MG08b45w2xX2z699E118T05dqYA43T296t0sOx', 118, ''),
('giorgi', '3C2D6DBCC2B138030536F11A187F607913A6A06B3B0961454C945251A0372A5F0A877A8E062AB1CCE31B96F664F4D58EF424774C23B6A5B0A5F53EB96B803A87', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'TkW7d40j5LcC1i5339U29X621U89ug1H8o22Ij3U586DV77q3902GXC27w1D4G98t5Mtj8e1614Hd5kP09523y0hhdqh1W1m4433', 119, ''),
('anri', 'AD55107C40EB94267B0E29E40A3DAD4B33B1381B8E22D2C6F9E397B4B24B48637711C0F1AC2C828282C07BCCF319FDD3A19FCF88F8FE4CE2B67AD8C9865441AA', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sh4F7v4nn86eZ41e9A5K3Ag437d081r6i13Q2de2Uva2X8Ad43NQ596h0b23b99C90wfUfHHmEdf0ywX76VMX4h4K69aMh2oGi90', 120, ''),
('Rafael_Guetter', 'C482878AD4AFA4E6D315B5384EDD79262186ADC4170DEA2AEB3277087923DD0073875A3D0BB1913D08317D6EE0EB7B760E0218C42E234DE17EE51F21CE98E008', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7G0F6ah3pf811k2s5n4ZRZGf4iy8Ds7IY5ks2tA9Sj9V2Q786GojDALbZ3d43X8v480y9DB97x8466VTx85AIvHGIh8w136B8E9g', 121, ''),
('Owen_Navarro', '77508AEB276C698D64CE9CF908C8225C25CE620E9F67FE20F277BE77F05BC85A9C52CB5AD9FF9F1A1D30944A375628C6014D0DB294AE76B89C375B7AD7C82BD3', 0, 0, 0, 0, 0, 0, 0, 0, '11/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'eZF0M5MsJ2cs2ooozPFLCB2870N99U9q3Jx4B2F83B183y2S04riX84Q9575W0c052Fz6x068I97tXh8Q47B0i13Ev08unhb92Yf', 122, ''),
('Aldrin', '587CF8F5F2FE69E2E67DCFB26E57C3D1B216EEE0C16FEEB7B6E9BF378CD1219C2F4E71C94F12A39A1D3E736CE6D6FF57DA12DC422620AE42389F30381CC8E314', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'D58PU6z0k3w8aO30520CfN61R08X9Qo7hhYVnI23SQePx57428C64U2V5G4wg2NOpr85B1Pu7O267yz28xA786B10Qdj4Jnr76cD', 123, ''),
('Shadowman83', '35782509222234F7A82013C568DAF8D3B71F33C0146FE30577CC186A1C06605FBA7D948C8579737088F590D61C3B12E4F861DCC578B60C666264742DA41AF5A4', 0, 0, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sr98300NE8c7Th33rgBx7M95Yw656e05i7t9p978uiq3I1F64n62Dh0XCkWX5l7oK2fam1fr56VFg1O06GH97Z2fLc0k61K7CRk4', 124, ''),
('Gaby.', 'BAEC04964785307B98D621031E3535F2265B652F656A23BF04A250558C5DCA1FF8A420D83293C34EFB7751CE6A7B55CBF25FE02F101D695E055D0F2648436687', 0, 0, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'e6G727BCozKm5MMco598370G390P51641277m3N2Gk1cj5fy28bjzj0za3C0916v953s9PQZnf3MC28Ehr4V7Oe8o263OTaO73b6', 125, ''),
('Gaby', '49362C30A5BE4B9083B8B9FF856E1E4390D679DFBAFB5219A42A65F276C60D3782B8C2FD22FEF5D50DA1C4ADEDC473C0C93092FEF7B3A44FB4BBD4A83598DE3E', 0, 0, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '005S1UM1P1O3LG7700t9EjE971868157SR260661y475tJJ0523gcM43v3a59174WXGd55SZh5r0qg5ijiay8452fU38j5I7B76e', 126, ''),
('linuxthefish', '761CA24EDB134CDBBB412E3E4821F141D45FF2E0DAD18702D7DDEDF623CE5AD30ECB42F3540332A40D0861885BEF5CEC658B3C6DD80F1D27203A2A72327240B5', 0, 0, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'T045if761OjT6v3CR98Z391YD2nuVy626Ql98MXqk950Gx42u1aH6U7292C4205fw0Uc07c1MN97hg1C4vs93p99tk512M68V3Io', 127, ''),
('WolverineX', 'CA8D8080DD4E0365038628FB5559AA429ED25F4408A33C9AE9788E2C3929FE1916417BBD944AB1A4952F7339C184CE0B024B0A623FEA664A6CE0246CE0C872A1', 0, 0, 0, 0, 0, 0, 0, 0, '12/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'fTHz422QF3ok679p8dYoH8Fp5R7SF2wVB520548C9ZvX4xdHf78aMwuB82CVF80x8ODwr4e8x38ib37a0F90gXdDjKKr0o812g91', 128, ''),
('[X]4Life', 'ED731026CC3D1A5549A2308569A36C9C919CA8896ABB7E08E15A35D7931F7067E139602051BC670EC6A04647A0B4FCA889CACDBBD7DB99049A0F333178D9C515', 0, 0, 0, 0, 0, 0, 0, 0, '13/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '72951IA0Q659Ai4FXV0ZrZ33hIB9WUm89Xp097Pk8L3CRa9o989d4pu4i8vUgiSy78g7wxdVd0Tbh7o67R87A9073y93YgH7kLdN', 129, ''),
('[X]Rip', '9228F610C43B8450EB7BA300A536E509F07B6C285FEC27CA41A9AD584316334D064698CA487FA782E421D704AEDC4A1C3B09C0BCF5DB7C8602ACCCA785E150F0', 4, 974720136, 21000000, 0, 0, 0, 0, 0, '13/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8Lyb945vXuMI13C4k303637nran7U01qNSgVyQa65A5cxa4ut566TgW947H5R9Nqv6I6V0BTh7Z362DWDYc50315LnvRU7p9J464', 130, ''),
('4Life', '1A26202960A51815EEE8501A4B3BA299AF3A859528295DA2AF75972F3F485C16EFB5117C5D5260EADE8EAEFE382C15C4894A783273C24B07C3A894B717A8FAAE', 0, 420000, 0, 0, 0, 0, 0, 0, '13/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A769K43or7j8V4m38JG57x58LAj2YryJ9Q70oCRE18L0Ib5lXUNg752LO79WLz87j85m61gbU4kudK454BgS102t927k4s14F9iQ', 131, ''),
('TURBO', '97250C979C7D5E566B89F7C36631F0048008EF9BF157CE1519BFF4B0C9CA7123CB521AB2DCE05B094EDFCA2324005BAD712DD64B5DEB7B12F57868A74C478407', 0, 2999900, 0, 0, 0, 0, 0, 0, '13/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '25DgCP98e540uuXykSF2183134LHa1C9WU7n941J1mirI14M5S6498UAD90yC2Z42Y76b4858c5Y28b3C3ZFu84231143REpF079', 132, '');
INSERT INTO `users` (`username`, `password`, `score`, `money`, `bank`, `stat`, `army`, `swat`, `admin`, `cop`, `regdate`, `prison`, `vip`, `arrest`, `surender`, `rob`, `rape`, `heal`, `hitman`, `sales`, `wep`, `drug`, `taze`, `truck`, `cookies`, `STD`, `prisontime`, `mayor`, `teroist`, `fix`, `kidnapper`, `pedo`, `taxi`, `pilot`, `pizza`, `farmer`, `miner`, `salt`, `id`, `ip`) VALUES
('.EXE', 'DF43B6C9F9AC8EABE02CE28F57BE128A46070EC6CBD18553DF079F968AEFF8A5A391FE8807DEB2160B8AB372578BB96704429423B5F6D9A58EDA7194C844B74B', 0, 0, 0, 0, 0, 0, 0, 0, '14/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'rh0u675Hh3fIa79lSY502z6j43C319wK5Z2rJ5V08jpAPP5xz541H291nM30Dgr0x0eiaw20Zi7j7b5E31df790JfG06462nVm2v', 133, ''),
('[X]Rep', '6023628245E3196F5DFB630CC7661502C8319733ACE37938692480A8671EA60FB928955D6EB35D10F24BF8A3F8F0ACD33578B62B776F791B91A91E397FCE04B5', 0, 868723, 0, 0, 0, 0, 0, 0, '14/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7o9XNd56QX1zFT581c028GD75POpU87f22d5163030h4sOc69Z9564td9699S16S3WUC9Vnv64M5O0V5SD4611u3neH3wka1V0bK', 134, ''),
('Amer_Suljic', 'BBC371B82164EC37D8B486501F756D2B498886020644B664004623F07A94C9B42C407550A3DAD86054F10B8B54A135FB44AA26D39F520061626C782F404AFFA3', 0, 0, 21000000, 0, 0, 0, 0, 0, '14/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '773kp548OdaATl76966405l35D8124P699D9ESxPa0gwr7KR7c03E4W61fhD48ri4eYQv7ddpN64361V0Ja44A7kqqj6h13634lo', 135, ''),
('cachy_filadelfi', 'D2CD0963B35D0CE54FA66F9A024B0EFC8E4F7D3DD2B83AAEF4324391CDD945425A19C437AEA18F8FF8DF11206684A057C616B06AF9A219AC5A4B73C37D640BD4', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'rHi2071th5m047dCz414WIoCQ68pX47v30kR2MK0oq4790IZLY8847K8757L85uP1j035Q93MfrE3Bah7915F65xU511t83tsShg', 136, ''),
('riho', 'BE424FD5A813DB65A8EECE1A95C4165DAAFBDD3A2A771081DE5CBC6F490B8874039AEA2FFA710459EDA5CCB10A8AB79A3996FF0335605F6579AF3CFB009D64FA', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'u4Y4g570s70N2RRwTf73p07DlLiKA33ICi02I8LyIt056HX5q903d93aBPcJ2r2V2e91H3382ppkMYx961495I2o01Fr12KO2V68', 137, ''),
('ventum', 'BD29A58AA09CE3D034A10539B322F31356498690BD696A9FF8AF8BEC668B1EF091661F8FA55904A305B49F30C4CF4FD28C8D90875FE2F3CDAA851CBCB2F9F881', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'zZsh5I8RJj14r1U4g4353am61515o711j2g86U4KB3eH67lkSYq339e139b090D974GrTxlcLJ3QCI7aZ7gXRg5FAJi175ej0j22', 138, ''),
('aioaio', '2BBD4F2BE85A39EBA1F719C389E0DEAA56974A7E43E1B1A0BECCEDB2FD96F14FB2285DED17ADCCA20C9AE315510B57CAFCF42486AFC62100552E9D269A7DB99B', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'eoi5Z7F5l2u03314Xn3O0g660Ps5ac5xp3H78697UCKQ72Y88D538c1B0820368HniR7tWG2bn11LP69kYQGejX45ShDt343r664', 139, ''),
('openTTD', 'B221CD8FAABE8ACF64013730B11CE9EEE4416ACC7A2996C55D4E4F4AB434E7F5934FAA52D05C2D5EEBCDB0C332F326700E79D56A5232E0D4830B1C9A1521F744', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'q016EzK5699c3n5r93Ib2d6O238o8i13M847249s67C40496Rv68U90YFH204EHXii7L967i2X4E1qGGv4Swg1D817NM9l1jt67r', 140, ''),
('SuperCyberPT', '3C78A15C8845A9F5992EAF7B5D02FA8E03E34D943DE1BCADF99B64BD278C62F31270C1D9865FF06ACD22788085BB454AA35783C6B56C7FAFC8E2C559F510ABEB', 0, 0, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'nJ6gx2756194c7ml814whCE1x09f0n540hp3uy9r7e4D9VyXoW1MjOlslTF7930r7Cw14f407jWHp1I6O7wk58b8CJMHW2786N07', 141, ''),
('Lil_$ainT', '3826920AF3D22F2ED7DD6B8D26457E1823149089EAD47ED162D68C31EF8D953CA9277B8A8C41B5C561D1131969A865355A7C5A7DE0FFC72D9B9B432EBFFB1F62', 1, 11237, 0, 0, 0, 0, 0, 0, '15/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '697j1LR46mXUc7wUhJ43JW196m7eZT125ZOvG82Rmx457P687703080H58Vh0k3o5ihg71J52ysH96Lmo9eZn88WAwO96A34Q705', 142, ''),
('Boki123', '3CB386D84A1CA33C121DAAFAC26E10E09E6DFD1BD9CE89F90DCB094E7DB46997B5C3E23D3170F168CC8C8C249F2E1B01336E545CBEA7979BC7C8C8214A4CE51F', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7G5b93VD87y8e68VLSUg4ne733H7425hN64c73c1FZ5mN0YsT80272X8mC0L8807L14p49rlk8x52P5a71N6g140tfZz7vH28c5c', 143, ''),
('lat', 'C65AF729CB81BEE3B2C3CA557472AE20B863EE0B328621BC8C363B57397502EE3E3CC7DDE302B38A9A0965BE9A26E512EF8A7FA68AD500BD55A696BA76FFF03E', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '1H7T86O1YGea361C9h5ZUS6MPlw5638746aq17s645X2405Rjc7l13Ir6x23G7NcNa7x1psYtZ422p3SHom82r62F98yHlLX6C63', 144, ''),
('Mustafa', '9B48D6AD368531A2BCA45A84AD5BEACD01E4A6B9DD427CAA1F5E8054F0AFA367FFCB9CCA2CB4C9989A9ED8529FDD44999ED2A8E29034B0A549DB22FDF999A5AF', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '44cv4Z6xZfX8y1H38LaH4G24nF61ee58875719sd4NMT3j2v4996w18kLAA5BJSRQ968IY3JT8ZY74weCoTd24S1N064CKO1sUx8', 145, ''),
('Guffy', 'B38D19EC6C0BF2CF46DDC68D7F385DB7C96988C7F7EEA87837DAD8C7436628684D46777FD2F1D521EDBAC35F18A82B9287A69E423F240B59357153200A29FE8F', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Z5103X555n3066h8WR90tN7X96VTB4562852u64DETAiwIM16A8513H8v7K7m2R08Xw112877z52E1F1hh51lh37R533jR10723j', 146, ''),
('samp', '3ED54712531D695A02C19D26E7BD8BBC5A1420D3B402C18FFF4080FF65A4597D0E256922DADA653D81FC4F43B5BE750A3BFA4F869B540D434CE733FE90C30AED', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'h06X604y0l7BJ5iC3Y048n825e0KFIw0UCX765F6bQHOWm7cu676iUEyew92g0vlG4bU9f88f534gq5nlKJ0BO3320k2F7dxsdq0', 147, ''),
('Flori', '46E4F3CD827B23C48BBB718F28A8FF529240ACE67DBC055BF3B5C0DD8D6835E009C21420E3E6AEF4A69B3E26A36F70D7C75229E5A06FAAAAEF85E34BEC9C3740', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '681036w2o3y3VoL4kI067tI4l82zH15c2U9e6526K536cG08QPoma2390JqSq53o8M89lma6dQzg2I78740J8c0Z488wNL703uA1', 148, ''),
('junex', 'DBF2BAC0DBC6660B2B5A30351596943A5DCAE5B3368C4203518D1381663F5BC95414DF4156552AC0231150A21077870F650E2404BFB69E547CA0D76CBAA93966', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'kt1b70693S977R49ll09YBwC5S5aoeN7e1f2aLvQ006n0cWlU8gN69f7og3h53wR6iQ8z944ZI6615l8AAXb1X17NP9949or33ky', 149, ''),
('roman1', 'E8E178BD8229B2CBFCB5C1C872D7F795BF155F3E341807B25248E5E83F1E9C112F2057CBE41C1061EB87CA63DF8C1CD445E2070EA5F840E3B0F57BD726C7C399', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'TA90xyTKb6rI6t79ch86w6l4oV07Na55R24T7ZLp4S6122p9Y3JA4147n7z4887EOE1H6FT89rQr13Oih0DN0o3E56X62495oOqe', 150, ''),
('abdou', '08F1FA23F558BD1F5B5B9A838F08316F7022CBCD5E77A2E81D7F64BB7117EBF4A9AD4A39634E126EB73714908FB89CB0F83C295CA65732EE77C53675A2CCAAE3', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'he3xx6669h354418fSNfb5N3O9p45Bow4344xF1C41U35j81G555O9b19SLt36RlQ3IY25rQq6049927240ql8Ux259h2i2gm60Z', 151, ''),
('patricksdmike', 'D63CC072B2C72D5AFEDC2B417FFC27A7200734841C4E185F3A62FEE486D463787EA869EE88A7D25FF99BADA1B054A3E83F69B4384F84C1FB71E5A0F77C00D00A', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Oe70V9vT0D4MA6I159NYnh31ln9AE443r4kUsGpu51611USB2mV4qWn5V2sUAP1350rmI0zw8098150yianzf100UTTOJ6ldnWEi', 152, ''),
('052dd', '48A78EF5D8D31D7B47484768664876D39782FE50C27F551E70BE102D66E12E2E0658FA374E9513184FA39C13B6ABA228C0CAF563B61BDD28233DE15345767A39', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8k6m7tXK6l6O2Yj17e3O2k3SW2f11eB58O8460129Fp104P5E71945Gj1fO6467sj7RTL8T99q982jUG344DBn99f2O23W5i318m', 153, ''),
('Tinca_Capone', '3357A9911B6B4A7B62E257FC5A0E2BD178B855C061B1CD290B5C797A43E1CCC0FBE0BEC67AEDA6506E7B6429ADA65A72F641403D42799F6234D8A1A85016F1A9', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SY7p36YvE04926w1Cf388zxu3fS1dFS0T1cY87468Td65V8J3b2QVF5y1NIp3bR465YbLg0tA4khMJI533t0h21220A4QO1Zd781', 154, ''),
('zlodei_rylit', 'E859D2EECFBEF6D9A46BE0B2B2AD2CA2D9A462526FF59EB2C8FB19FFAC0A9F9E960275E34E8D858B11759404A5F9580544928D8D9DE07C62296AF11194FF169B', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6z7JONkoEU9x404tFY276I9PE8791EQ6oAV87U17O2LOK1y6P5h3b5656fbZ6AM59L95e4s5Ct0X4XwVWUU2301043Ro5j84544F', 155, ''),
('batuhan48', '8AE5C808D68EA581A2D9CBC23C0C00639829CA338E70A0B364E644064340CB010A03415520893087361946548D635ABFAF80480037A22C6306FE52C0A5BDB511', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'g89X43h64wml53962j0959SO6B0feK02Fab3551kDo5pqUDwHlM97DRR37f96l9Eg73B3C6k00K9F767A880c691Q9X7V30vc2n0', 156, ''),
('Ton', 'DA362094BF833C7FF6FA9B21985BCFC4D25648AD1542B3242342FBFA5A7F5CDBBD125C0C16592249093CF72D3FE671AAC88A77489F7E8F20C014956153E68193', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6jeM7uh8w033bi25h82ybuXz1BqadysZ5W23A3a198mjkM1Ud1769vy3Kv6XaC9DPhA4U659YJraW38C62g74n62Rb5fUTSL670h', 157, ''),
('Riki_Ball', '65F1BBFA6656A7005F30D2E5FF57F231518843725908C8AB684A757F7BDFB13E5B63AAC3A143BD5ECF64A469556FD7AA220C0D4DBB19CAB444E812CAC3217D63', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0CUsW826tA27l42IB2U3L9UH1231W5K75kw1e9I7J1hZfJ8f21R3p5nvotu8Dw1ohV812l6Kw98jYTX6FH7qDB0DHN44X32x951i', 158, ''),
('Van_Dam', '7ADBEC7CC2A63A0F8027B888D44AD72373C6456CF3D5D3114F3D65D7AFCEBFC2FD6EFFADEA802BB426ACA10F9B48FF356D1C5A690D653AF8F62A19034D4B7C4D', 0, 0, 21000000, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '819NprAKo5W1T9XE5Z05tboQCGwc6ksFF4X3DNSt4tdn5196SZ4whfV27y8542x04587ups4r0k696986F5J5cHfipjfn18024MD', 159, ''),
('Chris_Lambert', 'CD76B6E6E64D09EAC3A51157E945A3DEC4407FEC679F8598A52456E1A0665FB086681473F0D32E7605B9F1EA2D426B44D47FFCE100450FB246EE9D909959FE20', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '39v59N736f0k6G59Llmp4582XTTeRs01OSA1A73TBP48SSbD37108Nq97g4rKO54IKC2ORdhRp522H87cTBst0Cf4u0Tp11Nk8o3', 160, ''),
('ElanUser', '1244D6A04CBE8520FA1D875A0799F43A22B5DEEE79E3A802B3B24E252BFCE0846E463484700095A0EB599CC58125B204CF8D18843EF7AB5A236110197A4D8689', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ufo4tIY7a6BLe0iOvra6r223r0Q3488vA591qB534H9FE30ss62E80yS676180402x77uQc52G7G7t9W17U0HDcd81ySFw045Is7', 161, ''),
('paco123', '6DB1DC55370107124D8E791613D13549E0AFD65E15140A5CC403BF8EB4DD62003CBBD3278287482822EBD0E9993409DCA353464AAB5FB11B3363527CEDDFB577', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'g7dd5Tu06gR969zL9476eo678V259s201xR9Vyw7C91999zE12zME1h4w3ZSZ855O89XO0TzEd30449eQ5759x9FVZ2OO23c8K5l', 162, ''),
('XxxgustavoxxX', 'C3C21FA40E3B2DED67056392E2C17049DB19F8B7ADD53E879ABBE83FD1316F9ABE990C59F66CE88465517995EAF4684740A219B5056EED04E99A6F79325EE177', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '423fh66jXCgR7865Dqx28odd49Z33M9g81Zw6KG5ElFciUn4lqvy59W1y3nV01ymY86pnD73G1Pu8yY797z65Q0I6M309V3nzG46', 163, ''),
('manuel2000', '60F950E24664695A0F3A961E9A557CB0D6E45DBE9EB0ABE90872C056E8DED39108ECB82B998B93318D9CA3CEFF4B415580D1BD62EDFFC2F6ED9BE2D99386F98E', 0, 0, 0, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'v56GTtJ94exBvB2hl53n586526nR9K14n7284n5j8orAwrr169B491s7u244NjU62134F3B1l12T8kX66tqRV4z8E60a111jy6k9', 164, ''),
('PABLO', 'D7DC08F153CF7414D4A166F15809056CF36F29DAF4424642074CB54005C0391DF2668A236E58B04886AEB2642BF4D1F1A9765C047E2AADC023207A1C0A86722F', 0, 0, 100, 0, 0, 0, 0, 0, '16/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Y1MxQ70e59A1cvVl0004g31O9o0K48SE937EqZ78J4c357rT26L3I4rl4W12EI385l778l8s38r8jXMK6953d415a79457j4hH0c', 165, ''),
('Davor_Risteski', 'C30CF471F7D5265AE67DFF85AC7C231875F3C8BA592DF0ECBBDBFF9957153134E5C64339E21929EF5410CD0E8D1B094E077D40764B7A8F054A6AB6D5A7ABBF4D', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'k3KP537P7Deh4w4gg9q70N2X183LF9Ae40uCJNxX3UsMn26XXENDjy00SLEjm0u1G9Nv8511KS800fmk2cM4De0k1Q6pIf9Xzb61', 166, ''),
('Davor_Risteskii', '0D54D43BAA5C728E7D371E638F426983E182FFCD91A2F0744480CA7F138EC47EE74CE6779872573B70C90A20F94F8E87A2730163E4587133E55376235C935C60', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'iiNDnKBY072rV1YM9clUCF12Ea4373EpP08Jlx0JXd4NjoPU1S1rEpY49Ug82mIF4228Hrz8544Q331167Ny1R101J6c3T2OD9X5', 167, ''),
('Mike_Crown', '9468B5A4DF13B8AF65BA99F9DA14BEAC9B666640682B98D7A3B5486108C169F9305A94E437A57DA9FE46A727FE7218919186344F4DF83BA466F3301855064858', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'P86Q9seT783L322261ZNK74iCoB1I4wy802HlKZ2IoiW3408Gf96T92Oi20Py6tVy29047Y9Re8a240465Z4BIai2X4U8mK80966', 168, ''),
('Ionutz11', '32DAB6AB386503447F5E0680A5B2D1794E5EC9FA41A2C4FCE75277472466D937E457648DF755640934212DCDEF99D836AF216E14C86138AB00E64917CE8E3E05', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'FB4993ght0115233s9hb96d35of7T6mNm37a6I643Q2p4cc66992b241DJh42K874RY4u8t6W7W8I053sUNCZ694N80Enp98540L', 169, ''),
('jaka', 'C149D5123F1BE0D615279D66798D9E41E6F03E67ABF624336C266C98C4C2FE3E541DDA9595A3F1E4A8543F06EE3E9F70D5873739597BD9E9C35F2F133203494A', 0, 0, 100, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4egK362HV616245u8Qfl96B01292871R04g757cplNd9788hE2J8UJm5Sfv0IH7iCyvzfuPaM1NT275669XE7VOuEO1U0Zp7775m', 170, ''),
('StoicaFlorin', '3E3E2146EEB3A6C1F2B54A34F7F95B05E870B8F883B6D5B2DADD1C715E5DC1DFDBD928B752CD0B5CC31B048E4C57FE888A53D5E0ADA6F16AA4950C314ACA77A6', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '881Tuz562cif1tF8uIOHDsEa2Y0444LQWGo86195K9lkH4L98G50l09Qz3H407i72t3t91b5y7o54E6F85vhm2b60374Hz33m0UD', 171, ''),
('Free_Dom', 'E95137A533B000753CEEAA28DCB8C1B7C62DB8E89F76F85174724B4EACAD4FE74035E08947F751B90978302AB13F379E5505965162BCD4EF55B82747E29B5CC5', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'G9kz1lt8a1apN00ykz7ntx1sf5C3575308Sme8A84j6B8C1qJcG6S34Oz4Uv5258U71vQ5u6ZmWII374E9z22D6aG00I10c68I91', 172, ''),
('Davor_Kusata', '900D570619C41A96FFBF63B38B2869376E42C63C3FE643A03353ED194AEF27A4DF0126421202BD100B360EA6CD62C21D083EE5FA9420AE8063E7FA1D50FF12EF', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'r14155w9k2q8e66Z6b87h29Gd6w2ymM27j46HEUui3v61O88ZV0432Q4k80EfE945gRs375gu9V310gdQJ5hL8Fb09T125kf224o', 173, ''),
('sohang', 'C44D134E08D3B199260E7AC5478584838DD9A4AD92AAB96CA59995DA731F44661C7F4335E84627BE66853CBB44BE501112E923BE0E1AF72C8BEBE275DAF8EFC7', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '02JN77658H39C5Zb3n79R2Z47N7k9eMn7J64RFB85ct3d58H46uGJm5F4XaYId467q513Q6kbGWTu38305H793Us6C9Ac2B6734z', 174, ''),
('Latif_Arnaut', '6521CD2505771E9199EA3A62B7BB8AB322E80CD64AAE72C9B7CCD55194BCD7A33C07875B2606356E849B7EFFB1DDD5C878C76DD8539C79B8435F0D6BBDFF0392', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2mi6u59681FjKi31R1qJz9E5Le80AvSrPWy661F9T80P74n35C7i4Hu58HLK44hlio22rC9zoI740436j3m6l50c996F839dDD06', 175, ''),
('Elvis_Dzaferovic', '971AB9D61265F1AF2928B1E664387C18D45B5B3B79A72849EFD814570736680F0514D3044E39C904BA375869520D12F529B4B359033D6B044ABE7103C3BEA270', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '73v2671QAb3a53k30Rzvr36Ta1rPV88OW5042X1CVV4L23n2251sN7o658mnM27zY5uniw8S4I996s7g0w478Ishl4qz01IE7I47', 176, ''),
('jean', '74D9DD96EADB4F0299F36D817BA849332017F1CA65E869B84D346BC120C28DF9EB17DD967A011CD1538FD10B25862D6579ABFF79F6350EC1CBBC560ADA0CFD06', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'J1a6559407565Zxy52488f076iZx19bVFKTGQPlUz7A993529g649432Qs76IC476P6o428N8713lk272vy110L810Dl35Wp7i53', 177, ''),
('negro', '04732D95D5A515A1A854A9446A16EE14916BC84C9C90060BB5D18C2DB5EA1CDDF02D022D6099E509DA53D4CA89BAD4ADA937E6D252F3426B066B90D66962B3B1', 0, 0, 0, 0, 0, 0, 0, 0, '17/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '096E0EUNIo7s25a3vW2j1044kVQ7R2877DQ733qIrdxgU7I9HJl041l005Tg351983Z167w5p9j45a55Q7p8aJ8y74fpd236ql68', 178, ''),
('lucas', 'A9EB9A673809BC048B823DCBFBF2B6287C6E602341E0FE2098AE94DADB51197C7E3E08A16AB85C6EA322B63E64A389632A99771B6072A0D32FCC9C3A06DA853A', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'e7R25A87782yw03m8r09b6sz3c95En57VX8748tv7t936Z5cP0dOG8846B5Drg2p3T70sU38ja7ZpJ033JlR5C7v1PRmdxst78QA', 179, ''),
('EliteKillerX', 'CDDC044B334AD90CE531ECD8AB316B0B26F84C023303BD2B6061A50DE40B2610D5D7BE9965253E10056FCB6F1CFB24C8899515FB0E63C783532E26CFE555092D', 0, 160000, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'wawwq2iA729nO88WIF6kd5JeM6eu3t5Z383iMhdX19993b6r1926cv63561C26Av4n7v0115i0tJ5u15e80Y6lS9nT9kc6221868', 180, ''),
('julian', '79F92FEA2F54F037E5DCDA0C1630FDB3B136DD98CA69E2783A8D93002C9C36E80425DCCFD9DB845AF92E3114A5E69E359D390B4DF5E4AD0F35E23638A3DB690B', 0, 0, 100, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6041vb8K376u770m715aGh5b0rGkIdDn7O0sX75b9PNb8D5kC0rmO903DI109Lx88U3y5MDM2mI8d84DPWx2I656n97s48w3f731', 181, ''),
('thegamerpro', 'A5E03AAAA8FDE75537C595578DA8B61C746D73948A47185896BA6CF960E242EA5BEB591212744A665DD594A8F596708101AFF0DF7C0D9A34DAD89F509D3EF599', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '9PV539Dl25583nsYHNOj84D531094z9KX1hFo2H8WhkOT1R5BC3Q4905bMf29ic36G87udB7Rlf2Q121ZkRHH1T6O40J2BR13F0M', 182, ''),
('Sheke', '9AC04C4ED899FB4DC587513207D6577E0ABA67E87775096608270A9CCDADE7639668DA60C6A99F0FF9EB2939B318EF11B1F9BC05FC730351C538AA908580DF6A', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'z26Y4I90na6sut0975g1Mn6uP8Lm3eh0V1674VZnrlA69Xx7m8Zer2rVf1j4DK2E1p4RO59g631357IEB6J69867Zc06047v7N3q', 183, ''),
('mata123', '658125D0BA5898EE5B9C8ECC76BD1909685F10BCDFDECDAB3E395DA3433F73D8075E50EF85C1A0F3520B524138FFF3DB1705F16804EED131809D986720668B96', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'wR17CP0zZXV9n8s956kUvDr1pPhq79T964708x65O0f01158fKJ942uVF2D13C4ST3c7h7Or6H3552Ab180LR5iA88D208H10y40', 184, ''),
('Arnaut_Latif', '0CB579EDE11B47C625FD4CB92867A06919E7D6E9C6FC2A568D6B95F24FC2C7117C518B9EDF020AE45ACB6FDEB9C611E8B6D53AC0064E496D458BF935DD013E05', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'R8X796lL9O3ki1071867Xz8519f9ClurvyjgTm9x8IBVS6a8Qj7W3673971504V9eO9Sr753JV8F59IN05Gs1dxNc9g6gm7Y7u99', 185, ''),
('Artur_Kaiser', 'D2BE40427454F9DBAF9A47BDB087449D182C7F04D47EE9FB6ACDA83E86161BEA66B663F3915599408CE8AB2BC3D576DE592A0ABD65D29CBBB7D58C5C2A0D0AEB', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'l89WtZ62339IS15fDN1du98Go8y0qLosL1P9biKZHBt5vv5gp80k4U7mKP1600cB7iF1uxk9G45UQ1UsT687haH2825796L99o15', 186, ''),
('newlooksk', 'D5044D7282EE93BDBFAA7BABF5116F23B1F989E9DC81B6D868486F5A12D841473BC80DE72D72D71FBF09AD8EE4ED4D7A46A8040C0198A185293F144D07316E0B', 0, 0, 0, 0, 0, 0, 0, 0, '18/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'MmkViJ64uC7861ya789ZO25H2wo4x1jn7bcn6gn001Y56OR6V10yrXl371W77htoRA088ak3XV3emGrL3JNnn34O6zxmQQ87hb32', 187, ''),
('Dubrov', '02FB666A84DDD2C906263F3DA34374E0B76A6E99089683D7031C6C2B77E851D2C2A77D59DF1383571E2EEFE0235F7CC8703BC255D1D02EA81321E92D1A940EA8', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cE6358q3rDlXYs68H0pT5o0P75I66AYX2fH6wa6M0v6Ou7b392X7N48u9xh9L10S3g3cYRHf887Miuk1UA5hGZJg8955472St2M4', 188, ''),
('herkez12', '71507F2FFFC5254094C814996E0171404EB0E1CE777F51264CBD3682A0CC060EAA616F78488BAB013914FA6047E9E0F05D805AEB6E5C06E4D63B0EA76A13B9F8', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '01h304725EbtCg474250wXO2XM59X1cUx7PtYv6Y5837Yh69F3T3WTZqU283Hmr8495C3r08G75k519446yjub955678iz06870Z', 189, ''),
('Crack360', 'D239F673D1DFBAAA085026D3C509FD718BC8291057A2340002C31E1A865BEF6472A505649FFFD028968F3869CCA74E2F4AD61F4301A91158A4592FFDF87CD700', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '63711q8iA2cYdL3y23fM79T6Q1HUK3SaNdJ5y9H5x10eKfJlaAZLn33U2688WC9DO40T61FLmjH15nT5bX2S8CBx40N966p2x102', 190, ''),
('ALeXy', '34446F2B6511CD409DE72A2442B5A86808AD07C8040E786276E22C081DFB943F5C3ECC4A59F1D4CDBDADFBBFC04808A0F43C63705A016AA28F4FA71EF48B4512', 3, 53043, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'p0g6g124o0U2u9223L54G83Wf48017vUy2j83G3Lynx9762z0fdbN1Lq3E90jXXP56SF02i653A2bs209t57vMKLGi115w580u7H', 191, ''),
('[SAS]Shazam', '44C369CB121D4033254DD1154E5B096F31E947E9DAFB72E8A301F2983CCDAF17B0AC4AB7CD420E30CBC6CBC3CF26CB4A882978A168E1F51FAA7A1E7B08758391', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '692s8Z41NA3Y1rB876u1pOS7176962b8AZ4VUUbL3El35W52vIF9718eiP04LC0410A0673Ep58911r39N6ZbeTQwi20jri8I858', 192, ''),
('Galaxy8', '61A6BD88C7D28059C93789A00D86FE6081D43CEA2B8B401C6C2F0FA3059935B95AD28BF2F14274664849952B87D86B72EE69319DC4AB7F9B951265D795F813CB', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'AoSFZ63JYK9A2Q46chY69ut3miqYS8lX0122LH3R138FdH4C5I6R7v0un2h95Vx3uXW2O52Q4a6461PR47s155UMijB95997yRgo', 193, ''),
('thenewboston', '932AE0D49D9F79F9AF36189922B25412FE4DB34C7C6AAA4CCB08CDADF434C06B1B0C5BBC2463BB7864A5E1CB792F40341207B1ED3A65D219E4BCC1A501360CAD', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'aFXi40N61Wf21sAc00V5FJ052Eonv0jFED2pqp0536k788W3uE25I884Td8C7obU1Y6vTb0D2742m469F36tK5725GydfZk9n270', 194, ''),
('ALEX_CLAVIJO', '9D4B4C6647AAFF6FB528C2BDA76EB586479E633A5781270964BEC7CBD3954BCEDECF570EDDDE5440477A32B3CD5EE938434786267F140A62EE3A9CCE2AEA87E8', 0, 0, 100, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Yzp9lk2322M3JOs50B4Qxf8clN0Emj5qN7aP639T18295059iR31K7q79Q55y5c6Zbjt7b21d2o4C7Gqu9n25VA252bK1o7u4JDS', 195, ''),
('kenny', '63CF767082314984471904A4FDA9293DDFB3130700629D9B7501E6D90AAB2AA104B81178BC4B24E0C1EEB37961B62CAF6F2D8947EE763A6EED4C6CB9B8E59344', 0, 0, 100, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bm018mj4S62sQ7k63105Xfx314991SYnMv06qs939TWGH7098732sc6469ox88pD7X360pHuz1KL43Y9Dpz0k7213I3s3xVrn1B5', 196, ''),
('[GDF]Alex[TVP]', '38C324DDF9AEF113F7990DF6980ED171943C179D702A60728E4AC23B4DF6A3C5AED1F90E218EF35DBF95730F1E9064926263A0398457CC893B5BF4812813C3ED', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '44imC0K1Yv1QM69fQ6l20kyoI23206t62O2i48bpyH10c148YndE6i42qn3k47h5653ZC2v93SOHu5E4912BQ143Uk41hW899EsJ', 197, ''),
('N1S2.Christian', '11C98EE163C6957B69164C79BBE9357FF591CA4A3099D2B87A93A7D9865E7E9F588BE3D8D5796DDE0B3FE65FA74E825EE8A3A14F081DBB56E4413B9B7E1FE0EA', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '19D8PB2107pGcy3Btxs0s994dbb9BJ9807YigC4Z0VC0HPedV62t7lh5N44mk32Fz23Ag197238HG6k01a4y8j7NpY5t5w3T44IA', 198, ''),
('Major_tony', 'B4B80740795F9D451A2E5EA45001444E49C6D841F7EE54052C268E5808E406BF3FD54C53FA871566D01F45DCA5B169602B7A975288633F8AA8F39CEE41FFC859', 0, 0, 100, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jye0NmnG109HI69WFrjzj5PrCL3pbz2XG2ghp8l4hUPbuB106763LxikB823yB8Ic6676z58MFW40R5v0T10q528p551Q4081eou', 199, ''),
('DarkMSD', 'FA6EDBAC0048B0B4B801607C004B95BFAD54F677B3AFDEC40D4B0E17700FDC36D55D955AFCE9E567E4D3BF74967E4025249AD60EF0B6623DDAD3D9A1B452F1ED', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8s0961as2lt4hfBHu1n6824c8i8OC620Dl2p59343Iu34MUGEv0eo48W16986f51142jO9x26dJz6l8f75B0VJNMk1v43p12r6s8', 200, ''),
('[MDK]Alan', 'B4FCF9DDBB516EC34FC2DD0C3C91B702866619B76A3103533D79EFE637D265C324DE26F52070919B8A8D8E6A2EF72680E775D82E208F1B78E05E98AE14207FDF', 0, 0, 0, 0, 0, 0, 0, 0, '19/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SxH6z4tgyGj00u8Oy6Iy19eY0hkx7M5375R498qC26p631nUZDhl31NsJto5p1FPj4fc6oJ9dpl3i33lj563I3g2Y70O7KNc03af', 201, ''),
('Teteros', 'C222F27FDF34F84166DB0B0E52EE6CAA2C87C85F9D5FAA8E51F530DDF746A3FCEB0A3E2874E4DE38FF91A1AAA2C8C70E6751179D70DCB3BA4D4916E27E3C9582', 0, 0, 100, 0, 0, 0, 0, 0, '20/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7Xa8GtDuQ2F3DX76F600EKhI58390l820wb11PIuc5E7I2r14bz92B141h6Qy7qvS83s8s8B405072G21lRH760Gw794y96a4wJL', 202, ''),
('Sparkle', 'B9CD1602F5C7E17F9D4C6A25926FF006980118BD0957230E1C152B6936EF9CA67C8BE7FBB9E7FE49B5BD10B5111BBD2C3A8C8FED5A157E30BF49C4D6288C3B8E', 0, 0, 0, 0, 0, 0, 0, 0, '20/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '316n70G1y2CB9HY2Ozer80I3c424376ul0JtH814IW4YAJ14t328M2mDtJDu6gQ85TvCL936rhZW70e76o9v708x55Ah54Rk6dS2', 203, ''),
('pro12345z1', '3E762453BA0F65AB310616FB4AF34883E993EC91B16B6ABE537B0F460FCA97B752C1331231B348C9679DAB38583C6F58BAB5CF08D698157D57F225AEB602560A', 0, 0, 0, 0, 0, 0, 0, 0, '20/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zt1324S04cQBzo9jNGxu46s1l6UkAPJGW4z6d4nj6g14Sthgli730N8034C50fAcks513513OG6qm7600B3p9P7K3961t34a52ch', 204, ''),
('Jhonny_Cage', '374360A49B7AF82216147CB81A0E7DDCD4D578E0E0B261E0CB81BA8D2C348208167A1D786EC90B816686F3C705F0670F25ECA985683314FCF8D0F8F36E4CAB64', 0, 0, 0, 0, 0, 0, 0, 0, '20/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'l6f7H94a8rW5f6cXoC73CDZi7BNO53MNPb08051426J39cHmkf372xxcsn74ZL7szW992xT5U955D5z8Y8j31e9yU011F81lD362', 205, ''),
('Kleivox91', '0E950307ED260D01E103E5060EBEFBE38A0EEBCDB39DAE4481D17D0B82E33FFA65DE3D34CD0B3349071F1CF45C08EA753547659DBE1A6A50553B4D08471567E5', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'e33952KNKb75MDx9t8qg1mneuk8432hA74h7O7J5KD7w7rd66Yde79H5O7EH095S5uDEYJV1h691K0Bl98h410q6S323BU7f9FZ4', 206, ''),
('rasist', '64F7DB675E699A6677A8F0F1484AD32F20195CEEE5BB02C3274F493151A316849BBC924DC28538A3FAE43152DDD660EACC06E8549A5B2372CD09D92FD28739D5', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Q9856Y8681jk4Sw87y1MN37bs3Y0rw57l33jk794A24P3S55514V605W9KY1X7A5ZK1124d5AvQ977846791WJ466663y291rHT6', 207, ''),
('[SW]Rip', '635435C2AF5FD600D9AE9C74B0F936BEFF155BF458B9645AD0DDA925E384F1F34363E96DBA84B34668B7226E9EC265EB86B2007FC6A6343A3443BA0D3191547B', 0, 639900, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'bmAov3WM9739oA4fYp3pcdKSIX09m0kkn906pk5l08737f6rj1348J3m2347S91P4B76s65aE2hI6ua4X66125vT0q1Ti8ZKMv24', 208, ''),
('sam_k', 'AAB42360ACCFCF0A79A4F5BC1B17BD2A6F93A90324FE2054A1E8DD2F90B244A27289BDA96EE5E6B8A1B13DED5D9AECE6A733E827FF8FDB18F043D9FF3E139236', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'FeVnjDDoM789L0NoW7IDHQbW72f6dxWE4Z6Ti2Mc0cY5qU5h56r5536ZmF5zXU2835q675309B01He117Ic94588jJ9Dm957253S', 209, ''),
('fag0t', '6325583C26675DEA23E9C446A36CCC09288F0452E75C0A34FA1A249CFA8E126C88A16FE47DFD4F5E72882815A299D1949389EF00925A2BC29548D390D228AEEF', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RW80b2091z761587EO5l759q357rVSo3K673p67Fwf301W7W0gViJ1x17lV1806D748XU82Q6Gm0c728322pW9X23i6G53D669J0', 210, ''),
('Artem_Vike', 'A8B453F43D2E75366EAEBA1CA493BC313A74D94E083DBB960B92C9B166A9EED9141E1D02D85F0D27F04748171AF3EE2E8CDE05F1D978097841028E4B1E563F0A', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'e3Vbw10QT2N20482pt393Z79QQ17O1N25abLh9443664q45tC9t120m630y600S672s1Ry9D76w3Je03B6K7Z5O586ZVJ9L18ev8', 211, ''),
('thuquilin', 'F23E6801B4EDF788E3C7416F10FEE764EC9DC30EADB1CF62722EC8D804F388CCF8A8E87ECE8738C19374B7543F322168EF3242655E57644A531E1178925DA23F', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4jxQ810Z00bkwZ1K2wxOmbKl0807zAdNP714Es0UOe6SY5vap13y0uC2d158mqb7275q196JmE41092zG4xOr2w00XO23sz91752', 212, ''),
('kitian2', '2615AF0F6B6B3AAA2E0009310EAC6E7211777A1FC6D721F59C49BAB0A34A81720CD3A61ED9A33561190D50D30594677B9DF5AC241C218545A8C0028927FCA2E6', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4Z4soL9G8i050RFZqj3qh88t520TO837C14JBep684dJmlB084iuD9P1g93e5F063VHWUR4ITwu90a79D5BnCuYjV67463C8Oi93', 213, ''),
('Elias', '6D341B4B704716C4234C109840586E23227F0E3EAEB3AC9708E4AB8DD2196EB072419A6168D0D9458DF83D2593DD4E67DA9DF30707461E692332A917615F9D47', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8681N73xFR02776SN09Y8j7SqIg050at0fA0jO6P6B1hPj0zcWq19471v815Nl249AJ1Z5XWMnc5JD96J45739O2mFD6rZJ8151A', 214, ''),
('MARQUIM', '42654D810ECECE8842CC9D7FC6F4135BEE70E413C586D77EAC7AF247FA269663199D2090B56804E01CEEEBED524DC055566D26F9DA596D3BC8334854EDFBB207', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'r8vTw9xvZ6G43y52ek23yN456F8UVM6ca7r6068080L497l5Z32Gr9406X0G3jY6wzEtn60kJq1uO0S6aCJ1ClR3YE4t95OM6In0', 215, ''),
('Cristian_Escobar', '69EB5AA6AA77DD9D9041EDA06E194352B2459823D807BF6988F9ECDE27A4438EB91620CD534239E221D1E2BA3F52479B360C0C984CE742B1EA1BB5FF02561FD0', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '1oN5i4KL56XN6D0E218V781ZYx6V24TsyEP851vbI9u292s0702286C436W8L16Y2t3dAzmem992UFl3lM53qfZ3A4412X7q884G', 216, ''),
('fadi98', '9E5AE1CB120C5E0D84B3ACDCCDF7D59675B2B5CC339593DB0DBFBE64B7CE2C20B37720EA6C6EFE8DE9B41D6B68D5C614126640DDB01BB493D1C74BEC35D0BE78', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'f60X2E81aE879GRSFVj893216fV0090K49018396uTr608vSrAv3X03P95IQa86gu8A65e3e08F529cA1y1g90rI7haN51rKer8j', 217, ''),
('ehab99', '8F84922AC34B89E87F92A612E1D51D3EC399A04D799F73AD25093A60E6C9A2BCA258B609115B38A659F7D69A8CC7E243C8A8041C4C34BA049D020127BB529B1B', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5y85BXQ6PIL285ro235TcKd14K1G5T1e23Pel4V834drf67qjBP61HBN60535PRxq7uHMA66438x8856vYyHj9c26fdclH6Ae3kj', 218, ''),
('aktham97', 'A7C8CA74606F8655B1D6B49A034C4023AD85E4D8374C6F806EDC92D67EF50079878867624D3FF1C79673C19CC459F1069B432E4B183D1EED20A33CA37886C6D2', 0, 0, 0, 0, 0, 0, 0, 0, '21/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '662Zz24hVw89tZ7i618Q1383QapiRQmQDW0L1F77V0W8HYG9n997FRvG8w4i76X0wD0B6V0cugwvB43n7Ro07gYv0b40cQF9g506', 219, ''),
('TheSoax', '02F53D117B8C0EF12DF31764CEAC539E45DA04136C063BDE8858FD85BDFE4778667430C62DB7B9D7C4AEEEECFD44EE09ADEA09BEF4C870E423216E3CD192B7D9', 0, 0, 410286, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '8V81720I1P31491UIAWr5895J9XJCqq073kgzIvoIEZ2a7P7w99Fpx56S3W50595m08v558G0J4B26L721I625fx3p50y947BG4O', 220, ''),
('denchik', '2E6184BBC7346C722D5B52A7F2160138B4F1721DD93A83394AAB112A2E4D6088C633D674A2CAF8763B4576A47A7CF74CC114282EDA365FBFF5DB323D98A9B1E2', 0, 0, 410286, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'J40T4okTxp861wEi28x4H0960Z7619w32GXfuNf8j775lMV078E8838f3j47153280XWQ5b97GMkU9j0Q66rXbst8d5532rSeCNH', 221, ''),
('jhj', 'EB01F3495F9BA5CEF8FD574F49A7395BECDBDE66A72D7E8EDD21540F9B5DA5E60F94B90DFC239ACDF0A69982C8695E470AE0BCBD07068406E52859D757DAF98F', 0, 0, 0, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '3Szla7o6oF7hm8J49acMFxHi9o6zKvoKu792783mE1i9F4468RRb46XZU0r94Qd2n9hLZB7MJC01338V4140b9LZa3Qv514Y165u', 222, ''),
('Tolik_Jhonson', '2F1EEE4C255CB5DE337593C167A64C060988173F9235348B89ED06E1057641C2038798F2D9F776B2D7C528DE7087F6E17DEE650A21D2DE0F17412B4B122FCE5B', 0, 0, 0, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B02pE6661su98J1z3ztZ6l99Bdre5F3n20y97M34R67E8PW9m1m521001Q0kzC00p1851DobF9472z446jFk9D2967y1gUW463NY', 223, ''),
('LESHIY_LESHIY', '635ED0E9C16EC69BAA7DFDA06406715A94BA344C549D8206229508242F0A9886F49D7449595645BF9CD55192B4BAB9F81988E60B7C120C67D8D26C636DEDEAA8', 0, 0, 0, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '16i99c8D1Y1ek04fX0hpS0rP7417F213M43615RV3104D6tb8O5IR596BK9o3I1u1XE3654Cj8H8s5B48CabD2Ao1311934Y9y4v', 224, ''),
('Mini_rife', '25F10B1ACE03E9AE01E55BF9578FF1E55A1B72A6E9CF5B4EAE2B8A3F451C8C37965D53E0684F65319F2C591947D686D666527299743D33F8E6AC5201EF69BD6A', 2, 0, 548, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '910uy09Xo67c4c70BD154cTHl1YqQy652Fb8sz1Nmy53Wx3d719d1H9K447k1f621gWyRdsRu477X0p007Wo93F3l24NJ632x3oX', 225, ''),
('Klown', 'CD2916C1129001ACDCEEB4248CD13FB13BF1C78A8F7A08E7DD37178EAA2946FDADF2761F06B5E8546DDF6EC20A0F0FEFD356373122BFFAD114F83B7B25E4E362', 0, 0, 548, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '19B36iQ2b575E0U0R5YeN90aHXE5l049F14Q9cW77Ix5499OY4G99Cj161q78s9q62964M57NlRH58398d5g9ydLiX59c8N09444', 226, ''),
('joonasd', '8761F20FC5630E1B995998238668E403F5EEB4A9A056833306B6218A7C91D1DAF5C815219956C9208BFDFDE0647112E0D58CE6D6C9B36029513173E7CF4AA623', 0, 0, 39374, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '156738O7j82946J6ch0WYLEAZ48F0HM0m7Gi81G39U8381oC0LJ654X2t9Y9146MbS0Y679it113cX4g31f35qQ1qf0843TvG7U0', 227, ''),
('sin', 'C1B87BBDCD45E68BD9887371C36ED821BEFC48D5740711424A8F53AA3815769770F39D29CCB26EF84D831B2260240F9780A638AF343E984E48F60D5D95C2BD8A', 0, 0, 39374, 0, 0, 0, 0, 0, '22/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'K6295r4ckT3X2QZNYg5yAMUsvcA4cWf4NXNhg58JUeO1576shB8976949z6Y641S2188Fe0aT9LorO2087X150t73M127OO38d1i', 228, ''),
('BeanSprouts', '084002D6879595E830FC7213E185185F6D1CB9A6EBE09FD0116A4776843F913D7F341C9988E7864E4CA7C01E5C61147B05F52C4EC56B61517385F1849F9D0697', 5, 750, 0, 0, 0, 0, 0, 0, '23/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '98my252RRLl2Q7s2T514HSA147069zY05r4Hq2QO30EC6FZU180B24gO74RusV000ISx03xpny9k5422VP23R7D8ZU1JE5302UXD', 229, ''),
('Skillex', '804F910A7F408571CFDBCE08D58A61AF4F42A511F7932998E1510D617AAADE45792FC48DA97C48C7D0302142CE32762C0CCA2C0F7E7E5BF09C0F218B500C5759', 0, 0, 0, 0, 0, 0, 0, 0, '26/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7pfc6t52T7e91P8u984fzJb9dH86s7a18t9x9TA7M82tqM2l9XsHQ378H5K58aK2VM3Cyq4y58pX6F93o9BR4GLDp34x2b35DCA1', 230, ''),
('Josip', '7A433A4A2A173A80C14A8A28D52C933938E3E1F050479137AD7238F5BA1B97D4FEDC018CD7AF58637BDFF82A32C4DA5D4F07AC5197892FCDE95591691F021E24', 0, 0, 0, 0, 0, 0, 4, 0, '26/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '6l51xPeZfJevX9K8246gBh5d8DH8LlU7279R43OW2x74052Jqwf5fNFtWR5BJje22XET30u03801PCbczcRf6H14k24A986W81Vf', 231, ''),
('Cro_Man', 'BAFD829B4F23BC68ED35486885B8AB4F26320A6FAFC6B14C193A8A503FB7FEA79A4D5E6D0F70F8E6407852D817EB6B9AD409D91B6C4E01E8E7922D7264FA62DC', 0, 0, 0, 0, 0, 0, 0, 0, '26/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4aHR5ney28QCr82q1wy7861284EUxBa7F787zl4sE690L8YP9j04iPc96175Q62LiAa59YC18JZ2HHAtW5BEyS25KTYtK16eKkJn', 232, ''),
('RodimusPrime', '2FC7435AA2673049C403D1657D5D4FBE8F08656EA8C019B45FC194483AF9807D6F73F7EBC46415F27DE87C253E235B0EC62E938E24FD263E6BBAF7F67965DF90', 0, 0, 39374, 0, 0, 0, 0, 0, '29/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '7fHts11H100740d67A4f67176tYR308wXF6D55A8WP7w5d7Cz6R3916Ox168TP7uA28L088Z18a269t26I2M38tq8ayd2535k7Ez', 233, ''),
('Rotiform', '00F962239DE7B40C58926511BA7D95CD01BB341E2330C7041EA36BDAF518825C2F5E516C93818B9DBECCCC49491C262685616CC19F36B0E6D225769F839F3B0F', 0, 0, 0, 0, 0, 0, 0, 0, '29/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B0atE25lZ7Yeojt5B35h61940e6TR069862xL43gDe3xzs248Mhi9wpg11FfJX4j408lHP7Hh0mR3aR71SV4rPDR3x6a352c8hmr', 234, ''),
('Jose_Quesada', 'D46A43D57542F386D68F6A100E28E81CC73930E2A3E46926CD1EA0608CA6592C4A9BF84D2362DFC0FA95F8CE5DFEDB0280AC954CEA99C72D1A59EE3EFE3935F7', 0, 0, 0, 0, 0, 0, 0, 0, '29/08/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'w5473201Pd0531d9IxarrwzsFc5d8MVPC4q8Sl1Y5871755922J7yW1Ij535JF6X97MB27Ku3fvFw1g6ce9Y9okBjpI9OlVW7Ks6', 235, ''),
('thefatshizmsddd', 'D7DD44A69AF5CEE0BD232F7AE909530E7FA681436C63E12B2F0BA662A84FC7F85FED2C6B05E12B72D745AEAEA988ACABB5255C48C7DA618BC6822BB1D968346D', 1, 167, 0, 0, 0, 0, 0, 0, '01/09/2013', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '13d3b3N2Z62mQ9m8d1PJ1D59939942hn548qm864tDfza0YJU3llU5o32jH2818iyM62L552cNR3pcg82AYz00g7ys122120427J', 236, '');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(24) NOT NULL,
  `model` int(4) NOT NULL,
  `vehname` varchar(100) NOT NULL,
  `numberplate` varchar(32) NOT NULL,
  `x_pos` float NOT NULL,
  `y_pos` float NOT NULL,
  `z_pos` float NOT NULL,
  `rotation` float NOT NULL,
  `value` int(8) NOT NULL,
  `pannel_damage` int(20) NOT NULL,
  `door_damage` int(20) NOT NULL,
  `light_damage` int(20) NOT NULL,
  `tire_damage` int(20) NOT NULL,
  `vehicle_health` float NOT NULL,
  `color1` int(10) NOT NULL,
  `color2` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `owner`, `model`, `vehname`, `numberplate`, `x_pos`, `y_pos`, `z_pos`, `rotation`, `value`, `pannel_damage`, `door_damage`, `light_damage`, `tire_damage`, `vehicle_health`, `color1`, `color2`) VALUES
(1, 'imacunt', 541, 'Bullet', 'iamacunt', -2252.24, -349.911, 38.3381, 319.226, 74997, 0, 0, 0, 0, 249, 45, 45),
(2, 'imacunt', 506, 'Super GT', 'boobs', -1911.71, 306.383, 40.774, 180.789, 49997, 0, 0, 0, 0, 1000, 40, 40),
(3, 'imacunt', 429, 'Banshee', 'boobs', -1918.85, 306.125, 40.8179, 182.592, 25000, 0, 0, 0, 0, 1000, 213, 213),
(4, 'BoSS', 579, 'Huntley', 'BoSS', -1987.9, 275.395, 34.9027, 85.1794, 28000, 0, 0, 0, 0, 1000, 97, 97),
(5, 'BoSS', 500, 'Mesa', 'BoSS', -1961.23, 268.075, 35.2431, 270.867, 7500, 0, 131072, 0, 0, 997.768, 221, 221),
(6, '[X]Rip', 411, 'Infernus', '0xAA3333AA', -2247.17, -262.702, 41.7481, 173.289, 120000, 36700179, 33686016, 5, 0, 527.635, 98, 98),
(7, '[X]Rip', 411, 'Infernus', '[X]Rip', -1988.75, 266.311, 34.8838, 82.0179, 120000, 0, 0, 0, 0, 1000, 200, 200),
(8, '[X]Rip', 415, 'Cheetah', '[X]Rip', -1982.3, 260.832, 35.1779, 92.2532, 49997, 0, 0, 0, 0, 1000, 213, 213),
(9, 'TURBO', 411, 'Infernus', 'TURBO is SEXY', -1982.3, 260.832, 35.1779, 92.2532, 120000, 0, 0, 0, 0, 1000, 97, 97),
(10, 'TURBO', 415, 'Cheetah', 'TURBO', -1982.3, 260.832, 35.1779, 92.2532, 49997, 0, 0, 0, 0, 1000, 221, 221),
(11, '4Life', 429, 'Banshee', 'IVAN', -1982.3, 260.832, 35.1779, 92.2532, 25000, 0, 0, 0, 0, 1000, 98, 98),
(12, 'TURBO', 506, 'Super GT', 'Borna', -1982.3, 260.832, 35.1779, 92.2532, 49997, 0, 0, 0, 0, 1000, 200, 200),
(13, '[SW]Rip', 415, 'Cheetah', 'Rip', -1982.3, 260.832, 35.1779, 92.2532, 49997, 0, 0, 0, 0, 1000, 45, 45);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
