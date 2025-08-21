Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76712EAB7A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766154; cv=none; b=jhLovQcvviOngpM8luDpMkoEJN5LMiB3VYDoSErdEsDpfl772E7OeslPsTmbcqBDNrduLVu9IBoqdK/dFg0ks1+kvyQAPZG7zO95Qp5i/4424TLMh4Nu/RhIsYht8oyfGJMLNnawGHLXe1MWSTjz+FR6KDzDUh+D6vpCQtRzmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766154; c=relaxed/simple;
	bh=0nk8OMCu5Z6u+OMPTHG8UtBRoBdjydf8YYmfl7FcRgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbQXl585RLaZWj8k9YGz/gqX5FxukUzbFq6M9DFw7o6Y5cEgt9BHMYL/WG+qqTQ/VTPyoms+GDdbmOJ/Dt0+QFqscDlu4354BDQ0WsTZ0Y/nHyv+OJQ7nVN5B8fDGb7dq6x8TMyG9c/RDYG2W/u+7PvYdm4TmdL7nBwcTfmbQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4Wv1diL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4Wv1diL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0nk8OMCu5Z6u+OMPTHG8UtBRoBdjydf8YYmfl7FcRgY=;
	b=N4Wv1diLvl/N2l8kYlMQMW15LNtLHpgWM+KTFyV7BSVyAO0LixaEJ/pqHWI4xwX+zGTmKG
	rwT8dpsneVuqgy1s8DhIuP3YEKszzNTXG0jdhiBWWqr/Rt7Drmf99isV+rctZi74cp3zaz
	AmZkV+5q//4DzJVnHBYm5ioNv5WaUhA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-HIMF-x4fNvGNzZm25MI-FQ-1; Thu, 21 Aug 2025 04:49:10 -0400
X-MC-Unique: HIMF-x4fNvGNzZm25MI-FQ-1
X-Mimecast-MFC-AGG-ID: HIMF-x4fNvGNzZm25MI-FQ_1755766150
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a927f570eso16684886d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766150; x=1756370950;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTKLkckZPZY51u66Qc8K7yv1S+qlB6sfl+ajIB2L21c=;
        b=Lxc3YkUVFLblQcTa00en5lp7+AYEic7+XNhqILFv7N4d7Pij9D9PA9NXM/EuAn1rX6
         Ej7aKybABQWdeKVQIW/s27JxY0ee1lpNAMFcszM98qDEsqxNvmEBV0BfpH5YzWnz5pDp
         1j6UkzLy2HiC4NGR7rSQzDD7Vx0B1DUi/SadgQwLswHPeSglzJPtPQLmcGOunic9U7TI
         kqWyFb1ym+RnN19yvvERFz2io92nvb+Q20mw2K9FqQDk41tDJmNDv4L/vrTqWmryvRAe
         zzOeJdPoftxaiZmS910JrK8z+z6sqlP9bQItZ79W7u0BjkKYkGWf0qlNwQwAQjyoto69
         Gq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBJWSdjNDbqOilJrT6//NJV+MvMGNikKe+sdNYpSW/LvyXzTj4DL0CbS6GICZORlUbAShbJ8I/EGveDyZPowoj8no=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVdzP1cUZ7uQRlswHs8J5LZqkxLuGLvJkBNwXRa0Mn6G+nt4s
	F4xOEeNBdx4G1jYsOHbBVk0JC8zeJWX1ib4psAT1ube9cF7ykgzTGRjoXkmPd7AdXVJfrfU6Glq
	35r6h4iprS3q9umGL1JSSPjTuBPlf/TINz+PV8PxTMNF9Rkxat17gvDTHgbWNMxNxyJr9AYr4hQ
	==
X-Gm-Gg: ASbGnct6m9EMXqgl0dQi/phoLwWKx6gtaPRdZkbYHI1JAZK/WkBHgSgzSD9eo4YSfL9
	AVlMcvCB/sh5lbt8Nvn80R3WlUC7RAxlVLhbpgdd1R5znbeHn0+6eYirN+BsbQW6fhPp0Dp5yhQ
	+LnaATun6L0IXKgaF5P/qTNugmj63GNVrVg70g62U6fKQtrpvE5/D4kVvEC+ptjwwP1PuAvxkAX
	HgS3ZRF5fWjy7lFADgHLZH+sYtr3KcgNElhYVXtDBkkbmqG1E4+Z4oia4tXmuXqKpT7bWe1zFeV
	ihWAW0VDzh8prg64p0lhYgbH9GS6Iff6abzpi8edEtAwDY5EHJ2BMdv3w6U4KssxpQ==
