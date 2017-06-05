		<br /><br />
		<div class="product-place tile index">
			<?$superObjects = $this->getController('Catalog')->getSpecialObjectsForIndex(20);?>
			<h2 class="h2">Специальные предложения:</h2>
			<?if($superObjects->count()):?>
			<?foreach($superObjects as $superObject):?>
				<?$this->getController('Catalog')->getCatalogListContentItemBlock($superObject)?>
			<?endforeach?>
			<?endif?>
			<div class="clear"></div>
		</div>