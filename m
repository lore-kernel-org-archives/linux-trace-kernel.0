Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799273;
	b=n4RKZZAbjk2zrhoSSmkJbdAufgn9FlCkjgB/IAgCmNd+BiNhdZbjPatEYx+Ks5FEUnxK
	 id4H0SQUmPE4fv8g+WNWbnAHC47Lh5wO2Tz84L/iNs6k4/xGoHdl5XXuafIneNCU5rC0n
	 1PQYsYgUvIiHjXCQahloMhyrADjf+37Zp3XwERl/DhkFF714v0V1mz0J85iO2d8tLi5gz
	 c/JcXvvbdWK1ubmzyjPkLWD/B/QfzlZplV4uXV2MHtWqX4DNPE8iJSKq0pqhOexkKnGHq
	 3B61dBLsTl+Z9wLQjfKHPdahWUa6Us/WYc6oyYhJkl6d/BJXTb3h3eZWq8S9y7iLFyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vcjiH1TUy+GY3+dmhgbUvGPnqAPspWJzTSrt2DjxgLY=;
	b=1RFPuNj9F/3iMn1g8qoC4ptmdkA3t5vh61YE0FTVQB0J5gd4O94Tr6eVDHWnJdY2J4Xi
	 wQtmOil3tom/8EiZySG9yU0vaksRV7l2SAx11FaA2OZZjO9n7Mso4kbA31XvAbKmzUvh+
	 qMc4pa8V281+gMiM8iq+uK40KsYfPDh9sgRDRuRN6TyaJz7WyOjKNdWhc8MqmRisrGMQf
	 7atLevYzmtaSZKvAIjK1+OxgOh9tlAVUmv8cPEhCadWc69lY0E/dce91Xd1Dd+4rMmZk0
	 U1BIFjlIFyr6JuFbLhJCqn5pmPxr8QlcTP9iZIvFbNNdVuYIS8HZkX5lCVVi8CVN55A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOmhEnLY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D5606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOmhEnLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6062C1F0089C;
	Fri, 27 Nov 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799272;
	bh=vcjiH1TUy+GY3+dmhgbUvGPnqAPspWJzTSrt2DjxgLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOmhEnLYgqV4NLWZOIB5I4DrskKgaKd6l2RkdXW52dDb6ZytNtAPFuWaVQLXhIMFg
	 MO+9ylp6DKBEHcaceryCstGh9x5c0pP47vrAcZrsYxxqy7jMsOuA027zmiuluZ8LuN
	 rwSeJMsocn8Xio0p3lnf3bLLNU4DdoMTfVb41CDgtvGCYfb92mdzibz2wYUo2/S72g
	 kQmJFryifMS1cdxcpBbMRWv4AqX01uViAcznhPulmDXThxaRAiD0VkSOT6tXVeb+Cj
	 4i0lQIMnthghNe2UMVdAk0NQI0i+EhsZNgZmQm9RsRPHrE7wvt3KZhqmyaNbXTrNfZ
	 jqLwYNlzGUIfw==
Message-ID: <sashiko-outbox-237963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] media: hantro: Add v4l2_hw run/done traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261127-v4l2-add-ftrace-v4-9-24138479002f@collabora.com>
References: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
 <20261127-v4l2-add-ftrace-v4-9-24138479002f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:07:51 +0000
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
- [Low] media: hantro: spurious v4l2_hw_run trace in
  hantro_end_prepare_run()
--

commit 1ae655efcf68c0a93d5323d8fc7f3881bf26bec6
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: hantro: Add v4l2_hw run/done traces

This commit adds trace_v4l2_hw_run() and trace_v4l2_hw_done() calls to the
Hantro VPU driver and records the hardware cycle count on the Rockchip
VPU981 AV1 decoder.

> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 3734ea701145a..45bf926c0480d 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
[ ... ]
> @@ -159,6 +165,8 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>  	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
>  				   &ctx->ctrl_handler);
> =20
> +	trace_v4l2_hw_run(ctx->fh.tgid, ctx->fh.fd);
> +
>  	/* Kick the watchdog. */
>  	schedule_delayed_work(&ctx->dev->watchdog_work,
>  			      msecs_to_jiffies(2000));

[Severity: Low]
Will calling trace_v4l2_hw_run() inside hantro_end_prepare_run() emit
v4l2_hw_run events even when frame preparation fails and the hardware is
never started?

For example, rockchip_vpu981_av1_dec_run() calls hantro_end_prepare_run()
on its error path before returning without enabling the decoder:

drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:rockchip_vp=
u981_av1_dec_run() {
    ...
	hantro_end_prepare_run(ctx);

	hantro_reg_write(vpu, &av1_dec_e, 1);

	return 0;

prepare_error:
	hantro_end_prepare_run(ctx);
	hantro_irq_done(vpu, VB2_BUF_STATE_ERROR);
	return ret;
}

When rockchip_vpu981_av1_dec_prepare_run() fails (such as on an invalid
tile count), this emits both trace_v4l2_hw_run() and trace_v4l2_hw_done()
even though no job ran on the hardware.  Similarly, hantro_g2_vp9_dec_run()
and rockchip_vpu2_vp8_dec_run() call hantro_end_prepare_run() when
start_prepare_run() fails and return an error to device_run(), which emits
an unpaired trace_v4l2_hw_run() without a matching trace_v4l2_hw_done().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-v4l2-add-f=
trace-v4-0-24138479002f@collabora.com?part=3D9