X-Received: by 2002:a05:6214:262c:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d89015a8dmr13934056d6.46.1755766149731;
        Thu, 21 Aug 2025 01:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF55/vnQ1tNaDKPCQMGQodL9V8M4CDiEKuWbmEd0QOQ3dzp5Pd6zW34uVKscpzQ5WOnG93Cg==
X-Received: by 2002:a05:6214:262c:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d89015a8dmr13933856d6.46.1755766149083;
        Thu, 21 Aug 2025 01:49:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f4d7sm100681526d6.2.2025.08.21.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:49:08 -0700 (PDT)
Message-ID: <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 10:49:05 +0200
In-Reply-To: <20250821081405.RQhrWVKp@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-2-gmonaco@redhat.com>
	 <20250821081405.RQhrWVKp@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OOEw0Dwi_snruod4I5JPjqJdLiH0AKcXoEE3dkVcK6M_1755766150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-21 at 10:14 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:07:53PM +0200, Gabriele Monaco wrote:
> > The da_monitor helper functions are generated from macros of the
> > type:
> >
> > DECLARE_DA_FUNCTION(name, type) \
> > static void da_func_x_##name(type arg) {} \
> > static void da_func_y_##name(type arg) {} \
> >
> > This is good to minimise code duplication but the long macros made
> > of skipped end of lines is rather hard to parse. Since functions
> > are static, the advantage of naming them differently for each
> > monitor is minimal.
> >
> > Refactor the da_monitor.h file to minimise macros, instead of
> > declaring functions from macros, we simply declare them with the
> > same name for all monitors (e.g. da_func_x) and for any remaining
> > reference to the monitor name (e.g. tracepoints, enums, global
> > variables) we use the CONCATENATE macro.

...
> > +#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
> > +#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
> > +#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
> > +#define events CONCATENATE(events_, MONITOR_NAME)
> > +#define states CONCATENATE(states_, MONITOR_NAME)
>
> I think these macros make it harder to read the code. E.g. it is not
> obvious what is "events" in "enum events event".
>
> How about renaming these to be the same for all monitors, and get rid
> of these 4 macros?
>
> Something like
>
> =09enum states_wip -> enum da_states
> =09state_max_wip=C2=A0=C2=A0 -> da_state_max
> =09etc
>
> Just my preference, of course. You probably have your reasons for
> doing it this way?

I think the reason was mostly laziness / wish to change less things.
This would require to change a bit more in each monitor's header and
rvgen, but since I'm already changing those, it should be no problem.

I assume the compiler would be just fine with the change and I don't see
a use-case where one would grab multiple definitions of those enums to
get a clash.

Good point, I'll look into that.

> > +/*
> > + * model_get_state_name - return the (string) name of the given
> > state
> > + */
> > +static char *model_get_state_name(enum states state)
> > +{
> > +=09if ((state < 0) || (state >=3D STATE_MAX))
> > +=09=09return "INVALID";
>
> Just notice that this probably should be
> =09if (BUG_ON((state < 0) || (state >=3D STATE_MAX)))
>
> You shouldn't do it in this patch of course. I just want to note it
> down.

Mmh, I'm not quite sure about this one, sure it's not a good thing when
we try to get an invalid state/event, but isn't BUG a bit too much here?
We're handling things gracefully so the kernel is not broken (although
rv likely is).

If you really think we should note that, what about just WARN/WARN_ONCE ?

> > index 17fa4f6e5ea6..bc02334aa8be 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -13,97 +13,102 @@
> > =C2=A0
> > =C2=A0#include <rv/automata.h>
> > =C2=A0#include <linux/rv.h>
> > +#include <linux/stringify.h>
> > =C2=A0#include <linux/bug.h>
> > =C2=A0#include <linux/sched.h>
> > =C2=A0
> > +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> > +#define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
>
> These macros as well. Should we rename the monitors to be the same
> and get rid of the macros?
>
> I see you took this RV_MONITOR_NAME idea from LTL. But I'm starting
> to wonder if this is really a good idea.
>
> What do you think?

Same laziness, I'll look into that!
They are static so they won't ever be defined together, nor I see a
reason for them not to be static.

One thing to note is that by using the same names everywhere, the
symbols won't be as accessible from debug tools (gdb/BPF or whatever),
I'm not sure that's really an issue, but it's the only downside coming
to my mind.

