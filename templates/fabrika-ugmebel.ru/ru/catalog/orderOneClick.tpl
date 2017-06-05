<script type="text/javascript" src="/js/catalog/orderByOneClick.js"></script>

<div class="callBackModal modalOrderOneClick">
	<div class="closeCallbackOneClick"></div>
	<div class="titleCallBackBlockOneClock"></div>

	<form action="/order/sendOrderByOneClick/" method="post" class="orderByOneClick" data-dataLayerPushEvent="zakaz_oneclick">
		<p>Укажите свой контактный телефон, и мы перезвоним вам в ближайшие несколько минут:</p>
		<input type="text" name="phoneNumber">
        <div class="block-input">
            <p class="capchaChange capchaP ajaxCapcha"></p>
            <input type="text" name="capcha" class="capchaInput" >
            <div class="clear"></div>
        </div>
		<input class="oneClickGoodId" name="goodId" type="hidden" value=""/>
		<button class="orderByOneClickSubmit">Отправить</button>
	</form>

	<div class="content" style="display: none; text-align: center;">
		<div class="thanks">Мы благодарны вам за интерес к нашим товарам !</div>
		<p>Наши менеджеры уже получили оповещение и в течение <span style="font-size: 20px;">10</span> минут перезвонят вам.</p>
		<button class="close" style="margin-top: 10px; float: none; margin-right: 0px;">Закрыть</button>
	</div>

</div>