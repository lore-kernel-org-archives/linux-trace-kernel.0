Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032454936F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932815; cv=pass; b=Wm2ItKcoJvjTmIRvLxNibyX0SUX7KtYZeL3z8xAzukbyhi5ugC0gNnjDUWdzAV0umOsBjGmIwkLSMCt90wo88pOzalOrct7GKLDtvMAy46Wcedov0xlG09WUzxxUy6HsDC6aYUrdoB/lQvS3fNLrsC+N5KnCEg348t+AlDtxxZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932815; c=relaxed/simple;
	bh=OJKCxitzFX7Devyeo1RMIWQKY4aZ2+94sv/X63QES54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnJV9lZgLy6702prI30ckqGSQU6U3YZisezg9tWvmyl5SEbpbzqsIrRhX+HMCA+NsW88b8JIA7tZ1OKEFRdkulkpzBiaM/UXpk+njGSi4FXaOtQB3yxF0OJW9+UPqIZiIZihcLuHt6SMyWAsHTtOu5JSgAxd29C4kXIGg4FJqZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LhjcfavC; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhjcfavC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b056d58f2aso3863887b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 16:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932813; cv=none;
        d=google.com; s=arc-20260327;
        b=phoCM/41N81OfXm2jgIGiW/PDBhVLdxAwS7YHuZQxydndx+f23gTVyR8LFEChGQNvP
         U7+9ONJGySbxCLOQT6FmybOmlyYESlAx/ncfscCQFsYW38CRWV2MkU8ASI8hAErOwiFA
         z295gsJJcoWCJFWMhYAFI8q+MbI3PLwdB60e5Li4k1Da0SS2tGjq/Qpi1yhAE4IZpzi/
         ARfGWuOUBJDMl/hWmlaDWY67WJMdZ3dk1vlkhgLrZGlxAwjA7EeA3EYjjCpmW048MmK+
         tS3ET3TlkcFIspShW0czx1oSsV7BpJ6jd2tWvNwqcXrrQhXe4y5I++HOwUWs1qCVvQCS
         eRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        fh=0BPENNGSZz95o9+GoSp9+04rhFCxL1hFBiP5E6CoPNs=;
        b=FDz+Y6IA9Pt/UZGwm9mzBs+UV2DDV1rcP/7DMZP0z2SQdDIA8aqcgHXwVDlUrObcAw
         tSgIzk9gniXr46C4ICYJNf5mwhmTqL60hZtAtlBO7YsET8c33TaqqV5i86HxWdAdioXc
         8pRopMYbL7AItk9iahnfF2R/pZhxihW2LaK7W9bxYUTGml6DfpOaqy997Jvwi76mCguz
         XYzs/fysLQsOYkT0fF5m2/h6sTjIzz42KI1BtWjjbKfqVFa9EIoVsGHIAy7aRcqCzPAB
         /BPOgCjdZ+HgdQjzkwO4YBtU0oVK3YpuXrkvkPp6RdAMQIx8vq1B71eVJP8Ht1HE9NxX
         +dyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791932813; x=1792537613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        b=LhjcfavCp9bD3Kt6BHrZPKZfe7C83QVgolYum5AlSX/RQHfYq7ACFgSFfiyOa/MYIh
         g0vbeOCvoXidnwGNuYun4Y0vu65zajMlnhekuDSSZW3gSwbAxqwHNV9YSK8aFT7zDXHP
         LDJJGDFwHjPC3wbXiDX9/gohTj454dcIuMHDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932813; x=1792537613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QntlmUV+IlR8FFxFh/1ODDrw2JuP6ngb9YrJOIy5BCA=;
        b=LSCPa93N/1V77TIvqnO2MJnrBF9z9onOWJGpLWsPcigVJhRlM2THBKVJdS8QDrSPYy
         IrTviN4ceF/vAvxX1+vPWwg2U0qLoEsNx1hj+ficuFzq1zo04RsREu47mqnibO9ZEzhJ
         ciD/cmjILwjX1nyIMI6sUSBifvquzwKfLX4okui3ObU0NbdGU0fcboLPGpMOZdgcUD0l
         0E/WaANg3qD6Dmn6mvWSCeQPhVKyHEGfJFrB9k1gVeH2oigIrZrQ3euiNAG8r25beVWU
         Z4riW0ebnQRw+ht01bgc6aS2aQhzYYo+wBNroC39m6mRM0jx8GOpZCAil9USYT5ZeTgD
         cjuQ==
