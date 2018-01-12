 <body>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NZ223F4"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
	 <!--<noindex>-->
	<? include 'catalog/orderOneClick.tpl'; ?>
	<? include 'modalAsk.tpl'; ?>
	<!--</noindex>-->

	<!--Начало контента шапки-->
	<header>
		<!--Начало первой линии шапки-->
		<div class="top-line">
			<div class="center-top-line">
<!--		<section class="top-line">
			<section class="center-top-line">-->
				<?$this->getController('Shopcart')->getShopcartBar()?>

<!--				<a href="#" class="login">
					Личный кабинет
				</a>-->
				<div class="social">
					<a href="https://twitter.com/mebel_mebelmag/" class="twitter"></a>
					<a href="https://www.facebook.com/groups/469382486555976/" class="fb"></a>
					<a href="http://vk.com/mebel_meb" class="vk"></a>
				</div>

				<?$this->getController('Article')->getTopMenu()?>

				<div class="clear"></div>
<!--			</section>
		</section>-->
			</div>
		</div>
		<!--Конец первой линии шапки-->
		<!--Начало второй линии шапки-->
            <!--<section class="top-line-info">-->
	    <div class="top-line-info">
            <a <?if ($this->isNotIndex()):?>href="/"<?endif;?> class="logo">
                <img src="/images/bg/logo.png" alt="logo">
            </a>
            <span class="ask modalAskShow" title="ЗАКАЗАТЬ ОБРАТНЫЙ ЗВОНОК">
                <span class="strong">
                    Задать вопрос
                </span>
            </span>

            <div class="search">
                <input type="text" class="findInput" placeholder="Поиск по сайту" maxlength="23" value="<?= isset($this->getGet()['word']) ? $this->getGet()['word'] : ''?>">
                <button class="findButton"></button>
            </div>

            <div class="time">
                <span class="info-time">График работы:</span>
                <span class="time1">
                    9:00
                </span>
                <span class="arrow-time"></span>
                <span class="time2">
                    21:00
                </span>
                <div class="clear"></div>
            </div>
            <div class="phone">
                <span class="phone-header"><b>+7 (495)</b> 540-44-62</span>
                <span class="mail-header"><b>info</b>@mebel-mebel.ru</span>
            </div>
            <div class="phone">
                <span class="phone-header phone_alloka"><b>+7 (495)</b> 223-38-21</span>
                <span class="mail-header"><b>director</b>@mebel-mebel.ru</span>
            </div>

            <div class="clear"></div>
            <!--</section>-->
	</div>
		<!--Конец второй линии шапки-->

		<?$this->getController('Catalog')->getTopMenu()?>

		<?$this->includeBreadcrumbs()?>

	</header>
        <!--Конец контента шапки-->