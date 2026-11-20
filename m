Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162358;
	b=lG7akzDncKbvH717UqrskmjgdbqE3RnJJSf3wny1q/1yB05s0DZagCsbyoC2b7TsdLKD
	 6eMwN0xjzl8u/Dd3ch8yBfvuJeN0ocRgKCX5iWIDK+TClFNpFYVwWjgoY56fPonEzFigO
	 QL3pR/EwyQhmKDGLNfFEkxvkcqU9qv3TtN6ARMRFOqKvaG7fIGcaHi3VFptnUtvjzoLsH
	 2nyds4ywb7oip/UaM8pOaoiC9anJfhuhsGIR7VkiMeSPQAuULQt6pKECs0KZtmtGJy4+H
	 iNjhzhfF/3GIpbeEr9FN9W+tMZ1f1+Ex2hCRitGUSMyng2fqx+GTFPr8Wbo2tO1/Nbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162358;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=yny7ZCsaJaUBk2Uk+L6wiiJ87n/ATHV1ryvHlIqZ5Tk=;
	b=L/9eXmTmJCJ3RZus/098RzsmCpC0iJmeqpYfTNhJnXf9mB73swHQZCETJFo1WTfzSLyU
	 7ZYMdDY6UtAeA4epQUQZs/uiwUBBOl7hOtWAkeJQXQFmsgfwxFD8whlsF/YfUiSZzGUmM
	 vVYyZ21swSwe6wUg1jAoMEecfTDBEKddl8KOiko9e3RkN4eF9DZmthTGiooNz36QPAhJu
	 GNuweRGXsA0olKYqUdhlzNkjWLZ2oFYzEBKkMh1NpeEM8NajtLgNyGWW4B80L67FdIZvZ
	 70LB9hrfhxRc9FUVdoLfdd4TOc14jm7TZxunarMKQFt57pAxoq3GF4peU9rLw75u4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXUtFnpz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C494606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 08:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C494606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXUtFnpz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795162356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yny7ZCsaJaUBk2Uk+L6wiiJ87n/ATHV1ryvHlIqZ5Tk=;
	b=IXUtFnpzoAOlbIDtwZ8WhauUJZdHs65FhMtsHlehbYKGFuQtSIzLQ05rq44Oin7UKOOCOa
	kgTRfMcZRJS7vZuQHdBwcX3guq+UwrCfP8qIn5R4jopj0s+IdzhXlTQvqZKl26KaScuSGn
	oDtm0JzRrhuAuvWBEPjm+TD9fbq+vMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-bgDRtF6GOI6_JNp2IH6MVg-1; Fri, 20 Nov 2026 08:12:34 +0000
X-MC-Unique: bgDRtF6GOI6_JNp2IH6MVg-1
X-Mimecast-MFC-AGG-ID: bgDRtF6GOI6_JNp2IH6MVg_1795162353
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0af48c18so354157f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 00:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162353; x=1795767153;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yny7ZCsaJaUBk2Uk+L6wiiJ87n/ATHV1ryvHlIqZ5Tk=;
        b=EGS5enrGBLo22qbbsRmm+Qot+ma9hBcsxuNJnyKddwwszGVBMkPXfvmigaSTAxXVi5
         oyOJ7kTDnog/XZADPNuJn1jU3D6ZA1hgS4b7SBCQiTDuwlRKxEA2TfatSpBp+1OkuKJz
         4nbx/L1/4LKquIA3vE5HZZYstC9AkwXzztuMIv7u42TVtlMs53KFHI2nTK2uY2o42XC1
         3sH9dlzdrF+6JDPPU/ElTBx9qVunexYmlY7lGnFs6GOvMCfLsVGoq/UphGOq8b9k0uYF
         isdkzZEr00bgrfLjsjLkOIi8NuzvHSpzg/DGIh90Uul1+yvWvJgIi93xRuu2M0VrHocb
         eoLg==
X-Forwarded-Encrypted: i=1; AL+hErEnOReybqgqPAIulQTBwI99/BVCJbp9JZ4VxdyDnJW82FMPGR/NXUdKb/RTMkkEW6u4Guqv/DN3iy8v2102nSQjee8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VfO934Hg1etroxN7IT0JjSd2rS9DO2k5RtrFbLEIbzdxaXZ8S
	S4P0oxE3ay+fCuiBl4HmKNsE9Be97pYubkQEZlbcNonrAGffKzzyAza7ighMVAVnEEFrdk6Xy/D
	Z3Ic8fSaVEBW5uyTUODKK5Uvz2VW4/S3Igc5pE51f/O8LX97Qw8tTZZ4t5g0DjxzfYN94twXBGA
	==
X-Gm-Gg: AZFdTZfWb+WAZU8kW2je8d0agfk7hAhwEaMNoMgGDwpkInzrKzxubjJ/nlIO7kuT7zL
	LAr0UF3Sg+/RucW/vJLYaOHQfDW9EsDjH0m/5INcg0MPMbIwKJ4InjsQpZHJjl25daWiL1rYn7R
	c6oKNK+0/IQ9SNb5G9vT1wQ8VGbUR5QAfirck4SeyGJEDuyGyR+u3wllhhAiJmALo2JQsw9aROJ
	NmIPuQu1SqhPympizc+bf1gprSDwN3Nm0sxTozYMEPGao6c94uCFj8cVE8nrt5rCmeCpom4+01S
	xfSAllrAiD5spNgC/n9Y7YeU1YgM+uhIDPUCqDefb/zMq4FhavTWHV24n62Hjnjh/AzaSHVH2vu
	fbAAH/Zv2WKR9R4wTl+uqbXGvBM5TFqgtindoBdBjzey6an5nyjBCAdUm/Ambx2TtJnDPeTXVJy
	KM
