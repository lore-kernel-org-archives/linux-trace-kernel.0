Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926342E43A;
	Fri,  4 Sep 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512912; cv=none; b=TP/p7enwwh439+6pySCOyFNz9n005h8XuSITQinxIOfICFx0FBtEerNOLfVWMDlvXL//24LuntDoToR3W4VcDHmaEziENI4u4dsU6dMEyUUwakTkTK6bu7Uch+6b7tt1H/T67CoMV69kYDDniZeNOFR5W9tFgyl8lpXegNR+hTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512912; c=relaxed/simple;
	bh=RTOkuJscrpPJjVNNjxoNkn5V5c05RKVFnU/ZyQKRXhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioyjqVFqcwYc3DWp3rhYgNdGMp3efF+n4mvE0rza0WbJfAoYlnPshq2JUMmeTRHbdSuPeuhpEEDabiy8/39DtdHBWBxo2X9gplDGgtqtbUR0Uc0hyFqpHJFslcQbNqkR/q6w+VflA76/yJoaqI0SwiK0pHf9TV4nOlopsybQeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAs6v+X3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAs6v+X3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788512910; x=1820048910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RTOkuJscrpPJjVNNjxoNkn5V5c05RKVFnU/ZyQKRXhU=;
  b=NAs6v+X3rE+zaRAwahZC7m6n3SAJ7BWvE8ViOcmfn34gKLn7WE+aUri3
   OddVrV/E9mj8+THqPT+cJ7WA+8xjUWQfZETMrQUCLCirR9vHMV9txs2mV
   YiUA8p6tKEaRxIsj7AfZ5g4SKabhV0nPR5sku0QDRly769yyv6yABbBIG
   XAONz+PsFtvkPQ5ktWq5/r57rIWsNNKqH9Ltjka1NyvN9QStpn/oW/yg7
   PHyAskdV+dUYgYLoEmPPQkfdDx9deCgFDhmem6Xzx+QIAH6KZj8IrDAuY
   Yo09ln/mB2D/VoqLt6qKqEMmSJFWlEIeJFybt0LJdFA3gQkhwwQdBNQVe
   Q==;
X-CSE-ConnectionGUID: jxatw5hKRAaEGdN2UazRxQ==
X-CSE-MsgGUID: CBoWbNgAT6ScIVD4ibRvIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99669234"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99669234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 02:08:29 -0700
X-CSE-ConnectionGUID: EXOLF6UfRfSAQklaHXyikw==
X-CSE-MsgGUID: 3CuE8+pcSBiwMrpvowrn3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266732821"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 02:08:20 -0700
Date: Fri, 4 Sep 2026 12:08:17 +0300
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
Subject: Re: [PATCH v2 1/3] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Message-ID: <apqKgda7dW_JXolJ@ashevche-desk.local>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 04:53:11PM -0400, Frank.Li@oss.nxp.com wrote:

> Introduce vchan_chan_name() to obtain the DMA channel device name.
> 
> Use a dedicated helper instead of directly accessing dma_chan::dev
> so callers remain unaffected by an upcoming rename of the struct member.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  		ret = devm_request_irq(&pdev->dev, chan->irq,
>  				       stm32_dma_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       vchan_chan_name(&chan->vchan), chan);
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"request_irq failed with err %d channel %d\n",

This one...

> +++ b/drivers/dma/stm32/stm32-dma3.c

>  		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       vchan_chan_name(&chan->vchan), chan);
>  		if (ret) {
>  			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> -				      dev_name(chan2dev(chan)));
> +				      vchan_chan_name(&chan->vchan));
>  			goto err_clk_disable;

...and this one are duplicate messages as devm_request*irq() printsr
most of the information.

Not sure if there will be a patch to simply drop them.

-- 
With Best Regards,
Andy Shevchenko


