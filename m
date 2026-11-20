Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193749;
	b=LnLAp/zSC+GX67U80A3rHWH4VgwSHMWk2MVJR+JDiDmvopZUPrHYVZFf61XAPr26eglJ
	 I7xVV7/B/+ESp4xALSrdv45hg08hRF/VxdcdW8FwbLVwe0S+2q5gW5jYQy5iJqAy0u+Hu
	 q2Lq7gceQXhSESEE1kV9DyoTyeRrBJxuPX3ZwfNhLUiHr9m9zedxV6gj/Si+8mJjkw4h/
	 xvY4ndGQV7mjgxYbJKzitIrM+Y5vHZQtltJ+M5ITtNEnf+iKGZcAQN1puwnNplEFWY3Td
	 IWhGgvbxksy1D6Djzd8jJngvYa5O87v/U+2BSCMgj+Pa02iylCfulJ02R+vX6sATHeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193749;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=KfINgigE+Qsibsmg3Pd332ceU/DO12uJAUgUbTLWkTU=;
	b=X+MYCsP4TVDj/iCoVb09ZXBNSh09G+4+hKQBlzhUn1H09vr3tzhCWVvlq7mt/goTqTc1
	 gtJzhMGsnDs2yt+Kpm+EgTDV+5VcsfGGz19Iwu1aK3uWLy2KfuEQJGBKSnAOI7LCdec99
	 JJjfOIdQDw9dv8cin4rU5Qd4OeYnpGVbtYj+Ft1K8RI8VtDtoQJ8YCsz5usdcdMlGc9er
	 p7alLf5fSciwVgqozXtbJi3rUGKgtb1NNY6eZd+tUJilxXQPOkp3IE2kbVvU1lbNTvK9f
	 EhhlmxpLDrKqnrI+QFqSTM1N0+qv6YejHgcZUVWm1L+fy2h7X021HHHyKUsIb/FQN3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzWReUzt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6060A2605
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 16:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC6060A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzWReUzt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795193747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KfINgigE+Qsibsmg3Pd332ceU/DO12uJAUgUbTLWkTU=;
	b=IzWReUztGDa0aZ/XmrtUV+IclGHGJOAixFcndomh8cE88jEsUjOll1GzRlBBcNiKurTahR
	0JzmIgRAz6XBSqo4NZdFq4FI/vj7hdv1JuunBfA5mqIQ/9qBYR+0Qs4/pGQKyKdh3a1YPb
	i8Z1jpsBUaTF3tzYJdyDPrKsoLqU0M0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-1PU3550oMaiu1LrAo04bSg-1; Fri, 20 Nov 2026 16:55:43 +0000
X-MC-Unique: 1PU3550oMaiu1LrAo04bSg-1
X-Mimecast-MFC-AGG-ID: 1PU3550oMaiu1LrAo04bSg_1795193742
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e29c25101so467022f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 08:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193742; x=1795798542;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KfINgigE+Qsibsmg3Pd332ceU/DO12uJAUgUbTLWkTU=;
        b=ii7D9jGA4NdoihkKZGFgszDFMuqbxLHiDs1vSaWb8tCBqfaTF+uk3ThM937pHP4J40
         623hxQ4R+BIlTr2+APXnEWTTKA1Adc1fWd8taOiMHVY5bbzLlteJWSu93Q1AwH8WLmU7
         8ZIpBHUfAYpluAttbqFIYFsZGKq5gBjGiBwFP7z3u6awFq6aCixSazDtl9o7X4V4ioka
         dyeKCbdHxoIY4UK55JWo6Uzb7lBiJpfZUGsy/Xgntr6i37ViySuv/QuVKoBQDvH4Ktjr
         5c0S3bXKwlV/GKouAI6zbsSGjYLI6GFQ26n9id4hQE/xJw6qWw1yp4r7jBiSrJ13V26w
         sf8w==
