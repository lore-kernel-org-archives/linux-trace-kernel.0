Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206F4C9D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766348; cv=none; b=nJzPkAV/YOlDb2blYBNMGHETcC4r/sOBk72A7SZ0NDW0FvwpbiMcLiyfy4vGHKx/4IWaOpRupTLxRywJ6t19L/9UGd6GHdUHAHpqtAI/Gcaxncjgyr8cX3oQX6Aer5v8UWt6TULhE2d8JKLkmItYjnamcizTu2ReelVJn8S/HT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766348; c=relaxed/simple;
	bh=Z8qUhokTd0WsKgbHQFucfW6sW7lUt0o2tpY2RQjjzvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYd5NTIiIP/RjRFS39D+SDE2PHtDXKnLkQVUI6fYGPdN+uxe9f6IrL2v4crkBqjSfnGPAYffXCx0JtgR2dNXjyespOriQjNUHAIGUxqaSG520wWol9ld7SBafOVjgVBbZpLBPU8Ciwx8NJSef9UmUuHr9pr+wbWNwYe3LhINcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmAnXX4B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmAnXX4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741766344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z8qUhokTd0WsKgbHQFucfW6sW7lUt0o2tpY2RQjjzvU=;
	b=DmAnXX4BFPRwvRrzlpT1N3cMtMLFpUNE+3I0awj5OY8XaCYaO0AmiXRZJ6F94O8fHJunMm
	3NRclJm2gAMpaK0vZOpduKE0GNgEXanfQxGws9al/mgf52AztMxAkvhheHbquApihBvgGZ
	GcJB1vtYG3yKvDiuLbQtGctMpxOCepk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-dyLAJlKjOf2Jr4cd9Acg8g-1; Wed, 12 Mar 2025 03:59:00 -0400
X-MC-Unique: dyLAJlKjOf2Jr4cd9Acg8g-1
X-Mimecast-MFC-AGG-ID: dyLAJlKjOf2Jr4cd9Acg8g_1741766339
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3914608e90eso2373674f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766339; x=1742371139;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YTb5atTpDH4Sw5lOFzwaFCjTjpSJD+CwGAkxUWoJK0=;
        b=KIC/jWt34OJQj66cjaIDw0cXFEbcBc7N55pjVrI09QOConSX38i/lQdIItllFb0AO4
         y5M7JvQTkB5MEmMNSgG/4JcaMIF0wWgnI1wjIkZj6yg0/viRpZ2xLZEV71VAQKlVa1lb
         ArWA4y4dQGy76x7lB9Q6mrfKzjZ7RfP4lczZ5Wh7Un5UiyiIP/jz3Mg+vtIUXdhrPkmS
         g8yD2UygiFNquPJGykdD+GXzJfHiEE0TelrwdHOp2rxT+6dVLbVPRIeOrF6KuY426Ey3
         2HjcCxECTFC7/ZkZEMoOmWSwY7ricIKGz0YbvGviqfxJZw4zYsrghHluGFZe6R9BbHMe
         XoGA==
X-Forwarded-Encrypted: i=1; AJvYcCUNVtCYkf/cPuUBTPBx3XqIh7iFVkO+GZTqnuEKaNMHt7WTtSVBW2eQPIVzh8HhZX+T0lGACFb9GSKG2iwSrgsJ4uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpISJ0np+KjC2GtVynZ6tvzlb8HyiswaaFnaoT4k6D2jvbzH55
	DgRMhrDBU459DOSHM+gm9qfDr6bAwg9VlQo/ml8lnw3wBIEqmeDnKv7yYmmlaQz3D8ArHxWETD1
	F8BklasrPG1T13DpxRYRUOnsrek+Pf2wcnVPD5p0/TMRnkoKJCFtkgI2N6MzPBukS8gyXAg==
