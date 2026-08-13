Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D38248F72;
	Thu, 13 Aug 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642265; cv=none; b=FiCghJzGPHCC6yij3NODRcChNsXb9OhaxNvHEiFGGquxu2hQ2PZblhitRdbwziGamW3ZsUx6HurP4Gv0/hcRjhy+cLr5wcQGfKquxDcYbmUs8BHmZdCZDZpqZlyL48+IiHPwyTaW8jW6+PF22Hujd5ptHE/ptH7HJP+FSdn33Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642265; c=relaxed/simple;
	bh=mjiOVMOMk2a1S5jj4W+hcPd085Qe5oN/ZdhhlcJBzic=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=jakgAmupEGEnXk0vJE8ielw437MWzy5EQd9WzmanzSab/CotD+AQzPnLgCYmnkF5QnLYnLP+jInKXuUyTnITKjucv7wOT/3nLtelU/2glv2cXdU4OS4kiCyylCuAOdO9mk0uadRjsDtL1TltLlZKysTsZcq9EJWKjwSw9y62qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=BrKU/2d1; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BrKU/2d1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=9kz+jvI32wPERrbL870TVMeN4G7K9bL5RJ1JKWoZA1Q=; b=BrKU/2d1rri5u9vmgacwHn1MUI
	ZHpp0GTxVHpY8teh3yMHnFNG1J2YK/+OR2P641SXEh/9xOhAsGzmWrdPYKr1TyHQFIAWs8Wv0N2z4
	PdKTylS+hQFqrZkg8asEh4M5ashON/XmnNl3rnu/VxcIUxQkFTqqC50w+6+fbUD/kR3FUxDrRVze8
	+NXhu0EYOxSfpxfHKSK4Hs32KJU17r+EfCUMrZdbbEk9UTCDQFIXpFsA5GBAPaEXKyL3iqJArWxou
	L80v7g3Nno34JxU/Z3I3NRZC8FY1yzGCY6QIUaoc9DR8OQb+YptrrqBpfwBY4INCvEpebpD8r0wej
	18FOpRvw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wuZGC-00000002RFD-3NzV;
	Thu, 13 Aug 2026 11:30:33 -0600
Message-ID: <11f666ce-ea7f-48c7-8219-baeb04498654@deltatee.com>
Date: Thu, 13 Aug 2026 11:28:43 -0600
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
 <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: Frank.Li@oss.nxp.com, ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, Frank.Li@kernel.org, paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com, zhoubinbin@loongson.cn, patrice.chotard@foss.st.com, amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, thierry.reding@kernel.org, jonathanh@nvidia.com, ludovic.desroches@microchip.com, vireshk@kernel.org, keguang.zhang@gmail.com, afaerber@suse.de, mani@kernel.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, kelvin.cao@microchip.com, ldewangan@nvidia.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, imx@lists.linux.dev, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get
 per-channel device name
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-12 3:24 p.m., Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the existing dma_chan_name() helper to obtain the per-channel device
> name instead of open-coding: dev_name(chan->dev->device) /
> dev_name(chan2dev())
> 
> Simplify the code and improve consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


