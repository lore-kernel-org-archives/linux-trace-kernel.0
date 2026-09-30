Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746F4F5E1F;
	Wed, 30 Sep 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780894; cv=none; b=hodBi93pq5DSjeYbxNNa35QGxSA7PTYFO+kC0T1JQv7fKBsaTOVx+nzX1avZn1DUyfXgoZfp0VGKqS/oeLWESdvxZ5Euvb3yRUqigxZfoiuolBM19fZuCow4QGX8W8FT/M/nusihp0hBfB5/nhsh1bUGMTkxkJcff0vllq9WVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780894; c=relaxed/simple;
	bh=7Ok+wG+ensSUfdXWBvZqOc4+NLUx/sxT9wjI74VFfLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D96gsMWfNdH2+jaqYQ4ojRAL7RXjY+Xtgy+rGZxiNpPkFZPwD/0MmFSMlhfQLnkf0jpcKWGAuVHSvkT0ChN+Zk7vOBzxgmtjJH8i9DVDq80Y+JnVJnkqn0y/8KxisYLMyWzsSE/UyuOS5UKrtRehww/HTIe9+ApP9xLj4qjPEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czyFghHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czyFghHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAB31F00893;
	Wed, 30 Sep 2026 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780884;
	bh=Fz3YX5ISWP5tgcsYgn36flljdXIPUJH6DcWDlRvsdts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czyFghHqgBDX4U7gYJDZX7vuLodZH5EmkhgV+isDxZkz5YB06Ins/7jBmiSSdZhKL
	 /fN5tZ7VAt8TmzX36e6Y265xBjiIzxHp68OU+IsKEmDyg0LNk+tfJQn6I+5s6a/Mln
	 jga5ahylgFcr1bU07asL+fUrAzBhUWSrBjcjuFH4Be0op6qu5OrWEPgtk+l5rS/JCU
	 29gxyZTjQVMooiL/jKCyu5AODqo0ODtFypNNO1UkaadDiGiczTq7ELNqYl7wmJHkqm
	 no7WKuWU6J4IjFMygjAyfdIwasD75/l2YqS7EZoqfnkqV0FA5UzjBoBdg2Jv4EhEfp
	 X+J9OPFdliy3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] soc: qcom: qpace: Add LLCC slice support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>
Cc: robh@kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930145215.3380977-6-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-6-georgi.djakov@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:08:03 +0000
Message-Id: <20260930150804.7BAB31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] qcom/qpace: unconditional probe failure if LLCC is disabled or abs=
ent
- [Medium] qcom/qpace: double deactivation of LLCC slices on failed resume
- [Low] qcom/qpace: missing Kconfig dependency causes linker error when LLC=
C=3Dm
--

commit 91b78e77e6f189e8963165dc5c4bd1f6ed1995ec
Author: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

soc: qcom: qpace: Add LLCC slice support

This commit adds support for QPaCE to use dedicated LLCC slices for compres=
sion
and decompression. It updates the driver to request and activate the LLCC s=
lices
during probe and resume, and deactivate them during suspend and remove.

> diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
> index f5b21ffbcbff5..86a935ae2ca93 100644
> --- a/drivers/soc/qcom/qpace.c
> +++ b/drivers/soc/qcom/qpace.c
[ ... ]
> @@ -660,9 +663,35 @@ static int qpace_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to map QPaCE registers\n");
> =20
> +	priv->llc_comp =3D llcc_slice_getd(LLCC_QPACE_COMPRESSION);
> +	if (IS_ERR(priv->llc_comp))
> +		return dev_err_probe(dev, PTR_ERR(priv->llc_comp),
> +				     "failed to get compression LLCC slice\n");

[Severity: High]
Does this unconditionally fail the probe if LLCC is disabled or missing from
the device tree? If CONFIG_QCOM_LLCC=3Dn, llcc_slice_getd() returns NULL (w=
hich
passes the IS_ERR check). Then the subsequent llcc_slice_activate(NULL)
invokes a macro stub returning -EINVAL, unconditionally failing the probe.

Additionally, if the QPaCE slice is absent from the device tree, it returns
an error pointer, which also aborts probe. Should this be treated as an
optional optimization rather than a hard requirement?

[Severity: Low]
Can this cause a linker error if CONFIG_QCOM_PAGE_COMPRESSION_ENGINE=3Dy but
CONFIG_QCOM_LLCC=3Dm? In this configuration, the built-in QPaCE driver cann=
ot
link against the exported symbols of the LLCC module, but
IS_ENABLED(CONFIG_QCOM_LLCC) evaluates to true, so it attempts to use the
header declarations rather than inline stubs. Is there a missing Kconfig
dependency?

> +
> +	priv->llc_decomp =3D llcc_slice_getd(LLCC_QPACE_DECOMPRESSION);
> +	if (IS_ERR(priv->llc_decomp)) {
> +		ret =3D dev_err_probe(dev, PTR_ERR(priv->llc_decomp),
> +				    "failed to get decompression LLCC slice\n");
> +		priv->llc_decomp =3D NULL;
> +		goto llc_put_comp;
> +	}
> +
> +	ret =3D llcc_slice_activate(priv->llc_comp);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to activate compression LLCC slice\n");
> +		goto llc_put_decomp;
> +	}
[ ... ]
> @@ -708,6 +745,10 @@ static void qpace_remove(struct platform_device *pde=
v)
>  	/* No callers remain; tear down the hardware. */
>  	cancel_work_sync(&qpace_priv->disable_work);
>  	qpace_power_off(&pdev->dev);
> +	llcc_slice_deactivate(qpace_priv->llc_decomp);
> +	llcc_slice_deactivate(qpace_priv->llc_comp);

[Severity: Medium]
Can this cause a double-deactivation if a previous qpace_resume() failed? If
an error occurs during qpace_resume() (e.g., if icc_set_bw() fails), the
driver leaves the slices deactivated and returns early.

If the device is subsequently unbound, qpace_remove() unconditionally calls
llcc_slice_deactivate() on both slices. Since their refcounts would already
be 0, wouldn't this underflow the refcount, triggering a
WARN_ON_ONCE(!refcount_dec_if_one(...)) in the LLCC core and sending an
erroneous deactivate command to the hardware?

> +	llcc_slice_putd(qpace_priv->llc_decomp);
> +	llcc_slice_putd(qpace_priv->llc_comp);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145215.3380=
977-1-georgi.djakov@oss.qualcomm.com?part=3D5