> > +#if RV_MON_TYPE =3D=3D RV_MON_GLOBAL || RV_MON_TYPE =3D=3D RV_MON_PER_=
CPU
> > +
> > +static inline bool
> > +da_event(struct da_monitor *da_mon, enum events event)
> > +{
> > +=09enum states curr_state, next_state;
> > +
> > +=09curr_state =3D READ_ONCE(da_mon->curr_state);
> > +=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> > +=09=09next_state =3D model_get_next_state(curr_state,
> > event);
> > +=09=09if (next_state =3D=3D INVALID_STATE) {
> > +=09=09=09cond_react(curr_state, event);
> > +=09=09=09CONCATENATE(trace_error_,
> > MONITOR_NAME)(model_get_state_name(curr_state),
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_event_name(event));
> > +=09=09=09return false;
> > +=09=09}
> > +=09=09if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state))) {
> > +=09=09=09CONCATENATE(trace_event_,
> > MONITOR_NAME)(model_get_state_name(curr_state),
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_event_name(event),
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_get_state_name(next_state),
> > +=09=09=09=09=09=C2=A0=C2=A0
> > model_is_final_state(next_state));
> > +=09=09=09return true;
> > +=09=09}
> > +=09}
> > +
> > +=09trace_rv_retries_error(__stringify(MONITOR_NAME),
> > model_get_event_name(event));
> > +=09pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
> > +=09=09" retries reached for event %s, resetting monitor
> > %s",
> > +=09=09model_get_event_name(event),
> > __stringify(MONITOR_NAME));
> > +=09return false;
> > +}
>
> You have two da_event(), which is mostly similar, except the
> function's signature and the trace event. Would it be sane to unify
> them, and only putting the differences in #ifdef?
>
> Perhaps something like:
>
> #if RV_MON_TYPE =3D=3D RV_MON_GLOBAL || RV_MON_TYPE =3D=3D RV_MON_PER_CPU
>
> typedef struct {} monitor_target;
>
> static void da_trace_event(struct da_monitor *da_mon, monitor_target
> target,
> =09=09=09=C2=A0=C2=A0 enum events event, enum states curr, enum
> states next)
> {
> =09CONCATENATE(trace_event_,
> MONITOR_NAME)(model_get_state_name(curr_state),
> =09=09=C2=A0=C2=A0=C2=A0 model_get_event_name(event),
> =09=09=C2=A0=C2=A0=C2=A0 model_get_state_name(next_state),
> =09=09=C2=A0=C2=A0=C2=A0 model_is_final_state(next_state));
> }
>
> #elif RV_MON_TYPE =3D=3D RV_MON_PER_TASK
>
> typedef struct task_struct *monitor_target;
>
> static void da_trace_event(struct da_monitor *da_mon, struct
> task_struct *task,
> =09=09=09=C2=A0=C2=A0 enum events event, enum states curr, enum
> states next)
> {
> =09CONCATENATE(trace_event_, MONITOR_NAME)(task->pid,
> =09=09=C2=A0=C2=A0 model_get_state_name(curr_state),
> =09=09=C2=A0=C2=A0 model_get_event_name(event),
> =09=09=C2=A0=C2=A0 model_get_state_name(next_state),
> =09=09=C2=A0=C2=A0 model_is_final_state(next_state));
> }
>
> #endif
>
> static inline bool
> da_event(struct da_monitor *da_mon, monitor_target target, enum
> events event)
> {
> =09enum states curr_state, next_state;
>
> =09curr_state =3D READ_ONCE(da_mon->curr_state);
> =09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> =09=09next_state =3D model_get_next_state(curr_state,
> event);
> =09=09if (next_state =3D=3D INVALID_STATE) {
> =09=09=09cond_react(curr_state, event);
> =09=09=09da_trace_event(da_mon, event, target,
> curr_state, next_state);
> =09=09=09return false;
> =09=09}
> =09=09if (likely(try_cmpxchg(&da_mon->curr_state,
> &curr_state, next_state))) {
> =09=09=09da_trace_error(...);
> =09=09=09return true;
> =09=09}
> =09}
>
> =09trace_rv_retries_error(__stringify(MONITOR_NAME),
> model_get_event_name(event));
> =09pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
> =09=09" retries reached for event %s, resetting monitor
> %s",
> =09=09model_get_event_name(event),
> __stringify(MONITOR_NAME));
> =09return false;
> }
>
> Same for the other functions.

Mmh, that's been bugging me throughout every change, but I'm not sure
it's that simple, implicit monitors don't have a target at all, so all
function prototypes are different because that needs to propagate.
Now that I think about it, it may not be a big deal not to pass the
target at all and retrieve it from the da_mon (that's just pointer
arithmetic the compiler might even optimise out).

I'm not sure that would be as simple if per-cpu monitors stopped being
implicit (like they are in your patch: they do have a target), but that
may never happen.

I'll give it a shot, thanks for pointing that out!

Thanks again,
Gabriele

