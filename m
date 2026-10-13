Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D15625EC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929717; cv=pass; b=bXoLPW/2/ZEgfQeZx1RtYjObjxntxOd5sEw/O4OXlQXwqat0Icf16Rm6G3E0R+/5WM+7cjwHALhSHRItf7scp3skmZMrNihBU5NS4Q0V8nsEmWcpbL7pajukp0UbN4b9zxNMnJNTEJ3k0z4KwHhLyVGSh+eLhq/XT4SsvtbbSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929717; c=relaxed/simple;
	bh=YoOftzpeEReVb6O4VclP/t8iOYPrrpNMFEoppDguHGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKE5z+OUVTCddU2GizGseswIdOyWE1JBhQVG1beoC2CofMIlKoHGULwq4VEiVergGovBQhwcyp77lqzDLS5+yc82tttVlEr6QjxW0jgUsZ7jWecS5sGwFb4fZY9mL6YdCoP8MIlTn8xesbgADTVq8h1OTWUQMajnnjqgche9n9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CU2M3KlD; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CU2M3KlD"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0af2aae63so18064477b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 15:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791929712; cv=none;
        d=google.com; s=arc-20260327;
        b=QG0Zdx3V2NLLwoALf6bvMmm/6CsRHozCr9Aq4YapRsrSzWhoSASp5JmeyymdMyyhMN
         rnkcb+qxAlP7LT1dH6t9bdLggDqrwKot4+X9F3euUAPWeRfMEms5HXqXCZkyMTIGiYj7
         hvJIi05ZFGDDK1qmzoIM/cB0V4I+6BRPVNlQoQFONpIsohFaopJbhPI0kaKTzJMzZDTC
         dnQxRW/Go1PXvp1fKvhyXFMfKiEPB0ZJLN+tb49Qn/6m1mLtbwY3383SennVqrvaGXo/
         3q/ygSYWWsfPd7OlaV+ZClMrivRi5Uc2ZjNys5p51CRoLsceXu/AuYIup2s60L18GbWN
         OJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        fh=tehU+3uincTAOzDW6UOv2LCjG3nAbfj+YA0xcnHxv+g=;
        b=QeITsqVH1dfgMPDXN9vGN4Y/llg8WiE3SLnwgKvMfFEW9yCC/vW8cOyNMsEbQ1jkiJ
         HwznozJuHfcqdyq2R0pLwrA+p+z2Y87qRh2hHP1yIPXTP+M44sKS+0NKlpPoNZlM5oaN
         yOUPcsc3qRFrOCeLpZ1Zkq3y/bPrc6RfNDMvY02BuvaKYGvE+S5HFDWCOxwOCoV8bo2T
         TTZzMgDws/iqJvgzKkjSafXXZO5Ay9xhqAJKMOS02fwUHVaUgqX2/G3uGkpn/rFey1dU
         O2z0/kDGcMh3ZtNaNYZyttE+XMXN2n6JxweEt77IrAONFWAl/pP6yM8iTdPUYosPsejM
         1Adg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791929712; x=1792534512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        b=CU2M3KlDWGShhDGLsvVmNHaag52sVAPgnsl/46rX4qmt6Oq5kdhpnE2Ya2eqYjeKAl
         nqoIYb2uYCDSy6x6hc0GVKf0hy99xPkaUTbhAOx4fojhEw+lm/yYy/l9joKVl39iSRwp
         MOANNDIM2El7Nbfv1Of3F4DOG75+7iqqBEKUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929712; x=1792534512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu1pMEg3izEfc/rQ67eSbYz040q7y2e9OLH8nvi7wBU=;
        b=TUVwOw+AR/QjBmkOxb+NvEWKBOf7kxzpmGcYJ3M5d+TJaT4S4R27H1QqWJLhGoJKkB
         p4IcRyp1k57aKSs3z1ZyryHA+2dT4YerNbo2VznrvFcD49ay2CJYnh1h7neeyh+oAc72
         VoGP2EVyFzLB2ru0WDC69Wv7Hsdopy+Z2E9yU4Nob9yOWM6J27O3pJU/m8rfMYX2SVHu
         R03V+yftqxIyGnvmJ+jSGSVgevpU7XBEIZl37YbKE0twEUp/kJGBwrw0zHZT1q8h8mIP
         pzLTVz9QIww4+gLjF+3nxfYQpugJTtlzSij8uT259jhd7JF8YS4FPbfKGaXh7LKwm6E7
         cjyg==
