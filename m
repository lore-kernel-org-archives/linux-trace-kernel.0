Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22263F6ABF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098892; cv=none; b=sIRvMs+ZfZw+/prED68PppvmsHYLgfJymIMHbgi6Ws132DV2pmMrESPZ9bsLElZCrDmof9sDitVDuBD7FKVYbvvXdopLoRZOSWJ855pL1NEGoF3VAxTt08BpZ8eXt2ik5UDT/PKO4tHUx5XbKp0ljuinAlACEKU5eg+38NZm8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098892; c=relaxed/simple;
	bh=w7PJ+r/AjgyFl3R6ERRoFzO4WHD/wObVO5Iv32Ja2kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDhlTVlI0q0U6ldH3G5ZR3GeZvjrL6APdHIAlKR4ILGTL+xjUu8CRAAi9FWMnR943jmi/T4dUfE5p3zaGbnCobw6SUb4abqS8jBoE0ywsJF3vJ+rGmH/h45aJvnxevMyS7K2OHv1K0y9Wf9i0KZJE/5vn/ATGhoHriwS3+eTxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE/DkXvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE/DkXvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769098872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JMjpoGClUjO/xgtPNC6JQ/CRmaEfUMxoPqMdu3Sai0=;
	b=gE/DkXvnLGYbx4elAbs0lpsypiTdePfqEMH8bBFgwowx1Bmr3xZuQIpDIWSU6zrlGSP4+Q
	JEYQ08yAZ60Rn++rCBHaL9FBmdfg5JVArBzoiZimoCA+6lRW/nhXuBC6aIeTP4m8OjF5hc
	0SvGatxRzPMrtw/4ROEKCJwny+zoxU4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-buh5mrcTOmap2iLXJJhRmA-1; Thu, 22 Jan 2026 11:21:10 -0500
X-MC-Unique: buh5mrcTOmap2iLXJJhRmA-1
X-Mimecast-MFC-AGG-ID: buh5mrcTOmap2iLXJJhRmA_1769098870
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50146430e1dso27875471cf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 08:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769098870; x=1769703670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JMjpoGClUjO/xgtPNC6JQ/CRmaEfUMxoPqMdu3Sai0=;
        b=gZbGqwd7eedNq9uJ67VcrrtkN+6Rcuv3aGdByGPOGo6IVl6VfBDC9ZBZ6u/rvJGZaC
         eMGlEO+cIGouGX4hxcc5+aNm2+BMfjH0fI21FZ7h3nzp8K5rGcx4UKfE3FQQj0wJHLOa
         fJVbW99KeuruWhoBoQI4Kf8cTL6QDOX2e11HGCf7Fc7ja7S5ne5VABBTNuwosQ+dpNkf
         Y+soGjra+oh+b+UV162FEcv4CjA0JGswhWgSp6lazSVgfW/BkibVELqT7nFiLgjIgJ9Q
         umMww5sywCgdAyESwP5gSDXLw9B41ILdLjEMoXVurfl9ua/fcCMBC4RndrtL9h6DOeHQ
         Nq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWccWWcyqdkGYrvUhsnP+QTdlm4MzMXso2xV27Z/nM6PXAAmS3x4iUYaaFB9jO5Hu5JQdoPGAx40EHTtoWemkJztfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBO5gJmSj46Pqg19wbjhxf4O3w6/v0zdWn7j1i3+aJXmWE2sN
	SlX9g63/+tsb7qQUg0LoEPb/skU+pjPtMhpAPbNUklZfV3eMRRQBEuyDIb0iMEdEScVrGu1RTYU
	bW6KmNlnWEyDc8qeG2TSofridGmLT0RihhJvyokdJPuUqDsK9KLdwFWn4XeBwXAiUw9V4Ii4ryx
	4qw5rXue5LyPdQ/1W6i4DFe2zu3O7STmUjYZWgfgk3/pOTW3HT
X-Gm-Gg: AZuq6aLmcxW5QPzc/5T+1VfmZ1rXp0Os0n1b9zf9ZZq/BBOIRe+B6K3ncVOhmRdhTam
	TGC6rdogM7W+WjyZ3iaXG/t8tR0BCXgGnZ3ODknOoMPZuczonLBfut1Pj2WpYNkcgAKiEhBkp7N
	ElBxirdU3pVIJXId6QMQJxrOXUqMFnKOwpLoIO6ilYxMHwiyHa9f0Ecgc1y0Xwmd2lc9mn5eEQg
	wh5UfPpc6TuEPHeA/2OjuGtXcs=
