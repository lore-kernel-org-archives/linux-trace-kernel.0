Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD4248F61
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559533; cv=none; b=REnrLr4Zp+zUsCepLTUdgcfLTCJweYWwORGbx5IGcKudwS1xd2EAqKPd30c3CcugT3Ia55ASxkGjyfg1Hxdq5R4bWhRCJM7hLUaFC1ZoWIh5kwKBgxiGQlTiVRpRKzkxla2axzvySfR/u3AWsFP6DD6WCeKte7XIZFJwttHEaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559533; c=relaxed/simple;
	bh=jxQyvOa3dye11bIJyBNLjl4KyzfLe4LnaogqFZvlFh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWSyk0T0UjLwp4nd9dTzSGvPON5Z/uw9GycPwwSutApHM33FxlwXTUhVm0e1UzdN5i/nG9iDSDe2gJENrd5JeWPN34WLuAYn99xhwEuJ/XUcJnLOXffX/HUyxjBqvUozCxhW1p4ssSw0IhcGbPwszLNNmMVP3hzZ/5MZcFW2r80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXGJBgI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXGJBgI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751559530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDwS3Dy5k3eT0KkRIFcitGVxHhb3CTfKee9eY6nXsAk=;
	b=PXGJBgI/J3xVj3ciakJyfeJAqSzNklQE2MlKnB6AyHMDdDsf1EADjP+8BRE/YCxTeT+/Th
	jUUjkkUhG9yMrkPeCNwygXCAAYfNiSCPfm2WAbSkORIwNhN63uRjSWyAUWuIfGAnlzFFP2
	6mmWL5oPUmt6yWFJF1R0w6ZXdsRPB1g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-lrhqXJ6-NNKN0hf3yT-kgA-1; Thu, 03 Jul 2025 12:18:49 -0400
X-MC-Unique: lrhqXJ6-NNKN0hf3yT-kgA-1
X-Mimecast-MFC-AGG-ID: lrhqXJ6-NNKN0hf3yT-kgA_1751559529
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a43ae0dcf7so53391cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 09:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559528; x=1752164328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDwS3Dy5k3eT0KkRIFcitGVxHhb3CTfKee9eY6nXsAk=;
        b=ch9ra/owseLzp443Z6G5VLPgz24/9XV7CFd84IXwgvu8LQJeMHA5cE4WAoGLC+QZNv
         goiXDakQh/RsPOsCZvkuAKoxDTfhy81md3WPCoa1vtnSeuEVScR4rbpr+D44ivKN5TWn
         DTGOw8j4a20DpMx/ZVMUWf8cVCTFH1T3Pu7R5dAQtNl5WhXQI5WpjCf9zBt0DmHAYpIs
         juCo1TBjjQelXHq1MbiHZ4qdz4BZ8Fh89aU9oer/fLgX73Pxb3H9sy7D+LCwDrAJuqPG
         mTMKV/W+Aw0r5XSgKpMjVXnh1zJaPduEKX8P3VCYjx1uYwzBHoze3Jn9Lpb2U69EgFK8
         KJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfghzDG6z9SWScaOVIdT2EBjdwyfvaQ8reECwvDgQ5rIjUcXVbMkVAG+FRZ7zA/YUYaUztfKYqtFci2jODkZaAWhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqYVoXYe+hvlZgjjArsmqAcNfd/1czC/Lek9e5cVHuQfPhWDB
	EN60V5AX2E2P2WMsWqTFcG8Gp104W/umqrmjpSAc3Mv/MWvnkafwYdvhZHTf4xyWn9HoWHgkFvZ
	CVlb0LpuK1lrNTgL3z0GPOQ7C4HyWNBZAbf5TOdpFu7Cy41qZEoiF0z7wO5glGCG/H6MXz4nNK+
	SFv9MVnTI5Wzl15GB/NBsJ1IqGe83+NmbLlqozFLKcRrIOLpUx+krR1RFkjBt+hg==
X-Gm-Gg: ASbGncuYIw0e1d9BsnoXYuAng6281nY8tgONaUhyaBNc445mQBUkozekWELzhMjK3Mt
	hmyWs+JxMGfAwpqVAXHcFJlbQkGe1zh6yBdrjj/xAzO08Pxfzr+gNuBKmtEuU6vhRtrV55zLhWu
	je0GMP5O7sVyZdvqijoZttNCa/fBrP9meyVd84
X-Received: by 2002:ac8:58d2:0:b0:4a9:7a4e:7e9c with SMTP id d75a77b69052e-4a992e320f1mr18779871cf.35.1751559528128;
        Thu, 03 Jul 2025 09:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECyAyqyGCB8mwdXH1M5kkQYyJWQyh3CoU2JPp20fMY4WXi5fXsL5rkhek8mqOtVk8qiCaEXxio7f7CAJdjGUM=
