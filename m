Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B625333F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463959; cv=none; b=q42h4+Oru0/5CN7aywJop4sKQ5PEvVXc9uiWF01u/SxjF+ASHcDjilz86CE+o17ORJ+YzJGMV5rnsvQjYFKoT5sfbZjSPJgowK8opifb26WK4HgI1SbosvyEGjvMUdQWwPayNpvIoI44YSF8FC1TQayjvsWn55eASpQdgWMZd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463959; c=relaxed/simple;
	bh=8u9Qf8DAyVnLgBL1BAQ7bJ/8OyB7sVxNOtB6nFzcscs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRCXk3hGhtBi5oq+hr5kkBb9di/UeRTDs+d/tZ3VL1/XMT+/K6Vu08Rf1lyZEtzwjr4tXP8Ixj7dwmS+gVGBq603pen02Z4AZLpODhqCx5Iik7oP+OQUvQBu79qrZvhRRHKt6P6vHOprYNwAcMIOT1th3zgey2B5z6I0vpwrnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jew7It8n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jew7It8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751463956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nzGM1dlehEBmeEpSlHweKlaaEOCqBU5H5nX/N5Y7Ic=;
	b=Jew7It8n/0VXbmpoRHQb4rKYH1vjTlab0ngbKSmQB1DXjoOpvWHRG14ewouQVPr9yC88AI
	Z23ExbiV0Lc2MZ38pto4sbZbcPMAA3HlYRMyBh87HTEnkHHwtFl//lTA4oV/sUSg12oW63
	aax3utSCzFqVGT4jQPpYhupJfISVrOg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-WEnqqdx2PKeXf5VhRGQ4vA-1; Wed, 02 Jul 2025 09:45:54 -0400
X-MC-Unique: WEnqqdx2PKeXf5VhRGQ4vA-1
X-Mimecast-MFC-AGG-ID: WEnqqdx2PKeXf5VhRGQ4vA_1751463954
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a77e31d163so43889111cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 06:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463954; x=1752068754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nzGM1dlehEBmeEpSlHweKlaaEOCqBU5H5nX/N5Y7Ic=;
        b=WBf4PkoGMGc4ZvDf2Hgky3yaX59lsb+gzUuGuUlxA/q5zAy80olVLJVOX2J7VUYX3J
         YmUuRHm3XdB0kv/JJ2ArHMF3Fe96zKmYd0xKGkNLnKNlRZbTiYhJOA3hUo+etX5YTqgu
         yHrGJGzCGgxRgVowRa0uTXMRoIuiF3+xk8CNeFtZRPc0nCv2IrRpUmNgmtRZEm+g9I0r
         CK6n1ojkmpDTXq6np2pYnP3emh0CJNUs+HKlUWDvAtE3wH8dSl85pa3lHZviJ4nCBO4Q
         8hzG5yX0rx51cBEIbHfpWXYYLU9VIdZ5hV8klp8bNeEdAKES54A8EweSTA//5dnLGzwY
         5Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCXIOE14+///vxZLjiJSQX0fbP/bYUMwvj8LaIkPteZx6vMO7ts+DESHA3e170Ixh+b1cEFSIRoDhVOFly23yuHoajY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aHUG8zDyuqz/sbnB4YwrTUazDBIw9D7aXaQL7O8++pSmksWn
	XuqjGWQnBwsj2ZHVIXq2ndFbZCAYOYbttJpuhXfl0g3B9WoAnqnJdLnub8WBV22N0B3XjXuafX5
	dhIXUqClS10WStVJIvAGmWvidRE5ruBiZKT/bqI5cOwz2c8gUekXMlOVzPD4aqeE4KIj6mSP4xJ
	28PRsGjGCKD5fxedAwYs+x8psAU3tmqWx/fpZwlsfo7NF2QAkc
X-Gm-Gg: ASbGncsWfgUv+NPY7FiTdCAQBj5fh5OTRRZ+sYTzageoRdM85TnfByVzwzdIvLukT1t
	a8kpTVjYtvkK7u+gP/kbRffiAU3NQYGWfpXimt6aNpX2elfJD0GGVfYAYc7hxjGTJzMIOgkEOyV
	mJUWGUcG040LlPsT7/CWHh9WorM1E9+JY/IMjR
X-Received: by 2002:a05:622a:4818:b0:4a6:ded5:3d62 with SMTP id d75a77b69052e-4a9768b5572mr41766091cf.9.1751463953182;
        Wed, 02 Jul 2025 06:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWWtZVKx5fXIrRfAlsWmy/44wHP/k2Ly2v2p19YYL7wyYAokSZ3ve58bfy9iDjapL+dYCF5bm0irryd6vCVL0=
