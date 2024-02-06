Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC712F386
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219624; cv=none; b=oXvgqKJQKX716j8NLg/1x5+2L1MOUjjRLNmdcOYanTgfi+NVo4zfngteaXYMba+3kdGIAGCyOn6LH+GAYtJEajyStPhzgZlVUu5KNOtc6dHQkxCdV2WxVVw5H5ouBEePildR4U3T+qoy4a0TBYGttFCM5wSRVdY/o8yLBojbkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219624; c=relaxed/simple;
	bh=GuYkVOKWQi9ltIDEokGctFvSodDquRxlfeS2oCmUDFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR7ZHzrzOg/U/o9bB9qhqSWnfqyTvtQ1ad8wPyV0569HgLcujTlULj5D0IIXDIpQSAxdZW20wWqe5/3DWPT0HHZootBfaiLBqylm5zbqUNc9iiUYR+b+WoDtWYC4RSnGgluHNkUf6T766+t2ld6FnrGW8jGdIeBCunX1TxPe4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2MzDXgv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2MzDXgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707219620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NlbQwjP7HumRrFzOjJ3rNvlAM+ikhLilx6mhWdV3rQs=;
	b=d2MzDXgvv4Dix3AdBknfyweC5izl1QITPEgfQSZ8sup+b3kGxJUriLbnOm9uc5X81N8yON
	IAH+9DBaIRDid5/jgpo2FIpJwJ5JLAcfbDfA1rdziQHzRWkhMIYLYcBsA2L2ZH2KgyApqy
	habaPboMGQDqK9na+Y58NEDUnb7GtWg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-xsFa8SoCPEe6Vg2WwjVhvA-1; Tue, 06 Feb 2024 06:40:19 -0500
X-MC-Unique: xsFa8SoCPEe6Vg2WwjVhvA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3be33c7f1c7so2336013b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219619; x=1707824419;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPELn2sdkgF0FjAabyDqjzot0ROUv2uYxpIr8s6iS+8=;
        b=a01pcxv6UXxzPyE/qWqAY7hAHf9k0K0QTn8NcTBHemyUNVBiYMNjFtvdgp8N6iLOVk
         NRsVZwrbcntnZ/OzJ7M1CEwxBCrDqGpVWAhBNjp9QTRJNM0tO0kYL0hY3ZGIOZz7aT2g
         qbxxKGEWLA27IZo8rfiXvyf88jCfSh/aFnlSI3bzvrjWAWQSSXMtUZlKXbhGvp1SyK75
         HFRzzY21epqYPkbe+DgkGxmCm1g36YAAHlgNUHsHfxVDXbbn3wjhOl2rBj21PPixi0sI
         7EeRNCyK79Z8zZdyGoH1g9qEmBRpnMBRLpitbNflARNqzhAWm8iNIUsFvZ/KaJleqPDf
         a+eQ==
X-Gm-Message-State: AOJu0Yxe6YQddUMeRajmEeeMMSfoENCqH7fjc8gib+1I7edRcOEFrevh
	QVspErBURSrZ/GgLdC0YxIl7IrG/AU7Z6Xk6zSIf8ripx4sqOIu4teaIZhnWUGEngkhMAns9oXz
	boJtCsOSBfc2q861FbiM5T49D9xpDg+zYkezFFVrIO+LYToWIspD7S0P5R+gLnpZxPT8hGQ==
X-Received: by 2002:a05:6808:190f:b0:3bf:bc5c:c452 with SMTP id bf15-20020a056808190f00b003bfbc5cc452mr3064118oib.3.1707219618765;
        Tue, 06 Feb 2024 03:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ZmeylEOxILfsDwOB8t205YVtnvISVVTonMkLuzePqzv9q2EyhH2b2Jk23HHMNB6iJU5asQ==