X-Received: by 2002:ac8:58d2:0:b0:4a9:7a4e:7e9c with SMTP id
 d75a77b69052e-4a992e320f1mr18778961cf.35.1751559527445; Thu, 03 Jul 2025
 09:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702143657.18dd1882@batman.local.home>
In-Reply-To: <20250702143657.18dd1882@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Thu, 3 Jul 2025 18:18:36 +0200
X-Gm-Features: Ac12FXyGEsZlFIT9p6ZMWW0ItcRE7JF4USUE3ISLrvC_zkk8QMfTZsj-ifpCh4o
Message-ID: <CA+wEVJYeDACQTO8g2L9_ZAM0mC2JwBm_pDahiGVmfc=c43caAA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RIMz1WCRCmcBB3EqmTSKsC9Xy3d8attVD4Aa4aZguMM_1751559529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 8:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> When soft disabling of trace events was first created, it needed to have =
a
> way to know if a file had a user that was using it with soft disabled (fo=
r
> triggers that need to enable or disable events from a context that can no=
t
> really enable or disable the event, it would set SOFT_DISABLED to state i=
t
> is disabled). The flag SOFT_MODE was used to denote that an event had a
> user that would enable or disable it via the SOFT_DISABLED flag.
>
> Commit 1cf4c0732db3c ("tracing: Modify soft-mode only if there's no other
> referrer") fixed a bug where if two users were using the SOFT_DISABLED
> flag the accounting would get messed up as the SOFT_MODE flag could only
> handle one user. That commit added the sm_ref counter which kept track of
> how many users were using the event in "soft mode". This made the
> SOFT_MODE flag redundant as it should only be set if the sm_ref counter i=
s
> non zero.
>
> Remove the SOFT_MODE flag and just use the sm_ref counter to know the
> event is in soft mode or not. This makes the code a bit simpler.
>
> Link: https://lore.kernel.org/all/20250702111908.03759998@batman.local.ho=
me/
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/trace_events.h |  3 ---
>  kernel/trace/trace_events.c  | 24 ++++++++++++------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index fa9cf4292dff..04307a19cde3 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -480,7 +480,6 @@ enum {
>         EVENT_FILE_FL_RECORDED_TGID_BIT,
>         EVENT_FILE_FL_FILTERED_BIT,
>         EVENT_FILE_FL_NO_SET_FILTER_BIT,
> -       EVENT_FILE_FL_SOFT_MODE_BIT,
>         EVENT_FILE_FL_SOFT_DISABLED_BIT,
>         EVENT_FILE_FL_TRIGGER_MODE_BIT,
>         EVENT_FILE_FL_TRIGGER_COND_BIT,
> @@ -618,7 +617,6 @@ extern int __kprobe_event_add_fields(struct dynevent_=
cmd *cmd, ...);
>   *  RECORDED_TGID - The tgids should be recorded at sched_switch
>   *  FILTERED     - The event has a filter attached
>   *  NO_SET_FILTER - Set when filter has error and is to be ignored
> - *  SOFT_MODE     - The event is enabled/disabled by SOFT_DISABLED
>   *  SOFT_DISABLED - When set, do not trace the event (even though its
>   *                   tracepoint may be enabled)
>   *  TRIGGER_MODE  - When set, invoke the triggers associated with the ev=
ent
> @@ -633,7 +631,6 @@ enum {
>         EVENT_FILE_FL_RECORDED_TGID     =3D (1 << EVENT_FILE_FL_RECORDED_=
TGID_BIT),
>         EVENT_FILE_FL_FILTERED          =3D (1 << EVENT_FILE_FL_FILTERED_=
BIT),
>         EVENT_FILE_FL_NO_SET_FILTER     =3D (1 << EVENT_FILE_FL_NO_SET_FI=
LTER_BIT),
> -       EVENT_FILE_FL_SOFT_MODE         =3D (1 << EVENT_FILE_FL_SOFT_MODE=
_BIT),
>         EVENT_FILE_FL_SOFT_DISABLED     =3D (1 << EVENT_FILE_FL_SOFT_DISA=
BLED_BIT),
>         EVENT_FILE_FL_TRIGGER_MODE      =3D (1 << EVENT_FILE_FL_TRIGGER_M=
ODE_BIT),
>         EVENT_FILE_FL_TRIGGER_COND      =3D (1 << EVENT_FILE_FL_TRIGGER_C=
OND_BIT),
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..0980f4def360 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -768,6 +768,7 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>  {
>         struct trace_event_call *call =3D file->event_call;
>         struct trace_array *tr =3D file->tr;
> +       bool soft_mode =3D atomic_read(&file->sm_ref) !=3D 0;

I was checking why an atomic counter is needed here, and, since this
function should be called with
event_mutex locked, I think the atomic counter is not needed, so maybe
it should be removed...
On a different angle I also checked the callers of this function and
it seems that in some cases
event_mutex is not held when calling this function. E.g.:
trace_event_trigger_enable_disable() -> trace_event_enable_disable()
-> __ftrace_event_enable_disable()

In general it seems that all the callers of
trace_event_enable_disable() are outside trace_events.c, so maybe
the modification below could solve this issue and concurrently we
could replace the atomic sm_ref with a
standard one...?

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -880,7 +880,9 @@ static int __ftrace_event_enable_disable(struct
trace_event_file *file,
 int trace_event_enable_disable(struct trace_event_file *file,
                               int enable, int soft_disable)
 {
+       mutex_lock(&event_mutex);
        return __ftrace_event_enable_disable(file, enable, soft_disable);
+       mutex_unlock(&event_mutex);
 }

Thanks
Gab

>         int ret =3D 0;
>         int disable;
>
> @@ -782,7 +783,7 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>                  * is set we do not want the event to be enabled before w=
e
>                  * clear the bit.
>                  *
> -                * When soft_disable is not set but the SOFT_MODE flag is=
,
> +                * When soft_disable is not set but the soft_mode is,
>                  * we do nothing. Do not disable the tracepoint, otherwis=
e
>                  * "soft enable"s (clearing the SOFT_DISABLED bit) wont w=
ork.
>                  */
> @@ -790,11 +791,11 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
>                         if (atomic_dec_return(&file->sm_ref) > 0)
>                                 break;
>                         disable =3D file->flags & EVENT_FILE_FL_SOFT_DISA=
BLED;
> -                       clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->fla=
gs);
> +                       soft_mode =3D false;
>                         /* Disable use of trace_buffered_event */
>                         trace_buffered_event_disable();
>                 } else
> -                       disable =3D !(file->flags & EVENT_FILE_FL_SOFT_MO=
DE);
> +                       disable =3D !soft_mode;
>
>                 if (disable && (file->flags & EVENT_FILE_FL_ENABLED)) {
>                         clear_bit(EVENT_FILE_FL_ENABLED_BIT, &file->flags=
);
> @@ -812,8 +813,8 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>
>                         WARN_ON_ONCE(ret);
>                 }
> -               /* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else c=
lear it */
> -               if (file->flags & EVENT_FILE_FL_SOFT_MODE)
> +               /* If in soft mode, just set the SOFT_DISABLE_BIT, else c=
lear it */
> +               if (soft_mode)
>                         set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->f=
lags);
>                 else
>                         clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file-=
>flags);
> @@ -823,7 +824,7 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>                  * When soft_disable is set and enable is set, we want to
>                  * register the tracepoint for the event, but leave the e=
vent
>                  * as is. That means, if the event was already enabled, w=
e do
> -                * nothing (but set SOFT_MODE). If the event is disabled,=
 we
> +                * nothing (but set soft_mode). If the event is disabled,=
 we
>                  * set SOFT_DISABLED before enabling the event tracepoint=
, so
>                  * it still seems to be disabled.
>                  */
> @@ -832,7 +833,7 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>                 else {
>                         if (atomic_inc_return(&file->sm_ref) > 1)
>                                 break;
> -                       set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags=
);
> +                       soft_mode =3D true;
>                         /* Enable use of trace_buffered_event */
>                         trace_buffered_event_enable();
>                 }
> @@ -840,7 +841,7 @@ static int __ftrace_event_enable_disable(struct trace=
_event_file *file,
>                 if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
>                         bool cmd =3D false, tgid =3D false;
>
> -                       /* Keep the event disabled, when going to SOFT_MO=
DE. */
> +                       /* Keep the event disabled, when going to soft mo=
de. */
>                         if (soft_disable)
>                                 set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, =
&file->flags);
>
> @@ -1792,8 +1793,7 @@ event_enable_read(struct file *filp, char __user *u=
buf, size_t cnt,
>             !(flags & EVENT_FILE_FL_SOFT_DISABLED))
>                 strcpy(buf, "1");
>
> -       if (flags & EVENT_FILE_FL_SOFT_DISABLED ||
> -           flags & EVENT_FILE_FL_SOFT_MODE)
> +       if (atomic_read(&file->sm_ref) !=3D 0)
>                 strcat(buf, "*");
>
>         strcat(buf, "\n");
> @@ -3584,7 +3584,7 @@ static int probe_remove_event_call(struct trace_eve=
nt_call *call)
>                         continue;
>                 /*
>                  * We can't rely on ftrace_event_enable_disable(enable =
=3D> 0)
> -                * we are going to do, EVENT_FILE_FL_SOFT_MODE can suppre=
ss
> +                * we are going to do, soft mode can suppress
>                  * TRACE_REG_UNREGISTER.
>                  */
>                 if (file->flags & EVENT_FILE_FL_ENABLED)
> @@ -3997,7 +3997,7 @@ static int free_probe_data(void *data)
>
>         edata->ref--;
>         if (!edata->ref) {
> -               /* Remove the SOFT_MODE flag */
> +               /* Remove soft mode */
>                 __ftrace_event_enable_disable(edata->file, 0, 1);
>                 trace_event_put_ref(edata->file->event_call);
>                 kfree(edata);
> --
> 2.47.2
>
>

