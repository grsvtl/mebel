<script type="text/javascript" src="/js/feedback/modalAsk.js"></script>

<div class="callBackModal modalAsk">
	<div class="closeCallback"></div>
	<div class="titleCallBackBlock"></div>

	<form action="/feedback/ajaxModalAsk/" method="post" class="modalAskClick" data-dataLayerPushEvent="form_zvonok">
		<h3>Ваш номер телефона</h3>
		<input type="text" name="phoneNumberAsk">
        <div class="block-input">
            <p class="capchaChange capchaP ajaxCapcha"></p>
            <input type="text" name="capcha" class="capchaInput" maxlength="2">
            <div class="clear"></div>
        </div>
		<button class="modalAskClickSubmit" data-dataLayerPushEvent="zakaz_svyaz">Отправить</button>
	</form>

	<div class="content" style="display: none; text-align: center;">
		<div class="thanks">Мы благодарны вам за интерес к нашим товарам !</div>
		<p>Наши менеджеры уже получили оповещение и в течение <span style="font-size: 20px;">10</span> минут перезвонят вам.</p>
		<button class="close" style="margin-top: 10px; float: none; margin-right: 0px;">Закрыть</button>
	</div>

</div>

