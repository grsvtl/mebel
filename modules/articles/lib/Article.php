<?php
namespace modules\articles\lib;
class Article extends \core\modules\base\ModuleDecorator implements \interfaces\IObjectToFrontend
{
	use \core\traits\objects\SiteMapPriority,
        \core\traits\RequestHandler,
        \core\traits\controllers\ServiceRequests;

	function __construct($objectId)
	{
		$object = new ArticleObject($objectId);
		$object = new \core\modules\categories\CategoryDecorator($object);
		$object = new \core\modules\statuses\StatusDecorator($object);
		$object = new \core\modules\images\ImagesDecorator($object);
		$object = new \core\modules\filesUploaded\FilesDecorator($object);
		parent::__construct($object);
	}

	/* Start: Meta Methods */
	public function getMetaTitle()
	{
		return $this->metaTitle ? $this->metaTitle : $this->getName();
	}

	public function getMetaDescription()
	{
		return $this->metaDescription;
	}

	public function getMetaKeywords()
	{
		return $this->metaKeywords;
	}

	public function getHeaderText()
	{
		return $this->headerText;
	}
	/*   End: Meta Methods */

	/* Start: Main Data Methods */
	public function getName()
	{
		return $this->name;
	}
	/*   End: Main Data Methods */

	public function getH1()
	{
		return empty($this->h1) ? $this->name : $this->h1;
	}

	/* Start: URL Methods */
	public function getPath()
	{
		if ($this->alias == 'index')
			return '/';
		if ($this->categoryId == ArticleConfig::NEWS_CATEGORY_ID)
			return '/news/'.$this->alias.'/';
		if ($this->categoryId == ArticleConfig::INFO_CATEGORY_ID)
			return '/info/'.$this->alias.'/';
        if ($this->categoryId == ArticleConfig::NEWS_UG_CATEGORY_ID)
            return '/news_ug/'.$this->alias.'/';
		return '/'.$this->alias.'/';
	}
	/*   End: URL Methods */

	public function isValidPath($path)
	{
		if($this->alias == '404')
			return true;
        if($this->categoryId == ArticleConfig::REVIEWS_MERI_CATEGORY_ID)
            return false;
		return $this->getPath() == rtrim($path,'/').'/';
	}

	public function remove () {
		return ($this->delete()) ? (int)$this->id : false ;
	}

	/* Start: Sitemap Methods */
	public function getLastUpdateTime()
	{
		return $this->lastUpdateTime;
	}

	public function getSitemapPriority()
	{
		return $this->sitemapPriority=='default' ? $this->getSitemapPriorityByPath($this->getPath()) : $this->sitemapPriority;
	}

	public function getChangeFreq()
	{
		return empty($this->changeFreq) ? 'weekly' : $this->changeFreq;
	}
	/*   End: Sitemap Methods */

	public function isShowTitleArticle()
	{
		$config = $this->getConfig();
		return ! in_array($this->id, $config->notShowTitleArticlesId);
	}

	public function getText(){return $this->text;}
	public function getDescription(){return $this->description;}
}