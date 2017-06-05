<script type="text/javascript" src="/js/catalog/orderByOneClick.js"></script>

<!--Начало модальное окно-->
	<div class="bg-modal orderOneClickModalBg" style="display: none;"></div>
	<div class="modal-block orderOneClickModal" style="display: none;">
		<div class="title-modal">
			<div class="close-modal close"></div>
			<div class="oneClickTitle"></div>
			<div class="clear"></div>
		</div>
		<div class="girl-img"></div>
		<form action="/order/sendOrderByOneClick/" method="post" class="orderByOneClick">
			<div class="h4">обратный звонок</div>
			<p>Укажите свой контактный телефон, и мы перезвоним вам в ближайшие несколько минут:</p>
			<input name="phoneNumber" value=""/>
			<input class="oneClickGoodId" name="goodId" type="hidden" value=""/>

            <div class="block-input">
                <p class="capchaChange capchaP ajaxCapcha"></p>
                <input type="text" name="capcha" class="capchaInput" >
                <div class="clear"></div>
            </div>

			<button class="orderByOneClickSubmit">Отправить</button>
		</form>
		<div class="content" style="display: none;">
			Мы благодарны вам за интерес к нашим товарам !
			<br /><br /><br />
			<p>Наши менеджеры уже получили оповещение и в течение <span style="font-size: 20px;">10</span> минут перезвонят вам.</p>
			<button class="close" style="margin-top: 10px;">Закрыть</button>
		</div>
	</div>
<!--Конец модальное окно-->