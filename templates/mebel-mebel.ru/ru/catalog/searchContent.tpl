<?include('filterBlock.tpl')?>
<section class="list-right">
	<h1 class="H1">
		<?if($objectsCount > 0):?>
		Найденные товары (<?=$objectsCount?>)
		<?else:?>
		Результаты поиска
		<?endif?>
	</h1>
	<br />
	<?if($objectsCount > 0):?>
		<?include($template.'.tpl')?>
	<?else:?>
	<div class="top-text">
		<p>По заданным критериям товары не найдены.</p>
		<p>Попробуйте изменить ваш запрос.</p>
	</div>
	<?endif?>
</section>