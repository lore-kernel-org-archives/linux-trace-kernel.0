Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95738E5EF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414596; cv=none; b=cJRzJPjCv+KlQo1qwGUm+OVfwVFARt340GF7MhS0Eo1/xiOT8T/IebUXzI24tLelsdbZAPBlz6/DuvuwzwCzBkkRi7NOd8MRrI+5b6zGLqKmlbj8o4hrxZbGatsMFh4aeSl31OLpmjutQOIvFQvZFM7DrbRbqc6aLoP+0Bp5Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414596; c=relaxed/simple;
	bh=srUu72PNp+dxknX9eUZZ/0okYbDR0PwIN1JdbYXSc+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RpltRKqFhp1p8yH7TbgEYk1gO8K83dik4rnwLpXKA9FecdTF6zrh9S+xN1lSLoy1s7YrI0QDro0fkgWlrkUgjRZjkhVaulzMvyEBsnslYbur0qOi5KjMM0uKmuVe7IrXolL8IL6xIZLrI/SchG22AkToROk88GPF/OtmtDUkLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMe4CP6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMe4CP6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2671F000E9;
	Thu,  3 Sep 2026 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414594;
	bh=vxTB3jjoTncamKPyyT03wln1URiBrufHO/FP2bIeYe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMe4CP6xVAfR34A4ShT7AKNSgokp3gd5/o5vDMD60Wftw8gUWux7WCuiPBGPji0rw
	 KIUSMiNgnJb+2v1qSMrXBYm06RBw31glNgUhvWeH0wlVYEHjcIZhBBVnc7a/uz14Fg
	 nvmVFa1HhUIJKSdY/BnqaQ8Cad4iTG2LT7bZ1yD25QsmT1rXgMIAA3pAXPfHh4aFXA
	 IXvACTG1xs+EqAZq0tdmMME/8v0UMsludbSDV06+JdxBdfWU2G4Esn2GyrszvRscV4
	 Ob+XUOgsOmR1uyrhFUEABTTXXrmxr/OQnEMHr2Hftq92wPz7v602DC2DuW3OwsBq5l
	 kEDQnkmqPxOkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] i2c: designware: stop transfer if spurious
 STOP is detected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-10-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-10-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:49:54 +0000
Message-Id: <20260903054954.7D2671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Spurious STOP condition is missed if it occurs before the first by=
te of read data is received, leading to an interrupt storm and CPU lockup.
--

commit e3d26d6a69ce1efff22a0f3c5508b0815ec71b26
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: designware: stop transfer if spurious STOP is detected
   =20
In i2c_dw_process_transfer(), if STOP_DET flag is set while read or
write is in progress, the transfer should be aborted. If this flag is
handled the same interrupt as TX_EMPTY flag, the driver first handles
TX_EMPTY flag and transmits the following messages, and only afterwards
checks STOP_DET flag.

> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/bus=
ses/i2c-designware-master.c
> index 76f28e1696bdc..936b9150754e8 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -651,17 +651,19 @@ static void i2c_dw_process_transfer(struct dw_i2c_d=
ev *dev, unsigned int stat)
>  	if (stat & DW_IC_INTR_RX_FULL)
>  		i2c_dw_read(dev);
> =20
> -	if (stat & DW_IC_INTR_TX_EMPTY)
> -		i2c_dw_xfer_msg(dev);
> -
>  	/* Abort if we detect a STOP in the middle of a read or a write */
>  	if ((stat & DW_IC_INTR_STOP_DET) &&
>  	    (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS)=
)) {

[Severity: High]
This is a pre-existing issue, but can this logic lead to an interrupt
storm and system hang if a spurious STOP occurs during a read?

If a spurious STOP condition occurs on the bus after a read command
has been fully written to the transmit FIFO, but before enough data is
received to trigger a DW_IC_INTR_RX_FULL interrupt, neither
STATUS_WRITE_IN_PROGRESS nor STATUS_READ_IN_PROGRESS will be set.

This causes the check in i2c_dw_process_transfer() to bypass the spurious
STOP handling.

Furthermore, i2c_dw_read_clear_intrbits() refuses to clear the STOP
hardware interrupt flag under these conditions:

drivers/i2c/busses/i2c-designware-master.c:i2c_dw_read_clear_intrbits() {
    ...
	if ((stat & DW_IC_INTR_STOP_DET) &&
	    ((dev->rx_outstanding =3D=3D 0) || (stat & DW_IC_INTR_RX_FULL)))
		regmap_read(dev->map, DW_IC_CLR_STOP_DET, &dummy);
    ...
}

Because dev->rx_outstanding is greater than zero and DW_IC_INTR_RX_FULL
is not set, the flag is intentionally left uncleared. Since the interrupt
is never cleared or masked, would the interrupt service routine immediately
re-trigger upon return, causing a hard system hang?

>  		dev_err(dev->dev, "spurious STOP detected\n");
>  		dev->rx_outstanding =3D 0;
>  		dev->msg_err =3D -EIO;
> +		__i2c_dw_write_intr_mask(dev, 0);
> +		goto tx_aborted;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D10
