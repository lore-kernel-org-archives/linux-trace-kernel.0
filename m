Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F64443AB6;
	Mon,  7 Sep 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771651; cv=fail; b=Wqk+5A67Th6qZ2ZZy4TOF5DVlTVU9T8BaN70bAD74x7oB5zMIBllSZkdl5YyN60bCxEOEAaY9o6Rs1pbhn2tdgM1w1v/osAiIVDVf0fGIxpGR0K2B0EvnlTbTkgRc/M0D0u6DlLE/JQomBHaLY1DiMWaL+AYoEwWsJuLM4vQKLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771651; c=relaxed/simple;
	bh=v6VaWMl7dKVjpj4xDZFz3IqIEgAdBMeQYbfexIXFZVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uDkLCnJ4FgwnSs99e19apnkCAl1xbAa1tV/LLphro4Yg2Y3VktylcbA0yG2//YSyXylIrKXSqrb7Ozhg73iGezRqtERB1I7N4JFig0mMO/A9JJpE76AdSAiolphKDOfk05rYoAs1722taMI282qFnaAA+Rw+BVdITOHefIt6YD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=V9G4anj3; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="V9G4anj3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxEM7F1EGmf2VqlHqpUqvg2kwtXvELm+H7CJ/e/QXvQpKsc3i5w6P1JKjhn/W5112lyKfn+Dhh0n6HnwkzrVZDbBcPh0n8RYmO7A+c3kOc2UsALQ55obJmI5RwhiTS2SDYNymMs3CYW4DrP0rR0/WDZ5BhOs+6NCXNtPvHcvyRwvVivYqTy1ZF7zm3IqpNy2GgBNKDKrVbljr7Fo2dId5ayrMrGh8TzkhU1vKYpUB1WeSI+HfLdthIOLh7e584C6a13p8RJMDNFrZBb84cJAkEL9NsPOAYm3NjcvVgNYtLHSvYI27/xx9zL6zPHG2N0ujElmsby8sazx8oFoFD/yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANf9UDNytopyrwg+LpWVjvNBhiwnWv7brkza7pslZ68=;
 b=pnC/H3UFqdmdcqtmu2d+4AfBYk3Xq20O849I8fWPX9MjYvVoEd/6CCOs6ZfbwITX9HYW4mnDURrZXET4of3yIFCGy3AQX4CM0y3ekNBA4Vuy2kiViGRl/lAdJF1Zoyj4gs1V07HrYGzQyo8yBGQMNK35I/mJ0rx1+CxCOHeiM/xiM1mLKODsF+I6X+h3azx2JkJoB/pMkyHg5N+KBmF9rtYTtHzU7J/CFiEeKR8blC5UQdFdBNnvXIXHB3JOh7RXYTkt2fIDq0M8lI7NVGzMQEZA8o4Hf4lHrL/m3bt2H0pWr43sAVRgZiVkaB0LbglWkPFEmO2DlsNUr0Nu5308nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANf9UDNytopyrwg+LpWVjvNBhiwnWv7brkza7pslZ68=;
 b=V9G4anj3zOjAYDvDBOoOmadbCcwKx50NWyWAQawzmaWsv+RDisslij+pkWJSNIcqWEcCwUqn61TVIHO4RtAkCDTmYf/dewjxZZaQZ6rVKrkGZTOX7cCaAP1rUr+l9hgrtMmYfclFIl2J1LhMGXvPgdAoDLw3C/AZHETgl6op6t1a7EE9u9K3aVrIe69o0nKRBrpsmTeTsGqKmLJxOt3MFcInO/pnkApWAUKLwVh70TacwVDZsWmx28wGTpQ1Avm460325g6WyPdlRJXy5LPo3iquLX6vSvRAgtabJpRaMaFkWUKKq/JE6XXxm0K3i0+ajQm+I0Sz8dk1JQKa/9IJ5w==
