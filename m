Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3067273D73
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596317; cv=none; b=D1VmUMsXs68xopjO5KpRViqD+2xnjmAgt7Jipd1bWqta4ABQFs4qryOymOCHR9AbE4aiAZvkzxVeSTNUoC9rzHlwtkPbiK48pDR8gaVBF26lIPYFSco3uqxJD/xPl5eO1v4W+A9c3kkVJe6+YjhQtBgQVFFUoS+35Z/FdHOBo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596317; c=relaxed/simple;
	bh=fpYR4QW2wW4FCm4U/+NZJ7rN2EAA7+srDce8CyXSl8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcLMd/P83EKdAc+CMV1300Z9mfKMNVB832504rBVzSpuiTNX2ni/1zisUFEnbZBFMXInPuqh9Yb8CK+JzQtam29sn14JYT9H1l4UbVZ4RpSBSSnuyceDDnbxdNFBoIOBk2+lQCefuz7O5c2VrE1WMRxZSmhqBiNy2GhRLzt+bRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwC+vmJB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwC+vmJB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5eee40cc0so50416401cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596314; x=1759201114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgmFE8NyPxtWNVbnJjQRIewsFcDLkEA59+rLxuhJGiU=;
        b=LwC+vmJBhmXpRIHgL1OAhwJIH3uhKOHXvRHNnuVpd9l7quIFb9BJJqc1Ekg5K6D8yr
         c8h6Zoan9Ra4iAjFhLQ0sO1XM24k2xh/ffCWxxwCSg9XzV5nluKWCXa/mSQExNP/9eft
         DZ+QEOFXND6VT1ueQwr3Q2GvBhL0jLoAZxvyNaRdDnsS5WGsbVuln9Z1h6GSZIAfuT2H
         z9rporeVkKoafep3IwsK5uci5cylcXJFxfu2qeUKDoLgcyacAg7o6XrnyzQau1uf4suK
         /YBUdH8yRLzDT7VfiaFjC96jtWl/uejU2NSr9i4OaObFGplcTAlWnxW0jXZu3q1K+yow
         ep/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596314; x=1759201114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgmFE8NyPxtWNVbnJjQRIewsFcDLkEA59+rLxuhJGiU=;
        b=Ur5VRCMxjVA/T2JGnRzhmUrk+PxJSDEXM67Gff8zt3UZEyqLpeA1Kns0pYRIZOg3+D
         MNqhOcnBLp9k5I92jhrgCaRWQlzDBCV8YZjrvyl6mggqyJe2tAy/1/zlqC1tNZgcfp1i
         YVaAEo6OlRFRdwfOjCiHDdTQVbxlYP8fRceeo5vNx4QpkQGDOHpV0yTTMXRmk+uFiq9u
         PCKiwT92Bq0CdMstpFCRFzUTmCLK4v7IhdykXn5eALhRZ9rHSdG+J0w/XHrKaK6VYlOF
         +nQ1R3OwgftXcHivAlbFiTM9M4mKwCGpUHBKHQEfztMWWJIPIbQ7drt0Ke5XsykpYS+o
         /0+g==
X-Forwarded-Encrypted: i=1; AJvYcCXfC6bvEDwakuh3f1BnqdI/ICxjIsXWWIQdxKCiJF0wQF2W4OYpLGCZmPHHNjTtFhMmq5iWbWUGRyZeTOsX2cO6BKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9bbTOHUr5buQLkCqi2ttqqwpKFfuedrlQMfYLEYd2YZzRlws
	9siM2taFE7fSHr7CeCBE1Yzn1jmi6CfgHxQmXS3pvmTCYuKYuuFgU2S1ojf2kfA1AQ/8kHe57mL
	d5vWTeSnnkBIaKVeKaxjz9gojrTrYAhM=
X-Gm-Gg: ASbGncvFiothHx0VfsX+myGT5oRDSGHGpz/v4n2G37Oci5NGFHY5hlrFc9yZZ7iOpPd
	COWOz9Uoa7x8kbnk5UdI/YZSaxnNbEWjrxfVpw07ndWICbu0bxyGwoFC0EJkAd1+cLTPhrrqYW1
	WIPPMuwZehyNIkwkCWj9+6wnh5D00QyQ90odqmeux8HesO63CD0HZ1zu4A5Y0viofv8IHEvAATT
	W0l6vj0
X-Google-Smtp-Source: AGHT+IFZW7WjRGmacqszORYavQA2IQYjlmSFmAfp6CW27838ZxITwERU2my/dBd3yJuqWIRGlMZ7Z0AQrAQtSyA5Hg8=
X-Received: by 2002:a05:622a:180f:b0:4d3:5418:d53d with SMTP id
 d75a77b69052e-4d36e5df14cmr11781191cf.49.1758596314495; Mon, 22 Sep 2025
 19:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250911032823.19064-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 23 Sep 2025 10:58:23 +0800
X-Gm-Features: AS18NWCCUIeAZ-4H_0obSn-5cwL3SUq_PYAXZiA-NZ_PXafNwbJKkb_7jDbCEak
Message-ID: <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: surenb@google.com, hannes@cmpxchg.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A very gentle ping on this patch.
Best regards,
Thanks!

On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com>=
 wrote:
>
> Add trace point to psi triggers. This is useful to
> observe the psi events in the kernel space.
>
> One use of this is to monitor memory pressure.
> When the pressure is too high, we can kill the process
> in the kernel space to prevent OOM.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> V3:
> -export it in the tracefs;
> ---
> v2:
> -fix compilation error;
> -export the tp;
> -add more commit message;
> ---
>  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
>  kernel/sched/psi.c           |  4 ++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..db8b8f25466e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
>         TP_printk("cpu=3D%d", __entry->cpu)
>  );
>
> +#ifdef CONFIG_PSI
> +TRACE_EVENT(psi_event,
> +
> +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size),
> +
> +       TP_ARGS(aggregator, state, threshold, win_size),
> +
> +       TP_STRUCT__entry(
> +               __field(int,    aggregator)
> +               __field(int,    state)
> +               __field(u64,    threshold)
> +               __field(u64,    win_size)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->aggregator     =3D aggregator;
> +               __entry->state          =3D state;
> +               __entry->threshold      =3D threshold;
> +               __entry->win_size       =3D win_size;
> +       ),
> +
> +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window_siz=
e=3D%llu",
> +               __entry->aggregator, __entry->state, __entry->threshold,
> +               __entry->win_size)
> +);
> +#endif /* CONFIG_PSI */
> +
>  /*
>   * Following tracepoints are not exported in tracefs and provide hooking
>   * mechanisms only for testing and debugging purposes.
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 59fdb7ebbf22..5b7954b653ed 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -141,6 +141,8 @@
>  #include <linux/psi.h>
>  #include "sched.h"
>
> +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> +
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>                 if (now < t->last_event_time + t->win.size)
>                         continue;
>
> +               trace_psi_event(aggregator, t->state, t->threshold, t->wi=
n.size);
> +
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
>                         if (t->of)
> --
> 2.25.1
>
