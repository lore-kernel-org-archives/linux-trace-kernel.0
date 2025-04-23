Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45A269D03
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Apr 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404683; cv=none; b=NAfI4v9cyzzwBPhxKHJVuvQOCBVAGyezMEvwjc7lQIlS/LW9W4sMwi9fPOkdubuEVLCFfte1NovOpsij4yOM46pnlNAr5ZHEB1nx2TFmhl0yep02v2hbP14lgHkEeBysM1g+/Kk6oXaHbw1PxKwH2NGt/u/TOgB67FYmD6fLM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404683; c=relaxed/simple;
	bh=VlJ6l36mUYdPTIGA6HQD18C8S3lIffZdBM1jUeIZ/nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSgwKQoNR3m6EPEMXZvXdH90uhqNof1pzBuH0PUzBOGhc7huSNzmchrc2fgL0BTx3q2KbuEY4teRSc7CPbkV9b+gnUZ5hD8AWmQ2zxOJou21/AYZfkGZWzSeqfd2l2NOxaUdsf+xdTpt9N1NXjsrcq0HSyNgDHCpQp9JlxUK99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/cn6WKF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/cn6WKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745404678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VlJ6l36mUYdPTIGA6HQD18C8S3lIffZdBM1jUeIZ/nA=;
	b=Y/cn6WKFGu0JlLZ5yWIB1Rnll576A8h5yOpZazbo7W8tLq49fgi4D8/p18MgiYJdBCAwmi
	rcqeoCjcKTVlatelILMQjdsSvOVTLihBcMjWUUjnGZC15W/viSuHDqZ8P45oDGQgoA8gsx
	vOZ0QCYlqbaUBvH4pOLv8Z3Ysi7ONVo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-zT23DCXHPYqYyUoLqz9l1w-1; Wed, 23 Apr 2025 06:37:56 -0400
X-MC-Unique: zT23DCXHPYqYyUoLqz9l1w-1
X-Mimecast-MFC-AGG-ID: zT23DCXHPYqYyUoLqz9l1w_1745404676
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32b08so2788963f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Apr 2025 03:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745404676; x=1746009476;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htvOdbbPBWJbiuZ26CDOd+VnDrAoFDfKKaGFmsTk4b8=;
        b=GrUzdjzaQMjSUMwuhNuFghBft7smY+t4UyDtjwtKCtBr5RcQXq4ipex+jXKInFjmxX
         CzdU/2KVw/pdw1vYZdyv/1537ILXq2n4tlwWWK/r+ZuVW40ZD9FkgHZh1jQhRFRgS44v
         qWsERtm8GGqgwYxuNW50D0hh87CTrs8OJ9jR3jwSdc0pGirK8qzHij9nSd9U7u4uDUOI
         iJ7Fdi6x9DKmhAFk3ReE3hUN4o4WApnbfCQXpeUmIO8aVN19SwbRHtQCGMbmCTeMWs+L
         +6FtDIgVLVTxiXMs6m9HGUVGPsyt1Vw4wTOiqWzfRoEUUKBGHQZ+VKfWnwFqAU+ipW0g
         2qZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNmv4zduJ8Cla3BJCozo+iQJF3pVFQscU+OS86ZYmkUWX7DNprR1NjXUol8IMC7BvoasUuAu1yt+fbQupG0pdVvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7JRDL1/8BpITAE+2RXZx7vHePfyFXjdC4d3/86KmfXbITkkC
	GPj3ijUsZ+FN8AFalXibtNwBF6FCQSMW3ohtWaiNpgHK2hG3k/m1k66GFabKh+CXYVHYVARDR9A
	Lt9NsYbtof53loOaYFL11ZMkCdhEpKojUUJEHSjv+mFiLwzUsf582DpV0s/muEOs0TRDGyw==
X-Gm-Gg: ASbGncvVGrEF9MGlTbfNCD+vDu7IKPOu/+BhSzAH4fNs00Y6esJzG6C0HtUysFakRXN
	/mg3U4wO3Gc44Q8GbQNBWZdYBfoItKOUqYo3dSyVYYl7UolY1BezBIkiy7A1I9xAMug/j6cDjEP
	UIehZW1WAwG3MdoP3sptYXzQ+I5Wz58D+J7c2YE10SBr77CnzJs8ZXy7s14/l3yrOLqxy7H/DLU
	VOIkfqiCtKaj+DJLO2nnmYiidtIZlZTqgZhTaJvWVQR0lU8euQkssQ39W581GfM4/6bt67k4Mri
	oM6cRykb5662ZO/QDIP7YOiXWo7jvHmYr863zw==
