Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792625067;
	b=4qpgN9qgFdLOrLP68C84C/QXGYyHEj85CvJVTPb63dw/FK1sPMd3xWNnVtNkngz7Y2J1
	 0e9zSnw8b3UlquqTJ3Cc0LAtkWbJxHDifGgI0gCem8rZMfR7kCdCgFZS8EDCdS7rM32WM
	 5icoAi/ZzJoxwjas0mWUooaRjBlNxYOvUkle6ozyzQLdf0rdc0pbL+a4d4JAj/X2paqcX
	 YdAdklDH3h1YKsSy9SS/VhqetgkJPMhdXWI3vPCelbd124m3aobYbABJMFGQoZ2374Py3
	 EPqp7RnOOCrOc0yOKCiArm7HZuH4K/VS0YGY/9otQ5wFfJwabRwl3ubGE8yvOLBnMjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
	b=Oo5tmmWblO0vAp5tV/++p/BEIf0zHe25hnr1pcajxTsCugcbJDRCk9PBsbR0wbc5/URo
	 sKotMCErVsehGrFzjuPjwSr4eObxXnr+P9TRTUVXtBIaHZGsFYfAY/JXWOgnl7euuai4t
	 HmqeCJUAp8wzUG/hdO7qgNeiYJotcSe4aMBzaN0uIcWiUbja8VpyIy1nanRcBVAiMP2DJ
	 SsReteXxp2DWQUcd+dHklO33DjW7k5/9zB9w4cbC6fYDwFrBEHo2KsPmJecm2xup1AODc
	 y+QVuLs/7s71IjBcYRaJOVC0PESpylmy066TGgRkbiLX2rpHtLkrIFqTR6DWkmYLYmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLi8y7J2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10087606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 23:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10087606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLi8y7J2
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab43af5e97so4181547b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 16:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792625065; cv=none;
        d=google.com; s=arc-20260327;
        b=gGDpqwsDoe2yKUtqAds39o8cFFJ0389fuy+8MfGBDqRHrW4q+VIytLOo8GwYagGL7E
         VziK/rcjDFond6p79ntxBjoXtRi973djU2nT3FMZ5dBl4XhXtDIgAOFQcUoCyPM/MYpx
         Zjzy0dOyVNaojLU5PQ1rZRenQ74573v6jGO9loVomADnMe8AUiRojvf3cwrFxHr7rZ+X
         T3f+dr2wib5AElNHYR0I5wutp7pbSEi6oXP8mWhXBrUinjr0rjkHOEda7HpTE/S+hR7a
         wDLNV0trudzCyo0ouCw9FhMihtNxXV9QHTJ6QNtAmGyORhyipJiy4rgSMTLyGtXibgkH
         PPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        fh=zEp4ojtJk0JJQrXn91E3q/QSrk9NmG1dMgvJQ9gG3SM=;
        b=tC6h7hBC8mXenENlaeox4BFXAlbXtOUc3Jh7HN8PppV4x4LUq2lOGSzKaNcYLLSnFi
         6xeRrAi8u60z5LINU1lGybaTDBwG3aaY42puhQVP3BiaM0L10RrgSSHZXX5qXivQCcn7
         PTRXBRX2CTVluazCe6NOMdX+YmrKhLv1EkjLJaiW0sAfteZPzfEAhOKtXJVrtKP6G+A5
         ZV8beQ/STU0MQBhYnt1rO97TQaad3INuaPIoK7a3ZLu3TarFZgacFqNIarnYxYkvIrJR
         HrQu928b29sfkQXixkdJgBaAhwUoPfvA+ad5QkUnRK6/FTBmAI4rsoYJ7pEbh4fEX1ul
         i3YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792625065; x=1793229865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        b=oLi8y7J2xgDhdaDp9fFCzXu3oc0F5lPk7JamTcvIw3le8Dw3lMLUBD6Gya+o37DXpE
         UyBfigPn8dmOyI3/uwfbcVVf7J58WFe+Fgp/s64m8mG4IhYwl7IHHJI92+G6kAxadobP
         XVMpG7fBQeNJo5ITGawxn7y6Io6uSkHTGov2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625065; x=1793229865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        b=o7IdmVSqqUQbWz2Evp3+GZkHgymIpC8HQJz47jhUlOheUUufohhS4u9QBc51xXngtj
         zhb0zABVHdyWe+DVJJOLuuTKmtcgjGjBPzoCMBpXKJhDkVaoDRIOFZN+FxlzkVCglbMv
         pZpQZ/7Xwi1ywBauefS92J6q4RkDBYP06or1Boi1YXdgczoqrAChWysV4AVXBBPC4auH
         3bZPR6RERln6R1R96NbjqMQke/HLQOokEBh194UPeKOUhdjH9j3aH9H1zt7bMrVDa8WH
         DXkdboK+j5IaZiuByo1kmxsFctxOZYBCKKxE06V/kzwtVuLviTdy/1kZQl7WmOQa6Sn/
         UkKw==