X-Received: by 2002:a05:6808:190f:b0:3bf:bc5c:c452 with SMTP id bf15-20020a056808190f00b003bfbc5cc452mr3064098oib.3.1707219618357;
        Tue, 06 Feb 2024 03:40:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJnhmQkSPCfSV4Wcdm8uHXiBJgR24AtZKafe87Sq4EsX9PXjU1u1KSMLKbDPHwFZEGkdLWk5UoZYxbdadgwn2iQitkvsFBx5Hykb1wK1UhHB+EAq9kRvoIxQB92PHlUAcO73RCBKSpvh3gq8hOQhgbCfRhHegJDclNaF9iw2Ew9M5RB9xwT7fpKc0HvpfaRnDk5l2g/jLunUI6O7Y+DilVtC8gkGT/oOvy7YHXU/mnbC+zKBYep8VM0gDlrqTYSECJPSdd+r1mVC/XM1VzJLxK+OjXLLPK5iRwesmlX7raC7ZJZ66HHGqxkGDNlt6m1ktVWeiHpTEMlBqPIO755Ol7VMFJFOQR9gQ2azAnrg+q0TOICO8tXI8QZjgZjK2l/BaGMqIm0FTclCwi7oyli21fYCzhxk86ut8lLaYlAeLp2JW7dBhKH5NmTG+XUy1HM5UXPOJOD0Gm8TsgG+X1qXVXgZBExd2z2iOvF2YRKj6muMGRK1oecIKpor8jiiUS6iGA6EnkTwdy+NvM4RHWWvEYQ+oWCqnKueFaTt4tHjJrruN2D2pn
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a121500b00783fb468e7bsm837276qkj.44.2024.02.06.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:40:17 -0800 (PST)
Message-ID: <dc049b1e556ef7b398fb78c01b6e2e693c185273.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on
 BQL
From: Paolo Abeni <pabeni@redhat.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net, 
 edumazet@google.com, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg
 <johannes.berg@intel.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 06 Feb 2024 12:40:13 +0100
In-Reply-To: <20240202165315.2506384-1-leitao@debian.org>
References: <20240202165315.2506384-1-leitao@debian.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-02-02 at 08:53 -0800, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
>=20
> softnet_data->time_squeeze is sometimes used as a proxy for
> host overload or indication of scheduling problems. In practice
> this statistic is very noisy and has hard to grasp units -
> e.g. is 10 squeezes a second to be expected, or high?
>=20
> Delaying network (NAPI) processing leads to drops on NIC queues
> but also RTT bloat, impacting pacing and CA decisions.
> Stalls are a little hard to detect on the Rx side, because
> there may simply have not been any packets received in given
> period of time. Packet timestamps help a little bit, but
> again we don't know if packets are stale because we're
> not keeping up or because someone (*cough* cgroups)
> disabled IRQs for a long time.
>=20
> We can, however, use Tx as a proxy for Rx stalls. Most drivers
> use combined Rx+Tx NAPIs so if Tx gets starved so will Rx.
> On the Tx side we know exactly when packets get queued,
> and completed, so there is no uncertainty.
>=20
> This patch adds stall checks to BQL. Why BQL? Because
> it's a convenient place to add such checks, already
> called by most drivers, and it has copious free space
> in its structures (this patch adds no extra cache
> references or dirtying to the fast path).
>=20
> The algorithm takes one parameter - max delay AKA stall
> threshold and increments a counter whenever NAPI got delayed
> for at least that amount of time. It also records the length
> of the longest stall.
>=20
> To be precise every time NAPI has not polled for at least
> stall thrs we check if there were any Tx packets queued
> between last NAPI run and now - stall_thrs/2.
>=20
> Unlike the classic Tx watchdog this mechanism does not
> ignore stalls caused by Tx being disabled, or loss of link.
> I don't think the check is worth the complexity, and
> stall is a stall, whether due to host overload, flow
> control, link down... doesn't matter much to the application.
>=20
> We have been running this detector in production at Meta
> for 2 years, with the threshold of 8ms. It's the lowest
> value where false positives become rare. There's still
> a constant stream of reported stalls (especially without
> the ksoftirqd deferral patches reverted), those who like
> their stall metrics to be 0 may prefer higher value.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>=20
> v1:
>   * https://lore.kernel.org/netdev/202306172057.jx7YhLiu-lkp@intel.com/T/
>=20
> v2:
>   * Fix the documentation file in patch 0001, since patch 0002 will
>     touch it later.
>   * Fix the kernel test robot issues, marking functions as statics.
>   * Use #include <linux/bitops.h> instead of <asm/bitops.h>.
>   * Added some new comments around, mainly around barriers.
>   * Format struct `netdev_queue_attribute` assignments to make
>     checkpatch happy.
>   * Updated and fixed the path in sysfs-class-net-queues
>     documentation.
>=20
> v3:
>   * Sending patch 0002 against net-next.
> =09- The first patch was accepted against 'net'
>=20
> ---
>  .../ABI/testing/sysfs-class-net-queues        | 23 +++++++
>  include/linux/dynamic_queue_limits.h          | 35 +++++++++++
>  include/trace/events/napi.h                   | 33 ++++++++++
>  lib/dynamic_queue_limits.c                    | 58 +++++++++++++++++
>  net/core/net-sysfs.c                          | 62 +++++++++++++++++++
>  5 files changed, 211 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documenta=
tion/ABI/testing/sysfs-class-net-queues
> index 5bff64d256c2..45bab9b6e3ae 100644
> --- a/Documentation/ABI/testing/sysfs-class-net-queues
> +++ b/Documentation/ABI/testing/sysfs-class-net-queues
> @@ -96,3 +96,26 @@ Description:
>  =09=09Indicates the absolute minimum limit of bytes allowed to be
>  =09=09queued on this network device transmit queue. Default value is
>  =09=090.
> +
> +What:=09=09/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/st=
all_thrs
> +Date:=09=09Jan 2024
> +KernelVersion:=096.9
> +Contact:=09netdev@vger.kernel.org
> +Description:
> +=09=09Tx completion stall detection threshold.=C2=A0

