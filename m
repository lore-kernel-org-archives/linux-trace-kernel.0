Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241D43637C;
	Fri,  4 Sep 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513562; cv=none; b=XfABXQxI9z7niixpmQXtnaaPAioRvt4jFv0pemEtxqm+aUEVYwQAKlCdm9JkViA+OOmaZQc4/oNVnQF0syVnpBPTpmkMvwWRRTZaUYaS5hguvBGW7MUXPoDN/tQFWxB+ZmJxM2ceaj5nypScjNWxUsmhNa47/fvxNhXbPxujOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513562; c=relaxed/simple;
	bh=Ciu3EUMUtyrEFe1yr//0MMiw5+oF+KjxR5BN8wbUdAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB4tZbtonNLlvsk3S84ULkCYWkBB39WHAeNjh/SQMqR5FJfzPyTHvzT664s4uuTWhfNJba+qYmn6cJS1ov0/3Si/Ds1ZWgiQk3uMek8D+MOicxFo3PZpU05wjR+COM9Zw5mSMl/3eR/9kRpmBsdeoKNMG2FPhzzkaYNMc+6+3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsElDCme; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsElDCme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788513560; x=1820049560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ciu3EUMUtyrEFe1yr//0MMiw5+oF+KjxR5BN8wbUdAE=;
  b=RsElDCmeaRg7oFk7AIHfvLhglCC4GdtqIoDC8dWlFTaZ6p9Z8daw994w
   /GuzDkyudvSY/wn4fo8khEIK4tAokIofo9Vc+fzVmGrtAmNbCPRnBvxzK
   zaMFM/OjZOAPUWceH+W2zPGuh+H/pCVT1LLnFD28lyXweAshyV5HMv8JU
   1fdhpVi6Y15y7LyCexEA3L5qVnq2pl8tdukSYM5OzeBKc9iqb7o22Yl1S
   /n5TSaThldYPZt/VGJ3gPImSi3lSIoX+ZA8dVRpNG7cYCFbFdxVeoUlVc
   QcdEdtvd0IcIqDuSbK9Hmco2v2mhej2vSCQkzZOO6LpQusEVcZX6Xlnri
   w==;
X-CSE-ConnectionGUID: u1lCC2tbRWCbwEAIErAqrA==
X-CSE-MsgGUID: TGCessxhTXq60/SsXcMDuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88859559"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88859559"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 02:19:19 -0700
X-CSE-ConnectionGUID: VxyZgL0WS8O2yrnlkTwwVw==
X-CSE-MsgGUID: gb9jsf5TTzWkjd20oz81HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268676438"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 02:19:11 -0700
Date: Fri, 4 Sep 2026 12:19:08 +0300
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
Subject: Re: [PATCH v2 3/3] dmaengine: add union chan_dev for dma_chan::dev
 for clarity
Message-ID: <apqNDHoNt09QYJe7@ashevche-desk.local>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-3-0db305b6c716@nxp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-dma-chan_dev-rename-v2-3-0db305b6c716@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 04:53:13PM -0400, Frank.Li@oss.nxp.com wrote:

> The current dma_chan structure contains both "device" and "dev". So
> 
> chan->device->dev refers to the DMA engine device.
> chan->dev->device refers to the per-channel device instance.
> 
> Their similar naming makes the distinction unclear and increases reader
> confusion.
> 
> Add union dma_chan::chan_dev to make its purpose explicit and clearly
> identify it as the per-channel device. After all user switch to chan_dev,
> union and dma_chan::dev will be removed.
> 
> Update the kernel-doc accordingly. Besides its sysfs usage, the per-channel
> device is also used by some DMA engine drivers for IOMMU mapping and
> therefore deserves a more accurate description.
> 
> No functional change intended.

...

>  static inline struct device *chan2dev(struct axi_dma_chan *chan)
>  {
> -	return &chan->vc.chan.dev->device;
> +	return &chan->vc.chan.chan_dev->device;
>  }

Looking at this and below I think we need a common helper(s)

>  static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
>  {
> -	return &lchan->vchan.chan.dev->device;
> +	return &lchan->vchan.chan.chan_dev->device;
>  }

>  	({								\
>  		u32 _v;							\
>  		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
> -		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
> +		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
>  			 "%s(): readl(%s): 0x%08x\n", __func__, #_reg,	\
>  			  _v);						\
>  		_v;							\

>  #define phy_writel(phy, val, _reg)					\
>  	do {								\
>  		writel((val), (phy)->base + _reg((phy)->idx));		\
> -		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
> +		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
>  			 "%s(): writel(0x%08x, %s)\n",			\
>  			 __func__, (u32)(val), #_reg);			\
>  	} while (0)
>  #define phy_writel_relaxed(phy, val, _reg)				\
>  	do {								\
>  		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
> -		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
> +		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
>  			 "%s(): writel_relaxed(0x%08x, %s)\n",		\
>  			 __func__, (u32)(val), #_reg);			\
>  	} while (0)

>  out_unlock:
>  	spin_unlock_irqrestore(&pdev->phy_lock, flags);
> -	dev_dbg(&pchan->vc.chan.dev->device,
> +	dev_dbg(&pchan->vc.chan.chan_dev->device,
>  		"%s(): phy=%p(%d)\n", __func__, found,
>  		found ? found->idx : -1);
>  

> -	dev_dbg(&chan->vc.chan.dev->device,
> +	dev_dbg(&chan->vc.chan.chan_dev->device,
>  		"%s(): freeing\n", __func__);

> -	dev_dbg(&phy->vchan->vc.chan.dev->device,
> +	dev_dbg(&phy->vchan->vc.chan.chan_dev->device,
>  		"%s(); phy=%p(%d) misaligned=%d\n", __func__,
>  		phy, phy->idx, misaligned);

> -	dev_dbg(&phy->vchan->vc.chan.dev->device,
> +	dev_dbg(&phy->vchan->vc.chan.chan_dev->device,
>  		"%s(): phy=%p(%d)\n", __func__, phy, phy->idx);

> -	dev_dbg(&chan->vc.chan.dev->device,
> +	dev_dbg(&chan->vc.chan.chan_dev->device,
>  		"%s(): desc=%p\n", __func__, desc);
>  	if (!chan->phy) {
>  		chan->phy = lookup_phy(chan);
>  		if (!chan->phy) {
> -			dev_dbg(&chan->vc.chan.dev->device,
> +			dev_dbg(&chan->vc.chan.chan_dev->device,
>  				"%s(): no free dma channel\n", __func__);
>  			return;

(and so on in this PXA driver)

Besides that we should drop __func__ from all _dbg() messages, that can be
enabled run-time with help of Dynamic Debug.

So I think this driver requires more prerequisite work.

>  static struct device *chan2dev(struct stm32_dma_chan *chan)
>  {
> -	return &chan->vchan.chan.dev->device;
> +	return &chan->vchan.chan.chan_dev->device;
>  }

>  static struct device *chan2dev(struct stm32_dma3_chan *chan)
>  {
> -	return &chan->vchan.chan.dev->device;
> +	return &chan->vchan.chan.chan_dev->device;
>  }

>  static struct device *chan2dev(struct stm32_mdma_chan *chan)
>  {
> -	return &chan->vchan.chan.dev->device;
> +	return &chan->vchan.chan.chan_dev->device;
>  }

...

Something like

vchan_to_device(vchan)
{
	return &vchan->chan.chan_dev->device;
}



-- 
With Best Regards,
Andy Shevchenko


