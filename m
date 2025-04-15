Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AAC1F3FE3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720317; cv=none; b=fxudHTTQMuxeki5ytoBBhSvG3jONHtrlbgMyFPVgDWkAil2Xy/UbMmimoq5h+Xsb6VYaK0H9WWpsjGjC0MswUaFQvA9imA9XHt40KIjHk/PVqVPSxGJ6KVtGj1JH3Grn9uEA2cnhcloAgwD/rDgw2r3d/y030VpV+U28VFhIR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720317; c=relaxed/simple;
	bh=t8iFptHztSHPPgsDimu1EhFoKgWo6OJnOZQmkEICrs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IApYxIJnXfelQPTRDbuBwC4dUD7Efjjqhz8wiuV7XfiLaDqAjVu43CFobxMlSft9K5131pwN9iqaKUUeiGLKQLuVQ3UPRKBaKTa+WdjixnvW3UL3Kr88iQovO7/mZ6DfVKpZF5o28gbDZPjPvkO30cBAwVXFxjAgA4Jf6wdaeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBUEdobR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBUEdobR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744720314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LkceNR5/lCSVt4pQxsmouXTl6VRo7Zp08czA+HbnBAk=;
	b=bBUEdobRxBriSGZCkTF280HhpiZwrfR1PAweAXaz7gY+Q28i1O/N8xC6CfQonIabU7bhxN
	w3mJtFY4axOb8zATTmbTKjIuAD3nDIGQDxQkMM0FbTzCG4BN73vatStfYPz/4nMfrgUC19
	MHsKPCPr3roazbbly4uke4Ygn4tny+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-AkUS7oJ_O0G0QW_PdSUFzg-1; Tue, 15 Apr 2025 08:31:48 -0400
X-MC-Unique: AkUS7oJ_O0G0QW_PdSUFzg-1
X-Mimecast-MFC-AGG-ID: AkUS7oJ_O0G0QW_PdSUFzg_1744720307
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so29267025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 05:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720307; x=1745325107;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1a73Sd3RAp1iqaDWI4nfw2gLoGkbnWXSdTgoGDBOvM=;
        b=VM1KKfMGpMSkzDcHYmNzSluezgZzEmNF6MfEeTmeK7dZBOWfR01NSeBt9+sd2Zwlgv
         XcMjncQqCPAOk8xKGFnmABAkJC7M0ujvvRzNWnbrce6q/rzVKYa5aUh+IW9f/+8eOlxA
         8HTIxUdECBF2ScjIBw9ys7mPJ0fPjDMr5fNE6ovIKbDjW/aUsmuM6shCidA7ucNVWdHC
         Cj3ReQYemTzh2n9W5oeqvVEJ/tEuThVSbC2WVFxum/0QRNCc80m50+bzAxQfPldHi/Zj
         mvvNmFQlNznugUoX7TDH0NymA8zzmrPbEIE1nW1OigA+31g7djAE00XpM7vKKz8DxHDF
         bMOw==
X-Forwarded-Encrypted: i=1; AJvYcCWVlzN2RsF2H+vb3WAP3B6VGU5BCPvBa6YXKZq61bbr9wF/5bI+SiMdKdyRB9C6ly4W5UZ3PAG3XHDU+Ot9tKAu2fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyD5FPXe0fIjTE06wQV7G4bvqT3tkUzOy/+t8/r05NLBXG2OLk
	XJS1pWvAZdTFhD5Ih8+AkDw/QXLayhbxJX2FkWYHIZcdCU8EX6ttkvdYq5OjrJp76R+SqTIAFmE
	zRjfYmkn1kNoY0ASe1r1NHIh0OFJEG2tYgDgt64xm1FlW+3CvfMctmV2HM2IhOXCxmdrnwg==
X-Gm-Gg: ASbGncv63XFL7v8y5h15jFAaI/y3a+hGP5wotdxNj1vNukN7b8FdnbaveYvwMw8ousJ
	k4xPt3+h+f37dtgeANZlfxpCY+nRhj2vuWnZAsmJGdoopbzMcWGPwDWNhK6uQbLvckJ7jh+P/Pb
	N0DRQd7uTr25NM4M3N928dsM3mqGbYatRvOmwwzHap4i4RjMYYhOwP5umHVAyOuZE1A4YQR9zlD
	D71E+EX0J610SzIpgZQjEOqD83yyO950oKalLb7iRK1hFnVEWXdGaAnC3I059vMUvtkMHc7JyKA
	FM2eSZ2IphoCuojuFIU0uSmcLw7syxQrKSIyPKM=
