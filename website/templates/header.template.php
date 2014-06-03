<?php
	$template = new Template(); 
?>

<!doctype html>
	
	<html lang="en" itemscope itemtype="http://schema.org/Article">

		<head>

			<meta charset="utf-8">

			<title><?php echo $template->GetTitle(); ?></title>

			<meta name="author" content="thefatshizms">
			<meta name="keywords" content="<? $template->GetKeywords(); ?>">
			<meta name="description" content="{$PAGE_DESC}">
			<link rel="author" href="https://plus.google.com/114550321533557581132/posts"/>
			<link rel="publisher" href="https://plus.google.com/114550321533557581132/"/> 
			<meta itemprop="name" content="San Fierro Cops 'n Robbers - index">
			<meta itemprop="description" content=<?php echo "$template->GetTitle()";?>>
			<meta itemprop="image" content="{$PAGE_IMAGE}"> 
			<meta name="twitter:card" content="summary_large_image">
			<meta name="twitter:site" content="@thefatshizms">
			<meta name="twitter:title" content="<? echo $template->GetTitle(); ?>">
			<meta name="twitter:description" content="<? echo $template->GetDesc(); ?>">
			<meta name="twitter:creator" content="@thefatshizms">
			<meta name="twitter:image:src" content=""> 
			<meta property="og:title" content="<? echo $template->GetTitle(); ?>" />
			<meta property="og:type" content="article" />
			<meta property="og:url" content="http://www.sf-cnr.co.uk/" />
			<meta property="og:image" content="" />
			<meta property="og:description" content="<? echo $template->GetDesc(); ?>" /> 
			<link href="./themes/1/js-image-slider.css" rel="stylesheet" type="text/css">
    		<link href="./generic.css" rel="stylesheet" type="text/css" >
    		<link href="./css/style.css" rel="stylesheet" type="text/css">

    		<script src="./themes/1/js-image-slider.js" type="text/javascript"></script>
    		<script src="./http://code.jquery.com/jquery-1.11.0.min.js"></script>
			<script src="./js/site.js"></script>
			<script>
			  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			  ga('create', 'UA-37045751-1', 'sf-cnr.co.uk');
			  ga('send', 'pageview');

			</script>
		</head>