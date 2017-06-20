<div class="modal2">
	<div class="modal_in">
		<a class="close pointer closeAskModal"></a>
		<p><img src="/images/bg/smodal54.png" alt=""></p>
		<p class="user">В корзине пользователя [ <?=$this->getAuthorizatedUser()->getLogin()?> ] сохранён товар.</p>
		<p>Видимо ранее вы уже добавляли в корзину товар, но не завершили заказ.</p>
		<div class="modal_step">
			<p class="title">Что делать дальше?</p>

			<table width="100%">
				<tbody><tr>
					<td width="1"><img src="/images/bg/smodal01.png" alt=""></td>
					<td width="1"><img src="/images/bg/smodal04.png" alt=""></td>
					<td>
						<p class="name">Объединить товары</p>
						<p>Объединить товары пользователя, <br>с товарами гостя</p>
					</td>
					<td><a class="submit pointer shopcartAction" data-action="ajaxSaveGuestShopcartToAuthorizatedShopcart">ОК</a></td>
				</tr>
				<tr>
					<td><img src="/images/bg/smodal02.png" alt=""></td>
					<td><img src="/images/bg/smodal05.png" alt=""></td>
					<td>
						<p class="name">Оставить товары гостя</p>
						<p>Удалятся товары пользователя,<br>останутся товары гостя.</p>
					</td>
					<td><a class="submit pointer shopcartAction" data-action="ajaxDelAuthorizatedShopcartSaveGuestShopcart">ОК</a></td>
				</tr>
				<tr>
					<td><img src="/images/bg/smodal03.png" alt=""></td>
					<td><img src="/images/bg/smodal06.png" alt=""></td>
					<td>
						<p class="name">Оставить товары пользователя</p>
						<p>Удалятся товары гостя, <br>останутся товары пользователя</p>
					</td>
					<td><a class="submit pointer shopcartAction" data-action="ajaxDelGuestShopcart">ОК</a></td>
				</tr>
			</tbody></table>
		</div>
	</div>
</div>