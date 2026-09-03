Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A682D3A75;
	Thu,  3 Sep 2026 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421638; cv=none; b=Zb1FxsDYQ0i5GkjJ2sVaUtxMByyHSHe/2rVJNAq5DFwhxAZQIPocBdk/Q1AR84kIvDNPQWR+pKzKdFQzIvFx+2w/+tz5sbpC1tA9XIrqlz636KLbvtO0kW4/TQjqquRke1nqJg3yYvbkVOly0V+RSGk5QX/bvsNVeoLTHyBayfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421638; c=relaxed/simple;
	bh=2eZKdONamPvCP1y5RVztRq6n8gH4zttgffCWQfy2imM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCFi91c8HMwPGpHmPgPE1Bb8rKYwrQPVchjxlDp2b+ohhvNF08rs/zDmaFHL7toC19Mr4c8NI1m9jv9ERMI8sm4OKzrtfy2KEXtkjxysPqytvqYQUAIsG6/5YQpf6xyAhsePVAozikWTvhbOUCucGNOyW4t0VxZgU7MpsyfBDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjAT8ISn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjAT8ISn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788421637; x=1819957637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2eZKdONamPvCP1y5RVztRq6n8gH4zttgffCWQfy2imM=;
  b=WjAT8ISnVatwrk3DKrccEU4FM3C/vMRBbJkO0lclGHRVI6jv/ZmAA8EO
   YY96bZYLu5jjUf16cYO5dQek8qGhkkQsO+vJIpAQK4DtjdYI52Zzrh8Nd
   GQDu3bw9o1T3HJyOEh0lKdXuoF6b9d0Md9mI2oGPQ6qzvNXlW6yuWdyce
   a4iOsAV0LeorAU9YLVZj22NSU7lvF4P8OJFBjem6dzeHpAkLKBfbeJDzR
   DiBZVyQIVH2lGQ1CGathun18pwhCnmthFCaRBDVIYriJjQoENSg56GBsY
   lxH5I1bN3TmuqWWOaUBCskgQbpEvmJDi5VjATb+Fsz653yT7rF2od8CNl
   Q==;
X-CSE-ConnectionGUID: NcKnVddEREm8uhcsAljm8w==
X-CSE-MsgGUID: ku2yQo01RPK0O+ESJszvWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99555157"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99555157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:47:16 -0700
X-CSE-ConnectionGUID: Hxhn/43GRSOYkNyUr+boqg==
X-CSE-MsgGUID: aEGVW8hZTXaw6XN4m0VwhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293143021"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:47:12 -0700
Date: Thu, 3 Sep 2026 10:47:09 +0300
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
Subject: Re: [PATCH v2 12/12] i2c: designware: add support for I2C_XFER_V2 -
 detailed fault reporting
Message-ID: <apkl_XHaZreKoipX@ashevche-desk.local>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-12-fedeb91792e6@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-i2c-fault-reporting-v2-12-fedeb91792e6@mobileye.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 08:38:19AM +0300, Dmitry Guzman wrote:
> I2C_XFER_V2 is a new API that allows I2C clients to get the detailed
> report in case of transmission failure. Previously, the only information
> returned by I2C bus controller was the error code; there was no way to
> find out how many messages or bytes in a certain message have been sent
> or received until the fault condition occurred, or to receive the data
> read before the fault.
> 
> This patch introduces support for this feature in i2c-designware driver.
> For AMD_NAVI_GPU model that has its own `xfer` callback function, this
> feature is currently not implemented.
> 
> The driver uses FLUSH_CNT field of ABORT_SOURCE register to detect
> how many command/data bytes written to FIFO were not actually sent.
> 
> Also, if the detailed fault report is required, the driver checks
> status after each read/write from/to FIFO. If ABORT flag is set, the
> driver cannot detect what happened first - FIFO read/write or
> communication abort, so it assumes that abort happened first, otherwise
> it either falsely reports one extra byte sent or returns the byte read
> from FIFO flushed after abort as a valid read byte. So, in unfortunate
> conditions, the fault report may be too pessimistic by one byte.
> 
> This check increases amount of time spent in interrupt handler, so if
> client doesn't need detailed fault report, this check should be avoided.
> Because of this, both `xfer` and `xfer_v2` callbacks are implemented in
> struct i2c_algorithm: the former does not generate detailed fault
> report, while the latter does.

...

> +static int i2c_dw_fault_report(struct dw_i2c_dev *dev, struct i2c_transfer_report *report);

Why forward declaration?

> +static inline bool i2c_dw_check_abort_flag(struct dw_i2c_dev *dev)

Why 'inline'?

> +{
> +	u32 stat;
> +
> +	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
> +	return (!!(stat & DW_IC_INTR_TX_ABRT));

Not a macro style.

> +}

...

> +			/* If precise fault reporting is required, check if the transfer
> +			 * is aborted after writing each byte.
> +			 * Otherwise, if it is aborted during filling FIFO, there is no way
> +			 * to know how many bytes was written to FIFO after transfer abort
> +			 * and thus are not counted in FLUSH_CNT.
> +			 * If we are checking abort flag after each byte, we can lose only 1 byte.
> +			 */

Style of the comments...

...

> +	if (!report) {

Use positive conditional instead.

> +		dev->need_precise_report = false;
> +	} else {
> +		dev->need_precise_report = true;
> +		report->msgs_cplt = -EOPNOTSUPP;
> +		report->bytes_cplt = -EOPNOTSUPP;
> +		report->fault_msg_idx = -EOPNOTSUPP;
> +	}

Will each driver use this? Needs a helper with explanation of the defaults.
Also note, the helper itself can be made in a separate patch.

...

> +					/* Reset report pointer to avoid
> +					 * calling i2c_dw_fault_report later
> +					 */

Style of the comment, also respect English punctuation and kernel standard
references, for instance the function can be referred as func().

...

> +	if (ret < 0) {
> +		if (report) {
> +			i2c_dw_fault_report(dev, report);
> +			report->msgs_cplt += msgs_in_prev_parts;
> +			report->fault_msg_idx += msgs_in_prev_parts;
> +		}
>  		return ret;
> +	}
> +	if (report) {
> +		report->msgs_cplt = num;
> +		report->fault_msg_idx = num;
> +		report->bytes_cplt = 0;
> +	}

If we going to have many lines like these you need to introduce an I²C report
handling APIs instead of these. This will help a lot. Currently this bulk of
stuff hard to review and follow.

...

> +	int idx;
> +	int n_flushed = FIELD_GET(DW_IC_TX_ABRT_SOURCE_FLUSH_CNT_MASK, dev->abort_source);

Reversed xmas tree order.

...

> +	for (int i = dev->msg_read_idx; i <= idx && i < dev->msgs_num; i++) {

Why is 'i' signed?

> +		if (dev->msgs[i].flags & I2C_M_RD) {
> +			report->msgs_cplt = i;
> +			if (!(dev->rx_buf_len))
> +				report->bytes_cplt = 0;
> +			else
> +				report->bytes_cplt = dev->rx_buf - dev->msgs[i].buf;
> +			if ((i < idx) || (report->bytes_cplt < dev->bytes_written))
> +				dev_warn_ratelimited(dev->dev, "Read data lost due to FIFO flush");
> +			break;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


