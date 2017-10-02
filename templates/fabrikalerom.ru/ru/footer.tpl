<!--footer-->
<footer>
    <div class="footer-bg">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <h4>Свяжитесь с нами</h4>
                    <span><a href="tel:8 800 333 47 01">8 800 333 47 01</a></span>
                    <span><a href="mailto:welcome@pm.ru">welcome@pm.ru</a></span>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-6">
                    <h4>О компании</h4>
                    <a href="/about_lerom/">О нас</a>
                    <a href="/contacts_lerom/">Контакты</a>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-6">
                    <h4>Каталог</h4>
                    <a href="/gostinnye/">Гостинные</a>
                    <a href="/spalni/">Спальни</a>
                    <a href="/detskie/">Детские</a>
                    <a href="/prihojii/">Прихожие</a>
                </div>
                <div class="col-md-2 col-sm-3 col-xs-6">
                    <h4>Меню</h4>
                    <?foreach($this->getController('Article')->getTopMenuArticles() as $item):?>
                    <a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
                    <?endforeach;?>
                </div>
                <div class="col-md-3  col-xs-12 copy-f">
                    <img src="/images/fabrikaLerom/white-logo.png" alt="">
                    <span>©  ООО "Лером" 2017</span>
                </div>
            </div>
        </div>
    </div>
</footer>
<!--footer end-->
</body>
</html>