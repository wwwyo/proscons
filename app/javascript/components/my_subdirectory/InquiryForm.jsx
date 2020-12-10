import React from "react"
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';


const InquiryForm = (props) => {
  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const submitSlack = (description) => {
    const payload={
      "text": 
        "prosconsからお問い合わせがありました\n" + 
        "お名前:" + props.name + '\n' +
        "内容:" + description
      }
    const url = "https://hooks.slack.com/services/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"
    fetch(url, {
      method: 'POST',
      body: JSON.stringify(payload),
    }).then(() => {
      alert('送信が完了しました。ありがとうございました！')
      return handleClose()
    })
  };

  const getSubmitForm = () => {
    const textField = document.getElementById("name");
    const description = textField.value
    submitSlack(description)
  };

  return (
    <div>
      <Button variant="outlined" color="primary" onClick={handleClickOpen}>
        お問い合わせ
      </Button>
      <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title">
        <DialogTitle id="form-dialog-title">ご利用いただきありがとうございます</DialogTitle>
        <DialogContent>
          <DialogContentText>
            メッセージでもなんでもコメントください〜
          </DialogContentText>
          <TextField
            autoFocus
            margin="dense"
            id="name"
            label="お問い合わせフォーム"
            type="text"
            fullWidth
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} color="primary">
            キャンセル
          </Button>
          <Button onClick={() => getSubmitForm()} color="primary">
            送信
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}

export default InquiryForm
