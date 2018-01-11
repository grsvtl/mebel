<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
<link rel="stylesheet" type="text/css" href="/css/vn-mebel.ru/content/shopcart.css" />
<article>
	<section class="main">
		<?=$content?>

        <div class="successBlockHybrid">Спасибо. Ваш заказ принят. Мы перезвоним Вам в ближайшее время.</div>

        <div class="yandex_s_p">
<!--            <h2>Моментальная оплата</h2>-->
<!--            <p>Вы можете оплатить ваш заказ прямо сейчас или позже, когда наши операторы вам позвонят.</p>-->
            <p>Завершите оформление заказа и наши операторы вам позвонят чтобы обговорить оплату и прочие детали.</p>
            </br>
            <div>Стоимость заказа: <span class="orderSum"></span> руб.</div>
            </br>
            <hr>
            <h4>Детали заказа</h4>
            </br>

<!--            <form action="https://money.yandex.ru/eshop.xml" method="post">-->
            <form>
<!--                <input required name="shopId" value="96107" type="hidden"/>-->
<!--                <input required name="scid" value="86076" type="hidden"/>-->

                <label>Сумма платежа:</label>
                <input required name="sum" value="" type="number" min="1" placeholder="Укажите сумму платежа">

                <!-- Поле name="customerNumber" обязательное, его удалить нельзя =============================
                     вы можете назвать его по своему, например вместо "Имя покупателя" написать "Идентификатор
                     плательщика", "Номер клиента", "Имя клиента" или "Номер заказа" и т.д.;
                     т.е. поле может иметь ваше название, но само name="customerNumber" переименовывать нельзя

                     -->
                <label>Имя покупателя:</label>
                <input required name="customerNumber" value="" size="64"/><br>

                <!-- Любые из этих групп строк можно убрать (если они не нужны) или переименовать ============
                     например, вместо "Телефон покупателя" написать "Цвет глаз" или "Номер автомобиля"     -->
                <label>Телефон покупателя:</label>
                <input name="custName" value="" size="64"/>
                <label>Адрес доставки:</label>
                <input name="custAddr" value="" size="64"/>
                <label>Email покупателя:</label>
                <input name="custEmail" value="" size="64"/>
                <label>Комментарии к заказу:</label>
                <textarea name="orderDetails" value="" rows="5" cols="68" wrap="soft"></textarea>
                <!-- Кнопку "Оплатить", можно назвать по своему, например value="Оплатить за курсы вождения"
                     или value="Оплатить подписку на журнал" и т.д.                                        -->
<!--                <input type="submit" onclick="dataLayer.push({'event': 'event_zakaz_paynow'});" value="Оплатить">-->
<!--                <button type="button" onclick="dataLayer.push({'event': 'event_pay_late'});" class="payAfter">Я оплачу позже</button>-->
                <button type="button" onclick="dataLayer.push({'event': 'event_pay_late'});" class="payAfter">Завершить оформление</button>
            </form>
        </div>

    </section>
</article>

<?$this->includeTemplate('footer')?>