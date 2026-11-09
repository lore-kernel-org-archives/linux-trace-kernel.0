Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199224;
	b=ETPUQ975szpt0KcwlOcSxLtcIYOFEBdw52z/jmqDgrLtvT7EMYl3zfg6p2Db5Lt0pPL4
	 4Ns8eWRUlHcOdX9UlkWbfgxzU4eXoMaE1fkbeGDbRq7jD2q5RWAyIHWJlrXycqHHNhc8w
	 kQMs2lFjS+nYHKh3hBpOrWppQAcrHU/c8PpsoTRRdHiBDRyW19gDmmozB9klU0SPHV6Aj
	 s3ArYfuNXaiOxCP5m0xk02f1sDxF7n+aAcb73w8QTF0zZVY7yNayv3ESzx60saKSWppW3
	 CQ2F7xIwbyWh3NWP0bMGPV/FaampICPvdbJGjk4MotG/jAxQFBJRqJzfpeuNVRwaVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+JJP82a+q4C9sS3G5fXe/VKxFt6JO7RhqZEnMMkyves=;
	b=KXte94SYY+9zOCMLjrpXcCUdIJDaMKAds4HM2WDssKsZOHKdcATgsd1vN50izYyVUWVo
	 o0yTD6KFKypVIruFkq75ywRhssz5GsUjtk9RcvkZ6x5f9epWPv0D6eF6YTCUpk0xrRDxz
	 pLrzQNYVfPo08eSJofjLL1x90Jx5bZ6wNjcc9oQ7Ryws+lQVniCVU3nCHTCrfKIS47ef5
	 rCg2wAT3hGwBMfMo3mOTztxwZQiNvS6lwZhpmaOC0DMtKsYPA8z7oDGGhJTQxRGE4oG/V
	 AiVfxAqm7c7CIENef6/jOGfuPc4eGKvYP2SIMa7vLeqJBbxjR8I3oOAAgmumT2R5FAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOP52uhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441E606A31C;
	Mon,  9 Nov 2026 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOP52uhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F941F0089F;
	Mon,  9 Nov 2026 04:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199224;
	bh=+JJP82a+q4C9sS3G5fXe/VKxFt6JO7RhqZEnMMkyves=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOP52uhB60mZaPusu4uoSi9Uccvp8DIp+a+EWp9x703GoX6r6ANMDJCzars7J14Vl
	 2PvSqub7uyCWk83V3UWOzevp7JnWf7Svm08FstQSTNjvZP1ZGxyn1MBUZTaEC03H4q
	 YCxeAcF+/ohhX9Nbsr1K8zoAK22d04E7o4BeBrVgOZJ5iYMxEShACERwsM1qDMKj/h
	 0oTPUN9Rn3f9eW3vr9z0MIaw4fob0cTOhMQyjk8FFSonD3Rg1VddDS5nrfOucIUF0c
	 h8yN2hyOOVk04uv7cmClF3GThBss0p5+vSf5KORzg7apBhQggGLfQuIW40YrwxdBIE
	 0iaW6+GHQopXw==
Message-ID: <sashiko-outbox-204407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: qcom: gpi: Add trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-trace-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261109-add-trace-support-gpio-v4-1-85ed08134917@oss.qualcomm.com>
References: <20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com>
 <20261109-add-trace-support-gpio-v4-1-85ed08134917@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:40:23 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dmaengine: qcom: gpi: trace_gpi_irq_status() outside loop in
  gpi_handle_irq()
--

commit d58f53a2d6e27d4e15eb4d5e08cf8036404a5c06
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Add trace event support

This commit adds tracepoint definitions and trace calls to the Qualcomm
GPI DMA engine driver.

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
> =20
>  	do {
>  		/* global gpii error */

[Severity: Low]
Should trace_gpi_irq_status() be called inside the start of the
do-while(type) loop instead of before it?  At the end of the loop body,
gpi_handle_irq() re-reads GPII_n_CNTXT_TYPE_IRQ_OFFS into type, so any
newly asserted interrupt bits handled in subsequent iterations are not
recorded by trace_gpi_irq_status().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-add-trace-=
support-gpio-v4-0-85ed08134917@oss.qualcomm.com?part=3D1
