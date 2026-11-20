Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214184;
	b=qapg5MiY44kb4g3A5alYIuqzkTEeVA5ImEruoUt+XGwgxa8d48F3nKxCf6EKkdznoY34
	 iphlcY0fLW+2OvRq+hJeKx4IlH0mVMETUtfHPe+mGyOc6JaieEgEyGrlgFw5wB/k8LwMu
	 Hs4V4CbaWVhkx7L7a5JeYTu52kx0RGfNnNsa9psbcwXCrcvp7UMW7y49vkd3HoLSztul6
	 y7PBqOlUdgChAmxG/YKSsOj2KzUrmG9ztNAakU8Px+MFwRaq4/ZzhS1lc12DSkfuge0Vp
	 O3RzCgiFFvM/Br5A/3zfk52rLwFfckfhhxlhk/LA7op4fMBnbcKXt5IlZWwkj87bqMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
	b=4yTo9fqP+4aacuIa2haef74RvJPjdcRINcO0yoLawZPuMRQ7pdApyD6JMPp/Nlzq1cYD
	 3mTDAFDxaO3fRxoPhmaLPyqceZeZeqKr4uSQ34C3asUTLJE9Z/Rwcqdc3IKI0ukHlKNFC
	 S2CwqrIL/zFsMP04ukhYZ0CrdJxuLurVTVJiehj0AqOAoaaMP4qcBCnyJ1lCwr6WdeTLx
	 kCmiKt5NSagz2hqjRLoTVCVLaNfll0rU0t1G0ZnPK4S9FyNbqO/KRx38KSndyaxPnsJ6h
	 e1dhpKGMQJSKhzArpWb8qq7IM5y7FoKPKcVhNPEk7zbQJSEZzC2YUMCxEXsA6suVBfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="eRRP/wob";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7C606A684
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E7C606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eRRP/wob
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b4d86f5328so10165157b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 14:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214180; cv=none;
        d=google.com; s=arc-20260327;
        b=s3r+iES5er0yf/B2ZJNnois46u2jnMyZPC1zqQYoiB3bZ76a3xO2sjO4yQnxx1DmNq
         URbVGGr6KQg4YKegtDqX3slO0NR9KpZHSGrVD7x7f8TiuDq723VjflKrW6KbBhj05FPP
         xovOi/XZXcaR5EGGUqg0ewb2yPLzao+zj9k6D18QKAzkS0j3A1kqcXHPKJgJB2IrWmFX
         meAdvWmbui7/nV4hA2L3pgXUji6Q47Gj+jCHDI+NQKKJEnGPLfv6xo/pbutZrZNquiG5
         JW4+7WoteOSI1U/FgWiNRSOeZfXfw+3o3GadcSpBo/m63PutX/1ZMJZnBCdWu+UNqgoV
         7S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        fh=2owyRyEkWVbjwU7stjOrC4BErPCPrZdy8U38qvXF3R0=;
        b=lrS+Q+/2TdCCbZVG/6k6sLC5sgUZ9C24rmdcf5TCpT2VR7ECJ3wD794K6RsuLbJ1RK
         iLIkRFSqzbmD3cGbK81Fcv0+55CO/CYhd8wLpWojYaOnLEp5dgRtNtjR7QsMoUR95lzH
         MZsCE/B76a+LzZCKVvw0eWgL79S8KAl4IvPq1d0FbjrXHmlS3J9hNEkF093a259+nbHy
         40bD7qOGKCb0u3cvhVIcgMsEDXjWUM4FH18j22YGJqfRcYWrQWlD5a1B/XfcAiEO9N/k
         vNMhlppxH+r7ZEJTx+lKVGtfhAZmOl8++DW6h15qDME9kQ7cJiQlT9uFgrlFiFsVrjQQ
         SdDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795214180; x=1795818980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        b=eRRP/wobXJsITiQgwsuDY/DjVunwMvvWHB85pcB9gVCy7jztOH8pY+CbLv82/7Pdfy
         AmW9MnMAweg8pQ3eF3ZsvbkqBBRV+3sH9RWiwZ1JxlyHoKht12tMnzVRkBGKPjs6vBL7
         /0EtvKedEhSr+Fe3XjtOuSHiEG10trzsvsTHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214180; x=1795818980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        b=Wb/IM9LKq82ycI+Ddzzu+7SURU03ID9hSqKXHnIMQtYpD5rvb11jeDUvcsd/qV1DiI
         e1aMDx59KJT8xijEhhEAMwRrg+jMJIU+7jQOO0nYOpr9r99nJhzuPHXhT3JTbp10S9Xp
         6dSARUNw3oEnSYMI73KHji/tLE6M8xpSXzvhNjk7WYEkc5z8z36EVJDdI0QbxS5PUmn1
         1pjOPYTGMLi2c5hqkdb+O1DbwEdInVyxl9sMnwLXEoecsuCwIzfYIfJaX4tduZa2lOM7
         1ttkkfc1pzA+O63e3j1PnEHiKf7NQyxila1B/6dLkHF9bDea8rKcGtxgQbW4vlcEHq4h
         aA/A==