X-Received: by 2002:a05:6000:22c2:b0:4ad:5e91:8fcb with SMTP id ffacd0b85a97d-4ad5e918ff5mr44921f8f.25.1795162352950;
        Fri, 20 Nov 2026 00:12:32 -0800 (PST)
X-Received: by 2002:a05:6000:22c2:b0:4ad:5e91:8fcb with SMTP id ffacd0b85a97d-4ad5e918ff5mr44869f8f.25.1795162352554;
        Fri, 20 Nov 2026 00:12:32 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf680fsm4565988f8f.14.2026.11.20.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:12:32 -0800 (PST)
Message-ID: <0a593f7ba6372245497cb9ac58dad1b71f9a2f4b.camel@redhat.com>
Subject: Re: [PATCH v8 08/14] rv: Support embedded target types in
 per-object DA storage
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 09:12:30 +0100
In-Reply-To: <49fd8e0482d2cf1f9c690031ab0cf9cc1eb1c5ad.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <49fd8e0482d2cf1f9c690031ab0cf9cc1eb1c5ad.1793900349.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: NMRpV3HyVzr6tIA14X8PzP4zUvGDqheWzBvHiR_Iy9k_1795162353
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> A PER_OBJ monitor usually typedefs monitor_target itself, as a pointer to
> the monitored object (borrowed: the object exists independently of the
> monitor and outlives the storage).
>=20
> A monitor whose target is monitor-owned data can instead define
> DA_OBJ_EMBEDDED_TYPE with a complete struct type: the framework then
> derives monitor_target as a pointer to it, embeds one instance in each
> per-object storage, and allocates and frees it together with the storage.
> On storage creation the caller-supplied target is shallow-copied into
> the storage before it is published, so it may be a fully initialised
> stack object.
>=20
> This allows per-object monitors to manage custom per-instance data withou=
t
> maintaining private mempools, complex multi-stage reference counting, or
> out-of-band teardown state machines.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Looks good, just a minor comment.

> =C2=A0/*
> =C2=A0 * da_get_target - return the object associated to the monitor
> + *
> + * NULL for an embedded target whose storage was pre-allocated but not f=
illed
> + * yet: a manual-allocation monitor publishes its storage before it has =
one.
> =C2=A0 */
> =C2=A0static inline monitor_target da_get_target(struct da_monitor *da_mo=
n)
> =C2=A0{
> -=09return container_of(da_mon, struct da_monitor_storage, rv.da_mon)-
> >target;
> +=09struct da_monitor_storage *mon_storage =3D
> +=09=09container_of(da_mon, struct da_monitor_storage, rv.da_mon);
> +
> +#ifdef DA_OBJ_EMBEDDED_TYPE
> +=09if (unlikely(da_storage_is_empty(mon_storage)))
> +=09=09return NULL;
> +#endif

We usually avoid ifdeffery inside functions like plague..
Could you embed this in TARGET_PTR?

  #define TARGET_PTR(storage) (unlikely(da_storage_is_empty(mon_storage)) ?=
 NULL : &(storage)->target)

> +=09return TARGET_PTR(mon_storage);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -572,8 +635,11 @@ static inline struct da_monitor
> *da_fill_empty_storage(da_id_type id,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_targ=
et target,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct da_mo=
nitor
> *da_mon)
> =C2=A0{
> -=09if (unlikely(da_mon && !da_get_target(da_mon)))
> -=09=09container_of(da_mon, struct da_monitor_storage, rv.da_mon)-
> >target =3D target;
> +=09struct da_monitor_storage *mon_storage =3D
> +=09=09container_of(da_mon, struct da_monitor_storage, rv.da_mon);
> +
> +=09if (unlikely(da_mon && da_storage_is_empty(mon_storage)))
> +=09=09da_storage_set_target(mon_storage, target);
> =C2=A0=09return da_mon;
> =C2=A0}
> =C2=A0
> @@ -589,7 +655,11 @@ static inline monitor_target
> da_get_target_by_id(da_id_type id)
> =C2=A0
> =C2=A0=09if (unlikely(!mon_storage))
> =C2=A0=09=09return NULL;
> -=09return mon_storage->target;
> +#ifdef DA_OBJ_EMBEDDED_TYPE
> +=09if (unlikely(da_storage_is_empty(mon_storage)))
> +=09=09return NULL;
> +#endif

Same here.

> +=09return TARGET_PTR(mon_storage);
> =C2=A0}

Thanks,
Gabriele

> =C2=A0
> =C2=A0static void da_kfree_cb(struct rcu_head *head)
> @@ -635,7 +705,7 @@ da_create_pool_storage(da_id_type id, monitor_target
> target,
> =C2=A0=09memset(mon_storage, 0, sizeof(*mon_storage));
> =C2=A0
> =C2=A0=09mon_storage->id =3D id;
> -=09mon_storage->target =3D target;
> +=09da_storage_set_target(mon_storage, target);
> =C2=A0
> =C2=A0=09hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
> =C2=A0=09return &mon_storage->rv.da_mon;

