<div class="manufacturersPlace <?= isset($this->getGet()['mainCategory']) ? '' : 'hide'?>">
	<?if($fabricators):?>
	<div class="manufacturer">
		<h6>По производителю:</h6>
		<ul>
			<? $i=0; foreach($fabricators as $fabricator):?>
			<li>
				<input
					type="checkbox"
					id="filterFabricator<?=$fabricator->id?>"
					name="fabricator[<?=$i?>]"
					data-name="fabricator"
					value="<?=$fabricator->id?>"
					<?= isset($this->getGet()['fabricator']) && in_array($fabricator->id, $this->getGet()['fabricator'])   ?  'checked'   :   ''?>
				>
				<label for="filterFabricator<?=$fabricator->id?>"><?=$fabricator->name?></label>
				<div class="clear"></div>
			</li>
			<? $i++; endforeach?>
		</ul>
	</div>
	<?endif?>
</div>