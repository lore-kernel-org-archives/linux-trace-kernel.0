Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA84ACC6E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189616; cv=none; b=IkKPi6BKk8FQQLK3DRF8SM2ONHDIJoWuvOZdSdvzoBJb6f1LcfNSkrod8vKkSZhrUQxq7tcEev9oajEpDmx6Ir1b007LLhYfQLWho5vB31QZ53+2DB3ZowQ/HoV6Auso/AAg70VrO5SNtJrH9hwpA5sU8H1XJEUBCq1+qOxdpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189616; c=relaxed/simple;
	bh=zpq7sYPeslmf17LCRvFh16466SF38yyBDlRlPndQTOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIU7VmiEY2I51pkHKTMdi6LjXHpUsbycoMQOqnUIOZ4zWzfiq4M8d1ZsO1aCXit/C49AVEaVjO0qhSsvFw2pWlhKSguE2G6Hc1haoJFkZmSYAgMAodMs0eOdc5bsXbRdCdkIaAnL84e4K/QgyNfAz+G81fJ+flYLVkHQ0a6gf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4ZwcyH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4ZwcyH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788189613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zpq7sYPeslmf17LCRvFh16466SF38yyBDlRlPndQTOc=;
	b=Z4ZwcyH95eUUdXPi7/EDFfw7X4ZSxdHNNDKlUzUYBpjlJrm0QiFimMxGGEgFtx2OckfQ32
	9Ujo3+GNmzKCQBFe66dHcH2j1txuJ2O4CSQ4YC0jcwkvXnVfH0FafzRt4Ghm56K4HljBXB
	Ht8BLLTgsuDLcmTKqFUSYYQNBaH10l0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-JrBxuPIKNSmnTPcU-G4NBw-1; Mon, 31 Aug 2026 11:20:11 -0400
X-MC-Unique: JrBxuPIKNSmnTPcU-G4NBw-1
X-Mimecast-MFC-AGG-ID: JrBxuPIKNSmnTPcU-G4NBw_1788189610
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e8e1ac69so2385320f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 08:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189610; x=1788794410;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXClpsh6iPYU83p7tcghxNepcDvf/U/9NsSbFV/a0j0=;
        b=G61kvEG04a3Gzohatay4H0f7R7Uza5gI173cH0AOSXEvc5dm3QBNA6jPl2ULl7OEQi
         5ESSFIhqLjwGvUTUrRMAyPExsu6X3YbmRljA+ZBopF9hL71H0yzT3pF9rJvOSUyChJ5y
         L0QcXReE79EdpfLrHObDyjwUcQsNLeogfLa/vbc4hRALgexUGsXJQ/Y/rJsWtXIkTMH1
         Z06FRTKN0jtYCQWMSC/gbq6mSHwgEr5OVqrj77ZlMHW+tRBMg70ICKj2txXA+dEDmpDU
         Ri4LdoT1vsEMiSEfNRA+ffexNF1A59FjP5xK+2/YEQu8Gu2VsUwkCHc1zmWpQATI/NR7
         jNrA==
X-Forwarded-Encrypted: i=1; AKwUvBzVxB/1GasQLiWXyuhI9NlyP9/rOeBIOmN6mtPK1mJdJZvQJ9JP4/OiJBLus2UZkylZXcL72issGen+Mg8pSCGaE+M=@vger.kernel.org
X-Gm-Message-State: AFuF++nqVEUrkz4BGgNZzaaUjAZ2LpnPhwV5w7Cc/1u+zA1vV/n5brIU
	NcDAafC3cidJosBBjD4NKnCcUX1Sh5iU8pv99rQTHoUVAyn5l44o2wf2Ca3ImTQXEsZyshQchJO
	E5XJ8LkmaMAATmAf+y4uAPEFeQ+R2ASlmQzxWGBXrQIEBoWMw1Z2LBQgt5VffF1WRupT0AijY1g
	==
