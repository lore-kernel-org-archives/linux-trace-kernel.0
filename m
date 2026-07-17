Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21C1B87C9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296012; cv=none; b=TJE9Gh1AN5Ajx0t9NGJo5TChOmdyZhJcHv5wDfVFLPtWLdYT/kw47Wvjvx1lTXwn0Lpis8GO1wA5Ov5D1/nwSojNp75bvKyGTGlWKS99+R54bOpLsH5iAlhf3ZgI3TFXZC2AnrvoOAnSwDeW1OHXqpYdmawNLRNRBL1wpjAq+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296012; c=relaxed/simple;
	bh=m/5L0OFBWKV42uafGozZjAwp764bClWapkOLR2rKq3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhOWZuVryjgXn5bb7kK4xZBkNNFUZSahfKAZfVGhZ2Kzgx9e5fnVDLzIPdlz0wyLCoQJUMd5ZfVY6A3O70E7S7tuZ6mJQ5FZ644FvNtZaTTX/01KtxOsGH0Y4uaR3K9XFleIkorFm7zZ+ilkzwprElSXedBPQLP2QyBBGw2elIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ8cPR0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ8cPR0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784296007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W57OWcvw0raX8UN/2+x6BXJcNfgoMGVn8N2bsK+RPKk=;
	b=WJ8cPR0A3yCRq33cSkW3pX55MAn1f6cJWUM6aFJsvKwyW0Lg3fWYFZJ4GKQPgnkVhZULI6
	VWKEIlvaVDbJrVGxh+avJUYa9kRbjiYs1Dg+zTHF0Ec+QGjwfvIrBWGFRXJLGPcRLVD/Yr
	mGfbm8d6JLgbLO049BRd+h0biPdHxPs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ovvGABJ4P_qOJC4MVejGIQ-1; Fri, 17 Jul 2026 09:46:46 -0400
X-MC-Unique: ovvGABJ4P_qOJC4MVejGIQ-1
X-Mimecast-MFC-AGG-ID: ovvGABJ4P_qOJC4MVejGIQ_1784296005
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15fed5653eso419991866b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296005; x=1784900805;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=36Vt7F/I3KQTg1o9rXJVqnyEiEhrV/ViF+I5vNMFZGQ=;
        b=a4tngUIKfgOee1TwqciXXrSmSkZj4mUSmRcyYq8N9JGi/LN3obC28YSY4OuwnAkQR/
         p8fBfJDmQZcQqE8TJxHZkNSIek/6nEJiuw5zWqvGbGHCnS8u5t1wWqIBjpXpC/oOKgkY
         MrhnvgHrmlJhQrO+Rt0uaK9UuazJvxaveansQtHqYdVqodq053h2PGcAClt8PUwcgGON
         0UUeW7tYuKG5tDdKqbyzTNSZG+LCMxo08HArfmpgNJz0iTKSh6lu8BYyfcBKQ7EcY0ek
         zrLZCCDExpr+Gjbp0Zzm1AGK+G8Axb3ZzY17FOBHKq61txM9emN+j/uTY4TOSB09Pb95
         fsHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlkHu8XNFEk42X5hAKz6K9Dvc2TvErGbc2hoMflHTIzymqcWOuUO8C9F1KOvyGBC4FhS4ut9jScGVBLjx565m79ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVChuY8WyVd5dpMMGcvOqZO468VkbY8q7hEfGQcNEYuTWC2mE
	+AtBT046YLkDRS/YWfeaYg+6G+phPGXKmECYpnPWeoMu+qzSIYK3PqgSPny2TPizzbKeislmimV
	H38o4B6mp7X8oa8zaiI7eXoIyqa3tQCyp2+wesTQ56cGVzHCQ/rO87lZ8O0cF0b5QFxZ2ruFSxR
	v43X142y3n
