<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <main id="main">

        <?if($mainSliderGoods->count()):?>
        <section class="container">
            <br>
            <div id="mainCarousel" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <?$i=0; foreach($mainSliderGoods as $mainGood):?>
                        <li data-target="#mainCarousel" data-slide-to="<?=$i?>" class="<?= $i==0 ? 'active' : ''?>"></li>
                    <?$i++; endforeach?>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <?$i=0; foreach($mainSliderGoods as $mainGood):?>
                    <div class="item <?= $i==0 ? 'active' : ''?>">
                        <a href="<?=$mainGood->getPath()?>" class="img-cover" style="background-image: url(<?=$mainGood->getFirstPrimaryImage()->getFocusImage('1340x400', 'watermark')?>)"></a>
                        <div class="carousel-caption">
                            <h2><?=$mainGood->getName()?></h2>
                            <br class="hidden-xs">
                            <p><?=$mainGood->getSmallDescription()?></p>
                            <br class="hidden-xs">
                            <a href="<?=$mainGood->getPath()?>" type="button" class="btn btn-primary btn-lg">Подробнее</a>
                        </div>
                    </div>
                    <?$i++; endforeach?>
                </div>
            </div>
        </section>
        <?endif?>

        <section id="catalog">
            <div class="container">
                <h2 class="text-center">Каталог товаров</h2>
                <br>

                <?$categoriesConfig = new \modules\catalog\categories\CatalogCategoryConfig();?>

                <div class="row catalog">
                    <div class="col-sm-6">
                        <?$category = $this->getCategoryById($categoriesConfig::GOSTINNYE_CATEGORY_ID);?>
                        <a href="<?=$category->getPath()?>" class="img-cover-big img-bordered" style="background-image: url(/images/meriMebel/bg/living_rooms.png);"></a>
                        <h5><a href="<?=$category->getPath()?>" class="text-dark">Гостинные</a></h5>
<!--                        <a href="#" class="text-orange pull-right catalog-models-count">Моделей — <span class="count-models">11</span></a>-->
                    </div>
                    <div class="col-sm-6">
                        <?$category = $this->getCategoryById($categoriesConfig::SPALNI_CATEGORY_ID);?>
                        <a href="<?=$category->getPath()?>" class="img-cover-big img-bordered" style="background-image: url(/images/meriMebel/bg/bedrooms.png);"></a>
                        <h5><a href="<?=$category->getPath()?>" class="text-dark">Спальни</a></h5>
                        <!--                        <a href="" class="text-orange pull-right catalog-models-count">Моделей — <span class="count-models"></span></a>-->
                    </div>
                </div>
                <br>
                <div class="row catalog">
                    <div class="col-md-4 col-sm-6">
                        <?$category = $this->getCategoryById($categoriesConfig::DETSKIE_CATEGORY_ID);?>
                        <a href="<?=$category->getPath()?>" class="img-cover img-bordered" style="background-image: url(/images/meriMebel/bg/childrens_furniture.png);"></a>
                        <h5><a href="<?=$category->getPath()?>" class="text-dark">Детская мебель</a></h5>
<!--                        <a href="#" class="text-orange pull-right catalog-models-count">Моделей — <span class="count-models">11</span></a>-->
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <?//$category = $this->getCategoryById($categoriesConfig::SHKAFI_DLYA_SPALNI_CATEGORY_ID);?>
                        <a href="/closet/" class="img-cover img-bordered" style="background-image: url(/images/meriMebel/bg/wardrobes.png);"></a>
                        <h5><a href="/closet/" class="text-dark">Шкафы-купе</a></h5>
<!--                        <a href="#" class="text-orange pull-right catalog-models-count">Моделей — <span class="count-models">11</span></a>-->
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <?$category = $this->getCategoryById($categoriesConfig::STENKI_CATEGORY_ID);?>
                        <a href="/gorki/" class="img-cover img-bordered" style="background-image: url(/images/meriMebel/bg/slides.png);"></a>
                        <h5><a href="/gorki/" class="text-dark">Горки</a></h5>
