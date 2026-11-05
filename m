Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900655;
	b=zbWTPGjs5B576jBZa5Tf/QzgaGsegiy11hW5hhZWU4fwK+uAK3ahdLCmYRCp441maai4
	 H9lRkyGx4V/FM8iPBINxacPsKQxAyEGuuzYA7gEjA2lNYW4yBo70tyZA0YHma6aBucNyb
	 MPaq783vTDCIoVsTMZqiJznt8UqcV2xLQjCgzY3WzUS24VqIcCRgXCI4tiKfBB+4/wt25
	 Zqeo3DB4qtuEqsmqlkQD7pK4BPTP/imLZszN1XGbkreek64BrSykGodOf23xxiUzXuWSI
	 QM9zwGo+AbSyvMyJWzLks/4WqvkZTTS/dE7Py8yAPpMBBXRKM9JepHCIMmU4Gi29ksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bmy0EVeh6oNWacdA96L2A2Z7XwTu9+w8atz06aegV7w=;
	b=trZWVVXG0hRKeM8Tjh690Hqi91vvOZd0JOBkBkkRqqD52AQkWfBl+kq4BKAoWC8P14pv
	 a27EwiwwAtVJKfUNKP04OiVIOw/3nMotCcmBdtxoNXn7ihughILUL1qR0ec2jF5neZODN
	 cwsjqhIwX6DBM2yw0CPYNQhukvQrTSGZ6xPDLnmr2kFpRUNA0crtOQtyMNvcx1YzKVmBS
	 vclFBU5uz6SL21WHwfJfZVTYtxxZKulawAi+VeZa5PqD/nII/UdK9ulWaNZP96PMA1cFM
	 XiH8fSSarfPKqkuHwU5q2XBJp5pyaSEfEZI4p8f6/ONUHvVukUCdQH6tPFsxCouRi7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ5OGAc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908F606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ5OGAc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1339F1F000C1;
	Thu,  5 Nov 2026 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900655;
	bh=bmy0EVeh6oNWacdA96L2A2Z7XwTu9+w8atz06aegV7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQ5OGAc8kuRwFVgw4BaS+kQvKYbIR7GRaxlWJjpUa+HPuhzmymqCISdsMACsv83ON
	 SSxG6BQH+2WRmgDLBsQ7yrQAbdY7h0kkkd3Y1kvByKcHlF7AtUT0w7ni0cmk/c3yqW
	 BESiIPzTNNbBXeiX8UEPEixhULLAeTdUdDLzGaoPSs66BkGYhY2kuu8dhuLO47v1TA
	 awXSM46q2cCe4KIkSUjop2IVBb7nzqIz9vfss7Lal7J8BdatvTHmcHx1YCZ2enyF1u
	 WnZ9ZWjDNtl250f57CSbYecDGldRQxpZXn/g0ZKx2uPj4oS/RQi/mHF2nhBssF+GJR
	 ht6NkO52anOkQ==
Message-ID: <sashiko-outbox-199652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/14] i2c: doc: add section for I2C_RDWR_V2
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-10-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-10-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:44:14 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] i2c: dev: NULL msgs with non-zero nmsgs accepted in i2cdev_ioctl=
()
- [Low] i2c: doc: inaccurate fault_msg_idx description in dev-interface.rst
- [Low] i2c: core: mismatched kernel-doc identifier above i2c_transfer()
--

commit 417441f5bb2c43e4da176d457da7a5caf43a4ed0
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: doc: add section for I2C_RDWR_V2 ioctl

This series introduces the I2C_RDWR_V2 ioctl and i2c_transfer_v2() API to
provide detailed fault reporting for I2C transfers, along with the
corresponding documentation in Documentation/i2c/dev-interface.rst.

> diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-=
interface.rst
> index c277a8e1202b5..95e60bdb2f4d0 100644
> --- a/Documentation/i2c/dev-interface.rst
> +++ b/Documentation/i2c/dev-interface.rst
> @@ -140,6 +140,54 @@ The following IOCTLs are defined:
>    The slave address and whether to use ten bit address mode has to be
>    set in each message, overriding the values set with the above ioctl's.
> =20
> +``ioctl(file, I2C_RDWR_V2, struct i2c_rdwr_v2_ioctl_data *msgset)``
> +  Does the same combined read/write transaction as I2C_RDWR, but also
> +  provides detailed fault report. The argument is a pointer to a::
> +
> +    struct i2c_rdwr_v2_ioctl_data {
> +	    struct i2c_rdwr_ioctl_data rdwr_data;
> +	    struct i2c_transfer_report report;
> +    };
> +
> +  rdwr_data is the same structure as the argument for I2C_RDWR ioctl.
> +  report is the structure that the transfer report is written to::
> +
> +    struct i2c_transfer_report {
> +      __s32 fault_msg_idx;
> +      __s32 msgs_cplt;
> +      __s32 bytes_cplt;
> +    };
> +
> +  msgs_cplt is the number of messages that has been sent or received
> +  successfully. If there are read messages within this range, the return=
ed
> +  data is guaranteed to be valid. If a message has been read from the
> +  device but the read data is lost (for example, FIFO is flushed before
> +  CPU read it), this message must not be counted.  If the controller can=
not
> +  determine the number of completed messages, the value is -EOPNOTSUPP.
> +
> +  fault_msg_idx is the number of messages that caused a fault. In case o=
f a
> +  fault, it is not necessary equal to msgs_cplt. For example, if the dri=
ver
> +  validates the whole batch before starting transmission, detects that it
> +  cannot send it, it returns -EOPNOTSUPP error immediately, so msgs_cplt=
 is 0,
