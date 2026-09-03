Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEA274B46
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414964; cv=none; b=PnKeF+mRDd+4120/8GWrWLpk3/QggBU418YQFarZWP4q+M0twcKA+ocB4fIclv2TwdSHrqjDH+qDFRtHJWUJtVxUwkN71ftQXwwIXoBrQAsTw2CvjMqrvahFDZGIt6+Yfk2OyWdACmOe1uzsZmM00HuxzCLD0uModevb0+SF9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414964; c=relaxed/simple;
	bh=wct71B0Pu60YkjYlZ4o19rf8zwrKzyCcU9xLV2noSNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bveHYddxC5oDvJdh52Be3G2twUOHAIfVaJ9bvAxc3WGGggWzIlkXq5fYJKCKhZgmXiJtNeeJublqLmARzVHBYMWayHY5e0eDDT+2aTd41ZCrVC57L9UBBVeezEMtcFk4sstLu6phupI/Zm65DHxxu/xybE3VlDZcTJH0iUL7AlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jljYIcSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jljYIcSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F311F000E9;
	Thu,  3 Sep 2026 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414962;
	bh=1e5+8R/QQneaZjKcIsj62iD2E710qU6JE660YgPNfHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jljYIcSCVNWGuCUEY/CrA+a0hbjSoVQhs7jzsEetTGvEF3T/4J4hX+17r3BsfEVfY
	 2nFujqEqSjmNj+zSn55EF9BzJEN3zgltrCMbTL2GvXDyNwpBLd1/zRtUEKD5Kd1wgH
	 OnKWdvN/JJnnyVhjcZacfwHWCUuSAFW5Zc3tBU8JY7VWrK10+/vpCutefRtv+ZScsS
	 8FIaHQxp/LAj68zcJWKYH32rS6C1Tw/5x0NABFlczVnfQr4Z6e3lbRetFszbUGzW03
	 jagar2R5aRXpXihKHJyWwORGnSxZE1ZGOvRrVonCp+Q5eEsGa/iTByE5Cinbh9AzsD
	 VFVmtZUax/FlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] i2c: nomadik: add support for I2C_XFER_V2 -
 detailed fault reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-7-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-7-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:56:02 +0000
Message-Id: <20260903055602.B5F311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The migration to the I2C_XFER_V2 API silently removed the hardcode=
d 3-attempt retry loop for transfers, breaking the driver's resilience agai=
nst transient bus errors.
- [High] Removing `.xfer` from `i2c_algorithm` breaks downstream subsystems=
 (like I2C multiplexers) that strictly check `.master_xfer`.
- [High] Heap out-of-bounds write in `i2cdev_ioctl_rdwr_v2` when updating t=
he length of a partially transferred message.
- [High] Unconditional memory leak of I2C message buffers upon transfer fai=
lure in `i2cdev_ioctl_rdwr_v2`.
- [Medium] Unprotected lockless read of `priv->cli.xfer_bytes` in process c=
ontext races with the hardirq handler.
- [Medium] Interrupt handler resets controller state before process context=
 can read it, defeating the new byte-level reporting.

Pre-existing issues:
- [High] Missing return value check for pm_runtime_get_sync(), which can le=
ad to a kernel crash if resume fails.
- [High] Missing synchronize_irq() in the timeout path leads to a Use-After=
-Free of message buffers by the interrupt handler.
--

commit 6e00e021c9abe420f0965de298c6d92c4d01241e
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: nomadik: add support for I2C_XFER_V2 - detailed fault reporting

I2C_XFER_V2 is a new API that allows I2C clients to get the detailed
report in case of transmission failure. Previously, the only information
returned by I2C bus controller was the error code, without exposing
how many messages or bytes had been sent. This commit introduces support
of this feature in the i2c-nomadik driver.

> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index c36e9961e0a39..8b0ab191f7c1f 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
[ ... ]
> @@ -678,6 +683,16 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv=
, u16 flags)
>  			status =3D priv->result;
>  		}
> =20
> +		if (flags & I2C_M_RD) {
> +			/* For READ messages, return the number of bytes read from FIFO */
> +			priv->bytes_cplt =3D priv->cli.xfer_bytes;

[Severity: Medium]
Is it safe to perform an unprotected lockless read of priv->cli.xfer_bytes
here? If the interrupt handler updates priv->cli.xfer_bytes concurrently on
an error or timeout path, could this regression cause the process context to
read a stale or inconsistent value?

> +		} else {
> +			/* For WRITE messages, return the number of bytes sent on bus */
> +			priv->bytes_cplt =3D FIELD_GET(I2C_SR_LENGTH, i2c_sr);

[Severity: Medium]
When an I2C abort error occurs, the interrupt handler calls init_hw(),
which resets the I2C_SR register before process context can read it.
Does this race condition cause the newly introduced byte-level error
reporting to silently fail by returning 0 for bytes_cplt and missing
the abort cause printout?

> +			/* LENGTH value includes the last byte that has not been sent or ACKe=
d */
> +			if (priv->bytes_cplt > 0)
> +				priv->bytes_cplt--;
> +		}
>  		init_hw(priv);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but missing synchronize_irq() in the timeout path leads to a
use-after-free. If a timeout occurs during an I2C transfer, this code path
frees the message buffer, but the interrupt handler could fire concurrently
on another CPU:

