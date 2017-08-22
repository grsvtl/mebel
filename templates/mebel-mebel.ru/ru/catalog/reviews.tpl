<?include('catalogObjectByeBlock.tpl')?>
<section class="info-text-reviews">

    <?if($object->getInfo()->getReviews(true)->count()):?>
    <h2>Отзывы покупателей</h2>
    <?foreach ($object->getInfo()->getReviews(true) as $review):?>
    <div class="reviewWrapper">
        <div class="reviewInner">
            <div class="name">
                <img src="/images/bg/manager_16_grey.png">
                <div><?=$review->getFirstName()?></div>
            </div>
            <div class="estimate">
                <?for($i=1; $i<=$review->getEstimate(); $i++):?>
                <img src="/images/bg/star20blue.png">
                <?endfor?>
                <?for($i=5; $i>$review->getEstimate(); $i--):?>
                    <img src="/images/bg/star20grey.png">
                <?endfor?>
            </div>
        </div>
        <?if($review->getAdventages()):?>
        <div class="reviewInner">
            <span class="title">Достоинства:</span>
            <span><?=$review->getAdventages()?></span>
        </div>
        <?endif?>
        <?if($review->getAdventages()):?>
        <div class="reviewInner">
            <span class="title">Недостатки:</span>
            <span><?=$review->getDisadventages()?></span>
        </div>
        <?endif?>
        <?if($review->getAdventages()):?>
        <div class="reviewInner">
            <span class="title">Комментарии:</span>
            <span><?=$review->getText()?></span>
        </div>
        <?endif?>
    </div>
    <?endforeach?>
    <?endif?>

    <h2>Оставить отзыв</h2>
    <div class="feedback reviewAdd" data-action="/review/ajaxAdd/">
        <input type="hidden" value="<?=$object->getInfo()->id?>" name="domainInfoId">
        <div class="line1">
            <div class="block-input">
                <span>Ваше имя</span>
                <input type="text" name="firstname">
            </div>
            <div class="block-input">
                <span>Ваша оценка</span>
                <select name="estimate">
                    <option></option>
                    <option value="1">1 - &starf; &star; &star; &star; &star;</option>
                    <option value="2">2 - &starf; &starf; &star; &star; &star;</option>
                    <option value="3">3 - &starf; &starf; &starf; &star; &star;</option>
                    <option value="4">4 - &starf; &starf; &starf; &starf; &star;</option>
                    <option value="5">5 - &starf; &starf; &starf; &starf; &starf;</option>
                </select>
            </div>
            <div class="clear"></div>
        </div>
        <div class="line1">
            <div class="block-input">
                <span>Достоинства</span>
                <input type="text" name="adventages">
            </div>
            <div class="block-input">
                <span>Недостатки</span>
                <input type="text" name="disadventages">
            </div>
            <div class="clear"></div>
        </div>
        <div class="line1">
            <span>Комментарии</span>
            <textarea name="text"></textarea>
        </div>
        <div class="line1 bottom">
            <div class="block-input">
                <button class="reviewAddSubmit">Отправить отзыв</button>
            </div>
            <div class="block-input"></div>
        </div>
        <div class="okReviewAdd hide">
            <p>Спасибо!</p>
            <p>Ваш отзыв принят.</p>
            <p>После модерации ваш отзыв появится на сайте.</p>
        </div>
    </div>
</section>