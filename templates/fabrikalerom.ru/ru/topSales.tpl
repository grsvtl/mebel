<div class="container main-content">
    <h2>Хиты продаж</h2>
    <div id="hot-offer" class="carousel slide" data-ride="carousel">
        <?$topSales = $this->getController('Catalog')->getTopSalesProducts()?>
        <?$topSalesCount = $topSales->count()?>
        <ol class="carousel-indicators">
            <?for ($i = 0; $i <= ceil($topSalesCount / 4) - 1; $i++):?>
            <li data-target="#hot-offer" data-slide-to="<?=$i?>" <?=$i == 0 ? 'class="active"' : ''?>></li>
            <?endfor?>
        </ol>
        <div class="carousel-inner">

            <? $iterator = 0; $lastBlockBegin = 0; foreach($topSales as $object):?>
            <?if($iterator % 4 == 0 || $iterator == 0):?>
            <?$lastBlockBegin = ($topSalesCount - $iterator < 4) ? $topSalesCount-1 : $iterator + 3 ?>
            <div class="item <?=$iterator == 0 ? 'active' : ''?>">
                <div class="row">
                    <?endif?>

                    <div class="col-md-3 col-sm-6 col-xs-6">
                        <?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
                    </div>

                    <?if($iterator == $lastBlockBegin):?>
                </div>
            </div>
            <?endif?>

            <?$iterator++?>
            <?endforeach?>
        </div>
    </div>
    <div class="text-content">
        <h2>Фирменный Интернет-Магазин
            Мебельной компании ЛЕРОМ В МОСКВЕ</h2>
        <p>Лером мебель предлагает всем своим клиентам широкий ассортимент мебели по низким ценам производителя. Наше кредо – это изготовление наиболее востребованных предметов мебели как для гостиных комнат, так и для спальни, детской, прихожих и других помещений жилища. Наши гостиные представляют экзотические серии с не менее экзотическими названиями «Роберта», «Оливия», «Валерия». Экстравагантные молодежные и детские мебельные предметы представляет также серия «Валерия». И, конечно, никого не оставит равнодушными наши прихожие и спальни марки «Мелисса и «Дольче Нотте». Только у нас Вы можете стать обладателями уникальных готовых композиций, которые специально спроектированы нашими мастерами и дизайнерами для вашего удобства. Более того, мебель Лером поможет сделать интерьер индивидуальным, который не только будет соответствовать вашим личным потребностям, но станет исполнением вашей мечты.</p>
    </div>
</div>