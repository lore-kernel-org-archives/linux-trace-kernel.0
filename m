Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367E415F28;
	Thu,  3 Sep 2026 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421192; cv=none; b=bkjJ4gEfkw0RH+iK/VCXZe8z3b2Pp/d/XhOOMkRXMYDnFn/zhIZjFBc3o56E9CSyO1B7LJB6X4R1+FtwN3YwQo+V8fT7Ka3zGJcHJoqiILe7Qz2FI7OUz8Y0sC8OCbpXsyVC+4Cqg12dgG+oO4j+BxlwSAzn+rkR2hNafZlDIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421192; c=relaxed/simple;
	bh=uDHW7C6c0VOUhhvrt2S3Sz5WaioyN/0J8ywzbnxIHKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPa23hnVhzrHHrF3VEbBp8/HhYXeiOuJw2/lWuoxD28Derd+0tfZe3uwlZn19/lEYPRE0vHJeVt/I6zv1DR5F21hI3D8pUhbKqFxmVE9zEI3N/LUys19AD8rRTfabDUExaDUqdw+310R9SSX+sTPuA18+5gx8eKNHZC0c4wb29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grxGfyim; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grxGfyim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788421190; x=1819957190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDHW7C6c0VOUhhvrt2S3Sz5WaioyN/0J8ywzbnxIHKc=;
  b=grxGfyimGERxtjhwG7coz1Du1Sjkmv4feOWFKSeItL1vyFKr21+kNvgW
   vEtyhkxI0YB9ULm1kSBAi3Rs0Q/HHvq/kBa+stfJzZkpD3PdMGqvXpRXY
   ZkBLqBTM71iD1YdMsEDfLkV/ieCw9PB2GvgMQ1+PtQS8B/F0fxVjmE+ZA
   t36SbiUophEilR5bm8/ue6+ZJCzvKtRpB/uPA4VTI6iryYcrfKuksd1GE
   vObNXoOViMMMHE66svAVZd0HSWiMdO/2IWGY9MbYRe3cDA/Nrwg+2/zmA
   urgJ8pRqTrtSQ63/azCSSUh1jRmzlXqYuk5yjE9TV8N37wCw74H6QQRs2
   A==;
X-CSE-ConnectionGUID: Ocqt5OUdSQKrRqADmKbQxg==
X-CSE-MsgGUID: hZYQvNlhQoaxebyQCy/34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92763140"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92763140"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:39:49 -0700
X-CSE-ConnectionGUID: wX/kLpurT4GA48XlHGT6+Q==
X-CSE-MsgGUID: BAcaZdMqSsupWnZm0UCY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273797726"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:39:46 -0700
Date: Thu, 3 Sep 2026 10:39:44 +0300
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
Subject: Re: [PATCH v2 09/12] i2c: designware: no SMBUS_READ_BLOCK_DATA
 without EMPTYFIFO_HOLD_MASTER
Message-ID: <apkkQFFbPhZl9-Ec@ashevche-desk.local>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-9-fedeb91792e6@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-i2c-fault-reporting-v2-9-fedeb91792e6@mobileye.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 08:38:16AM +0300, Dmitry Guzman wrote:
> Controllers without EMPTYFIFO_HOLD_MASTER feature cannot hold bus with
> empty FIFO. This makes impossible to issue SMBUS block read command:
> it is not known how many bytes must be read until it reads the  first byte

Too many spaces.

> indicates the data length is read. Without EMPTYFIFO_HOLD_MASTER, when
> the first byte is read, TX FIFO gets empty, this causes STOP condition
> and the transfer is terminated.
> 
> Reset SMBUS_READ_BLOCK_DATA bit in functionality mask on such controllers.

...

> +	/* Controllers without EMPTYFIFO_HOLD_MASTER feature cannot issue SMBUS
> +	 * block read because after reading the data length FIFO gets empty and
> +	 * STOP is generated automatically
> +	 */

/*
 * Please, use the regular style for the
 * multi-line comments. This reply can be used
 * as an example.
 */

-- 
With Best Regards,
Andy Shevchenko


