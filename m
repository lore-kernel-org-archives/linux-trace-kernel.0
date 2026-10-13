Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DB542EEC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932291; cv=pass; b=m9d0j30HRh4tqd4H3B/rWu0DW7EDXY3NwkKiR/YtN2jcC6HVQgTvYQJpw3hzRNW9EDr9/rkmxibjlLwFDE7ZmStj+sibV0/lX4ftyblSI6OnuoXol0PIWAzXEE71PMZbKkt5Jsh1rDQKH3OfnXaCON3W+wjV6JyuRQWF02srngE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932291; c=relaxed/simple;
	bh=0EpohbfYukostjZXI2ncT+Tc3ZmFCLMbMduDseGX9/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjnw8aFqjagPVz2Yx1/eEcLJdvwVISCSLySCRrLT127PwJnN9ifmHUe+mqqL0qaeojRUgQ4/30IaMwNiQhokA9aUn7+9eb8MNykybRBECe5I4yl53+egQm3cFTxpdisfxZhjDQ5ySO1i83X6zKMWzKpCzI8td/hsH+/sHlBnMII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oZBUNVUP; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZBUNVUP"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac8a2ac52bso36556777b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 15:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932287; cv=none;
        d=google.com; s=arc-20260327;
        b=gMmVv8v3ywA4iVayhlCiVubi4ODS5ju3hSkK/8wnsWo5alVRA4cH3ELcSB2rCE0k2o
         OxUB/8SskA6OzFSGkqJwJKug1HDnIugBk8O7ksFoc1sQBlupZ1848mdU1Ne+teypqSm2
         z75DawAA2SdZHlBhDnsl8c0cCeGETNeI+bGV8fSl4vAJ/pZsw84uaHt1MbD+EKWszJoJ
         En/6ieaY1vbpKpiBq4iVH5RNrKylxmEhvI2z3v9uHM4Am73m+rO9zEH6xzjXLnyiZU2p
         o6llTuYIyncA5bT8UcBG5eZktcq8Vn5T2IygrcndDcRHaIUHZFIP1QPVxJDwUhtqGPgR
         lgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        fh=kt9uZKYVzMe1fIpqPMaN+ALLVNcFaK2DXrt/OMnvjME=;
        b=OYU1IaJXK/dHqpCQYRPWduWi6JrnzrxcNsNw5l4U0YarPkSZY9cOUuia03XLVhIIuh
         Zsi0dad17P6Wk4o2PxSFigFm6SCdukkpSGNiBgv9YNMAG8xE5nUdm8UlRYmGsby1sVX7
         6kTbT3SM8+6egvJmWz0dYU9aSw+c0vUAns4a4jCeBTQHGi8lHoGj2a5wdbiyyr/l7uvM
         VYpBJzCYtmQOTemFcri6Ok7/rYYAgLCR6KkqHbQ4HFVKifBpGiQuymap9jDdmAx5VHUf
         ceixg3Nd/A7+SNJT4YkpUpqsnQn5tJYShjy6wtZ3MGaG3vqMBHoRim4BRJ/dfYEWHq40
         W2Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791932287; x=1792537087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        b=oZBUNVUPz9F891EBANCiJ1zpQtqx5ZnytrriGsQTtVDwjEfrozhfX3EUQSXt4Uq32m
         o/62ov5r2iWb0s27TnHD0DtzR75APPg3LI3NvusDHxoQodUNP2XVpwpT7JjY5USRURBy
         GVmXzV+oBz6/YA6VdTe2OhtUQVY1rruxWflo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932287; x=1792537087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNT5k/R5hoaf9iRJyFQonm0fN6tqHDSkSoHBE1CtQE8=;
        b=dOTZzY8SFJzF2xT8P0OrPq8ake7grfNj6mglp25RJElVynwT95lX4AfmKhIuTFoEIC
         r5bQ9V7evUaQDppmkbUXkTUqcIfnrm1kFJNWU61/b6HCGh+pZav1O5oN0MycHbuY2JGu
         hZszbmmqt10SCbB7jX+Gwp9EvVXfHCkC3Rs52b0zBOuwsBTAT2IxLQ0/6UPt8L1P/pAi
         4w/1eItpivYU6fAD+2WzdueXoMyl6okRSpEk0OJrZ936StJ3pTSlHgx188sHp7JDmleO
         pxTewaayAoPsmfY2sGcwZhy0L4QwWjg+tSDhoWU5mONNtLuNjN9Mn+K/vrw6Av4tFt7e
         8BwQ==