X-Forwarded-Encrypted: i=1; AKwUvBxB08RXIccW3ogDBk73ATcI1aFwo/iS36tG6SSua3yrchEnUtyZ7kdgbxWCnFJbiecJ+lyIEeoUlLP15W7N4O3AdHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3v0d4teO9c+sCmYpxZTW118SF6SQXwVwtWnizxmGE1jQwXH+L
	cK27096CcB0Y1X7UjJfA8GYyUmpKjJ9vLmBw93CYZ7lTfsu2MDsOVf1/RAobtc7FOvR3nA5loCC
	EtBDCcN7VgUPzctyPL/tNalwpnV6Eb0jVIu0VTZ2KmQrp4iaKOECUlA==
X-Gm-Gg: AYBFou0njx2eMx5XaTZ3+cFDD2AWcEZ5yVdWKlc+TnvyapEAcTg81QN72h+kHDhEUIa
	MQjpXRVl3cFJjFImo7sM+2xd6oqMd3wOZCbEd1f6qc+uC8QregJDjnFzFlNxP0wFYFYW4EYvrlL
	IKKhaSk2TUfmA0fsIac5aYv0pmSIOaEgONd4UnySMGKXEfZZn6hkpa7F3A1M9+uaxIpDct+ARka
	+4AqlJ/oOABULbEZRwAgffdAslFOhdYSeJIj6P9f6vpWw0i+jjIumINZuTu+F83JCPdkbocsnng
	WkonB6S/o9msSdUVmRD1KD7lKJNn6svhVzNxxZT6x8OJJkyzhIJLWaY020T38xkqQBbtC8ELOwJ
	YTNZZWYe3Eg==
X-Received: by 2002:a05:690c:e1d9:10b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b07ee80677mr35220177b3.56.1791929712213; Tue, 13 Oct 2026
 15:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-7-384af01da3ee@chromium.org> <sashiko-outbox-166152@kernel.org>
In-Reply-To: <sashiko-outbox-166152@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:15:00 -0700
X-Gm-Features: AclHuK8LY0flPJXmLlCRmm3TtT6hKXqXYTxefNgnCBXeN5jvcX9L7jCw_bXXSqQ
Message-ID: <CAEe3GZFCEBXTQqGw+JdppYm7hCwuoBTXuAf104ru5nArKwes9A@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] HID: spi-hid: add ACPI support for HID over SPI
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] spi-hid: data race on bus_error_count in spi_hid_error_handler
> --
>
> commit a262e333d16eb58c8aa593f81c7497790c2b01b7
> Author: Angela Czubak <acz@semihalf.com>
>
> HID: spi-hid: add ACPI support for HID over SPI
>
> Detect SPI HID devices described in ACPI.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 83678e6835818..f4e9b4e1294ed 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -327,8 +303,21 @@ static void spi_hid_error_handler(struct spi_hid *=
shid)
> >
> >       shid->power_state =3D HIDSPI_ON;
> >
> > -     shid->ops->deassert_reset(shid->ops);
> > +     error =3D shid->ops->deassert_reset(shid->ops);
> > +     if (error) {
> > +             dev_err(dev, "failed to deassert reset: %d\n", error);
> > +             shid->bus_error_count++;
> > +             shid->bus_last_error =3D error;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
> Does this introduce a data race with other updaters of bus_error_count?
>
> Userspace sending an output report via __spi_hid_send_output_report() che=
cks
> SPI_HID_READY locklessly. If SPI_HID_READY is read as 1 just before
> spi_hid_error_handler() clears it, the output report path proceeds to acq=
uire
> io_lock and invoke spi_hid_output(), which updates bus_error_count on err=
or
> (under io_lock).
>
> Because spi_hid_error_handler() updates bus_error_count here without hold=
ing
> io_lock, both threads can execute shid->bus_error_count++ concurrently, w=
hich
> can lead to lost increments or torn reads via sysfs.

This is harmless in practice: bus_error_count and bus_last_error are
only debug counters shown in sysfs, and losing an increment would
need two failures at the same moment.

>
> > +             /*
> > +              * Without a successful reset the device will not send a =
reset
> > +              * response, so no IRQ would trigger another recovery att=
empt.
> > +              * Retry from here; reset_attempts bounds the number of t=
ries.
> > +              */
> > +             set_bit(SPI_HID_ERROR, &shid->flags);
> > +             schedule_work(&shid->reset_work);
> > +     }
> >
> > +     /* Balance disable_irq() above; a retry disables it again. */
> >       enable_irq(shid->spi->irq);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D7
