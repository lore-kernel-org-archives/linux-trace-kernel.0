Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008647;
	b=mEc5IA6wDgCQjwcn7jcbuLsujofh2FXV1tO9G3xX1XU9zLzdr6CH1TrrAKbf1tmMFezx
	 7d6VfWuKZnbWelfjfbjhKBbKcoxaRNNcYwUiSrAs2D8eAwiVNly/6ijLJ6eUBeuijQpeu
	 oG12Ni3bT0LR079vjZrNEvuVsZj5c3kF3Q7f/4d6YvpnhA/E2lLf523L/uzff+uuGv6NU
	 YsgTdymuXTLBiT+cfKugOMD8v2y/bT76HtG8OWfGzMlL3zHfAi1rUaysgrVvKBIZ/vZRk
	 h4G9c4Byf05641POLLA80AkGCZ8/6fsARfrEtv6fLtx95MK29bOHTl/i4g3I/y6+bvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008647;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=JTCqnzsxX/3nE49CngBy+g5LF98SrJW9/PZyzZjuy1E=;
	b=f5WFOJWAjOfzQpyhsSpxJZVFKdn3n6oreVxv5z1xRSVNw3fpv2KnQdJrSvTn7Kbz5V2q
	 EHKfT5OQ38up+dOARaYUteAIu0yOiGDY05dlHvR9cGlmG/Nd7Cee+X5tMsl6TSwAxnYpI
	 e8T/1SkFssyI0a4Ezs6Y7JC3CeBB/7qplY8anVNNtQdgutHEZhLAmoEvJKywclG+J5Dxe
	 yyYZcWB0oqmh8ljRbJ8zlv5NuK5nCCIg5a0A61S0cttnYORxtgQUu7KvY28Yy9CgR6ntm
	 dkqgM0tcNP9YUE60ZptKFIa3B2VtQWoDm7rmm5Fjv+wUmGE8GkUJ9iZF4Nf1pCE0niw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9NjPQIn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55779606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 09:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55779606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9NjPQIn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793008645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JTCqnzsxX/3nE49CngBy+g5LF98SrJW9/PZyzZjuy1E=;
	b=G9NjPQInaEFqVthMgjTuwBaToeMUuoatq2E9KH0TbCJne9RGwQawOL0y61BXgET8hVcS3O
	W2B/+u2dhVhjf0Tv0ixrdYX6cw16aOyEvA4Qxu8BVHZL2CfDWhNbZ99znOD6c6MHbTlYrz
	EfxLuYqO2vJN1nxop172TPF1G8fmFhU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-VmCNcYE4PBqOwb-QFbqesQ-1; Mon, 26 Oct 2026 05:57:23 -0400
X-MC-Unique: VmCNcYE4PBqOwb-QFbqesQ-1
X-Mimecast-MFC-AGG-ID: VmCNcYE4PBqOwb-QFbqesQ_1793008643
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4870142f030so1709609f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 02:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008642; x=1793613442;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0cP7bHbkVnJIoWQHM/hNh1+7ETLTN+9A+Z6R6C59Ogw=;
        b=wrwzSrTsaxuwIzhm5V02OkDmSMwMY1iNY7XbKoti8qVUKbskeuwhGvP5iXtOCMX9G3
         WepdpDYpCr01yivIS3u6PltDlUn3LJASd4EmUvb18angu6qMtcfaChGzApP2PTCbzUKL
         Ya8qbuyklmcRDE78XN4oY4meUvgY0xyBaoB/F7UiGTBHSKxfmw8+drp87OMWKZJ/cOCt
         +E0C9gK5Jm1I/373SNWlJLacsbZCtx/FUAyJWY5z2oO0y3G8oCUjpu2nTsFNo5UmXOjA
         8AWG9zo4rG4mDXZlTa8PLBatW3qXbld7AR/6F2ybajKVxmTGiEdqe5e5U75LL1h8N4Wc
         xzOA==
