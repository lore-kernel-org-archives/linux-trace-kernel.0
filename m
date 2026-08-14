Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38583422541;
	Fri, 14 Aug 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694643; cv=none; b=BQ0S5ihz21yUblWTH0YXKPTWieYUkHdLdiifqviT2FwQvuMRGZX7lg+JU2AQ/cueSSXBkpsvGd6TBznsgJNAh7tye3x96iC4zNI4DbBoZ5CyHl9W6MxsGvlleDyL8yskqaELgNKY2YABHNvRFwfORCA3hXk5COR31/x/ReIAXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694643; c=relaxed/simple;
	bh=f/gV5vYFiyp1v8tbidEy1y5VhvcAHpOxhT/ORtc2H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lycpGs0g0Ov0mzjT/Wr4RR54VZUT8/4YT2+BTgq0X73NgWBVfzd8rkmyYRflOwtbfvbCXChqtgIVQcSo5M/wCkBipLugszSbpE/KfR7bs5+q8YrjqJcQdLBYmxrb45rkGF0JAFbZGxUute3vw0TDdOO7C12xoy69PmZl4T06VuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTcNcRrX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTcNcRrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786694641; x=1818230641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f/gV5vYFiyp1v8tbidEy1y5VhvcAHpOxhT/ORtc2H+I=;
  b=cTcNcRrXUbQ9hOi3YD1CGV5POETSr5xaawdLedvsK1MBoXJuY+Xv3tqe
   yRWxZxT+oIsr+30AdUnALEY6laweC0txgxIzFG3gR5inbLpPlRuNZrz0Z
   kb7ktZFRDDOyMFxJb+kAUbnIAQhvflQJdpwpxOjfbVW2lm8LiUKqQgJTl
   Edc/yQEkNxv62K2zWyXOT2XBLVYQ00U3sk7EFwMPliMt7+Gxe0WupN48Z
   ue3+25FpHTP33agne25DEbistskhO6AgDANqUjLcjZ7gKKdc6nvmxg6FR
   7Hm0sl7Lt0qvN25indkNcISB08HVIi7cl/MfU8iECtuAceG7hBH8USGU9
   w==;
X-CSE-ConnectionGUID: N599WOnbSO6vNyAyoCQ5bQ==
X-CSE-MsgGUID: 2SiWvGjZT5mGLRxlkbDgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112817475"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="112817475"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:04:00 -0700
X-CSE-ConnectionGUID: uZWHJQ8jQdKFP7Q1mWiRNg==
X-CSE-MsgGUID: 8lhQsporQJ2V5PiZN1hVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262411537"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:03:51 -0700
Date: Fri, 14 Aug 2026 11:03:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Message-ID: <an7L5D_9aGMkLiEw@ashevche-desk.local>
References: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
 <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 05:24:08PM -0400, Frank.Li@oss.nxp.com wrote:

> Use the existing dma_chan_name() helper to obtain the per-channel device
> name instead of open-coding: dev_name(chan->dev->device) /
> dev_name(chan2dev())
> 
> Simplify the code and improve consistency.
> 
> No functional change intended.

...

>  		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> -				       dev_name(chan2dev(lchan)), lchan);
> +				       dma_chan_name(&lchan->vchan.chan), lchan);

Depending on the amount of users (and I expect there is a number), I would
expect specific API for virt-dma case.

>  		if (ret)
>  			return ret;

-- 
With Best Regards,
Andy Shevchenko