X-Gm-Gg: ASbGncsw2H0EeQvm5jacCcMv8jBNEStD0rhx3DyNkSyedcj2sqMSHWNW71PMb1PlI+h
	vYzETr5ceKT/MP4yXQiBpG+5RqsPvA8SR5gs7DcfpqO7qkyjvWxbJk0TdiLLF+vIvYKTwiNCcUD
	iPx6PZwL8rNkAZAda7b4jVQ7l8R/aXbUVKlaX01PTvKlDRYLSANcjvPtUxaHISkTeW3mycgZ1nL
	jsR6A3KZ4aB6DC7kqqpjXNIAr2KjllzxhQ58SdI6+4p8GU/Y2vlQ6O15t/pPH6TSYA5+oMDj/Ur
	daxWy8pEhAOI5ArK1OgRnW+V3qMk0vglR1WK6RId6Q==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39132b58ad8mr19705098f8f.0.1741766339492;
        Wed, 12 Mar 2025 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgH8YlIN8M80SafZ2e0Ts0SxDtQRxsit6/g0y2H7GtX97JmQP5wLdfdz+N4CV9QEDBE5bw2w==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39132b58ad8mr19705080f8f.0.1741766339076;
        Wed, 12 Mar 2025 00:58:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbaa94sm20390707f8f.14.2025.03.12.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:58:58 -0700 (PDT)
Message-ID: <e3f6e9a2e859e2c65ab960942543b8660f86edbc.camel@redhat.com>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	john.ogness@linutronix.de, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
	 <senozhatsky@chromium.org>
Date: Wed, 12 Mar 2025 08:58:56 +0100
In-Reply-To: <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: EfkwGAJ1ln2dQra_2HxOMyaidA8S4mzDvqD_S4m9mck_1741766339
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> Each RV monitor has one static buffer to send to the reactors. If
> multiple
> errors are detected at the same time, the one buffer could be
> overwritten.
>=20
> Instead, leave it to the reactors to handle buffering.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
> =C2=A0include/linux/printk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++---
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 61 ++++++------------------------
> --
> =C2=A0kernel/printk/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/reactor_panic.c=C2=A0 |=C2=A0 7 +---
> =C2=A0kernel/trace/rv/reactor_printk.c |=C2=A0 8 +++--
> =C2=A0kernel/trace/rv/rv_reactors.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A07 files changed, 26 insertions(+), 65 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 510c88bfabd4..c55d45544a16 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,58 +16,11 @@
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static char
> REACT_MSG_##name[1024];=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09snprintf(REACT_MSG_##name,
> 1024,=09=09=09=09=09=09=09\
> -=09=09 "rv: monitor %s does not allow event %s on state
> %s\n",=09=09=09\
> -=09=09
> #name,=09=09=09=09=09=09=09=09=09=09\
> -=09=09
> model_get_event_name_##name(event),=09=09=09=09=09=09\
> -=09=09
> model_get_state_name_##name(curr_state));=09=09=09=09=09\
> -=09return
> REACT_MSG_##name;=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static void cond_react_##name(char
> *msg)=09=09=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09if
> (rv_##name.react)=09=09=09=09=09=09=09=09=09\
> -
> =09=09rv_##name.react(msg);=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static bool
> rv_reacting_on_##name(void)=09=09=09=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09return
> rv_reacting_on();=09=09=09=09=09=09=09=09\
> -}
> -
> -#else /* CONFIG_RV_REACTOR */
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static inline char *format_react_msg_##name(type curr_state, type
> event)=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09return
> NULL;=09=09=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static void cond_react_##name(char
> *msg)=09=09=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09return;=09=09=09=09=09=09=09=09=09=09=09\
> -
> }=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> -static bool
> rv_reacting_on_##name(void)=09=09=09=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09return
> 0;=09=09=09=09=09=09=09=09=09=09\
> -}
> -#endif
> -

I don't think you need to remove those helper functions, why not just
having format_react_msg_ prepare the arguments for react?

cond_react might be mildly useful also for ltl, we may think about
putting it somewhere else and/or refactoring it a bit to include
reacting_on (which is indeed global and doesn't require a per-monitor
wrapper).

