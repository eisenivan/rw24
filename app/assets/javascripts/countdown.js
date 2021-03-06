var countdown = {
  init: function() {
    this.oneMinute = 60 * 1000;
    this.oneHour = this.oneMinute * 60;
    this.oneDay = this.oneHour * 24;
    this.oneYear = this.oneDay * 365;

    this.start = new Date($(".countstart").attr("data-countstart")).valueOf();
    this.finish = this.start + this.oneDay;
    this.next = this.start + this.oneYear;
    this.now = new Date().valueOf();

    this.old_current = null;

    setInterval(this.render, 1000);
    this.render()
  },

  render: function() {
    var self = countdown;
    self.now += 1000;

    if(self.now > self.finish) {
      self.start = self.next;
    }

    var diff = Math.abs(self.start - self.now);

    var countdownDay = Math.floor(diff / self.oneDay);
    var countdownHrs = Math.floor(diff % self.oneDay / self.oneHour);
    var countdownMin = Math.floor(diff % self.oneHour / self.oneMinute);
    var countdownSec = Math.floor(diff % self.oneMinute / 1000);

    $("#day b").html(countdownDay < 10 ? "0"+countdownDay.toString() : countdownDay);
    $("#hrs b").html(countdownHrs < 10 ? "0"+countdownHrs.toString() : countdownHrs);
    $("#min b").html(countdownMin < 10 ? "0"+countdownMin.toString() : countdownMin);
    $("#sec b").html(countdownSec < 10 ? "0"+countdownSec.toString() : countdownSec);

    var current = self.start < self.now && self.now < self.finish;
    if(current != self.old_current) {
      if(current) {
        $("#countdown p.countup").hide();
        $("#countdown p.countdown").show();
      } else {
        $("#countdown p.countup").show();
        $("#countdown p.countdown").hide();
      }
    }
    $("#countdown").css("visibility", "");
    self.old_current = current;
  }
}

$(function() {
  countdown.init();
});
