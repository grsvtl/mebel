<!DOCTYPE html>
<html lang="ru">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><?=$this->getMetaTitle();?></title>
    <meta name="description" content="<?=$this->getMetaDescription();?>" />
    <meta name="keywords" content="<?=$this->getMetaKeywords();?>" />

    <link href="/templates/node_modules/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <?
    $this->getController('imploder')
    ->css()
    ->add('styles.css', '/css/'.$this->getCurrentDomainAlias().'/')
    ->add('styles-adaptive.css', '/css/'.$this->getCurrentDomainAlias().'/')
    ->add('errors.css', '/admin/js/base/actions/styles/')
    ->add('loaderBlock.css', '/admin/js/base/actions/styles/')
    ->printf('compact');
    ?>

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script type="text/javascript">
        var date_format = '<?=DATE_FORMAT?>';
        var dir_https   = '<?=DIR_HTTPS?>';
        var dir_http    = '<?=DIR_HTTP?>';
        var part        = '<?//=($this->isPart($this->getPart())) ? $this->getPart() : '';?>';
        var controller  = '<?=$this->getMainController()?>';
        var action      = '<?=$this->action?>';
    </script>

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,700&amp;subset=cyrillic" rel="stylesheet">

    <?
    $js = $this->getController('imploder')->js();
    $js
        ->add('jquery.min.js', '/templates/node_modules/jquery/dist/')
        ->add('bootstrap.min.js', '/templates/node_modules/bootstrap/dist/js/')
        ->add('ajaxCapcha.js', '/js/feedback/')
        ->add('modalOrderCall.js', '/js/lerom/')
        ->add('jquery.htmlFromServer.js', '/admin/js/jquery/extensions/')
        ->add('jquery.autoScroll-1.0.js', '/admin/js/jquery/extensions/')
        ->add('loaderBlock.class.js', '/admin/js/base/actions/')
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
        ->add('shopcartBar.js', '/js/shopcart/')
        ->add('browserMsieAdapter.js', '/js/')
        ->tagsPrint();
    ?>

</head>