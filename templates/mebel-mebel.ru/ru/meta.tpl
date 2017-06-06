<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="icon" type="image/png" href="/favicon.ico" />
		<link rel="shortcut icon" type="image/png" href="/favicon.ico" />
		<title><?=$this->getMetaTitle();?></title>
		<meta name="description" content="<?=$this->getMetaDescription();?>" />
		<meta name="keywords" content="<?=$this->getMetaKeywords();?>" />

        <meta name="yandex-verification" content="eac81aec89057a65" />

		<!-- Google Tag Manager -->
		<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
		new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
		j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
		'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
		})(window,document,'script','dataLayer','GTM-NZ223F4');</script>
		<!-- End Google Tag Manager -->
		
		<!-- Start: Apple devices icons -->
		<link rel="apple-touch-icon" sizes="57x57" href="/images/touch_icons/apple-touch-icon-57.png" />
		<link rel="apple-touch-icon" sizes="72x72" href="/images/touch_icons/apple-touch-icon-72.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="/images/touch_icons/apple-touch-icon-114.png" />
		<link rel="apple-touch-icon" sizes="144x144" href="/images/touch_icons/apple-touch-icon-144.png" />
		<!-- End: Apple devices icons -->

		<?
		$this->getController('imploder')
			->css()
			->add('style.css', '/css/vn-mebel.ru/')
			->add('reset.css', '/css/vn-mebel.ru/')
			->add('jquery-ui-1.10.1.custom.min.css','/js/extensions/ui/')
			->add('errors.css', '/admin/js/base/actions/styles/')
			->add('loaderBlock.css', '/admin/js/base/actions/styles/')
			->printf('compact');
		?>

		<script type="text/javascript">
			var date_format = '<?=DATE_FORMAT?>';
			var dir_https   = '<?=DIR_HTTPS?>';
			var dir_http    = '<?=DIR_HTTP?>';
			var part        = '<?//=($this->isPart($this->getPart())) ? $this->getPart() : '';?>';
			var controller  = '<?=$this->getMainController()?>';
			var action      = '<?=$this->action?>';
		</script>

		<?
		$js = $this->getController('imploder')->js();
		$js->add('jquery.js')
			->add('jquery.deparam.js', '/admin/js/jquery/extensions/')
			->add('jquery.htmlFromServer.js', '/admin/js/jquery/extensions/')
			->add('jquery.autoScroll-1.0.js', '/admin/js/jquery/extensions/')
			->add('loaderBlock.class.js', '/admin/js/base/actions/')
			->add('slides.min.jquery.js')
			->add('jquery-ui-1.10.1.custom.min.js','/js/extensions/ui/')
//			->add('js.js')
			->add('ajaxLoader.class.js')
			->add('loaderLight.class.js', '/admin/js/base/actions/')
			->add('errors.class.js','/admin/js/base/actions/')
			->add('error.class.js','/admin/js/base/actions/')
			->add('form.class.js','/admin/js/base/actions/')
			->add('buttons.class.js','/admin/js/base/actions/')
			->add('jquery.inputmask.js','/admin/js/jquery/extensions/')
			->add('loader.class.js','/admin/js/base/actions/')
			->add('shopcartHandler.js', '/js/shopcart/')
			->add('shopcart.class.js', '/js/shopcart/')
            ->add('ajaxCapcha.js', '/js/feedback/')
            ->add('catalog.js', '/js/catalog/')
			->tagsPrint();
		?>

<!--		<script type="text/javascript">

		</script>-->

		<meta name='yandex-verification' content='5537042e65106f1b' />
		<script type="text/javascript">
         
        var _alloka = {
        objects: {
            'cf3174e4383ca150': {
                block_class: 'phone_alloka'
            }
        },
        trackable_source_types:  ["utm"],
        last_source: false
    };
		</script>
		<script src="https://analytics.alloka.ru/v4/alloka.js" type="text/javascript"></script>
		<script>
		  function metrika(goal){
			ga("send", "event", "alloka", "call");
			yaCounter26379288.reachGoal(goal);
		  };
		</script>
	</head>

<?if($this->isDeveloperDomain()):?>
<div style="position: absolute;margin: 60px 0px 0px 0px;background: red;float: left;">ТЕСТОВЫЙ ДОМЕН</div>
<? endif; ?>