X-Forwarded-Encrypted: i=1; AL+hErGfWcE2+nLtxL+i0cafmuuOQB04QIXjgJy+tbqjIqtYeHMDyxQHznvzAOxH7CxQesp2LUWKDbzG6psG43eOGkNpEwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZrLOViOhrSFKBHPP5Ditr5q5iERRx9WOkoFdjbDL1MQ9ZEp84
	mXuZNL5pBjDMmq5MEyXvJy5BrsbOGDuXinjl88bjf240rG6uqSlBrraZtOQ289Tqth6/BO9/ij6
	DXQaLrowe/EgYxZeXNRMHK5BvwWNFsp5vkflw40hMcd88whHX6d1sJg==
X-Gm-Gg: AZFdTZeSW8PLtD3SMPMIaKZRVOOiVbSu3BaCGTHHHesDaSlqy7Kn6c86kT9uZr/xY2L
	7EZxkx3Ko3RhBkiafLVDgKLWF7RuNBuwa4xt0RMo0j+782ewGhQMJZVxBpU47fmArnNM2qsjW4O
	TySDdOEtjJD0znF0ToCzlSE64aTjXEV+odLjkPBLrOIfv5kIEgBIM+9Xz7acSWdfmMCcmMGMm4i
	hfp9Pm5u0j3F30nJYC1ly0d3tmCW131Ppz94CLPa/Z5c5HJjgX05t1j7PAaT0CPj5UkiWvO2NLW
	zBlmYZJa+K/1/Ddv7mlDp1JraqsrUQv6nY2qxIJhGmm3OifQbRzimasBCgnEdUscwtxPVuWXuAC
	+tLO2/4HoO/5CBMO11gl3lpGXhfVNiwDs8TDNCuC6oaLYX5dpC7XpHi7AMtRbxMNf0tQ=
X-Received: by 2002:a05:690c:6b09:b0:8b3:33cf:1fd6 with SMTP id
 00721157ae682-8b5204da8cbmr22654577b3.46.1795214180401; Fri, 20 Nov 2026
 14:36:20 -0800 (PST)
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
 <20261024-send-upstream-v7-10-abad13174b43@chromium.org> <sashiko-outbox-183486@kernel.org>