X-Gm-Gg: AfdE7ckO+ZCeYfUJ0qBPSe5L1HYeAMiu5AL+eJTVo7UJCVfxh1gHN+XLM8u36Y13NTP
	85xbWuE8S40PM9Ix4pD3Nu04uU+7DtjmkraL4gc3FL2q2Es69YyqdelbQsTz5iU3zP/b1fYg3ZJ
	WUY7QRijnW0+ktKdaL8a6w1O85cypVnGD4jdwCN2CoKWCBL5+yxCZCjKI9PYws2Yt590UnVKdSz
	eIP/ZbpjsIDbC3QOEhbiPCvs4L8pu4TCAjjb6q7/39/h3Fdqxv0ViOCwJUlHA7Xn8HaD8LkaZOm
	nqlTiZ5+c6vpgn80WJKgiMPeXaIsWmCWl9qoUK7qRtsfM9OB8Q/MalQOLsU2wLqXbgFxNp3paGC
	2rj2adyipyojCpvGIVtP2ad78ERgGOnPnOEQkAOAzeTjB80mGYsjG467gWewzohZgO4eu4g==
X-Received: by 2002:a17:906:3a93:b0:c16:720c:831 with SMTP id a640c23a62f3a-c16b4854cfdmr75099866b.38.1784296005161;
        Fri, 17 Jul 2026 06:46:45 -0700 (PDT)
X-Received: by 2002:a17:906:3a93:b0:c16:720c:831 with SMTP id a640c23a62f3a-c16b4854cfdmr75098366b.38.1784296004477;
        Fri, 17 Jul 2026 06:46:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1740bf91bdsm74296766b.63.2026.07.17.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:46:44 -0700 (PDT)
Message-ID: <34e1dfd9b5c8ded4fba878714754813fb60c2431.camel@redhat.com>
Subject: Re: [PATCH v4 1/8] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Jul 2026 15:46:42 +0200
In-Reply-To: <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <42cda27998fca0ca2573baac60a01ab9620b91f0.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: xAAsa38CQtd1M57Yhhzdxl4-T9uLJgA003RKrJKeHbI_1784296005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Per-object DA storage allocation is currently limited to kmalloc on
> demand. Add a compile-time selector so monitors can choose among three
> strategies:
>=20
> =C2=A0 DA_ALLOC_AUTO=C2=A0=C2=A0 (default) - kmalloc per object on the mo=
nitor path
> =C2=A0 DA_ALLOC_POOL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - pre-allocated fixed-size llist pool;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 selected by defining DA_MON_POOL_SIZE
> =C2=A0 DA_ALLOC_MANUAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - caller pre-inserts storage; framework
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 only links the target field
>=20
> The pool strategy uses a lock-free llist (cmpxchg, no spinlock) so
> pool release is safe from RCU callback context without acquiring a
> lock. Moving allocation before the measurement window also prevents
> kmalloc latency.

Measurement window here is tlob's, remember RV isn't itself a measurement
tool (yet, perhaps).
And isn't this also happening with other methods? We're trying to do
allocation when the monitor starts (so before this measurement window).

