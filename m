Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214538;
	b=hkFoPPpZeVVMwT4t0yg4VtwykEykErhhF5S69unXvh/Lduq1CP78bU6Hrbr4eGIUyPIa
	 TY5nvutavGiriKl6YlzyQKIz76TRpGvHThiXqPTPAdYOp+OhMiO6QIItJpkLZLaaskEcR
	 uxPNxRMbZ4dbIgIlhLB2+v95/bygTin5WNHE0JqTB0RWN1XeGVGuD7eoGswsReT276dc1
	 JDxuR9RGUDb0u03vuZ6LQ6D8JJpYgVWcVuOvL3mSiWwgTbew3upgam6TeZSstQ0YLX4vR
	 1DlTx41UqToFoJ0Ujqa9FWrUxROiPjLliYUXE8iaMlwCftCGP9GsjMDHkkLJzjG9lOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
	b=1V+YLYT37YOA4gpbV4x3a1tsg3fGBhJmzq9xVoqFOP9V8jmtSz6WzjOhKZiMaabKkiBT
	 80JrJBgF8+vlIePyP/AHKqbXdrCztFn6NmE442gsAi8NMCCt5tdWY9A+Ko1HRKHKMGTEY
	 TRkPk51WxNZjawL8P1yEaYQq7JUIT2kkyTt0DNwEdYylyK/zWkcBPFBScql5pn2DfgO43
	 2H6sqqWq7nO5clV0rOZk8wXry0CX16Ecd+bfC/VM8vuFrdQbbeWrsy1J6/MJgO0YE47CT
	 yqKsIl51rHbvBAj4jkgYxs/GYaSWx3iII9HuyHrpmcBD+4O9JkWLfVe/+wDk1CurQVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fvNFs6YW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C58606A6BD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 22:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C58606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fvNFs6YW
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso1693417d50.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 14:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214531; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMSQG4Hq6L78S8n0oyCX/SqmGWu7Lb7z+na9VnH/tDTizb2IJxxHrM18kr7js9H5ga
         6WTqSoZyQK1T/vKU/BOVJwIoslpks77ygkU+rBh+gnTmABVo5XFTHJWpUoPWqnbtvg11
         7JVX58iYn7F4NR0yarTPMhkkENltMgb7dWKRJOiblVwORgHtAE/gfRDROAuwNwTQuS2k
         ycCfGGewAnKofkyQvmpadBbDH5hHvC6ML7eOn75Oo5M1QiPxTCfjkv/FPTbg6xWYirUt
         /7CNaXtucTxYKUF/+3uzVraRoRZfDIgKtVbHoZ437UEYgRHvORRPeZf8NCtHcAs8vj7k
         Iv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        fh=2kGZJG9G3AuYX+FuT5qwzVphAkUHSda0J93dFGNn9YM=;
        b=h9hw69jUxypee7SxRj0KXepYIIwrU8ZBSdQmB/efsJp+DwgOUdLRu0+IQzUrsEH0aK
         yZBpm0uuRLfyDlxXJFEWxkkTQbxSw508jCqBtHJzfyu16zgHJt3ZJrtBNTTjBzCICQJs
         6i1jjPWPOD/PFN2FFXUu4pmruXCCDa6XC/WSlDkhxXi1ZsZw6+flY5cc8Xbkq9gVms6y
         tjHM7pPNCZVjDckC0CGuZVWEOX1eUZc3te3hxNB6N/24SRyeOUB0h0FDQa2w05XsanXu
         pH49GEn1rhm9bN5BDuh1P4Gv9b7j4iQg2ZCA19KQEFRu50MQMAV1YTsJxS4snnxu8dl7
         R9ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795214531; x=1795819331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        b=fvNFs6YWasf+wplVYmHAek4F/XoGdUzQF5xAHO5IGZp5CRRMRRxkruN3V+DWI4+hCW
         oHgp2SRsfzcmufJj7ymjrsKVE0kw4s8HdIeYBoJqV5T7lhTewU9l1CwTZk4K5ZUFxWIh
         2dqCA02YjCgAuB7cdfi9YfOGibXePz+tK2myU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214531; x=1795819331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        b=WNsWb2dvnuVfJV3xOa6+/Cj4xPZNVyE0Lp9I4DwNxMC1vFJr04X/r4XwLgavHMPZkR
         nDwU45dv8ng5bauxle/ThwawQSQilDrkbPgSC0MRNvwY+sMTNMv/PYvEFz/3HNLsC7ru
         psQjCrDMipVDkbuXGyPjUuqIZVb4/Se1CYKS8J/ZOlvKXDmYKDQZ28dHy1sjbWMvJS+8
         oRj0/k9ujBbEOcL3odWYdQCCW5J2pch4FILUBnnOHj+4Z5mmd1SF1VovKhHKgM9AlCj/
         /G4d0EDpPjYEuHDErcUeLKdMkllBUBUmLeuk3nuIDwAEMC+FoqRUqmBUe5M0CLBdFOII
         mWPw==
