<?if($reviews->count()):?>

<div class="recallMainBlock">
	<h3 class="recallTitle">Отзывы</h3>

	<?foreach($reviews as $review):?>
	<div class="recallBlock">
		<div class="nameAndDateRecall">
			<div class="manicon"></div>
			<div class="nameRecall"><?=$review->getName()?></div>
			<div class="dateRecall"><?=str_replace('-', '.', $review->date)?></div>
			<div class="clear"></div>
		</div>
		<p><?=$review->getDescription()?></p>
	</div>
	<?endforeach?>

	<a href="/reviews/" class="allRecall">Все отзывы</a>

</div>

<?endif?>