X-Received: by 2002:a05:622a:54d:b0:4ff:c17f:726 with SMTP id d75a77b69052e-502f77424e1mr1339161cf.15.1769098870125;
        Thu, 22 Jan 2026 08:21:10 -0800 (PST)
X-Received: by 2002:a05:622a:54d:b0:4ff:c17f:726 with SMTP id
 d75a77b69052e-502f77424e1mr1338551cf.15.1769098869419; Thu, 22 Jan 2026
 08:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814122141.109076-1-gpaoloni@redhat.com> <20251217133744.4a3a33cf@gandalf.local.home>
In-Reply-To: <20251217133744.4a3a33cf@gandalf.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Thu, 22 Jan 2026 17:20:58 +0100
X-Gm-Features: AZwV_QistqqYiLXzhriwN-3YkoLisECHwwhRRrdopxRJl8oXUJW4eG60gSpvwh0
Message-ID: <CA+wEVJZqEiR7PzK6DSaSxmAihf7v4kfq1ht9OTFFDUVnXixJWw@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R3DX-bGELKfdGTcSsj2teHH1hH0V3AjVdHy7rZaAmDU_1769098870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve

On Wed, Dec 17, 2025 at 7:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 14 Aug 2025 14:21:41 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> Hi Gabriele,
>
> As this patch is still sitting in patchwork, and I like the comments, I
> want to move it forward. I know we are still discussing posting
> requirements, but regardless of that, this has some good information that=
 I
> want to add anyway. But the patch itself needs some clean up.

Many thanks for this and I am very sorry for the late reply. Basically
for some reason this email went into my spam folder and I realized
about your reply when looking for a different email thread on the
lore website.

>
> Note, this email is about documenting the functions and has nothing to do
> with the discussions about requirements and such.
>
> First, the subject requires some changes. One, the tracing subsystem uses
> capitalized subjects. Two, the subject can be shorter:
>
>   tracing: Add kerneldoc to set_clr_event() functions

Noted thanks, I'll keep this in mind for this and future patches

>
>
> > As per Linux Kernel documentation guidelines
> > (https://docs.kernel.org/doc-guide/kernel-doc.html),
> > <<Every function that is exported to loadable modules using
> > EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
> > comment>>;
> > hence this patch adds detailed kernel-doc headers documentation
>
> Change logs should be in imperative mode and never say "this patch".

Noted, I'll switch to imperative.

>
> > for trace_array_set_clr_event(), trace_set_clr_event() and the
> > main functions in the respective call-trees that support their
> > functionalities.
> >
> > For each of the documented functions, as part of the extensive
> > description, a set of "Function's expectations" and "Assumptions
> > of Use" are described in a way that facilitate:
> >
> > 1) evaluating the current code and any proposed modification
> >    to behave as described;
> >
> > 2) writing kernel tests to verify the code to behave as described.
> >
>
> Actually, the above can simply be replaced with:
>
> Add kernedoc to the following functions:
>
>   <list of functions>

Ok noted, I will change it in the next revision

