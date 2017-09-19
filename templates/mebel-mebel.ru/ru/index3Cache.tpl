		<?//$fabricators = $this->getObject('\modules\fabricators\lib\Fabricators')->getActiveFabricators()?>

		<!--<div class="factory">
			<h2>У нас товары мебельных фабрик:</h2>
			<?foreach ($fabricators as $fabricator):?>
				<div class="fabricatorBlock"><a href="<?=$fabricator->getPath()?>"><?=$fabricator->name?></a></div>
			<?endforeach?>
			<div class="clear"></div>
		</div>-->


		<!--<div class="rubrics">
			<h2>Популярные рубрики:</h2>
			<div class="d1">
				<a href="/spalni/modulnyie_spalni/">
					<img src="/images/content/articles/index/spalny.jpg" alt="photo" />
				</a>
				<a href="/spalni/modulnyie_spalni/">
					Комплекты для спальни
					<span>предложений - <?=$this->getQuantityByCategoryAlias('modulnyie_spalni')?></span>
				</a>
			</div>
			<div class="d2">
				<a href="/detskie/modulnyie_detskie/">
					<img src="/images/content/articles/index/detskaya.jpg" alt="photo" />
				</a>
				<a href="/detskie/">
					Детская мебель
					<span>предложений - <?=$this->getQuantityByCategoryAlias('detskie')?></span>
				</a>
			</div>
			<div class="d3">
				<a href="/gostinnye/modulnyie_gostinyie/">
					<img src="/images/content/articles/index/gostynica.jpg" alt="photo" />
				</a>
				<a href="/gostinnye/modulnyie_gostinyie/">
					Композиции для гостиной
					<?if($this->getQuantityByCategoryAlias('modulnyie_gostinyie')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('modulnyie_gostinyie')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d4">
				<a href="/kabinet/kompozicii_dlya_kobineta/">
					<img src="/images/content/articles/index/biblioteka.jpg" alt="photo" />
				</a>
				<a href="/kabinet/kompozicii_dlya_kobineta/">
					Мебель для кабинета
					<?if($this->getQuantityByCategoryAlias('kompozicii_dlya_kobineta')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('kompozicii_dlya_kobineta')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d5">
				<a href="/prihojii/podtovaryi_dlya_prihojey/">
					<img src="/images/content/articles/index/prih.png" alt="photo" />
				</a>
				<a href="/prihojii/podtovaryi_dlya_prihojey/">
					Прихожии
					<?if($this->getQuantityByCategoryAlias('podtovaryi_dlya_prihojey')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('podtovaryi_dlya_prihojey')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d6">
				<a href="/myagkaya_mebel/">
					<img src="/images/content/articles/index/matrasy.jpg" alt="photo" />
				</a>
				<a href="/myagkaya_mebel/">
					Мягкая мебель
					<?if($this->getQuantityByCategoryAlias('myagkaya_mebel')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('myagkaya_mebel')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d7">
				<a href="/spalni/shkafi_dlya_spalni/">
					<img src="/images/content/articles/index/closets.png" alt="photo" />
				</a>
				<a href="/spalni/shkafi_dlya_spalni/">
					Шкафы
					<?if($this->getQuantityByCategoryAlias('shkafi_dlya_spalni')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('shkafi_dlya_spalni')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d8">
				<a href="/spalni/krovati/">
					<img src="/images/content/articles/index/krovaty.jpg" alt="photo" />
				</a>
				<a href="/spalni/krovati/">
					Кровати
					<?if($this->getQuantityByCategoryAlias('krovati')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('krovati')?></span>
					<?endif?>
				</a>
			</div>
		</div>-->
		<div class="info-block">
		<!--<section class="info-block">-->
			<div class="clear"></div>
		<!--</section>-->
		</div>
	</section>
<!--</article>-->
</div>

<?$this->includeTemplate('footer')?>