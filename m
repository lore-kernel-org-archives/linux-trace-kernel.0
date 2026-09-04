Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46323BD1B;
	Fri,  4 Sep 2026 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559375; cv=none; b=NoDCvAYINIsQdPEga1lkFzgkUMRcBMh6ZRIwWFDcisAa0MiCsN9WOiEWgtNHzbeSlx8cgmno8wW5mm1j8jocVLe8+p2W8XrMNvgb9ZBFsEkaye+LJitKvKRUBBE949MZ2wU8knDaTaJIo0a/yJIJvRMAPyFFfbjsS9qqXt7TKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559375; c=relaxed/simple;
	bh=v+IXWRxGdSiQM1vJ9ikhe6NB4EV4rEN+vEmgvFR9Lfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BOMYGdAfZAB0PeK00eSIsjNdb97ig+19rEA+3spkLPLVBOc86XvciojT53fbdWmOT620V5/0L0jgPO+NUrnJ5yZVSmNztUzT3vxUDyxZBAd68g3/Uh1UOH4OS3XuH+1ZTK86YsWG2yqnWOashi/62/92P2pZ/PgOlxJoJBTDlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k86gAmmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k86gAmmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2371F00A3D;
	Fri,  4 Sep 2026 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559373;
	bh=GLLXKAM/oFD/+TwCTarWiBZBq5qAd3TUL54mWsJUOcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k86gAmmYow38MLIxFp046up3K2eWST3U73EwQdYljm+IRdYr9aDHuFV0YdiEnkF1/
	 t1XytmSIP/xXdkXEFzlnBkhDt2LSdfzWsEK7Kq3W+4fPWHFkMHmNefKMFLqFTW9Zex
	 8RzOl1Pa2jjKHvXh0DiIGyZ+oF8lC8JEeY15vLlidFd19mdFa/nWuOb5sR3eTAj3K4
	 eKmz601nKBHKNK0vd+yTuOIjSkkfjnwyoR7uLD4MtmUJFi3NVVTDK1r9QC/bMC42Fm
	 IjDcQ3Hck25jH5tCIPE12O+LFXiuqaTk2eKbwOMyYesrC9lpQpIKckipt57la6sImS
	 69stsA8Kekj5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: add (dmaengine|vchan)_chan_dev()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, imx@lists.linux.dev, vkoul@kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-dma-chan_dev-rename-v3-3-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-3-685601b0b788@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:02:52 +0000
Message-Id: <20260904220253.5A2371F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Descriptor preparation functions return ERR_PTR instead of NULL an=
d leak memory on failure.
- [High] Out-of-bounds memory access in at_xdmac_tx_status() when the trans=
fers list is empty.
--

commit 3b17906d45663cb4c1aae18a74a2d9d31cfc3f4d
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: add (dmaengine|vchan)_chan_dev() helper
   =20
This commit adds new helper functions (dmaengine|vchan)_chan_dev() to
access the DMA channel device. It replaces private chan2dev() implementatio=
ns
in individual DMA engine drivers to provide a cleaner common API.

> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 901971e8bae69..d40a8b40dddc3 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c

[ ... ]

> @@ -1667,7 +1662,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cooki=
e_t cookie,
> =20
>  	dma_set_residue(txstate, residue);
> =20
> -	dev_dbg(chan2dev(chan),
> +	dev_dbg(dmaengine_chan_dev(chan),
>  		 "%s: desc=3D0x%p, tx_dma_desc.phys=3D%pad, tx_status=3D%d, cookie=3D%=
d, residue=3D%d\n",
>  		 __func__, desc, &desc->tx_dma_desc.phys, ret, cookie, residue);

[Severity: High]
This is a pre-existing issue, but is there a potential out-of-bounds access
in at_xdmac_tx_status() when the transfers list is empty?

If dmaengine_tx_status() is called after at_xdmac_device_terminate_all()
empties the atchan->xfers_list, dma_cookie_status() might still return
DMA_IN_PROGRESS because the cookie is not marked as completed.

Earlier in at_xdmac_tx_status(), the code blindly calls list_first_entry()
on atchan->xfers_list without checking if it is empty, and then accesses
desc->active_xfer. Since list_first_entry() does not verify emptiness,
this interprets the list_head pointer as a structure, which could lead
to an invalid memory access or a crash.

[ ... ]

> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/l=
oongson/loongson2-apb-cmc-dma.c
> index 2f1c8c4fd0654..755363f4bfa2c 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c

[ ... ]

> @@ -409,7 +404,7 @@ loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan=
, struct scatterlist *sgl,
> =20
>  		num_items =3D DIV_ROUND_UP(sg_dma_len(sg), buswidth);
>  		if (num_items >=3D LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> -			dev_err(chan2dev(lchan), "Number of items not supported\n");
> +			dev_err(vchan_chan_dev(&lchan->vchan), "Number of items not supported=
\n");
>  			kfree(desc);
>  			return ERR_PTR(-EINVAL);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but shouldn't the dmaengine API
functions device_prep_slave_sg() and device_prep_dma_cyclic() return NULL
on failure rather than ERR_PTR()?

In loongson2_cmc_dma_prep_slave_sg(), if loongson2_cmc_dma_set_xfer_param()
fails or the item count is unsupported, it returns ERR_PTR. Since callers
typically check for !desc on failure, returning ERR_PTR means the error
check passes, which could lead to a kernel panic when the invalid pointer
is dereferenced.

Additionally, earlier in the same loop, if set_xfer_param() fails, the
previously allocated desc via kzalloc_flex() appears to be leaked before
returning ERR_PTR(ret).

> @@ -447,7 +442,7 @@ loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *ch=
an, dma_addr_t buf_addr, si
> =20
>  	num_items =3D DIV_ROUND_UP(period_len, buswidth);
>  	if (num_items >=3D LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> -		dev_err(chan2dev(lchan), "Number of items not supported\n");
> +		dev_err(vchan_chan_dev(&lchan->vchan), "Number of items not supported\=
n");
>  		return ERR_PTR(-EINVAL);
>  	}

[Severity: High]
This is also a pre-existing issue, but similar to the above, does this
return value violate the API expectations?

Returning ERR_PTR(-EINVAL) here and when loongson2_cmc_dma_set_xfer_param()
fails will likely bypass caller checks for NULL, potentially leading to a
crash on dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-dma-chan_d=
ev-rename-v3-0-685601b0b788@nxp.com?part=3D3
