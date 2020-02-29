<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<html>
<head>
<title>Image Upload</title>
</head>
<body>
<h1>Upload Sample</h1>
<form action="<?= base_url('UserAccount/uploadPicture')?>" method="post" enctype="multipart/form-data">
    Select image to upload:
    <input type="file" name="fileToUpload" id="fileToUpload">
    <input type="submit" value="Upload Image" name="submit">
</form>

</body>
</html>