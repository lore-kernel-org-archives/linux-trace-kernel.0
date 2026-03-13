Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CD195811
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365104; cv=pass; b=hZO+SeCuoQx5JRUMcZtX0r8Co/ZPLlznsWhtriyVAarErvvWdLGfRmNYnIDL+S1pXgNA/+FwcdREEvTwPExBQxeYjYAkN7JP4o7oERDIC/nl8ii6k6WWInkOcs09DSvvSB7tW2v98I3NMVSSVu4jm+FzMXE0qxOFjajNP7gK8io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365104; c=relaxed/simple;
	bh=AC8iYEc4o15iNNkb0ItF7mz3m2i90M9wjDNv6ViuDeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbL7myN5aqeER41ybMKonJD/Au03H/alvDIs8kQXAEcQZ6hIosHYsUMLSjsImMT7gkIXhzknDiIn83YeDvv3Hv8fZDC9H/kxl3ruw8IrsyuXxSuMiSSjoUG+y1MwdAZrX/j3JVz2SRBbF5XYeyrN64AAXnvinSEFIbmptcZICo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IIvsDR9Q; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IIvsDR9Q"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so1896132d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365102; cv=none;
        d=google.com; s=arc-20240605;
        b=ezIFZmkJChwyKZdmzS9jhgJwIJfvub5WeLh165DLWwlosGz7B5zy7KeNsdinw3rtez
         9aHNRbrKuPRvxMZv8Oa/wH2kAnfi/9YGiNtm0cVB6AXW0e+tvuh5D8eg8uce8r44FDEy
         slTNTemPQ/Py+SKY/JNcc/l0O3uqCAN5+d9yRu7x9mnjsYsHRUTQXaiJOZLEPWBjNq0Q
         SDmUTRX91o/Tr8lVPwGxf0eAvJHM8ikJ0x7LNV54A1khDYFfW8vldE6gZ0eou+Ldjy9r
         6oV37aJ5NSRp1BtLH36FMBjFJE4kphFDf77l4uJYVHn6Y0lTnU5N07r1h3uz1zFt8cjz
         oYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KJONc7b7B9S6fez1LPOao3IejHe+L4PGlt2OexMJ13Q=;
        fh=6GddG1O4ytm4nv+SVdde77kV2lOjyuK9tb+XU6IjoAo=;
        b=PBqBZtvAOGWsP4DeeJmei7uquJRAtLha10ArL6tUECldnpdzN2DXlHryUZZgBSUM66
         UjqAo78S3E6grZgTmtYJpp4MjIINUzpJJjYuZOpTwRJd4HFwBq8Y3hmeFb2VXx3hK/CU
         yX+cWRcesRwNJ15Gqe/oSZUEl1wpaaYVouuMjv6/Pcmeg1rTB/+KoNxbf3WYI0qNw0GK
         2J7QoQaMHCzR6fWOv7cu4AJharQJ2wFz7ZHzdRti5te2qdQAtcJHOPyuIX0/MLE/HIn5
         dhdQIWcMq+3bPNFdiNBHvRFgjdrXkagIclPy6D7xgiQsKxAG3Z8UJckkzRpbBlc8D1VZ
         0x8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773365102; x=1773969902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJONc7b7B9S6fez1LPOao3IejHe+L4PGlt2OexMJ13Q=;
        b=IIvsDR9QwZEE4NfmZnX69JUhPC7WrzuveOgIf+rAijV6npFkQ41z7y3Zc3243yyRhu
         Nqr+DRdkmZO2H/4Q2yVxxgcovnMaCp2ZAw6oGHCjImjHE+/HbE1kgcGnJCDlzzrFYQlR
         SiHul3htBaS3DzVl09bYebprmButJxo815rT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773365102; x=1773969902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJONc7b7B9S6fez1LPOao3IejHe+L4PGlt2OexMJ13Q=;
        b=igRkVyfNL9fJ6h1Gpcs09+dcZeUX1chmdvRc0C4GTVfKANcygb41RCYK1iPIRhWwxS
         FyVtm3xXDbkcB7Q4k2AGF36S/6bT4UAZkP0JyEBn9trlPWTdiCvqWOzBJ8kmYI9hGKF/
         b2tkRvAlPEqdX2SqddlqfuNi+gk96ELGHIrs0fzfmvii7U4RO7WaR5I385rJJHMlyuh1
         ZcQKYMc//BxW8T5qwuEh/sYAi/F8o22OVLZoTjaQtsvjPZ7p8VoVj5nxA2IGQhwKikxZ
         R3cd9ih9FClASWVhaIa6UozE7RmlKkvcFvzj2R01MlyWUpfaUgDKqBBFlKedf7iOI4Am
         a7gw==
