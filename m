Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DA396588
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415172; cv=none; b=uOR2XozS52LXZhW2Zl6k5opUsW019RvQA63dmUVu9GCvGdioMHTZy2sAutKCqBEyVS62B8w7H7ghvxCgYU7aBO8UAALAKUs2XmjtwgBvi6A0rCimTCauxVPpkC3mO7Mog42ifoePVAFlsRzZ1Oz0O6ascIH0hrMLjZ3LMuP2SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415172; c=relaxed/simple;
	bh=Phcia0okgnDAZI/BivUc3xYNHf06Yl8aViGTe//pk58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lV/hS/tQIC3s+XEWAIxvS9p0vUBiWVReOMYAx9xSjmQrT6910Iv2VtWsBK3RZxoNvFC9rzuY0EGJ3h1hyokymsqSgODQzmWSXWDv1hNXQvCdDf4nke4lLvbmBdpA4vAs0iUvgo2Van48uA40XcoWlIE5pyBgnrAFiViYf68rMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJfhH61+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJfhH61+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E572F1F000E9;
	Thu,  3 Sep 2026 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788415165;
	bh=65Qs27ngX+m5A9hYT9Ufye9rpkZFU8aHHHATiNv5H0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJfhH61+eLTJDDcCP+rqAeUj4k5QqyEbDSzCdZx6S1j5w7L/jl/r17HyamyrA3dM+
	 iKtPHEvdj1T4C7EQQr2XuIy93Fy6A7XXjCdBD7fsWjTpc3ElHXruzTXlnHRJgvFQ3B
	 tX/UA6sSM/7uEK4kL+001qBbJHbrnLR1DI2DSn8GGDZ+kPVHP4Emb/DTY9gCWjaOW3
	 8c3UnzYJmHOAyhRDf/gfjOfmTEdTdlG6xHFFH5ZYaXfIpnwHX+U6Cpvdjqya0/6edg
	 IujdUhmeNXyq6aoiHIeKG8dNBkgvvCgvdJsiiHZ5VJ9L+djR7Gye6Dc4NZ9dE0DCmk
	 +7eysuDdQdZlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] i2c: designware: add support for I2C_XFER_V2 -
 detailed fault reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-12-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-12-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:59:24 +0000
Message-Id: <20260903055924.E572F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized stack variable `stat` is evaluated if `regmap_read=
` fails.
- [Medium] i2c_dw_fault_report incorrectly reports transmission progress on=
 non-abort errors, and unconditional addition corrupts potential error retu=
rns.
--

commit ace9d554c2f401ddd92040765e5f36fab0bfd74c
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: i2c: designware: add support for I2C_XFER_V2 - detailed fault repo=
rting

This commit introduces support for I2C_XFER_V2 in the i2c-designware driver.
It enables clients to get detailed reports on transmission failures by
detecting the number of un-sent bytes via the FLUSH_CNT field and checking
abort flags after FIFO reads and writes.

> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/bus=
ses/i2c-designware-master.c
> index f029aa1eadbf8..bc23c3fdaaf2e 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c

[ ... ]

> @@ -33,6 +34,16 @@
>  #define AMD_TIMEOUT_MAX_US	250
>  #define AMD_MASTERCFG_MASK	GENMASK(15, 0)
> =20
> +static int i2c_dw_fault_report(struct dw_i2c_dev *dev, struct i2c_transf=
er_report *report);
> +
> +static inline bool i2c_dw_check_abort_flag(struct dw_i2c_dev *dev)
> +{
> +	u32 stat;
> +
> +	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
> +	return (!!(stat & DW_IC_INTR_TX_ABRT));
> +}

[Severity: Medium]
If regmap_read() fails (for example, due to a bus error or PM state),
could this result in evaluating an uninitialized stack variable?

If stat contains a garbage value, this might spuriously detect a TX abort,
prematurely breaking the FIFO read/write loops and causing non-deterministic
transfer behavior.

[ ... ]

> @@ -918,16 +980,83 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i=
2c_msg msgs[], int num)
> =20
>  	i2c_dw_release_lock(dev);
> =20
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (report) {
> +			i2c_dw_fault_report(dev, report);
> +			report->msgs_cplt +=3D msgs_in_prev_parts;
> +			report->fault_msg_idx +=3D msgs_in_prev_parts;
> +		}
>  		return ret;
> +	}

[Severity: Medium]
Will this unconditional addition corrupt a negative error code if
i2c_dw_fault_report() sets report->msgs_cplt to a negative value to indicate
an indeterminate state?

[ ... ]

> +static int i2c_dw_fault_report(struct dw_i2c_dev *dev, struct i2c_transf=
er_report *report)
> +{
> +	int idx;
> +	int n_flushed =3D FIELD_GET(DW_IC_TX_ABRT_SOURCE_FLUSH_CNT_MASK, dev->a=
bort_source);

[Severity: Medium]
Does this code correctly handle non-abort errors like timeouts?

If a timeout occurs and dev->abort_source is 0, n_flushed will be 0. Could
this cause bytes stuck in the FIFO to be incorrectly reported as successful=
ly
sent on the wire?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D12
