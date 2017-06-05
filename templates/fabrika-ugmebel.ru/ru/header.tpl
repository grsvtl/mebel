<body>

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PW4SHLK"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<div class="callBackBg"></div>
<?include('modalAsk.tpl')?>
<?include 'catalog/orderOneClick.tpl'?>

<div class="shopcartBarPlace"></div>

<div class="main-container">
    <header id="header">
        <nav id="navbarTop" class="navbar navbar-inverse" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-top">
                        <span class="glyphicon glyphicon-menu-hamburger"></span>
                    </button>
                    <a class="navbar-brand visible-md visible-xs" href="/">Юг мебель</a>
                </div>

                <?=$this->getController('Article')->getTopMenu()?>

                <div class="shopcartBarPlace"></div>

            </div>
        </nav>
        <div class="container padded">
            <div class="row">
                <div class="col-md-2 hidden-md hidden-sm">
                    <a href="/"><img src="/images/ugMebel/bg/logo.png" alt=""></a>
                </div>
                <div class="col-lg-10 col-sm-12">
                    <div class="row info">
                        <div class="col-md-3 hidden-sm info--contact-us">
                            <a class="btn btn-default btn-lg btn-block callBack">
                                <span class="glyphicon glyphicon-phone-alt"></span>&nbsp;&nbsp;Связаться с нами
                            </a>
                        </div>
                        <div class="col-md-3 col-sm-4 info--stock">
                            <div class="row">
                                <div class="col-sm-1 hidden-xs">
                                    <span class="glyphicon glyphicon-home"></span>
                                </div>
                                <div class="col-sm-10 text-uppercase">
                                    <label>Основной cклад:</label><br>
                                    <address><a href="">г. Зеленоград,<br> <span class="text-nowrap">ул. Середниковская, стр. 2</span></a></address>
                                </div>
                            </div>
                        </div>

                        <div class="headerPhoneAllocaPlace"></div>
                        <script src="/js/alloka/getHeaderPhoneAlloka.js"></script>

                    </div>
                </div>
            </div>
        </div>
    </header>
    <main id="main">

        <?if($this->isIndex()):?>
        <section id="sectionGallery">
            <div class="gallery">
                <a href="/spalni/" class="img-cover" style="background-image: url(/images/ugMebel/bg/bedroom.png)" alt="">
                    <h4 class="text-center">Спальни</h4>
                </a>
                <a href="/gostinnye/" class="img-cover" style="background-image: url(/images/ugMebel/bg/living_room.png)" alt="">
                    <h4 class="text-center">Гостиные</h4>
                </a>
                <a href="/kuhni/" class="img-cover" style="background-image: url(/images/ugMebel/bg/kitchen.png)" alt="">
                    <h4 class="text-center">Кухни</h4>
                </a>
            </div>
        </section>
        <?else:?>
        <nav id="catalogNavigation">
            <ul class="nav nav-justified">
                <li><a href="/spalni/">Спальни</a></li>
                <li><a href="/gostinnye/">Гостиные</a></li>
                <li><a href="/kuhni/">Кухни</a></li>
            </ul>
        </nav>
        <?$this->includeBreadcrumbs()?>
        <?endif?>