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

		<h1><?=$h1?></h1>

		<?if($objects->count()):?>
		<?$this->getCatalogObjectBlock($objects)?>
		<?else:?>
			<p>Таких товаров не существует. Попробуйте поискать в разделах каталога или воспользуйтесь поиском вверху страницы.</p>
		<?endif?>

		<?include('paginator.tpl')?>

	</div>
	<div class="clear"></div>
</div>

<?$this->includeTemplate('footer')?>