Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33623371A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796103; cv=none; b=FidANeeyL6y9l75t/BU8/4aR1VvMmdqufkqtAbFQlEfRYjaMw3oQm2FZ3No9256/CBNaNP19BBpq1CTurWXHSJ8YFE8RnE21+CmP73LE4UUZWwG18CNmw9r2WdR/N5D/6Cur7nMXyvHlZnbstAU6T7+4nAyEXVNPjRuCQ8WO0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796103; c=relaxed/simple;
	bh=C18Tf7unDSvJX9j9nW+HoEx1hBUMa6jHn1mjS+YktOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIw42LvaEaynuINT/fWCuZ2kUExqh5C78QUviZvUxnRn/mGcxq+5VFI1i626uW+O1Es+AbxM0o85Y0fQUpEeHE0/BL1VfJlt8u7x5+SJJ4kZDEBydiAdHzaZHEh8Grx+ncO8ZAwu55xNLFytQZNj9U6P8YnHVX8jHQoUpEites8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUppqsVx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUppqsVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744796099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OE8rijCCHarqL4HfwQt6I0qNX8d9hXiizHIP9i4ZaNE=;
	b=RUppqsVx5bBVGtnqAUFMY+grQ9A1da3dQIYdfSpJbXVyjyDgN8eOABaNANvKjeMa0Jsb0v
	oAGhU2qYjN4MI0U2Cw18eOEWS5pu0luqN5YrQ+edQQmHb5jFYALGh3datzwe2NkMHQodE1
	FhSgt82yji8FFI3KjyEVf5qP3VlwB4A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-8EyA2TK_NKOqjeB6b2Ybeg-1; Wed, 16 Apr 2025 05:34:57 -0400
X-MC-Unique: 8EyA2TK_NKOqjeB6b2Ybeg-1
X-Mimecast-MFC-AGG-ID: 8EyA2TK_NKOqjeB6b2Ybeg_1744796097
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so468125666b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 02:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796096; x=1745400896;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R38kvr6YYwHybVl0KvxrQLj4rrauk+WxuzNkAEl5+ic=;
        b=KyYwk/+3VsDOs4y6BziY1L+s5AWp9B3gapSXk/JEFLy30DxS/Zrof78nq1JT+zG0W5
         Fd9SfOnRsuT3pq3FIP/7MKqYNT3OWxolSnv8FZ75mTSpuoLYfS5BTU8FOUM5bUVng1+S
         cKPz1fUOPMEmX/K+ki8iDYtdqAzt7pNBvKm0twjvaFsElFykq9WqcjP/PqAq1l12d9R9
         Lw+HhkDIv0tpJQapuBm6bctvd4Rsjlob/pzCiZ86aI+AyLz0SnPdWlu1SuNjXHswzeYF
         uWp5pCBxcRB5FCKX2GxBTVaJv7WRkIH2Oy1zk4p2DcSBUI5uIhYepGYHz4mKy4RYpf51
         ipww==
X-Forwarded-Encrypted: i=1; AJvYcCXFfM731ZynoUO7Le4rrqn9phmQ7LLaBGbPjUPTwR3qp7vSbV3zKRjrcpOFmLTXdx47dsiM/QBt0dsza8pEso+BHNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsHn/80P2FxWAXatzvSQcdeXUl6ZqFumX6BPSjDcZFippzCCh
	JYXWWIiul5ITfG5fNEpDp10XC7gDI1cZ6kQ8mqIvZpitRwrUNNq2aTY5ATvhJ/+r/agcBhEpCiw
	sOhgDwRfB4SHTZxeRGsknLKuMSEc8fy0xuZCkAs0Gdf0XiPJxPZ9zzB8t9SkcpjuzPeDtrA==