X-Forwarded-Encrypted: i=1; AL+hErHML9HqNgMpOqVzQ1sIwcI7CaG4u9sUCcjIbh7EyFqqYVQufhT3tunFPGxFGKgwnbN3Vg4oIFf8be5t9nVcBI5E3EM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SLfVd2LrRZ3l/kkBHq9iEWlqdH5iJ4Feq2EFxGuobJUV8hl6q
	ctUQkhdpkDSgb/fy+ciNIVFtHL88Di4LSgmAeNxm2F3troA/tDYKd8ihjR/ibse+M/4gzskYcwa
	TMPupJw+HSEEN5OjKCJsg9EiVDgcCVaj64yatm8hd
X-Gm-Gg: AZFdTZeOzyMG1U+95qm5SGcaLoMYOQ9PANA2et0uJS8/L+eIYZWw5lpn3LCsnf/lBeS
	PXRwgbw/chhyYrehCTNc6b7AG+IGhwyCa2JkAvpWX3G75sCvEm8P1b2Ye/AgLOSgVmfMMQ51rVn
	v9pH0SV/snum7d0jhY4Y4vQTR5WvGU7BrUmFiP2t4kp2AHNa0pdDh19mMJg86SHCx5fBkNt5omN
	PCb/MUNBfFdb7sUzwGvWe/oSXTK1skStksJgb4rbcEIam9VDq0RpeEOIxcyujO9b6k4YALFkElw
	rBabJ8/DxZ7PCz9hENt/FjYVUhDH0Zez3nGqWa1vpiN1bAc+rOmrRUwmRLCaWlwBzQVhj2aA0fh
	hQdIn2sVUnY/dE+serANV0xOQJcoqzUfpvADw4z/bSDUi9j6e/mgt0Q+Tb6ynYjRYFDE=
X-Received: by 2002:a05:690e:1918:b0:67d:e4c3:d838 with SMTP id
 956f58d0204a3-67df440a008mr1910475d50.29.1795214531587; Fri, 20 Nov 2026
 14:42:11 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-11-abad13174b43@chromium.org> <sashiko-outbox-183484@kernel.org>
