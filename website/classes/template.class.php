<?php

	class Template {

		private $page_title;
		private $page_desc;
		private $page_keywords;
		private $page_image;

		

		public function Header()
		{
			require("./templates/header.template.php");
		}

		public function SetTitle($title)
		{
			$this->page_title = $title;
		}

		public function GetTitle()
		{
			return $this->page_title;
		}

		public function SetDesc($desc)
		{
			$this->page_desc = $desc;
		}

		public function GetDesc()
		{
			return $this->page_desc;
		}

		public function SetKeywords($keywords)
		{
			$this->page_keywords = $keywords;
		}

		public function GetKeywords()
		{
			return $this->page_keywords;
		}

		public function SetImage($image)
		{
			$this->page_image = $image;
		}

		public function Footer()
		{

		}
	}

?>