X-Forwarded-Encrypted: i=1; AKwUvBxlnTL61e4uVOkPOxorSrVNC6NvziXq+bF6duq8V4xlMIAxQsWDTVpWGjq94i/+KDfuQ76VQ/jZnBUdDCIS3Np/2yI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi00W0jvQYVonCUka/KtOfsue0LQyltFjfR6Mz+6oq4WpF/tl4
	IFa4tkcpx6L90Yc85W8MpNyHVJzA0LDpM+PWLKhAqxvv55hPsR/9qBI5EFfBmo4LQ6KW/EtULBk
	bM+APoC/BpCe4cd1cyjNutSqYSNsn+urWPqTToUbf
X-Gm-Gg: AYBFou0/dLIulc1Heq3NFaJzPFqkXJR5MASaZm7HHcOjF1z4h2g4e6S8dypwyJk68Lt
	QrK8aFH9qyZ2Po2gRzZ3bEmyQRVl+moKdzwtaRg6isaK8NDoAHzve+Tthnqh3xRHjls2vvfgB6Q
	p3vDs+trWQYYqtuUShbGIXejaJ7dtSJg3hZlTvjaGOdB4ylfWGOtrJe1zzI35nIJhufG5wAOvUh
	AbK7i9OMS4IOBfCJs5OPLNilqvSWc+xfaK2VFnIQF45jhkLyJQ6PUxx9xmqlC9dlZdsIoK/g097
	NcXWmmGV7iUCOkHKmKS3JxN7QWxnCvihOopMSQd7ydFlI1AUUr69E0TCTAwAyPH/ofSjP7hJix2
	NN33wbvKxaYFlTnYsgTOUGMCUSihDOgIfmdVWPHKgkUsWHMV85N56e8sbhtLktFh2Plk=
X-Received: by 2002:a05:690c:2786:b0:8b0:88c7:f184 with SMTP id
 00721157ae682-8b14551034emr3963617b3.4.1792625064963; Wed, 21 Oct 2026
 16:24:24 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-4-cb9ba4b3d6fa@chromium.org> <sashiko-outbox-178143@kernel.org>
