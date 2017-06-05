<footer>
		<div class="footerCenter">
			<ul class="blocksFooter">
				<li>
					<h4>Контакты:</h4>

                    <div class="footerPhoneAllocaPlace"></div>
                    <script src="/js/alloka/getFooterPhoneAlloka.js"></script>

					<span class="mailFooter">info@dana-mebel.net</span>
                    <span class="mailFooter">
                        <br />
                        Москва,
                        <br />
                        Пресненская наб. 12,
                        <br />
                        офис 7703
                    </span>
				</li>

				<?$menu = $this->getController('Catalog')->getMainCategoriesWhichHasChildren($this->getController('Catalog')->getDanaFabricatorId())?>
				<?if(count($menu)):?>
				<li>
					<h4>Каталог:</h4>
					<?foreach($menu as $item):?>
					<a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
					<?endforeach;?>
					<div class="clear"></div>
				</li>
				<?endif?>

				<?$menu = $this->getController('Article')->getTopMenuData()?>
				<?if($menu->count()):?>
				<!--<li class="threeBlock">-->
				<li>
					<h4>Меню:</h4>
					<?foreach($menu as $item):?>
					<a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
					<?endforeach;?>
				</li>
				<?endif?>

				<li>
					<img src="/images/danaMebel/bg/footerLogo.png" height="33" width="117" alt="" class="footerLogo">
					<p>© Интернет-магазин<br> «Dana-mebel» 2010–<?=date("Y")?></p>
				</li>
			</ul>
			<div class="clear"></div>
		</div>

		<div class="counters hide">
			<!-- Yandex.Metrika informer -->
			<a href="http://metrika.yandex.ru/stat/?id=23812792&amp;from=informer"
			   target="_blank" rel="nofollow"><img src="//bs.yandex.ru/informer/23812792/3_0_FC345CFF_DC143CFF_0_pageviews"
												   style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" onclick="try{Ya.Metrika.informer({i:this,id:23812792,lang:'ru'});return false}catch(e){}"/></a>
			<!-- /Yandex.Metrika informer -->

			<!-- Yandex.Metrika counter -->
			<script type="text/javascript">
				(function (d, w, c) {
					(w[c] = w[c] || []).push(function() {
						try {
							w.yaCounter23812792 = new Ya.Metrika({id:23812792,
							webvisor:true,
							clickmap:true,
							trackLinks:true,
							accurateTrackBounce:true});
						} catch(e) { }
					});

					var n = d.getElementsByTagName("script")[0],
							s = d.createElement("script"),
							f = function () { n.parentNode.insertBefore(s, n); };
					s.type = "text/javascript";
					s.async = true;
					s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

					if (w.opera == "[object Opera]") {
						d.addEventListener("DOMContentLoaded", f, false);
					} else { f(); }
				})(document, window, "yandex_metrika_callbacks");
			</script>
			<noscript><div><img src="//mc.yandex.ru/watch/23812792" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
			<!-- /Yandex.Metrika counter -->
		</div>

	</footer>
</body>
</html>