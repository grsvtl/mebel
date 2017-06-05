<?if($object->getOffer()->type == 'time'):?>
	<script type="text/javascript">
		$(function(){
			$('#countMain' + <?=$object->getOffer()->id?>).countdown({
				until: new Date(<?=$object->getOffer()->getJQFormatedTime()?>)
			});
//			$('#countMain871').countdown('pause');
		});
	</script>
	<script type="text/javascript" src="/js/extensions/countdown/jquery.countdown.min.js"></script>
	<script type="text/javascript" src="/js/extensions/countdown/jquery.countdown-ru.js"></script>
<?endif?>
<link rel="stylesheet" type="text/css" href="/js/extensions/countdown/jquery.countdown.css" />

<div class="shares">
	<div class="shares-info1">
		<p><?=$object->getOffer()->title?></p>
	</div>
	<div class="shares-info2">
		<?=$object->getOffer()->description?>
	</div>
	<div class="shares-time counter">
		<h6>Осталось до конца акции</h6>
		<?if($object->getOffer()->type == 'time'):?>
			<div class="timer">
				<div id="countMain<?=$object->getOffer()->id?>"></div>
			</div>
			<?else:?>
			<div class="timer">
				<div class="timer">
					<div class="hasCountdown ">
						<span class="countdown_row">
							<span class="countdown_section_left">
								<span class="countdown_amount_left quantity_offer"><?=$object->getOffer()->quantity?></span>
								<div class="sht">шт.</div>
							</span>
						</span>
					</div>
				</div>
			</div>
		<?endif?>
	</div>
</div>
<div class="tub-line"></div>