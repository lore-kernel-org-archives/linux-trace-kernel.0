Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD35540AE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930377; cv=pass; b=Ch02QqaAQzT2RRTfq99/8q9zy6jcQ3VDBAs4+V5A4K4U5jnyHUI/7ejGV7pFfdiMuVEzH9yRUnvpHTDxlzOCee5TeSCHKHpj2MS/aOBC6qmeYyySYUrP6X9i+C0UWY9FHS/9cvplUudg6RrsUJDI/3EKviDx4YUAWmdrE2Ts9B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930377; c=relaxed/simple;
	bh=LHKyaN6WUugoUSp5MeLqyUxtlolwPgBXkaD5KlRFm9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCtWwfPgcnl/vGY24fIOhLPR9KoBULnqMNVleS6qdcbW4cTMAPgZXxEaPvLgSPPXeCC3hL2LPV8lpFVrF3L60VIUbwqCOIYphkxnzG3udc8AmQrrIJBZIvuxFBX1gzdnP+ur5E++wpN9BE+6jrxiTPrG1L/TGb0jdztQRuIm5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C4/6EXUW; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4/6EXUW"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac525c1f05so4764217b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 15:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930374; cv=none;
        d=google.com; s=arc-20260327;
        b=I8ntNbgX9TNr/4CyJcsfsFx6rvzUaIEJpkMv1XhWUI7RTBLK0jLjPd4kvFZrmk0Icd
         aMERTJoe2o4jHbMS9n8rgBZF3skrt1irGl2XZorfQrKo45U9UHR4erwVaEixgoA017uN
         YFUN4NAWjf/3Z018UllXq5nv6JCf/mFtjl/0lKRUbOnDaZKZpCKGR8iTq0t9LBoFrdZ1
         MUxN9QE/K9mAtbssvrfQrGRmOD1YOSZCEytma57byGj8Z2UXPRo44JPgdvrBUbBFo+9l
         LSFmDqQtTaTyFCOGQ6aaCndHBOKKc+kh0rxyh1wZFd9sznWE8pb4ydRCudxzBzDCwDBu
         vJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        fh=pNviALZ0qihkuEXLfZN6DAISAFjQSdKrta5YEju+w9k=;
        b=Xl4dDuKtmB6BznprRKislojI2XCuKAehOiGk3Q9LY41Kj3WRJEI2q3VacfPoY3VyAy
         y0vajc3Zu+nzgH9UXmETRLDRS7mhN5oL2xpWZmBSvMyTzHe0e89Qc5GTb98kj4mm5TfQ
         Gt8ex9r4uQZtTddxzTCYdqLKGeQZmcdHVrMz8wUXe4sYi6YAJXue9nC7dgnSxwf9+RkB
         2p+AZDYU9y59+AMZMBv6z6obgRuNBbvAPGPyKmikM/yF1aVktFXj+bgKyvHFTcrTEvF8
         rxsj1K9JWJeVVp86ZAwLuYN0fwP7w2I3MxP8z8l6F1ktJFrbYP1PsD1ewC5fJI0XM0TT
         SFmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930374; x=1792535174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=C4/6EXUWLqwBThAGo1onKkHW2BxZrd15xJmVGIULHYLY1nPFF5hv2mrrYcUkuA7RR8
         IhUjXjBsCxcolz6CV0dg8XhSVmMve/TAn8Iev1d7tXkENPi2R8sDAr89/T1YBI130YKh
         IcS6Ly+tY/cTuvFj2Cbai7MhyVANyndbphs84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930374; x=1792535174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=CJ6l+d+sQy/onQpxkrIeFpEucmSJW+ZoN0S6FWCBLq2acRjzkCNPW9oCWsEGJD5LG2
         pyw1UTfptqyBOOuuYY8YJ2KGGBVJ2mHRipqalvsKlVnISHkSl/+RKmbP6LwC1WlQlk08
         WUcGdTusS+IpfT3/Prixq0OSCR+ulR+Q5f344Vle+bkxDMjl/US/26VJ7MzNNbZ+ug1p
         z/1kraJ2DVV4N3v8ovCwT2c4quLJoIRrW2iNHmO8hgPfT+1bD/pwSQue9d+LnYybigUU
         h/PsMAe/H485RtbLBz8Ze+Y2LJ+czftAxujLizdw1wYqBit7Fky4LcuQfSCznG3tiWS3
         96Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwNcnZ/Gt/8boaSn3YCiiziOHrAJuXbs2XEeJ9RHwYvHa0H0AnNdLw83y5ba64tfQ7z64+CaQxCVxzeshkwHJTdwmI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPohVv2GPBSXIhs5Xogb8qs1wvLbMPi8Q6mv8QA9BTGQjA1epA
	BBLqBIjEH3+piZi43A2PUsNIC+s5Y6B7Z36pmF7QLiDrlzt9b68nSiMEucEzPtUvTq8j03KtMjK
	0o0nMf8/mF2SIUD4fHiyahpveRkiIL1e54B1+S2S5