X-Received: by 2002:a05:622a:4818:b0:4a6:ded5:3d62 with SMTP id
 d75a77b69052e-4a9768b5572mr41765701cf.9.1751463952674; Wed, 02 Jul 2025
 06:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085618.4489-1-gpaoloni@redhat.com> <20250701195939.3e297e20@gandalf.local.home>
In-Reply-To: <20250701195939.3e297e20@gandalf.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 2 Jul 2025 15:45:41 +0200
X-Gm-Features: Ac12FXzaoj0JCj2YIlLuiPzae-grwKdgkAOETspd5fkGO1Lj_S1SFUvMoU3TDQg
Message-ID: <CA+wEVJY2a_ERXemup7EefPPXHOv8DAfyauuP6Mn5vHYFkbbBcQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9HebolJuR1vOJSYxRsBWGhLV_SI_N8cYzJihaIPI03E_1751463954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven, many thanks for looking into this

On Wed, Jul 2, 2025 at 1:59=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
>
> FYI, I know some maintainers prefer a "RESEND" of a patch, but I personal=
ly
> prefer a simple "ping" reply to the patch. Actually, I'll take either, bu=
t
> my workflow is with patchwork[1] and I tend to give older patches in
> patchwork priority. By sending a patch again via "RESEND" that patch will
> supersede the older patch which actually pushes the patch further down in=
to
> the queue, which makes it even longer for me to see it (having the opposi=
te
> effect of the purpose of sending "RESEND").

Apologies, next time I'll ping instead of RESENDing (I recently
started following
this mailing list, so I was not aware).

>
> [1] https://patchwork.kernel.org/project/linux-trace-kernel/list/
>
> On Fri, 20 Jun 2025 10:56:18 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > As per Linux Kernel documentation guidelines
> > (https://docs.kernel.org/doc-guide/kernel-doc.html),
> > <<Every function that is exported to loadable modules using
> > EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
> > comment>>; hence this patch adds detailed kernel-doc headers
> > documentation for trace_array_set_clr_event, trace_set_clr_event
>
>
> When referencing functions, please add parenthesis "func()" when naming
> them.

Thanks, I'll change the commit msg in v2.


>
> > and the main functions in the respective call-trees that support
> > their functionalities.
>
> Also add newlines in the change log, to make it visually easier to read.

got it, will change in v2.

>
> > For each of the documented functions, as part of the extensive
> > description, a set of "Function's expectations" are described in
> > a way that facilitate:
> > 1) evaluating the current code and any proposed modification
> >    to behave as described;
> > 2) writing kernel tests to verify the code to behave as described.
> >
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> > Re-sending as no feedbacks have been received.

Now that I am reading this I realized that I missed the most important
discussion comments from v1, so I am adding them back here inline
below (BTW one more reason to avoid RESENDs):

While working on the documentation of __ftrace_event_enable_disable,
I realized that the EVENT_FILE_FL_SOFT_MODE flag is mainly used
internally in the function itself, whereas it is EVENT_FILE_FL_SOFT_DISABLE=
D
that prevents tracing the event.
In this perspective I see that, starting from the initial state, if for
a specific event we invoke __ftrace_event_enable_disable with enable=3D1
and soft_disable=3D0, the EVENT_FILE_FL_ENABLED is set whereas
EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED are not.
Now if for that event we invoke __ftrace_event_enable_disable again with
enable=3D1 and soft_disable=3D1, EVENT_FILE_FL_ENABLED stays set,
EVENT_FILE_FL_SOFT_MODE is set, while EVENT_FILE_FL_SOFT_DISABLED
remains not set. Instead if from the initial state we directly invoke
__ftrace_event_enable_disable with enable=3D1 and soft_disable=3D1, all
the status flag mentioned above are all set (EVENT_FILE_FL_ENABLED,
EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED).
Now I wonder if:
a) such a behaviour is consistent with the code expectation;
b) if it would make sense to have a standard enable invocation followed
   by a soft enable invocation to end up in the same state as a single
   invocation of soft enable;
c) eventually if we could get rid of the soft_mode flag and simplify
   the code to only use the soft_disabled flag.

Probably there are aspects that I am missing and I really appreciate
your inputs/views.