X-Forwarded-Encrypted: i=1; AJvYcCUWbIJkjc5cSCoRABB6p6wYg7atD7huzMEJ72IgcfueJYFWmFoKSvj+ZZgsCBxNfOxMbu3QMVP+dOiSURrXGYWSLQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLB1cJoXKgEDW7gDMzyK93Ok/76HzGL6XPq56uRcrZDIsEj2R
	BSJsIz/HJnR6VSW/IPNq9Sr+qs3ZYf25rLooou0xWnv11ZjjTljQW1il06UWLA1RdHJlPqixKAo
	0yZZHLRfErUn78VGLOCgapZ4ie3/wUxDY/LkKwriX
X-Gm-Gg: ATEYQzzI9h1TEfH8CaqL3syqsvzA7U/G9OhMX0N/Nncz4lrhc1lXQ8KVxliVrGwWH16
	2uer6UhM0Ib+hvHealAsjRBG3rZMJPkpFGIralMpyVF4LDleErsNhBuzIV89vKhXyw6yCHPUrkv
	YH02/U05xABburwHsvyNgOsk0RZ6Z1gwqiJugDehOpcoYHownuLSNosL7ZFi9i5OaEbiFNkVU+I
	5n891R6Qc2PRO64kMNil0iEpNko7fZsAmvbGwl64QOuIqcaKKYjBU+43La/gxzRTxi9MZfeLbqO
	JF3V+LQU7gF3KRq85QXLrmKjgBpsym7BM+YVQ6a7
X-Received: by 2002:a05:690e:1641:b0:64d:60f2:819e with SMTP id
 956f58d0204a3-64e6308dbcdmr1404345d50.51.1773365102025; Thu, 12 Mar 2026
 18:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-7-1515ba218f3d@chromium.org> <abD6RJZa5D7LN3x0@google.com>
In-Reply-To: <abD6RJZa5D7LN3x0@google.com>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 12 Mar 2026 18:24:51 -0700
X-Gm-Features: AaiRm50satk3IZ5Ra5HOtrIO4y7mdvuWBFwHlLWxp0PismqLqx2sHIfNBl2JX5Y
Message-ID: <CAEe3GZHF9KXPyZbQhr_7qzi2GOpaamnTp7NuFEgmp=hDZ1Lf0w@mail.gmail.com>
Subject: Re: [PATCH 07/12] HID: spi_hid: add ACPI support for SPI over HID
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Angela Czubak <acz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:27=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Tue, Mar 03, 2026 at 06:12:59AM +0000, Jingyuan Liang wrote:
> > From: Angela Czubak <acz@semihalf.com>
> >
> > Detect SPI HID devices described in ACPI.
> >
> > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> >  drivers/hid/spi-hid/Kconfig        |  15 +++
> >  drivers/hid/spi-hid/Makefile       |   1 +
> >  drivers/hid/spi-hid/spi-hid-acpi.c | 253 +++++++++++++++++++++++++++++=
++++++++
> >  drivers/hid/spi-hid/spi-hid-core.c |  27 +---
> >  drivers/hid/spi-hid/spi-hid.h      |  44 +++++++
> >  5 files changed, 316 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
> > index 836fdefe8345..114b1e00da39 100644
> > --- a/drivers/hid/spi-hid/Kconfig
> > +++ b/drivers/hid/spi-hid/Kconfig
> > @@ -10,6 +10,21 @@ menuconfig SPI_HID
> >
> >  if SPI_HID
> >
> > +config SPI_HID_ACPI
> > +     tristate "HID over SPI transport layer ACPI driver"
> > +     depends on ACPI
> > +     select SPI_HID_CORE
> > +     help
> > +       Say Y here if you use a keyboard, a touchpad, a touchscreen, or=
 any