I'm a bit puzzled since you're mentioning it many times, when have we
done /allocations/ from RCU callbacks?
We surely do deallocations (kfree_rcu) but allocations are at most in RCU
read-side critical sections and it's perfectly fine to take sleeping
spinlocks there (that's a special kind of sleep under PREEMPT_RT).
Besides I'm not quite sure spinlocks are that bad in RCU callbacks
either (kfree surely takes them).
I'm not sure what you mean here but I don't think deallocation was ever
a problem, was it?

> nomiss is updated to DA_ALLOC_MANUAL.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 247 ++++++++=
+++++++++++----
> =C2=A0include/rv/ha_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
6 +
> =C2=A0kernel/trace/rv/monitors/nomiss/nomiss.c |=C2=A0=C2=A0 6 +-
> =C2=A03 files changed, 221 insertions(+), 38 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 34b8fba9ecd4..9c9acc123e3b 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -14,7 +14,56 @@
> =C2=A0#ifndef _RV_DA_MONITOR_H
> =C2=A0#define _RV_DA_MONITOR_H
> =C2=A0
> +/*
> + * Allocation strategies for RV_MON_PER_OBJ monitors.
> + *
> + * Select the strategy with a single define before including this header=
:
> + *
> + *=C2=A0=C2=A0 #define DA_MON_POOL_SIZE N=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - pool mode; N pre-allocated slots.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Implies DA_ALLOC_POOL
> automatically.
> + *=C2=A0=C2=A0 #define DA_MON_ALLOCATION_STRATEGY \
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DA_ALLOC_=
MANUAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - manual mode (see below).
> + *=C2=A0=C2=A0 (neither)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - auto mode (default).
> + *
> + * Do not define both DA_MON_POOL_SIZE and DA_MON_ALLOCATION_STRATEGY.
> + *
> + * DA_ALLOC_AUTO=C2=A0=C2=A0 - lock-free kmalloc on the hot path; unboun=
ded capacity.
> + * DA_ALLOC_POOL=C2=A0=C2=A0 - pre-allocated fixed-size pool; set by def=
ining
> DA_MON_POOL_SIZE.
> + * DA_ALLOC_MANUAL - caller inserts storage before da_handle_start_event=
();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the framework only links the target=
 field.
> + */
> +#define DA_ALLOC_AUTO=C2=A0=C2=A0 0
> +#define DA_ALLOC_POOL=C2=A0=C2=A0 1
> +#define DA_ALLOC_MANUAL 2
> +
> +#ifdef DA_MON_POOL_SIZE
> +#ifdef DA_MON_ALLOCATION_STRATEGY
> +#error "Define only one of DA_MON_POOL_SIZE or DA_MON_ALLOCATION_STRATEG=
Y"
> +#endif
> +#if DA_MON_POOL_SIZE =3D=3D 0
> +#error "DA_MON_POOL_SIZE must be non-zero"
> +#endif
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
> +#endif

Longer ifdefs should have comments to make them readable, like

  #endif /* DA_MON_POOL_SIZE */

> +
> +#ifndef DA_MON_ALLOCATION_STRATEGY
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
> +#endif
> +
> +/*
> + * Provide a zero default so da_monitor_init() can reference
> + * DA_MON_POOL_SIZE in a plain C if() without an #if guard; the
> + * compiler eliminates the dead branch.
> + */
> +#ifndef DA_MON_POOL_SIZE
> +#if DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL
> +#error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined and non-ze=
ro"
> +#endif
> +#define DA_MON_POOL_SIZE 0
> +#endif

Same here, better to have a comment.

> +
> =C2=A0#include <rv/automata.h>
> +#include <linux/llist.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0#include <linux/stringify.h>
> =C2=A0#include <linux/bug.h>
> @@ -66,6 +115,16 @@ static struct rv_monitor rv_this;
> =C2=A0#define da_monitor_sync_hook()
> =C2=A0#endif
> =C2=A0
> +/*
> + * Per-object teardown hook, called after da_monitor_reset_all() +
> + * da_monitor_sync_hook() and before hash_del_rcu() for each entry.
> + * All HA timer callbacks have completed at this point.
> + * Define before including this header.=C2=A0 Default: no-op.
> + */
> +#ifndef da_extra_cleanup
> +#define da_extra_cleanup(da_mon)
> +#endif
> +
> =C2=A0/*
> =C2=A0 * Type for the target id, default to int but can be overridden.
> =C2=A0 * A long type can work as hash table key (PER_OBJ) but will be dow=
ngraded to
> @@ -404,6 +463,12 @@ struct da_monitor_storage {
> =C2=A0=09union rv_task_monitor rv;
> =C2=A0=09struct hlist_node node;
> =C2=A0=09struct rcu_head rcu;
> +=09/*
> +=09 * Mutually exclusive with rcu: rcu is live during the RCU callback
> +=09 * flight; free_node when the slot is in da_pool_free_list.
> +=09 * Present in all monitors to avoid #if-gating the pool helpers.
> +=09 */

I really don't understand much more about it by this comment, perhaps
drop it here and make the separate usages clearer later?

By the way, if they are /really/ mutually exclusive and you want to save
space, why not having them in an anonymous union?

> +=09struct llist_node free_node;
> =C2=A0};
> =C2=A0
> =C2=A0#ifndef DA_MONITOR_HT_BITS
> @@ -495,18 +560,6 @@ static inline da_id_type da_get_id(struct da_monitor
> *da_mon)
> =C2=A0=09return container_of(da_mon, struct da_monitor_storage, rv.da_mon=
)-
> >id;
> =C2=A0}
> =C2=A0
> -/*
> - * da_create_or_get - create the per-object storage if not already there
> - *
> - * This needs a lookup so should be guarded by RCU, the condition is che=
cked
> - * directly in da_create_storage()
> - */
> -static inline void da_create_or_get(da_id_type id, monitor_target target=
)
> -{
> -=09guard(rcu)();
> -=09da_create_storage(id, target, da_get_monitor(id, target));
> -}
> -
> =C2=A0/*
> =C2=A0 * da_fill_empty_storage - store the target in a pre-allocated stor=
age
> =C2=A0 *
> @@ -537,15 +590,79 @@ static inline monitor_target
> da_get_target_by_id(da_id_type id)
> =C2=A0=09return mon_storage->target;
> =C2=A0}
> =C2=A0
> +/*
> + * Lock-free llist (cmpxchg) rather than kmem_cache/mempool: on
> + * PREEMPT_RT spinlock_t becomes a sleeping lock, which is forbidden
> + * in the rcuc kthread context where RCU callbacks run.

This comment kind of implies we were using a kmem_cache, it's great for
a changelog and helped me understand why you're doing this, but doesn't
belong to the final version as is.

> + *
> + * Multiple producers (any context, any CPU) call llist_add; a single
> + * consumer (llist_del_first, serialised by the monitor's start lock)

Which monitor's start lock? There is no such a thing defined anywhere,
maybe you wanted to say that monitors using this allocation scheme MUST
lock during their start event. This by the way needs to be a global lock
among all instances of the monitor (as you're indeed doing in tlob).

With that in mind, I don't really see how this is better than the
original mempool: you still need to lock. There's nothing wrong in
freeing stuff from RCU callbacks, that's what they're for.

> + * needs no additional synchronisation.
> + *
> + * Per-TU statics: each PER_OBJ monitor gets its own pool instance;
> + * da_pool_storage and da_pool_free_list are NULL/empty and the pool
> + * paths are dead code for non-pool monitors.
> + */