X-Received: by 2002:a05:6000:2d08:b0:391:2a9f:2fcb with SMTP id ffacd0b85a97d-39eaaecdc43mr11875108f8f.36.1744720307101;
        Tue, 15 Apr 2025 05:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ycg8O9xQhBfZzgNtXQZUfoHEE2cLc/SzULCS1q7QwNJkCHaR97D4J4FI533j3gfmzkHI7Q==
X-Received: by 2002:a05:6000:2d08:b0:391:2a9f:2fcb with SMTP id ffacd0b85a97d-39eaaecdc43mr11875079f8f.36.1744720306709;
        Tue, 15 Apr 2025 05:31:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96407esm14219474f8f.17.2025.04.15.05.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 05:31:46 -0700 (PDT)
Message-ID: <4d5dd1b919aada32ddf4dbce895f19e558343ee9.camel@redhat.com>
Subject: Re: [PATCH v2 19/22] rv: Add rtapp_pagefault monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, 	x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, 	linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org
Date: Tue, 15 Apr 2025 14:31:43 +0200
In-Reply-To: <f57547af5e8c836f5c548f624e61f3e0002ce0b4.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <f57547af5e8c836f5c548f624e61f3e0002ce0b4.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xEaj_RemZYEb3b-EEQKO4lm7eJd3OkF-WkL0AKlGd7M_1744720307
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> Userspace real-time applications may have design flaws that they
> raise
> page faults in real-time threads, and thus have unexpected latencies.
>=20
> Add an linear temporal logic monitor to detect this scenario.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-riscv@lists.infradead.org
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/pagefault/Kconfig=C2=A0=C2=A0=C2=A0 | 11 +=
++
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0 | 83
> +++++++++++++++++++
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.h=C2=A0=C2=A0 | 57 ++++++=
+++++++
> =C2=A0.../rv/monitors/pagefault/pagefault_trace.h=C2=A0=C2=A0 | 14 ++++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A0tools/verification/models/rtapp/pagefault.ltl |=C2=A0 1 +
> =C2=A08 files changed, 169 insertions(+)
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
> index 000000000000..9f7a4cba39a1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
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
> +=09ltl_atom_set(mon, LTL_RT, rt_task(task));
> +}
> +
> +static void ltl_atoms_init(struct task_struct *task, struct
> ltl_monitor *mon, bool task_creation)
> +{
> +=09if (task_creation)
> +=09=09ltl_atom_set(mon, LTL_PAGEFAULT, false);
> +}
> +
> +static void handle_page_fault(void *data, unsigned long address,
> struct pt_regs *regs,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long error_code)
> +{
> +=09ltl_atom_pulse(current, LTL_PAGEFAULT, true);
> +}
> +
> +static int enable_pagefault(void)
> +{
> +=09int retval;
> +
> +=09retval =3D ltl_monitor_init();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09rv_attach_trace_probe("pagefault", page_fault_kernel,
> handle_page_fault);
> +=09rv_attach_trace_probe("pagefault", page_fault_user,
> handle_page_fault);
> +
> +=09return 0;
> +}
> +
> +static void disable_pagefault(void)
> +{
> +=09rv_pagefault.enabled =3D 0;
> +
> +=09rv_detach_trace_probe("rtapp_pagefault", page_fault_kernel,
> handle_page_fault);
> +=09rv_detach_trace_probe("rtapp_pagefault", page_fault_user,
> handle_page_fault);
> +
> +=09ltl_monitor_destroy();
> +}
> +
> +static struct rv_monitor rv_pagefault =3D {
> +=09.name =3D "pagefault",
> +=09.description =3D "Monitor that RT tasks do not raise page
> faults",
> +=09.enable =3D enable_pagefault,
> +=09.disable =3D disable_pagefault,
> +};
> +
> +static int __init register_pagefault(void)
> +{
> +=09rv_register_monitor(&rv_pagefault, &rv_rtapp);
> +=09return 0;

Any reason why you aren't returning the error value from the monitor
registration?

Other than that, the monitor seems neat and reasonably easy to
generate.

May not be necessary in this series, but try to keep compatibility with
the userspace RV tool as well, you need to have some special case in
its tracing components because fields are not matching:
 # rv mon sleep -t
         rcuc/11-108      [011] event <CANT FIND FIELD final_state>  =20
(null) x (null)                   -> (null)                   Y
         rcuc/11-108      [011] event <CANT FIND FIELD final_state>  =20
(null) x (null)                   -> (null)                   Y
      ktimers/11-109      [011] event <CANT FIND FIELD final_state>  =20
(null) x (null)                   -> (null)                   Y
=20
Thanks,
Gabriele

