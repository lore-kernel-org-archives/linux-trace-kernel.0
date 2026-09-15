Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278674B5123;
	Tue, 15 Sep 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493783; cv=none; b=hAf3X0FZwPMqppq7ARQN4bwJ1sO00VKWFyYs0JZ6A8pNukHtih8mngznk9VnKC2x8cTsBTrghh7QC1xyJuobPalIzaAH+nH86LFY5E5u1AZWo3inm4wbmTGatUwqpt5GPsJTObKcqev5898Gv1ah+M40AaW0DhrmT1dE3B+fI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493783; c=relaxed/simple;
	bh=kOgdNJ3koZYykRt9HdMlU2I5LO0w6KpIWNWHFTo6/KE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HIEAktc9/iwGYbI6SuJc2j4uMtJf0CRgUxMfFINYWeXfkOlIYkMEM5C918Tm8PZBzR84jYWAPKSoMu/AMeKyyu/veGbOO0nqPA4nGCi11eINlVjmP0zm+1VoeGKSPVdK7Bsw+Yfi++A1YYjr21x71jhKHrl6Pff2Jn2t1INwIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqL0uFcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqL0uFcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1471F000FF;
	Tue, 15 Sep 2026 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493781;
	bh=eTLQWI728P1f1TgVNc2IjXvlKruVQpSAnHbGOlFGSMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IqL0uFcAz2W5DkjxGwOnkWfM8TYT1N01QbSqNK3HTHMrWJ43bARjd9DgtrhAA+Rxu
	 AXl3bxb6/jx9HNVXvT16HSsGtKRh3NyLYICoIxx0z3RP2s0fUb/g/5Urzt+JBSVeUZ
	 V9aLg7r6c7LM7/xKVxGQTneRMd50O3P9qKIPkNJGggGC6cmjXP9FhKqVuey76ETL0c
	 w4GUPZdtt0LiDIUsPy2XaBzSC3HsohqRmZu+6gVqgnGE8I6K+1EiVnTs+OgCsxwbAI
	 eFq37WxaO9GpIGKpb/KOnS946OLkckZszqkpaQHjg4CdbsCLEW70ryH7yPR0PTv7JQ
	 y0opBllzEbU8Q==
From: Vinod Koul <vkoul@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Frank Li <Frank.Li@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Binbin Zhou <zhoubinbin@loongson.cn>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Viresh Kumar <vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Frank.Li@oss.nxp.com
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
References: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
Subject: Re: [PATCH v4 0/4] dmaengine: rename dma_chan::dev to
 dma_chan::chan_dev for clarity
Message-Id: <178949376928.248239.6347762847462574995.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 09 Sep 2026 12:22:27 -0400, Frank.Li@oss.nxp.com wrote:
> The current dma_chan structure contains both "device" and "dev". So
> 
>     chan->device->dev refers to the DMA engine device.
>     chan->dev->device refers to the per-channel device instance.
> 
> Their similar naming makes the distinction unclear and increases reader
> confusion.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: vchan: add vchan_chan_name() to get channel device name
      commit: 75d8640d7f5f89d1a1c39ccb72166ada95fb38d2
[2/4] dmaengine: use dma_chan_name() helper to get per-channel device name
      commit: 76574306c1ac38137683c69407f0e7810f407e4d
[3/4] dmaengine: add (dmaengine|vchan)_chan_dev() helper
      commit: 3b97a3ec420542591c10db8600cf481f1038a011
[4/4] dmaengine: add union chan_dev for dma_chan::dev for clarity
      commit: 6ad1b49cc30dc9bc7c06dd44241e61fe6f82c0b8

Best regards,
-- 
~Vinod