X-Forwarded-Encrypted: i=1; AKwUvBzHBq3H1zUGfQEczDGbmspGXpg1AzF79cMCC7nw50T+kopvAQBB97UuWJ3wtHI3GeWCTh4feAlrxT7AaJRk8gOajzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzhMLrUUj4kyeQz6M0GTZXDuYH1h9J16RBA7JOSUkjovIzMHce
	T84zWp2cDGStoXahhX4LYX70RJXEQli6Z5wdJZc1Jczgs8XIRf1BB6jKtrBiZBz9INoaIizGKO+
	SPgY4Zejtwjo4fzOi0yhuNQdCvb0thG84cBH25BK80pqFh2yy/l+GlFS7dy0TDVKqvvmbcoAbp/
	QwpTBUnA==
X-Gm-Gg: AYBFou1qVs0S2Md8cOyk68lXPuV/5/2SA9ZIm/c5HoWyCPpHYczMtXhPhj9j3BvBbu8
	t+E8OP3USGkFlrVHPPGagDskrUwwXSqdL1C1xfSEzPJAH1Tku8m3DWROdJJdvYmrDD7CviTocnQ
	Qe7TubeKAz3LQqmmEWvagq6y1hJp2o80EDNZO7o7h66jfsYTmEkVYhgY3+Brw/iDhnA4bQCSwmQ
	fsd/n5CEO+MU+xqW3R62Hckq6FZYpLewhLh66MFKKigF0fIr7ksb9FYqpdDUqwXKUIZQbcxKzH0
	EN3tNO+6Gf+J5eTJvJ1Ohn06mVl+slNKepa1R+WcIPofGPQHxgBr4Xg0mqZfUwYlaT+32WHKW6Z
	+S4tLL7H5xgnkqG6syBcvi6wmDZUG
X-Received: by 2002:a5d:43ce:0:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-48e3eb9fdfcmr8414742f8f.43.1793008642466;
        Mon, 26 Oct 2026 02:57:22 -0700 (PDT)
X-Received: by 2002:a5d:43ce:0:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-48e3eb9fdfcmr8414708f8f.43.1793008642046;
        Mon, 26 Oct 2026 02:57:22 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece14a1sm15843421f8f.57.2026.10.26.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:57:20 -0700 (PDT)
Message-ID: <a0d96dd77c308dc558da93b13dcc024518f58c2c.camel@redhat.com>
Subject: Re: [PATCH v7 04/14] rv: Disarm HA timers on the storage free path
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 10:57:19 +0100
In-Reply-To: <3d5a8a567f1c1921f725c31a780845ff23e5abb9.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
	 <3d5a8a567f1c1921f725c31a780845ff23e5abb9.1791745088.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: UzqxUhE5PjCPHAYMP0yXTOSq0FBsZUJSgWoPAGRMSIg_1793008643
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
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

Mmh, looks reasonable, I probably need to check this whole cleanup path aga=
in
for consistency and duplication.

>=20
> Add da_monitor_free_hook(), called right before a per-object storage is
> freed, from the RCU callback and from da_monitor_destroy().=C2=A0 HA moni=
tors
> implement it with ha_cancel_timer_sync().=C2=A0 Replace kfree_rcu() with
> call_rcu() so there is a callback to hook.
>=20
> A storage whose monitor never started has a zeroed timer, and
> hrtimer_cancel() dereferences timer->base.=C2=A0 nomiss pre-creates one s=
uch
> storage per possible CPU.=C2=A0 Skip them with the new ha_timer_ready().

I struggled with this too, but relying on the internal representation of ti=
mers
for this is brittle, can you use da_monitoring() there, like we do in
ha_monitor_reset_env()? We shouldn't have running timers when not monitorin=
g.

I still want to give a deeper look at this when I get more time.

Thanks,
Gabriele

