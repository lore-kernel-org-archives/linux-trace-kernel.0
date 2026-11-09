Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199235;
	b=cYNb8evBtaojJxh37MSLQiqr2KO+dCWx1B3Dx50wJcXqQ4KzbkHdYuZ/2g6pOwjFj8YB
	 9CwPvhuiQbAZm7lt2b6wKwvaYVDyGmGYSha1cV86oktSwv7HTotWqx2pI07+/+SBHDcBL
	 iFGJmS11GlvxNyY5m0N2+HrgC1b+f+uItGy1PTpZIH5LkGR764XW7dMqBFRK0hQiyH8H1
	 g2gM13eQ0ktHQSuBkxZNH+gTmw9wN/tmfSuanHUomepNaMomyEFxTlbXHw4uUBHOueUUz
	 jgKJSvEoywbFucL3fwFVftakNHdZAVsEFa0/C9S/CYyYeuKrtDjU7UNsO4Ywu3cAp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zzq1ywE6lo5bqg/2dT+OQms0Rk30m6F5OCaHkpppRJI=;
	b=FEGQgbyFvfu0jDq0hiLw90E/yMiwpEhwhc/+vTvWeCS+W+OCCkL8IYVt5yyx/N3Sjpx+
	 wUuhZinS7caVus7fa+/oWCoqSF/qJ9FiZ+53z3I1OVBMYIzgHQu7h3QwO16g+fvyqXiEB
	 hkX5/OMhcBrDNpTWrU9mUgQY9DF4p394gBq7G2V+7Q+Nqi1F1qp11DjnPxA1TVJD4l92W
	 YzniqcYJU4aDg3Tg0fqgsxWved9gf5MJIQH3P2qFp4uAiViD70f7QYUWJEhqOR50HDfiV
	 xBuh+eoPG3Kka3UbLjZFzs22n3prQrphOrpB78a2RllLROBuw483F0LlPX8//cIjm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOWiY+0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D5606A31C;
	Mon,  9 Nov 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOWiY+0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D131F008A2;
	Mon,  9 Nov 2026 04:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199234;
	bh=zzq1ywE6lo5bqg/2dT+OQms0Rk30m6F5OCaHkpppRJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOWiY+0ByO9vW1Cq3mkLi2U8zHZCYFTMm9vfWcFpe6YaNYi7zdrZtSl9xzE2mpO8S
	 LZZozcgz4YbyrtLwFA9MLyEgNnes0EeMO+PIfAa/yyTLxJGbZkjHXToGYlwHPMu6Hv
	 cjGr71f07EV2q5QWP+XWIWdzshUIwcuztBJ5gMRebyNi+8+7/EgS1S9k5IkXtwuu2V
	 m652BVP1CaiYKOdJYGtMtHBZOkmCkXFsmDmDLzfPc4WKWDY6w1G/wSPVBfVWUXEVWd
	 LNfMcMQIMbLKNM2KQrQae032tMwcJxhip8SoPmke25uAoNV4bq2UxfNYIBesndmoa1
	 2GgbyFGygRXQQ==
Message-ID: <sashiko-outbox-204408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-trace-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261109-add-trace-support-gpio-v4-2-85ed08134917@oss.qualcomm.com>
References: <20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com>
 <20261109-add-trace-support-gpio-v4-2-85ed08134917@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:40:34 +0000
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
- [Medium] dmaengine: qcom: gpi: bare default label in
  gpi_process_events()
--

commit 5129f82faa3a23c9f80811290603ff518d6e73fb
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

This commit replaces the remaining dev_dbg() calls in the Qualcomm GPI DMA
driver with tracepoints.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index fafe6ac848d94..8f9e55e52c616 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c

[ ... ]

> @@ -1121,11 +1105,8 @@ static void gpi_process_events(struct gpii *gpii)
>  							    &gpi_event->immediate_data_event);
>  				break;
>  			case QUP_NOTIF_EV_TYPE:
> -				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
>  				break;
>  			default:
> -				dev_dbg(gpii->gpi_dev->dev,
> -					"not supported event type:0x%x\n", type);
>  			}
>  			gpi_ring_recycle_ev_element(ev_ring);
>  		}

[Severity: Medium]
Does removing dev_dbg() from the default: case in gpi_process_events()
leave a label at the end of the switch block without a break statement?
Under -std=3Dgnu11, GCC versions prior to GCC 11 reject a bare label before
a closing brace with a build error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-add-trace-=
support-gpio-v4-0-85ed08134917@oss.qualcomm.com?part=3D2
