<div class="content-wrap">
    <div class="main">
        <h1>Upload Sample</h1>
        <form action="<?= base_url('UserAccount/uploadPicture')?>" method="post" enctype="multipart/form-data">
            Select image to upload:
            <input type="file" name="fileToUpload" id="fileToUpload">
            <input type="submit" value="Upload Image" name="submit">
        </form>
    </div>
</div>