X-Gm-Gg: AYBFou03I35RCYHbvhsjnbYs1f2bqo1SKH/hrrkSGxPY38xOBBlNIzrDFi7JFT3WvQj
	9baGpw2+fweE0KnKnI5GLkocBTpMhnFgbNraDeS5hOWHm6eJdftuca5ZgFNSF8GPCDXgjlpZ0Y0
	VxpyTt34NQdTqjpBhg3hg4QjhG0xYsFtGWq92Of9XDCm/4EHSQ8UIJ/3YbgX6gO5Cs48lmN7yRq
	gHPna3SDCqLIEunY85so9C+GGb3e6kkJ00TkIlM/FBSSgznBvv9bWZ7mYcIWBQ6zzEpnFi57QkA
	XsR04GH3gVM7mf1HRjeVJqjcjjndZpztLq91+oLnwgs/s9HEni/qOFvQW5nOJY7WUWZW3cON3Fz
	8t9rAlpf/64QyX3zUwG3RN54QILPojg==
X-Received: by 2002:a05:6000:4a12:b0:47f:e7f7:370f with SMTP id ffacd0b85a97d-484397b80a3mr19425582f8f.10.1788189609699;
        Mon, 31 Aug 2026 08:20:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4a12:b0:47f:e7f7:370f with SMTP id ffacd0b85a97d-484397b80a3mr19425405f8f.10.1788189609003;
        Mon, 31 Aug 2026 08:20:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af45sm14788380f8f.9.2026.08.31.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:20:08 -0700 (PDT)
Message-ID: <0093e4b7c07afdc08ff15414373be9cd89250529.camel@redhat.com>
Subject: Re: [RFC 2/3] rv: add per-monitor edge-stat facility and stats file
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jan Kiszka	
 <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 31 Aug 2026 17:20:05 +0200
In-Reply-To: <20260827072400.45734-3-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
	 <20260827072400.45734-3-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: MDTXAfijNn803EsA_tO4utTUrfuSlN7HeaErhjmRuy0_1788189610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
> Add CONFIG_RV_EDGE_STAT, an optional feature that records how long a
> monitor's automaton dwells in a state and exposes it per edge through a
> per-monitor "stats" tracefs file.
>=20
> The core allocates a per-CPU buffer on first enable and reports, per edge
> and per CPU, the count, maximum and summed dwell time. Only the owning CP=
U
> writes the counters, so a reader snapshots them with local64_read() with =
no
> IPI and no locking on the accounting path.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>

In this implementation you're tying the edge stats on the struct
rv_monitor and implementing things in rv.c . Now this is targeting only
DA/HA monitors, I presume. It's probably easier directly writing the
implementation in da_monitor. That would save you a bit of headache
you're solving with function and void pointers here.

You could extend da_monitor_init()/da_monitor_destroy() to
create/destroy this tracefs file, then leave the entire matrix in the
struct da_monitor (which might be a first step to support also other
monitor types besides per-cpu).

Then all specific implementations can be done following what we do with
RV_MON_TYPE (you can only implement per-cpu for now and leave the rest
blank or whatever is cleaner).

The logic behind da_monitor.h (and friends) is to create specific
per-monitor static functions, you will get some duplication in the
object file, but the compiler can inline and optimise things better.

Now this works perfectly with handlers which are very simple, and we are
still doing it also with more complex things which could live in another
(shared) object file, you can do it too.

Does it make sense to you?

Thanks,
Gabriele

