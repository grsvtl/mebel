<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="image/png" href="/favicon-dana.ico" />
    <link rel="shortcut icon" type="image/png" href="/favicon-dana.ico" />

	<title><?=$this->getMetaTitle();?></title>
	<meta name="description" content="<?=$this->getMetaDescription();?>" />
	<meta name="keywords" content="<?=$this->getMetaKeywords();?>" />

	<link href='https://fonts.googleapis.com/css?family=Exo+2:400,300,300italic,400italic,700,700italic&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
	<link rel="apple-touch-icon" sizes="57x57" href="/images/danaMebel/favicon/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="/images/danaMebel/favicon/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="/images/danaMebel/favicon/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="/images/danaMebel/favicon/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="/images/danaMebel/favicon/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="/images/danaMebel/favicon/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="/images/danaMebel/favicon/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="/images/danaMebel/favicon/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="/images/danaMebel/favicon/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192"  href="/images/danaMebel/favicon/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/images/danaMebel/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/images/danaMebel/favicon/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/images/danaMebel/favicon/favicon-16x16.png">
	<link rel="manifest" href="favicon/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="/images/danaMebel/favicon/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">

	<?
		$this->getController('imploder')
			->css()
			->add('style.css', '/css/dana-mebel.net/')
			->add('reset.css', '/css/dana-mebel.net/')
			->add('adaptability.css', '/css/dana-mebel.net/')
			->add('jquery-ui-1.10.1.custom.min.css','/js/extensions/ui/')
			->add('errors.css', '/admin/js/base/actions/styles/')
			->add('loaderBlock.css', '/admin/js/base/actions/styles/')
			->printf('compact');
		?>

	<?
		$js = $this->getController('imploder')->js();
		$js
            ->add('jquery.min.js', '/templates/node_modules/jquery/dist/')
            ->add('browserMsieAdapter.js', '/js/')
//            ->add('jquery.js')
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

			->add('jquery.glide.js', '/js/danaMebel/')
			->add('main.js', '/js/danaMebel/')
            ->add('shopcartBar.js', '/js/shopcart/')
            ->add('ajaxCapcha.js', '/js/feedback/')

			->tagsPrint();
		?>

    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-NWVGXQ');</script>
    <!-- End Google Tag Manager -->

    <script type="text/javascript">

        var _alloka = {
            objects: {
                '83dfc19a10234e76': {
                    block_class: 'phone_alloka'
                }
            },
            trackable_source_types:  ["type_in", "referrer", "utm"],
            last_source: false,
            use_geo: true
        };
    </script>
    <script src="http://analytics.alloka.ru/v4/alloka.js" type="text/javascript"></script>


</head>

<?if($this->isDeveloperDomain()):?>
<div style="position: absolute;margin: 60px 0px 0px 0px;background: red;float: left;">ТЕСТОВЫЙ ДОМЕН</div>
<? endif; ?>
