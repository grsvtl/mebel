<div class="list-products">
	<div class="sorting">

		<?foreach($sorting['view'] as $key=>$value):?>
		<?if($value!=$template):?>
		<a class="sortLinks" href="<?=\core\utils\Utils::sgp($_SERVER['REQUEST_URI'], 'view', $key);?>">
		<?endif?>
			<div class="<?=$key?>-icon <?= $value==$template ? 'active' : 'pointer'?>"></div>
		<?if($value!=$template):?>
		</a>
		<?endif?>
		<?endforeach?>

		<span class="s-n">Сортировать по:</span>
		<?
			$url = $_SERVER['REQUEST_URI'];
			foreach($sorting['fields'] as $title=>$field)
				$url = \core\utils\Utils::rgp($url, 'sortBy%5B'.$field.'%5D');
		?>
		<? foreach($sorting['fields'] as $title=>$field):?>
		<a
			href="<?=\core\utils\Utils::sgp($url, 'sortBy%5B'.$field.'%5D', $sorting['direction']=='up' ? 'down' : 'up');?>"
			class="sortLinks price-list <?=($sorting['current']==$field)?'active':''?> <?= $sorting['current']==$field ? $sorting['direction'] : ''?>"
			rel="nofollow"
		>
			<span><?=$title?></span>
		</a>
		<? endforeach; ?>

		<div class="clear"></div>
	</div>
</div>