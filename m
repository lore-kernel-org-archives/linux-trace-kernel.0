Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D8519DFE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926534; cv=pass; b=RpE0Vl65/UdL0C9I507KehnN42OrUqX6UMbbu5cnma2u4hFW978fugznEVUUHeR3Q/ISMoLUuOXy5pshwTFHiXQxKe/Oyr9lNqoP7NsGlI7w367gvUIdIcLBpkbBQ76qgPabYG0Ff1W+Y+lBfefllmKpHChl7Ax0hi8z6XyY0uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926534; c=relaxed/simple;
	bh=sf30vAcaJ++DLttGm/TNinMSo0jN9WDVolmb3olSr0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYi0zz1JIypMR3Uf6wZG9rBhPqT57P3IkO0uiDzP+2FbbNBcZZ7Ilgg6pKDy4d74T6vPxUQw+XcqRHVL1x044xrIBbzG0sxochBocUrdpkOpuyJ/syU3Q/VF1s//HIaXW7JgiUF/FBG6RAKY0PfFjnR/KHo//xzYCGtsDJCb6+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sc7Gh42h; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sc7Gh42h"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac4806e210so23213137b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 14:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791926528; cv=none;
        d=google.com; s=arc-20260327;
        b=doLWEvKJBUzsZW+cGaBGouOhlINS1/jlnSdjVlK0kc3Hckl0WFyUGc2ONGl+d9fVoC
         fxFof9xyLPV5lx9zjlDImPxCQPhNNDwi+LUt1Taghb8rzrbQHyw2dgl5Mlh5cIRmolI/
         BRoIqqwEgWHPFyzH0oItcBJsRaPoBm5pXMvcD7IidFmgT85ypT2aP2KesuglymXw3oxS
         ATYzmMPsj05h75kcFd1Srbuxe3xhO1x/KHEyutwmBF/IjndmKkcSgbWmRzkcoRWzKgbR
         gAJwBEnrig2jDRLw97P/XWpefoCX/0outDyiBXPycJokA8iT2tFIu8uPeuy4AUQWY6JY
         tgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        fh=FYjNaWoXSKWTcy8lNVRCvhGlyyXYxYQuuk+R4l2a5gk=;
        b=C5phmGgQzI9mnuk2tlJSbMViZwIWg9p4rA+CNtrgSJYz6qL2/Yfj0s2zYMlSkgNZCw
         fZXdd4B+8nmLsb2RM2U80UvT21pwbLCf45XdbUFjbRQ5HE97WzpYrxl5kLcJqB/HyJVQ
         ++UsAJ+jCko+JCpTPuxmqAKTO4zq/YokBfVZsN4pkRraEKQWLSae7L02+05272z/ugo0
         p/xN3RUKJlxVrrFVFZZMkMz51PfWVFw2GmaytIJuHckKrGXgK6nUIEDwM9hRhSXxfmUn
         SzslaZJeRWBz/qwOUASS/S8UTJ62o1rXncPqMJAldqwx2s6XRkdK3lVFc5cruqC94lsx
         tf2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791926528; x=1792531328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        b=Sc7Gh42h6n0xBIW4jv8fFKe2zdPNW4uXbZLoU5mw34wx0S3tlmBSafIcAzh8tu4VIY
         pxY4mnOzgzmsLdfbyD+0t+6K2HKAO+hmJo//Gbu3+q5hLA8dVMikUJXaPWatgWbxA8eT
         M2J/XqcIQK3Fs3L+autqFqU2gzYUQXCbygCic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926528; x=1792531328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tW1MH59A22+8G0RbZ3B3dj8ln/Mz2H51o5N7Shhczv4=;
        b=yQpKj1bLNzDUgcwjVKc22xCeEA4FE4f+Dy8/nF0TuBY+fVTihrekYFECEjUaoKRDxj
         tSUndS1TA81X4H2WVXFYkGOe37c9jH4NzGR6fAzPgCsZJs7T2fI8mSKaSxeBb5Tir6oo
         NfZuqe7x/dy0kvGk+JINzvifFhQg3zkrU1nr1Ws9fNCYKC3EcRcGvkFuXNfAdbg6pR3s
         3CtKtIQ7cMey8LvgpgyQZQQDTrebRDDglE3n1yQeL3VJ5UTpO2ChkS/LXaYNqWOem+oX
         XrL9DGNl+X+SLiiTzMAgt++/uk9ExE+oHqTC5zU9fGh1k6t5vj1oIkDWaJblAf8GLYD+
         3snQ==
X-Forwarded-Encrypted: i=1; AKwUvBwz6k1JX7zNlBMhrErzuU9esOXBPUH7zB3LjhlaSh8XlqcFWO414l+iACH8oe40l3eOv0wQ4CPpSb07A7X9qItnOzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3/kWKPI7QVw1pJeWlIeebfiFQk/b2GVt469NgdWGjC2ahUUOV
	kNmyCcsZAgL2KL7oJ8ypyMDNBnhRYfDbo1PrP/irIfgpg9xBQ00qd8O/NLfNXzs6ClcPzzipRWq
	a+P5quGAaC3AhRYT7a7w4F6zD1YtFXOtDaXL0S1JY
