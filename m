Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901094;
	b=zdb3jv0dxsqXJvY6vWjNgnM8xo9jWlCcMn784yUgKuzfVhgZfCiojv+JiRcx2dg9IOUR
	 UVhkgacNhQ79tfkeh3ZRakntvQq7ukxnygqu3zZAryFjMv9toGHEjIznLH84DrLOVWieV
	 HW4cJW8B4ad1pHhmqghwUkiLXKlSVJ8Tp5a/N1RIBl1wRGadBBe8TmzK9zz5yieNBO7XR
	 ZbfLShoE3dJndnoCJXFPqSGmi03kfLPkEs6iMGLKK3Mgj8houO9q/2Oi+mikA7eVAg3kP
	 GI8bv20ZfM5a56AmAbn8jjNbA4TznG+tkmgJyO13ffdKkADS5p6gxmNJ8ixSI46OmnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901094;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pAxncouh8lnngfzBRr4sxJncVGwAemX1VzDTMYbEeY4=;
	b=PaApnW/a1kbSnCGEMEuaJJ6BbFclcgiGFXzhVikc0BQ73UE8S70Dz3PYshriURcSY/fN
	 iZUJSYCcfXh9OcV2KgNPcbyeSWXx8a4l2bfox/XZZ4leGE+G9LN06KfbL5egXfP5zq+MV
	 a/1cqhXCSQ1Cm3sUA/k0MtTqc1YSUHZ62GtXeSLUK6FPpD5BoEfyoC/PGpJ/UEJ5vrJfv
	 RpOHZY4rvB/Xz1nXkLPN/tPIj7w9nn0uwNUHWwitvCzESVWNiMS9l2R3IXKzPShxXPnqk
	 9+YWkYWU5MmH8eCVwv/yahHkOaRLh8Qsxm6L9i0wl6EMfReOXW8c1JeK6C6QgOfiXFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S47hwplp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F1606A33F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S47hwplp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA95A1F000C1;
	Thu,  5 Nov 2026 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901094;
	bh=pAxncouh8lnngfzBRr4sxJncVGwAemX1VzDTMYbEeY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S47hwplpPTvKevNiMW/K2kraPuS6TcTYuiSn/5XOxSiscucLpH1Wwsalb2NdJ3olW
	 W47KGkw70JSrMomYdhd8zF91AS4ZKV4IVOHCdJfs9vBV1ploYbUxrxLdNsPbakVxZy
	 mhtX2a/f52e6TBlL+8sIkI83GtXYIEI7ff5YgnoEYtIE4fTIdAVGXAXXj88TghV1y+
	 4HkKJXf0Ax/GNllyY2ASLmcRwvSCCtyupbZGOe5o6Fc0a5523PSU2aS5taBxX5/rvS
	 FSfG34KLyJ4h6El728rq66Rw3zdEFG7NdGXJ469UgMwD0rLrLWHTC9SQzDKYUhFB2Z
	 Ko/SOyfW4Uo0w==
Message-ID: <sashiko-outbox-199664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/14] i2c: core: implement I2C_RDWR_V2 ioctl -
 transfer with detailed report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-9-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-9-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:51:33 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] i2c: dev: missing bytes_cplt bounds check in i2cdev_ioctl_rdwr_v2()
- [High] i2c: missing report reset and bounds checks in __i2c_transfer_v2()
- [Medium] i2c: dev: I2C_RDWR_V2 with NULL msgs and non-zero nmsgs returns =
0 in i2cdev_ioctl()
- [Medium] i2c: dev: missing algo->xfer_v2 check in i2cdev_ioctl_rdwr_v2()
- [Low] i2c: dev: leftover fixme, sign-compare, and logging in i2cdev_ioctl=
_rdwr_v2()
--

commit 7d55aa9159adadd2b0feb48eabc72a0f050719a1
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: core: implement I2C_RDWR_V2 ioctl - transfer with detailed report

This commit adds the I2C_RDWR_V2 ioctl (and its compat counterpart) to
i2c-dev so userspace can receive an i2c_transfer_report describing completed
messages, bytes transferred, and the faulting message index when a transfer
fails.

> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index d219eb89f978b..14fe1dd7eecf4 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -240,11 +240,19 @@ static int i2cdev_check_addr(struct i2c_adapter *ad=
apter, unsigned int addr)
>  	return result;
>  }
> =20
> -static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
> -		unsigned nmsgs, struct i2c_msg *msgs)
> +static noinline int i2cdev_ioctl_rdwr_v2(struct i2c_client *client,
> +					 unsigned int nmsgs, struct i2c_msg *msgs,
> +					 struct i2c_transfer_report __user *user_report)
>  {
> +	struct i2c_transfer_report report;
>  	u8 __user **data_ptrs;
> -	int i, res;
> +	int i, res, msgs_done;
> +
> +	i2c_transfer_report_init(&report);
> +
> +	if (user_report)
> +		if (copy_to_user(user_report, &report, sizeof(report)))
> +			return -EFAULT;
> =20
>  	/* Adapter must support I2C transfers */
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -EOPNOTSUPP;

[Severity: Medium]
When user_report is non-NULL (for I2C_RDWR_V2 with nmsgs > 0), should
i2cdev_ioctl_rdwr_v2() also verify client->adapter->algo->xfer_v2 before
allocating and validating the messages?

In drivers/i2c/i2c-core-base.c, __i2c_transfer_v2() initializes the report
fields to -EOPNOTSUPP and immediately returns -EOPNOTSUPP when
adap->algo->xfer_v2 is NULL:

drivers/i2c/i2c-core-base.c:__i2c_transfer_v2() {
	if (report) {
		i2c_transfer_report_init(report);

		if (!adap->algo->xfer_v2)
			return -EOPNOTSUPP;
	}
}

Because i2cdev_ioctl_rdwr_v2() only checks algo->xfer_v2 later via
i2c_transfer_v2(), calling I2C_RDWR_V2 on an adapter without xfer_v2 with a
message that fails validation (such as msgs[i].len > 8192, a memdup_user()
failure, or an invalid I2C_M_RECV_LEN buffer) will overwrite report via
i2c_transfer_report_bad_msg(&report, i) and copy that to user_report instead
of leaving the report fields set to -EOPNOTSUPP and returning -EOPNOTSUPP.
Even when all messages are valid, it allocates data_ptrs and duplicates eve=
ry
message buffer with memdup_user() before __i2c_transfer_v2() rejects the
transfer.

> @@ -259,6 +267,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_clie=
nt *client,
>  		/* Limit the size of the message to a sane amount */
>  		if (msgs[i].len > 8192) {
>  			res =3D -EINVAL;
> +			i2c_transfer_report_bad_msg(&report, i);
>  			break;
>  		}
> =20
> @@ -266,6 +275,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_clie=
nt *client,
>  		msgs[i].buf =3D memdup_user(data_ptrs[i], msgs[i].len);
>  		if (IS_ERR(msgs[i].buf)) {
>  			res =3D PTR_ERR(msgs[i].buf);
> +			i2c_transfer_report_bad_msg(&report, i);
>  			break;
>  		}
>  		/* memdup_user allocates with GFP_KERNEL, so DMA is ok */
> @@ -287,6 +297,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_clie=
nt *client,
>  			    msgs[i].len < 1 || msgs[i].buf[0] < 1 ||
>  			    msgs[i].len < msgs[i].buf[0] +
>  					     I2C_SMBUS_BLOCK_MAX) {
> +				i2c_transfer_report_bad_msg(&report, i);
>  				i++;
>  				res =3D -EINVAL;
>  				break;
> @@ -300,12 +311,44 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_cl=
ient *client,
>  		for (j =3D 0; j < i; ++j)
>  			kfree(msgs[j].buf);
>  		kfree(data_ptrs);
> +		if (user_report && copy_to_user(user_report, &report, sizeof(report)))
> +			res =3D -EFAULT;
>  		return res;
>  	}
> =20
> -	res =3D i2c_transfer(client->adapter, msgs, nmsgs);
> +	if (user_report) {
> +		res =3D i2c_transfer_v2(client->adapter, msgs, nmsgs, &report);
> +		msgs_done =3D report.msgs_cplt;

[Severity: High]
Passing a non-NULL &report into i2c_transfer_v2() -> __i2c_transfer_v2()
activates the report paths in drivers/i2c/i2c-core-base.c:

drivers/i2c/i2c-core-base.c:__i2c_transfer_v2() {
	...
	/* Retry automatically on arbitration loss */
	orig_jiffies =3D jiffies;
	for (ret =3D 0, try =3D 0; try <=3D adap->retries; try++) {
		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic) {
			ret =3D adap->algo->master_xfer_atomic(adap, msgs, num);
		} else {
			if (report)
				ret =3D adap->algo->xfer_v2(adap, msgs, num, report);
			else
				ret =3D adap->algo->master_xfer(adap, msgs, num);
		}

		if (ret !=3D -EAGAIN)
			break;
		if (time_after(jiffies, orig_jiffies + adap->timeout))
			break;
	}

	if (static_branch_unlikely(&i2c_trace_msg_key)) {
		int i, n;

		if (report)
			n =3D report->msgs_cplt;
		else
			n =3D ret;
		for (i =3D 0; i < n; i++)
			if (msgs[i].flags & I2C_M_RD)
				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
		if (report && report->bytes_cplt > 0 && msgs[n].flags & I2C_M_RD)
			trace_i2c_reply(adap, &msgs[n], report->bytes_cplt, n);
		trace_i2c_result(adap, num, ret);
	}
}