> +static struct da_monitor_storage *da_pool_storage;
> +static LLIST_HEAD(da_pool_free_list);

...

> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -17,8 +17,8 @@
> =C2=A0
> =C2=A0#define RV_MON_TYPE RV_MON_PER_OBJ
> =C2=A0#define HA_TIMER_TYPE HA_TIMER_WHEEL
> -/* The start condition is on sched_switch, it's dangerous to allocate th=
ere
> */
> -#define DA_SKIP_AUTO_ALLOC
> +/* Allocate storage in sched_setscheduler; sched_switch is too hot to al=
loc.
> */
> +#define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
> =C2=A0typedef struct sched_dl_entity *monitor_target;
> =C2=A0#include "nomiss.h"
> =C2=A0#include <rv/ha_monitor.h>
> @@ -214,7 +214,7 @@ static void handle_sys_enter(void *data, struct pt_re=
gs
> *regs, long id)
> =C2=A0=09if (p->policy =3D=3D SCHED_DEADLINE)
> =C2=A0=09=09da_reset(EXPAND_ID_TASK(p));
> =C2=A0=09else if (new_policy =3D=3D SCHED_DEADLINE)
> -=09=09da_create_or_get(EXPAND_ID_TASK(p));
> +=09=09da_create_empty_storage(get_entity_id(&p->dl, task_cpu(p),
> DL_TASK));

I'm starting to doubt this is the right thing to do. We do have the
target (p) and that function doesn't check if the id already has a
storage (which shouldn't happen but well, doesn't hurt checking).

This simplification is probably just not worth it, and doesn't look
related to the rest of the change.

Thanks,
Gabriele