X-Gm-Gg: AYBFou2QZDUUq7g7+vsjDRIuhx9OBcNZT8PQ5WbfmMZ/PRzulQzxig6OtTNmiQE7vG9
	cyd+KO+7MuDEYE6gBrf+Hoj8sacVVWC2eC+RI2M0rUaFVuPTyWkGIV/KRRQG+7+H1sH1oSm3PGo
	98Hll6kG4qZGkYS9EC6fAIpWk9WKotiUSnt3jUDYKzJcW7rIu/DgfdFyI7Aub+9d1lYGUmxSJbY
	JUgRg8O4lHibEHy2gAkn6HmMtGS8JJGfCZS8LOVp8KTho1CTmddnYQfZymAcXTsdxDhMHZfDMxI
	kNtNVWGlMszOM1hYt6Nu5cEKnW+sn7BDb9ixZEFmmXsxkdVpBhqI9z0DV8VnoFDt/8wM8zvsqfl
	dVbVwoPwpFA==
X-Received: by 2002:a05:690c:4d4a:b0:887:f4fc:ee35 with SMTP id
 00721157ae682-8b07ed1fb6cmr47618147b3.19.1791926528330; Tue, 13 Oct 2026
 14:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-4-384af01da3ee@chromium.org> <sashiko-outbox-166154@kernel.org>
In-Reply-To: <sashiko-outbox-166154@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 14:21:57 -0700
X-Gm-Features: AclHuK8vj_2CnW3lS7fdTlkJRR8RuhSwUE7H_CFag_-G2v-URCUG4IFSzD-lQgw
Message-ID: <CAEe3GZH-QD4vj71c2AR6Y0VFhchBARBctYtfmur07nrgK5xBWQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] HID: spi-hid: add spi-hid driver HID layer
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] hid: output_report callback sleeps in atomic context
> --
>
> commit 954a3684cea1bad33a85c00ff6725f7553c75027
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
>     HID: spi-hid: add spi-hid driver HID layer
>
>     Add HID low level driver callbacks to register SPI as a HID driver, a=
nd
>     an external touch device as a HID device.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 02a7608c4b882..fca7a44eeb9f9 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > +static int spi_hid_send_output_report(struct spi_hid *shid,
> > +                                   struct spi_hid_output_report *repor=
t)
> > +{
> > +     guard(mutex)(&shid->output_lock);
> > +     return __spi_hid_send_output_report(shid, report);
> > +}
> > +
> > +static int __spi_hid_sync_request(struct spi_hid *shid,
> > +                               struct spi_hid_output_report *report)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     int error;
> > +
> > +     reinit_completion(&shid->output_done);
> > +
> > +     error =3D __spi_hid_send_output_report(shid, report);
> > +     if (error)
> > +             return error;
> > +
> > +     error =3D wait_for_completion_interruptible_timeout(&shid->output=
_done,
> > +                                                       msecs_to_jiffie=
s(SPI_HID_RESP_TIMEOUT));
> > +     if (error =3D=3D 0) {
> > +             dev_err(dev, "Response timed out\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +     if (error < 0)
> > +             return error;
> > +
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_sync_request(struct spi_hid *shid,
> > +                             struct spi_hid_output_report *report)
> > +{
> > +     guard(mutex)(&shid->output_lock);
> > +     return __spi_hid_sync_request(shid, report);
> > +}
> [ ... ]
> > +static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
> > +                                 size_t len)
> > +{
> > +     struct spi_device *spi =3D hid->driver_data;
> > +     struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +     struct device *dev =3D &spi->dev;
> > +     struct spi_hid_output_report report =3D {
> > +             .report_type =3D OUTPUT_REPORT,
> > +             .content_length =3D len - 1,
> > +             .content_id =3D buf[0],
> > +             .content =3D &buf[1],
> > +     };
> > +     int error;
> > +
> > +     if (!test_bit(SPI_HID_READY, &shid->flags)) {
> > +             dev_err(dev, "%s called in unready state\n", __func__);
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (shid->desc.no_output_report_ack)
> > +             error =3D spi_hid_send_output_report(shid, &report);
> > +     else
> > +             error =3D spi_hid_sync_request(shid, &report);
>
> [Severity: High]
> Can this code sleep in an atomic context?
>
> The HID subsystem requires the output_report callback to be asynchronous =
because
> it can be invoked from atomic contexts, such as softirqs for LED triggers=
 or
> force feedback.
>
> Both spi_hid_send_output_report() and spi_hid_sync_request() acquire a mu=
tex,
> which will sleep. Furthermore, spi_hid_sync_request() blocks by calling
> wait_for_completion_interruptible_timeout() in __spi_hid_sync_request() w=
hile
> waiting for the response.
>
> Will calling these synchronous primitives from the output_report callback=
 lead
> to a scheduling while atomic BUG and cause a kernel panic?
>
> > +
> > +     if (error) {
> > +             dev_err(dev, "failed to send output report\n");
> > +             return error;
> > +     }
> > +
> > +     return len;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D4

Not really. HID core doesn't call ->output_report() from atomic context
(LED updates are sent from a workqueue), and as noted in my reply
on the documentation patch, USB-HID and I2C-HID already sleep in
this callback too.