Could this cause out-of-bounds accesses on msgs[] or stale report data in
__i2c_transfer_v2()?

First, i2c_transfer_report_init(report) is called once before the retry loop
rather than before each retry attempt. If an attempt returns -EAGAIN on
arbitration loss after adap->algo->xfer_v2() has populated report, the next
retry starts with non-negative report->msgs_cplt and report->bytes_cplt from
the previous attempt (for example, in i2c_dw_fault_report() where
report->msgs_cplt < 0 guards initial assignment and report->msgs_cplt +=3D
msgs_in_prev_parts accumulates across parts).

Second, when i2c_trace_msg_key tracepoints are enabled, __i2c_transfer_v2()
uses n =3D report->msgs_cplt in the loop and indexes msgs[n] when
report->bytes_cplt > 0 without checking that 0 <=3D n < num or that
report->bytes_cplt <=3D msgs[n].len, whereas the bounds checks in
i2cdev_ioctl_rdwr_v2() only run after i2c_transfer_v2() returns.

Third, if i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic is
taken while report is non-NULL, master_xfer_atomic() does not update report,
leaving report->msgs_cplt set to -EOPNOTSUPP even on a successful transfer.

> +	} else {
> +		res =3D i2c_transfer(client->adapter, msgs, nmsgs);
> +		if (res < 0)
> +			msgs_done =3D 0;
> +		else
> +			msgs_done =3D nmsgs;
> +	}
> +
> +	if (user_report && copy_to_user(user_report, &report, sizeof(report)))
> +		res =3D -EFAULT;
> +
> +	if (msgs_done > (int)nmsgs) {
> +		//fixme - use dev_err?
> +		pr_err("Bad i2c_transfer_report: msgs_cplt =3D %i, bytes_cplt =3D %i, =
nmsgs =3D %i\n",
> +		       report.msgs_cplt, report.bytes_cplt, nmsgs);
> +		msgs_done =3D nmsgs;
> +	}
> +
> +	if (report.bytes_cplt > 0) {
> +		if (msgs_done < nmsgs && msgs_done >=3D 0) {
> +			msgs[msgs_done].len =3D report.bytes_cplt;
> +			msgs_done++;
> +		} else {
> +			pr_err("Bad i2c_transfer_report: msgs_cplt =3D %i, bytes_cplt =3D %i,=
 nmsgs =3D %i\n",
> +				report.msgs_cplt, report.bytes_cplt, nmsgs);
> +		}
> +	}

[Severity: Low]
In i2cdev_ioctl_rdwr_v2(), there is a leftover "//fixme - use dev_err?"
comment above pr_err(). Should these pr_err() calls use
dev_err(&client->adapter->dev, ...) instead, and format unsigned int nmsgs
with %u?

Also, in the check:

	if (msgs_done < nmsgs && msgs_done >=3D 0)

msgs_done is a signed int while nmsgs is an unsigned int (unlike the earlier
check which casts nmsgs to int). Because of usual arithmetic conversions,
msgs_done is converted to unsigned int in msgs_done < nmsgs, which triggers=
 a
-Wsign-compare warning under W=3D1 and makes msgs_done >=3D 0 redundant.

Finally, if a driver reports both report.msgs_cplt > nmsgs and
report.bytes_cplt > 0, the first block logs "Bad i2c_transfer_report" and
clamps msgs_done =3D nmsgs, which then causes msgs_done < nmsgs in the seco=
nd
block to be false and logs the same error message a second time, all after
report was already copied to user_report.

