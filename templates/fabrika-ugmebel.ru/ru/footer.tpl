<footer id="footer">
    <div class="container padded">
        <div class="row">
            <div class="col-sm-3 text-center">
                <div class="logo-box">
                    <a href="/"><img src="/images/ugMebel/bg/logo_inverse.png" alt="Мэри-мебель" class="logo"></a>
                    <p class="copyright">Ставропольская мебельная фабрика — "Юг мебель"</p>
                </div>
            </div>

            <?$topMenu = $this->getController('Article')->getTopMenuData()?>
            <?if(count($topMenu)):?>
            <div class="col-sm-3">
                <h5>О нас</h5>
                <ul class="list-unstyled">
                    <?foreach($topMenu as $item):?>
                    <li><a href="<?=$item->getPath()?>"><?=$item->getName()?></a></li>
                    <?endforeach;?>
                </ul>
            </div>
            <?endif?>

            <?$mainCategories = $this->getController('Catalog')->getMainCategoriesWhichHasChildren($this->getUgFabricatorId())?>
            <?if(count($mainCategories)):?>
            <div class="col-sm-3">
                <h5>Каталог</h5>
                <ul class="list-unstyled">
                    <?foreach($mainCategories as $mainCategory):?>
                    <li><a href="<?=$mainCategory->getPath()?>"><?=$mainCategory->getName()?></a></li>
                    <?endforeach;?>
                </ul>
            </div>
            <?endif?>

            <div class="col-sm-3">
                <h5>Наши контакты</h5>

                <div class="footerPhoneAllocaPlace"></div>
                <script src="/js/alloka/getFooterPhoneAlloka.js"></script>

                <br>
                <p><a href="mailto:sale@fabrika-ugMebel.ru">sale@fabrika-ugMebel.ru</a></p>
            </div>
        </div>
    </div>
</footer>
</div>
</body>

</html>