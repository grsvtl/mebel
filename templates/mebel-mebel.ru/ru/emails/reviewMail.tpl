<? include ('header.tpl'); ?>
    <tr>
        <td colspan="2" style="padding-left: 10px;">
            <h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Новый отзыв с сайта <?=SEND_FROM?></h2>
            <p>
                Здравствуйте.
                <br /><br />
                Со страницы <?=$_SERVER['HTTP_REFERER']?> сайта <?=SEND_FROM?> был добавлен новый отзыв.
                <br /><br />
                Отзыв:
                <br />
                Имя: <strong><?=$review->getFirstName()?></strong>
                <br />
                Оценка: <strong><?=$review->getEstimate()?></strong>
                <br />
                Достоинства: <strong><?=$review->getAdventages()?></strong>
                <br />
                Недостатки: <strong><?=$review->getDisadventages()?></strong>
                <br />
                Комметарии: <strong><?=$review->getText()?></strong>
                <br /><br />
                В данный момент отзыв заблокирован.
                <br />
                Вы можете разблокировать отзыв в
                <a href="<?='http://'.$_SERVER['HTTP_HOST'].$catalogObject->getAdminPath()?>">
                    системе управления
                </a>
                после чего он станет доступным
                в <a href="<?=$_SERVER['HTTP_REFERER']?>">клиентской части</a>.
            </p>
        </td>
    </tr>
<? include ('footerAdmin.tpl'); ?>