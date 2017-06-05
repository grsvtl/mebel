<div class="seriesPlace <?= isset($this->getGet()['fabricator']) ? '' : 'hide'?>">
	<?if($series):?>
	<div class="price-filter seria">
		<h6>По серии:</h6>
		<ul>
			<? $i=1; foreach($series as $seria):?>
			<li>
				<input
					type="checkbox"
					id="filterFabricator<?=$seria?>"
					name="seria[<?=$i?>]"
					data-name="seria"
					value="<?=$seria?>"
					<?= isset($this->getGet()['seria']) && in_array($seria, $this->getGet()['seria'])   ?  'checked'   :   ''?>
				>
				<label for="filterFabricator<?=$seria?>"><?=$seria?></label>
				<div class="clear"></div>
			</li>
			<? $i++; endforeach?>
		</ul>

	</div>
	<?endif?>
</div>