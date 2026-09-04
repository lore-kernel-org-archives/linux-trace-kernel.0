Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B742124D;
	Fri,  4 Sep 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521934; cv=none; b=L8IOl4mpkKc4pt5V7Lquz8TP2s13u/O2+m8kmqPitIP720O7/xzyy9uTDXfz5TXylBcI+a5uXHreGGjgAnFGUIcjQ+I9DSQHDWSxvrEeOKitCNHxySt502jkZ6ram2oppgLix4K2i57IXMBtPlF45LIUHUAyqFh+i8zkLJ3bQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521934; c=relaxed/simple;
	bh=sI88re9mQH9GGvNdQuqSOyqwac+FJGSZRs1mUIUeR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkUg4QPwqdho71NNwlSd+UcvqD0WpduP81hdnGUbVZdoeAdKs9Y9ZDunqmkZQkwVo1f9u+WEmsi+imm2RYgwwoHTeP7nMozglc7qnByFnoqOHFuGhDdb2kQNWLHfRa/kCw2upGn3a/vcFpILSFlOy+b7KbM5JoNaSXlp/5D6hQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqaD9GhP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqaD9GhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788521931; x=1820057931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sI88re9mQH9GGvNdQuqSOyqwac+FJGSZRs1mUIUeR4w=;
  b=UqaD9GhPIW/SEAoEvQoN/3I3/quz0Twf58glhUF4UbcXAPhfSIYEFom8
   asi/GlcCJpRE4/DOAHGUgb+lzY83/2fJFiSVHp3kIyLRaB6hWCpIa8k8q
   2t2iYNFuw9Dr7Hk9t/y1vRxsLA5OJ2KRzi9R+3Red0tuBJTXGQyPFVZnm
   1d+aS26JkqiJQKkrpvB8p2z/WALCvpkcItvZe9BoKVWDKKGJnpx8a3gNZ
   XYXsb57cpHTJlPkVqGh9f8Pow1nOt4cx7pZ/9pUxOGI7HKrGZcjEOjNDs
   UUsJEjk6FIPLMA3G8Trl1a4ffLKBe9mI1SCtb+QVB9iwP4XBRbXs88tcv
   Q==;
X-CSE-ConnectionGUID: LatcrKqzSN2OAwTI6oWWHw==
X-CSE-MsgGUID: FFbvIKOaRBitth8s6SHZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92720050"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="92720050"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:38:50 -0700
X-CSE-ConnectionGUID: ObP9eg0VQSCbRIFJ00EGKA==
X-CSE-MsgGUID: UlijwXHGRmWAqOZ/7kly8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="268698798"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 04:38:42 -0700
Date: Fri, 4 Sep 2026 14:38:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Frank.Li@oss.nxp.com, Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
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
Message-ID: <apqtvq2Xov1LKBPN@ashevche-desk.local>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
 <apqKgda7dW_JXolJ@ashevche-desk.local>
 <be376690-5219-4bf3-8ed7-02a49cee0e30@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be376690-5219-4bf3-8ed7-02a49cee0e30@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 11:26:37AM +0200, Amelie Delaunay wrote:
> On 9/4/26 11:08, Andy Shevchenko wrote:
> > On Thu, Sep 03, 2026 at 04:53:11PM -0400, Frank.Li@oss.nxp.com wrote:
> > 
> > > Introduce vchan_chan_name() to obtain the DMA channel device name.
> > > 
> > > Use a dedicated helper instead of directly accessing dma_chan::dev
> > > so callers remain unaffected by an upcoming rename of the struct member.
> > 
> > LGTM,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > ...
> > 
> > >   		ret = devm_request_irq(&pdev->dev, chan->irq,
> > >   				       stm32_dma_chan_irq, 0,
> > > -				       dev_name(chan2dev(chan)), chan);
> > > +				       vchan_chan_name(&chan->vchan), chan);
> > >   		if (ret) {
> > >   			dev_err(&pdev->dev,
> > >   				"request_irq failed with err %d channel %d\n",
> > 
> > This one...
> > 
> > > +++ b/drivers/dma/stm32/stm32-dma3.c
> > 
> > >   		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
> > > -				       dev_name(chan2dev(chan)), chan);
> > > +				       vchan_chan_name(&chan->vchan), chan);
> > >   		if (ret) {
> > >   			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> > > -				      dev_name(chan2dev(chan)));
> > > +				      vchan_chan_name(&chan->vchan));
> > >   			goto err_clk_disable;
> > 
> > ...and this one are duplicate messages as devm_request*irq() printsr
> > most of the information.
> > 
> > Not sure if there will be a patch to simply drop them.
> 
> It was the purpose of this series:
> https://lore.kernel.org/dmaengine/20260709135846.97972-1-panchuang@vivo.com/

Yes, thanks. My point is (independently on who contributes that patch) that
the piece above may be an unneeded churn due to messages are going to be
removed. It all relies if that series (a.k.a. patch that removes messages)
goes first.

-- 
With Best Regards,
Andy Shevchenko