> =C2=A0/*
> =C2=A0 * Generic helpers for all types of deterministic automata monitors=
.
> =C2=A0 */
> =C2=A0#define DECLARE_DA_MON_GENERIC_HELPERS(name,
> type)=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09=09\
> -
> =09=09=09=09=09=09=09=09=09=09=09=09\
> =C2=A0/*=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0 * da_monitor_reset_##name - reset a monitor and setting it to init
> state=09=09=09\
> =C2=A0
> */=09=09=09=09=09=09=09=09=09=09=09=09\
> @@ -170,8 +123,11 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)=09=09=09=09\
> =C2=A0=09=09return
> true;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09}=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (rv_reacting_on_##name())=09=09=09=09=09=09=09=09\
> -
> =09=09cond_react_##name(format_react_msg_##name(curr_state, event));=09=
=09=09\
> +=09if (rv_reacting_on() &&
> rv_##name.react)=09=09=09=09=09=09\
> +=09=09rv_##name.react("rv: monitor %s does not allow event
> %s on state %s\n",=09=09\
> +=09=09=09=09#name,=09=09=09=09
> =09=09=09=09\
> +=09=09=09=09model_get_event_name_##name(event),
> =09=09=09=09\
> +=09=09=09=09model_get_state_name_##name(curr_sta
> te));=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09trace_error_##name(model_get_state_name_##name(curr_state),
> =09=09=09=09\
> =C2=A0=09=09=09=C2=A0=C2=A0
> model_get_event_name_##name(event));=09=09=09=09=09\
> @@ -202,8 +158,11 @@ static inline bool da_event_##name(struct
> da_monitor *da_mon, struct task_struct
> =C2=A0=09=09return
> true;=09=09=09=09=09=09=09=09=09\
> =C2=A0=09}=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> -=09if
> (rv_reacting_on_##name())=09=09=09=09=09=09=09=09\
> -
> =09=09cond_react_##name(format_react_msg_##name(curr_state, event));=09=
=09=09\
> +=09if (rv_reacting_on() &&
> rv_##name.react)=09=09=09=09=09=09\
> +=09=09rv_##name.react("rv: monitor %s does not allow event
> %s on state %s\n",=09=09\
> +=09=09=09=09#name,=09=09=09=09
> =09=09=09=09\
> +=09=09=09=09model_get_event_name_##name(event),
> =09=09=09=09\
> +=09=09=09=09model_get_state_name_##name(curr_sta
> te));=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09
> =09=09=09=09\
> =C2=A0=09trace_error_##name(tsk-
> >pid,=09=09=09=09=09=09=09=09\
> =C2=A0=09=09=09=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),=09=09=09=09\
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index a91bdf802967..28afdeb58412 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -71,7 +71,6 @@ int vprintk_store(int facility, int level,
> =C2=A0=09=09=C2=A0 const char *fmt, va_list args);
> =C2=A0
> =C2=A0__printf(1, 0) int vprintk_default(const char *fmt, va_list args);
> -__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0void __printk_safe_enter(void);
> =C2=A0void __printk_safe_exit(void);
> diff --git a/kernel/trace/rv/reactor_panic.c
> b/kernel/trace/rv/reactor_panic.c
> index 0186ff4cbd0b..4addabc9bcf1 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -13,15 +13,10 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -static void rv_panic_reaction(char *msg)
> -{
> -=09panic(msg);
> -}
> -
> =C2=A0static struct rv_reactor rv_panic =3D {
> =C2=A0=09.name =3D "panic",
> =C2=A0=09.description =3D "panic the system if an exception is found.",
> -=09.react =3D rv_panic_reaction
> +=09.react =3D panic
> =C2=A0};

For the sake of verbosity, I would still keep a wrapper function around
panic, just to show directly from this file how should a react()
function look like, as well as allowing future modifications, if
needed. Not that the additional function call would be much of a
problem during panic, I believe.

Good improvement overall, thanks.

Gabriele

> =C2=A0
> =C2=A0static int __init register_react_panic(void)
> diff --git a/kernel/trace/rv/reactor_printk.c
> b/kernel/trace/rv/reactor_printk.c
> index 178759dbf89f..a15db3fc8b82 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -12,9 +12,13 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -static void rv_printk_reaction(char *msg)
> +static void rv_printk_reaction(const char *msg, ...)
> =C2=A0{
> -=09printk_deferred(msg);
> +=09va_list args;
> +
> +=09va_start(args, msg);
> +=09vprintk_deferred(msg, args);
> +=09va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_printk =3D {
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 7b49cbe388d4..885661fe2b6e 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -468,7 +468,7 @@ void reactor_cleanup_monitor(struct
> rv_monitor_def *mdef)
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */
> -static void rv_nop_reaction(char *msg)
> +static void rv_nop_reaction(const char *msg, ...)
> =C2=A0{
> =C2=A0}
> =C2=A0

