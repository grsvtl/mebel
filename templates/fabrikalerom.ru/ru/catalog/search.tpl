<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<script type="text/javascript" src="/js/fabrikaLerom/catalog.js"></script>

<main>
    <div class="container main-content">

        <?$this->getController('Catalog')->getLeftMenu()?>

        <div class="right-block">
            <?$this->includeBreadcrumbs()?>

            <h1><?=$h1?></h1>

            <?//$this->includeTemplate('catalog/filterBlock')?>

            <div class="tab-catalog">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <li class="active" data-tab="composition"><a href="#composition" data-toggle="tab">Товары</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="composition">
                        <div class="row">
                            <?foreach ($objects as $object):?>
                            <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                <?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
                            </div>
                            <?endforeach?>
                        </div>
                    </div>
                </div>
                <div class="navigation text-center">
                    <span class="see-more-offers btn loadMoreButton">Показать еще 9 шт. </span>
                </div>
                <div class="text-content-inset">
                    <h3>Заголовок сео текса</h3>
                    <p>Оригинальное сочетание текстуры мебели и ярких вставок в мебели для детской "Валерия" создает неповторимое праздничное настроение.</p>
                    <p>Кровать для детей младшего возраста с трех сторон защищена спинками и укомплектована двумя вместительными ящиками. Подростковый вариант отличается изящным изголовьем с вместительной нишей для хранения белья.</p>
                    <p>Валерия – дипломант международного смотра-конкурса российской мебели в номинации ”Баланс цены и качества”, обладатель Гран-при ОХТС, дипломант программы ”100 лучших товаров России” производства "Лером".</p>
                </div>
            </div>
        </div>

    </div>
</main>

<span class="listLevel" data-value="<?=$level?>"></span>
<span class="query" data-value="<?=$query?>"></span>
<span class="paramSearchOn" data-value="<?=$isParameterSearchActive?>"></span>


<?$this->includeTemplate('footer')?>