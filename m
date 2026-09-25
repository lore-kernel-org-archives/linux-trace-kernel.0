Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801863FAE19;
	Fri, 25 Sep 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370166; cv=none; b=SwwHta+qYUnW7C7Bi7x2VTiRBl5oO3aFSx26P3qTAHtgXgkpr8ju3/09AWOwKr6lu2nReeieYNb+2c75bfHv3oj5oyUXqP0a5O5vbR/+g7IBXxaKreKVImHz+oIBfTwUkZedwZy31z9S4joKz+Yk6msMzl0DtNuXCdvxLQA9X+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370166; c=relaxed/simple;
	bh=Qvqz7Wr5yNqii1/gjS269mf8ctwQbgdLvv5LqtbjgCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVznq+SP/2mHXDxHrRmkRX/1SyLghFYEakREmnjORbPBsLcCCQxX55qYuWra/6vPNbGt94HfnzlbkQ65ifzT7JySzBfMP/SM2gfzGXg8l0GgUK4QjLMY5D3KDn8GdBimGSItCxcfGMrOzzlcvAoJTru1Dzlqfzpn/UDPJ7h0DFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfCg6Kmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfCg6Kmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D5F1F000FF;
	Fri, 25 Sep 2026 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370165;
	bh=P/uk8SXQCZgKI7sjJqX34SkDP99fYN77zTseeuS6D1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfCg6KmmCELIT0nNfyGtQuR/l1E5euqXk8rNS+mj+TwaDnWMQYVHhzushSdvDg0zg
	 mvyNCi2qsP87/ylxyMQMxyxMxZNlCrwgOHelACigGY440JAvAQwiamgXekCg4gbbIk
	 GbQGuErfs/8XZhsX6Qv69DIhO5q8Y4aMTl9ovSzFbj8KguK8sv+hQjMsNLmV11t+vr
	 1uDU9SVqRM45/Fg8R51gufBwNYx8o1mrIuJnM/bSC99hB5Ia1a44iYruL/xIl4r1NE
	 u/xkVYGpZYgcKwqhyxA1/2jsr6XmK/bFabNODH4KAIg60H1HlB682PzWd3eBxBMzxO
	 4kUPXq2Rtezvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260926-add-trace-support-gpio-v3-2-8572bf7456b2@oss.qualcomm.com>
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
 <20260926-add-trace-support-gpio-v3-2-8572bf7456b2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:02:44 +0000
Message-Id: <20260925210244.D6D5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dmaengine: qcom: gpi: unused variable gpi_ev_state_str causes compi=
ler warning
--

commit 16ff3240f7873902688743d98570cd5eebf13594
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

This commit replaces dev_dbg() based debug logging in the GPI DMA driver
with tracepoints, providing structured runtime visibility.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index fafe6ac848d94..6aff2a0d54161 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
[ ... ]
> @@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *da=
ta)
>  				ev_state =3D DEFAULT_EV_CH_STATE;
> =20
>  			gpii->ev_state =3D ev_state;
> -			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
> -				TO_GPI_EV_STATE_STR(gpii->ev_state));
> +			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
> +					      gpii->ev_state);

[Severity: Low]
Is it possible that this change in gpi_handle_irq() within
drivers/dma/qcom/gpi.c leaves the gpi_ev_state_str static array and
TO_GPI_EV_STATE_STR macro as orphaned dead code?

Since trace_gpi_ev_ctrl_irq() only takes the integer value, the final
consumer of the macro is removed. Could this regression trigger a
-Wunused-variable compiler warning for the unreferenced static array
when compiling the driver with standard kernel warning flags enabled?

For reference, the array is defined earlier in the file as:

static const char *const gpi_ev_state_str[MAX_EV_STATES] =3D {
	[EV_STATE_NOT_ALLOCATED] =3D "NOT ALLOCATED",
	[EV_STATE_ALLOCATED] =3D "ALLOCATED",
};

#define TO_GPI_EV_STATE_STR(_state) (((_state) >=3D MAX_EV_STATES) ? \
				    "INVALID" : gpi_ev_state_str[(_state)])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-add-trace-=
support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com?part=3D2