X-Gm-Gg: ASbGnctdw2+RG52NadHDflvsWLWhJeylcyDirkMNV2p1iLxIx8MMgAOjgd6gHlKgRmq
	smo9IZXnVADJSZypfIVFtcM0mEGi3LyoxY67Aj1u/hnmcVxILoaaRFw+mq4UYhY7irhpsLmTykf
	oxhusyeRneAuabIan8pp575ZtypKMVv3lkUxCWDl0JAOkNRU4elJHFptJrVzJS9avy0fAykkUJu
	3GtwmwUNfH6I0IfC+v85Ecq/4Dt4rvrbEFDNZdatEgkL/JtLxHZQeDSUdfueMgUp2f6nWXhtZe0
	tzw/OX/q//MFNNIm/MPzKpU8QgXPBGlakdol6T0=
X-Received: by 2002:a17:906:f594:b0:aca:d4d0:a735 with SMTP id a640c23a62f3a-acb42ad330dmr92702266b.43.1744796096548;
        Wed, 16 Apr 2025 02:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA3tINUfuvkxHAN/j7OpwBay5sdkkyLpxkjrrvfKwXbTUdvRoKXKWFVl9vjG5myTqzr3sZpg==
X-Received: by 2002:a17:906:f594:b0:aca:d4d0:a735 with SMTP id a640c23a62f3a-acb42ad330dmr92699866b.43.1744796096039;
        Wed, 16 Apr 2025 02:34:56 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128932sm90388766b.88.2025.04.16.02.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:34:55 -0700 (PDT)
Message-ID: <4edad1940b2d05f1997895d4bbc11f02a921e8e5.camel@redhat.com>
Subject: Re: [PATCH v3 13/22] rv: Add support for LTL monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Wed, 16 Apr 2025 11:34:53 +0200
In-Reply-To: <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
	 <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 4mEqWIUuqzh8YigBnWNE7yYKS-VxlQg8ZXXKB07L224_1744796097
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> While attempting to implement DA monitors for some complex
> specifications,
> deterministic automaton is found to be inappropriate as the
> specification
> language. The automaton is complicated, hard to understand, and
> error-prone.
>=20
> For these cases, linear temporal logic is more suitable as the
> specification language.
>=20
> Add support for linear temporal logic runtime verification monitor.
>=20
> For all the details, see the documentations added by this commit.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../trace/rv/linear_temporal_logic.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 119 ++++
> =C2=A0Documentation/trace/rv/monitor_synthesis.rst=C2=A0 | 141 ++++-
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 62 +-
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 184 ++++++
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 47 ++
> =C2=A0tools/verification/rvgen/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0tools/verification/rvgen/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0tools/verification/rvgen/__main__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0tools/verification/rvgen/rvgen/ltl2ba.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 558
> ++++++++++++++++++
> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 242 ++++++++
> =C2=A0.../rvgen/rvgen/templates/ltl2k/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 102 ++++
> =C2=A0.../rvgen/rvgen/templates/ltl2k/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 14 +
> =C2=A015 files changed, 1465 insertions(+), 25 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
> =C2=A0create mode 100644 include/rv/ltl_monitor.h
> =C2=A0create mode 100644 tools/verification/rvgen/.gitignore
> =C2=A0create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
> =C2=A0create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
> =C2=A0create mode 100644
> tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> =C2=A0create mode 100644
> tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
>=20
> [...]
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> new file mode 100644
> index 000000000000..78f5a1197665
> --- /dev/null
> +++ b/include/rv/ltl_monitor.h
> @@ -0,0 +1,184 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * This file must be combined with the $(MODEL_NAME).h file
> generated by
> + * tools/verification/rvgen.
> + */
> +
> +#include <linux/args.h>
> +#include <linux/rv.h>
> +#include <linux/stringify.h>
> +#include <linux/seq_buf.h>
> +#include <rv/instrumentation.h>
> +#include <trace/events/task.h>
> +#include <trace/events/sched.h>
> +
> +#ifndef MONITOR_NAME
> +#error "MONITOR_NAME macro is not defined. Did you include
> $(MODEL_NAME).h generated by rvgen?"
> +#endif
> +
> +#ifdef CONFIG_RV_REACTORS
> +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> +static struct rv_monitor RV_MONITOR_NAME;
> +
> +static void rv_cond_react(struct task_struct *task)
> +{
> +=09if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> +=09=09return;
> +=09RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)":
> %s[%d]: violation detected\n",
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task->comm, task->pid);
> +}

