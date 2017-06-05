<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
        
        <section id="aboutCompany">
            <div class="container text-center">
                <h2>Фабрика "Юг Мебель" — уют в вашем доме</h2>
                <p class="text-dark"> Производственные площади расположены в Ставрополе. Компания обладает мощным техническим парком,<br> где 33 000 кв.метров занята оборудованием самого высокого класса.</p>
                <br>
                <div class="row">
                    <div class="col-sm-4">
                        <div class="about-item">
                            <img src="/images/ugMebel/bg/stock.png" alt="">
                            <h4 class="text-uppercase">Склад</h4>
                            <p>У нас свой склад в Москве. Поэтому мы быстро доставим вам товар.</p>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="about-item">
                            <img src="/images/ugMebel/bg/price_and_quality.png" alt="">
                            <h4 class="text-uppercase">Цена и качество</h4>
                            <p>Мебель фабрики "Юг Мебель" обладает отличным сочетанием цена и качество.</p>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="about-item">
                            <img src="/images/ugMebel/bg/best_hardware.png" alt="">
                            <h4 class="text-uppercase">Лучшие комплектующие</h4>
                            <p>Для изготовления фурнитуры используются лучшие комплектующие.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <?$mainCategories = $this->getMainCategoriesWhichHasChildren($this->getUgFabricatorId())?>
        <?if(count($mainCategories)):?>
        <section id="popularModels">
            <div class="container">
                <h2 class="text-center">Популярные модели</h2>
                <div role="tabpanel">
                    <ul class="nav nav-tabs tabs-outline" role="tablist">
                        <?$i=0; foreach($mainCategories as $mainCategory):?>
                        <li role="presentation" class="<?=$i==0 ? 'active' : ''?>">
                            <a href="#<?=$mainCategory->alias?>" aria-controls="home" role="tab" data-toggle="tab"><?=$mainCategory->getName()?></a>
                        </li>
                        <?$i++; endforeach?>
                    </ul>

                    <div class="tab-content">
                        <?$i=0; foreach($mainCategories as $mainCategory):?>
                        <div role="tabpanel" class="tab-pane <?=$i==0 ? 'active' : ''?>" id="<?=$mainCategory->alias?>">
                            <div class="row products">
                                <?$objects = $this->getObjectsByCategorySortPriority($mainCategory, 3)?>
                                <?if($objects->count()): foreach ($objects as $object):?>

                                <?$this->setContent('object', $object)->includeTemplate('catalog/catalogListItem')?>

                                <?endforeach;endif;?>
                            </div>
                            <div class="text-center">
                                <a href="<?=$mainCategory->getPath()?>" class="btn btn-primary btn-lg">Посмотреть <?=mb_strtolower($mainCategory->getName(), "utf-8")?></a>
                            </div>
                        </div>
                        <?$i++; endforeach?>
                    </div>

                </div>
            </div>
        </section>
        <?endif;?>

        <section id="ourShops" class="container-fluid">
            <div class="row">
                <div class="col-md-6 img-cover img-bg" style="background-image: url(/images/ugMebel/bg/panorama.png);">
                </div>
                <div class="col-lg-4 col-md-6 is-content">
                    <h2>Наши магазины</h2>
                    <p>В связи с подделками наших образцов мы выкладываем список наших официальных интернет магазинов!</p>

                    <ul class="list-inline shop-list">
                        <li><a href="#">shop-diamebel.ru</a></li>
                        <li><a href="#">diamebel.net</a></li>
                        <li><a href="#">mebel-mebel.ru</a></li>
                        <li><a href="#">mebelir.ru</a></li>
                        <li><a href="#">stenochka.ru</a></li>
                        <li><a href="#">mebelone.ru</a></li>
                        <li><a href="#">mebelnadom.ru</a></li>
                        <li><a href="#">meb-online.ru</a></li>
                        <li><a href="#">stillhome.ru</a></li>
                    </ul>
                </div>
            </div>
        </section>

        <?$this->getController('Article')->getIndexNews(2)?>

    </main>

<?$this->includeTemplate('footer')?>