X-Gm-Gg: AYBFou2VcuWhNkQQD6Xzy+qb56nZLlH6SnGCfDPeWEqpeOtERBTvARt+UzRKA16qiOS
	bierno+HJU0iJxcsJQVu3Yut/gq7SbO0pwfpZUe7YDiy86Zpy8aJs7Eeu+iILdJ1F8pwrBra3nT
	9EbSiSWOIjkJ74LVW9sCcit4e0xs0lX96UJaIrzTl7S4iFFnThHWrk1mPRDAbdy6XP0JEiZUT13
	04yYNpTMNDd5J6zpQMASotwzRoj2EdpYAfwxCid+eaioIx2iHzuADyRGVBu6TY6rC6qFeDgAi7B
	+2UBdq4Xyb9Pgwr8wEi9+Rbl/vi3hW+OhOfnLhiw/QMb/ajE9WR+OXTgARCyIFg3fAD4jnKlYeb
	GsXWb7IKJfQ==
X-Received: by 2002:a05:690c:39a:b0:8ae:8877:9ef6 with SMTP id
 00721157ae682-8b07edcf6f8mr55863427b3.10.1791930374515; Tue, 13 Oct 2026
 15:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-8-384af01da3ee@chromium.org> <aszWnnc6RR9d5SYw@monoceros>
In-Reply-To: <aszWnnc6RR9d5SYw@monoceros>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:26:03 -0700
X-Gm-Features: AclHuK_tyUehVA205WXB_Og5y1P8AMIMPFMlhjQ2Y9FOhmh_U9e-FbL8LEin36M
Message-ID: <CAEe3GZHB_mDcdz3gcoAzOu6mO7ua3muESOJcaZi6Z45Q8J77rQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] HID: spi-hid: add device tree support for HID
 over SPI
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 5:49=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Oct 09, 2026 at 10:25:33PM +0000, Jingyuan Liang wrote:
> > +#include <linux/mod_devicetable.h>
> > [...]
> > +#include <linux/spi/spi.h>
>
> Drop <linux/mod_devicetable.h>, the spi header already provides the
> needed *_device_id with less dependencies.

Thank you. I will drop it in v6.

>
> > +static const struct of_device_id spi_hid_of_match[] =3D {
> > +     { .compatible =3D "hid-over-spi", .data =3D &timing_data },
> > +     {}
>
> { } please

Will fix it in v6.

>
> > +};
> > +MODULE_DEVICE_TABLE(of, spi_hid_of_match);
> > +
> > +static const struct spi_device_id spi_hid_of_id_table[] =3D {
> > +     { "hid", 0 },
> > +     { "hid-over-spi", 0 },
> > +     { }
> > +};
>
> Please use named initializers and drop the unused zeros.

Thank you. Will fix it in v6.

>
> > +MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
> > +
> > +static struct spi_driver spi_hid_of_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "spi_hid_of",
> > +             .owner  =3D THIS_MODULE,
> > +             .of_match_table =3D spi_hid_of_match,
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +             .dev_groups =3D spi_hid_groups,
> > +     },
> > +     .probe          =3D spi_hid_of_probe,
> > +     .remove         =3D spi_hid_core_remove,
> > +     .id_table       =3D spi_hid_of_id_table,
>
> Very inconsistent alignment of =3D, if you ask me, just use a single spac=
e
> before a =3D.

Will do in v6, thanks.

>
> > +};
>
> Best regards
> Uwe
