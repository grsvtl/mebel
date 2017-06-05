<script type="text/javascript" src="/js/catalog/filters.js"></script>

<section class="filters">
	<div class="searchBlock">
		<h3>Поиск</h3>
		<div class="price-filter">
			<h6>По цене:</h6>
			<div class="slide">
				<div
					id="slider-range"
					data-min="<?=$this->getController('Catalog')->getMinPrice()?>"
					data-max="<?=$this->getController('Catalog')->getMaxPrice()?>"
					data-choosed-min="<?= isset($this->getGet()['minPrice']) ? $this->getGet()['minPrice'] : $this->getController('Catalog')->getMinPrice()?>"
					data-choosed-max="<?= isset($this->getGet()['maxPrice']) ? $this->getGet()['maxPrice'] : $this->getController('Catalog')->getMaxPrice()?>"
				>
				</div>
			</div>
			<div class="price">
				<span class="ot">от</span>
				<input type="text" placeholder="0" name="minPrice" class="minPrice" >
				<span class="do">до</span>
				<input type="text" placeholder="0" name="maxPrice" class="maxPrice" >
				<span class="rub">руб.</span>
				<div class="clear"></div>
			</div>
		</div>
		<div class="price-filter">
			<h6>По ключевым словам:</h6>
			<input type="text" maxlength="23" class='word' name="word" value='<?= isset($this->getGet()['word']) ? $this->getGet()['word'] : ''?>'>
		</div>
		<div class="type">
			<h6>По типу:</h6>
			<ul>
				<? $i=0; foreach ($this->getController('Catalog')->getMainCategoriesWhichHasChildren() as $mainCategory):?>
				<li>
					<input
						type="checkbox"
						id="filterMainCategory<?=$mainCategory->id?>"
						name="mainCategory[<?=$i?>]"
						data-name="mainCategory"
						value="<?=$mainCategory->id?>"
						<?= isset($this->getGet()['mainCategory']) && in_array($mainCategory->id, $this->getGet()['mainCategory'])   ?  'checked'   :   ''?>
					>
					<label for="filterMainCategory<?=$mainCategory->id?>"><?=$mainCategory->name?></label>
					<div class="clear"></div>
				</li>
				<? $i++; endforeach;?>
			</ul>
		</div>

		<?//=$this->getController('Catalog')->getFilterBlockManufacturer($this->getGet()['mainCategory'])?>
		<?//=$this->getController('Catalog')->getFilterBlockSeries($this->getGet()['fabricator'], $this->getGet()['mainCategory'])?>

		<button class="filter-button">ПРИМЕНИТЬ</button>
	</div>
</section>
