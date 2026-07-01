Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD774A13BD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911515; cv=none; b=SeVaduR5aTzFJG4PVYRLfzE69Ni0OASrS98Mm3cHLoY6XbnvcYdkBuL9g0wDk0UimrzAXonGHDyg8xp74ZD9GS/Yl/sbdFKznKOJBi+ctV7euuQEs3e5k0PqU8KNTReBab7qtcKOqv4SdqGNzBpDHw/lIIjrB2UicOkU3muaPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911515; c=relaxed/simple;
	bh=Z1dnppZtWjCZi7q1aIUQF7u13Sl/6IrT/5WEnuUvbk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4RQ8ll3jmZkZ76ves+QWuehVjpb6j1F22p9Ekb0+S6mxDiNr09suoMd9yjTwsax8b5v6YBSA+d8eFj1sqUwhwcLVd/VmEjZ3wRWbvWEi2/VNDkki4BZApHnFIJtToUVqmZdh5c+qQEtQfC0daR/U2/uO6BhV9YazEFUePDLxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2Osq+WM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2Osq+WM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782911512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O2kaOkJpmUQC1Co5+hPpV2JeAMEFgXgAPIdlMmpxk7U=;
	b=M2Osq+WMmBGAyZR6FCPeLHzF7JiRg0bxxpMBwPjqr0lVIW2mgmThh6B2+bYCs4tw6z/Fde
	Y/lSj8x5LEj0JA5z/nI3lcgXg8ToWWGAAZ1VS5S2h6GztB8ddPfg0mSWXuceYV1Q4Q/367
	5DYkmZA+sPcpPmVX4TcSRqakwkF1Eqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-H7KBvZR4MSeNnuWJWnKxfg-1; Wed, 01 Jul 2026 09:11:51 -0400
X-MC-Unique: H7KBvZR4MSeNnuWJWnKxfg-1
X-Mimecast-MFC-AGG-ID: H7KBvZR4MSeNnuWJWnKxfg_1782911510
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so13580795e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911510; x=1783516310;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt0xBCqeWoRJYvuEg2PYnPwtGvcwgU1CZOMs8phmh8g=;
        b=CMt+2g2udNf2cZ04GXuOOWOzfllG1D/zoASvN1mRSnyx1uETYC3jrWAm2++AjCmm+W
         nDvSs04id+mEnHfZXp/y1YPoku1pdJXIxGRaiLTxHYPtNtIJHj9EdXlle9sBn9uJYwsI
         hsNnoF6/6bwwF9TooQjP92O6RihFeMJvlCCw03Sv9YVc6J01mwDj0oRWTkLHwsflDYZv
         RE04cvWmVVw2IBAiN9/Zl3wPhMxs/DWuKSeRyDMd8EqX3wxwf+9+3TQchVb/24ANAS1p
         cmhjmHL/hscaFj0+kxm0c4YIHud9wsqDMwlc5ev+PleL6gNwN+YKw+vI7GtF//VEyr/x
         iUqg==
X-Forwarded-Encrypted: i=1; AFNElJ/SfB2jLl0klOFmhCZVJXvihDUq7Tp9XKqPi/Ql8W/FlirqE4A3Ho/S7awwyRXmEsCL7NmHcUkBubhwEPmkeW4tbnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNanzaZjzL128zqtGaXIZI9MgBQEI/yA3zMGPmfFdOr1i3pAny
	k9HBVGcAA78ep8fcKME5BxhFfgrYkDFtZVr0KEcedhf3JJLRqS2NFv+zioUt1CkP5q5Bo3SiUVA
	wgAd3vrYF5+UXUDuaNel6cXJ+Q/z55IVLzN1RG6o2YUgszMJpTabD/puc6MoADqoea4ocGNYWhQ
	==