In-Reply-To: <sashiko-outbox-183486@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 14:36:09 -0800
X-Gm-Features: AclHuK-uqG9_uXU3EVhPHyRTDXChIzvp0O_bkgQvn7hhRNcrLduMWOI_Cxiv4hw
Message-ID: <CAEe3GZGLP5PtW1HD1R_wm6+WeUf=7pVbCb3iKbihorEKy-4VkA@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] HID: spi-hid: add power management implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] hid: spi-hid: unhandled deassert_reset() failure in spi_hid_resu=
me()
> - [Medium] HID: spi-hid: race and missed hid_driver_reset_resume() in spi=
_hid_resume()
> --
>
> commit 9bd51942caad3c04cffc9fdd14002340e1980586
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add power management implementation
>
> This patch adds system sleep power management callbacks to the HID over S=
PI
> transport driver, handling device power down, reset synchronization, and =
wake
> IRQ setup across suspend and resume.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 4ff93d22715cd..3b8874ca0e1cc 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -231,6 +239,147 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> >       }
> >  }
> >
> > +/*
> > + * Wait for the device descriptor response after reset; the device the=
n takes
> > + * requests. Set READY here: the report descriptor check that normally=
 sets it
> > + * needs power_lock, which callers hold.
> > + */
> > +static int spi_hid_wait_for_reset(struct spi_hid *shid)
> > +{
> > +     unsigned long timeout =3D msecs_to_jiffies(SPI_HID_RESET_TIMEOUT =
+
> > +                                              SPI_HID_RESP_TIMEOUT);
> > +
> > +     if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
> > +             dev_warn(&shid->spi->dev,
> > +                      "Device descriptor not received after reset\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     set_bit(SPI_HID_READY, &shid->flags);
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_suspend(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +
> > +     /*
> > +      * Stop reset_work until resume; pending steps keep their flags. =
The
> > +      * IRQ stays on so a request in flight gets its response.
> > +      */
> > +     disable_work_sync(&shid->reset_work);
> > +
> > +     /* HID driver suspend may talk to the device; responses need the =
IRQ. */
> > +     scoped_guard(mutex, &shid->power_lock) {
> > +             if (shid->power_state !=3D HIDSPI_OFF && shid->hid) {
> > +                     error =3D hid_driver_suspend(shid->hid, PMSG_SUSP=
END);
> > +                     if (error) {
> > +                             dev_err(dev, "%s failed to suspend hid dr=
iver: %d\n",
> > +                                     __func__, error);
> > +                             enable_work(&shid->reset_work);
> > +                             /* Redo a schedule_work() dropped while d=
isabled. */
> > +                             schedule_work(&shid->reset_work);
> > +                             return error;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* disable_irq() waits for a running IRQ thread. */
> > +     disable_irq(shid->spi->irq);
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     if (!device_may_wakeup(dev)) {
> > +             if (shid->power_state !=3D HIDSPI_OFF) {
> > +                     /* Device is fully reset on resume; drop stale st=
ate. */
> > +                     clear_bit(SPI_HID_READY, &shid->flags);
> > +                     clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
> > +                     clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> > +                     clear_bit(SPI_HID_ERROR, &shid->flags);
> > +                     set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> > +
> > +                     shid->ops->assert_reset(shid->ops);
> > +
> > +                     error =3D shid->ops->power_down(shid->ops);
> > +                     if (error)
> > +                             dev_err(dev, "%s: could not power down: %=
d\n", __func__, error);
> > +
> > +                     /* Held in reset either way; resume resets it. */
> > +                     shid->power_state =3D HIDSPI_OFF;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_resume(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     bool was_reset =3D false;
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     enable_work(&shid->reset_work);
> > +     if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> > +             /* Stay off; only balance disable_*() in suspend. */
> > +             enable_irq(shid->spi->irq);
> > +             return 0;
> > +     }
> > +
> > +     if (!device_may_wakeup(dev)) {
> > +             if (shid->power_state =3D=3D HIDSPI_OFF) {
> > +                     shid->ops->assert_reset(shid->ops);
> > +
> > +                     shid->ops->sleep_minimal_reset_delay(shid->ops);
> > +
> > +                     error =3D shid->ops->power_up(shid->ops);
> > +                     if (error) {
> > +                             dev_err(dev, "%s: could not power up: %d\=
n", __func__, error);
> > +                             /* Suspend runs next even if resume fails=
. */
> > +                             enable_irq(shid->spi->irq);
> > +                             return error;
> > +                     }
> > +                     shid->power_state =3D HIDSPI_ON;
> > +                     reinit_completion(&shid->reset_done);
> > +                     error =3D shid->ops->deassert_reset(shid->ops);
> > +                     if (error)
> > +                             dev_err(dev, "%s: failed to deassert rese=
t: %d\n",
> > +                                     __func__, error);
> > +                     else
> > +                             was_reset =3D true;
> > +             }
> > +     }
>
> [Severity: High]
> What happens in spi_hid_resume() if shid->ops->deassert_reset(shid->ops)
> fails (or if was_reset is true while shid->hid is still NULL and the rese=
t
> times out)?
>
> When deassert_reset() fails in spi_hid_error_handler(), the driver sets
> SPI_HID_ERROR and schedules shid->reset_work because a device held in res=
et
> will not assert a reset-response IRQ:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_error_handler() {
>         ...
>         error =3D shid->ops->deassert_reset(shid->ops);
>         if (error) {
>                 dev_err(dev, "failed to deassert reset: %d\n", error);
>                 set_bit(SPI_HID_ERROR, &shid->flags);
>                 schedule_work(&shid->reset_work);
>         }
> }
>
> In spi_hid_resume(), however, a deassert_reset() failure only logs the er=
ror
> and leaves was_reset false. Because spi_hid_suspend() cleared SPI_HID_REA=
DY,
> SPI_HID_RESET_RESPONSE, SPI_HID_CREATE_DEVICE, and SPI_HID_ERROR before
> powering down, shid->reset_work is not scheduled, spi_hid_wait_for_reset(=
) is
> skipped, and spi_hid_resume() returns 0 when !test_bit(SPI_HID_READY,
> &shid->flags).
>
> Similarly, because spi_hid_wait_for_reset() is gated inside if (shid->hid=
), if
> shid->hid was not yet created before suspend and the post-resume reset ti=
mes
> out, nothing sets SPI_HID_ERROR or schedules shid->reset_work.
>
> Could this leave the device permanently held in reset with its regulator
> enabled in HIDSPI_ON and no recovery work queued?

No. The next suspend powers the device down and the following resume
retries the reset.

>
> > +
> > +     enable_irq(shid->spi->irq);
> > +
> > +     /*
> > +      * For devices that may wake up, process work that was pending wh=
ile
> > +      * suspend had reset_work disabled. Otherwise suspend already dro=
pped it.
> > +      */
> > +     if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> > +         test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> > +         test_bit(SPI_HID_ERROR, &shid->flags))
> > +             schedule_work(&shid->reset_work);
> > +
> > +     if (shid->hid) {
> > +             if (was_reset && spi_hid_wait_for_reset(shid)) {
> > +                     /* No reset response: let recovery retry. */
> > +                     set_bit(SPI_HID_ERROR, &shid->flags);
> > +                     schedule_work(&shid->reset_work);
> > +                     return -ETIMEDOUT;
> > +             }
> > +             /* HID requests would fail while the device is not ready.=
 */
> > +             if (!test_bit(SPI_HID_READY, &shid->flags))
> > +                     return 0;
> > +             error =3D hid_driver_reset_resume(shid->hid);
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
> [Severity: Medium]
> On the wakeup path (when device_may_wakeup(dev) is true and was_reset is
> false), how does hid_driver_reset_resume(shid->hid) interact with a pendi=
ng
> reset_work?
>
> When spi_hid_irq_error() sets SPI_HID_ERROR or spi_hid_process_input_repo=
rt()
> sets SPI_HID_RESET_RESPONSE in the IRQ thread, SPI_HID_READY is not clear=
ed
> immediately. Instead, SPI_HID_READY is cleared later when shid->reset_wor=
k
> runs spi_hid_error_handler() (which must first acquire shid->power_lock) =
or
> spi_hid_reset_response().
>
> Because spi_hid_resume() holds shid->power_lock across the entire functio=
n,
> scheduling shid->reset_work and immediately checking test_bit(SPI_HID_REA=
DY,
> &shid->flags) means:
>
> 1. If SPI_HID_ERROR or SPI_HID_RESET_RESPONSE was set while SPI_HID_READY=
 is
> still set, spi_hid_resume() sees SPI_HID_READY set and calls
> hid_driver_reset_resume(shid->hid) right before shid->reset_work runs and
> resets the device.
>
> 2. Conversely, if SPI_HID_READY was already cleared (for example, after a=
 sync
> request timeout or while SPI_HID_CREATE_DEVICE is pending), spi_hid_resum=
e()
> returns 0 early at !test_bit(SPI_HID_READY, &shid->flags). Once
> shid->reset_work later completes in spi_hid_refresh_device():
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_refresh_device() {
>         ...
>         /* Same report descriptor, so no need to create a new hid device.=
 */
>         if (new_crc32 =3D=3D shid->report_descriptor_crc32) {
>                 shid->reset_attempts =3D 0;
>                 set_bit(SPI_HID_READY, &shid->flags);
>                 return;
>         }
> }
>
> it sets SPI_HID_READY and returns without calling
> hid_driver_reset_resume(shid->hid), leaving the HID driver in the suspend=
ed
> state set by spi_hid_suspend().
>
> Should spi_hid_resume() coordinate with pending reset work on the wakeup =
path
> so hid_driver_reset_resume() runs after the reset completes?

This requires an error or reset response to be pending at resume on a
wakeup-enabled device. Waiting for reset_work here would need
restructuring resume, since reset_work also takes power_lock. Leaving
it as is for this series.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-ups=
tream-v7-0-abad13174b43@chromium.org?part=3D10
