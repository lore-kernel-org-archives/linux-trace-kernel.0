Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81B4CA77D;
	Fri, 25 Sep 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370156; cv=none; b=WCnTiHRcyzceZa0XGrupyB9oCRnqwadtzdD//q704ugVQ4v7n3j39RYN8f+NWKPSlO4fTEBwjG4S4RZbqaR8Gavm4Dj7ZakqFisF9HC+l1E1q1pj/+or7l05lTeSXTDYJeTj7kxBHtdfrqU4LzD/8+hEsB9aYzfaEUdkdRgIxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370156; c=relaxed/simple;
	bh=51ZaFsdFz1Wwq5zlbutLpUtcWj+XGGPb/nMjS2QfCeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUNiTV+AaHKw67yfSLbC2BLc5E1ZQMpy8vBJSIthnmnPKUpOWZKkjQyZwF8zIM4aAdEG1njdyGA5n8O6n584c5jG+R/x1JEeZfOhg0BWdp0Z74nELMpmpBUZhSGKVgsSOwip+A+FsB/hfrmfc47Y/28U/a/FBpW574Z37FJyc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzO0Ds8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzO0Ds8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137531F000FF;
	Fri, 25 Sep 2026 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370154;
	bh=//o9C0aXh23cIQirCEq3IcN4PyV1OvHdwiwsfc7FSvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzO0Ds8TtYzGDJNZBtdBKoh94H9zfnrvyVA5RjLIdDv9AvtbeEfF1d8D6RcZ/0ptc
	 KzRYw1ArYEIG8YDMUXlWXI6ZSmlmnBcN8fSK3XqdRPH9lrwy9xnJHAFfbunddAeblg
	 d9Oz6ho9t7tn8i06sIq4MXvy7GcSFcA7xAsaXQQd6YpGpKQea/LY98/BHYHRNcVaME
	 jULCJhg9xSJbcyoGTJFh7XVJlJ0O8BgJdfI2G7GMdHbKytL2LTY3OQTM3IBOR5K9CY
	 PWI/MAIgawS8WAQYa5szYk/tV8z4eXGfWOOlAhFVyvGnwReQdWSpG2pZq9mBFsLTFV
	 /xlYdOAK5C+zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: qcom: gpi: Add trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260926-add-trace-support-gpio-v3-1-8572bf7456b2@oss.qualcomm.com>
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
 <20260926-add-trace-support-gpio-v3-1-8572bf7456b2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:02:33 +0000
Message-Id: <20260925210234.137531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dmaengine: gpi: dropped trace events for coalesced interrupts
--

commit 0bb8d8f2455ccff160b2666b22bf4854db9eb970
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Add trace event support

This commit adds tracepoint support to the Qualcomm GPI DMA engine driver
for structured runtime visibility into GPI DMA behavior. The events cover
channel command dispatch, IRQ type handling, and state transitions among
other details.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index c41bfac65ddf3..fafe6ac848d94 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c

[ ... ]

> @@ -841,6 +846,7 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
> =20
>  	offset =3D GPII_n_CNTXT_TYPE_IRQ_OFFS(gpii->gpii_id);
>  	type =3D gpi_read_reg(gpii, gpii->regs + offset);
> +	trace_gpi_irq_status(gpii->gpi_dev->dev, gpii_id, type);

[Severity: Medium]
Will this miss tracing coalesced interrupts?

Because trace_gpi_irq_status() is placed strictly before the
do { ... } while (type); loop in gpi_handle_irq(), when new interrupts=20
arrive during the handler execution and the loop re-reads the type=20
register, the tracepoint is not called again for the newly read type.

Should the tracepoint be moved inside the loop, or placed iteratively
after every register read?

> =20
>  	do {
>  		/* global gpii error */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-add-trace-=
support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com?part=3D1
