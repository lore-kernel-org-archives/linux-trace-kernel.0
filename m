Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1737188A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414813; cv=none; b=P+K3HYUj0aSFJJ52pzbTBNX8d+IcLKe01SDZxAfsfXLx2wmd2i3FkDI2RKK3W+N624SItMHOs469eWPJNfxeU2bU8tsIg0tkpOwpRpT7KlF+p6R3JgcLyKnTl55yt7BPcE2xneUjNkMTwmdPYZG26UjRA4ilnNpK9+q0XASu/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414813; c=relaxed/simple;
	bh=qb/taHIdwW9of5PS+PtHXKU1jE6xxKDUNw6qOAKCB44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMl/qYP152uWa2wGOTdbBhDVOztYGSCS+7AlsxWBiujJdx84zcOnAsHCHfSK6dj3c8B3Gmxbt/VchSjSBL+FaMbWTTY1LtnCcYp36Kf7PCI9oL7r+7g/VsvkbnsZhH4DFO2aXFuz8pTX5+eLHyKOQ+dVQirkBOrV1BN3+JUZANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjzrLfHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjzrLfHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958D1F000E9;
	Thu,  3 Sep 2026 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414812;
	bh=y7zpK7dKO8gTL2qP8kbq8bo8gh0ErSAZK0dPNqeNcjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjzrLfHEHKwd40dq264NeJXfRgx81YY0kiy+LxOBdfEpdll0QxvRLp4P9fhTW9qoo
	 Rsh5csYKz2mW5wkLv6dPEalh39exi0daKs6smzrqhFvQBIdky5DDthD67/msHcg5Cd
	 IJjAmMIox+pc/fEkzz6d1gIKZ80pbc36Jgkaet6tAKfNIagsWfgV1smWwqdyc/QYs2
	 ST2l9miQCxXe7fc7LbfdTWdcfS6r8gk2WY4Zl5b91v60+gzSA1sKd6IdPSTuFgqA7d
	 XSR8hSeN4imOUQrLG9LtDSKZduAjQlOxt0KH5ARu7rq7N+rCG4XmkB0tI9TK9fw++l
	 ax6Un46HJRBwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] i2c: nomadik: do not try to retransmit I2C
 message series on errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-3-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-3-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:53:31 +0000
Message-Id: <20260903055331.D958D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lack of synchronization between process context timeout handli=
ng and the IRQ handler causes unprotected hardware access and Use-After-Fre=
e memory corruption.
- [High] Missing return value check for pm_runtime_get_sync() in nmk_i2c_xf=
er() / nmk_i2c_xfer_v2() allows hardware access while the device is suspend=
ed.
- [High] Wait queue head `xfer_wq` is incorrectly re-initialized per-transf=
er, risking data races with delayed interrupts.
- [High] flush_i2c_fifo() executes a massive, non-yielding busy-wait loop i=
nside an IRQ handler, risking an NMI watchdog timeout.
--

commit 5d412f1d8843a1e97e53a226d012fcb387ee76b5
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: i2c: nomadik: do not try to retransmit I2C message series on errors

This commit modifies the i2c-nomadik driver to avoid retransmitting the
entire message series upon an error in the xfer callback. It removes the
triple retry loop to prevent hiding hardware faults and avoiding issues
with non-idempotent messages.

> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 45b4815b09452..ca9366e09e712 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -716,27 +716,21 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_ada=
p,
>  	int status =3D 0;
>  	int i;
>  	struct nmk_i2c_dev *priv =3D i2c_get_adapdata(i2c_adap);
> -	int j;
> =20
>  	pm_runtime_get_sync(&priv->adev->dev);
> =20
> -	/* Attempt three times to send the message queue */
> -	for (j =3D 0; j < 3; j++) {
> -		/* setup the i2c controller */
> -		setup_i2c_controller(priv);

[Severity: High]
This isn't a regression introduced by this patch, but pm_runtime_get_sync()
can fail (e.g., if the clock fails to enable or the power domain is off).
Since this return value is not checked, does this unconditionally proceed to
access hardware registers via setup_i2c_controller() even if the device
failed to resume?

If the clock remains gated, could accessing the I/O memory cause a kernel
panic (synchronous external abort or bus fault)?

> -		for (i =3D 0; i < num_msgs; i++) {
[ ... ]

Looking at read_i2c() in drivers/i2c/busses/i2c-nomadik.c:

> static int read_i2c(struct nmk_i2c_dev *priv, u16 flags)
> {
[ ... ]
> 	/* enable the controller */
> 	i2c_set_bit(priv->virtbase + I2C_CR, I2C_CR_PE);
>=20
> 	init_waitqueue_head(&priv->xfer_wq);
> 	priv->xfer_done =3D false;

[Severity: High]
This isn't a regression introduced by this patch, but init_waitqueue_head()
is called at the start of every transfer. Wait queues should typically be
initialized exactly once during device probe.

If a previous transfer timed out and its interrupt was not successfully
disabled (e.g., if flush_i2c_fifo() times out), could a delayed hardware
interrupt fire concurrently with the next transfer's initialization?

The delayed i2c_irq_handler() executes:

> 		priv->xfer_done =3D true;
> 		wake_up(&priv->xfer_wq);

Could wake_up() execute exactly while init_waitqueue_head() is
re-initializing the waitqueue's spinlock and list head on another CPU,
leading to spinlock and linked list corruption?

Looking at flush_i2c_fifo() in drivers/i2c/busses/i2c-nomadik.c:

> static int flush_i2c_fifo(struct nmk_i2c_dev *priv)
> {
> #define LOOP_ATTEMPTS 10
> 	ktime_t timeout;
> 	int i;
[ ... ]
> 	for (i =3D 0; i < LOOP_ATTEMPTS; i++) {
> 		timeout =3D ktime_add_us(ktime_get(), priv->timeout_usecs);
>=20
> 		while (ktime_after(timeout, ktime_get())) {
> 			if ((readl(priv->virtbase + I2C_CR) &
> 				(I2C_CR_FTX | I2C_CR_FRX)) =3D=3D 0)
> 				return 0;
> 		}
> 	}

[Severity: High]
This isn't a regression introduced by this patch, but flush_i2c_fifo() uses
a polling loop checking FIFO status using ktime_after() without any
cpu_relax() or sleep.=20

Since flush_i2c_fifo() is called by init_hw(), which is triggered by the
i2c_irq_handler() on error paths (such as I2C_IT_MAL or I2C_IT_BERR),
is this blocking nested loop executing inside a hard IRQ handler context?

The timeout duration priv->timeout_usecs (defaulting to 200 ms) is nested
inside an outer loop running LOOP_ATTEMPTS (10) times. If the hardware is
stuck, could the IRQ handler continuously spin in hard IRQ context for
2 seconds, triggering a system hard lockup and NMI watchdog panic?

Looking at nmk_i2c_xfer_one() in drivers/i2c/busses/i2c-nomadik.c:

> static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
> {
[ ... ]
> 	if (status || priv->result) {
> 		u32 i2c_sr;
> 		u32 cause;
[ ... ]
> 		init_hw(priv);
>=20
> 		status =3D status ? status : priv->result;
> 	}
>=20
> 	return status;
> }

[Severity: Critical]
This isn't a regression introduced by this patch, but if an I2C transfer
times out in wait_event_timeout() within read_i2c(), process context
attempts recovery by calling init_hw() without any lock to serialize against
the IRQ handler.

Looking at init_hw():

> static int init_hw(struct nmk_i2c_dev *priv)
> {
> 	int stat;
>=20
> 	stat =3D flush_i2c_fifo(priv);
> 	if (stat)
> 		goto exit;
>=20
> 	/* disable the controller */
> 	i2c_clr_bit(priv->virtbase + I2C_CR, I2C_CR_PE);
>=20
> 	disable_all_interrupts(priv);

If flush_i2c_fifo() also times out, it exits early via goto exit and skips
disabling the controller and its interrupts.=20

When the process returns -ETIMEDOUT to the I2C core, the user-provided
transfer buffer is freed. Since the hardware and interrupts were left
enabled, could a delayed interrupt later complete the transaction and fire?

The IRQ handler executes locklessly and enters the Rx interrupt case:

> 	case I2C_IT_RXFNF:
> 		for (count =3D rft; count > 0; count--) {
> 			/* Read the Rx FIFO */
> 			*priv->cli.buffer =3D nmk_i2c_readb(priv, I2C_RFR);
> 			priv->cli.buffer++;
> 		}

Could this dereference the stale priv->cli.buffer, resulting in a
use-after-free and memory corruption by writing received hardware data
directly into freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D3
