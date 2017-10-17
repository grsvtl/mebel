<form action="" method="GET" class="form-horizontal form-order paramFilterForm" role="form">
<div class="filtr-list">
    <h3>Фильтровать по доступным цветам:</h3>
    <div class="filtr-block">
        <?foreach ($activeSearchParameters as $searchParam):?>
        <div class="content-f-b">
            <?$parameter = $searchParam->getParameterValue();?>
            <?$inputName = 'param_'.$parameter->id?>
            <input type="checkbox" id="col-<?=$parameter->description?>" name="<?=$inputName?>" <?=(isset($_GET[$inputName]) && $_GET[$inputName]) == 'on' ? 'checked' : ''?>>
            <label for="col-<?=$parameter->description?>">
                <? if (file_exists(DIR.'/images/colors/'.$parameter->description.'.png') ): ?>
                <img src="/images/colors/<?=$parameter->description?>.png" title="<?=$parameter->name?>" width="54" height="54" alt="">
                <? endif; ?>
                <p><?=$this->mb_ucfirst($parameter->value)?></p>
            </label>
        </div>
        <?endforeach?>
        <input type="hidden" name="searchParameterActive" value="1">
    </div>
    <div class="button-block-filter text-center">
        <button class="btn red-btn paramFilterButton">Фильтровать</button>
        <a
            href="<?= isset($category)
                ?
                $category->getPath().( isset($seria) ? $seria->getAlias().'/' : '')
                :
                '/search/query='.$_GET['query']?>" class="btn white-btn"
            >
            Сбросить фильр
        </a>
    </div>
</div>
</form>