X-Gm-Message-State: AFq9FYL+OfiiJCXsxzoc2TY2ggnSOFR77FFyWSdTu9oK/6o8Lleznbbl
	98L44O6WewyAYI3REMF/re53MAGZ7QfIo+zB6/ShYx1jmOi4a2z5vQPJnJAqoZTKCcu+Nr7WOQZ
	+2n/f2t0d9trvBASnxGfcAMdFbtAvTvObRgID+cnS
X-Gm-Gg: AYBFou3y3D7MXQv9U/YVm96PbVQFENM6LcZSM1TBC2W4lN1xyrUuKzRXrVNFHNwwhVD
	RDSxNXYPUTKvpgF2fd0xaqrgaF3CATdj1xDlndPN1/bCkk5ONsXVstOhD68nVnp9uOROHOI0BD4
	nuOiADB5mD1oK5fPrNkLmk6vsjOvlcqspX2cyugJMKLhdgeh0v+lotFH3IYq1qfu99SkZ+rc5g8
	fzAvL9lELnm9PTi82bwoPQkhmU8DQqXNhg/xD7vs28asMDVc6bI3qQseq2j0mZUtaP72HwFWHMF
	dXwVg7rzCxMADIZSh6csc291FW7Cb/JHLbIWum37ErlvtvbftGBxdcujozn4uVzA59MfWDhpqlI
	MNivYsj5xWQ==
X-Received: by 2002:a05:690c:47c4:b0:8ac:927:f7e5 with SMTP id
 00721157ae682-8b07ed0a2e1mr37669057b3.10.1791932287599; Tue, 13 Oct 2026
 15:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-10-384af01da3ee@chromium.org> <sashiko-outbox-166155@kernel.org>
In-Reply-To: <sashiko-outbox-166155@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:57:56 -0700
X-Gm-Features: AclHuK81HkBfvQ90JSsC-kMkz_kzpA8f9XGiSlSkqkbfMIOwnBJRPKPpuZiMjK8
Message-ID: <CAEe3GZGdbXdbqLjAmubh6EwdZ=FgzSDphmTy6YR53PySnH4cvQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] HID: spi-hid: add power management implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] spi-hid: hid_driver_reset_resume() races with error recovery d=
uring resume
> --
>
> commit e43c402ebe88a8dd98c0bab5a81f64d825faf560
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
>     HID: spi-hid: add power management implementation
>
> This commit implements power management callbacks for the HID over SPI
> driver. It introduces suspend and resume operations, handling device
> power state and reset coordination during system transitions.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index f4e9b4e1294ed..66bfc251bd915 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > +static int spi_hid_resume(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     bool was_reset =3D false;
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> [ ... ]
> > +     enable_irq(shid->spi->irq);
> > +
> > +     /*
> > +      * For devices that may wake up, process work that was pending wh=
en
> > +      * suspend cancelled reset_work. Otherwise suspend already droppe=
d it.
> > +      */
> > +     if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> > +         test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> > +         test_bit(SPI_HID_ERROR, &shid->flags))
> > +             schedule_work(&shid->reset_work);
> > +
> > +     if (shid->hid) {
> > +             if (was_reset)
> > +                     spi_hid_wait_for_reset(shid);
> > +             error =3D hid_driver_reset_resume(shid->hid);
>
> [Severity: Medium]
> Does hid_driver_reset_resume() race with error recovery here?
>
> In spi_hid_resume() (drivers/hid/spi-hid/spi-hid-core.c), the power_lock =
is
> acquired at the beginning of the function and held until it returns.
>
> If a wakeup-capable device suspends while an error recovery is pending
> (the SPI_HID_ERROR flag is set), spi_hid_suspend() cancels reset_work and
> leaves the device powered on.
>
> During system resume, spi_hid_resume() reschedules reset_work to handle t=
he
> pending error. However, because the device was left powered on, was_reset=
 is
> false, causing spi_hid_resume() to skip spi_hid_wait_for_reset().
>
> It then immediately calls hid_driver_reset_resume() while still holding
> power_lock. Because reset_work requires power_lock to execute
> spi_hid_error_handler(), the scheduled error recovery is blocked until
> spi_hid_resume() returns.
>
> Consequently, hid_driver_reset_resume() attempts to communicate with the
> device synchronously while it is physically still in an unresponsive erro=
r
> state, which will time out or fail, aborting the device resume.

This needs an error to be pending exactly at suspend on a wakeup-enabled
device. Error recovery still runs right after resume, so I'd rather keep
the resume path simple.

>
> > +             if (error) {
> > +                     dev_err(dev, "%s: failed to reset resume hid driv=
er: %d\n",
> > +                             __func__, error);
> > +                     return error;
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D10
