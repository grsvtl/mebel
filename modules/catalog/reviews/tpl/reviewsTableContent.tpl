<script src="/admin/js/base/actions/inputToggler.class.js"></script>
<script src="/modules/catalog/reviews/js/reviews.js"></script>
<link rel="stylesheet" type="text/css" href="/modules/catalog/subGoods/css/style.css">

<div class="goodsTable">
    <p class="title">Список отзывов:</p>
    <?$reviews = $domainInfo->getReviews();?>
    <table class="goodsList">
        <tr class="top">
            <td>&nbsp;#&nbsp;</td>
            <td class="borderLeft">Имя</td>
            <td class="borderLeft">Достоинства</td>
            <td class="borderLeft">Недостатки</td>
            <td class="borderLeft">Комментарий</td>
            <td class="borderLeft">Оценка</td>
            <td class="borderLeft">Статус</td>
            <td class="borderLeft"><img src="/admin/images/bg/trash.png" alt="Удалить" /></td>
        </tr>
        <?if ($reviews->count()):?>
        <? $i=1; foreach($reviews as $review):?>
        <tr class="line currentReviews">
            <td class="center"><?=$i?></td>
            <td class="center toInput" data-reviewId="<?=$review->id?>" name="firstname"><?=$review->getFirstName()?></td>
            <td class="center">
                <textarea name="adventages" data-reviewId="<?=$review->id?>"><?=$review->getAdventages()?></textarea>
            </td>
            <td class="center">
                <textarea name="disadventages" data-reviewId="<?=$review->id?>"><?=$review->getDisadventages()?></textarea>
            </td>
            <td class="center">
                <textarea name="text" data-reviewId="<?=$review->id?>"><?=$review->getText()?></textarea>
            </td>
            <td class="center">
                <select name="estimate" data-reviewId="<?=$review->id?>">
                    <option></option>
                    <?for($j=1; $j<=5; $j++):?>
                        <option value="<?=$j?>" <?= $j==$review->getEstimate() ? 'selected' : ''?>><?=$j?></option>
                    <?endfor;?>
                </select>
            </td>
            <td class="center">
                <select name="statusId" data-reviewId="<?=$review->id?>">
                    <?foreach($review->getStatuses() as $status):?>
                        <option value="<?=$status->id?>" <?= $status->id==$review->statusId ? 'selected' : ''?>>
                            <?=$status->name?>
                        </option>
                    <?endforeach;?>
                </select>
            </td>
            <td class="center">
                <a class="pointer delete deleteReview" data-reviewId="<?=$review->id?>" title="Удалить отзыв"></a>
            </td>
        </tr>
        <? $i++; endforeach?>
        <? endif;?>
        <tr class="line addReviewForm">
            <input type="hidden" name="domainInfoId" value="<?=$domainInfo->id?>">
            <td class="center"></td>
            <td class="center"><input type="text" name="firstname"></td>
            <td class="center"><textarea name="adventages"></textarea></td>
            <td class="center"><textarea name="disadventages"></textarea></td>
            <td class="center"><textarea name="text"></textarea></td>
            <td class="center">
                <select name="estimate">
                    <option></option>
                    <?for($i=1; $i<=5; $i++):?>
                        <option value="<?=$i?>"><?=$i?></option>
                    <?endfor;?>
                </select>
            </td>
            <td class="center">
                <select name="statusId">
                    <?foreach($reviews->getStatuses() as $status):?>
                        <option value="<?=$status->id?>"><?=$status->name?></option>
                    <?endforeach;?>
                </select>
            </td>
            <td class="center">
                <img class="pointer addReview" src="/admin/images/buttons/add.png" alt="Добавить отзыв">
            </td>
        </tr>
    </table>
</div>