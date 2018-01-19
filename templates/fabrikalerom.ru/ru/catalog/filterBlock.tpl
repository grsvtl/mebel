<?if(isset($colorsArray) && !empty($colorsArray)):?>

        <div class="filtr-list">
            <h3>Доступные цвета:</h3>
            <div class="filtr-block">
                <?foreach ($colorsArray as $color):?>
                    <div class="content-f-b">
                        <? if (file_exists(DIR.'/images/colors/'.$color['description'].'.png') ): ?>
                            <img src="/images/colors/<?=$color['description']?>.png" title="<?=$color['name']?>" width="108" height="54">
                        <?elseif(file_exists(DIR.'/images/colors/'.$color['description'].'.jpg')):?>
                            <img src="/images/colors/<?=$color['description']?>.jpg" title="<?=$color['name']?>"  width="108" height="54">
                        <?elseif(file_exists(DIR.'/images/colors/'.$color['description'].'.gif')):?>
                            <img src="/images/colors/<?=$color['description']?>.gif" title="<?=$color['name']?>"  width="108" height="54">
                        <? endif; ?>
                        <br>
                        <?=$color['name']?>
                    </div>
                <?endforeach?>
            </div>
        </div>

<!--    <form action="" method="GET" class="form-horizontal form-order paramFilterForm" role="form">-->
<!--    <div class="filtr-list">-->
<!--        <h3>Фильтровать по доступным цветам:</h3>-->
<!--        <div class="filtr-block">-->
<!--            --><?//foreach ($colorsArray as $color):?>
<!--                <div class="content-f-b">-->
<!--                    --><?//$inputName = 'param_'.$color['id']?>
<!--                    <input type="checkbox" id="col---><?//=$color['description']?><!--" name="--><?//=$inputName?><!--" --><?//=(isset($_GET[$inputName]) && $_GET[$inputName]) == 'on' ? 'checked' : ''?><!-->
<!--                    <label for="col---><?//=$color['description']?><!--">-->
<!--                        --><?// if (file_exists(DIR.'/images/colors/'.$color['description'].'.png') ): ?>
<!--                            <img src="/images/colors/--><?//=$color['description']?><!--.png" title="--><?//=$color['name']?><!--" width="54" height="54" alt="">-->
<!--                        --><?// endif; ?>
<!--                        <p>--><?//=$this->mb_ucfirst($color['name'])?><!--</p>-->
<!--                    </label>-->
<!--                </div>-->
<!--            --><?//endforeach?>
<!--            <input type="hidden" name="searchParameterActive" value="1">-->
<!--        </div>-->
<!--        <div class="button-block-filter text-center">-->
<!--            <button class="btn red-btn paramFilterButton">Фильтровать</button>-->
<!--            <a-->
<!--                href="--><?//= isset($category)
//                    ?
//                    $category->getPath().( isset($seria) ? $seria->getAlias().'/' : '')
//                    :
//                    '/search/query='.$_GET['query']?><!--" class="btn white-btn"-->
<!--                >-->
<!--                Сбросить фильр-->
<!--            </a>-->
<!--        </div>-->
<!--    </div>-->
<!--    </form>-->
<?endif;?>