> > ---
> >  kernel/trace/trace_events.c | 125 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 109 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 120531268abf..4bd1f6e73ef1 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -763,6 +763,54 @@ void trace_event_enable_tgid_record(bool enable)
> >       } while_for_each_event_file();
> >  }
> >
> > +/*
>
> If you are going to use kerneldoc comments, might as well make it a
> kerneldoc format: /**

Uh this is bad, sorry I'll fix this in v2.

>
> > + * __ftrace_event_enable_disable - enable or disable a trace event
> > + * @file: trace event file associated with the event.
> > + * @enable: 0 or 1 respectively to disable/enable the event (any other=
 value is
> > + * invalid).
>
> Saying 0 or 1 should assume that those are the only values. Don't need th=
e
> content in the parenthesis.

Agreed, I'll remove it in v2.

>
> > + * @soft_disable: 1 or 0 respectively to mark if the enable parameter =
IS or
> > + * IS NOT a soft enable/disable.
> > + *
> > + * Function's expectations:
> > + * - If soft_disable is 1 a reference counter associated with the trac=
e
> > + * event shall be increased or decreased according to the enable param=
eter
> > + * being 1 (enable) or 0 (disable) respectively.
> > + * If the reference counter is > 0 before the increase or after the de=
crease,
> > + * no other actions shall be taken.
>
> Although this has newlines (which I like!), the indentation should be wit=
h
> the first word after the hyphen. That is, instead of:
>
>  * - If soft_disable is 1 a reference counter associated with the trace
>  * event shall be increased or decreased according to the enable paramete=
r
>  * being 1 (enable) or 0 (disable) respectively.
>  * If the reference counter is > 0 before the increase or after the decre=
ase,
>  * no other actions shall be taken.
>
> It should be:
>
>  * - If soft_disable is 1 a reference counter associated with the trace
>  *   event shall be increased or decreased according to the enable parame=
ter
>  *   being 1 (enable) or 0 (disable) respectively.
>  *   If the reference counter is > 0 before the increase or after the dec=
rease,
>  *   no other actions shall be taken.
>
> Making it easier to read.

Agreed, will be changed in v2.

>
> > + *
> > + * - if soft_disable is 1 and the trace event reference counter is 0 b=
efore
> > + * the increase or after the decrease, an enable value set to 0 or 1 s=
hall set
> > + * or clear the soft mode flag respectively; this is characterized by =
disabling
> > + * or enabling the use of trace_buffered_event respectively.
> > + *
> > + * - If soft_disable is 1 and enable is 0 and the reference counter re=
aches
> > + * zero and if the soft disabled flag is set (i.e. if the event was pr=
eviously
> > + * enabled with soft_disable =3D 1), tracing for the trace point event=
 shall be
> > + * disabled and the soft disabled flag shall be cleared.
>
> Would it be possible to group the requirements within "If soft_disable is
> 1"? Seeing three different lines starting with the same state seems
> inefficient.

Possibly yes but IMO it would not save much; e.g:
  - if soft_disable is 1:
    - if the trace event reference counter is 0 before the increase or afte=
r
      the decrease, an enable value set to 0 or 1 shall set or clear the so=
ft
      mode flag respectively; this is characterized by disabling or enablin=
g
      the use of trace_buffered_event respectively.

    - if enable is 0 and the reference counter reaches zero and the soft
      disabled flag is set (i.e. if the event was previously enabled with
      soft_disable =3D 1), tracing for the trace point event shall be disab=
led
      and the soft disabled flag shall be cleared.

However IMO we can revisit this point after we have a discussion on the
considerations that were missed in the RESEND process and that are
now pasted above

>
> > + *
> > + * - If soft_disable is 0 and enable is 0, tracing for the trace point=
 event
> > + * shall be disabled only if the soft mode flag is clear (i.e. event p=
reviously
> > + * enabled with soft_disable =3D 0). Additionally the soft disabled fl=
ag shall be
> > + * set or cleared according to the soft mode flag being set or clear
> > + * respectively.
> > + *
> > + * - If enable is 1, tracing for the trace point event shall be enable=
d (if
> > + * previously disabled); in addition if soft_disable is 1 and the refe=
rence
> > + * counter is 0 before the increase, the soft disabled flag shall be s=
et.
> > + *
> > + * - When enabling or disabling tracing for the trace point event
> > + * the flags associated with comms and tgids shall be checked and, if =
set,
> > + * respectively tracing of comms and tgdis at sched_switch shall be
> > + * enabled/disabled.
> > + *
> > + * Returns 0 on success, or any error returned by the event register o=
r
> > + * unregister callbacks.

FYI I also noticed here that "Context" is missing and "Returns" should be
"Return:", so I'll fix this in v2

> > + *
> > + * NOTE: in order to invoke this code in a thread-safe way, event_mute=
x shall
> > + * be locked before calling it.
> > + * NOTE: the validity of the input pointer file shall be checked by th=
e caller
>
> I have to find some time to make sure the above is correct. I'm looking a=
t
> this more at a superficial level. And I'll look at the rest later.

Many Thanks!
Gab

>
> Cheers,
>
> -- Steve
>

