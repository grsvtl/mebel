<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<div class="mainContent">
	<div class="buttonMenu">
		<span>Каталог</span>
	</div>
	<div class="bgGrayMenu"></div>
	<div class="leftMenu">

	<?=$this->getController('Catalog')->getCatalogLeftMenu()?>

	</div>
	<div class="rightContent">

		<?$this->includeBreadcrumbs()?>

		<h1>Мебель <?=$seria->getValue()?></h1>

		<?$goodsWithSubgoodsOfSeria = $this->getGoodsWithSubgoodsBySeria($seria)?>
		<?if($goodsWithSubgoodsOfSeria->count()):?>
		<div class="mainBannerComposition">
			<div class="slider">
				<ul class="slides">
					<?foreach($goodsWithSubgoodsOfSeria as $good):?>
					<li class="slide">
						<div class="mainOffer" style="background-image: url(<?=$good->getFirstPrimaryImage()->getImage('860x296')?>)">
							<a href="<?=$good->getPath()?>" class="moreABanners"><?=$good->getName()?></a>
							<a href="<?=$good->getPath()?>" class="moreComp">Посмотреть подробнее</a>
						</div>
					</li>
					<?endforeach?>
				</ul>
			</div>
		</div>
		<?endif?>

		<?if($seriaCategories->count()):?>
		<div class="compositiomMebel">
			<h2><span>Каталог <?=$seria->getValue()?></span></h2>
			<ul>
				<?foreach($seriaCategories as $category):?>
				<li>
					<a
						href="/<?= $seria->getAlias()?><?= $category->getPath()?>"
						class="imgComposition"
						style="background-image: url(<?=$this->getFirstObjectOfCategoryAndSeria($category, $seria)->getFirstPrimaryImage()->getImage('272x166')?>)"
					>
						<span class="nameComposition"><?=$category->getName()?></span>
					</a>
				</li>
				<?endforeach?>
			</ul>
			<div class="clear"></div>
		</div>
		<?endif?>

	</div>
	<div class="clear"></div>
</div>

<?$this->includeTemplate('footer')?>