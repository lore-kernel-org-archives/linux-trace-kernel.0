Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C24E0B70;
	Wed, 30 Sep 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780921; cv=none; b=tXqwjDrGgG6JYIxbLkxL6AINofCqVOHsRm0uXMKtRWu+mq2OYBXuzWVVIRflWLVhKg5kLbwuadM/AdRmGDMLoAOoYDaOLnpR8V34qwCwuJsCdbV1lNKWMYlgCEC1q2fMC5xLFncjwVgpxHBkiuLewuLAqMHzrBSzMEry6E4ESbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780921; c=relaxed/simple;
	bh=5mOG2J4Ub494gp8FewOph2+u22JzvRzIn8IysCJ5HoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ds8JisyLolvJqMcoa994O1dtQ8iRqiuz6notEWvspQQU4/KfCjjNF4M2ELctTwmTqg3rXITpxr4Vbshgic3B1fNDyaa98lkluNpFvv/22ZnObA/aKDTToMs4YLNxAaOsltrNwqPCytBPadRseRfGXMewLhX2LDpy4XBS5Y/O0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7mDBw7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7mDBw7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE281F000FF;
	Wed, 30 Sep 2026 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780910;
	bh=frduz8rZcAKxNdH1bWgnIfr23mW/Ot9kPtUmM5okev4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7mDBw7tY80KHgLM/K6kLyF9tw33iLx9xm2CIzXKhTnty3iHT75J7Wt0FvJbPSY/A
	 65CpIlWd/d/nLicONYaDJnTwEvUabhBxMbVTyPta1kLyTnjUrFISXXheFm31PPjisf
	 OreB12LQviKa84wnVhjAyn2+cq+xj3xurTQqqfT74H5iwoA/Upa0eiPpHBBXNHEIrg
	 BonzV9kw2qLFV1QsBaF0uu2AKctnqcEWaUr88W7WIKr/Hj3pr5vXsJ8TCD2oMdnsrN
	 1GCTT69CWX04/towQ67VFj+dsLIVgL9LsxlAniH16CLMsXMVbpxXnm15YDhkHuCfRq
	 2XOTqzufk69/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>
Cc: linux-trace-kernel@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:08:30 +0000
Message-Id: <20260930150830.9CE281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] block: zram: signed/unsigned promotion masks hardware errors in qp=
ace_compress
- [High] block: zram: missing qpace availability check causes NULL pointer =
dereference
- [High] block: zram: unbinding qpace driver causes Use-After-Free in backe=
nd
- [Medium] block: zram: qpace backend uses bounce buffers instead of claime=
d zero-copy DMA mapping
--

commit e4fba83b2c0230490d177ce709e7ea22807d84d4
Author: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

zram: Add QPaCE zcomp backend

Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
zram can expose qpace-lz4 as a selectable compression algorithm when the
QPaCE driver is available.

> Compress and decompress operations are handled via the QPaCE urgent
> synchronous path: each request DMA-maps the source and destination
> buffers, issues a blocking hardware command, and returns the result size.

[Severity: Medium]
Does the implementation contradict the commit message's claim about DMA
mapping the request buffers? The code allocates static bounce buffers and
performs synchronous memory copies instead of mapping the actual request
memory directly.

> diff --git a/drivers/block/zram/backend_qpace.c b/drivers/block/zram/back=
end_qpace.c
> new file mode 100644
> index 0000000000000..3af13727adefc
> --- /dev/null
> +++ b/drivers/block/zram/backend_qpace.c
[ ... ]
> +static int qpace_create_ctx(struct zcomp_params *params, struct zcomp_ct=
x *ctx)
> +{
> +	struct device *dev =3D qpace_get_dma_dev();

[Severity: High]
Is it safe to unconditionally call qpace_get_dma_dev() here without
verifying if the hardware actually probed via qpace_is_dev_available()?

If the QPaCE driver hasn't probed successfully or is missing, the global
qpace_priv pointer remains NULL, and qpace_get_dma_dev() dereferences it:

drivers/soc/qcom/qpace.c:qpace_get_dma_dev() {
    return qpace_priv->dev;
}

Could this cause a kernel panic if a user writes 'qpace-lz4' to
/sys/block/zram0/comp_algorithm on an unsupported system?

[Severity: High]
Additionally, does this cache the device pointer without acquiring a robust
reference via get_device() or taking a module reference?

If the QPaCE driver is unbound via sysfs, qpace_priv is destroyed.
Subsequent compress operations or teardown might access the freed device
pointer or qpace_priv structure, leading to a use-after-free.

> +	struct qpace_ctx *cc;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	cc =3D kzalloc_obj(*cc, GFP_KERNEL);
> +	if (!cc)
> +		return -ENOMEM;
> +
> +	cc->dev =3D dev;
> +	cc->in_buf =3D dma_alloc_coherent(dev, PAGE_SIZE, &cc->in_dma, GFP_KERN=
EL);

[Severity: Medium]
This statically allocates a bounce buffer rather than preparing to map the
dynamic request buffers. Does this introduce CPU overhead by breaking the
zero-copy DMA design claimed in the commit message?

[ ... ]
> +static void qpace_destroy_ctx(struct zcomp_ctx *ctx)
> +{
> +	struct qpace_ctx *cc =3D ctx->context;
> +
> +	if (!cc)
> +		return;
> +
> +	dma_free_coherent(cc->dev, PAGE_SIZE, cc->out_buf, cc->out_dma);

[Severity: High]
If the device was unbound and qpace_priv was freed, could accessing cc->dev
here trigger a use-after-free during cleanup?

[ ... ]
> +static int qpace_compress(struct zcomp_params *params, struct zcomp_ctx =
*ctx,
> +			  struct zcomp_req *req)
> +{
> +	struct qpace_algorithm *algo =3D params->drv_data;
> +	struct qpace_ctx *cc =3D ctx->context;
> +	int ret;
> +
> +	memcpy(cc->in_buf, req->src, req->src_len);

[Severity: Medium]
Does copying data to the bounce buffer here confirm the data path is not
zero-copy?

> +
> +	ret =3D qpace_urgent_compress(cc->in_dma, cc->out_dma, algo);
> +
> +	if (ret =3D=3D -E2BIG || ret >=3D PAGE_SIZE) {

[Severity: High]
Are hardware errors from the QPaCE compressor masked here?

If qpace_urgent_compress() returns a negative error code (e.g., -EINVAL),
comparing the signed integer 'ret' to PAGE_SIZE (typically unsigned long)
promotes 'ret' to a large unsigned value.

Would this cause the check to incorrectly pass, silently treating broken or
failed compressions as incompressible data instead of propagating the failu=
re?

> +		req->dst_len =3D PAGE_SIZE;
> +		return 0;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145215.3380=
977-1-georgi.djakov@oss.qualcomm.com?part=3D4
