Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EB4AA3EC;
	Fri,  4 Sep 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529250; cv=none; b=DIlEOvKNO+SHIQ/eEZ0KH1MdomysvXm1nHvrmQCHEYi3GoVnRJgviBVgmE/wHNOHdfMTBORmqpbugSJmUVzIy2SPJmc80l0gFqcCZmTyPlSiJba5sDsOgRP6BDm55elLRT72Oos5wKTktwBe8h9KzYFK/SAO2FzyUFd1ZfCYlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529250; c=relaxed/simple;
	bh=zesXpEseowuhkScQQajGo9Gm6M5KbuH5TUA2nQ5LhGE=;
	h=From:Date:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LPuZsU3AjFqQaK8HKBCjs9hfERhwZkCHg8c8mRWUxZw8VpLnmktCM4KKUfKSXBV84blg/t3ARJm0GdxnbjllKzJgxWdxebkiQCSsflOkoO6ZX+ciebLtNo9Qo+lGbdfccwtly1C1xAeHpI4/ust+RsXaQHuN7IWRiU2+8LjKPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=tXZFjS1b reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="tXZFjS1b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788529244; x=1820065244;
  h=from:date:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zesXpEseowuhkScQQajGo9Gm6M5KbuH5TUA2nQ5LhGE=;
  b=tXZFjS1bk12R4WvipFwTkGkhlLk1Q6UV0TUx2ie3x8CVO/kunftLP0V5
   Zugfs4iHWWogKYIQ/UG78p4ZRU69XdeDbDkUufIhd2EthEnN2SrZSdJ+6
   ibgpcHJVUum4mKWcJxyo8kdmV9i1wyJC/Gc2VR8x372AfEuydSkVqXDiB
   xLRIlaJMWJyLR8Ga+OC9SMPl+S65/p9um4SJTju4x0wQpQb4z+UvYIa+P
   eSuw60QKEn3G4O6WQ96MSpmAAOnwXgnk1TG2tASeoy1fz4WRxrKmehnp/
   Cdl35PSHaT1V9mIljblLUStXZHlDTcMTT0dc875szXV6C7ERBZqKfZID9
   A==;
X-CSE-ConnectionGUID: +2GJib0/R6CjHDIc/kM5dA==
X-CSE-MsgGUID: ZXjXowgRTF2paV6sdN/fvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 16:39:32 +0300
X-CSE-ConnectionGUID: ZM77DTLQR0+7lN7bawTt/g==
X-CSE-MsgGUID: rIrAksyhTzmCLYfnSyIKtg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 04 Sep 2026 16:46:09 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Fri, 04 Sep 2026 16:39:30 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Fri, 4 Sep 2026 13:53:55 +0300
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Walleij
 <linusw@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH v2 01/12] i2c: core: add I2C_XFER_V2 - support for
 detailed transfer reporting
Message-Id: <20260904135355.427fcb01d57c172552748943@mobileye.com>
In-Reply-To: <apkgBIgF09HAcbot@ashevche-desk.local>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
	<20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com>
	<apkgBIgF09HAcbot@ashevche-desk.local>
Organization: MobilEye
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
On Thu, 3 Sep 2026 10:21:40 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > I2C bus controller driver may implement either both callbacks or any one
> > of them. The implementation of both callbacks may make sense if the
> > precise detection of the fault position requires different handling with
> > the hardware that causes to extra CPU load or other consequences that
> > may be unwanted if the precise fault report is not required. If the
> > precise fault detection is free, the driver may implement only `xfer_v2`
> > callback - the infrastructure will provide pointer to a dummy fault
> > report that will be dropped if the client uses old API.
> 
> What tool do you use?

vim, git and b4

> The problem with the submission is that:
> - it has no cover letter

The cover letter is here: 
https://lore.kernel.org/linux-i2c/20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com/

It also contains link to the patch for i2c-tools that adds support for the
new API.

> - it has been send with In-Reply-To set to the previous version of the set.

https://lore.kernel.org/linux-i2c/20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com/raw
In-Reply-To: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>

What's wrong with this?

> 
> 
> > -int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> > +int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
> > +		   struct i2c_transfer_report *report)
> >  {
> > +	struct i2c_transfer_report dummy_report;
> >  	unsigned long orig_jiffies;
> >  	int ret, try;
> >  
> > -	if (!adap->algo->master_xfer) {
> > +	if (report) {
> > +		report->msgs_cplt = -EOPNOTSUPP;
> > +		report->bytes_cplt = -EOPNOTSUPP;
> > +		report->fault_msg_idx = -EOPNOTSUPP;
> 
> Why all three?! Why even a single one as long as we return an error code?
> 

There are two distinct cases when we return -EOPNOTSUPP:

1) The I2C driver reports that it cannot transfer a specific message.
For example, there are controllers that have message length limit less than
8K, or cannot do zero-length reads or writes, or cannot change target
address without generating STOP.
In this case, `msgs_cplt` and `bytes_cplt` are the number of messages and
bytes transferred successfully (both should be zero if the driver validates
the whole batch before starting transfer), and `fault_msg_idx` points to
the message that cannot be sent.

2) The driver does not support detailed fault reporting (does not implement
`i2c_xfer_v2` callback). In this case, all fields of the transfer report
structure have -EOPNOTSUPP value.

Also, in theory, I can imagine a controller that supports only message-wise
report and not byte-wise. This can be indicated by -EOPNOTSUPP value in
`bytes_cplt` field.

Thanks for the question. I think I should add a comment explaining this.

> 
> > +		report = &dummy_report;
> 
> 
> > +	if (adap->quirks) {
> > +		struct i2c_msg *bad_msg = i2c_check_for_quirks(adap, msgs, num);
> > +
> > +		if (bad_msg) {
> 
> This style is bad for maintenance. Whenever you need to validate something,
> never assign it in the definition.
> 

OK, I'll fix the coding style (here and in other patches also).

> 
> ...
> 
> Make sure you do a series of a small logically finished pieces. For example,
> introducing a v2 of a hook with a new prototype. This can be done in a separate
> patch. Adding report is another, and so on...
> 

OK, I'll split it into a series of small patches. Thanks for the review.

-- 
Best regards,
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

