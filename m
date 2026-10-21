Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792621009;
	b=yzu31pyu27PcsAQa/9hbwTLM9g6jweQuS3XF9p5Ud0hctrSYHkErm44HJDuDCiLtSU+r
	 AQAZvxytuGFZwhDq5LJ77wN4qjK+eayPOfrXpbHHNPKrJEPx4XQ0r+w7wfxQOKZpZgL89
	 BpLRkNvDV48tyh1giEBf7Yo5QOJDVkwQR5gAqmJPspLVvml7VOiQhgJpjjbyVeAuUHoMd
	 hC1nb4zChL/3MxyuWyKSxMRWwddJzMQL/zW8J8tj+02HQvdwKD+leQnigYD5zOba1q7/6
	 lQyG4Mp9wxz84gvovgRuvDFgKpkmuER4OGlBBMGTo8f0oEcSQ/U+DZ4VSeJIKshP+lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
	b=4I9peHmlntDv+PmlXdXqXlurNLqRIXuxKtQTHaIpI+i3cuQzNDSUZnutlM7eokYwO4qr
	 0x/b9+xdfpInVFU9NPh6VEJ1frfbpn8iHnlo3PMT+ksqe44CSmTyNjk53rcaGF3YD6UX0
	 7YOZtwS+HDAKf6WOXebSzG5jhPuDvJQoih0VyE/v1zT2Xv0Awmkztzd6Qf9reucbV9mDa
	 kJew9GUIcGHIEbFic8iGATEti/SK7S0lPEdDsfmp32GcmOIwU881bu+4EHNkfn4H0pIpN
	 v524GrUkWjzLU5bATIilzcgIk/Fbcc1anKWpx0pC9VwhTwJ30vc5Ki7Gk2hQ2W/yeyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pp3zPBI7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B9606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pp3zPBI7
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67921b515a7so1176243d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 15:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621007; cv=none;
        d=google.com; s=arc-20260327;
        b=rvqxqAYHJHrxQzAiD6+sP8c4a1P73U0JN0OeajwOY4ZW9r+1DpWuSsqDPPuUHpZHRH
         A9Nbc2GaAZMpV+IJLABnsgqlSWobM+CnhWc+gm+pZhM26Q24gNOaFxUS6xFntgEjo48D
         2LW9MxcBIA4OEqsHTPMDRtkD+WznwNugNFVhw0/bvwvqQacjoBsDrx1oAXsCSpnxPJBt
         Qo7NQq9WZ4XAgmqo9lw8xUn+531/ntOVetOsZemfvytmswadqE4cWXPiV1z3a7nqNyCd
         YmXGs2hc+UXb6tgIkmP+yQ9qkSa7w8+Vns3hEbz6on0kjfKH3AghXoQH0wNfzxMy1qsr
         KlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        fh=VV8AU9BAL5eV+8jHxXV4GUpePNSyPH5HxPY7S6i2qbo=;
        b=VbOR2neaniS4LRCY031jbL/oYPI0xrJYxFFL2pJPVVzbp9FDt2840Ur+ra7IFQu07r
         +KZe71fQ6h5bxX1ei8Lz62Vas5IhhUPwxaLsOt3H1tR+yxuNal+CPfZJtEIor2IcSO1R
         kE8fB2yGgAr4763hoDAOdPvTF+8WMNLHnvpZTRNStgZsrbii/5yolBQCFf0pH0+E0bz3
         1Q8OGTIeN66wDSDnge6/3SqVNcfA6QbOyHHY3m91eB8g5Tc6YMFE6iwSJYzhjKZT+cwM
         y/YD3uhSrp/dLa8eAafw5VWUrZE7bQe8/p0Plda7QNdhG7+MBxRs1K2XZRdzhd2wquXy
         3Vbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792621007; x=1793225807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        b=Pp3zPBI7GONExxATnfQd52OQh2njdUvt29F7MQp/AEVn70HzNcoaPB4/yDg8KSOeLq
         7wfrAe7ITktoLrUPAlRn2bXTEEP+lCh5VC3UG57EE8x/1HrBVgZUuwFgvxtiwwCITWnx
         k3x6DEkwQMjRO/7/TY5b4wQnKs0Yrbk+/XvFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621007; x=1793225807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        b=2iSEpKTux38cyegbygbb8tqVfTC/O/g9E0CJdKEF3goxKXTynRXuAcIkUY3mpP1yAY
         XvulxHUTvHICz5bgfQ+QEdlKoGzIyLIsYvMk7qTP7t4UBUsjrPDQt2eJPyML/urxUZVt
         sCXJ2+46PW6sYXs/1NT5KY58JDLxQorenVgO6+5IzKhsikcniGBoBMHyYJTgLdVgyTuC
         L02qk/A0CUPk39wJN5GZmWnEdEfg0GFB7wNyPixyibZXQroWtND3QX8npmTlNTUiWnBm
         wNvLiNF+vd1FWrJ6qRmf8lg3V+yJzg2FFaMcBdL8FdQxijlw/084cD1XXcPxr8jYVkmC
         vLkA==
X-Forwarded-Encrypted: i=1; AKwUvBz6em1QF4DCZzIYrATpactqAibslm9+RhEMJXwMpLsiFx+sNYNZTUYhnMtpEh3fp5IbNeCn5U2D5gC+Wjv6eNheJeM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFCp4Tt3Ktrj5vu69mZdbV8A3My0RX4jj09OCitFELCnFKX+bx
	s6PcVqivlvKUZdIjXng21mcwSjl5yas3vLcwvZIcNOyzzeR/sqwFdiWhdfJBaBJAtXUlQcj4bS0
	o88HAOYPcAtYkiL/H17ZnfzN6in/LSaX+kKi2IKNf