>
>
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> > Changes from v1:
> > - Added "Context:" information
> > - Added "Assumptions of Use"
> > - __ftrace_event_enable_disable Function's expectations have been
> >   rewritten to replace the soft mode flag with the soft mode reference
> >   counter
> > - Addressed other comments from https://lore.kernel.org/linux-trace-ker=
nel/20250620085618.4489-1-gpaoloni@redhat.com/T/#u
> > ---
> >  kernel/trace/trace_events.c | 150 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 133 insertions(+), 17 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 9f3e9537417d..9bad5e9669df 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -763,6 +763,58 @@ void trace_event_enable_tgid_record(bool enable)
> >       } while_for_each_event_file();
> >  }
> >
> > +/**
> > + * __ftrace_event_enable_disable - enable or disable a trace event
> > + * @file: trace event file associated with the event.
> > + * @enable: 0 or 1 respectively to disable/enable the event.
> > + * @soft_disable: 1 or 0 respectively to mark if the enable parameter =
IS or
> > + * IS NOT a soft enable/disable.
>
> The parameter description should be short oneliners. Any more detail shou=
ld
> be in the body of the kerneldoc. Also, please be consistent. @enable uses
> "0 or 1" and @soft_disable uses "1 or 0".

Ok I can change it to
"@soft_disable: 0 or 1 respectively if enable above IS NOT or IS soft"

>
>
> > + *
> > + * Function's expectations:
>
> Also, thinking about this particular function. It should describe what th=
e
> intent is. Something to the effect of:
>
>     This function is used to enable or disable trace events for a given
>     instance. The @file maps the event to a specific instance. Normally,
>     this will be called with @soft_disabled =3D 0, where @enable set to 1=
 will
>     enabled the event to start recording, and if @enable is set to 0, wil=
l
>     disable the event. The @enable is a on/off switch, where calling this
>     function multiple times with @enable =3D 1 will enable the event the
>     first time, and the then calling this with @enable =3D 0 will disable=
 the
>     event, regardless of the number of times it was called with @enable f=
or
>     a given @file.
>
>     As there are triggers that can enable tracing in a context that canno=
t
>     modify kernel text, the triggers when enabled must "soft enable" the
>     events before it has to enable them in one of those prohibited
>     contexts. The code would call this function with @soft_disable set
>     before it needs to enable the event. If the event is not already
>     enabled, the @file flags SOFT_DISABLED bit is set and the event is
>     enabled but the callback will see the SOFT_DISABLED set and not do
>     anything.
>
>     When the trigger needs the event to be fully enabled, it only needs t=
o
>     clear the SOFT_DISABLED flag, which will cause the event to start
>     recording.
>
>     Unlike the @enable flag, the @soft_disable has a counter, as multiple
>     triggers may need to use it. For every time this is called with
>     @enable=3D1 and @soft_disable=3D1, it requires a @enable=3D0 and
>     @soft_disable=3D1 to fully disable the event.
>
> The above can replace the below.

Yes. I think we can keep your description and format it as a bulleted list
to allow linking corresponding tests (e.g. KUnit). Basically it could be:

    This function is used to enable or disable trace events for a given
    instance. The @file maps the event to a specific instance.

    __ftrace_event_enable_disable behavior:
    1. Under normal operation (not in soft_mode), the function is called
    with @soft_disabled =3D 0, where @enable set to 1 will enable the
    event to start recording and @enable set to 0 will disable the event.

    2. The @enable is a on/off switch; when not in soft_mode, calling
    this function multiple times with @enable =3D 1 will enable the event
    the first time, then calling this with @enable =3D 0 will disable the
    event, regardless of the number of times it was called with @enable
    for a given @file.

    Note: as there are triggers that can enable tracing in a context that
    cannot modify kernel text, the triggers, when enabled, must "soft
    enable" the events before these can be enabled in one of those
    prohibited contexts.
    3. To do so this function must be called with @soft_disable =3D 1 and
    @enable =3D 1: If the event is not already enabled, the @file flags
    SOFT_DISABLED bit is set and the event is enabled but the callback
    will see the SOFT_DISABLED set and not do anything.

   4. When the trigger needs the event to be fully enabled, it only needs t=
o
   clear the SOFT_DISABLED flag, which will cause the event to start
   recording. This is achieved by calling the function with @soft_disable =
=3D 0
   and @enable =3D 1.

   6. Unlike the @enable flag, the @soft_disable has a counter, as multiple
   triggers may need to use it. For every time the function is called with
   @enable=3D1 and @soft_disable=3D1, the counter is increased and it requi=
res
   a corresponding times of invocations with @enable=3D0 and
   @soft_disable=3D1 to have the counter reach zero and hence to fully disa=
ble
   the event.

   7. If the trigger was previously fully enabled invoking the function wit=
h
   @soft_disable =3D 0 and @enable =3D 1, invoking the function with
   @soft_disable =3D 1 and @enable =3D 1 will not set the SOFT_DISABLED
   bit, hence the trigger will stay fully enabled but the @soft_disable cou=
nter
   will be increased.

   8. If the trigger was previously fully enabled (i.e. by an invocation wi=
th
   @soft_disable =3D 0 and @enable =3D 1) and the @soft_disable counter is
   not zero, an invocation with @soft_disable =3D 0 and @enable =3D 0 will
   set the the SOFT_DISABLED bit.

Note that I added point 7 and 8 to capture what happens when a soft_disable
enable command follows and normal mode enable command

>
> > + * - If soft_disable is 1 a soft mode reference counter associated wit=
h the
> > + *   trace event shall be increased or decreased according to the enab=
le
> > + *   parameter being 1 (enable) or 0 (disable) respectively.
> > + *   If the soft mode reference counter is > 0 before the increase or =
after
> > + *   the decrease, no other actions shall be taken.
> > + *
> > + * - if soft_disable is 1 and the soft mode reference counter is 0 bef=
ore
> > + *   the increase or after the decrease, an enable value set to 0 or 1=
 shall
> > + *   result in disabling or enabling the use of trace_buffered_event
> > + *   respectively.
> > + *
> > + * - If soft_disable is 1 and enable is 0 and the soft mode reference =
counter
> > + *   reaches zero and if the soft disabled flag is set (i.e. if the ev=
ent was
> > + *   previously enabled with soft_disable =3D 1), tracing for the trac=
e point
> > + *   event shall be disabled and the soft disabled flag shall be clear=
ed.
> > + *
> > + * - If soft_disable is 0 and enable is 0, tracing for the trace point=
 event
> > + *   shall be disabled only if the soft mode reference counter is 0.
> > + *   Additionally the soft disabled flag shall be set or cleared accor=
ding to
> > + *   the soft mode reference counter being greater than 0 or 0 respect=
ively.
> > + *
> > + * - If enable is 1, tracing for the trace point event shall be enable=
d (if
> > + *   previously disabled); in addition, if soft_disable is 1 and the s=
oft mode
> > + *   reference counter is 0 before the increase, the soft disabled fla=
g shall
> > + *   be set.
> > + *
> > + * - When enabling or disabling tracing for the trace point event
> > + *   the flags associated with comms and tgids shall be checked and, i=
f set,
> > + *   respectively tracing of comms and tgdis at sched_switch shall be
> > + *   enabled/disabled.
> > + *
> > + * Assumptions of Use:
> > + * - for thread-safe execution, event_mutex shall be locked before cal=
ling
> > + *   this function;
> > + * - the file input pointer is assumed to be a valid one;
> > + * - the enable input parameter shall not be set to any value other th=
an 0
> > + *   or 1.
> > + *
> > + * Context: process context.
>
> > + *
> > + * Return:
> > + * * 0 on success
> > + * * any error returned by the event register or unregister callbacks
>
> Note, the error document here should not reference other functions.
>
> Should just say "Negative on error" or something similar.
>
> > + */
>
>
> The rest can be updated similar.
>
> Are you OK with this, or would you prefer that I make these changes?