X-Forwarded-Encrypted: i=1; AL+hErFEWrsdeZSbJC2MQElKQTQ2tS9AzvGAUKD4j5KO9gf+EsJ6gKz6k2aEIQXi055ppswP3WzMltegFYWshOe8KwOdSG0=@vger.kernel.org
X-Gm-Message-State: APuU4Z84A6nPUB0cjPm3kjowAGdTFnBfwYVeGX+alPQNHXTY4sQpSjV/
	jl/vUoEgsvE6shKPq7US/M/DTLgBQ6maM4n2GJhgIXLkhJFdrVV1IQaIYBliSzILTZxej5wSfX1
	eO+kUre+vT9MTmH8fWk0g8oDT82YCNBbX4vua/ZWqHhm1DaRDSyp3EYUIWKbT0OOG3eSt7sTkog
	==
X-Gm-Gg: AZFdTZc5fyq53tTceTUKD90erZGVDCEn31TvKMyJ7O5wIpaZTq/joK2nFCH8FW0VzCN
	2AF/qZxB+SB8O6CRExxQdfblMQ0okb8e6s+IbS8gUsAe1shX1ryADgffE+LDm5tlKat8WdN3E3L
	ylDC6jlYSaCHZ479n7Wmh0pG4oywRP89Yrc2MqpeQl/k/WyxC6HaejtXw0FM/t+KcXe0HrwPF1r
	TK59cv/1wGcL007l47hSgvho0DnmK1AGEUyHb1xlB6d7K69UmtlfUH2wI4FhsQ3V0i75PROAzdp
	sooX6TVaqmIZJn+X1LQRIaGjEe681IhNCjcZMn8LiqhHwbHb5qFx7uFofV0SjV7927v3vVI1eQb
	GvsmrUjSeo+OqAQ848Nz9ifJ0ObmKVMgf2S8pmShdGi13a4SzSU8SRDr7e3NKmNFcRYmGZR56K/
	3J
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4abab02c60amr8111243f8f.5.1795193741927;
        Fri, 20 Nov 2026 08:55:41 -0800 (PST)
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4abab02c60amr8111219f8f.5.1795193741582;
        Fri, 20 Nov 2026 08:55:41 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9add26sm6819963f8f.44.2026.11.20.08.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:41 -0800 (PST)
Message-ID: <fd165f2b52d7a9afaa30c29963178da08fbc3521.camel@redhat.com>
Subject: Re: [PATCH v8 04/14] rv: Disarm HA timers on the storage free path
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 17:55:40 +0100
In-Reply-To: <0ab3632933008e028855e158b4b978881a2715dc.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <0ab3632933008e028855e158b4b978881a2715dc.1793900349.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WTKBK5Hhp_PWWD8NqH-Wekz7tnhB1v9kv_ntkfqd2xg_1795193742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> da_destroy_storage() cancels the HA timer through da_monitor_reset_hook()
> and only then unlinks the storage with hash_del_rcu().=C2=A0 A handler on
> another CPU that looked the storage up before the unlink can still call
> ha_start_timer_*() after the cancel.=C2=A0 The timer then stays queued on=
 a
