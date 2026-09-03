Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66697382299
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414757; cv=none; b=ObBKjRTjydODVWfKSOHuxYCTDj8gHW5xSGtFcBXeGA2enQS58BfTxb+iPdbW6LhlG7eZxUzOdjfNMwL08+2NL27fMnmi+HFELtwko/mxTwKT0mjHXg0DYQa8/N2oOMisFrxmUlIOMD4iFaxjlrGbzNFBd1kFS0ZCLRIF5ACtttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414757; c=relaxed/simple;
	bh=UEBYcgM8gmRDyF3l/b2rl5eq6dk8G2zSx3hVuMmKt9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NMTVWVR8SnN9Rl1b9KYfvD9DY2p1jAnxf092pMI1e+KEOSwJO7iQVVPF7dlAffj5lFQaPBoGxwWHVcDTPDa2kgYoR7BQTBGbLHpLfrfpqVQyHNqtXvCHvnINArIz7jG3hMPMQyqRA4CCl67Su7kShMVw0w3B7rCL6+ruegtwlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzTQpRUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzTQpRUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF9D1F000E9;
	Thu,  3 Sep 2026 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414756;
	bh=8c5SFZj5H6AFol0FJOwAzAFSLoWSdIPRNH/BXCtB6oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XzTQpRUAZJhzHjlKCJb7+zB5AATJ2ksF7LqtCXSqcwm1kAhL+UD7zpF6vo4oGtqJr
	 mpwXu5RVqSPus+EjiW2pWrL3iWFyj3De1X8ptNuR8pr1UPtJIgJLitL1EomeXBFFPW
	 GCWhQ9cHJu83Y4y2Bhg42uH3XzbP/P3NwOMct6Pa8UOmehJ7YNiAVllw64O5ZNKp7Z
	 LGtx/y2KrlmEPuW6uEMqzyDqRiwSqeF4S4XNUcJ4Her0mTirYPA1QpoycLFcllJ0zQ
	 lhIimXGKrOoF+aP4Jju7I/KpnicPMSQsYPZEC9zx9PJXfSnkjC0xReqZzA2dzOFc9F
	 FIf7PgNaZaX4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] i2c: core: add I2C_XFER_V2 - support for
 detailed transfer reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-1-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:52:35 +0000
Message-Id: <20260903055236.2CF9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Message buffers allocated during initialization are leaked on erro=
r or partial transfer paths because the cleanup loop counter is incorrectly=
 overwritten.
- [High] Incrementing the array index before writing `msgs[i].len` causes a=
n out-of-bounds kernel heap write if the transfer fault occurs on the last =
message in the batch.
- [High] `dummy_report` is passed uninitialized to adapter drivers and its =
uninitialized contents dictate trace loop bounds, risking out-of-bounds mem=
ory accesses.
- [High] The `compat_i2cdev_ioctl()` handler is missing the `I2C_RDWR_V2` c=
ase, severely breaking 32-bit user-space compatibility on 64-bit kernels.
- [High] The `i2c_reply` tracepoint dynamically allocates and copies `msg->=
len` bytes instead of the actually transferred `data_len`.
- [Medium] The `fault_msg_idx` returned to userspace suffers from an off-by=
-one error during `I2C_M_RECV_LEN` validation.
- [Medium] Failure to copy `user_report` back to userspace when parameter v=
alidation fails in `i2cdev_ioctl_rdwr_v2`.
--

commit 57251745b527f28695f099c2ece7c79d4075938b
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: core: add I2C_XFER_V2 - support for detailed transfer reporting

This commit introduces the i2c_transfer_v2 API and I2C_RDWR_V2 ioctl to
provide detailed fault reporting during I2C transfers. It allows bus
controllers to specify which message failed and how many bytes were
transferred.

> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index ddaacf876dada..a6515868f97ba 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
[ ... ]
> +int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, in=
t num,
> +		   struct i2c_transfer_report *report)
>  {
> +	struct i2c_transfer_report dummy_report;
>  	unsigned long orig_jiffies;
>  	int ret, try;
[ ... ]
> +	/*
> +	 * If the controller only supports "v2" callback and the report is not =
requested,
> +	 * provide pointer to a dummy report.
> +	 */
> +	if (!(adap->algo->master_xfer) && (!report))
> +		report =3D &dummy_report;
[ ... ]
>  	if (static_branch_unlikely(&i2c_trace_msg_key)) {
> -		int i;
> -		for (i =3D 0; i < ret; i++)
> +		int n;
> +
> +		if (report)
> +			n =3D report->msgs_cplt;
> +		else
> +			n =3D ret;
> +		for (int i =3D 0; i < n; i++)

[Severity: High]
The dummy_report structure is declared on the stack but not initialized.

If the adapter only supports xfer_v2 and report is NULL, the code redirects
report to &dummy_report. If the transfer completes via the atomic fallback
or if xfer_v2 fails without populating the report, does this uninitialized
stack memory dictate the upper bound n in the tracing loop? This could
result in an out-of-bounds array read when tracing is enabled.

> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index ccaac5e29f906..90456e6c04b41 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
[ ... ]
> @@ -289,6 +297,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_clie=
nt *client,
>  					     I2C_SMBUS_BLOCK_MAX) {
>  				i++;
>  				res =3D -EINVAL;
> +				report.fault_msg_idx =3D i;
>  				break;
>  			}

[Severity: Medium]
Does this set the fault index to the incorrect message? The loop counter
is incremented before assigning it to report.fault_msg_idx. This means
userspace would be told the fault occurred on the message following the one
that actually failed the length validation.

[ ... ]
> @@ -303,9 +312,34 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_cli=
ent *client,
>  		return res;
>  	}

[Severity: Medium]
If message validation fails (e.g., maximum length exceeded), the function
returns early with return res; here. Doesn't this skip the copy_to_user()
at the end of the function, discarding the fault_msg_idx that was recorded?

> -	res =3D i2c_transfer(client->adapter, msgs, nmsgs);
> +	if (user_report) {
> +		res =3D i2c_transfer_v2(client->adapter, msgs, nmsgs, &report);
> +		i =3D report.msgs_cplt;
> +	} else {
> +		res =3D i2c_transfer(client->adapter, msgs, nmsgs);
> +		if (res < 0)
> +			i =3D 0;
> +		else
> +			i =3D nmsgs;
> +	}

[Severity: High]
The loop counter is overwritten here with report.msgs_cplt or 0.
Since the cleanup loop uses while (i-- > 0), does this skip the
deallocation of the memory buffers from index i up to nmsgs - 1?
This could allow unprivileged users to leak kernel heap memory by
intentionally triggering partial transfers.

> +
> +	if (user_report && copy_to_user(user_report, &report, sizeof(report)))
> +		res =3D -EFAULT;
> +
> +	/* Number of messages transferred completely or partially */
> +	if (report.bytes_cplt > 0) {
> +		i++;
> +		msgs[i].len =3D report.bytes_cplt;
> +	}
> +

[Severity: High]
If the transfer fault occurs on the final message in the batch, the
overwritten loop counter will equal nmsgs - 1. If report.bytes_cplt > 0,
the counter is incremented to nmsgs before assigning msgs[i].len. Does this
result in an out-of-bounds kernel heap write to msgs[nmsgs]?

[ ... ]
> @@ -572,7 +627,7 @@ static long compat_i2cdev_ioctl(struct file *file, un=
signed int cmd, unsigned lo
>  			};
>  		}
> =20
> -		res =3D i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
> +		res =3D i2cdev_ioctl_rdwr_v2(client, rdwr_arg.nmsgs, rdwr_pa, NULL);
>  		kfree(rdwr_pa);
>  		return res;
>  	}

[Severity: High]
The I2C_RDWR_V2 ioctl command is not added to the switch statement in
compat_i2cdev_ioctl(). Could this cause 32-bit processes calling this new
ioctl on 64-bit kernels to fall through to the native 64-bit i2cdev_ioctl(),
leading to struct layout parsing mismatches and memory corruption?

> diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
> index 142a23c6593c6..2ea8e9805edf5 100644
> --- a/include/trace/events/i2c.h
> +++ b/include/trace/events/i2c.h
[ ... ]
> @@ -102,7 +102,7 @@ TRACE_EVENT_FN(i2c_reply,
>  		       __entry->msg_nr =3D num;
>  		       __entry->addr =3D msg->addr;
>  		       __entry->flags =3D msg->flags;
> -		       __entry->len =3D msg->len;
> +		       __entry->len =3D data_len;
>  		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
>  			      ),

[Severity: High]
While __entry->len is updated to use the provided data_len, the dynamic
array allocation (via __dynamic_array in TP_STRUCT__entry) and the
memcpy() call still use msg->len.

If data_len is greater than msg->len, could this cause TP_printk() to
read past the end of the trace ring buffer allocation? Conversely, if
data_len is smaller, does the memcpy() copy uninitialized kernel heap
memory into the trace ring buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D1
