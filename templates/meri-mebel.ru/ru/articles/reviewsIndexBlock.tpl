<?if($reviews->count()):?>
<section id="reviews" class="container-fluid text-center">
    <div class="container">
        <h2>Отзывы о фабрике</h2>
        <p>Мы дорожим вашим мнением, поэтому всегда готовы выслушать ваше мнение по поводу нашей
            <br> продукции. <a href="/reviews/">Посмотреть</a> все отзывы или <a href="/reviews/?#sendForm">оставить</a> свой отзыв.</p>
        <br>
        <br>
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-8">
                <div id="carousel-id" class="carousel reviews-carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <?$i=0; foreach($reviews as $review):?>
                        <li data-target="#carousel-id" data-slide-to="<?=$i?>" class="<?= $i==0 ? 'active' : ''?>">
                            <img src="<?=$review->getFirstPrimaryImage()->getImage('60x60')?>" alt="фото клиента">
<!--                            <img src="/images/meriMebel/bg/manIcon.svg">-->
                        </li>
                        <?$i++; endforeach?>
                    </ol>
                    <div class="carousel-inner">
                        <?$i=0; foreach($reviews as $review):?>
                        <div class="item <?= $i==0 ? 'active' : ''?>">
                            <div class="panel panel-default review">
                                <img class="review-image" src="<?=$review->getFirstPrimaryImage()->getImage('100x100')?>" alt="фото клиента">
                                <div class="panel-body">
                                    <p><?=$review->getDescription()?></p>
                                </div>
                                <div class="review-name"><?=$review->getH1()?></div>
                            </div>
                        </div>
                        <?$i++; endforeach?>
                    </div>
                    <a class="left carousel-control hidden-xs" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
                    <a class="right carousel-control hidden-xs" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                </div>
            </div>
            <div class="col-sm-2"></div>
        </div>
        <br>
        <br>
    </div>
</section>
<?endif?>