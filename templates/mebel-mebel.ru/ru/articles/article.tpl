<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

	<article class="article">
		<section class="main">
			<h1 class="H1"><?=$article->getH1()?></h1>
			<div class="clear"></div>
			<?=$article->text?>
		</section>
	</article>
<?$this->includeTemplate('footer')?>