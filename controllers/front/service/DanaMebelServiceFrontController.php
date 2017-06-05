<?php
namespace controllers\front\service;
class DanaMebelServiceFrontController extends \controllers\base\Controller
{
	use	\core\traits\controllers\ControllersHandler,
		\core\traits\controllers\Templates;

	private $actionsRedirects = array(
		'sitemap.xml'   => 'sitemap',
		'robots.txt'    => 'robots',
        'YML.xml'       =>'yml'
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
		$this->getController('Article')->viewArticle('404');
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
			$articles = new \modules\articles\lib\Articles();
			$query = 'AND `statusId` = ?d
				AND `categoryId` IN (?s)';

			$articles->setSubquery($query, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID, '106, 103');

			$goods = new \modules\catalog\catalog\lib\Catalog();
			$goods->setSubquery(' AND `statusId` NOT IN (?d, ?d) AND `fabricatorId` = ?d',
					\modules\catalog\catalog\lib\CatalogItemConfig::BLOCKED_STATUS_ID,
					\modules\catalog\catalog\lib\CatalogItemConfig::REMOVED_STATUS_ID,
					$this->getController('Catalog')->getDanaFabricatorId());
			$goodCategories = $goods->getCategories()->setSubquery(' AND `statusId` = ?d AND `parentId` = ?d', 1, 0);

			$sitemap->addObjects($articles)
					->addObjects($goodCategories)
					->addObjects($goods);

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
        $yml->setShopName('Дана мебель')
            ->setCompanyName('Дана мебель')
            ->addCategories($this->getController('Catalog')->getCategoriesByFabricatorId( $this->getController('Catalog')->getDanaFabricatorId() ));

        foreach($this->getController('Catalog')->getItemsByFabricatorId( $this->getController('Catalog')->getDanaFabricatorId() ) as $good)
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
