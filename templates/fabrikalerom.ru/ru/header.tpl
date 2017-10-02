<body>
    <!--header-->
    <header>
        <div class="top-line">
            <div class="container">
                <div class="row">
                    <div class="col-md-9 col-xs-6 menu-top-b">
                        <?=$this->getController('Article')->getTopMenu()?>
                    </div>
                    <div class="col-md-3 col-xs-6 card-b-b">
                        <div class="shopcartBarPlace"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="logo-head-line">
            <div class="container">
                <div class="row">
                    <div class="col-md-2 col-sm-2 col-xs-6 logo">
                        <a href="/"><img src="/images/fabrikaLerom/logo.png" alt=""></a>
                    </div>
                    <div class="col-md-4 col-sm-4 hidden-xs searg-head">
                        <form action="/search/" method="get">
                            <div class="searg-head-inset">
                                <input type="text" name="query" placeholder="Поиск товара" required>
                                <button><img src="/images/fabrikaLerom/zoom.svg" alt=""></button>
                            </div>
                        </form>
                    </div>
                    <div class="call-back col-md-3 hidden-xs col-sm-3 col-lg-2">
                        <a href="/contacts_lerom/">
                            <div class="btn btn-red-line">
                                Обратная связь
                            </div>
                        </a>
                    </div>
                    <div class="col-ld-4 col-md-3 col-sm-3 col-xs-6 phone-head">
                        <p>+7 (495)226-44-34 <span>Без выходных с 9:00 до 21:00</span></p>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--header end-->