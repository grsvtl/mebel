<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<br /><br /><br /><br />

<?foreach($objects as $new):?>
	<a href="<?=$new->getPath()?>"><?=$new->getName()?></a>
	<br /><br />
<?endforeach?>

<br /><br /><br /><br />
<?$this->includeTemplate('footer')?>