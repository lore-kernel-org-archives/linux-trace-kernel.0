Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2850158DAC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759187846; cv=none; b=HfVLs5QjVHVtM4KkERAInMBMXbO51Erhdy+/YNewJMol/PKt2mJ8LT43yeYgKTPFkG1Y1T/ftX7U4BY5MP1TkMh7VNpLQpgogyK8nKkBQBzo2kauewgHlRs8OiBHlkg6op9P8eWsug4tHUvouSAXAWTQqIO81rDkXEx16KVBpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759187846; c=relaxed/simple;
	bh=svO6E+msw21q9TKA2w+Rs5wzNfExBN21DT2mgQTJ+AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJZLA7AWIFDprWP2E2bYpljciwNMzVwu86HvHPOhJx5HNHKsUWMiIf+VlhfJzF7sfGcDXC3IIOV6jQ6+qR2he/iyYfuIV6sPMbLWHuaa4jGcAZbztNl4PLxa9t46pA2xF2M449U05bJ7j8Y8uw5SDF2OShw2vVwtQlYo/JtGd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmbGeFqe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmbGeFqe"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4de66881569so181831cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759187843; x=1759792643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5eUH1fgaB1ZLwnpOvF85QHH/AvoF8YekDGzagS4th4=;
        b=fmbGeFqeQXum9p1P0IPrbw6sZQAB7oteJicrW8aG+Ycf7GDMPtneAuZUx53lUb/wfa
         N6VEdZvu72a2t/LWCbZXHhjUL+GvfXdQyamDfuojsvmAzL3ZEn74vYH74kmrTergM6tW
         eMEiC6DJbnh+Fb+roWz1zhxRTozky+4uGCDVeTwYkAgNsa+oWzyausNtGJ5LYcJm8TsZ
         MBnM8MO2x8Gk/z+9eyfHRPxmsSo/MHkBMF5EEa9wpvoWTRiNaq//XnlH7p/Yz3c/xlaP
         3PdQPz9EiNcj/w4glPCZZP4BB4/J+hSltJWNTlwewDhcPU+Ms44U83FmuWi9jNNkMx8S
         PGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759187843; x=1759792643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5eUH1fgaB1ZLwnpOvF85QHH/AvoF8YekDGzagS4th4=;
        b=jla49V47W8r7oXQyCS81WHV2c1lVWlqxr0OrfPxkLvn3P5ApbdNIyrzpCPzwwqhJBc
         69ynfNCmn0L1e7BLtnfZQ7dFkO8WdDANUYpafpB/kau0w8dYOZF8m72rRr5WqaNzXjrV
         nReaMPae0MNcNuumHcSeTRyuoU+eINEIsQk0Iz3EC6aB/KpVd92bturH89QAvaeAgs9z
         TWWYTJ6VhRPiyi22UoCGGiWA4wpVGBsdDWZKMQWhgHLH2vQIpN+s8nve7huI/zz9Fmj4
         meRhks65Sl39zQniNuHqbxqOz5/bqXZt+LQiZ8c+xi6bA328OyzW3ZvDW1ZUfJTh4aBw
         GWXg==
X-Forwarded-Encrypted: i=1; AJvYcCVM/JuVEpsU/zCyQR8b0aDycWHoaqDSbqgBH42aFzSWj5HgWhw4C2AJERZ0liFyA+WcT7uBybfxH7LRUvF1h7lya2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxcEMyzBFeTmvS8lyT+YwGZCOGVtwrxwWnYmr/GuQdEzEBVuU
	ilrzIK4VjuZ3RCZkrnAl6z+pyPITtbdIbQJJadRsg5jD6SgN6Yw86iypky4f6M7gSOCVCu/dWxO
	Ne4qAfVpaSdJi1Pj5gJU0oGpkmGDl4GHXZ5qrtU9x
X-Gm-Gg: ASbGncvSiAc6Z9W0kFX6uBCO4xwkYzqfAC/7dbTdYXN85mudUMNRnr5ORci+0Z58lDG
	DWscKtJ56R56B97mzpKkIA96F3nmZ9Wkkx4lx8y+jPZx1KhB33pwHBd+6Y1KxNqTwUhSGk0UF5D
	QQ8qkSrgKe+HE5tExPOthy4SmUPkujmxSqE1MTv27K8HTPffJjvSOMVyKEEQOOMXaErShTbkzgS
	FNbUvLo0tRCxnCbpQd3qlM=
X-Google-Smtp-Source: AGHT+IHfsLwWpMqezwQq7q2kidIcNh9cfkSUyXW4r9RDg2tuDqDeoDw0BZ/UmZdZt4Z2voubUFoRmNqlA/0rVTg/wXU=
X-Received: by 2002:a05:622a:246:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4e2cb5800famr2533761cf.0.1759187842992; Mon, 29 Sep 2025
 16:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929014227.430-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250929014227.430-1-xuewen.yan@unisoc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 29 Sep 2025 16:17:12 -0700
X-Gm-Features: AS18NWA_D2H2UMLKseNXQLjtpdGclApv5Fi3Hn3pAQ9qD6aEMPtLl1TGONdORNI
Message-ID: <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
Subject: Re: [RFC PATCH V4] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: hannes@cmpxchg.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, yuming.han@unisoc.com, xuewen.yan94@gmail.com, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 6:43=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> Add trace point to psi triggers. This is useful to
> observe the psi events in the kernel space.
>
> One use of this is to monitor memory pressure.
> When the pressure is too high, we can kill the process
> in the kernel space to prevent OOM.

Just FYI, Roman is working on a BPF-based oom-killer solution [1]
which might be also interesting for you and this tracepoint might be
useful for Roman as well. CC'ing him here.

[1] https://lore.kernel.org/all/20250818170136.209169-1-roman.gushchin@linu=
x.dev/
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> V4:
> -generate the event only after cmpxchg() passes the check
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
>  kernel/sched/psi.c           |  5 +++++
>  2 files changed, 32 insertions(+)
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
> index 59fdb7ebbf22..e8a7fd04ba9f 100644
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
> @@ -515,6 +517,9 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>                                 kernfs_notify(t->of->kn);
>                         else
>                                 wake_up_interruptible(&t->event_wait);
> +
> +                       trace_psi_event(aggregator, t->state, t->threshol=
d,
> +                                       t->win.size);
>                 }
>                 t->last_event_time =3D now;
>                 /* Reset threshold breach flag once event got generated *=
/
> --
> 2.25.1
>
>
