Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FE38E8B9;
	Thu, 13 Aug 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642487; cv=none; b=I5fDH9en1N2hb3piaXQ3qNHDhdZ+09O7ZlqKYb8ZPm25uZ0sQ/wOvpWELFc7QVu1vS8Nl1jQo5Lyq/bA9HGZGvbB9rhUNs1nljcxqc+QozUUvi6cehxETsA+bFAEl8w+CS8dqdH1ods0vsP79meqx6Ix/rV8RQyFsErlkfHQgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642487; c=relaxed/simple;
	bh=N1Hjk9riHLlq/h7iFL323EOWWDmlwzDwCifp8K79TiY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=eO5dZypTlSi9YnWHrl0SVcFniOwpby5q74hUuVUqSglmaqlc1w1v3yW7oXwOsH7IYPAJWbM2PDeKX1FMZm4UzYFxbPRp+PsL4IN3R8lzMW5lQAdn2wF2Eh6R6GDOgdYZJwfpsqztuRHJPSY//3Pz3Wes5w6x3Z84d9cfFEq0T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=L5+ZsqOt; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="L5+ZsqOt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=XFj6VBuvNlnLerahn+Ew2ADvQ1GLzQ4tJ+S+S2qSCZ0=; b=L5+ZsqOtNkaXdXhMeUmtDlxXCG
	4+nWgHrJ/6YJ7a7wgq9ZARZicz03xxQhv5a2V1xFjOPSAstssr5ix0VfMjKwL/MfYk69qSVdYKa8V
	7EIhycg37CLe4uJq27WaATd/QsdIRjTdsbnIXr9jGYu25sgB50xhxmWVTIlFhp1xha4mAHmrQ9ioR
	In/HlwNTgm+4Tm3c68Xl5hpr7vZPzq6XUCRoM84rgn8q+bD/2msGM9FUqy43Xu708/xoa9lTnNDfV
	AZ/h2VOCknwxnLug35RZsU//sokoMiM5WhtQv5m7s7DHnjngbdfaHNASnF1F2SsosrLxUXDsFByBY
	ePAS7V1A==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wuZK6-00000002RIj-2N9e;
	Thu, 13 Aug 2026 11:34:35 -0600
Message-ID: <9bdb074f-da65-41a9-b7bc-790ecab27e60@deltatee.com>
Date: Thu, 13 Aug 2026 11:33:22 -0600
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
References: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
 <20260812-dma-chan_dev-rename-v1-2-a67131f7d5c2@nxp.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260812-dma-chan_dev-rename-v1-2-a67131f7d5c2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: Frank.Li@oss.nxp.com, ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, Frank.Li@kernel.org, paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com, zhoubinbin@loongson.cn, patrice.chotard@foss.st.com, amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, thierry.reding@kernel.org, jonathanh@nvidia.com, ludovic.desroches@microchip.com, vireshk@kernel.org, keguang.zhang@gmail.com, afaerber@suse.de, mani@kernel.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, kelvin.cao@microchip.com, ldewangan@nvidia.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, imx@lists.linux.dev, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 2/2] dmaengine: add union chan_dev for dma_chan::dev for
 clarity
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-12 3:24 p.m., Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
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
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks, I've often been confused by this myself. I'm glad you're
cleaning it up and making progress.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
