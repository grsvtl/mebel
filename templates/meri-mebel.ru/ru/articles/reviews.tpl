<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<main id="main">
    <div class="container">
        <br>
        <?$this->includeBreadcrumbs()?>
        <h1>Отзывы</h1>
        <br>
        <div class="row">
            <?foreach($reviews as $review):?>
                <div class="recallBlock">
                    <div class="nameAndDateRecall">
                        <div class="manicon">
                            <img src="<?=$review->getFirstPrimaryImage()->getImage('100x100')?>">
<!--                            <img src="/images/meriMebel/bg/manIcon.svg" height="50" width="50">-->
                        </div>
                        <div class="nameRecall"><?=$review->getName()?></div>
                        <div class="dateRecall"><?=str_replace('-', '.', $review->date)?></div>
                        <div class="clear"></div>
                    </div>
                    <p><?=$review->getText()?></p>
                </div>
            <?endforeach?>

            <script type="text/javascript" src="/js/reviews.js"></script>

            <div id="sendForm" class="sendReview" data-action="/article/sendReview/" data-method="post">
                <div class="form-group">
                    <input type="text" name="name" class="form-control allRecallInput" placeholder="Имя" />
                    <textarea name="text" class="form-control allRecallTextarea" placeholder="Отзыв" rows="5" noresize></textarea>
                    <input type="file" name="photo" accept="image/*" class="form-control allRecallInputFile">
                    <a class="form-control allRecall pointer sendReviewSubmit">Оставить отзыв</a>
                    <img class="sendCommentLoader hide" src="/images/loaders/horizontal-green-loader.gif" style="height: 15px; margin-top: 10px;" />
                    <div class="sendCommentResult hide">
                        <br />
                        <font color="green">
                            Ваш отзыв успешно доставлен.
                            <br />
                            После модерации он появиться на сайте.
                        </font>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <br>
    </div>
</main>
<?$this->includeTemplate('footer')?>