Received: from DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) by GVXPR10MB9163.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:00:41 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::46) by DUZPR01CA0231.outlook.office365.com
 (2603:10a6:10:4b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 09:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 7 Sep 2026 09:00:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 7 Sep
 2026 11:06:40 +0200
Received: from [10.48.87.20] (10.48.87.20) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 7 Sep
 2026 11:00:38 +0200
Message-ID: <10aec35d-5828-44e6-a72c-1b8fceb1d95c@foss.st.com>
Date: Mon, 7 Sep 2026 11:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
To: <Frank.Li@oss.nxp.com>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung
	<schung@nuvoton.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, Paul Cercueil <paul@crapouillou.net>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "Ludovic
 Desroches" <ludovic.desroches@microchip.com>, Viresh Kumar
	<vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
	<mani@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
	<haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "Chen-Yu
 Tsai" <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-actions@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<imx@lists.linux.dev>, Frank Li <Frank.Li@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-1-685601b0b788@nxp.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260904-dma-chan_dev-rename-v3-1-685601b0b788@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|GVXPR10MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 479e9f74-3004-4795-dd49-08df0cbe7df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	ptbm1Px8qYODMimfyFIYDZBxrv3Mn3uCcbbk3lshungwl74rVnhyD725DTkdxMfkOvljVDELSqsuyQMRYxQM3z0zi7K/JT5Ov4nLLKSDgBAtSJ6hV3ETIqROCezqJTnvjmeiwuUDOPAd5jmfDAdBbg8hH25hww7YEDQWjpXb0sJzPsgmQzqx80McCJFEnPY80VE2h+1fyiCx6QowWnF+NFNzwq/6w1QKQYwskF5QSn++/DRcMiCq1L7U3goivbguXeUZqL3+I9lmHTssmH2jLl0A4h0gTeH543Wli6uLZmOwflkbS0KetJCFuOM6+iE+JXjOm6OzzkadGPs/skazx2Mjw3iE6CBTS+nqlmzJmo9lqqtTfDK5RDmSuL0qJHxJ8Z6EQ8u1YWFGFFqiwYgzpXza7MaaN07J8jswFfXt1RkkDsRU5Nbm+/gIKQhikZXqtQkdnS2WTSTTab5HAOGRsMmmCd00vpApMGuOwWe2L8278iwAYl5kPTVKWU4mJWk/MOKwNFu0eQfVoGfDMLS/ccR5iAqp7+yxrw+klwXynOeaFGeZRxKlQCs22C+9iTbZtk2KIroDn+cOURZJnBfHoKMsaiTntlC7lzTP1IAblWa2SFuJMwe1f2n7OupzWr9mICAEOGaK429ZeWwGj+F+FUA0cmjpViJP63Smq6//tJ+5SUKSw+bh3+VusDIRozACZfRUdgeoSJXHJzMN5ALvCu8EPw2s+Q6mxpo9U5B3VkuvM2MT3fWKDARYW3Tmb9cMI18efJfwblXK8IOtQFpfVQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4YIPkN1mOz68rj1FpmNS3arBCn/cMxs23Onm7dsEXQ9dKlXhf66N1Niw1lvETulrRB6KTPuisW2x5YoRLm8RoEK+vGM/fX++DVbpnugWoZfg7q+sWUvepVDd4iAwfXdENfkYDWD6CjWTxmNIHln9r+YKbVxtiCcN9DabKLMzETwB2YRL7jbD/U66YQdUzIH7Uu1V2SC3sGuC7GwCi60wKKKnvK7/PqL+bzreER7g+odraiD+MDHAaLdtsojNFBNdM8hPvpPKDqP/vDw1LsWozOokYfLJntf42O5W6Q2un/WUpUAkFMImOJb7oG6e38Zm3q6h9/RnO5wSzMUWishK3eHYMCB9uvN13EPoD5UpA+gJFgZtI/wc/0rPlFQEmKGAvHI12Wt5y8V5zYfQZvnXB6uFWnMetSVZhcE6+TNXqXicGI1PwRl9E3H/z8ZASAsX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:00:40.5336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479e9f74-3004-4795-dd49-08df0cbe7df0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9163



On 9/4/26 23:49, Frank.Li@oss.nxp.com wrote:
> From: Frank Li<Frank.Li@nxp.com>
> 
> Introduce vchan_chan_name() to obtain the DMA channel device name.
> 
> Use a dedicated helper instead of directly accessing dma_chan::dev
> so callers remain unaffected by an upcoming rename of the struct member.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com> # For STM32

> ---
>   drivers/dma/arm-dma350.c                     |  2 +-
>   drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
>   drivers/dma/stm32/stm32-dma.c                |  2 +-
>   drivers/dma/stm32/stm32-dma3.c               |  4 ++--
>   drivers/dma/virt-dma.h                       | 11 +++++++++++
>   5 files changed, 16 insertions(+), 5 deletions(-)