> +  while fault_msg_idx points to the message that cannot be sent. Another
> +  example when these two value may be different is I2C controller that
> +  flushes RX FIFO when an error is detected before CPU reads data from i=
t.

[Severity: Low]
In Documentation/i2c/dev-interface.rst under the I2C_RDWR_V2 description, is
describing fault_msg_idx as "the number of messages that caused a fault"
accurate?

In include/uapi/linux/i2c.h, struct i2c_transfer_report defines fault_msg_i=
dx
as the 0-based index of the message that caused the fault, or a negative er=
ror
code (-EOPNOTSUPP via i2c_transfer_report_init()) if the bus driver cannot
determine it:

    struct i2c_transfer_report {
        __s32 fault_msg_idx; /* In case of a fault, index of the message th=
at caused
                              * the fault. If the bus driver cannot determi=
ne it, it
                              * puts a negative error code. If there is no =
fault, the
                              * value is equal to number of messages transf=
erred.
                              */

Should this paragraph state that fault_msg_idx is the index of the message
that caused a fault, and also mention that its value is -EOPNOTSUPP if the
controller cannot determine which message caused the fault?

[ ... ]

> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 165ec14260c88..e8449f55f0452 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c

[ ... ]

> +/**
> + * i2c_transfer_v2 - execute a single or combined I2C message
>   * @adap: Handle to I2C bus
>   * @msgs: One or more messages to execute before STOP is issued to
>   *	terminate the operation; each message begins with a START.
> @@ -2371,35 +2453,18 @@ EXPORT_SYMBOL(__i2c_transfer);
>   */
>  int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  {
> -	int ret;
> -
> -	/* REVISIT the fault reporting model here is weak:
> -	 *
> -	 *  - When we get an error after receiving N bytes from a slave,
> -	 *    there is no way to report "N".
> -	 *
> -	 *  - When we get a NAK after transmitting N bytes to a slave,
> -	 *    there is no way to report "N" ... or to let the master
> -	 *    continue executing the rest of this combined message, if
> -	 *    that's the appropriate response.
> -	 *
> -	 *  - When for example "num" is two and we successfully complete
> -	 *    the first message but get an error part way through the
> -	 *    second, it's unclear whether that should be reported as
> -	 *    one (discarding status on the second message) or errno
> -	 *    (discarding status on the first one).
> -	 */
> -	ret =3D __i2c_lock_bus_helper(adap);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D __i2c_transfer(adap, msgs, num);
> -	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
> -
> -	return ret;
> +	return i2c_transfer_v2(adap, msgs, num, NULL);
>  }

[Severity: Low]
This isn't a runtime bug, but the kernel-doc comment immediately above
i2c_transfer() in drivers/i2c/i2c-core-base.c was renamed to i2c_transfer_v=
2,
which causes a kernel-doc warning when building with W=3D1. Should the
identifier in the comment header remain i2c_transfer?

> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index d219eb89f978b..14fe1dd7eecf4 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c

[ ... ]

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
In i2cdev_ioctl() (and the identical check in compat_i2cdev_ioctl()) in
drivers/i2c/i2c-dev.c, what happens if user space invokes I2C_RDWR_V2 with
rdwr_arg.msgs =3D=3D NULL and rdwr_arg.nmsgs > 0?

Because both conditions are combined into:

    if (!rdwr_arg.msgs || rdwr_arg.nmsgs =3D=3D 0)

a call with a NULL msgs pointer and non-zero nmsgs enters the capability
discovery branch and returns 0 when client->adapter->algo->xfer_v2 is set,
without transferring any messages or initializing the user-space report
structure.

Should capability discovery only trigger when rdwr_arg.nmsgs =3D=3D 0, while
!rdwr_arg.msgs with non-zero nmsgs returns -EINVAL in both i2cdev_ioctl() a=
nd
compat_i2cdev_ioctl()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D10
