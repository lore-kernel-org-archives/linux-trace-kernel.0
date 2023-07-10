Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0CFEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 16:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGJQN3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJQN2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:13:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723618D;
        Mon, 10 Jul 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689005604; x=1720541604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hcRhvsNpzCZm3Sd7nNPgrDaCtucecy1QPHYWw64ui6o=;
  b=gNhFXiXfjwNq5lgOn1LfATXCkYjrkUiekdloO+VlxgQAGwAowpuqnero
   LqwzCM58mwnIEo6x/vxNUY2goK7aOXUgMv0fr7tkztR6hfBI1DnMgLE9q
   +Jpx4d2Uyv67chiRtr0ioR8ixqTjMXI9XWukYXc1cBgoJowFte1TAeoNM
   FlAybTb6Hr4INO6T8ZDJ3joMZNvW8dugQm9OqLbOzuE5+MQiSBmZUOJD/
   pNOTl3oz/wHthzgZ3zrrrmlXXKNUQe6/uNM0QNkhpRV0ZDF71heDNUJMA
   0aDyyYGf6IoE9nWwExq8QuAYseXWicb+7ZNPpwqeDAyiGeTCigvmEXSgY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354244117"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354244117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="790844445"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="790844445"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2023 09:12:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qItUs-001bGm-39;
        Mon, 10 Jul 2023 19:12:22 +0300
Date:   Mon, 10 Jul 2023 19:12:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Andy Gross <agross@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 09/15] spi: Use struct_size() helper
Message-ID: <ZKwt5utuGaCf5nmT@smile.fi.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-10-andriy.shevchenko@linux.intel.com>
 <20230710-doze-scared-9f0a2e1a9125-mkl@pengutronix.de>
 <ZKwtgwZtUUHGC+S3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKwtgwZtUUHGC+S3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:10:43PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 05:59:55PM +0200, Marc Kleine-Budde wrote:
> > On 10.07.2023 18:49:26, Andy Shevchenko wrote:

...

> > > +	struct spi_transfer	t[];
> > 
> > You might want to use the DECLARE_FLEX_ARRAY helper here.
> 
> Technically, yes, semantically documentation [1] disagrees with

"and [2]"

> you, so I leave it as is.
> 
> [1]: Documentation/process/deprecated.rst:269

[2]: Documentation/process/deprecated.rst:350

-- 
With Best Regards,
Andy Shevchenko


