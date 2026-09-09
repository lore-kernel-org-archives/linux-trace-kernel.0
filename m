Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05822559CA1;
	Wed,  9 Sep 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957600; cv=none; b=XxWcWdsKywu47qQHDrzwAlgJwm7wr82ojYm4YO9+1QjUJXWOWgPrO/h/7Fng85j4SMidtT/bvg56Xqy55rHn8ehv/Nwox8zZfzTQU94qQwz3cd+xLaEWc42E4fbcTKiK8vCcF4yVcIsBoNpDtUUJZicTCH+uCmu05PTJ5sJ3p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957600; c=relaxed/simple;
	bh=xbYe82dXs9fCME0YyCdgSfK0I2LWsvQv0NiGKLBhX6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qldur3VqFqnsLfShCIIj2V2g10xv3XnWSJtmQhsBKDXX0wezP6LPf1Nxk7kCAw9Oxib537ZlMQOSvQwc0GAJ+X1mQq9Wo8BLRm+LDwB8T1g3F2xB6zFGdNhO0gdIHj3tkx5MDCdEosY3f6KQC0hrrQ05J6t5PtIfZ/b1roURoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj1IrIP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj1IrIP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780A31F00A3A;
	Wed,  9 Sep 2026 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957598;
	bh=4wjDBD4eTQIvB0n0DbUPkYQj15kwWSjuBDp4QqdtW1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rj1IrIP44mOF3Q6zyOQy+1mwdi2cS/MrkriYAymLSDMvvPBZjd2BSJywkaPirWg8+
	 jv/pq79HZ+t8lNaivmIEMURx7xVM9uZRHBtyl4CZpzxBScOgkPil862x8VRJkZQ8yw
	 vzXO0wfO/FidAIalJo0eqfh/4Ta6rD6cqcF/nQN2DB91B/G/QVs7KEZaIaVmSft2A6
	 tYZ4I43+QPYvVgApIkob6jsUrdpDLGK+t9Fq+CdwgOTVg0a++n811WNpc6Z9csJTwe
	 ppUYxVQ62KkGkRjhIUVlKTSDS0Ho258mO1pXA2cLr1XatH7NSfmBlCr9xQZXP4MaiG
	 6/OplGs7fuUMQ==
Date: Wed, 9 Sep 2026 18:09:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Frank.Li@oss.nxp.com, Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v3 3/4] dmaengine: add (dmaengine|vchan)_chan_dev() helper
Message-ID: <aqFTmjUCysJWmy-P@parshuram>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-3-685601b0b788@nxp.com>
 <c79f42cf-43c4-4b5a-a6da-217052d40284@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79f42cf-43c4-4b5a-a6da-217052d40284@foss.st.com>

On 07-09-26, 10:55, Amelie Delaunay wrote:
> Hi Frank,
> 
> On 9/4/26 23:49, Frank.Li@oss.nxp.com wrote:
> [...]
> 
> I don't think removing chan2dev() function from the STM32 DMA drivers is an
> improvement, since the parameter is a `stm32` chan, not a `dma_chan`.
> chan2dev() was meant to expose the channel device behind the `stm32` wrapper
> and keep logging concise.
> 
> > diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> > index 3e8151e2ad75a..4688cebaf7f7a 100644
> > --- a/drivers/dma/stm32/stm32-dma.c
> > +++ b/drivers/dma/stm32/stm32-dma.c
> > @@ -248,11 +248,6 @@ static struct stm32_dma_desc *to_stm32_dma_desc(struct virt_dma_desc *vdesc)
> >   	return container_of(vdesc, struct stm32_dma_desc, vdesc);
> >   }
> > -static struct device *chan2dev(struct stm32_dma_chan *chan)
> > -{
> > -	return &chan->vchan.chan.dev->device;
> > -}
> > -
> 
> I would rather keep it as:
> 
> static struct device *chan2dev(struct stm32_dma_chan *chan)
> {
> 	return vchan_chan_dev(&chan->vchan);
> }
> 
> and then drop all further updates.

I would say better to use a common macro than keep one for yours

-- 
~Vinod
