<?php
namespace core\seo\yml;
class Yml
{
	private $domain;
    private $shopName;
    private $companyName;
	private $categoriesData = '';
	private $offersData = '';

	public function __construct($domain = null)
	{
		$this->setDomain($domain);
	}

	private function setDomain($domain)
	{
		$this->domain = empty($domain) ? $this->getDefaultDomain() : $domain;
		return $this;
	}

	private function getDefaultDomain()
	{
		return 'http://'.$_SERVER['HTTP_HOST'];
	}

	public function setShopName($shopName)
    {
        $this->shopName = $shopName;
        return $this;
    }

    public function setCompanyName($companyName)
    {
        $this->companyName = $companyName;
        return $this;
    }

	public function addCategories($categories)
	{
		foreach($categories as $category)
			$this->addCategory($category);
		return $this;
	}

	private function addCategory($category)
	{
		$this->categoriesData .= '<category id="'.$category->id.'"'
			.($category->parentId ? ' parentId="'.$category->parentId.'"' : '')
			. '>'.$category->getName()
			. '</category>';
	}

	public function addOffer(\core\seo\yml\YmlOffer $offer)
	{
		$this->offersData .=
			'<offer id="'.$offer->id.'"'
				. ' available="'.$offer->available.'"'
				.($offer->bid ? ' bid="'.$offer->bid.'"' : '')
				.($offer->cbid ? ' cbid="'.$offer->cbid.'"' : '')
			. '>'
			.	 '<url>'.$this->getDefaultDomain().$offer->url.'</url>'
			.	 '<price>'.$offer->price.'</price>'
			.	 '<currencyId>'.$offer->currencyId.'</currencyId>'
			.	 '<categoryId>'.$offer->categoryId.'</categoryId>'
		;

			foreach($offer->pictures as $picture)
				$this->offersData .= '<picture>'.$this->getDefaultDomain().$picture.'</picture>';

		$this->offersData .=
				'<name>'.$offer->name.'</name>'
				.'<description>'.$offer->description.'</description>'
				.'<manufacturer_warranty>' . ($offer->manufacturerWarranty ? 'true' : 'false') . '</manufacturer_warranty>'
				.'<delivery>' . ($offer->delivery ? 'true' : 'false') . '</delivery>'
				.($offer->delivery ? ( '<delivery-options><option cost="'.$offer->deliveryCost.'" /></delivery-options>' ) : '')
		;

		$this->offersData .=
			'</offer>';
	}

	public function printYml()
	{
		echo $this->printHeaders()
				  ->getCode();
	}

	private function printHeaders()
	{
		header("Content-Type: text/xml");
		header("Expires: Thu, 19 Feb 1998 13:24:18 GMT");
		header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");
		header("Cache-Control: no-cache, must-revalidate");
		header("Cache-Control: post-check=0,pre-check=0");
		header("Cache-Control: max-age=0");
		header("Pragma: no-cache");
		return $this;
	}

	private function getCode()
	{
		return $this->getSitemapHeader().$this->getSitemapBody().$this->getSitemapFooter();
	}

	private function getSitemapHeader()
	{
		return '<?xml version="1.0" encoding="UTF-8"?><yml_catalog date="'.date("Y-m-d H:i").'">';
	}

	private function getSitemapBody()
	{
		$sitemap = '<shop><name>'.$this->shopName.'</name>'
			.'<company>'.$this->companyName.'</company>'
			.'<url>'.$this->domain.'/</url>'
			.'<currencies><currency id="RUR" rate="1" plus="0"/></currencies>';

		if($this->categoriesData != '')
			$sitemap .= '<categories>'.$this->categoriesData.'</categories>';

		if($this->offersData != '')
			$sitemap .= '<offers>'.$this->offersData.'</offers>';

		$sitemap .= '</shop>';
		return $sitemap;
	}

	private function getSitemapFooter()
	{
		return '</yml_catalog>';
	}

	public function resetSitemap()
	{
		$this->elements = array();
		return $this;
	}
}