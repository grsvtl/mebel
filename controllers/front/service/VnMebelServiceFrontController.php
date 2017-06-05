<?php
namespace controllers\front\service;
class VnMebelServiceFrontController extends \controllers\base\Controller
{
	use	\core\traits\controllers\ControllersHandler,
		\core\traits\controllers\Templates;

    private $actionsRedirects = array(
        'sitemap.xml'   => 'sitemap',
        'robots.txt'    => 'robots',
        'YML.xml'       => 'yml'
    );

	public function __call($actionName, $arguments)
	{
		if (method_exists($this, $actionName))
			return call_user_func_array(array($this, $actionName), $arguments);
		elseif (isset($this->actionsRedirects[$actionName])){
			$action = $this->actionsRedirects[$actionName];
			return $this->$action();
		} else {
			$defaultControllerName = \core\Configurator::getInstance()->controllers->defaultFrontController;
			return $this->getController($defaultControllerName)->$actionName();
		}
	}

	public function redirect404()
	{
		header("HTTP/1.0 404 Not Found");
		$objects = new \modules\catalog\catalog\lib\Catalog();
		$this->setContent('categories', $objects->getMainCategories(1))
			 ->includeTemplate('404');
		die();
	}

	public function accessDenied($right)
	{
		$this->redirect404();
	}

	public function forbidden()
	{
		$this->redirect404();
	}

	protected function sitemap()
	{
		if ($this->getSERVER()['REQUEST_URI'] != '/sitemap.xml')
			return $this->redirect404();

        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		$sitemap = new \core\seo\sitemap\Sitemap();

		if ($contents === false){

//			mail('sashagrinceac@yahoo.com',
//				'generating sitemap in VnMebelServiceFrontController',
//				'The sitemap was generated in VnMebelServiceFrontController directly, without cache - '.date('Y/m/d H:i:s')
//			);

			$articles = new \modules\articles\lib\Articles();
			$query = '
				AND `statusId` = ?d
				AND `categoryId` IN (?s)';

			$articles->setSubquery($query, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID, '102,103,104');

			$goods = new \modules\catalog\catalog\lib\Catalog();
			$goods->setSubquery(' AND `statusId` NOT IN (?d, ?d)', \modules\catalog\catalog\lib\CatalogItemConfig::BLOCKED_STATUS_ID, \modules\catalog\catalog\lib\CatalogItemConfig::REMOVED_STATUS_ID);
			$goodCategories = $goods->getCategories()->setSubquery(' AND `statusId` = ?d', 1);

//			$complects = new \modules\catalog\complects\lib\Complects();
//			$complects->setSubquery(' AND `statusId` NOT IN (?d, ?d)', \modules\catalog\complects\lib\ComplectConfig::BLOCKED_STATUS_ID, \modules\catalog\complects\lib\ComplectConfig::REMOVED_STATUS_ID);


            $goods->setLimit(2000);

			$sitemap
                ->addObjects($articles)
					->addObjects($goods)
					->addObjects($goodCategories);

//			$offers = new \modules\catalog\offers\lib\Offers();
//			$offersCategories = $offers->getCategories()->setSubquery(' AND `statusId` = ?d', 1);
//
//			$offers = $offers->getValidOffers();
//			$offerGroupGoods = new \modules\catalog\offers\offerGroups\offerGroupGoods\lib\OfferGroupGoods();
//			foreach($offers as $offer)
//				foreach($offerGroupGoods->getGoodsByOffer($offer) as $offerGood)
//					$sitemap->addObject($offerGood->getGood());
//			$sitemap->addObjects($offersCategories);

			$contents = $sitemap->getSitemapCode();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		$sitemap->printXMLHeaders();
		echo $contents;
	}

	protected function robots()
	{
		if ($this->getSERVER()['REQUEST_URI'] != '/robots.txt')
			return $this->redirect404();

		$filePath = $this->isProductionDomain()
						? DIR.'/robots/'.$this->getDevelopersDomainAlias().'Robots.txt'
						: DIR.'/robots/DeveloperRobots.txt';

		if (file_exists($filePath)){
			header('Content-type: text/plain');
			include($filePath);
		} else
			$this->redirect404();
	}

    protected function yml()
    {
        if ($this->getSERVER()['REQUEST_URI'] != '/YML.xml')
            return $this->redirect404();
        $yml = new \core\seo\yml\Yml();
        $yml->setShopName('Мебель мебель')
            ->setCompanyName('Мебель мебель')
            ->addCategories($this->getController('Catalog')->getActiveCategories());

        foreach($this->getController('Catalog')->getActiveObjects(1250) as $good)
            $yml->addOffer($this->getYmlOfferFromGood($good));

        $yml->printYml();
    }

    protected function getYmlOfferFromGood($good)
    {
        $pictures = array();
        foreach($good->getImagesByCategoryAndStatus(2, 1) as $image)
            $pictures[] = $image->getImage();

        $data = array(
            'id'		=> $good->id,
            'available' => 'true',
            'url'		=> $good->getPath(),
            'price'		=> $good->getShowPrice(),
            'currencyId'=> 'RUR',
            'categoryId'=> $good->categoryId,
            'pictures' => $pictures,
            'name'		=> $good->getName(),
            'description'=> strip_tags($good->description),
            'manufacturerWarranty' => true,
            'delivery' => true
        );
        return new \core\seo\yml\YmlOffer($data);
    }
}
