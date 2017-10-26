<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Content-Language" content="ru">
        <meta name="Description" content="">
        <meta name="Keywords" content="">
        <meta name="Revisit-After" content="15 days">
        <title>Webdelo Administration Panel / Каталог / Редактирование приоритетов</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="/node_modules/bootstrap/dist/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="/node_modules/bootstrap/dist/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/modules/catalog/priority/css/sorting.css">
    </head>
    <body>


    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/admin/catalog/"><img src="/admin/images/logo/logo.png" alt="" style="margin-top: -8px;"/></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <form class="navbar-form navbar-right">
                    <a href="/admin/catalog/" class="btn btn-default">
                        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span> Назад
                    </a>
                </form>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h3>Редактирование приоритетов <small>по домену, категории, серии</small></h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form id="formFilters" method="get">
                    <div class="row">
                        <div class="col-md-2">
                            <select name="domainAlias" id="domainAlias" style="width: 100%;">
                                <option value="">Выберите домен</option>
                                <? foreach ( $domains->getObjects() as $domain ): ?>
                                    <option <?=$this->getGET()['domainAlias']==$domain->domainName?'selected':''?> value="<?=$domain->domainName?>"><?=$domain->domainName?></option>
                                <? endforeach; ?>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select name="categoryId" id="categoryId" style="width: 100%;">
                                <option value="0">Выберите категорию</option>
                                <?php if ($objects->getMainCategories()->count() != 0): foreach($objects->getMainCategories() as $categoryObject):?>
                                    <option value="<?=$categoryObject->id?>" <?=($categoryObject->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>
                                        <?=$categoryObject->name?> (<?=$categoryObject->alias?> - <?=$categoryObject->id?>)
                                    </option>
                                    <?php if ($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
                                        <option value="<?=$children->id?>" <?=($children->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>
                                            &nbsp;&nbsp;|-&nbsp;<?=$children->name?> (<?=$children->alias?> - <?=$children->id?>)
                                        </option>
                                        <?php if ($children->getChildren() != NULL): foreach($children->getChildren() as $children2):?>
                                            <option value="<?=$children2->id?>" <?=($children2->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>
                                                &nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?> (<?=$children2->alias?> - <?=$children2->id?>)
                                            </option>
                                        <?php endforeach; endif;?>
                                    <?php endforeach; endif;?>
                                <?php endforeach; endif;?>
                            </select>
                        </div>
                        <? if (isset($series)) : ?>
                        <div class="col-md-2">
                            <select name="seriaId" id="seria" style="width: 100%;">
                                <option value="">Выберите серию</option>
                                <? foreach ( $series as $seriaItem ): ?>
                                    <option <?=$this->getGET()['seriaId']==$seriaItem->id?'selected':''?> value="<?=$seriaItem->id?>">
                                        <?=$seriaItem->value?> (<?=$seriaItem->alias?> - <?=$seriaItem->id?>)
                                    </option>
                                <? endforeach; ?>
                            </select>
                        </div>
                        <? endif; ?>
                    </div>
                </form>
            </div>
        </div>
        <? if ( !$category || !$domainAlias ) : ?>
        <div class="row">
            <div class="col-md-12">
                <p class="alert alert-info">
                    Пожалуйста, выберите домен, категорию<?=$seria?', серию':''?>.
                </p>
            </div>
        </div>
        <? elseif( $category && $domainAlias && (!$seria && $domainAlias!='mebel-mebel.ru' ) ) : ?>
            <div class="row">
                <div class="col-md-12">
                    <p class="alert alert-info">
                        Пожалуйста выберите серию
                    </p>
                </div>
            </div>
        <? endif; ?>

        <? if ( $category && $domainAlias && $seria ) : ?>
            <div class="row">
                <div class="col-md-12 itemsContainer">
                    <? $this->renderItems( $domainAlias, $category, $seria ) ?>
                </div>
            </div>
        <? elseif ( $category && $domainAlias && (!$seria && $domainAlias=='mebel-mebel.ru' ) ): ?>
            <div class="row">
                <div class="col-md-12 itemsContainer">
                    <? $this->renderMebelMebelItems( $domainAlias, $category ) ?>
                </div>
            </div>
        <? endif; ?>
    </div>


    </body>
</html>


<script src="/node_modules/jquery/dist/jquery.min.js"></script>
<script src="/node_modules/jqueryui/jquery-ui.min.js"></script>
<script src="/modules/catalog/priority/js/priority.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>

