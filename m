Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768244248BA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891822; cv=none; b=h76zvAcP29A12aoaSh6fT2wrdZdJnNVWJSbdv5RVpzljJ7qQAGgVCUAK/nZgz+XgT2HKZm3fxNUqaooEBBTxB4OP7htjeEbGxJ1m7bAy/DCoXYPdh2st3Qof4zf+c8GpEe07vyV48urmIXSjdMBTWEZ033heDC0l/+mPNDYRBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891822; c=relaxed/simple;
	bh=HCIyv38tb2pu+Re9koRWC7ELVI6euIGHZUZA1uJNcSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED2pt3kHWnhtiE1n3vZk/y99NKX0IMWwmVoRA4Xhe/y111hsccyxqmoEG4f26bZ0Yg0Z/B4CFHsadY5Xn/pAvEVn15tC0tOjbEbQtC5Oukyrn09ucKJgCaXSiY1OldUt1Pzt0tjqy6cThTSusAiWpR72E5rEgCtwTXIwU1fIXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYaE2/sn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYaE2/sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791891819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HCIyv38tb2pu+Re9koRWC7ELVI6euIGHZUZA1uJNcSE=;
	b=CYaE2/sn02jLkIgdGkxdN318VynMZnXwFsaSwvmtulO1q/v6vtvmSgK0ngY5HhMTGxr/yu
	lRyGvQNlBaGzH3M8EfUHbfGhNqgiD6eGi8Qixz+R0tHZmIzSH4nyY4JNCLv7lqq3ogtHWs
	SgR8IjQmzLyw31hWsS0e8UBu03Srudw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-F_gTdH9iPSe8FGUXarrplg-1; Tue, 13 Oct 2026 11:43:32 +0000
X-MC-Unique: F_gTdH9iPSe8FGUXarrplg-1
X-Mimecast-MFC-AGG-ID: F_gTdH9iPSe8FGUXarrplg_1791891811
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a17ec7a49cso18863285e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791891811; x=1792496611;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ezc60w2EW0Z8miij++dLscNvA7WLeG86FqgXSEBcGis=;
        b=bP8aX1kLtxSsqkEXczMb3jxa6Z3iKj9556O0RT8xU81Ot6BgM4po9seCI2ps1DVtyZ
         zZXAkp6Lv42cPWnJ9x4QX2Kn4kbaNfAgSdl8ROSY5IWl7XYkaz/THb9DdRJWhOKr1mxY
         mNnaryGPyidWqriB+nWNId5HkkY+Kh6XQjvQXItsW+ns1JS9n0MfKe5vhusd1q9As2ei
         fyyfHNbBFU3hPQofticVoRtKmwatXv4Qzyah1BzzMtfYjK5Ty9LcwC2lJnG73d1Depm4
         bjyOmAyu55XkVx9R3Q/7AAbVdcn2UbIC6/K34r4zJcCH+qfNP9itoMJOgL8hMzbENMXY
         rukA==
X-Forwarded-Encrypted: i=1; AKwUvBxyxO0XcqfNJ0nr8GyCu9xqeB4LYW4z0OZDGVI1r6reXcIGdfkHwxV7ua0ZqSrL1dy+dZ3z2nuENhcVpfDhngidtoU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKq45dunccoCIl4oZtFy7sjQcxAfPRKE+Ih0hAUKpLw5+pWS3V
	7ljSHtljLFh3/AEJVhPr/mEC4vSsms579EW0n1TvrpMucigNmTUwJdj+MO73sDLZTOvGaVAYnPO
	aINt4yUeFCZZh1pBj0XFv0kUrh1iaVKlW9jQ3rh4K6qHy1vVtl47z1+5WKTVd+p7DSCq0GOguRg
	==
X-Gm-Gg: AYBFou3d4TAJxF9yj73afBmmjEGNR+2yim+Ig+sruTs/h+C4DzzliPRik13586OaMK1
	663Emk6pdyUhfEdYh92Luqvji/VYSAKMFoCcmEFVdMADafKU5u1rPaJ8UZQmow6Ayj/0Gr3N34L
	tmLs1UnvPOzafpGL5FEnkFmWooi9Hf/HAlQe3AP6YMvsHsqo1PuErg6FG42PhXjeycA5tZFO4rx
	NS2SE2f7hFo2P/yuXwYovvHADpsleY6auw61zlkNvOnpMsQNXyinnh67tXyQhQG/bMAWN2J37jt
	OJ6GStBXLa/BvC4w1EY8S56LwpaQElcCpVZDt9J4YTXgd/35cDlR20Qt65321cRYJb+UTmbJ8h4
	FVxvwld7xp8FkWyte6hlwi3okwPhd
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr222322675e9.8.1791891810949;
        Tue, 13 Oct 2026 04:43:30 -0700 (PDT)
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr222322215e9.8.1791891810454;
        Tue, 13 Oct 2026 04:43:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm449268585e9.4.2026.10.13.04.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:43:29 -0700 (PDT)