> > +       other HID based devices which are connected to your computer vi=
a SPI.
> > +       This driver supports ACPI-based systems.
> > +
> > +       If unsure, say N.
> > +
> > +       This support is also available as a module.  If so, the module
> > +       will be called spi-hid-acpi. It will also build/depend on the
> > +       module spi-hid.
> > +
> >  config SPI_HID_CORE
> >       tristate
> >  endif
> > diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefil=
e
> > index 92e24cddbfc2..753c7b7a7844 100644
> > --- a/drivers/hid/spi-hid/Makefile
> > +++ b/drivers/hid/spi-hid/Makefile
> > @@ -7,3 +7,4 @@
> >
> >  obj-$(CONFIG_SPI_HID_CORE)   +=3D spi-hid.o
> >  spi-hid-objs                         =3D spi-hid-core.o
> > +obj-$(CONFIG_SPI_HID_ACPI)   +=3D spi-hid-acpi.o
> > diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/s=
pi-hid-acpi.c
> > new file mode 100644
> > index 000000000000..612e74fe72f9
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-acpi.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * HID over SPI protocol, ACPI related code
> > + *
> > + * Copyright (c) 2021 Microsoft Corporation
> > + * Copyright (c) 2026 Google LLC
> > + *
> > + * This code was forked out of the HID over SPI core code, which is pa=
rtially
> > + * based on "HID over I2C protocol implementation:
> > + *
> > + * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com=
>
> > + * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
> > + * Copyright (c) 2012 Red Hat, Inc
> > + *
> > + * which in turn is partially based on "USB HID support for Linux":
> > + *
> > + * Copyright (c) 1999 Andreas Gal
> > + * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
> > + * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Conce=
pt2, Inc
> > + * Copyright (c) 2007-2008 Oliver Neukum
> > + * Copyright (c) 2006-2010 Jiri Kosina
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/reset.h>
> > +#include <linux/uuid.h>
> > +
> > +#include "spi-hid.h"
> > +
> > +/* Config structure is filled with data from ACPI */
> > +struct spi_hid_acpi_config {
> > +     struct spihid_ops ops;
> > +
> > +     struct spi_hid_conf property_conf;
> > +     u32 post_power_on_delay_ms;
> > +     u32 minimal_reset_delay_ms;
> > +     struct acpi_device *adev;
> > +};
> > +
> > +/* HID SPI Device: 6e2ac436-0fcf41af-a265-b32a220dcfab */
> > +static guid_t spi_hid_guid =3D
> > +     GUID_INIT(0x6E2AC436, 0x0FCF, 0x41AF,
> > +               0xA2, 0x65, 0xB3, 0x2A, 0x22, 0x0D, 0xCF, 0xAB);
> > +
> > +static int spi_hid_acpi_populate_config(struct spi_hid_acpi_config *co=
nf,
> > +                                     struct acpi_device *adev)
> > +{
> > +     acpi_handle handle =3D acpi_device_handle(adev);
> > +     union acpi_object *obj;
> > +
> > +     conf->adev =3D adev;
> > +
> > +     /* Revision 3 for HID over SPI V1, see specification. */
> > +     obj =3D acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 1, NULL=
,
> > +                                   ACPI_TYPE_INTEGER);
> > +     if (!obj) {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID input report =
header address failed");
> > +             return -ENODEV;
> > +     }
> > +     conf->property_conf.input_report_header_address =3D obj->integer.=
value;
> > +     ACPI_FREE(obj);
> > +
> > +     obj =3D acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 2, NULL=
,
> > +                                   ACPI_TYPE_INTEGER);
> > +     if (!obj) {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID input report =
body address failed");
> > +             return -ENODEV;
> > +     }
> > +     conf->property_conf.input_report_body_address =3D obj->integer.va=
lue;
> > +     ACPI_FREE(obj);
> > +
> > +     obj =3D acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 3, NULL=
,
> > +                                   ACPI_TYPE_INTEGER);
> > +     if (!obj) {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID output report=
 header address failed");
> > +             return -ENODEV;
> > +     }
> > +     conf->property_conf.output_report_address =3D obj->integer.value;
> > +     ACPI_FREE(obj);
> > +
> > +     obj =3D acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 4, NULL=
,
> > +                                   ACPI_TYPE_BUFFER);
> > +     if (!obj) {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID read opcode f=
ailed");
> > +             return -ENODEV;
> > +     }
> > +     if (obj->buffer.length =3D=3D 1) {
> > +             conf->property_conf.read_opcode =3D obj->buffer.pointer[0=
];
> > +     } else {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID read opcode, =
too long buffer");
> > +             ACPI_FREE(obj);
> > +             return -ENODEV;
> > +     }
> > +     ACPI_FREE(obj);
> > +
> > +     obj =3D acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 5, NULL=
,
> > +                                   ACPI_TYPE_BUFFER);
> > +     if (!obj) {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID write opcode =
failed");
> > +             return -ENODEV;
> > +     }
> > +     if (obj->buffer.length =3D=3D 1) {
> > +             conf->property_conf.write_opcode =3D obj->buffer.pointer[=
0];
> > +     } else {
> > +             acpi_handle_err(handle,
> > +                             "Error _DSM call to get HID write opcode,=
 too long buffer");
> > +             ACPI_FREE(obj);
> > +             return -ENODEV;
> > +     }
> > +     ACPI_FREE(obj);
> > +
> > +     /* Value not provided in ACPI,*/
> > +     conf->post_power_on_delay_ms =3D 5;
> > +     conf->minimal_reset_delay_ms =3D 150;
> > +
> > +     if (!acpi_has_method(handle, "_RST")) {
> > +             acpi_handle_err(handle, "No reset method for acpi handle"=
);
> > +             return -ENODEV;
>
> I would return -EINVAL as we have the device with right _DSM but without
> mandated by the spec _RST.

Thanks! Will fix this in v2.

>
> > +     }
> > +
> > +     /* FIXME: not reading hid-over-spi-flags, multi-SPI not supported=
 */
> > +
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_acpi_power_none(struct spihid_ops *ops)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_acpi_power_down(struct spihid_ops *ops)
> > +{
> > +     struct spi_hid_acpi_config *conf =3D container_of(ops,
> > +                                                     struct spi_hid_ac=
pi_config,
> > +                                                     ops);
> > +
> > +     return acpi_device_set_power(conf->adev, ACPI_STATE_D3);
> > +}
> > +
> > +static int spi_hid_acpi_power_up(struct spihid_ops *ops)
> > +{
> > +     struct spi_hid_acpi_config *conf =3D container_of(ops,
> > +                                                     struct spi_hid_ac=
pi_config,
> > +                                                     ops);
> > +     int error;
> > +
> > +     error =3D acpi_device_set_power(conf->adev, ACPI_STATE_D0);
> > +     if (error) {
> > +             dev_err(&conf->adev->dev, "Error could not power up ACPI =
device: %d.", error);
> > +             return error;
> > +     }
> > +
> > +     if (conf->post_power_on_delay_ms)
> > +             msleep(conf->post_power_on_delay_ms);
> > +
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_acpi_assert_reset(struct spihid_ops *ops)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_acpi_deassert_reset(struct spihid_ops *ops)
> > +{
> > +     struct spi_hid_acpi_config *conf =3D container_of(ops,
> > +                                                     struct spi_hid_ac=
pi_config,
> > +                                                     ops);
> > +
> > +     return device_reset(&conf->adev->dev);
> > +}
> > +
> > +static void spi_hid_acpi_sleep_minimal_reset_delay(struct spihid_ops *=
ops)
> > +{
> > +     struct spi_hid_acpi_config *conf =3D container_of(ops,
> > +                                                     struct spi_hid_ac=
pi_config,
> > +                                                     ops);
> > +     usleep_range(1000 * conf->minimal_reset_delay_ms,
> > +                  1000 * (conf->minimal_reset_delay_ms + 1));
>
> I'd probably use "fsleep(conf->minimal_reset_delay_ms * 1000)".

I will fix this in v2. And do the same for the of driver.

>
> > +}
> > +
> > +static int spi_hid_acpi_probe(struct spi_device *spi)
> > +{
> > +     struct device *dev =3D &spi->dev;
> > +     struct acpi_device *adev;
> > +     struct spi_hid_acpi_config *config;
> > +     int error;
> > +
> > +     adev =3D ACPI_COMPANION(dev);
> > +     if (!adev) {
> > +             dev_err(dev, "Error could not get ACPI device.");
> > +             return -ENODEV;
> > +     }
> > +
> > +     config =3D devm_kzalloc(dev, sizeof(struct spi_hid_acpi_config),
> > +                           GFP_KERNEL);
> > +     if (!config)
> > +             return -ENOMEM;
> > +
> > +     if (acpi_device_power_manageable(adev)) {
> > +             config->ops.power_up =3D spi_hid_acpi_power_up;
> > +             config->ops.power_down =3D spi_hid_acpi_power_down;
> > +     } else {
> > +             config->ops.power_up =3D spi_hid_acpi_power_none;
> > +             config->ops.power_down =3D spi_hid_acpi_power_none;
> > +     }
> > +     config->ops.assert_reset =3D spi_hid_acpi_assert_reset;
> > +     config->ops.deassert_reset =3D spi_hid_acpi_deassert_reset;
> > +     config->ops.sleep_minimal_reset_delay =3D
> > +             spi_hid_acpi_sleep_minimal_reset_delay;
> > +
> > +     error =3D spi_hid_acpi_populate_config(config, adev);
> > +     if (error) {
> > +             dev_err(dev, "%s: unable to populate config data.", __fun=
c__);
> > +             return error;
> > +     }
>
> I would add a blank line.

Sure! Will fix this in v2.

>
> > +     return spi_hid_core_probe(spi, &config->ops, &config->property_co=
nf);
> > +}
> > +
> > +static const struct acpi_device_id spi_hid_acpi_match[] =3D {
> > +     { "ACPI0C51", 0 },
> > +     { "PNP0C51", 0 },
> > +     { },
>
> No comma on sentinels.

Will fix this in v2.

>
> > +};
> > +MODULE_DEVICE_TABLE(acpi, spi_hid_acpi_match);
> > +
> > +static struct spi_driver spi_hid_acpi_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "spi_hid_acpi",
> > +             .owner  =3D THIS_MODULE,
> > +             .acpi_match_table =3D ACPI_PTR(spi_hid_acpi_match),
>
> This is dependent on ACPI, so no need to sue ACPI_PTR().

Will fix this in v2 and remove of_match_ptr in the of driver as well.

>
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +             .dev_groups =3D spi_hid_groups,
> > +     },
> > +     .probe          =3D spi_hid_acpi_probe,
> > +     .remove         =3D spi_hid_core_remove,
> > +};
> > +
> > +module_spi_driver(spi_hid_acpi_driver);
> > +
> > +MODULE_DESCRIPTION("HID over SPI ACPI transport driver");
> > +MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index e3273846267e..02beb209a92d 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> > @@ -43,6 +43,9 @@
> >  #include <linux/wait.h>
> >  #include <linux/workqueue.h>
> >
> > +#include "spi-hid.h"
> > +#include "spi-hid-core.h"
> > +
> >  /* Protocol constants */
> >  #define SPI_HID_READ_APPROVAL_CONSTANT               0xff
> >  #define SPI_HID_INPUT_HEADER_SYNC_BYTE               0x5a
> > @@ -105,30 +108,6 @@ struct spi_hid_output_report {
> >       u8 *content;
> >  };
> >
> > -/* struct spi_hid_conf - Conf provided to the core */
> > -struct spi_hid_conf {
> > -     u32 input_report_header_address;
> > -     u32 input_report_body_address;
> > -     u32 output_report_address;
> > -     u8 read_opcode;
> > -     u8 write_opcode;
> > -};
> > -
> > -/**
> > - * struct spihid_ops - Ops provided to the core
> > - * @power_up: do sequencing to power up the device
> > - * @power_down: do sequencing to power down the device
> > - * @assert_reset: do sequencing to assert the reset line
> > - * @deassert_reset: do sequencing to deassert the reset line
> > - */
> > -struct spihid_ops {
> > -     int (*power_up)(struct spihid_ops *ops);
> > -     int (*power_down)(struct spihid_ops *ops);
> > -     int (*assert_reset)(struct spihid_ops *ops);
> > -     int (*deassert_reset)(struct spihid_ops *ops);
> > -     void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
> > -};
> > -
> >  static struct hid_ll_driver spi_hid_ll_driver;
> >
> >  static void spi_hid_populate_read_approvals(const struct spi_hid_conf =
*conf,
> > diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hi=
d.h
> > new file mode 100644
> > index 000000000000..1fdd45262647
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2021 Microsoft Corporation
> > + * Copyright (c) 2026 Google LLC
> > + */
> > +
> > +#ifndef SPI_HID_H
> > +#define SPI_HID_H
> > +
> > +#include <linux/spi/spi.h>
> > +#include <linux/sysfs.h>
> > +
> > +/* struct spi_hid_conf - Conf provided to the core */
> > +struct spi_hid_conf {
> > +     u32 input_report_header_address;
> > +     u32 input_report_body_address;
> > +     u32 output_report_address;
> > +     u8 read_opcode;
> > +     u8 write_opcode;
> > +};
> > +
> > +/**
> > + * struct spihid_ops - Ops provided to the core
> > + * @power_up: do sequencing to power up the device
> > + * @power_down: do sequencing to power down the device
> > + * @assert_reset: do sequencing to assert the reset line
> > + * @deassert_reset: do sequencing to deassert the reset line
> > + */
> > +struct spihid_ops {
> > +     int (*power_up)(struct spihid_ops *ops);
> > +     int (*power_down)(struct spihid_ops *ops);
> > +     int (*assert_reset)(struct spihid_ops *ops);
> > +     int (*deassert_reset)(struct spihid_ops *ops);
> > +     void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
> > +};
> > +
> > +int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
> > +                    struct spi_hid_conf *conf);
> > +
> > +void spi_hid_core_remove(struct spi_device *spi);
> > +
> > +extern const struct attribute_group *spi_hid_groups[];
> > +
> > +#endif /* SPI_HID_H */
>
> I am not sure if this belongs to this patch or if it should be better in
> the patch introducing the main driver from the beginning.

These definitions were in spi-hid-core.c in the previous patch introducing
the main driver because it was only used in one .c file. This patch introdu=
ces
spi-hid-acpi.c and now two .c files need it so I created a separate .h
file here.

>
> For the ACPI part:
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Thanks.
>
> --
> Dmitry