X-Gm-Gg: AfdE7clWtw5OQfzrnOIj5N5B84Wm5QrTlm5RTFg9XiOImrnPcjeFC0WVq559zdsUDlA
	3En+fQtTmw7Rm4fWJO8iI5IFrkHcWgRk+cG1sdqnYFHHehVkP+RMn31Fpj2GqmF5YmtliiHcVCV
	R8iBUi538oyhiNAGOaY5AZtMhbXHAPC3rPVQobteK4b5Fhxpo1nDeDooyDDf604c9G0OkAJg/0R
	XIUWzXPNIp531RvAI4jid0So6vGzCf+7WT3S3Xm6bSZadio1yH4au9WRODmJKz3uVT9idqXu7F9
	T7+FWdVZ9ZKm8hbh2G6UOYIQp5ZP+chmN2B5o1RcfgHPCb2HLPXRRYAPA/mAgz9aab3kEPeFpoQ
	09KGfwDqcA7KOWUvYPSEpzBNjXjzW/kCNVMgL+01NIerh+I+i/pDeK6F0bLurf7WmMLR2jBTT41
	ZIDlJq
X-Received: by 2002:a05:600c:6986:b0:493:bc4a:a14d with SMTP id 5b1f17b1804b1-493c2485321mr23964805e9.19.1782911509850;
        Wed, 01 Jul 2026 06:11:49 -0700 (PDT)
X-Received: by 2002:a05:600c:6986:b0:493:bc4a:a14d with SMTP id 5b1f17b1804b1-493c2485321mr23964325e9.19.1782911509310;
        Wed, 01 Jul 2026 06:11:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef11338sm58189635e9.1.2026.07.01.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:11:48 -0700 (PDT)
Message-ID: <b33e175467a8cb8011ded2195353bc6743b4cd46.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 15:11:46 +0200
In-Reply-To: <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Se2jELFB2_sk05-m89M_q6vmCQl00G7IBQ9WXeCaVuE_1782911510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-19 at 09:21 +0200, Nam Cao wrote:
> Add a wakeup monitor to detect a lower-priority task waking up a
> higher-priority task.
>=20
> The rtapp/sleep monitor already detects this. However, that monitor
> triggers an error in the context of the wakee task and user only gets
> the stacktrace of that task. It is also extremely useful to get the
> stacktrace of the waker task, which this monitor offers. In other
> words, this monitor complements the rtapp/sleep monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

This looks good, but if I understand it correctly, the same violation shoul=
d be
spotted by both monitors from two different perspectives, but sleep catches=
 more
things (e.g. tasks using wrong sleeping ways despite their wakeup):

  # perf stat -a -e rv:error_sleep -e rv:error_wakeup -- stress-ng --cpu 5 =
--cpu-load 90 --sched rr -t 5

   Performance counter stats for 'system wide':

               285      rv:error_sleep                                     =
   =20
                20      rv:error_wakeup                                    =
   =20

Provided I don't really know what's happening down there (I just let the
stressor run free), this discrepancy is expected, right?

Thanks,
Gabriele

> ---
> =C2=A0Documentation/trace/rv/monitor_rtapp.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 20 +++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rtapp/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0kernel/trace/rv/monitors/wakeup/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 16 ++
> =C2=A0kernel/trace/rv/monitors/wakeup/wakeup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 153 ++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/wakeup/wakeup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 92 +++++++++++
> =C2=A0.../trace/rv/monitors/wakeup/wakeup_trace.h=C2=A0=C2=A0 |=C2=A0 14 =
++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0tools/verification/models/rtapp/wakeup.ltl=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 5 +
> =C2=A010 files changed, 304 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/wakeup/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup_trace.h
> =C2=A0create mode 100644 tools/verification/models/rtapp/wakeup.ltl
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> b/Documentation/trace/rv/monitor_rtapp.rst
> index 502d3ea412eb..238b59395ff5 100644
> --- a/Documentation/trace/rv/monitor_rtapp.rst
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -124,3 +124,23 @@ to handle some special cases:
> =C2=A0=C2=A0=C2=A0=C2=A0 real-time-safe because preemption is disabled fo=
r the duration.
> =C2=A0=C2=A0 - `FUTEX_LOCK_PI` is included in the allowlist for the same =
reason as
> =C2=A0=C2=A0=C2=A0=C2=A0 `BLOCK_ON_RT_MUTEX`.
> +
> +Monitor wakeup
> +++++++++++++++
> +
> +The `wakeup` monitor reports real-time threads being woken by lower-prio=
rity
> threads,
> +which is a hint of priority inversion. Its specification is::
> +
> +=C2=A0 RULE =3D always (((RT and USER_THREAD) imply
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or
> ALLOWLIST))
> +
> +=C2=A0 ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LO=
CK_PI
> +
> +The `sleep` monitor already reports this type of problem. The difference=
 is
