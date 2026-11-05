Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902425;
	b=ZGXTETP56PtAnApR7ldxuAT4EwDidNYSbTUVMJp+rXBmxGv/R3xEntTFPKaXNqXSIeE9
	 qqBKRMjPGK6mNxBzXYEW5HwsetEMxVprhXGBkb8hxPBvJOlduU/ittVIoUaIDbxE/D98E
	 /lvNkawE4fmmB9t0YmWZiIBpbfRX3rfYuV5EWnadG0+OF0FdBp6B6XOIS4g02jaVSqJ1b
	 ifWDtW1qwen75GqysTEi5hmQnoxI3PfWUWvdil1KqRMzR10EanBjcfnSxLXqWpsRbiwZe
	 j33IIqHTzahxnwhfXqoEx2kqQH75z4PGd2UTY1YpR0kv7oC5mUTp8OKExqsE9pvmPhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lrq8bWdQ+pA0IAPhEEj6+OyvmLelx5wL0GbYXTShkaI=;
	b=KzfL8WcAWRuqTKlqpE54Jd2A5jh52yiit9mK22/jP/04udgJGsM+ZqLuiMBqKne1Yd3F
	 4fQW996nLidheuRpOK1emKwzwHa7np8Sxz9O/b+an/k0WCSfqwOJ7jAwdeYumOKlD5/BN
	 8GnbiAAWP0O3Oq7Q23LRFWPCcHkC0dsznf8ytz3oh8cprdzXzZm6e3+MONCR5Tmt3/IXo
	 GEjxMu/JdaoszyFPy2C41znVVveLWySf0+DzAdiJIkWRs5Skvq3VI02OWfBMqB0PoUz2i
	 oErqxWqhoVYOh2zZtAyZ4pgho/gCzASSTjGv0ceklGZjrNwlQNklm3UIGn2WMGLlDNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at++mf3k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E172606A329
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at++mf3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A361F000C1;
	Thu,  5 Nov 2026 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902425;
	bh=lrq8bWdQ+pA0IAPhEEj6+OyvmLelx5wL0GbYXTShkaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=at++mf3kELnTGeUYn7KiO7VhHSMkEljxZl7n1LAzTjgUeXpvhEvDI41hU/DXzGW/l
	 J5MAaSgRTNqtykxKVEEEqVI3MyuKmhCGxaFPS2XdASHYRKdR+uYDkqi6nRiwp9Uzc0
	 XPYdWU2yhEt/uMxiPXRBId1pTRF/IlK9CNpQvfqCNbsP4ybE/chV8HzsxF8+jC3+NI
	 FEOEtKWvoC5UINUnGb9s/M03/XzD8zbBCMjzXWr5XOl13szN3L0ELQSXsfz2X3kFya
	 V52FpI41WgFq7AL4HqaiisUfkgX/pr4ir6gGnvTsYA2Q3pG2esbN/Z2G1XuXqv2i3g
	 t488rB5TE84LA==
Message-ID: <sashiko-outbox-199706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 12/14] i2c: nomadik: add support for I2C_XFER_V2
 - detailed fault reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-12-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-12-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:13:44 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] i2c: nomadik: unpopulated transfer report on pm_runtime_get_sync=
() early exit
--

commit 22d1a25cd553d39ed6c3ad6c9998ec471c05f948
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: nomadik: add support for I2C_XFER_V2 - detailed fault reporting

This commit converts the i2c-nomadik driver to the xfer_v2 callback so it c=
an
populate struct i2c_transfer_report with the number of completed messages,
completed bytes, and the faulting message index when a transfer fails.

> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 958adc51615e4..a8ccd863a6edf 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c

[ ... ]

> @@ -739,8 +755,9 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv,=
 u16 flags)
>   * please use the i2c_smbus_read_i2c_block_data()
>   * or i2c_smbus_write_i2c_block_data() API
>   */
> -static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
> -		struct i2c_msg msgs[], int num_msgs)
> +static int nmk_i2c_xfer_v2(struct i2c_adapter *i2c_adap,
> +		struct i2c_msg msgs[], int num_msgs,
> +		struct i2c_transfer_report *report)
>  {
>  	int status =3D 0;
>  	int i;
> @@ -750,6 +767,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	if (i)
>  		return i;
> =20
> +	priv->bytes_cplt =3D 0;
> +
>  	/* setup the i2c controller */
>  	setup_i2c_controller(priv);
> =20
> @@ -768,10 +787,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_ada=
p,
>  	pm_runtime_put_sync(&priv->adev->dev);
> =20
>  	/* return the no. messages processed */
> -	if (status)
> +	if (status) {
> +		report->msgs_cplt =3D i;
> +		report->bytes_cplt =3D priv->bytes_cplt;
> +		report->fault_msg_idx =3D i;
>  		return status;
> -	else
> +	} else {
> +		i2c_transfer_report_success(report, num_msgs);
>  		return num_msgs;
> +	}
>  }

[Severity: Medium]
What happens to the transfer report in drivers/i2c/busses/i2c-nomadik.c when
nmk_i2c_xfer_v2() takes the early return on pm_runtime_get_sync()?

Before invoking adap->algo->xfer_v2(), __i2c_transfer_v2() in
drivers/i2c/i2c-core-base.c initializes all fields of struct
i2c_transfer_report to -EOPNOTSUPP via i2c_transfer_report_init(report):

drivers/i2c/i2c-core-base.c:__i2c_transfer_v2() {
	...
	if (adap->algo->xfer_v2) {
		i2c_transfer_report_init(report);
		...
		ret =3D adap->algo->xfer_v2(adap, msgs, num, report);
	...
}

In nmk_i2c_xfer_v2(), if pm_runtime_get_sync(&priv->adev->dev) returns a
non-zero value, the function returns immediately before reaching the block =
at
the end of nmk_i2c_xfer_v2() that populates report:

	i =3D pm_runtime_get_sync(&priv->adev->dev);
	if (i)
		return i;

If pm_runtime_get_sync() fails with a negative error code, 0 messages and 0
bytes have been transferred before failing on message 0, but report->msgs_c=
plt,
report->bytes_cplt, and report->fault_msg_idx remain -EOPNOTSUPP instead of=
 0,
telling callers of i2c_transfer_v2() and the I2C_RDWR_V2 ioctl that the
controller does not support fault reporting.

In addition, if pm_runtime_get_sync() returns 1 because the device was alre=
ady
active, nmk_i2c_xfer_v2() returns 1 while leaving all fields of report set =
to
-EOPNOTSUPP, resulting in a positive return value paired with a negative
report->msgs_cplt.

Should nmk_i2c_xfer_v2() populate report (or use pm_runtime_resume_and_get()
and set msgs_cplt, bytes_cplt, and fault_msg_idx to 0 on error) before
returning when runtime resume fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D12