X-Received: by 2002:a5d:64c2:0:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-39f175ba69fmr6143801f8f.11.1745404675786;
        Wed, 23 Apr 2025 03:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCW39oL+DTOq34k/J8w9aq68eyfD5vKWVHY8SgLjQZi5WLtsz5YNU1V68pZbV8+BR4U4+dxw==
X-Received: by 2002:a5d:64c2:0:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-39f175ba69fmr6143780f8f.11.1745404675397;
        Wed, 23 Apr 2025 03:37:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433141sm18478248f8f.35.2025.04.23.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:37:54 -0700 (PDT)
Message-ID: <02f047788f369cd0387d2934fa99fe3e8e1913c2.camel@redhat.com>
Subject: Re: [PATCH v4 19/22] rv: Add rtapp_pagefault monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Wed, 23 Apr 2025 12:37:53 +0200
In-Reply-To: <2eff7190ba245eb157f95ae461fef54183d07665.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
	 <2eff7190ba245eb157f95ae461fef54183d07665.1745390829.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OwedKyPE4rIbhAhzmF2XZl2yb-jnsJ-pVTgH0Xcs9Eo_1745404676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Wed, 2025-04-23 at 08:50 +0200, Nam Cao wrote:
> Userspace real-time applications may have design flaws that they
> raise
> page faults in real-time threads, and thus have unexpected latencies.
>=20
> Add an linear temporal logic monitor to detect this scenario.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/pagefault/Kconfig=C2=A0=C2=A0=C2=A0 | 11 +=
++
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0 | 82
> +++++++++++++++++++
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.h=C2=A0=C2=A0 | 57 ++++++=
+++++++
> =C2=A0.../rv/monitors/pagefault/pagefault_trace.h=C2=A0=C2=A0 | 14 ++++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A0tools/verification/models/rtapp/pagefault.ltl |=C2=A0 1 +
> =C2=A08 files changed, 168 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
> =C2=A0create mode 100644
> kernel/trace/rv/monitors/pagefault/pagefault_trace.h
> =C2=A0create mode 100644 tools/verification/models/rtapp/pagefault.ltl
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 5c407d291661..6f86d8501e87 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -42,6 +42,7 @@ source "kernel/trace/rv/monitors/scpd/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/snep/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sncid/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> +source "kernel/trace/rv/monitors/pagefault/Kconfig"
> =C2=A0# Add new monitors here
> =C2=A0
> =C2=A0config RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 9b28c2419995..353ecf939d0e 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_RV_MON_SCPD) +=3D monitors/scpd/scpd.o
> =C2=A0obj-$(CONFIG_RV_MON_SNEP) +=3D monitors/snep/snep.o
> =C2=A0obj-$(CONFIG_RV_MON_SNCID) +=3D monitors/sncid/sncid.o
> =C2=A0obj-$(CONFIG_RV_MON_RTAPP) +=3D monitors/rtapp/rtapp.o
> +obj-$(CONFIG_RV_MON_PAGEFAULT) +=3D monitors/pagefault/pagefault.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig
> b/kernel/trace/rv/monitors/pagefault/Kconfig
> new file mode 100644
> index 000000000000..b31dee208459
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/pagefault/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_PAGEFAULT
> +=09depends on RV
> +=09select RV_LTL_MONITOR
> +=09depends on RV_MON_RTAPP
> +=09default y
> +=09select LTL_MON_EVENTS_ID
> +=09bool "pagefault monitor"
> +=09help
> +=09=C2=A0 Monitor that real-time tasks do not raise page faults
> diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c
> b/kernel/trace/rv/monitors/pagefault/pagefault.c
> new file mode 100644
> index 000000000000..ff7df49871b2
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/rv.h>
> +#include <linux/sched/deadline.h>
> +#include <linux/sched/rt.h>
> +#include <linux/tracepoint.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "pagefault"
> +
> +#include <rv_trace.h>
> +#include <trace/events/exceptions.h>
> +#include <monitors/rtapp/rtapp.h>
> +
> +#include "pagefault.h"
> +#include <rv/ltl_monitor.h>
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct
> ltl_monitor *mon)
> +{
> +=09ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
> +}

Mmh, you probably already considered that, so ignore my comment in that cas=
e.

I just realised this function would tell you a PI boosted task is an RT tas=
k,
is that acceptable in your model?
It's probably a configuration mistake on its own if an RT task following th=
ose
rules shares resources with non-RT tasks not following them, but if that's
something allowed, you may see this atom change more often than you'd like,=
 not
sure if that can be something worth noting.

Perhaps you could add a comment saying that this is not a problem and why (=
e.g.
instead of using rt_or_dl_task_policy for the job).

What do you think?

Besides this detail, the monitor looks good to me
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