> the
> +context in which the problem is reported. While the `sleep` monitor repo=
rts
> the problem
> +in the context of the wakee, this `wakeup` monitor reports the problem i=
n the
> context of
> +the waker. This monitor complement the `sleep` monitor, giving user bett=
er
> +understanding of the issue. For instance, to debug a lower-priority task
> waking a
> +higher-priority task scenario, user can enable both `wakeup` monitor and
> `sleep`
> +monitor to get the stack traces of both tasks.
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 3884b14df375..4d3a14a0bac2 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -76,6 +76,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/pagefault/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sleep/Kconfig"
> +source "kernel/trace/rv/monitors/wakeup/Kconfig"
> =C2=A0# Add new rtapp monitors here
> =C2=A0
> =C2=A0source "kernel/trace/rv/monitors/stall/Kconfig"
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 94498da35b37..c2c0e4142eb4 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> =C2=A0obj-$(CONFIG_RV_MON_STALL) +=3D monitors/stall/stall.o
> =C2=A0obj-$(CONFIG_RV_MON_DEADLINE) +=3D monitors/deadline/deadline.o
> =C2=A0obj-$(CONFIG_RV_MON_NOMISS) +=3D monitors/nomiss/nomiss.o
> +obj-$(CONFIG_RV_MON_WAKEUP) +=3D monitors/wakeup/wakeup.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig
> b/kernel/trace/rv/monitors/rtapp/Kconfig
> index 1ce9370a9ba8..1fcd7a400ded 100644
> --- a/kernel/trace/rv/monitors/rtapp/Kconfig
> +++ b/kernel/trace/rv/monitors/rtapp/Kconfig
> @@ -1,6 +1,6 @@
> =C2=A0config RV_MON_RTAPP
> =C2=A0=09depends on RV
> -=09depends on RV_PER_TASK_MONITORS >=3D 2
> +=09depends on RV_PER_TASK_MONITORS >=3D 3
> =C2=A0=09bool "rtapp monitor"
> =C2=A0=09help
> =C2=A0=09=C2=A0 Collection of monitors to check for common problems with =
real-time
> diff --git a/kernel/trace/rv/monitors/wakeup/Kconfig
> b/kernel/trace/rv/monitors/wakeup/Kconfig
> new file mode 100644
> index 000000000000..ec3a5c06a8c4
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/wakeup/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_WAKEUP
> +=09depends on RV
> +=09depends on RV_MON_RTAPP
> +=09depends on HAVE_SYSCALL_TRACEPOINTS
> +=09default y
> +=09select LTL_MON_EVENTS_ID
> +=09bool "wakeup monitor"
> +=09help
> +=09=C2=A0 This monitor detects a lower-priority task waking up a
> +=09=C2=A0 higher-priority task. The RV_MON_SLEEP monitor already
> +=09=C2=A0 detects this case, but this monitor detects in the context
> +=09=C2=A0 of the waker task instead. This and RV_MON_SLEEP can be
> +=09=C2=A0 enabled together to get the stacktrace of both the waker
> +=09=C2=A0 task and the wakee task.
> diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.c
> b/kernel/trace/rv/monitors/wakeup/wakeup.c
> new file mode 100644
> index 000000000000..01b47416f24e
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/wakeup/wakeup.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "wakeup"
> +
> +#include <trace/events/syscalls.h>
> +#include <trace/events/sched.h>
> +#include <trace/events/lock.h>
> +#include <uapi/linux/futex.h>
> +
> +#include <rv_trace.h>
> +#include <monitors/rtapp/rtapp.h>
> +
> +
> +#ifndef __NR_futex
> +#define __NR_futex (-__COUNTER__)
> +#endif
> +#ifndef __NR_futex_time64
> +#define __NR_futex_time64 (-__COUNTER__)
> +#endif
> +
> +#include "wakeup.h"
> +#include <rv/ltl_monitor.h>
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor
> *mon)
> +{
> +=09/*
> +=09 * This includes "actual" real-time tasks and also PI-boosted
> +=09 * tasks. A task being PI-boosted means it is blocking an "actual"
> +=09 * real-task, therefore it should also obey the monitor's rule,
> +=09 * otherwise the "actual" real-task may be delayed.
> +=09 */
> +=09ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
> +}
> +
> +static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor =
*mon,
> bool task_creation)
> +{
> +=09ltl_atom_set(mon, LTL_WOKEN_BY_LOWER_PRIO, false);
> +=09ltl_atom_set(mon, LTL_WOKEN_BY_SOFTIRQ, false);
> +
> +=09if (task_creation) {
> +=09=09ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
> +=09=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> +=09}
> +
> +=09ltl_atom_set(mon, LTL_USER_THREAD, !(task->flags & PF_KTHREAD));
> +}
> +
> +static void handle_sched_waking(void *data, struct task_struct *task)
> +{
> +=09if (in_task()) {
> +=09=09if (current->prio > task->prio)
> +=09=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO, true);
> +=09} else if (in_serving_softirq()) {
> +=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
> +=09}
> +}
> +
> +static void handle_contention_begin(void *data, void *lock, unsigned int
> flags)
> +{
> +=09if (flags & LCB_F_RT)
> +=09=09ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
> +}
> +
> +static void handle_contention_end(void *data, void *lock, int ret)
> +{
> +=09ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
> +}
> +
> +static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
> +{
> +=09unsigned long args[6];
> +=09int op, cmd;
> +
> +=09switch (id) {
> +=09case __NR_futex:
> +=09case __NR_futex_time64:
> +=09=09syscall_get_arguments(current, regs, args);
> +=09=09op =3D args[1];
> +=09=09cmd =3D op & FUTEX_CMD_MASK;
> +
> +=09=09switch (cmd) {
> +=09=09case FUTEX_LOCK_PI:
> +=09=09case FUTEX_LOCK_PI2:
> +=09=09=09ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
> +=09=09=09break;
> +=09=09}
> +=09=09break;
> +=09}
> +}
> +
> +static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
> +{
> +=09ltl_atom_update(current, LTL_FUTEX_LOCK_PI, false);
> +}
> +
> +static int enable_wakeup(void)
> +{
> +=09int retval;
> +
> +=09retval =3D ltl_monitor_init();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09rv_attach_trace_probe("rtapp_wakeup", sched_waking,
> handle_sched_waking);
> +=09rv_attach_trace_probe("rtapp_wakeup", contention_begin,
> handle_contention_begin);
> +=09rv_attach_trace_probe("rtapp_wakeup", contention_end,
> handle_contention_end);
> +=09rv_attach_trace_probe("rtapp_wakeup", sys_enter, handle_sys_enter);
> +=09rv_attach_trace_probe("rtapp_wakeup", sys_exit, handle_sys_exit);
> +
> +=09return 0;
> +}
> +
> +static void disable_wakeup(void)
> +{
> +=09rv_detach_trace_probe("rtapp_wakeup", sched_waking,
> handle_sched_waking);
> +=09rv_detach_trace_probe("rtapp_wakeup", contention_begin,
> handle_contention_begin);
> +=09rv_detach_trace_probe("rtapp_wakeup", contention_end,
> handle_contention_end);
> +=09rv_detach_trace_probe("rtapp_wakeup", sys_enter, handle_sys_enter);
> +=09rv_detach_trace_probe("rtapp_wakeup", sys_exit, handle_sys_exit);
> +
> +=09ltl_monitor_destroy();
> +}
> +
> +static struct rv_monitor rv_wakeup =3D {
> +=09.name =3D "wakeup",
> +=09.description =3D "Monitor that real-time tasks are not woken by lower=
-
> priority tasks",
> +=09.enable =3D enable_wakeup,
> +=09.disable =3D disable_wakeup,
> +};
> +
> +static int __init register_wakeup(void)
> +{
> +=09return rv_register_monitor(&rv_wakeup, &rv_rtapp);
> +}
> +
> +static void __exit unregister_wakeup(void)
> +{
> +=09rv_unregister_monitor(&rv_wakeup);
> +}
> +
> +module_init(register_wakeup);
> +module_exit(unregister_wakeup);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("Monitor that real-time tasks are not woken by lower-
> priority tasks");
> diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.h
> b/kernel/trace/rv/monitors/wakeup/wakeup.h
> new file mode 100644
> index 000000000000..6f80da64e0e1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/wakeup/wakeup.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * C implementation of Buchi automaton, automatically generated by
> + * tools/verification/rvgen from the linear temporal logic specification=
.
> + * For further information, see kernel documentation:
> + *=C2=A0=C2=A0 Documentation/trace/rv/linear_temporal_logic.rst
> + */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME wakeup
> +
> +enum ltl_atom {
> +=09LTL_BLOCK_ON_RT_MUTEX,
> +=09LTL_FUTEX_LOCK_PI,
> +=09LTL_RT,
> +=09LTL_USER_THREAD,
> +=09LTL_WOKEN_BY_LOWER_PRIO,
> +=09LTL_WOKEN_BY_SOFTIRQ,
> +=09LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +=09static const char *const names[] =3D {
> +=09=09"bl_on_rt_mu",
> +=09=09"fu_lo_pi",
> +=09=09"rt",
> +=09=09"us_th",
> +=09=09"wo_lo_pr",
> +=09=09"wo_so",
> +=09};
> +
> +=09return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +=09S0,
> +=09RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
> +
> +static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +=09bool woken_by_softirq =3D test_bit(LTL_WOKEN_BY_SOFTIRQ, mon->atoms);
> +=09bool woken_by_lower_prio =3D test_bit(LTL_WOKEN_BY_LOWER_PRIO, mon-
> >atoms);
> +=09bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
> +=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> +=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> +=09bool val9 =3D block_on_rt_mutex || futex_lock_pi;
> +=09bool val6 =3D !woken_by_softirq;
> +=09bool val5 =3D !woken_by_lower_prio;
> +=09bool val8 =3D val5 && val6;
> +=09bool val10 =3D val8 || val9;
> +=09bool val3 =3D !user_thread;
> +=09bool val2 =3D !rt;
> +=09bool val4 =3D val2 || val3;
> +=09bool val11 =3D val4 || val10;
> +
> +=09if (val11)
> +=09=09__set_bit(S0, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state,
> unsigned long *next)
> +{
> +=09bool woken_by_softirq =3D test_bit(LTL_WOKEN_BY_SOFTIRQ, mon->atoms);
> +=09bool woken_by_lower_prio =3D test_bit(LTL_WOKEN_BY_LOWER_PRIO, mon-
> >atoms);
> +=09bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
> +=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> +=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> +=09bool val9 =3D block_on_rt_mutex || futex_lock_pi;
> +=09bool val6 =3D !woken_by_softirq;
> +=09bool val5 =3D !woken_by_lower_prio;
> +=09bool val8 =3D val5 && val6;
> +=09bool val10 =3D val8 || val9;
> +=09bool val3 =3D !user_thread;
> +=09bool val2 =3D !rt;
> +=09bool val4 =3D val2 || val3;
> +=09bool val11 =3D val4 || val10;
> +
> +=09switch (state) {
> +=09case S0:
> +=09=09if (val11)
> +=09=09=09__set_bit(S0, next);
> +=09=09break;
> +=09}
> +}
> diff --git a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
> b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
> new file mode 100644
> index 000000000000..7e056183f920
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_WAKEUP
> +DEFINE_EVENT(event_ltl_monitor_id, event_wakeup,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task, char *sta=
tes, char *atoms,
> char *next),
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task, states, atoms, next));
> +DEFINE_EVENT(error_ltl_monitor_id, error_wakeup,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task),
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task));
> +#endif /* CONFIG_RV_MON_WAKEUP */
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 9622c269789c..2f8a932432c9 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -241,6 +241,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
> =C2=A0);
> =C2=A0#include <monitors/pagefault/pagefault_trace.h>
> =C2=A0#include <monitors/sleep/sleep_trace.h>
> +#include <monitors/wakeup/wakeup_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> =C2=A0#endif /* CONFIG_LTL_MON_EVENTS_ID */
> =C2=A0
> diff --git a/tools/verification/models/rtapp/wakeup.ltl
> b/tools/verification/models/rtapp/wakeup.ltl
> new file mode 100644
> index 000000000000..a5d63ca0811a
> --- /dev/null
> +++ b/tools/verification/models/rtapp/wakeup.ltl
> @@ -0,0 +1,5 @@
> +RULE =3D always (((RT and USER_THREAD) imply
> +=09=09(not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or
> ALLOWLIST))
> +
> +ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LOCK_PI

