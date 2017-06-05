<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<div class="textPageMain">
		<div class="textPage">

			<?$this->includeBreadcrumbs()?>

			<h1><?=$article->getH1()?></h1>
			<?=$article->getText();?>
		</div>
		<div class="clear"></div>
	</div>
<?$this->includeTemplate('footer')?>