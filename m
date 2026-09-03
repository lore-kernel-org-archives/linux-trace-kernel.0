Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A22D7DCF;
	Thu,  3 Sep 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474794; cv=none; b=Iojo+FjwTLYxwrrYAB6W5Jtlq2zuvx4tdgC4uI/O2Gi+E2jTUheTaVu+RZwnwiuPjJV/tUkEStUCSD+F+uuxngaSkPp0etnEIeg3elzb/iPTcU5h1m6bjo60DH3n1N4p2GXzxCwa6NKmrnpNrDfu97cXPCFHqHqTIVXxBIS74Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474794; c=relaxed/simple;
	bh=PIXL1HlOr2OAWCKfAcP7uuThZNVlq9Vbb6VY/5c8pcE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=X/+dgPTc9qA/RArUJ/s9piPq5o7HC8aw+vSkBaTWeWrECl6Xjdnj/islRVkx1ADV5z14WnT3VOYQiJ/K+GBlhgxIPq9Zi/+M75blOnPqi1el6ZrCvMJefPyaeM/dYdMBhm3d5dGYPBYqzwr/x7f6XQW8ZpdQNwya0L+dpPXrGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=JxhafLRB; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="JxhafLRB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ZpOyW9JwdzvymqD7nh64dhGMgQ9gYFcIgy1C7e7EDew=; b=JxhafLRBFfiDbyUgKcxbdSJ2dB
	G/LvGMoB/v6HYzBXhKjf6dKeFB5H+10bD37VRifeQ+IQOe1OOrI2sYFlDm8ol7jTn2tPJyT1qAxf9
	2g7eLzUtwiPDksHmpo5egNV1iJ3GeKdR33UH5IPfi+V20GQ7DZaS3mAIHe/lR6+R4bjLPOgNyBVWN
	eGhbVPL7oZXNhllf05l+l2reLpOpV8o9PVpH/MPGKrrj6j+/coMHh8vSbqi4cjoNrEDN7dijdO5DI
	lrpCi+m+/WHQRtrKOEnzkBkCWiYJ31KSiouFHjsJYXPZro5rxKb/hxeJNcmS4Qw5US97USWLcyIWE
	y9y2zAvg==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x2FzL-00000001iUZ-2jmV;
	Thu, 03 Sep 2026 16:32:56 -0600
Message-ID: <1fb463b3-437c-43fa-95df-29c2c7d2496d@deltatee.com>
Date: Thu, 3 Sep 2026 16:30:55 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank.Li@oss.nxp.com, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Binbin Zhou <zhoubinbin@loongson.cn>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Viresh Kumar <vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: Frank.Li@oss.nxp.com, ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, Frank.Li@kernel.org, paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com, zhoubinbin@loongson.cn, patrice.chotard@foss.st.com, amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, thierry.reding@kernel.org, jonathanh@nvidia.com, ludovic.desroches@microchip.com, vireshk@kernel.org, keguang.zhang@gmail.com, afaerber@suse.de, mani@kernel.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, kelvin.cao@microchip.com, ldewangan@nvidia.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, imx@lists.linux.dev, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/3] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-03 2:53 p.m., Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Introduce vchan_chan_name() to obtain the DMA channel device name.
> 
> Use a dedicated helper instead of directly accessing dma_chan::dev
> so callers remain unaffected by an upcoming rename of the struct member.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
