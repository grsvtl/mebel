<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<script type="text/javascript" src="/js/fabrikaLerom/main.js"></script>

<!--body-->
<main>
    <div class="container main-content">

        <?$this->getController('Catalog')->getLeftMenu()?>

        <div class="right-block">

            <?$indexImages = $indexArticle->getImagesByObjectId()?>
            <?if($indexImages->count()):?>
            <div class="main-banner">
                <div id="main-banner" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <?$j=0; foreach ($indexImages as $indexImage):?>
                        <li data-target="#main-banner" data-slide-to="<?=$j?>" <?= $j==0 ? 'class="active"' : ''?>></li>
                        <?$j++; endforeach;?>
                    </ol>
                    <div class="carousel-inner">
                        <?$j=0; foreach ($indexImages as $indexImage):?>
                        <a href="<?=$indexImage->description?>" class="item slide-banner <?= $j==0 ? 'slide-0 active' : ''?>"
                             style="background:#333 url(<?=$indexImage->getImage('830x0')?>) no-repeat center; cursor: hand"
                        >

                        </a>
                        <?$j++; endforeach;?>
                    </div>
                </div>
            </div>
            <?endif;?>

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
                        <a href="/new-lerom-products/">
                            <img src="/images/fabrikaLerom/new.jpg" alt="">
                            <span class="col-com">
                                <?
                                echo $quantityGoods = $this->getQuantityByCategoryAlias('new-lerom-products');
                                echo ' '.\core\utils\Utils::declension($quantityGoods, array("композиция", "композиции", "композиций"));
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
<!--    --><?//$this->includeTemplate('reviews')?>
    <?$this->includeTemplate('indexMap')?>

    <div class="modalsBlock"></div>
</main>
<?$this->includeTemplate('footer')?>