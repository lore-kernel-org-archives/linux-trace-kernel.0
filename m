Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903339;
	b=wWORK3PGoN4DalemYDo9k/722UB+ruY5ia0mt2JUHkMWBzjIQbE4fzPomcDc21YulfDE
	 HWb1QflNufqZkrDvhthTQSsMoppGhfBGYbutT+wbPhKytEJkk3q3/2WaCb8HW8hCQn4sT
	 DPownEDX8ygsIq3fm1KjS088m5XW7rqZpy3v6lLw7PO42BWH7qKaBd65rPIc3F+NmYtgu
	 b1TuyCvJqyuuQhiOuN2BmhYPyi35+K3RgCOQpt2tbArYRppnMuVhJ7uURw9A1BP/3E+kF
	 j1d22Hb2HIrmYvBlxVBTGT73nj8rURFiFtzqqZnXpWchgEaYV1JYjJ2Ih8qFP5JmjqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903339;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NJRIBxDa0PBI1ayFa5wZ+sVeSyV4S6VsRvVyFVIG9Yc=;
	b=c2o5KkRYOqSR7kLy5nrppeoss6B2EoHAsTCiyb+V3qhn6yK/ZZKMP3/Ik7k7o+vCqZcR
	 n3azvH4/h17ZAZ+OntDIEQf9VC9aPCTWLApoRpvIt1pdpTq9HELEDiC28OJYrrewRYWdr
	 XALZDvXbKKM8faCRixjgFmvzllxkIusCyLqPaKQhtCHzrGkTsiCJfC5MMtqGNejDJymu5
	 BMOOB6ggHHvn3eBwX7+5TeFfesdKkGbDAfh+4FHBg5UpVvr6BjCYb5QZCyjPzB+6148Iz
	 HbygTCqs966Pu2jZ8tWrJo+vl26ur6kpnDqMnarIyiSQGJHXgjVKcqPA8j+0q99uAqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M3YCKE4Z;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0862606A326;
	Thu,  5 Nov 2026 18:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0862606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M3YCKE4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793903340; x=1825439340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLP7D2diFf8GVGCCXQtzmey6vFHHS3ImWJ64xyTbLbo=;
  b=M3YCKE4Zv3A0hVUJzxcsy6q/9NBd6xM4UQdaM+fC5JzeolkjdKU1eDX0
   IyNf8ZWQ04P4Tx6sETJFH2ltiDa9FuT8EfVoRFKXUAKnFfu4tOJb2213c
   BqtWXrMUN3l5ZeeIgOuIydRrNCD8fFisX+cz8tSHpEO4n+bL2kJ96T+tj
   iHqxL7xiE9PSUmxCg2Xns+szTe6Fjfsq2SH62sRuEZ4YM3Qtdwo2pZEAt
   W0prtsKDnKnAdUgNDu3AHFY+pEGv01TBZSoDJ9rQpdDNvaQGTVYQwWLy9
   pa59W9PemF1tiUO3jE0NC/NoDdkbALT6A2d43K98QIX0i78V2eXBpHSIa
   Q==;
X-CSE-ConnectionGUID: ogkXQnY7SG+16gnbEeKHnQ==
X-CSE-MsgGUID: Y6qEAL6mTn2kj/iymx2rvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2577154"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2577154"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:28:59 -0800
X-CSE-ConnectionGUID: 8AkguHEkRvWFOmYHarRzCA==
X-CSE-MsgGUID: 8hM0xRPvQjSF0gw/H+gG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7204397"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:28:55 -0800
Date: Thu, 5 Nov 2026 20:28:52 +0200
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
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 07/14] i2c: core: implement i2c_transfer_v2() -
 transfer with detailed reporting
Message-ID: <auzK5F7uOEpGpUBe@ashevche-desk.local>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-7-515ad74ac4c9@mobileye.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-i2c-fault-reporting-v3-7-515ad74ac4c9@mobileye.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 07:15:28PM +0200, Dmitry Guzman wrote:
> In __i2c_transfer() and i2c_transfer(), add one more parameter - pointer
> to transfer report. In __i2c_transfer(), if the pointer is not NULL,
> use algo->xfer_v2() callback instead of algo->xfer() in order to get the
> detailed transfer report. If the adapter does not have xfer_v2(), return
> -EOPNOTSUPP.
> 
> If the adapter has any quirks that make impossible to transfer requested
> message or messages, put the index of the first such message to the
> transfer report structure.
> 
> If the report is not NULL, algo->xfer_v2() returned an error and there
> are any read messages, trace the read data using `trace_i2c_reply(). If
> the last read message is incomplete (transfer was interrupted in the
> middle of a read message), trace the read portion of data also.
> 
> Rename __i2c_transfer() to __i2c_transfer_v2() and i2c_transfer() to
> i2c_transfer_v2().
> 
> For backward compatibility, add __i2c_transfer() and i2c_transfer() that
> call __i2c_transfer_v2() and i2c_transfer_v2() respectively with null
> report pointer.
> 
> Remove comment "REVISIT the fault reporting model here is weak".

...

>  	if (static_branch_unlikely(&i2c_trace_msg_key)) {
> -		int i;
> -		for (i = 0; i < ret; i++)
> +		int i, n;
> +
> +		if (report)
> +			n = report->msgs_cplt;
> +		else
> +			n = ret;

> +		for (i = 0; i < n; i++)
>  			if (msgs[i].flags & I2C_M_RD)
>  				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);

Besides missing {}. the iterator is local to the loop, hence

		for (int i = 0; i < n; i++) {
			if (msgs[i].flags & I2C_M_RD)
				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
		}

> +		if (report && report->bytes_cplt > 0 && msgs[n].flags & I2C_M_RD)
> +			trace_i2c_reply(adap, &msgs[n], report->bytes_cplt, n);
>  		trace_i2c_result(adap, num, ret);
>  	}

...

> +/**
> + * __i2c_transfer - unlocked flavor of i2c_transfer
> + * @adap: Handle to I2C bus
> + * @msgs: One or more messages to execute before STOP is issued to
> + *	terminate the operation; each message begins with a START.
> + * @num: Number of messages to be executed.

> + * Returns negative errno, else the number of messages executed.

Return section must be last in the kernel-doc (it's documented) and actually be
a such. Always validate with kernel-doc script.

> + * Adapter lock must be held when calling this function. No debug logging
> + * takes place.

This is Context section in kernel-doc for.
And more effectively is to add a lockdep annotation.

> + */
> +int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	return __i2c_transfer_v2(adap, msgs, num, NULL);
> +}

-- 
With Best Regards,
Andy Shevchenko