> +
>  	while (i-- > 0) {
> -		if (res >=3D 0 && (msgs[i].flags & I2C_M_RD)) {
> +		if (msgs[i].flags & I2C_M_RD && i < msgs_done) {
>  			if (copy_to_user(data_ptrs[i], msgs[i].buf,
>  					 msgs[i].len))
>  				res =3D -EFAULT;

[Severity: High]
Can copy_to_user() read past the end of the allocated msgs[i].buf buffer in
i2cdev_ioctl_rdwr_v2()?

Earlier in i2cdev_ioctl_rdwr_v2(), each kernel buffer is allocated with the
original message length:

	msgs[i].buf =3D memdup_user(data_ptrs[i], msgs[i].len);

When report.bytes_cplt > 0 and 0 <=3D msgs_done < nmsgs, the code overwrites
msgs[msgs_done].len without checking that report.bytes_cplt does not exceed
the allocated msgs[msgs_done].len:

	if (report.bytes_cplt > 0) {
		if (msgs_done < nmsgs && msgs_done >=3D 0) {
			msgs[msgs_done].len =3D report.bytes_cplt;
			msgs_done++;
		}
	}

If a bus driver sets report.bytes_cplt to a value larger than
msgs[msgs_done].len (or if msgs[i].len was reduced to msgs[i].buf[0] for
I2C_M_RECV_LEN), copy_to_user(data_ptrs[i], msgs[i].buf, msgs[i].len) will
read out of bounds from the kernel heap buffer msgs[i].buf and copy past the
end of the userspace buffer. Should report.bytes_cplt be validated against
msgs[msgs_done].len before assigning it?

> @@ -439,18 +482,39 @@ static long i2cdev_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
>  		funcs =3D i2c_get_functionality(client->adapter);
>  		return put_user(funcs, (unsigned long __user *)arg);
> =20
> -	case I2C_RDWR: {
> +	case I2C_RDWR:
> +	case I2C_RDWR_V2:
> +	{
> +		struct i2c_rdwr_ioctl_data __user *user_arg;
> +		struct i2c_transfer_report __user *user_rep;
>  		struct i2c_rdwr_ioctl_data rdwr_arg;
>  		struct i2c_msg *rdwr_pa;
>  		int res;
> =20
> -		if (copy_from_user(&rdwr_arg,
> -				   (struct i2c_rdwr_ioctl_data __user *)arg,
> -				   sizeof(rdwr_arg)))
> +		if (cmd =3D=3D I2C_RDWR_V2) {
> +			user_arg =3D &((struct i2c_rdwr_v2_ioctl_data __user *)arg)->rdwr_dat=
a;
> +			user_rep =3D &((struct i2c_rdwr_v2_ioctl_data __user *)arg)->report;
> +		} else {
> +			user_arg =3D (struct i2c_rdwr_ioctl_data __user *)arg;
> +			user_rep =3D NULL;
> +		}
> +
> +		if (copy_from_user(&rdwr_arg, user_arg, sizeof(rdwr_arg)))
>  			return -EFAULT;
> =20
> -		if (!rdwr_arg.msgs || rdwr_arg.nmsgs =3D=3D 0)
> -			return -EINVAL;
> +		if (!rdwr_arg.msgs || rdwr_arg.nmsgs =3D=3D 0) {
> +			/*
> +			 * I2C_RDWR_V2 ioctl with nmsgs =3D=3D 0 is used for
> +			 * discovering of the controller capability to return
> +			 * detailed fault reports.
> +			 */
> +			if (cmd =3D=3D I2C_RDWR)
> +				return -EINVAL;
> +			if (client->adapter->algo->xfer_v2)
> +				return 0;
> +			else
> +				return -EOPNOTSUPP;
> +		}

[Severity: Medium]
In both i2cdev_ioctl() and compat_i2cdev_ioctl(), what happens when a caller
invokes I2C_RDWR_V2 with rdwr_arg.nmsgs > 0 and rdwr_arg.msgs =3D=3D NULL?

Because !rdwr_arg.msgs is combined with rdwr_arg.nmsgs =3D=3D 0 in the same
condition, passing a NULL msgs pointer with a non-zero nmsgs enters the
capability discovery branch and returns 0 (when algo->xfer_v2 is present)
without transferring any messages or updating user_rep, instead of returning
-EINVAL. Should capability discovery only trigger when rdwr_arg.nmsgs =3D=
=3D 0,
and return -EINVAL when rdwr_arg.msgs is NULL with rdwr_arg.nmsgs > 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D9
