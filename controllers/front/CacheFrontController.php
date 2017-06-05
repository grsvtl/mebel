<?php
namespace controllers\front;
class CacheFrontController extends \controllers\base\Controller
{
	use \core\traits\controllers\Authorization;

//	public function clearDanaCurrentPageCache($cacheKey)
//	{
//		if(!$this->getController('Authorization')->isAdminAuthorizated())
//			return false;
////		\core\cache\Cacher::getInstance()->remove($cacheKey);
//		$this->getController('Catalog')->getCatalogLeftMenu();	// clear left menu cache, return cacher instance
//		$this->getController('Article')->getTopMenu()	// clear top menu cache, return cacher instance
//										->remove($cacheKey);
//		return true;
//	}

//	public function clearMebelCurrentPageCache($cacheKey = false)
//	{
//		if(!$this->getController('Authorization')->isAdminAuthorizated())
//			return false;
//		$this->getController('Article')->getTopMenu();	// clear top menu cache, return cacher instance
//		$this->getController('Article')->getFooterMenu();
//		$this->getController('Article')->getFooterServicesMenu();
//		$this->getController('Article')->getServicesMenu();
//		$this->getController('Catalog')->getTopMenu();
//		if($cacheKey)
//			\core\cache\Cacher::getInstance()->remove($cacheKey);
//		return true;
//	}
}