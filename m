Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0003E2AC9;
	Thu,  3 Sep 2026 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420108; cv=none; b=QWPF/Wy17DcHNOPW1YwcrTRaO1XfygPp/pk+gLKYmyp+Bn3ZVxQCYMW4BgRphl5Orm+Wg4uwUhBtH7i3dmF1CsjGwAtdzYMZaJhsiYl/zGa1N9oZhgcMDWMCKQJe6nXghMs+V1ogx8IMrRYcGFxltOAQtjw3BYnBes9NfTbhXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420108; c=relaxed/simple;
	bh=E/rv5OYfCgD1Ay6H7pbOaKWU2Rq/RliVZWyF2kjsLCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJtKXYjh71pdoWGTjXI9Z10e+NQJuDr0+2Inqs8TriFW/DkLlVwhSJ/nDw+mEAwn8gwHayCQAegKhqELhXfkjCIx7LtiRfHflXvMI6lHmehmugq2hVul7kgNqrpTbzFBm/fuw60mbD84qEnD110U2eRTuO+0RiH6Fse33W5x6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFgPZmGJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFgPZmGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788420107; x=1819956107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/rv5OYfCgD1Ay6H7pbOaKWU2Rq/RliVZWyF2kjsLCc=;
  b=XFgPZmGJ6jt1RknFwrRRW9DNBMXnnXur9Iw0wKtlH0SnWpptfuN1TVIo
   Z9J10Fe1NXP7p6K8ava6mb7KsNVUQyU6uhZ4a+sVseVi+cN7nIHATx6Rp
   6aIcc7sO2HF8PU37+EhDebY4XEX9GjZzqqw3telAlhJYXau4MP6/9ASB+
   AKMwSyY0KZygrbNq2jzGdkmDuHpv/wi2LIgGJ5RO9DcOHiL0ghaQGucXF
   qkQMnbEku/jWYkiPhvjSnCk+oE9fijoIUewEM6f1DmOH0tUVakMDvj+uo
   UWP36qaToet7xA7kSX3FdShJhvyB7+QLkGLMkS8zyfCApIlfTGK/BKGIh
   Q==;
X-CSE-ConnectionGUID: cjrCntf0QFWWlWLiz+D3Yg==
X-CSE-MsgGUID: mWd4KfBpR3aI5toFJu8D3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88815773"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88815773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:21:46 -0700
X-CSE-ConnectionGUID: S57IN92qQCKbOLMzaU+g8A==
X-CSE-MsgGUID: JmrspBJRQ7aRBQVp04jgaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263461669"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:21:42 -0700
Date: Thu, 3 Sep 2026 10:21:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Walleij <linusw@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH v2 01/12] i2c: core: add I2C_XFER_V2 - support for
 detailed transfer reporting
Message-ID: <apkgBIgF09HAcbot@ashevche-desk.local>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 08:38:08AM +0300, Dmitry Guzman wrote:
> In I2C subsystem there is API that allows sending/receiving a number of
> messages in a single call. I2C_RDWR ioctl, as well as i2c_transfer kernel
> API function, returns only a single error code. In case of a fault,
> there is no way to know which message in the series caused a fault, and
> how many bytes have been sent or received before the fault.
> 
> This commit introduces i2c_transfer_v2 kernel API function and
> I2C_RDWR_V2 ioctl. They provide the same functionality as the old ones,
> but also accept additional pointer to `i2c_transfer_report` structure
> and fill it with detailed fault report: number of messages transferred
> successfully, index of message that caused fault, number of bytes
> transferred (if a fault occurred in the middle of the last message).
> 
> I2C bus controller driver may implement either both callbacks or any one
> of them. The implementation of both callbacks may make sense if the
> precise detection of the fault position requires different handling with
> the hardware that causes to extra CPU load or other consequences that
> may be unwanted if the precise fault report is not required. If the
> precise fault detection is free, the driver may implement only `xfer_v2`
> callback - the infrastructure will provide pointer to a dummy fault
> report that will be dropped if the client uses old API.

What tool do you use?
The problem with the submission is that:
- it has no cover letter
- it has been send with In-Reply-To set to the previous version of the set.

I have noticed the same issue in another patch series which is heavily relies
on AI. You should read the coding-assistants.rst and act accordingly.

...

> -int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
> +		   struct i2c_transfer_report *report)
>  {
> +	struct i2c_transfer_report dummy_report;
>  	unsigned long orig_jiffies;
>  	int ret, try;
>  
> -	if (!adap->algo->master_xfer) {
> +	if (report) {
> +		report->msgs_cplt = -EOPNOTSUPP;
> +		report->bytes_cplt = -EOPNOTSUPP;
> +		report->fault_msg_idx = -EOPNOTSUPP;

Why all three?! Why even a single one as long as we return an error code?

> +		if (!adap->algo->xfer_v2)
> +			return -EOPNOTSUPP;
> +	}
> +
> +	if (!adap->algo->master_xfer && !adap->algo->xfer_v2) {
>  		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/*
> +	 * If the controller only supports "v2" callback and the report is not requested,
> +	 * provide pointer to a dummy report.
> +	 */
> +	if (!(adap->algo->master_xfer) && (!report))

It's not a line in the macro.

> +		report = &dummy_report;


> +	if (adap->quirks) {
> +		struct i2c_msg *bad_msg = i2c_check_for_quirks(adap, msgs, num);
> +
> +		if (bad_msg) {

This style is bad for maintenance. Whenever you need to validate something,
never assign it in the definition.

> +			if (report) {
> +				report->msgs_cplt = 0;
> +				report->bytes_cplt = 0;
> +				report->fault_msg_idx = bad_msg - msgs;
> +			}
> +			return -EOPNOTSUPP;
> +		}
> +	}

...

On a brief look this patch made with AI and it's a complete unreviewable mess.
Make sure you do a series of a small logically finished pieces. For example,
introducing a v2 of a hook with a new prototype. This can be done in a separate
patch. Adding report is another, and so on...

-- 
With Best Regards,
Andy Shevchenko