<!--                        <a href="#" class="text-orange pull-right catalog-models-count">Моделей — <span class="count-models">11</span></a>-->
                    </div>
                </div>
                </br>
            </div>
        </section>

        <link rel="stylesheet" href="/css/meri-mebel.ru/content/articles/showroomIndex.css">
        <section id="showroom">
            <div class="container margin-top-12">
                <div class="showroom bordered text-dark">
                    <h2>Наш Шоу-рум</h2>
                    <p>У нас есть свой шоу-рум где представленно большое количество <br>моделей мебели.</p>
                    <p>Ждем вас по адресу <strong>Каширское шоссе, дом 61, корпус 3А,</strong> каждый день <br>с 10 до 20 часов</p>
                    <p>&nbsp;</p>
                    <a href="/showroom-meri/" class="btn btn-primary">Подробнее</a>
                </div>
            </div>
        </section>

        <section id="services">
            <div class="container">
                <h2 class="text-center">Мы предлагаем</h2>
                <br>
                <div class="row services">
                    <div class="col-md-3 col-sm-6">
                        <div class="service bordered text-center">
                            <img src="/images/meriMebel/bg/garantee.png" alt="">
                            <br>
                            <br>
                            <h4 class="text-uppercase">2 Года гарантии</h4>
                            <br>
                            <p class="text-left">Гарантия фабрики 2 года с даты покупки, а также послегарантийное обслуживание нашими специалистами</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="service bordered text-center">
                            <img src="/images/meriMebel/bg/delivery.png" alt="">
                            <br>
                            <br>
                            <h4 class="text-uppercase">Доставка 1-2 дня</h4>
                            <br>
                            <p class="text-left">Доставим в кротчайшие сроки, в зависимости от того в каком районе вы живете.</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="service bordered text-center">
                            <img src="/images/meriMebel/bg/assembly.png" alt="">
                            <br>
                            <br>
                            <h4 class="text-uppercase">Профессиональная сборка</h4>
                            <p class="text-left">Организация профессиональной сборки уже на следующий день после доставки мебели!</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="service bordered text-center">
                            <img src="/images/meriMebel/bg/sertification.png" alt="">
                            <br>
                            <br>
                            <h4 class="text-uppercase">Сертифицированная мебель</h4>
                            <p class="text-left">Сертифицированная и подлинная мебель — без подделок!</p>
                        </div>
                    </div>
                </div>
                <br class="hidden-xs">
                <br class="hidden-xs">
            </div>
        </section>
        <section id="dillers">
            <div class="container">
                <h2 class="text-center">Наши официальные диллеры</h2>
                <p class="text-center">
                    Если Вы хотите стать нашим официальным дилером вне Московского региона, то просим связаться
                    <br> с нами по след. контактным данным: <b class="text-dark phone_alloka">8 (495) 120-05-15</b>
                </p>
            </div>
            <br>
            <div class="img-cover img-bordered dillers-on-map-image" style="background-image: url(/images/meriMebel/bg/dillers_on_map.png);"></div>
            <br class="hidden-xs">
            <br class="hidden-xs">
        </section>

        <?if($popularGoods->count()):?>
        <section id="popularProducts" class="container-fluid">
            <div class="container">
                <h2 class="text-center">Популярные товары</h2>
                <br>
                <div class="row popular-products">
                    <?foreach($popularGoods as $good):?>
                    <div class="col-md-4 col-sm-6 popular-product-card">
                        <a href="<?=$good->getPath()?>" class="img-cover" style="background-image: url(<?=$good->getFirstPrimaryImage()->getImage('390x265', 'watermark')?>);"></a>
                        <h5><a href="<?=$good->getPath()?>"><?=$good->getName()?></a></h5>
                        <p class="popular-products--price"><?=number_format( $good->getShowPrice(), 0, ',', ' ' )?> <span class="glyphicon glyphicon-ruble"></span></p>
                    </div>
                    <?endforeach?>
                </div>
                <br>
            </div>
        </section>
        <?endif?>

        <?$this->getController('Article')->getIndexReviews(5)?>

    </main>

<?$this->includeTemplate('footer')?>