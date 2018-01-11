<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<script type="text/javascript" src="/js/fabrikaLerom/main.js"></script>

<!--body-->
<main>
    <div class="container main-content">

        <?$this->getController('Catalog')->getLeftMenu()?>

        <div class="right-block">
            <div class="main-banner">
                <div id="main-banner" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#main-banner" data-slide-to="0" class="active"></li>
                        <li data-target="#main-banner" data-slide-to="1" ></li>
                        <li data-target="#main-banner" data-slide-to="2" ></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="item active slide-banner slide-1">
                            <h1 class="banner-h1">Добро пожаловать на сайт фабрики <br>«Лером мебель»</h1>
                            <div class="text-center"><a href="" class="btn btn-white-color">Подробнее о фабрике</a></div>
                        </div>
                        <div class="item  slide-banner">
                            <h1 class="banner-h1">Добро пожаловать на сайт фабрики <br>«Лером мебель»</h1>
                            <div class="text-center"><a href="" class="btn btn-white-color">Подробнее о фабрике</a></div>
                        </div>
                        <div class="item  slide-banner">
                            <h1 class="banner-h1">Добро пожаловать на сайт фабрики <br>«Лером мебель»</h1>
                            <div class="text-center"><a href="" class="btn btn-white-color">Подробнее о фабрике</a></div>
                        </div>
                    </div>
                </div>
            </div>
            <h2>Основные категории</h2>
            <div class="catalog-blocks">
                <div class="row">
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a href="/gostinnye">
                            <img src="/images/fabrikaLerom/gostinye.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('gostinnye');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Гостиные</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a href="/spalni/">
                            <img src="/images/fabrikaLerom/spalny.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('spalni');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Спальни</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a href="/detskie/">
                            <img src="/images/fabrikaLerom/detskie.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('detskie');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Детские</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a href="/prihojii/">
                            <img src="/images/fabrikaLerom/prihijie.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('prihojii');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Прихожие</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a href="/shkafyi-kupe/">
                            <img src="/images/fabrikaLerom/shkaf.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('shkafyi-kupe');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Шкафы-купе</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                    <div class="col-md-4 catalog-list col-sm-6">
                        <a>
                            <img src="/images/fabrikaLerom/new.jpg" alt="">
                            <span class="col-com">
                                <?//=$this->getQuantityByCategoryAlias('modulnyie_detskie')?>
                                <?
//                                echo $quantityGoods = $this->getQuantityByCategoryAlias('modulnyie_detskie');
//                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
                                ?>
                            </span>
                            <span class="name-cat">Новинки!</span>
                            <span class="clear"></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?$this->includeTemplate('benefits')?>
    <?$this->includeTemplate('topSales')?>
    <?$this->includeTemplate('reviews')?>
    <?$this->includeTemplate('indexMap')?>

    <div class="modalsBlock"></div>
</main>
<?$this->includeTemplate('footer')?>