In-Reply-To: <sashiko-outbox-178143@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 21 Oct 2026 16:24:13 -0700
X-Gm-Features: AclHuK8I92dDi-a24-arJkNbKz40DybvKa54bpvCtfeFFEOTon1M-6c-zRbUBhQ
Message-ID: <CAEe3GZG3rHcRtHmg=vB5WdfsQ38Fghi_o80dSnsuaog2_xrieQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] HID: spi-hid: add spi-hid driver HID layer
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] HID: spi-hid: zero-length report descriptor accepted in spi_hi=
d_ll_parse()
> --
>
> commit 9328ec8c48a0b55cf1019d845ec2c37e89f4cdbb
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add spi-hid driver HID layer
>
> This commit adds the HID low-level driver callbacks and device creation l=
ogic
> for spi-hid, handling report descriptor fetching, buffer allocation, and
> output/feature report requests.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 02a7608c4b882..fca7a44eeb9f9 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > @@ -84,11 +185,484 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> [ ... ]
> > +/*
> > + * This function returns the length of the report descriptor, or a neg=
ative
> > + * error code if something went wrong.
> > + */
> > +static int spi_hid_report_descriptor_request(struct spi_hid *shid)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     struct spi_hid_output_report report =3D {
> > +             .report_type =3D REPORT_DESCRIPTOR,
> > +             .content_length =3D 0,
> > +             .content_id =3D SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQ=
UEST,
> > +             .content =3D NULL,
> > +     };
> > +     int ret;
> > +
> > +     ret =3D  spi_hid_sync_request(shid, &report);
> > +     if (ret) {
> > +             dev_err(dev,
> > +                     "Expected report descriptor not received: %d\n", =
ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D shid->response_length;
> > +     if (ret !=3D shid->desc.report_descriptor_length) {
> > +             ret =3D min_t(unsigned int, ret, shid->desc.report_descri=
ptor_length);
> > +             dev_err(dev, "Received report descriptor length doesn't m=
atch device descriptor field, using min of the two: %d\n",
> > +                     ret);
> > +     }
> > +
> > +     return ret;
> > +}
> [ ... ]
> > +static int spi_hid_ll_parse(struct hid_device *hid)
> > +{
> > +     struct spi_device *spi =3D hid->driver_data;
> > +     struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +     struct device *dev =3D &spi->dev;
> > +     unsigned int rsize =3D shid->desc.report_descriptor_length;
> > +     int error, len;
> > +
> > +     if (rsize > HID_MAX_DESCRIPTOR_SIZE) {
> > +             dev_err(dev,
> > +                     "Report descriptor size %d is greater than HID_MA=
X_DESCRIPTOR_SIZE %d\n",
> > +                     rsize, HID_MAX_DESCRIPTOR_SIZE);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rsize > shid->bufsize) {
> > +             error =3D spi_hid_alloc_buffers(shid, rsize);
> > +             if (error)
> > +                     return error;
> > +     }
> > +
> > +     len =3D spi_hid_report_descriptor_request(shid);
> > +     if (len < 0) {
> > +             dev_err(dev, "Report descriptor request failed, %d\n", le=
n);
> > +             return len;
> > +     }
> > +
> > +     /*
> > +      * FIXME: below call returning 0 doesn't mean that the report des=
criptor
> > +      * is good. We might be caching a crc32 of a corrupted r. d. or w=
ho
> > +      * knows what the FW sent. Need to have a feedback loop about r. =
d.
> > +      * being ok and only then cache it.
> > +      */
> > +     error =3D hid_parse_report(hid, (u8 *)shid->response->content, le=
n);
> > +     if (error) {
> > +             dev_err(dev, "failed parsing report: %d\n", error);
> > +             return error;
> > +     }
> > +     shid->report_descriptor_crc32 =3D crc32_le(0,
> > +                                              (unsigned char const *)s=
hid->response->content,
> > +                                              len);
> > +
> > +     set_bit(SPI_HID_READY, &shid->flags);
> > +
> > +     return 0;
> > +}
>
> [Severity: Medium]
> What happens in spi_hid_ll_parse() if the report descriptor length is 0?
>
> In spi_hid_ll_parse(), rsize (shid->desc.report_descriptor_length) is che=
cked
> against HID_MAX_DESCRIPTOR_SIZE, but not for zero. Later in the series, t=
he
> commit "HID: spi-hid: add HID SPI protocol implementation" validates
> raw->rep_desc_len !=3D 0 in spi_hid_dev_desc_response(), but if a device =
returns
> a REPORT_DESCRIPTOR_RESPONSE with content_length =3D=3D 0 (shid->response=
_length =3D=3D
> 0), spi_hid_report_descriptor_request() computes min_t(unsigned int, 0,
> shid->desc.report_descriptor_length) and returns 0.
>
> Both spi_hid_ll_parse() here and spi_hid_refresh_device() in the protocol=
 patch
> only check if (len < 0), treating len =3D=3D 0 as success.
>
> When len =3D=3D 0 is passed to hid_parse_report():
>
> drivers/hid/hid-core.c:hid_parse_report() {
>         hid->dev_rdesc =3D kmemdup(start, size, GFP_KERNEL);
>         if (!hid->dev_rdesc)
>                 return -ENOMEM;
>         hid->dev_rsize =3D size;
>         return 0;
> }
>
> kmemdup() returns ZERO_SIZE_PTR (non-NULL), so hid_parse_report() returns=
 0.
> spi_hid_ll_parse() then caches a CRC32 of 0 and sets SPI_HID_READY, and
> hid_add_device() sees a non-NULL hdev->dev_rdesc and calls device_add(),
> registering an unusable hid_device while bypassing SPI_HID_ERROR reset
> recovery.
>
> Should spi_hid_report_descriptor_request() or its callers reject a 0-leng=
th
> report descriptor (for example, checking !rsize in spi_hid_ll_parse() and
> returning -EINVAL when shid->response_length =3D=3D 0 or len <=3D 0)?

Will fix this in v7.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-ups=
tream-v6-0-cb9ba4b3d6fa@chromium.org?part=3D4