What about adding more context here (see below).

> +#else
> +static void rv_cond_react(struct task_struct *task)
> +{
> +}
> +#endif
> +
> [...]
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 99c3801616d4..f9fb848bae91 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -127,6 +127,53 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
> =C2=A0// Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
> =C2=A0
> =C2=A0#endif /* CONFIG_DA_MON_EVENTS_ID */
> +#if CONFIG_LTL_MON_EVENTS_ID
> +TRACE_EVENT(event_ltl_monitor_id,
> +
> +=09TP_PROTO(struct task_struct *task, char *states, char
> *atoms, char *next),
> +
> +=09TP_ARGS(task, states, atoms, next),
> +
> +=09TP_STRUCT__entry(
> +=09=09__string(comm, task->comm)
> +=09=09__field(pid_t, pid)
> +=09=09__string(states, states)
> +=09=09__string(atoms, atoms)
> +=09=09__string(next, next)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__assign_str(comm);
> +=09=09__entry->pid =3D task->pid;
> +=09=09__assign_str(states);
> +=09=09__assign_str(atoms);
> +=09=09__assign_str(next);
> +=09),
> +
> +=09TP_printk("%s[%d]: (%s) x (%s) -> (%s)", __get_str(comm),
> __entry->pid, __get_str(states),
> +=09=09=C2=A0 __get_str(atoms), __get_str(next))
> +);
> +
> +TRACE_EVENT(error_ltl_monitor_id,
> +
> +=09TP_PROTO(struct task_struct *task),
> +
> +=09TP_ARGS(task),
> +
> +=09TP_STRUCT__entry(
> +=09=09__string(comm, task->comm)
> +=09=09__field(pid_t, pid)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__assign_str(comm);
> +=09=09__entry->pid =3D task->pid;
> +=09),
> +
> +=09TP_printk("%s[%d]: violation detected", __get_str(comm),

In your workflow you're probably using events and errors together, but
wouldn't it help printing the atoms together with the violation
detected?
At least to give a clue on the error in case the user doesn't want to
see the entire trace (which might be needed for a full debug though).

The same could be said from reactors, the user doesn't have much
information to infer what went wrong.

> __entry->pid)
> +);
> +// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> +#endif /* CONFIG_LTL_MON_EVENTS_ID */
> =C2=A0#endif /* _TRACE_RV_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> [...]
> diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> b/tools/verification/rvgen/rvgen/ltl2k.py
> new file mode 100644
> index 000000000000..e2a7c4bcccc9
> --- /dev/null
> +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> @@ -0,0 +1,242 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +from pathlib import Path
> +from . import generator
> +from . import ltl2ba
> +
> +COLUMN_LIMIT =3D 100
> +
> +def line_len(line: str) -> int:
> +=C2=A0=C2=A0=C2=A0 tabs =3D line.count('\t')
> +=C2=A0=C2=A0=C2=A0 return tabs * 7 + len(line)
> +
> +def break_long_line(line: str, indent=3D'') -> list[str]:
> +=C2=A0=C2=A0=C2=A0 result =3D []
> +=C2=A0=C2=A0=C2=A0 while line_len(line) > COLUMN_LIMIT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D line[:COLUMN_LIMIT - li=
ne_len(line)].rfind(' ')
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result.append(line[:i])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D indent + line[i + 1:=
]
> +=C2=A0=C2=A0=C2=A0 if line:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result.append(line)
> +=C2=A0=C2=A0=C2=A0 return result
> +
> +def build_condition_string(node: ltl2ba.GraphNode):
> +=C2=A0=C2=A0=C2=A0 if not node.labels:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "(true)"
> +
> +=C2=A0=C2=A0=C2=A0 result =3D "("
> +
> +=C2=A0=C2=A0=C2=A0 first =3D True
> +=C2=A0=C2=A0=C2=A0 for label in sorted(node.labels):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not first:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resul=
t +=3D " && "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result +=3D label
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first =3D False
> +
> +=C2=A0=C2=A0=C2=A0 result +=3D ")"
> +
> +=C2=A0=C2=A0=C2=A0 return result
> +
> +def abbreviate_atoms(atoms: list[str]) -> list[str]:
> +=C2=A0=C2=A0=C2=A0 abbrs =3D list()
> +=C2=A0=C2=A0=C2=A0 for atom in atoms:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D 1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while True:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abbr =
=3D atom[:size]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if su=
m(a.startswith(abbr) for a in atoms) =3D=3D 1:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =
+=3D 1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abbrs.append(abbr.lower())
> +=C2=A0=C2=A0=C2=A0 return abbrs