X-Gm-Gg: AYBFou0xPdfRLzTFnBwWDELB4xJ+IFdEGBQm7Dq+5Ve4mpSHamEDYfzSqfWXFHWEmYN
	JIgt4dpaMIvwlKMs/cOyNlF3LXdlUm4t/7roxhdxgwBv8kcoc9dh/AR3MZyBqPs4q2GxpzaCGQ4
	L5H1XPxbG2Pa0R7pm95rzCIPcShB76fdBl1xsoRzJMEEeVI5/ERqGYRT5UrlLQ+BRvc7msxtLav
	RR6avSjZf80mJWo4sWMpFUAHz0U2CX28szyuRTjOZ2QVUUWTf4c1X7oJqoZdVozyI1unzmTZuzt
	rSbLr9NUr206F4dEacfrzLlyqrDTJ6FOGEOMlWOVm7lHYhUAGVGYSWPbcP3bVuU91VgTCvAFey9
	/zQryvnQcYKnJ8pxTlzF7LqL4pQVuj3jij0sxHfJks8WozS8WXaTAkcfv4SVkDfnbUg==
X-Received: by 2002:a05:690e:14ca:b0:679:938d:a5e1 with SMTP id
 956f58d0204a3-67a0e5d5717mr1652923d50.106.1792621007076; Wed, 21 Oct 2026
 15:16:47 -0700 (PDT)
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
 <20261019-send-upstream-v6-3-cb9ba4b3d6fa@chromium.org> <sashiko-outbox-178136@kernel.org>
In-Reply-To: <sashiko-outbox-178136@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 21 Oct 2026 15:16:36 -0700
X-Gm-Features: AclHuK97y_1C_fXZ7yRJHnp3ya3ECqu5ReTQG8sTLOF0eRq_fLLRwG53TU5NjZo
Message-ID: <CAEe3GZGsfB+zi3Qf6buPWP_3hkw9bsd4mB=PtBrp4irtM5Z0zA@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] HID: spi-hid: multi-value sysfs attributes and missing ABI docume=
ntation
> --
>
> commit 4c66f3d16c395b79d0997b29357fb80b5a6f2708
> Author: Angela Czubak <acz@semihalf.com>
>
> HID: spi-hid: add transport driver skeleton for HID over SPI bus
>
> This commit creates the spi-hid directory with its Kconfig and Makefile, =
and
> adds the initial core driver skeleton including basic device structures,
> sysfs attributes, and probe/remove functions.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > new file mode 100644
> > index 0000000000000..02a7608c4b882
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> > @@ -0,0 +1,213 @@
>
> [ ... ]
>
> > +static ssize_t bus_error_count_show(struct device *dev,
> > +                                 struct device_attribute *attr, char *=
buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u (%d)\n",
> > +                       shid->bus_error_count, shid->bus_last_error);
> > +}
> > +static DEVICE_ATTR_RO(bus_error_count);
> > +
> > +static ssize_t regulator_error_count_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u (%d)\n",
> > +                       shid->regulator_error_count,
> > +                       shid->regulator_last_error);
> > +}
> > +static DEVICE_ATTR_RO(regulator_error_count);
> > +
> > +static ssize_t device_initiated_reset_count_show(struct device *dev,
> > +                                              struct device_attribute =
*attr,
> > +                                              char *buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u\n", shid->dir_count);
> > +}
> > +static DEVICE_ATTR_RO(device_initiated_reset_count);
> > +
> > +static struct attribute *spi_hid_attrs[] =3D {
> > +     &dev_attr_bus_error_count.attr,
> > +     &dev_attr_regulator_error_count.attr,
> > +     &dev_attr_device_initiated_reset_count.attr,
> > +     NULL    /* Terminator */
> > +};
> > +
> > +static const struct attribute_group spi_hid_group =3D {
> > +     .attrs =3D spi_hid_attrs,
> > +};
> > +
> > +const struct attribute_group *spi_hid_groups[] =3D {
> > +     &spi_hid_group,
> > +     NULL
> > +};
> > +EXPORT_SYMBOL_GPL(spi_hid_groups);
>
> [Severity: Low]
> In drivers/hid/spi-hid/spi-hid-core.c, bus_error_count_show() and
> regulator_error_count_show() format both an unsigned error count and a si=
gned
> last error code in parentheses ("%u (%d)\n") into a single sysfs file whe=
n
> userspace reads bus_error_count or regulator_error_count via spi_hid_grou=
ps
> (which is attached to .dev_groups in the later ACPI and Device Tree suppo=
rt
> commits in this series).
>
> Per Documentation/filesystems/sysfs.rst, sysfs attributes should export o=
ne
> value per file without custom formatting or mixing types, and new sysfs
> attributes should be documented in Documentation/ABI/.
>
> Should bus_last_error and regulator_last_error be split into separate sys=
fs
> attributes (or moved to debugfs), and should Documentation/ABI/ entries b=
e
> added for the attributes in spi_hid_attrs?

Will drop these attributes in v7. Already reported via dev_err() and
tracepoints.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-ups=
tream-v6-0-cb9ba4b3d6fa@chromium.org?part=3D3
