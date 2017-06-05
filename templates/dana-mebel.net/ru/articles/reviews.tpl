<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
<div class="textPageMain">
		<div class="textPage">

			<?$this->includeBreadcrumbs()?>

			<h1>Отзывы</h1>

			<?foreach($reviews as $review):?>
			<div class="recallBlock">
				<div class="nameAndDateRecall">
					<div class="manicon"></div>
					<div class="nameRecall"><?=$review->getName()?></div>
					<div class="dateRecall"><?=str_replace('-', '.', $review->date)?></div>
					<div class="clear"></div>
				</div>
				<p><?=$review->getText()?></p>
			</div>
			<?endforeach?>

			<script type="text/javascript" src="/js/reviews.js"></script>

			<div class="sendReview" data-action="/article/sendReview/" data-method="post" style="width: 500px; text-align: center; margin: 0px auto 0 auto;">
				<input type="text" name="name" class="allRecallInput" placeholder="Имя" />
				<textarea name="text" class="allRecallTextarea" placeholder="Отзыв" noresize></textarea>
				<a class="allRecall sendReviewSubmit">Оставить отзыв</a>
				<img class="sendCommentLoader hide" src="/images/loaders/horizontal-green-loader.gif" style="height: 15px; margin-top: 10px;" />
				<div class="sendCommentResult hide">
					<br />
					<font color="green">
						Ваш отзыв успешно доставлен.
						<br />
						После модерации он появиться на сайте.
					</font>
				</div>
			</div>

		</div>
		<div class="clear"></div>
	</div>
<?$this->includeTemplate('footer')?>