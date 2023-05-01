import Trix from 'trix';

$(function() {
  $('.trix-button-group--file-tools').remove();
  $('.trix-button--icon-code').remove();
});

Trix.config.blockAttributes.default.tagName = "p"
Trix.config.blockAttributes.default.breakOnReturn = true;

Trix.Block.prototype.breaksOnReturn = function(){
  const attr = this.getLastAttribute();
  const config = Trix.getBlockConfig(attr ? attr : "default");
  return config ? config.breakOnReturn : false;
};
Trix.LineBreakInsertion.prototype.shouldInsertBlockBreak = function(){
  if(this.block.hasAttributes() && this.block.isListItem() && !this.block.isEmpty()) {
    return this.startLocation.offset > 0
  } else {
    return !this.shouldBreakFormattedBlock() ? this.breaksOnReturn : false;
  }
};