>=20
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0include/rv/da_monitor.h | 23 ++++++++++++++++++++++-
> =C2=A0include/rv/ha_monitor.h | 26 ++++++++++++++++++++++++++
> =C2=A02 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index e3cf85c9ce55..2cd260208bc1 100644
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
> @@ -564,7 +584,7 @@ static inline void da_destroy_storage(da_id_type id)
> =C2=A0=09=09return;
> =C2=A0=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> =C2=A0=09hash_del_rcu(&mon_storage->node);
> -=09kfree_rcu(mon_storage, rcu);
> +=09call_rcu(&mon_storage->rcu, da_kfree_cb);
> =C2=A0}
> =C2=A0
> =C2=A0static void __da_monitor_reset_all(void (*reset)(struct da_monitor =
*))
> @@ -607,6 +627,7 @@ static inline void da_monitor_destroy(void)
> =C2=A0=09 * pending, we can safely assume no concurrent user.
> =C2=A0=09 */
> =C2=A0=09hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
> +=09=09da_monitor_free_hook(&mon_storage->rv.da_mon);
> =C2=A0=09=09hash_del_rcu(&mon_storage->node);
> =C2=A0=09=09kfree(mon_storage);
> =C2=A0=09}
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 499ce60779f9..99b60d0d26b6 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -29,6 +29,8 @@ static inline void ha_monitor_reset_env(struct da_monit=
or
> *da_mon);
> =C2=A0static inline void ha_setup_timer(struct ha_monitor *ha_mon);
> =C2=A0static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
> +static inline bool ha_timer_ready(struct ha_monitor *ha_mon);
> +static inline void ha_monitor_free_env(struct da_monitor *da_mon);
> =C2=A0static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
> =C2=A0=09=09=09=09=09 enum states curr_state,
> =C2=A0=09=09=09=09=09 enum events event,
> @@ -38,6 +40,7 @@ static bool ha_monitor_handle_constraint(struct da_moni=
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
> @@ -467,8 +470,15 @@ static inline bool ha_cancel_timer(struct ha_monitor
> *ha_mon)
> =C2=A0{
> =C2=A0=09return timer_delete(&ha_mon->timer);
> =C2=A0}
> +/* timer_setup() sets it; the cancel paths here never clear it. */
> +static inline bool ha_timer_ready(struct ha_monitor *ha_mon)
> +{
> +=09return READ_ONCE(ha_mon->timer.function);
> +}
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> =C2=A0{
> +=09if (!ha_timer_ready(ha_mon))
> +=09=09return;
> =C2=A0=09timer_delete_sync(&ha_mon->timer);
> =C2=A0}
> =C2=A0#elif HA_TIMER_TYPE =3D=3D HA_TIMER_HRTIMER
> @@ -524,8 +534,18 @@ static inline bool ha_cancel_timer(struct ha_monitor
> *ha_mon)
> =C2=A0{
> =C2=A0=09return hrtimer_try_to_cancel(&ha_mon->hrtimer) =3D=3D 1;
> =C2=A0}
> +/*
> + * hrtimer_cancel() reads timer->base before anything else; a zeroed tim=
er
> + * has it NULL and would fault.
> + */
> +static inline bool ha_timer_ready(struct ha_monitor *ha_mon)
> +{
> +=09return READ_ONCE(ha_mon->hrtimer.base);
> +}
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> =C2=A0{
> +=09if (!ha_timer_ready(ha_mon))
> +=09=09return;
> =C2=A0=09hrtimer_cancel(&ha_mon->hrtimer);
> =C2=A0}
> =C2=A0#else /* HA_TIMER_NONE */
> @@ -538,9 +558,15 @@ static inline bool ha_cancel_timer(struct ha_monitor
> *ha_mon)
> =C2=A0{
> =C2=A0=09return false;
> =C2=A0}
> +static inline bool ha_timer_ready(struct ha_monitor *ha_mon) { return fa=
lse;
> }
> =C2=A0static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) =
{ }
> =C2=A0#endif
> =C2=A0
> +static inline void ha_monitor_free_env(struct da_monitor *da_mon)
> +{
> +=09ha_cancel_timer_sync(to_ha_monitor(da_mon));
> +}
> +
> =C2=A0#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> =C2=A0#ifdef RV_MON_OPS_INIT
> =C2=A0#undef RV_MON_OPS_INIT