> ---
> =C2=A0.../trace/rv/runtime-verification.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++++
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +++
> =C2=A0include/linux/rv_edge_stat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 =
+++-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 11 ++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 116 +++++++++++++++++-
> =C2=A05 files changed, 184 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/trace/rv/runtime-verification.rst
> b/Documentation/trace/rv/runtime-verification.rst
> index c700dde9259c..194b2f9db461 100644
> --- a/Documentation/trace/rv/runtime-verification.rst
> +++ b/Documentation/trace/rv/runtime-verification.rst
> @@ -229,3 +229,27 @@ For example::
> =C2=A0=C2=A0=C2=A0 nop
> =C2=A0=C2=A0=C2=A0 [panic]
> =C2=A0=C2=A0=C2=A0 printk
> +
> +**monitors/MONITOR/stats**
> +
> +Present only when the kernel is built with CONFIG_RV_EDGE_STAT=3Dy and
> *MONITOR*
> +is a per-cpu DA/HA (automaton) monitor. It reports how long the automato=
n
> +dwells in each state before leaving it, timed with local_clock() and
> accounted
> +per outgoing edge and per CPU.
> +
> +- The first line is a header naming the columns.
> +- Each following line describes one edge on one CPU::
> +
> +=C2=A0=C2=A0 cpu edge label count max_ns sum_ns
> +
> +=C2=A0 *count* is the number of times the edge was taken, *max_ns* and *=
sum_ns*
> are
> +=C2=A0 the worst and total dwell in nanoseconds, and *label* is "state:e=
vent".
> +
> +The counters are reset each time the monitor is enabled.
> +
> +For example::
> +
> +=C2=A0=C2=A0 # cat monitors/wip/stats
> +=C2=A0=C2=A0 # cpu edge label count max_ns sum_ns
> +=C2=A0=C2=A0 0 0 preemptive:preempt_disable 4210 183200 95501200
> +=C2=A0=C2=A0 0 4 non_preemptive:preempt_enable 4208 42600 3812900
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 541ba404926a..7eeecce17e50 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -136,6 +136,16 @@ struct rv_reactor {
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> +/**
> + * struct rv_edge_cfg - per-edge dwell-time statistics for a monitor
> + * @n_edges:=09number of automaton edges (STATE_MAX * EVENT_MAX)
> + * @edge_name:=09optional, write a human name for @edge into @buf (may b=
e
> NULL)
> + */
> +struct rv_edge_cfg {
> +=09unsigned int=09n_edges;
> +=09void=09=09(*edge_name)(unsigned int edge, char *buf, size_t
> len);
> +};
> +
> =C2=A0struct rv_monitor {
> =C2=A0=09const char=09=09*name;
> =C2=A0=09const char=09=09*description;
> @@ -146,6 +156,10 @@ struct rv_monitor {
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0=09struct rv_reactor=09*reactor;
> =C2=A0=09__printf(1, 0) void=09(*react)(const char *msg, va_list args);
> +#endif
> +#ifdef CONFIG_RV_EDGE_STAT
> +=09const struct rv_edge_cfg=09*edge_cfg;
> +=09void __percpu=09=09=09*edge_pcpu;
> =C2=A0#endif
> =C2=A0=09struct list_head=09list;
> =C2=A0=09struct rv_monitor=09*parent;
> diff --git a/include/linux/rv_edge_stat.h b/include/linux/rv_edge_stat.h
> index 751de8074dcc..fda30ff728a1 100644
> --- a/include/linux/rv_edge_stat.h
> +++ b/include/linux/rv_edge_stat.h
> @@ -9,14 +9,11 @@
> =C2=A0#define _LINUX_RV_EDGE_STAT_H
> =C2=A0
> =C2=A0#include <linux/compiler.h>
> +#include <linux/percpu.h>
> +#include <linux/rv.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <asm/local64.h>
> =C2=A0
> -/*
> - * Per-CPU counters kept in local64_t so accounting is safe against inte=
rrupt
> - * and NMI nesting on the owning CPU without disabling interrupts -- the=
 same
> - * approach the trace ring buffer uses. Only the owning CPU writes.
> - */
> =C2=A0struct rv_edge_stat {
> =C2=A0=09local64_t=09count;
> =C2=A0=09local64_t=09sum_ns;
> @@ -42,4 +39,22 @@ void rv_edge_stat_account(struct rv_edge_stat *s, u64
> dwell_ns)
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_RV_EDGE_STAT
> +/**
> + * rv_edge_account - record a dwell of @dwell_ns on @edge of monitor @mo=
n
> + *
> + * Cheap and lock-free: the local64_t counters make this safe against
> interrupt
> + * and NMI nesting on the current CPU without disabling interrupts, so i=
t
> does
> + * not perturb the latency being measured. The caller only needs to stay=
 on
> its
> + * CPU for the call (as tracepoint probes already do).
> + */
> +static __always_inline void
> +rv_edge_account(struct rv_monitor *mon, unsigned int edge, u64 dwell_ns)
> +{
> +=09struct rv_edge_stat *e =3D this_cpu_ptr(mon->edge_pcpu);
> +
> +=09rv_edge_stat_account(&e[edge], dwell_ns);
> +}
> +#endif /* CONFIG_RV_EDGE_STAT */
> +
> =C2=A0#endif /* _LINUX_RV_EDGE_STAT_H */
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 3884b14df375..9d76dff394ca 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -59,6 +59,17 @@ config RV_PER_TASK_MONITORS
> =C2=A0=09=C2=A0 This option configures the maximum number of per-task RV =
monitors
> that can run
> =C2=A0=09=C2=A0 simultaneously.
> =C2=A0
> +config RV_EDGE_STAT
> +=09bool "Per-edge dwell-time statistics"
> +=09depends on RV
> +=09help
> +=09=C2=A0 Record per-edge dwell-time statistics for per-cpu DA/HA monito=
rs
> and
> +=09=C2=A0 expose them through a per-monitor "stats" tracefs file. This t=
imes
> +=09=C2=A0 each monitored automaton transition with local_clock(), so lea=
ve it
> +=09=C2=A0 off if you do not need the statistics.
> +
> +=09=C2=A0 If unsure, say N.
> +
> =C2=A0source "kernel/trace/rv/monitors/wip/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/wwnr/Kconfig"
> =C2=A0
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index ee4e68102f17..88a0bbaec4d0 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -142,6 +142,12 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/seq_file.h>
> +#ifdef CONFIG_RV_EDGE_STAT
> +#include <linux/percpu.h>
> +#include <linux/rv_edge_stat.h>
> +#include <linux/smp.h>
> +#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_MON_EVENTS
> =C2=A0#define CREATE_TRACE_POINTS
> @@ -278,6 +284,9 @@ static void rv_disable_single(struct rv_monitor *mon)
> =C2=A0=09__rv_disable_monitor(mon, true);
> =C2=A0}
> =C2=A0
> +static int rv_edge_setup(struct rv_monitor *mon);
> +static void rv_edge_reset(struct rv_monitor *mon);
> +
> =C2=A0static int rv_enable_single(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09int retval;
> @@ -289,9 +298,15 @@ static int rv_enable_single(struct rv_monitor *mon)
> =C2=A0
> =C2=A0=09retval =3D mon->enable();
> =C2=A0
> -=09if (!retval)
> +=09if (!retval) {
> =C2=A0=09=09mon->enabled =3D 1;
> =C2=A0
> +=09=09if (rv_edge_setup(mon))
> +=09=09=09pr_warn("rv: %s: edge statistics unavailable (out of
> memory)\n",
> +=09=09=09=09mon->name);
> +=09=09rv_edge_reset(mon);
> +=09}
> +
> =C2=A0=09return retval;
> =C2=A0}
> =C2=A0
> @@ -412,6 +427,101 @@ static const struct file_operations interface_desc_=
fops
> =3D {
> =C2=A0=09.read=09=3D monitor_desc_read_data,
> =C2=A0};
> =C2=A0
> +#ifdef CONFIG_RV_EDGE_STAT
> +static size_t rv_edge_blob_size(const struct rv_monitor *mon)
> +{
> +=09return mon->edge_cfg->n_edges * sizeof(struct rv_edge_stat);
> +}
> +
> +static void rv_edge_reset_ipi(void *info)
> +{
> +=09struct rv_monitor *mon =3D info;
> +
> +=09memset(this_cpu_ptr(mon->edge_pcpu), 0, rv_edge_blob_size(mon));
> +}
> +
> +/* rv_edge_reset - zero the statistics; call from a monitor reset/enable=
. */
> +static void rv_edge_reset(struct rv_monitor *mon)
> +{
> +=09if (mon->edge_pcpu)
> +=09=09on_each_cpu(rv_edge_reset_ipi, mon, 1);
> +}
> +
> +/*
> + * The counters are per-CPU and only the owning CPU writes them, so a re=
ader
> on
> + * any CPU can snapshot them with local64_read().
> + */
> +static int rv_edge_stats_show(struct seq_file *seq, void *v)
> +{
> +=09struct rv_monitor *mon =3D seq->private;
> +=09const struct rv_edge_cfg *cfg =3D mon->edge_cfg;
> +=09unsigned int e;
> +=09int cpu;
> +
> +=09seq_puts(seq, "# cpu edge label count max_ns sum_ns\n");
> +
> +=09if (!mon->edge_pcpu)
> +=09=09return 0;
> +
> +=09for_each_online_cpu(cpu) {
> +=09=09struct rv_edge_stat *s =3D per_cpu_ptr(mon->edge_pcpu, cpu);
> +
> +=09=09for (e =3D 0; e < cfg->n_edges; e++) {
> +=09=09=09char lbl[48] =3D "";
> +
> +=09=09=09if (cfg->edge_name)
> +=09=09=09=09cfg->edge_name(e, lbl, sizeof(lbl));
> +=09=09=09seq_printf(seq, "%d %u %s %llu %llu %llu\n",
> +=09=09=09=09=C2=A0=C2=A0 cpu, e, lbl,
> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&s[e].count),
> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&s[e].max_ns),
> +=09=09=09=09=C2=A0=C2=A0 (u64)local64_read(&s[e].sum_ns));
> +=09=09}
> +=09}
> +=09return 0;
> +}
> +
> +static int rv_edge_stats_open(struct inode *inode, struct file *file)
> +{
> +=09return single_open(file, rv_edge_stats_show, inode->i_private);
> +}
> +
> +static const struct file_operations rv_edge_stats_fops =3D {
> +=09.open=09=09=3D rv_edge_stats_open,
> +=09.read=09=09=3D seq_read,
> +=09.llseek=09=09=3D seq_lseek,
> +=09.release=09=3D single_release,
> +};
> +
> +/*
> + * Allocate the per-CPU buffer and expose stats. Done on first enable
> + * rather than at registration because a DA/HA monitor's edge_cfg is bou=
nd by
> + * da_monitor_init(), which runs from the monitor's enable path.
> + */
> +static int rv_edge_setup(struct rv_monitor *mon)
> +{
> +=09if (!mon->edge_cfg || !mon->edge_cfg->n_edges || mon->edge_pcpu)
> +=09=09return 0;
> +
> +=09mon->edge_pcpu =3D __alloc_percpu(rv_edge_blob_size(mon),
> +=09=09=09=09=09__alignof__(struct rv_edge_stat));
> +=09if (!mon->edge_pcpu)
> +=09=09return -ENOMEM;
> +
> +=09if (!rv_create_file("stats", RV_MODE_READ, mon->root_d, mon,
> +=09=09=09=C2=A0=C2=A0=C2=A0 &rv_edge_stats_fops)) {
> +=09=09free_percpu(mon->edge_pcpu);
> +=09=09mon->edge_pcpu =3D NULL;
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09return 0;
> +}
> +#else
> +static int rv_edge_setup(struct rv_monitor *mon) { return 0; }
> +static void rv_edge_reset(struct rv_monitor *mon) { }
> +#endif /* CONFIG_RV_EDGE_STAT */
> +
> =C2=A0/*
> =C2=A0 * During the registration of a monitor, this function creates
> =C2=A0 * the monitor dir, where the specific options of the monitor
> @@ -747,6 +857,10 @@ static const struct file_operations monitoring_on_fo=
ps =3D
> {
> =C2=A0
> =C2=A0static void destroy_monitor_dir(struct rv_monitor *mon)
> =C2=A0{
> +#ifdef CONFIG_RV_EDGE_STAT
> +=09free_percpu(mon->edge_pcpu);
> +=09mon->edge_pcpu =3D NULL;
> +#endif
> =C2=A0=09rv_remove(mon->root_d);
> =C2=A0}
> =C2=A0