X-Forwarded-Encrypted: i=1; AKwUvBygASIQs0cr0R5MuJKXwk/ZHLFrnVMOtyykIJxNAIzqHr+/MfY82PU744/WfGTBhrJhyAxRQayb0Wt8p+q7Z0HUY6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhipmVr/wdfuha/q/4MGAnuE302ihQ8rTR9PXiIGIMFoY6M85P
	5uo4pHKW/q6n4nGnN3M1cKLQtspD0yMlW1D8bjCPJfCcPhN2jEuGFSbiLYLAUsRtssg4JouM6Q+
	6I6gorB92gxpUowm6Mjqd0VhKwQkcyEYvjhl9fdxZ
X-Gm-Gg: AYBFou01YEM4NosGXQ1RNS4L7K7TUP4azMw8f0ZowDAeFzKzMmtJCHRW30muOzD4QhB
	51yPkpOW2zSSBsho4nKPu7b+DBcI80YQa40s+Ez++MBU+C3Q1zVn/L9cxOmcmMJqUnhKU8VwfV2
	SMNNyQK94xiVRET84UEi2YXUNBN+TegCQ/GnHxn0T3p8ZqB8vWlZZSz94AFDOjh0Qi759y5quMd
	fGU/C/GNs+CVyzWfKcFYiozuvQ7RTf408WXBC6/jHzmM3aJq89XaLEtgSCdDRW2/aMwDk5sr4gj
	XyGMb307wRQiYGOOsD6RrZ/qg1Eq8pSvjJaoZWbDU0XoOEHMdNqiAeotaXfIzA45LnvTFr6kN4M
	L59iLJeaNQQ==
X-Received: by 2002:a05:690c:82e:b0:8ac:805b:3a6e with SMTP id
 00721157ae682-8b07edb832amr35007727b3.25.1791932813416; Tue, 13 Oct 2026
 16:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-11-384af01da3ee@chromium.org> <sashiko-outbox-166150@kernel.org>
In-Reply-To: <sashiko-outbox-166150@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 16:06:42 -0700
X-Gm-Features: AclHuK_EPiuPXQkmP4djXq_D1z67MVt8XUJL6Sx0kl0aGpRUcTZIlzf43HHn9kY
Message-ID: <CAEe3GZH07w_-Be--FnoVJXvOXtQ4pnjO1T8CMkejVaUFrVC9VA@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] HID: spi-hid: add panel follower support
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] spi-hid: Inconsistent wake IRQ configuration for panel followers
> --
>
> commit 4c8d0ec463c5dbd300c392f3f924992096f8ebc1
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add panel follower support
>
> This commit adds support to the spi-hid transport driver to act as a
> panel follower, allowing its power state to be sequenced with a display
> panel.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > @@ -1577,21 +1676,17 @@ int spi_hid_core_probe(struct spi_device *spi, =
struct spihid_ops *ops,
> >               }
> >       }
> >
> > -     error =3D shid->ops->power_up(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: could not power up\n", __func__);
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
> > +             error =3D spi_hid_register_panel_follower(shid);
> > +             if (error)
> > +                     return dev_err_probe(dev, error,
> > +                                          "Failed to register panel fo=
llower\n");
>
> [Severity: Low]
> Does this sequence leave a dangling, inactive wake IRQ attached to the
> device when it is a panel follower?
>
> In spi_hid_core_probe() just prior to this block, the code checks
> device_can_wakeup(dev) and unconditionally allocates the wake IRQ via
> devm_pm_set_wake_irq().
>
> However, if the device is a panel follower, it calls
> spi_hid_register_panel_follower() here. Inside that function, it checks
> device_can_wakeup(dev) again, warns the user, and forcibly disables the
> capability:
>
>     if (device_can_wakeup(dev)) {
>         dev_warn(dev, "Can't wakeup if following panel\n");
>         device_set_wakeup_capable(dev, false);
>     }
>
> Because the capability is disabled after the IRQ is already requested, it
> appears to waste resources by allocating an IRQ that is immediately rende=
red
> unusable. Should the panel follower check and the potential clearing of t=
he
> wakeup capability occur before the wake IRQ is requested?

This is harmless: devm_pm_set_wake_irq() doesn't request a new IRQ,
it only marks the existing one as the wake IRQ, and the PM core only
arms it when wakeup is enabled. i2c-hid has the same sequence (the
I2C core sets the wake IRQ before the panel follower check).

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D11
