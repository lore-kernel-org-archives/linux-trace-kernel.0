Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900060;
	b=noGYdjwMXhNzxczCgC0NXrcK6m+b4WxRrRksUeMW8bm+UHKMM/nxMUg5b3U+Nje4awyD
	 x9nZ6ak86agInn8Hs67CIvoBsT5vzTzBmUFSCYONjehlNSvHCCqDV5V/u0F6P3R438wAj
	 Rd7Wic7h94QPYa10mhAlOR1lPjz+eAbHJ83bk2Ryudh3l+7l2qZZjDNzbS2AXRJ/LItAU
	 Lj4enmAQcJTyn3A2DUWRFeui6JrIuArEAadHlbTYl846A1cvWtAeSO1OOJK0SaVURMfF+
	 HN3XpcfP9WCgMzhdVnXboPDuHLvujecylCqVlyYHW99KDJrSq8mRLf71dp5aw91sbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900060;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LalToQ/4MoXEK4CKhEZChmXdUtY334d+LSVpV7yv7kQ=;
	b=w+ACRVfxg2KMHXZVkbgqoqVM/VQse78hPLL1TjtfP8G/sLYayizKBa7Vbs8druUzJlc8
	 /bhu3zqHN46RQbGHkfVumA8K48VckbrE1pSN2uyXi+rxq/r3ME6J9aJCdYTc0cHpTsWg3
	 Gwra9pw8WYcbmOGokJmpnt00wc5VAB5HUMeUCxIOTDEmqQwihVyZSxe5CFgKsHGRVPLYO
	 yYYnGkYS+i5EOiyUhoPKvgQKdGhzxSuw3sGvvKI6MY5QMvGOXTYJI41HnVsxfBAxlvziB
	 acwSxXho5iCmsef02dJqyV1+o9142x1/4qO+wDVJ6C7C/gQdhxvmEEninvTBpu8uQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkKStxnB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440A606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkKStxnB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AB11F000C1;
	Thu,  5 Nov 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900059;
	bh=LalToQ/4MoXEK4CKhEZChmXdUtY334d+LSVpV7yv7kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IkKStxnB1ulSeIWTX6i9CfZ22sO3cmN73rgYaHneQDkVTKVjsF0XnKS+NegSJs//u
	 q7nyZf3bEljLy6/Ny449kaJ3A4DmHiib95yExMYsTKiVVmD3BydEr+7qU6m5Mhw37m
	 iPRFoK5De/w7GzBJCvYPyqS8i7COuwe0tWQ+7fAlOnc9somT23ld5Pr3KLSCUQW1Wo
	 JAzmSzWp/whQu42Q/9QEMAJKHNuRafIFzhClYKUZMuh74PscGCMbnIY+Pg39co6RRy
	 96m6WXYQTkqcNk5pJ/Kib80xMpSw6fVRshhVVAm8wS39olEkB3SDvhlxWo+LOJOLmj
	 PODnZ+78JX7YA==
Message-ID: <sashiko-outbox-199635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/14] i2c: core: implement i2c_transfer_v2() -
 transfer with detailed reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-7-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-7-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:34:18 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] i2c: core: out-of-bounds msgs[] access when tracing in __i2c_trans=
fer_v2()
- [Medium] i2c: core: unupdated report and skipped tracing in __i2c_transfe=
r_v2()
- [Medium] i2c: core: unreset transfer report on retry in __i2c_transfer_v2=
()
- [Low] i2c: core: wrong function name in kernel-doc comment for i2c_transf=
er()
--

commit d51afdaed0f512f5afd35f1c0e4f6000a4fd5c18
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: core: implement i2c_transfer_v2() - transfer with detailed reporting

This commit introduces i2c_transfer_v2() and __i2c_transfer_v2() to support
detailed transfer reporting via struct i2c_transfer_report and the
algo->xfer_v2() callback, while keeping i2c_transfer() and __i2c_transfer()
as wrappers passing a NULL report pointer.

> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 23ff02a1e532d..e8449f55f0452 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -2288,22 +2288,37 @@ static struct i2c_msg *i2c_check_for_quirks(struc=
t i2c_adapter *adap,
>  }
> =20
>  /**
> - * __i2c_transfer - unlocked flavor of i2c_transfer
> + * __i2c_transfer_v2 - unlocked flavor of i2c_transfer_v2
>   * @adap: Handle to I2C bus
>   * @msgs: One or more messages to execute before STOP is issued to
>   *	terminate the operation; each message begins with a START.
>   * @num: Number of messages to be executed.
> + * @report: The buffer for detailed transfer report (may be NULL).
>   *
>   * Returns negative errno, else the number of messages executed.
> + * Writes the detailed transfer report to the structure pointed by @repo=
rt.
>   *
>   * Adapter lock must be held when calling this function. No debug logging
>   * takes place.
>   */
> -int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int n=
um)
> +int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, in=
t num,
> +		      struct i2c_transfer_report *report)
>  {
>  	unsigned long orig_jiffies;
>  	int ret, try;
> =20
> +	if (report) {
> +		/* Initialize the report structure with -EOPNOTSUPP in all fields.
> +		 * This differentiates from the case when the adapter supports
> +		 * fault reporting and returns -EOPNOTSUPP because it cannot transfer
> +		 * a certain message.
> +		 */
> +		i2c_transfer_report_init(report);
> +
> +		if (!adap->algo->xfer_v2)
> +			return -EOPNOTSUPP;
> +	}

[ ... ]

> @@ -2336,10 +2359,14 @@ int __i2c_transfer(struct i2c_adapter *adap, stru=
ct i2c_msg *msgs, int num)
>  	/* Retry automatically on arbitration loss */
>  	orig_jiffies =3D jiffies;
>  	for (ret =3D 0, try =3D 0; try <=3D adap->retries; try++) {
> -		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic)
> +		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic) {
>  			ret =3D adap->algo->master_xfer_atomic(adap, msgs, num);

[Severity: Medium]
What happens in __i2c_transfer_v2() when i2c_in_atomic_xfer_mode() is true
on an adapter that provides both xfer_v2 and master_xfer_atomic, and the
caller passes a non-NULL report pointer?

At the start of __i2c_transfer_v2(), i2c_transfer_report_init(report) sets
report->msgs_cplt, report->fault_msg_idx, and report->bytes_cplt to
-EOPNOTSUPP. The transfer loop then invokes adap->algo->master_xfer_atomic(=
),
which does not take a report pointer. Even when master_xfer_atomic() succee=
ds
and returns num, report is never updated with i2c_transfer_report_success(),
so all fields of report remain -EOPNOTSUPP in violation of the struct
i2c_transfer_report contract.

Because report->msgs_cplt stays -EOPNOTSUPP, the tracepoint loop below also
sets n =3D report->msgs_cplt and skips trace_i2c_reply() for all completed
I2C_M_RD messages. Should __i2c_transfer_v2() update report (or reject
atomic transfers when report is non-NULL)?

> -		else
> -			ret =3D adap->algo->master_xfer(adap, msgs, num);
> +		} else {
> +			if (report)
> +				ret =3D adap->algo->xfer_v2(adap, msgs, num, report);
> +			else
> +				ret =3D adap->algo->master_xfer(adap, msgs, num);
> +		}
> =20
>  		if (ret !=3D -EAGAIN)
>  			break;

[Severity: Medium]
If adap->algo->xfer_v2() partially populates report on try =3D=3D 0 and ret=
urns
-EAGAIN on arbitration loss, doesn't the next iteration of the retry loop in
__i2c_transfer_v2() pass that dirty report structure into xfer_v2() without
re-initializing it via i2c_transfer_report_init(report)?

If a subsequent attempt fails before overwriting all fields of report, or if
the bus driver expects report->msgs_cplt to be initialized to -EOPNOTSUPP on
entry to xfer_v2() (such as i2c_dw_fault_report() checking report->msgs_cpl=
t < 0
and accumulating msgs_in_prev_parts), stale values from the earlier attempt
will corrupt the final report.

Also, in i2c_transfer_v2(), if __i2c_lock_bus_helper(adap) returns -EAGAIN
before __i2c_transfer_v2() is called, i2c_transfer_report_init(report) is
not called at all, leaving the caller's report structure uninitialized.
Should i2c_transfer_report_init(report) be called on entry to
i2c_transfer_v2() and before each retry in __i2c_transfer_v2()?

>  		if (time_after(jiffies, orig_jiffies + adap->timeout))
>  			break;
>  	}
> =20
>  	if (static_branch_unlikely(&i2c_trace_msg_key)) {
> -		int i;
> -		for (i =3D 0; i < ret; i++)
> +		int i, n;
> +
> +		if (report)
> +			n =3D report->msgs_cplt;
> +		else
> +			n =3D ret;
> +		for (i =3D 0; i < n; i++)
>  			if (msgs[i].flags & I2C_M_RD)
>  				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
> +		if (report && report->bytes_cplt > 0 && msgs[n].flags & I2C_M_RD)
> +			trace_i2c_reply(adap, &msgs[n], report->bytes_cplt, n);

[Severity: High]
Can this index msgs[n] out of bounds when i2c_trace_msg_key is enabled in
__i2c_transfer_v2()?

Here n is set to report->msgs_cplt, and if report->bytes_cplt > 0, the code
evaluates msgs[n].flags and calls trace_i2c_reply(adap, &msgs[n],
report->bytes_cplt, n) without checking that n >=3D 0 and n < num (or that =
n <=3D
num for the loop and report->bytes_cplt <=3D msgs[n].len).

By definition in struct i2c_transfer_report, report->msgs_cplt can be a
negative error code (when the driver cannot determine the number of
completed messages) or equal to num (or even >=3D num if a multi-part trans=
fer
accumulates msgs_in_prev_parts across retries). If report->bytes_cplt > 0 at
the same time, indexing msgs[n] reads out of bounds on the msgs[] array and
trace_i2c_reply() can copy from an out-of-bounds msgs[n].buf pointer.

>  		trace_i2c_result(adap, num, ret);
>  	}
> =20
>  	return ret;
>  }

[ ... ]

> +/**
> + * i2c_transfer_v2 - execute a single or combined I2C message
> + * @adap: Handle to I2C bus
> + * @msgs: One or more messages to execute before STOP is issued to
> + *	terminate the operation; each message begins with a START.
> + * @num: Number of messages to be executed.
> + *
> + * Returns negative errno, else the number of messages executed.
> + *
> + * Note that there is no requirement that each message be sent to
> + * the same slave address, although that is the most common model.
> + */
> +int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)

[Severity: Low]
Should the kernel-doc function name above i2c_transfer() be i2c_transfer
instead of i2c_transfer_v2? Having i2c_transfer_v2 here causes a kernel-doc
prototype mismatch warning when building with W=3D1 or building documentati=
on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D7