> storage that kfree_rcu() frees a grace period later, and fires on freed
> memory, reporting a violation for an object that no longer exists.
>=20
> A monitor cannot close this from its own handlers: any cancel it issues
> precedes the unlink.=C2=A0 The first point no reader can race with is the
> RCU callback that frees the storage.
>=20
> Add da_monitor_free_hook(), called right before a per-object storage is
> freed, from the RCU callback and from da_monitor_destroy().=C2=A0 HA moni=
tors
> implement it by calling ha_cancel_timer_sync() if da_monitoring() is true=
.
> Replace kfree_rcu() with call_rcu() so there is a callback to hook.
>=20
> Cancelling synchronously from the RCU callback is safe: HA hrtimers are
> always armed in HARD mode, so hrtimer_cancel() only spins, and on
> PREEMPT_RT, where timer_delete_sync() may sleep, RCU callbacks run in
> the rcuc kthread.
>=20
> Storages whose monitor never started are skipped via da_monitoring().
>=20
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Looks good to me, thanks

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/rv/da_monitor.h | 27 ++++++++++++++++++++++++++-
> =C2=A0include/rv/ha_monitor.h |=C2=A0 8 ++++++++
> =C2=A02 files changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index e3cf85c9ce55..c7f9733fb8a4 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -67,6 +67,17 @@ static struct rv_monitor rv_this;
> =C2=A0#define da_monitor_sync_hook()
> =C2=A0#endif
> =C2=A0
> +/*
> + * Called on the last reference to a storage, right before it is freed.
> + * Monitors embedding a timer disarm it here: an earlier point races wit=
h a
> + * reader that resolved the storage before hash_del_rcu(), and
> + * tracepoint_synchronize_unregister() only covers tracepoint probes.
> + * Default: no-op.
> + */
> +#ifndef da_monitor_free_hook
> +#define da_monitor_free_hook(da_mon)
> +#endif
> +
> =C2=A0/*
> =C2=A0 * Type for the target id, default to int but can be overridden.
> =C2=A0 * A long type can work as hash table key (PER_OBJ) but will be dow=
ngraded to
> @@ -543,6 +554,15 @@ static inline monitor_target
> da_get_target_by_id(da_id_type id)
> =C2=A0=09return mon_storage->target;
> =C2=A0}
> =C2=A0
> +static void da_kfree_cb(struct rcu_head *head)
> +{
> +=09struct da_monitor_storage *ms =3D
> +=09=09container_of(head, struct da_monitor_storage, rcu);
> +
> +=09da_monitor_free_hook(&ms->rv.da_mon);
> +=09kfree(ms);
> +}
> +
> =C2=A0/*
> =C2=A0 * da_destroy_storage - destroy the per-object storage
> =C2=A0 *
> @@ -564,7 +584,11 @@ static inline void da_destroy_storage(da_id_type id)
> =C2=A0=09=09return;
> =C2=A0=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> =C2=A0=09hash_del_rcu(&mon_storage->node);
> -=09kfree_rcu(mon_storage, rcu);
> +=09/*
> +=09 * A reader from before hash_del_rcu() may still arm; the free
> +=09 * callback runs past it, so the hook disarms there.
> +=09 */
> +=09call_rcu(&mon_storage->rcu, da_kfree_cb);
> =C2=A0}
> =C2=A0
> =C2=A0static void __da_monitor_reset_all(void (*reset)(struct da_monitor =
*))
> @@ -607,6 +631,7 @@ static inline void da_monitor_destroy(void)
> =C2=A0=09 * pending, we can safely assume no concurrent user.
> =C2=A0=09 */
> =C2=A0=09hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
> +=09=09da_monitor_free_hook(&mon_storage->rv.da_mon);
> =C2=A0=09=09hash_del_rcu(&mon_storage->node);
> =C2=A0=09=09kfree(mon_storage);
> =C2=A0=09}
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index ebb7f91e3447..3bf1dd15544c 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -29,6 +29,7 @@ static inline void ha_monitor_reset_env(struct da_monit=
or
> *da_mon);
> =C2=A0static inline void ha_setup_timer(struct ha_monitor *ha_mon);
> =C2=A0static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
> +static inline void ha_monitor_free_env(struct da_monitor *da_mon);
> =C2=A0static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
> =C2=A0=09=09=09=09=09 enum states curr_state,
> =C2=A0=09=09=09=09=09 enum events event,
> @@ -38,6 +39,7 @@ static bool ha_monitor_handle_constraint(struct da_moni=
tor
> *da_mon,
> =C2=A0#define da_monitor_init_hook ha_monitor_init_env
> =C2=A0#define da_monitor_reset_hook ha_monitor_reset_env
> =C2=A0#define da_monitor_sync_hook() synchronize_rcu()
> +#define da_monitor_free_hook ha_monitor_free_env
> =C2=A0
> =C2=A0#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE =3D=3D RV_MON_PER=
_TASK
> =C2=A0/*
> @@ -551,6 +553,12 @@ static inline bool ha_cancel_timer(struct ha_monitor
> *ha_mon)
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) =
{ }
> =C2=A0#endif
> =C2=A0
> +static inline void ha_monitor_free_env(struct da_monitor *da_mon)
> +{
> +=09if (da_monitoring(da_mon))
> +=09=09ha_cancel_timer_sync(to_ha_monitor(da_mon));
> +}
> +
> =C2=A0#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> =C2=A0#ifdef RV_MON_OPS_INIT
> =C2=A0#undef RV_MON_OPS_INIT

