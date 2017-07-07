<div class="shopcartContent">
	<?if($this->isGoodsInShopcart()):?>
		<h1 class="H1">Корзина</h1>
		<div class="top-line-cart">
			<a href="/" class="cart-a">Продолжить покупки</a>
			<h4 class="cart-h4">Товары в корзине</h4>
			<div class="clear"></div>
		</div>

		<?foreach($shopcart->getSortedByIndexArray() as $object):?>
			<?if($object->isAnComplect()):?>
				<div class="product-cart-block included">
					<div class="included-block">
						<div class="name-block">Товар со скидкой</div>
						<div class="close-block-cart removeFromShopcart" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>"></div>
						<div class="img-cart">
							<a href="<?=$object->getPrimaryGood()->getGood()->getPath()?>">
								<img src="<?=$object->getPrimaryGood()->getGood()->getFirstPrimaryImage()->getUserImage('129x97', 'watermarkPng')?>" alt="">
							</a>
						</div>
						<div class="linck-cart-product">
							<span>[ID <?=$object->getPrimaryGood()->getGood()->id?>]</span>
							<a href="<?=$object->getPrimaryGood()->getGood()->getPath()?>"><?=$object->getPrimaryGood()->getGood()->getName()?></a>
							<strong>Производитель - <?=$object->getPrimaryGood()->getGood()->getFabricator()->getName()?></strong>
						</div>
						<div class="cart-price-1"></div>
						<div class="number-cart">
							<span>Количество</span>
							<p><?=$object->getPrimaryGood()->quantity?></p>
							<div class="clear"></div>
						</div>
						<div class="cart-price-1 two">
							<p>Старая цена</p>
							<span class="old-price-2">
								<?=number_format($object->getPrimaryGood()->getGood()->getShowOldPrice(), 0, ',', ' ' )?>
								<strong>c</strong>
							</span>
							<p>Цена</p>
							<span>
								<?=number_format($object->getPrimaryGood()->getShowPrice(), 0, ',', ' ' )?>
								<strong>c</strong>
							</span>
						</div>
						<div class="clear"></div>
					</div>
					<?if($object->getSecondaryGoods()->count()): foreach($object->getSecondaryGoods() as $complectSubgood):?>
					<div class="included-block">
						<div class="img-cart">
							<a href="<?=$complectSubgood->getGood()->getPath()?>">
								<img src="<?=$complectSubgood->getGood()->getFirstPrimaryImage()->getUserImage('129x97', 'watermarkPng')?>" alt="">
							</a>
						</div>
						<div class="linck-cart-product">
							<span>[ID <?=$complectSubgood->getGood()->id?>]</span>
							<a href="<?=$complectSubgood->getGood()->getPath()?>"><?=$complectSubgood->getGood()->getName()?></a>
							<strong>Производитель - <?=$complectSubgood->getGood()->getFabricator()->getName()?></strong>
						</div>
						<div class="cart-price-1">

						</div>
						<div class="number-cart">
							<span>Количество</span>
							<p><?=$complectSubgood->quantity?></p>
							<div class="clear"></div>
						</div>
						<div class="cart-price-1 two">
							<p>Старая цена</p>
							<span class="old-price-2">
								<?=number_format($complectSubgood->getGood()->getShowOldPrice, 0, ',', ' ' )?>
								<strong>c</strong>
							</span>

							<p>Цена</p>
							<span>
								<?=number_format($complectSubgood->getShowPrice(), 0, ',', ' ' )?>
								<strong>c</strong>
							</span>
						</div>
						<div class="clear"></div>
					</div>
					<?endforeach; endif;?>
					<div class="total-amount">
						<div class="text-total">
							Покупая комплектом вы экономите -
							<span>
								<?=number_format(($object->getBasePriceByQuantity($object->getQuantity()) - $object->getPriceByQuantity($object->getQuantity())) * $object->getQuantity(), 0, ',', ' ' )?>
								<strong>c</strong>
							</span>
						</div>
						<div class="number-cart">
							<span>Количество</span>
							<?if($object->getQuantity() > 1):?>
							<strong class="p1 changeQuantity" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>" data-quantity="<?=$object->getQuantity() - 1?>">-</strong>
							<?endif?>
							<p><?=$object->getQuantity()?></p>
							<strong class="p2 changeQuantity" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>" data-quantity="<?=$object->getQuantity() + 1?>">+</strong>
							<div class="clear"></div>
						</div>
						<div class="cart-price-1 two">
							<p>Итоговая стоимость:</p>
							<span>
								<?=number_format( $object->getPriceByQuantity($object->getQuantity()) * $object->getQuantity(), 0, ',', ' ' )?> <strong>c</strong>
							</span>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			<?else:?>
				<div class="product-cart-block <?= $object->isAnOffer() ? 'akcia' : ''?>">

					<?if($object->isAnOffer()):?>
					<div class="name-block">
						Товар со скидкой
					</div>
					<?endif?>

					<div class="close-block-cart removeFromShopcart" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>"></div>
					<div class="img-cart">
						<a href="<?=$object->getPath()?>" target="blank">
							<img src="<?=$object->getFirstPrimaryImage()->getUserImage('129x97', 'watermarkPng')?>" alt="">
						</a>
					</div>
					<div class="linck-cart-product">
						<span>[ID <?=$object->id?>]</span>
						<a href="<?=$object->getPath()?>" target="blank"><?=$object->getName()?></a>
						<strong>Производитель - <?=$object->getFabricator()->getName()?></strong>
					</div>
					<div class="cart-price-1">

						<?if($object->isAnOffer()):?>
						<p>Старая цена</p>
						<span class="old-price-2">
							<?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<p>Цена</p>
						<span>
							<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<?else:?>
						<p>Цена</p>
						<span>
							<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<?endif?>

					</div>
					<div class="number-cart">
							<span>Количество</span>
							<?if($object->getQuantity() > 1):?>
							<strong class="p1 changeQuantity" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>" data-quantity="<?=$object->getQuantity() - 1?>">-</strong>
							<?endif?>
							<p><?=$object->getQuantity()?></p>
							<strong class="p2 changeQuantity" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>" data-quantity="<?=$object->getQuantity() + 1?>">+</strong>
							<div class="clear"></div>
					</div>
					<div class="cart-price-1 two">

						<?if($object->isAnOffer()):?>
						<p>Старая стоимость</p>
						<span class="old-price-2">
							<?=number_format( $object->getShowOldPrice() * $object->getQuantity(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<p>Стоимость</p>
						<span>
							<?=number_format( $object->getTotalPrice(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<?else:?>
						<p>Стоимость</p>
						<span>
							<?=number_format( $object->getTotalPrice(), 0, ',', ' ' )?> <strong>c</strong>
						</span>
						<?endif?>

					</div>
					<div class="clear"></div>

					<?if($object->getSubgoods()->count()):?>
					<div class="product-in-complect subGoods_<?=$object->id?>">
						<h3>Комплектация:</h3>
						<?foreach($object->getSubgoods() as $subGood):?>
						<div class="product-in-complect-block">
							<div class="mini-img">
								<a href="<?=$subGood->getGood()->getPath()?>">
									<img src="<?=$subGood->getGood()->getFirstPrimaryImage()->getUserImage('97x83', 'watermarkPng')?>" alt="">
								</a>
							</div>
							<div class="mini-linck-complect">
								<span>[ID <?=$subGood->getGood()->id?>]</span>
								<a href="<?=$subGood->getGood()->getPath()?>"><?=$subGood->getGood()->getName()?></a>
							</div>
							<div class="clear"></div>
						</div>
						<?endforeach?>
					</div>
					<div class="button-all-see showSubgoodsButton" data-id="<?=$object->id?>">Показать комплектацию</div>
					<?endif?>
				</div>
			<?endif?>
		<?endforeach?>

		<div class="total-price">
			<p>ИТОГО:</p>
			<span><?=number_format( $shopcart->getTotalPrice(), 0, ',', ' ' )?><strong>c</strong></span>
		</div>

		<span class="start-ordering startOrdering" onclick="dataLayer.push({'event': 'event_zakaz_start'});">Начать оформление заказа</span>

		<div class="ordering hide">
			<h2>Оформление заказа</h2>
			<div class="left-ordering">
				<div class="shipping shippingBLock">
					<h3>Выберите тип доставки</h3>
					<ul>
						<li>
							<input type="radio" id="shippingSelf" name="shipping" checked="">
							<label for="shippingSelf">Не нужно (Самовывоз)</label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="shippingMoskow" name="shipping">
							<label for="shippingMoskow">По Москве </label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="shippingMkad" name="shipping">
							<label for="shippingMkad">За МКАД </label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="shippingCompany" name="shipping">
							<label for="shippingCompany">На транспортную компанию </label>
							<div class="clear"></div>
						</li>
					</ul>
				</div>
				<div class="shipping lift liftBlock hide">
					<h3>Подъем на этаж</h3>
					<ul>
						<li>
							<input type="radio" id="liftBySelf" name="lift" checked="">
							<label for="liftBySelf">Не нужно (Сами поднимем)</label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="liftWithoutLift" name="lift">
							<label for="liftWithoutLift">Заказываем подъём (нет лифта) </label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="liftWithSmallLift" name="lift">
							<label for="liftWithSmallLift">Заказываем подъём (пассажирский лифт)</label>
							<div class="clear"></div>
						</li>
						<li>
							<input type="radio" id="liftWithBigLift" name="lift">
							<label for="liftWithBigLift">Заказываем подъём (грузовой лифт)</label>
							<div class="clear"></div>
						</li>
					</ul>
				</div>
			</div>
			<div class="right-order">
				<label>Фамилия</label>
				<input type="text" name="family">
				<label>Имя</label>
				<input type="text" name="name">
				<label>Отчество</label>
				<input type="text" name="parentName">
				<label>Телефон</label>
				<input type="text" name="phone" placeholder="+7 (400) 45 85 692">
				<label>Дополнительный телефон</label>
				<input type="text" name="addPhone" placeholder="+7 (400) 45 85 692">
				<label>E-mail</label>
				<input type="text" name="email">
                <label>Другая информация</label>
                <textarea name="info"></textarea>
				<div class="address-order adresOrderBlock hide">
					<label>Адрес доставки:</label>
					<ul>
						<li>
							<span>Индекс</span>
							<input type="text" name="index">
							<div class="clear"></div>
						</li>
						<li>
							<span>Область</span>
							<input type="text" name="region">
							<div class="clear"></div>
						</li>
						<li>
							<span>Город</span>
							<input type="text" name="city">
							<div class="clear"></div>
						</li>
						<li>
							<span>Улица</span>
							<input type="text" name="street">
							<div class="clear"></div>
						</li>
						<li>
							<span>Корп.</span>
							<input type="text" name="block">
							<div class="clear"></div>
						</li>
						<li>
							<span>Дом</span>
							<input type="text" name="home">
							<div class="clear"></div>
						</li>
						<li>
							<span>Квартира</span>
							<input type="text" name="flat">
							<div class="clear"></div>
						</li>
					</ul>
				</div>
				<label>Способ оплаты</label>
				<select name="paymentType">
					<option>Наличные</option>
					<option>Банковский перевод</option>
					<option>Кредитная карта</option>
				</select>
			</div>
			<div class="clear"></div>
			<span class="start-ordering two sendOrderGetSuccessBlock">оформить заказ</span>
		</div>

	<?else:?>
		<div class="top-line-cart">
			<h4 class="cart-h4">В корзиние нет товаров</h4>
			<div class="clear"></div>
		</div>
	<?endif?>
	<div class="clear"></div>
</div>