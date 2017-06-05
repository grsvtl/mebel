<?if($series->count()):?>
<div class="compositiomMebel">
	<ul>
		<?foreach($series as $seria):?>
		<?
			$objects = $this->getController('Catalog')->getObjectsByFabricatorAndSeria($fabricator->id, $seria->getValue());
			$objectsCount = $objects->count();
			if($objectsCount):
		?>
		<li>
			<a href="<?= isset($category) ? $category->getPath() : ''?><?=$seria->getAlias()?>/"
			   class="imgComposition"
			   style="background-image: url(<?=
					$seria->description ?
					$seria->description :
					$objects->current()->getFirstPrimaryImage()->getFocusImage('272x166')
					?>)">
				<span class="nameComposition"><?=$seria->getValue()?></span>
			</a>
		</li>
		<?endif?>
		<?endforeach?>
	</ul>
	<div class="clear"></div>
</div>
<?endif?>