i2c_irq_handler()
    *priv->cli.buffer =3D nmk_i2c_readb(priv, I2C_RFR);

Since init_hw() calls disable_all_interrupts() which only masks the IP block
but does not wait for running handlers, can this cause memory corruption by
writing to the concurrently freed buffer?

> =20
>  		status =3D status ? status : priv->result;
[ ... ]
> @@ -733,14 +749,16 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *pri=
v, u16 flags)
>   * please use the i2c_smbus_read_i2c_block_data()
>   * or i2c_smbus_write_i2c_block_data() API
>   */
> -static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
> -		struct i2c_msg msgs[], int num_msgs)
> +static int nmk_i2c_xfer_v2(struct i2c_adapter *i2c_adap,
> +		struct i2c_msg msgs[], int num_msgs,
> +		struct i2c_transfer_report *report)
>  {

[Severity: High]
The migration to the I2C_XFER_V2 API silently removed the hardcoded 3-attem=
pt
retry loop for transfers. Does this regression break the driver's resilience
against transient bus errors like lost arbitration or NACKs, causing failed
I2C transfers for device drivers?

>  	int status =3D 0;
>  	int i;
>  	struct nmk_i2c_dev *priv =3D i2c_get_adapdata(i2c_adap);
> =20
>  	pm_runtime_get_sync(&priv->adev->dev);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but the return value of pm_runtime_get_sync() is unchecked here. If
the power domain fails to resume and returns an error, execution continues
to setup_i2c_controller(), which could lead to a kernel panic from accessing
unclocked or unpowered registers. Should we check the return value before
proceeding?

> +	priv->bytes_cplt =3D 0;
> =20
>  	/* setup the i2c controller */
[ ... ]
> @@ -1014,7 +1039,7 @@ static unsigned int nmk_i2c_functionality(struct i2=
c_adapter *adap)
>  }
> =20
>  static const struct i2c_algorithm nmk_i2c_algo =3D {
> -	.xfer =3D nmk_i2c_xfer,
> +	.xfer_v2 =3D nmk_i2c_xfer_v2,

[Severity: High]
Does removing .xfer from i2c_algorithm break downstream subsystems like I2C
multiplexers? When a multiplexer attached to this bus attempts to register
its transfer methods, it strictly checks parent->algo->master_xfer. Since
.xfer is removed, the .master_xfer field (which is aliased via a union)
evaluates to NULL, causing multiplexed I2C transfers to consistently fail
with -EOPNOTSUPP.

>  	.functionality =3D nmk_i2c_functionality
>  };


Looking at i2cdev_ioctl_rdwr_v2() in drivers/i2c/i2c-dev.c introduced earli=
er
in this series:

drivers/i2c/i2c-dev.c:i2cdev_ioctl_rdwr_v2() {
    ...
    if (user_report) {
        res =3D i2c_transfer_v2(client->adapter, msgs, nmsgs, &report);
        i =3D report.msgs_cplt;
    } else {
        res =3D i2c_transfer(client->adapter, msgs, nmsgs);
        if (res < 0)
            i =3D 0;
        else
            i =3D nmsgs;
    }
    ...
    while (i-- > 0) {
        if (msgs[i].flags & I2C_M_RD) {
            if (copy_to_user(data_ptrs[i], msgs[i].buf,
                             msgs[i].len))
                res =3D -EFAULT;
        }
        kfree(msgs[i].buf);
    }
    ...
}

[Severity: High]
Does this regression leak the un-transferred message buffers? When an I2C
transfer involving multiple messages fails partway through, the loop index i
is reassigned to the number of completed messages. This truncates the clean=
up
loop, skipping the kfree(msgs[i].buf) for all subsequent allocated message
buffers.


Further down in i2cdev_ioctl_rdwr_v2():

drivers/i2c/i2c-dev.c:i2cdev_ioctl_rdwr_v2() {
    ...
    /* Number of messages transferred completely or partially */
    if (report.bytes_cplt > 0) {
        i++;
        msgs[i].len =3D report.bytes_cplt;
    }
    ...
}

[Severity: High]
Can this regression corrupt memory with an out-of-bounds write? The code
incorrectly increments i before writing report.bytes_cplt to msgs[i].len.
If nmsgs =3D=3D 1 and the only message faults, this writes entirely outside=
 the
msgs array, or otherwise corrupts the length of the next message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D7
