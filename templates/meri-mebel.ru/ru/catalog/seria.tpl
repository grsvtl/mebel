<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
    <main id="main">
        <div class="container">
            <br>
            <?$this->includeBreadcrumbs()?>
            <h1 class="text-center"><?=$h1?></h1>
            <br>
            <div class="products-catalog">

                <?if(count($objects)):?>
                    <div class="filter-container">
                        <div class="sortBy">
                            <span class="span filter-label">Сортировать:</span>&nbsp;&nbsp;
                            <a
                                <?if($sorting['current']=='price' && $sorting['direction']=='up'):?>
                                    class="active"
                                <?else:?>
                                    href="<?=\core\utils\Utils::sgp($_SERVER['REQUEST_URI'], 'sortBy%5Bprice%5D', 'up');?>"
                                <?endif?>
                            >
                                от дешевого к дорогому
                            </a>
                            <a
                                <?if($sorting['current']=='price' && $sorting['direction']=='down'):?>
                                    class="active"
                                <?else:?>
                                    href="<?=\core\utils\Utils::sgp($_SERVER['REQUEST_URI'], 'sortBy%5Bprice%5D', 'down');?>"
                                <?endif?>
                            >
                                от дорогого к дешевому
                            </a>
                            <a
                                <?if($sorting['current']=='priority'):?>
                                    class="active"
                                <?else:?>
                                    href="<?=\core\utils\Utils::ragp($_SERVER['REQUEST_URI']);?>"
                                <?endif?>
                            >
                                по популярности
                            </a>
                        </div>
                    </div>
                    <br />

                    <section class="row products">
                        <?foreach($objects as $object):?>
                            <div class="col-md-4 col-sm-6">
                                <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
                                    <a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
                                        Редактировать [id = <?=$object->id?>]
                                    </a>
                                <?endif?>
                                <div class="product-item">
                                    <?include('bands/bandBlock.tpl')?>
                                    <a
                                        href="<?=$object->getPath()?>"
                                        class="img-cover"
                                        style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('0x200', 'watermark')?>);"
                                    ></a>
                                    <div class="product-item-details">
                                        <?if (!$object->getOffer()):?>
<!--                                            <div class="div-margin-product-item-details"></div>-->
                                        <?endif?>
                                        <h5><a href="<?=$object->getPath()?>" class="product--name"><?=$object->getName()?></a></h5>
                                        <div>
                                            <div class="row">
                                                <div class="col-md-7">
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <span class="product--price"><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></span>
                                                            <span class="glyphicon glyphicon-ruble"></span>
                                                        </div>
                                                        <div class="col-xs-12">
                                                            <?if ($object->getOffer()):?>
                                                                <span class="old_price pull-left">
                                                                <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                                                                    <span class="glyphicon glyphicon-ruble"></span>
                                                                </span>
                                                            <?endif;?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <a href="<?=$object->getPath()?>" class="btn btn-default btn-sm pull-right">Подробнее</a>
                                                </div>
                                            </div>
                                            <?if ($object->getOffer()):?>
                                                <span class="offer_only">Только в период акции!</span>
                                            <?endif;?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?endforeach?>
                    </section>
                    </br>
                <?else:?>
                    <p>Таких товаров не существует. Попробуйте поискать в разделах каталога или воспользуйтесь поиском вверху страницы.</p>
                <?endif?>

            </div>
        </div>
    </main>
<?$this->includeTemplate('footer')?>