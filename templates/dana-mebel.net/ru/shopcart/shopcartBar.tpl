<?if($this->getController('Shopcart')->getShopcart()->count()):?>
<div class="topRedLine cardAdded shopcartBar">
	<div class="topRedLineCenter">
		<div class="cardBlock">
			<span class="nameC">Корзина:</span>
			<span class="summP"><?=$shopcartCount?> шт.</span>
			<span class="summM"><?= number_format( $this->getController('Shopcart')->getTotalPrice(), 0, ',', ' ' )?> руб.</span>
			<a href="/shopcart/" class="inCard">Перейти</a>
		</div>
		<div class="clear"></div>
	</div>
</div>
<?else:?>
<div class="topRedLine shopcartBar">
	<div class="topRedLineCenter"></div>
</div>
<?endif?>