In-Reply-To: <sashiko-outbox-183484@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 14:42:00 -0800
X-Gm-Features: Aa3M54qwBjwBmrAzhDq76JOH0mkyHB45HQlbB0ykD_xKYZsQBf4Gvgfm3ggVaBs
Message-ID: <CAEe3GZHSuQ2c2gOJPgJDu08T2+m+2RHLmcpGsE_0o+=UX96F_A@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] HID: spi-hid: add panel follower support
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:10=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] HID: spi-hid: unrecovered deassert_reset() failure in spi_hid_=
resume()
> - [Medium] HID: spi-hid: improper wakeup teardown for panel followers in =
probe
> --
>
> commit 35d9a38c1b6ffa8dbb3ab740ec9ce120c5b2e7a1
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add panel follower support
>
> This commit adds DRM panel follower support to spi-hid so that a follower
> device powers up and suspends in coordination with its panel rather than
> during initial probe and standard system PM callbacks.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 3b8874ca0e1cc..496b33cdf3d46 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -325,28 +328,30 @@ static int spi_hid_resume(struct spi_hid *shid)
> >               return 0;
> >       }
> >
> > -     if (!device_may_wakeup(dev)) {
> > -             if (shid->power_state =3D=3D HIDSPI_OFF) {
> > -                     shid->ops->assert_reset(shid->ops);
> > +     /*
> > +      * Check power_state, not device_may_wakeup(): power/wakeup can c=
hange
> > +      * while the device is off.
> > +      */
> > +     if (shid->power_state =3D=3D HIDSPI_OFF) {
> > +             shid->ops->assert_reset(shid->ops);
> >
> > -                     shid->ops->sleep_minimal_reset_delay(shid->ops);
> > +             shid->ops->sleep_minimal_reset_delay(shid->ops);
> >
> > -                     error =3D shid->ops->power_up(shid->ops);
> > -                     if (error) {
> > -                             dev_err(dev, "%s: could not power up: %d\=
n", __func__, error);
> > -                             /* Suspend runs next even if resume fails=
. */
> > -                             enable_irq(shid->spi->irq);
> > -                             return error;
> > -                     }
> > -                     shid->power_state =3D HIDSPI_ON;
> > -                     reinit_completion(&shid->reset_done);
> > -                     error =3D shid->ops->deassert_reset(shid->ops);
> > -                     if (error)
> > -                             dev_err(dev, "%s: failed to deassert rese=
t: %d\n",
> > -                                     __func__, error);
> > -                     else
> > -                             was_reset =3D true;
> > +             error =3D shid->ops->power_up(shid->ops);
> > +             if (error) {
> > +                     dev_err(dev, "%s: could not power up: %d\n", __fu=
nc__, error);
> > +                     /* Suspend runs next even if resume fails. */
> > +                     enable_irq(shid->spi->irq);
> > +                     return error;
> >               }
> > +             shid->power_state =3D HIDSPI_ON;
> > +             reinit_completion(&shid->reset_done);
> > +             error =3D shid->ops->deassert_reset(shid->ops);
> > +             if (error)
> > +                     dev_err(dev, "%s: failed to deassert reset: %d\n"=
,
> > +                             __func__, error);
> > +             else
> > +                     was_reset =3D true;
> >       }
>
> [Severity: Medium]
> What happens if shid->ops->deassert_reset(shid->ops) fails in
> spi_hid_resume()?
>
> For non-followers, initial power-up goes through spi_hid_dev_init(), whic=
h
> powers down the device and returns the error when deassert_reset() fails.
> For panel followers, spi_hid_core_probe() leaves shid->power_state as
> HIDSPI_OFF and shid->hid as NULL, and spi_hid_panel_follower_work() relie=
s
> on spi_hid_resume() for the initial power-up as well as subsequent resume=
s.
>
> When deassert_reset() fails in spi_hid_resume(), was_reset remains false
> while shid->power_state is set to HIDSPI_ON and the IRQ is enabled with t=
he
> device still held in reset:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_resume() {
>     ...
>         if (shid->hid) {
>                 if (was_reset && spi_hid_wait_for_reset(shid)) {
>                         /* No reset response: let recovery retry. */
>                         set_bit(SPI_HID_ERROR, &shid->flags);
>                         schedule_work(&shid->reset_work);
>                         return -ETIMEDOUT;
>                 }
>                 /* HID requests would fail while the device is not ready.=
 */
>                 if (!test_bit(SPI_HID_READY, &shid->flags))
>                         return 0;
>     ...
> }
>
> On the first power-up of a panel follower, shid->hid is NULL, so
> spi_hid_resume() returns 0 without scheduling shid->reset_work. On subseq=
uent
> resumes where shid->hid is non-NULL, was_reset is false and SPI_HID_READY=
 was
> cleared during spi_hid_suspend(), so spi_hid_resume() again returns 0 wit=
hout
> setting SPI_HID_ERROR or scheduling shid->reset_work.
>
> Should a deassert_reset() failure in spi_hid_resume() trigger recovery (o=
r
> clean up and return the error) so the device is not left powered on in re=
set
> and permanently uninitialized?

Same as the 10/11 comment; the next panel prepare retries the power
up.

>
> > @@ -1447,6 +1452,108 @@ static struct hid_ll_driver spi_hid_ll_driver =
=3D {
>
> [ ... ]
>
> > +static int spi_hid_register_panel_follower(struct spi_hid *shid)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +
> > +     shid->panel_follower.funcs =3D &spi_hid_panel_follower_prepare_fu=
ncs;
> > +
> > +     /*
> > +      * If we're not in control of our own power up/power down then we=
 can't
> > +      * do the logic to manage wakeups. Give a warning if a user thoug=
ht
> > +      * that was possible then force the capability off.
> > +      */
> > +     if (device_can_wakeup(dev)) {
> > +             dev_warn(dev, "Can't wakeup if following panel\n");
> > +             device_set_wakeup_capable(dev, false);
> > +     }
> > +
> > +     return drm_panel_add_follower(dev, &shid->panel_follower);
> > +}
>
> [ ... ]
>
> > @@ -1523,21 +1618,19 @@ int spi_hid_core_probe(struct spi_device *spi, =
struct spihid_ops *ops,
> >               }
> >       }
> >
> > -     error =3D shid->ops->power_up(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: could not power up: %d\n", __func__, er=
ror);
> > -             return error;
> > -     }
> > -
> > -     error =3D shid->ops->deassert_reset(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: failed to deassert reset: %d\n", __func=
__, error);
> > -             shid->ops->power_down(shid->ops);
> > -             return error;
> > +     if (shid->is_panel_follower) {
> > +             /* Like the IRQ: the first panel_prepared resume enables =
it. */
> > +             disable_work(&shid->reset_work);
> > +             error =3D spi_hid_register_panel_follower(shid);
>
> [Severity: Medium]
> Does calling device_set_wakeup_capable(dev, false) in
> spi_hid_register_panel_follower() after devm_pm_set_wake_irq() in
> spi_hid_core_probe() leave the wake IRQ configured and leak
> dev->power.wakeup if wakeup was enabled on the device before probe?
>
> In spi_hid_core_probe(), if the firmware node marked the device as wakeup
> capable (for example via acpi_bind_one()), device_can_wakeup(dev) is true=
 and
> devm_pm_set_wake_irq(dev, spi->irq) attaches a wake IRQ before
> shid->is_panel_follower is checked:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_core_probe() {
>     ...
>         if (device_can_wakeup(dev)) {
>                 error =3D devm_pm_set_wake_irq(dev, spi->irq);
>                 if (error) {
>                         dev_err(dev, "%s: failed to set wake IRQ\n", __fu=
nc__);
>                         return error;
>                 }
>         }
>
>         if (shid->is_panel_follower) {
>                 /* Like the IRQ: the first panel_prepared resume enables =
it. */
>                 disable_work(&shid->reset_work);
>                 error =3D spi_hid_register_panel_follower(shid);
>     ...
> }
>
> Furthermore, if a wakeup_source was attached to dev->power.wakeup (for
> example via sysfs power/wakeup before async or deferred probe completes),
> calling device_set_wakeup_capable(dev, false) directly sets
> dev->power.can_wakeup =3D false without detaching the wakeup source first=
.
> Subsequent calls to device_wakeup_disable(dev), including from
> device_pm_remove() on unbind, check dev->power.can_wakeup and return earl=
y:
>
> drivers/base/power/wakeup.c:device_wakeup_disable() {
>         struct wakeup_source *ws;
>
>         if (!dev || !dev->power.can_wakeup)
>                 return;
>
>         ws =3D device_wakeup_detach(dev);
>         wakeup_source_unregister(ws);
> }
>
> Should spi_hid_register_panel_follower() use device_init_wakeup(dev, fals=
e)
> (which calls device_wakeup_disable(dev) before clearing wakeup capability=
),
> and should spi_hid_core_probe() skip devm_pm_set_wake_irq() when
> shid->is_panel_follower is true?

This follows i2c-hid's panel follower handling. The wake IRQ is
not armed once can_wakeup is cleared, and the SPI core doesn't
enable wakeup before probe.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-ups=
tream-v7-0-abad13174b43@chromium.org?part=3D11
