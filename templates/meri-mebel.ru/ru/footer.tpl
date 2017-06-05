            <footer id="footer">
                <div class="container padded">
                    <div class="row">
                        <div class="col-md-3 col-sm-4">
                            <div class="well text-center">
                                <br class="hidden-xs">
                                <br class="hidden-xs">
                                <p class="phone_alloka"><a href="tel:8 800 333 47 01">8 800 333 47 01</a></p>
                                <p><a href="mailto: welcome@pm.ru">welcome@pm.ru</a></p>
                                <p><a href="#">Адреса магазинов</a></p>
                                <br class="hidden-xs">
                                <br class="hidden-xs">
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-8">
                            <div class="row">
                                <?$topMenu = $this->getController('Article')->getTopMenuData()?>
                                <?if($topMenu->count()):?>
                                    <div class="col-md-4 col-sm-4">
                                        <h5>О компании</h5>
                                        <ul class="list-unstyled">
                                            <?foreach($topMenu as $item):?>
                                            <li><a href="<?=$item->getPath()?>"><?=$item->getName()?></li>
                                            <?endforeach;?>
                                        </ul>
                                    </div>
                                <?endif?>
                                <div class="col-md-4 col-sm-4">
                                    <h5>Каталог</h5>
                                    <ul class="list-unstyled">
                                        <li><a href="/gostinnye/">Гостинные</a></li>
                                        <li><a href="/detskie/">Детские</a></li>
                                        <li><a href="/spalni/">Спальни</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <h5>&nbsp;</h5>
                                    <ul class="list-unstyled">
                                        <li><a href="/closet/">Шкафы-купе</a></li>
                                        <li><a href="/gorki/">Горки</a>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 hidden-sm hidden-xs">
                            <br>
                            <a href="/"><img src="/images/meriMebel/bg/logo_inverse.png" alt="Мэри-мебель" class="logo"></a>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="container-fluid text-center copyright">© <?=date("Y")?> г. Мэри-Мебель в Москве</div>
            </footer>
        </div>

    </body>

</html>
