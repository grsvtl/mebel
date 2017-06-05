<body class="<?=isset($bodyClass) ? $bodyClass : ''?>">

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NWVGXQ"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->


	<div class="callBackBg"></div>

	<?include('modalAsk.tpl')?>
	<?include 'catalog/orderOneClick.tpl'?>

	<header>

        <div class="shopcartBarPlace"></div>

		<div class="logoLine">
			<a href="/" class="logo"><img src="/images/danaMebel/bg/mainLogo.png" height="44" width="157" alt=""></a>
			<div class="search">
				<input type="text" class="findInput" placeholder="Поиск по сайту" value="<?= isset($this->getGet()['find']) ? $this->getGet()->find : ''?>">
				<button class="findButton"></button>
				<p>Например: <span>гостиные Вена</span></p>
			</div>
			<div class="social">
				<div class="scialLine">
					<a href="#" class="fb"></a>
					<a href="#" class="vk"></a>
					<a href="#" class="od"></a>
				</div>
				<span class="callBack" title="Заказать обратный звонок">Заказать звонок</span>
			</div>

            <div class="headerPhoneAllocaPlace"></div>
            <script src="/js/alloka/getHeaderPhoneAlloka.js"></script>

			<div class="clear"></div>
		</div>

		<?=$this->getController('Article')->getTopMenu()?>

	</header>