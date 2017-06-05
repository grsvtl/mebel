<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<article>
	<section class="main">
		<? include('filterBlock.tpl')?>
		<section class="list-right">
			<h1 class="H1"><?=$category->getH1()?></h1>
			<?if(isset($mainCategoryContentInclude)):?>
				<div class="top-text"><?=$category->getDescription()?></div>
				<div class="catalogListContent">
					<link rel="stylesheet" type="text/css" href="/css/vn-mebel.ru/content/categoryContentInclude.css" />
					<?include('categoryContentInclude/'.$mainCategoryContentInclude.'.tpl');?>
				</div>
				<div class="text-bottom"><?=$category->getText()?></div>
			<?else:?>
				<?if(!isset($this->getGet()['page']) || $this->getGet()['page']==1):?>
				<div class="top-text"><?=$category->getDescription()?></div>
				<?endif?>
				<?=$this->getCatalogListContent($category);?>
				<?if(!isset($this->getGet()['page']) || $this->getGet()['page']==1):?>
				<div class="text-bottom"><?=$category->getText()?></div>
				<?endif?>
			<?endif?>
		</section>
		<div class="clear"></div>
	</section>
</article>
<?$this->includeTemplate('footer')?>