Yes I can take care of sending an updated patch. I guess that the rest of
kernel-doc headers below look good to you, so for consistency I will just
use a numbered bulleted list as done above....

Sorry again for the delay (I should look into the spam folder more frequent=
ly)

Thanks
Gab

>
> -- Steve
>
> >  static int __ftrace_event_enable_disable(struct trace_event_file *file=
,
> >                                        int enable, int soft_disable)
> >  {
> > @@ -1296,8 +1348,46 @@ static void remove_event_file_dir(struct trace_e=
vent_file *file)
> >       event_file_put(file);
> >  }
> >
> > -/*
> > - * __ftrace_set_clr_event(NULL, NULL, NULL, set) will set/unset all ev=
ents.
> > +/**
> > + * __ftrace_set_clr_event_nolock - enable or disable an event within a=
 system.
> > + * @tr: target trace_array containing the events list.
> > + * @match: target system or event name (NULL for any).
> > + * @sub: target system name (NULL for any).
> > + * @event: target event name (NULL for any).
> > + * @set: 1 to enable, 0 to disable.
> > + * @mod: target module name (NULL for any).
> > + *
> > + * Function's expectations:
> > + * - If mod is set, the mod name shall be sanitized by replacing all '=
-' with
> > + *   '_' to match the modules' naming convention used in the Kernel.
> > + *
> > + * - From the events' list in the input tr, the ensemble of events to =
be enabled
> > + *   or disabled shall be selected according to the input match, sub, =
event and
> > + *   mod parameters. Each of these parameters, if set, shall restrict =
the events
> > + *   ensemble to those with a matching parameter's name.
> > + *
> > + * - For each of the selected events the IGNORE_ENABLE flag shall be c=
hecked,
> > + *   and, if not set, ftrace_event_enable_disable shall be invoked pas=
sing the
> > + *   input set parameter to either enable or disable the event.
> > + *
> > + * Assumptions of Use:
> > + * - for thread-safe execution, event_mutex shall be locked before cal=
ling
> > + *   this function;
> > + * - the tr input pointer is assumed to be a valid one;
> > + * - the set input parameter shall not be set to any value other than =
0
> > + *   or 1.
> > + *
> > + * NOTE: __ftrace_set_clr_event_nolock(NULL, NULL, NULL, set, NULL) wi=
ll
> > + * set/unset all events.
> > + *
> > + * Context: process context.
> > + *
> > + * Return:
> > + * * 0 on success
> > + * * %-EINVAL - the input parameters do not match any registered event
> > + * * %-ENOMEM -  memory allocation fails for the module pointer
> > + * * any value returned by the first call to ftrace_event_enable_disab=
le that
> > + * returned an error
> >   */
> >  static int
> >  __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *matc=
h,
> > @@ -1440,16 +1530,32 @@ int ftrace_set_clr_event(struct trace_array *tr=
, char *buf, int set)
> >  }
> >
> >  /**
> > - * trace_set_clr_event - enable or disable an event
> > - * @system: system name to match (NULL for any system)
> > - * @event: event name to match (NULL for all events, within system)
> > - * @set: 1 to enable, 0 to disable
> > + * trace_set_clr_event - enable or disable an event within a system.
> > + * @system: system name (NULL for any system).
> > + * @event: event name (NULL for all events, within system).
> > + * @set: 1 to enable, 0 to disable.
> >   *
> >   * This is a way for other parts of the kernel to enable or disable
> >   * event recording.
> >   *
> > - * Returns 0 on success, -EINVAL if the parameters do not match any
> > - * registered events.
> > + * Function's expectations:
> > + * - This function shall retrieve the pointer of the global trace arra=
y (global
> > + *   tracer) and pass it, along the rest of input parameters, to
> > + *   __ftrace_set_clr_event_nolock.
> > + *
> > + * - This function shall properly lock/unlock the global event_mutex
> > + *   before/after invoking ftrace_set_clr_event_nolock.
> > + *
> > + * Assumptions of Use:
> > + * - the set input parameter shall not be set to any value other than =
0
> > + *   or 1.
> > + *
> > + * Context: process context, locks and unlocks event_mutex.
> > + *
> > + * Return:
> > + * * 0 on success
> > + * * %-ENODEV - the global tracer cannot be retrieved
> > + * * any other error condition returned by __ftrace_set_clr_event_nolo=
ck
> >   */
> >  int trace_set_clr_event(const char *system, const char *event, int set=
)
> >  {
> > @@ -1463,17 +1569,27 @@ int trace_set_clr_event(const char *system, con=
st char *event, int set)
> >  EXPORT_SYMBOL_GPL(trace_set_clr_event);
> >
> >  /**
> > - * trace_array_set_clr_event - enable or disable an event for a trace =
array.
> > - * @tr: concerned trace array.
> > - * @system: system name to match (NULL for any system)
> > - * @event: event name to match (NULL for all events, within system)
> > - * @enable: true to enable, false to disable
> > + * trace_array_set_clr_event - enable or disable an event within a sys=
tem for
> > + * a trace array.
> > + * @tr: input trace array.
> > + * @system: system name (NULL for any system).
> > + * @event: event name (NULL for all events, within system).
> > + * @enable: true to enable, false to disable.
> >   *
> > - * This is a way for other parts of the kernel to enable or disable
> > - * event recording.
> > + * This is a way for other parts of the kernel to enable or disable ev=
ent
> > + * recording.
> > + *
> > + * Function's expectations:
> > + * - This function shall properly lock/unlock the global event_mutex
> > + *   before/after invoking ftrace_set_clr_event_nolock passing along t=
he same
> > + *   input parameters.
> > + *
> > + * Context: process context, locks and unlocks event_mutex.
> >   *
> > - * Returns 0 on success, -EINVAL if the parameters do not match any
> > - * registered events.
> > + * Return:
> > + * * 0 on success
> > + * * %-ENOENT - the input tr is NULL
> > + * * any other error condition returned by __ftrace_set_clr_event_nolo=
ck
> >   */
> >  int trace_array_set_clr_event(struct trace_array *tr, const char *syst=
em,
> >               const char *event, bool enable)
>