Possibly worth mentioning it's in milliseconds

> Kernel will guarantee
> +=09=09to detect all stalls longer than this threshold but may also
> +=09=09detect stalls longer than half of the threshold.
> +
> +What:=09=09/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/st=
all_cnt
> +Date:=09=09Jan 2024
> +KernelVersion:=096.9
> +Contact:=09netdev@vger.kernel.org
> +Description:
> +=09=09Number of detected Tx completion stalls.
> +
> +What:=09=09/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/st=
all_max
> +Date:=09=09Jan 2024
> +KernelVersion:=096.9
> +Contact:=09netdev@vger.kernel.org
> +Description:
> +=09=09Longest detected Tx completion stall. Write 0 to clear.
> diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic=
_queue_limits.h
> index 407c2f281b64..288e98fe85f0 100644
> --- a/include/linux/dynamic_queue_limits.h
> +++ b/include/linux/dynamic_queue_limits.h
> @@ -38,14 +38,21 @@
> =20
>  #ifdef __KERNEL__
> =20
> +#include <linux/bitops.h>
>  #include <asm/bug.h>
> =20
> +#define DQL_HIST_LEN=09=094
> +#define DQL_HIST_ENT(dql, idx)=09((dql)->history[(idx) % DQL_HIST_LEN])
> +
>  struct dql {
>  =09/* Fields accessed in enqueue path (dql_queued) */
>  =09unsigned int=09num_queued;=09=09/* Total ever queued */
>  =09unsigned int=09adj_limit;=09=09/* limit + num_completed */
>  =09unsigned int=09last_obj_cnt;=09=09/* Count at last queuing */
> =20
> +=09unsigned long=09history_head;
> +=09unsigned long=09history[DQL_HIST_LEN];
> +
>  =09/* Fields accessed only by completion path (dql_completed) */
> =20
>  =09unsigned int=09limit ____cacheline_aligned_in_smp; /* Current limit *=
/
> @@ -62,6 +69,11 @@ struct dql {
>  =09unsigned int=09max_limit;=09=09/* Max limit */
>  =09unsigned int=09min_limit;=09=09/* Minimum limit */
>  =09unsigned int=09slack_hold_time;=09/* Time to measure slack */
> +
> +=09unsigned char=09stall_thrs;
> +=09unsigned char=09stall_max;

Why don't 'unsigned short'?=20


> +=09unsigned long=09last_reap;
> +=09unsigned long=09stall_cnt;
>  };
> =20
>  /* Set some static maximums */
> @@ -74,6 +86,8 @@ struct dql {
>   */
>  static inline void dql_queued(struct dql *dql, unsigned int count)
>  {
> +=09unsigned long map, now, now_hi, i;
> +
>  =09BUG_ON(count > DQL_MAX_OBJECT);
> =20
>  =09dql->last_obj_cnt =3D count;
> @@ -86,6 +100,27 @@ static inline void dql_queued(struct dql *dql, unsign=
ed int count)
>  =09barrier();
> =20
>  =09dql->num_queued +=3D count;
> +
> +=09now =3D jiffies;
> +=09now_hi =3D now / BITS_PER_LONG;
> +=09if (unlikely(now_hi !=3D dql->history_head)) {
> +=09=09/* About to reuse slots, clear them */
> +=09=09for (i =3D 0; i < DQL_HIST_LEN; i++) {
> +=09=09=09/* Multiplication masks high bits */
> +=09=09=09if (now_hi * BITS_PER_LONG =3D=3D
> +=09=09=09    (dql->history_head + i) * BITS_PER_LONG)
> +=09=09=09=09break;
> +=09=09=09DQL_HIST_ENT(dql, dql->history_head + i + 1) =3D 0;
> +=09=09}
> +=09=09/* pairs with smp_rmb() in dql_check_stall() */
> +=09=09smp_wmb();
> +=09=09WRITE_ONCE(dql->history_head, now_hi);
> +=09}
> +
> +=09/* __set_bit() does not guarantee WRITE_ONCE() semantics */
> +=09map =3D DQL_HIST_ENT(dql, now_hi);
> +=09if (!(map & BIT_MASK(now)))
> +=09=09WRITE_ONCE(DQL_HIST_ENT(dql, now_hi), map | BIT_MASK(now));

Do you have measure of performance impact, if any? e.g. for udp
flood/pktgen/xdp tput tests with extreme pkt rate?

What about making all the above conditional to a non zero stall_thrs,
alike the check part?

>  }
> =20
>  /* Returns how many objects can be queued, < 0 indicates over limit. */
> diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
> index 6678cf8b235b..272112ddaaa8 100644
> --- a/include/trace/events/napi.h
> +++ b/include/trace/events/napi.h
> @@ -36,6 +36,39 @@ TRACE_EVENT(napi_poll,
>  =09=09  __entry->work, __entry->budget)
>  );
> =20
> +TRACE_EVENT(dql_stall_detected,
> +
> +=09TP_PROTO(unsigned int thrs, unsigned int len,
> +=09=09 unsigned long last_reap, unsigned long hist_head,
> +=09=09 unsigned long now, unsigned long *hist),
> +
> +=09TP_ARGS(thrs, len, last_reap, hist_head, now, hist),
> +
> +=09TP_STRUCT__entry(
> +=09=09__field(=09unsigned int,=09=09thrs)
> +=09=09__field(=09unsigned int,=09=09len)
> +=09=09__field(=09unsigned long,=09=09last_reap)
> +=09=09__field(=09unsigned long,=09=09hist_head)
> +=09=09__field(=09unsigned long,=09=09now)
> +=09=09__array(=09unsigned long,=09=09hist, 4)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__entry->thrs =3D thrs;
> +=09=09__entry->len =3D len;
> +=09=09__entry->last_reap =3D last_reap;
> +=09=09__entry->hist_head =3D hist_head * BITS_PER_LONG;
> +=09=09__entry->now =3D now;
> +=09=09memcpy(__entry->hist, hist, sizeof(entry->hist));
> +=09),
> +
> +=09TP_printk("thrs %u  len %u  last_reap %lu  hist_head %lu  now %lu  hi=
st %016lx %016lx %016lx %016lx",
> +=09=09  __entry->thrs, __entry->len,
> +=09=09  __entry->last_reap, __entry->hist_head, __entry->now,
> +=09=09  __entry->hist[0], __entry->hist[1],
> +=09=09  __entry->hist[2], __entry->hist[3])
> +);
> +
>  #undef NO_DEV
> =20
>  #endif /* _TRACE_NAPI_H */
> diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> index fde0aa244148..162d30ae542c 100644
> --- a/lib/dynamic_queue_limits.c
> +++ b/lib/dynamic_queue_limits.c
> @@ -10,10 +10,61 @@
>  #include <linux/dynamic_queue_limits.h>
>  #include <linux/compiler.h>
>  #include <linux/export.h>
> +#include <trace/events/napi.h>
> =20
>  #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
>  #define AFTER_EQ(A, B) ((int)((A) - (B)) >=3D 0)
> =20
> +static void dql_check_stall(struct dql *dql)
> +{
> +=09unsigned long stall_thrs, now;
> +
> +=09/* If we detect a stall see if anything was queued */
> +=09stall_thrs =3D READ_ONCE(dql->stall_thrs);
> +=09if (!stall_thrs)
> +=09=09return;
> +
> +=09now =3D jiffies;
> +=09if (time_after_eq(now, dql->last_reap + stall_thrs)) {
> +=09=09unsigned long hist_head, t, start, end;
> +
> +=09=09/* We are trying to detect a period of at least @stall_thrs
> +=09=09 * jiffies without any Tx completions, but during first half
> +=09=09 * of which some Tx was posted.
> +=09=09 */
> +dqs_again:
> +=09=09hist_head =3D READ_ONCE(dql->history_head);
> +=09=09/* pairs with smp_wmb() in dql_queued() */
> +=09=09smp_rmb();
> +=09=09/* oldest sample since last reap */
> +=09=09start =3D (hist_head - DQL_HIST_LEN + 1) * BITS_PER_LONG;
> +=09=09if (time_before(start, dql->last_reap + 1))
> +=09=09=09start =3D dql->last_reap + 1;
> +=09=09/* newest sample we should have already seen a completion for */
> +=09=09end =3D hist_head * BITS_PER_LONG + (BITS_PER_LONG - 1);
> +=09=09if (time_before(now, end + stall_thrs / 2))
> +=09=09=09end =3D now - stall_thrs / 2;
> +
> +=09=09for (t =3D start; time_before_eq(t, end); t++)
> +=09=09=09if (test_bit(t % (DQL_HIST_LEN * BITS_PER_LONG),
> +=09=09=09=09     dql->history))
> +=09=09=09=09break;
> +=09=09if (!time_before_eq(t, end))
> +=09=09=09goto no_stall;
> +=09=09if (hist_head !=3D READ_ONCE(dql->history_head))
> +=09=09=09goto dqs_again;
> +
> +=09=09dql->stall_cnt++;
> +=09=09dql->stall_max =3D max_t(unsigned int, dql->stall_max, now - t);
> +
> +=09=09trace_dql_stall_detected(dql->stall_thrs, now - t,
> +=09=09=09=09=09 dql->last_reap, dql->history_head,
> +=09=09=09=09=09 now, dql->history);
> +=09}
> +no_stall:
> +=09dql->last_reap =3D now;
> +}
> +
>  /* Records completed count and recalculates the queue limit */
>  void dql_completed(struct dql *dql, unsigned int count)
>  {
> @@ -110,6 +161,8 @@ void dql_completed(struct dql *dql, unsigned int coun=
t)
>  =09dql->prev_last_obj_cnt =3D dql->last_obj_cnt;
>  =09dql->num_completed =3D completed;
>  =09dql->prev_num_queued =3D num_queued;
> +
> +=09dql_check_stall(dql);
>  }
>  EXPORT_SYMBOL(dql_completed);
> =20
> @@ -125,6 +178,10 @@ void dql_reset(struct dql *dql)
>  =09dql->prev_ovlimit =3D 0;
>  =09dql->lowest_slack =3D UINT_MAX;
>  =09dql->slack_start_time =3D jiffies;
> +
> +=09dql->last_reap =3D jiffies;
> +=09dql->history_head =3D jiffies / BITS_PER_LONG;
> +=09memset(dql->history, 0, sizeof(dql->history));
>  }
>  EXPORT_SYMBOL(dql_reset);
> =20
> @@ -133,6 +190,7 @@ void dql_init(struct dql *dql, unsigned int hold_time=
)
>  =09dql->max_limit =3D DQL_MAX_LIMIT;
>  =09dql->min_limit =3D 0;
>  =09dql->slack_hold_time =3D hold_time;
> +=09dql->stall_thrs =3D 0;
>  =09dql_reset(dql);
>  }
>  EXPORT_SYMBOL(dql_init);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index a09d507c5b03..94a622b0bb55 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1409,6 +1409,65 @@ static struct netdev_queue_attribute bql_hold_time=
_attribute __ro_after_init
>  =09=3D __ATTR(hold_time, 0644,
>  =09=09 bql_show_hold_time, bql_set_hold_time);
> =20
> +static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf=
)
> +{
> +=09struct dql *dql =3D &queue->dql;
> +
> +=09return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
> +}
> +
> +static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
> +=09=09=09=09  const char *buf, size_t len)
> +{
> +=09struct dql *dql =3D &queue->dql;
> +=09unsigned int value;
> +=09int err;
> +
> +=09err =3D kstrtouint(buf, 10, &value);
> +=09if (err < 0)
> +=09=09return err;
> +
> +=09value =3D msecs_to_jiffies(value);
> +=09if (value && (value < 4 || value > 4 / 2 * BITS_PER_LONG))

I admit I'm more than a bit lost with constant usage.. why 4/2 here?
Perhaps some more comments describing the implement logic would be
helpful.

Thanks!

Paolo