Message-ID: <0eab40ebeb128ca308762f0bf33d2f7084ef32f9.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rv: add per-monitor edge-stat facility and stats
 file
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Tue, 13 Oct 2026 13:43:28 +0200
In-Reply-To: <20260911123439.463052-3-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <20260911123439.463052-3-tobias.schaffner@siemens.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0MJf9f5id8N6isu9vqslv018jtnq9hRii7D5XNLZv7k_1791891811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
> Add CONFIG_RV_EDGE_STAT, an optional feature that records how long a
> monitor's automaton dwells in a state and exposes it per edge through a
> per-monitor "stats" tracefs file.
>=20
> The facility uses a static per-CPU matrix and reports, per edge and per
> CPU, the count, summed dwell time and maximum dwell time. Only the owning
> CPU writes the counters, so a reader snapshots them with local64_read()
> with no IPI and no locking on the accounting path.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
...

> +
> +/*
> + * Static storage avoids allocation lifetime races. Only the owning CPU
> writes,
> + * so readers can snapshot counters with local64_read().
> + */
> +#define RV_THIS_NR_EDGES=09(STATE_MAX * EVENT_MAX)
> +
> +struct rv_this_edges {
> +=09struct rv_edge_stat=09edge[RV_THIS_NR_EDGES];
> +};

Does this really need to be a new struct? Cannot you just define it as:

DEFINE_PER_CPU(struct rv_edge_stat[RV_THIS_NR_EDGES], DA_MON_EDGES);

Then use it as:

per_cpu_ptr(DA_MON_EDGES, cpu), sizeof(DA_MON_EDGES)

struct rv_edge_stat *edges =3D per_cpu_ptr(DA_MON_EDGES, cpu);
&edges[e].count

> +
> +static DEFINE_PER_CPU(struct rv_this_edges, DA_MON_EDGES);
> +static struct dentry *rv_this_stats_file;
> +
> +/* Called before tracepoints are registered, so memset cannot race an up=
date.
> */
> +static void rv_edge_stats_reset(void)
> +{
> +=09int cpu;
> +
> +=09for_each_possible_cpu(cpu)
> +=09=09memset(per_cpu_ptr(&DA_MON_EDGES, cpu), 0,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct rv_this_edges))=
;
> +}
> +
> +static int rv_edge_stats_show(struct seq_file *seq, void *v)
> +{
> +=09unsigned int e;
> +=09int cpu;
> +
> +=09seq_puts(seq, "# cpu edge label count sum_ns max_ns\n");
> +=09/* Include offline CPUs and keep output stable across CPU hotplug. */
> +=09for_each_possible_cpu(cpu) {
> +=09=09struct rv_this_edges *m =3D per_cpu_ptr(&DA_MON_EDGES, cpu);
> +
> +=09=09for (e =3D 0; e < RV_THIS_NR_EDGES; e++)
> +=09=09=09seq_printf(seq, "%d %u %s:%s %llu %llu %llu\n",
> +=09=09=09=09=C2=A0=C2=A0 cpu, e,
> +=09=09=09=09=C2=A0=C2=A0 model_get_state_name(e / EVENT_MAX),
> +=09=09=09=09=C2=A0=C2=A0 model_get_event_name(e % EVENT_MAX),

Perhaps you could have macros like DA_EDGE(s, e) or DA_EDGE_TO_EVENT(e)
DA_EDGE_TO_STATE(s) to make the matrix selection a bit more readable,
but that's a matter of taste.

> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&m->edge[e].count),
> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&m->edge[e].sum_ns),
> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&m->edge[e].max_ns));
> +=09}

I would like to see a way to tell if an edge is invalid or not, we
expect zero on invalid edges.
Perhaps that can be a new column so you also show the count in case they
are not 0.

You can just use model_get_next_state() =3D=3D INVALID_STATE

> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(rv_edge_stats);
> +
> +static int rv_edge_stats_create(struct dentry *parent)
> +{
> +=09rv_edge_stats_reset();
> +=09/* RV_MODE_READ is private to kernel/trace/rv/. */

I suggested you to use the rv helpers for this, you can obviously also
use RV_MODE_READ. Now monitors are in kernel/trace/rv/, so it won't be
an issue.

If we add support for modular monitors, moving the definitions to
linux/rv.h is the easiest thing to do anyway (you can do it too if you
really want and/or your agents complain, in a separate commit).

> +=09rv_this_stats_file =3D tracefs_create_file("stats", 0440, parent,
> +=09=09=09=09=09=09 NULL, &rv_edge_stats_fops);
> +=09return rv_this_stats_file ? 0 : -ENOMEM;
> +}
> +
> +static void rv_edge_stats_remove(void)
> +{
> +=09tracefs_remove(rv_this_stats_file);
> +=09rv_this_stats_file =3D NULL;
> +}
> +
> +/* A zero timestamp marks resets, which can run on a different CPU. */
> +#define da_state_entered(s)=09da_state_pack((s), local_clock() &
> RV_TS_MASK)
> +
> +static __always_inline void
> +rv_edge_account(da_state_t old, da_state_t new, enum states curr, enum e=
vents
> ev)
> +{
> +=09struct rv_this_edges *m;
> +=09u64 prev =3D da_ts_of(old);
> +
> +=09if (!prev)
> +=09=09return;

This happens only the first time after reset, isn't it unlikely()?

> +
> +=09m =3D this_cpu_ptr(&DA_MON_EDGES);
> +=09rv_edge_stat_account(&m->edge[curr * EVENT_MAX + ev],
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 (da_ts_of(new) - prev) & RV_TS_MASK);

If you decide to go for the macro, this would be DA_EDGE(s, e) or whatever
looks clear to you.

> +}
> +
> +#else /* per-cpu accounting off for this monitor type */
> +
> +#define da_state_entered(s)=09((da_state_t)(s))
> +
> +static __always_inline void
> +rv_edge_account(da_state_t old, da_state_t new, enum states curr, enum e=
vents
> ev) { }
> +
> +#endif /* RV_MON_TYPE =3D=3D RV_MON_PER_CPU */
> +
> +static __always_inline bool
> +da_state_try_commit(da_state_t *word, da_state_t *old, enum states next,
> +=09=09=C2=A0=C2=A0=C2=A0 enum events event)
> +{
> +=09da_state_t prev =3D *old;
> +=09da_state_t new =3D da_state_entered(next);
> +
> +=09if (!try_cmpxchg(word, old, new))
> +=09=09return false;
> +
> +=09rv_edge_account(prev, new, da_state_of(prev), event);
> +=09return true;
> +}
> +
> +#else /* !CONFIG_RV_EDGE_STAT */
> +
> +/*
> + * Feature off: only the hooks the DA/HA layer calls are provided, as tr=
ivial
> + * pass-throughs. da_state_t is a plain state word with no packed timest=
amp.
> + */
> +#define da_state_of(w)=09=09((unsigned int)(w))

Is this cast necessary? We assign it to an enum, the sign isn't really
important. I guess it's the same for the other implementation of
da_state_of() (which is now in another patch).

Thanks,
Gabriele


> +#define da_state_entered(s)=09(s)
> +
> +static __always_inline bool
> +da_state_try_commit(da_state_t *word, da_state_t *old, enum states next,
> +=09=09=C2=A0=C2=A0=C2=A0 enum events event)
> +{
> +=09return try_cmpxchg(word, old, next);
> +}
> +
> +#if RV_MON_TYPE =3D=3D RV_MON_PER_CPU
> +static inline int rv_edge_stats_create(struct dentry *parent) { return 0=
; }
> +static inline void rv_edge_stats_remove(void) { }
> +#endif
> +
> =C2=A0#endif /* CONFIG_RV_EDGE_STAT */
> =C2=A0
> =C2=A0#endif /* _RV_EDGE_STAT_H */
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 3884b14df375..3045037fb36a 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -59,6 +59,18 @@ config RV_PER_TASK_MONITORS
> =C2=A0=09=C2=A0 This option configures the maximum number of per-task RV =
monitors
> that can run
> =C2=A0=09=C2=A0 simultaneously.
> =C2=A0
> +config RV_EDGE_STAT
> +=09bool "Per-edge dwell-time statistics"
> +=09depends on RV && 64BIT && DA_MON_EVENTS_IMPLICIT
> +=09help
> +=09=C2=A0 Record per-edge dwell-time statistics for per-cpu deterministi=
c and
> +=09=C2=A0 hybrid automaton monitors and expose them through a per-monito=
r
> +=09=C2=A0 "stats" tracefs file. This times each monitored automaton
> transition
> +=09=C2=A0 with local_clock(), so leave it off if you do not need the
> +=09=C2=A0 statistics.
> +
> +=09=C2=A0 If unsure, say N.
> +
> =C2=A0source "kernel/trace/rv/monitors/wip/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/wwnr/Kconfig"
>=20

