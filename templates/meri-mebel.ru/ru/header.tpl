<body>

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-N5GPZ6H".
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

    <div class="callBackBg"></div>
    <?include 'catalog/orderOneClick.tpl'?>

    <div class="main-container">
        <header id="header">
            <nav id="navbarTop" class="navbar navbar-inverse" role="navigation">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-top">
                            <span class="glyphicon glyphicon-menu-hamburger"></span>
                        </button>
                        <a class="navbar-brand visible-md visible-xs" href="/">Мэри-Мебель</a>
                    </div>

                    <?=$this->getController('Article')->getTopMenu()?>

                    <div class="shopcartBarPlace"></div>

                </div>
            </nav>
            <div class="container padded">
                <div class="row">
                    <div class="col-lg-2 col-sm-4 visible-lg visible-sm info--logo text-center">
                        <a href="/"><img src="/images/meriMebel/bg/logo.png" alt=""></a>
                    </div>
                    <div class="col-lg-5 col-md-6 col-sm-4">
                        <div class="row">
                            <div class="col-md-6 info--search">
                                <div class="form-group has-feedback search-container">
                                    <input type="search" class="form-control findInput search" id="search" value="<?=$this->getGet()['word']?>" placeholder="Поиск по сайту">
                                    <span class="glyphicon glyphicon-search form-control-feedback findButton" aria-hidden="true"></span>
                                </div>
                            </div>
                            <div class="col-md-6 text-center info--link-to-stock">
                                <a href="/contakts/" class="btn btn-orange btn-block"><img src="/images/meriMebel/bg/map.png">&nbsp;&nbsp;<span>Как проехать к складу</span></a>
                            </div>
                        </div>
                    </div>
                    <div id="infoContainer" class="col-lg-5 col-md-6 col-sm-4 text-dark">
                        <div class="row">
                            <div class="col-md-6 col-sm-12 col-xs-6 info--schedule">
                                <div class="row">
                                    <div class="col-sm-2 hidden-xs"><img src="/images/meriMebel/bg/clock.png" alt=""></div>
                                    <div class="col-sm-10">
                                        <b>График работы</b>
                                        <p>Пн-Сб. &nbsp;&nbsp;&nbsp;9:00-21:00</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12 col-xs-6 info--contacts">
                                <div class="row">
                                    <div class="col-sm-2 hidden-xs"><img src="/images/meriMebel/bg/phone.png" alt=""></div>
                                    <div class="col-sm-10">

                                        <div class="headerPhoneAllocaPlace"></div>
                                        <script src="/js/alloka/getHeaderPhoneAlloka.js"></script>
										<div class="phone_alloka" style="display:none;">(495) 150-01-36</div>

                                        <p><a href="mailto: info@meri-mebel.ru">info@meri-mebel.ru</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <nav id="navbarMain" class="navbar navbar-default" role="navigation">
                <div class="container">

                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-products">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </button>
                        <span class="navbar-brand visible-xs">Продукция</span>
                    </div>

                    <?
                        $mainCategories = $this->getController('Catalog')->getMainCategoriesWhichHasChildren( $this->getController('Catalog')->getMeriFabricatorId() );
                        if(count($mainCategories)):
                    ?>
                    <div class="collapse navbar-collapse navbar-products">
                        <ul class="nav navbar-nav">
                            <?foreach ($mainCategories as $mainCategory):?>
                            <li class="<?= $this->getRequest()['action']==$mainCategory->alias  ?  'active'  :  ''?>">
                                <a href="<?=$mainCategory->getPath()?>"><?=$mainCategory->getName()?></a>
                            </li>
                            <?endforeach;?>
                            <li class="<?= $this->getRequest()['action']=='closet'  ?  'active'  :  ''?>">
                                <a href="/closet/">ШКАФЫ-КУПЕ</a>
                            </li>
                            <li class="<?= $this->getRequest()['action']=='gorki'  ?  'active'  :  ''?>">
                                <a href="/gorki/">Горки</a>
                            </li>
                        </ul>
                    </div>
                    <?endif?>

                </div>
            </nav>
        </header>