I get this is just a matter of preference, so feel free to ignore my
suggestion.
This abbreviation algorithm doesn't work too well with atoms starting
with the same substring and can produce some unexpected result:

LTL_BLOCK_ON_RT_MUTEX:                b,
LTL_KERNEL_THREAD:                    ke,
LTL_KTHREAD_SHOULD_STOP:              kt,
LTL_NANOSLEEP:                        n,
LTL_PI_FUTEX:                         p,
LTL_RT:                               r,
LTL_SLEEP:                            s,
LTL_TASK_IS_MIGRATION:                task_is_m,
LTL_TASK_IS_RCU:                      task_is_r,
LTL_WAKE:                             wa,
LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    woken_by_e,
LTL_WOKEN_BY_HARDIRQ:                 woken_by_h,
LTL_WOKEN_BY_NMI:                     woken_by_n,

"woken_by_*" and "task_is_*" atom can get unnecessarily long and
while reading "kt" I might think about kernel_thread.

I was thinking about something like:

LTL_BLOCK_ON_RT_MUTEX:                b_o_r_m
LTL_KERNEL_THREAD:                    k_t
LTL_KTHREAD_SHOULD_STOP:              k_s_s
LTL_NANOSLEEP:                        n
LTL_PI_FUTEX:                         p_f
LTL_RT:                               r
LTL_SLEEP:                            s
LTL_TASK_IS_MIGRATION:                t_i_m
LTL_TASK_IS_RCU:                      t_i_r
LTL_WAKE:                             w
LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    w_b_e_o_h_p
LTL_WOKEN_BY_HARDIRQ:                 w_b_h
LTL_WOKEN_BY_NMI:                     w_b_n

or even

LTL_BLOCK_ON_RT_MUTEX:                b_m
LTL_KERNEL_THREAD:                    k_t
LTL_KTHREAD_SHOULD_STOP:              k_s_s
LTL_NANOSLEEP:                        n
LTL_PI_FUTEX:                         p_f
LTL_RT:                               r
LTL_SLEEP:                            s
LTL_TASK_IS_MIGRATION:                t_m
LTL_TASK_IS_RCU:                      t_r
LTL_WAKE:                             w
LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    w_e_h_p
LTL_WOKEN_BY_HARDIRQ:                 w_h
LTL_WOKEN_BY_NMI:                     w_n

I used the following code to come up with this:

def abbreviate_atoms(atoms: list[str]) -> list[str]:
    # completely arbitrary..
    skip =3D [ "is", "by", "or", "and" ]
    def abbr (n, s):
        return '_'.join(word[:n] for word in s.lower().split('_') if word n=
ot in skip)
    for n in range(1, 32):
        abbrs =3D [abbr(n, a) for a in atoms]
        if len(abbrs) =3D=3D len(set(abbrs)):
            return abbrs

Which could even be tuned to use 2 letters per block instead of 1
(improving readability by a lot actually)..
'bl_on_rt_mu', 'ke_th', 'kt_sh_st', 'na', 'pi_fu', 'rt', 'sl', 'ta_mi',
'ta_rc', 'wa', 'wo_eq_hi_pr', 'wo_ha', 'wo_nm'

What do you think?

Thanks,
Gabriele

