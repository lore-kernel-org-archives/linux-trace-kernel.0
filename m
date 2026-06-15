Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809E3D9684
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518353; cv=none; b=CDBAW3iAkY9WChH9RE/etKG4NhK9uj9CG89YJzEfnnEoOj3iYlHbOjTIe71A0BoXOMcSDNm4kCnewVdfwbzfwKPn1sa2d/RAYLi2CocuO958fgBcAKCvMmTlUm5DrH6SnZM78OtJvWlZaX7vq/VeIZcx/8NTipe2urnX/SjKQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518353; c=relaxed/simple;
	bh=mc1zxisHkWiVd7CBd3GkM0WhffpmJu3KmjNbCP1J9gw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRxF4vPSKBhKzxmwzlh+zuf0jP+thgXhYooN7FN8qiqy7gd6JU+HjCiDQexJ/T7lsdL8vZR2rlbk+YGa8z1Xx7xevh/phVKS+g9SxyL1z1YrQe4q91fLZ2zkdi9TCWdWXFjrhHEjolR2hdSrNPPmWq+Ixyy8Lq28txWfGEPNDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrHvf6RK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrHvf6RK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781518350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mc1zxisHkWiVd7CBd3GkM0WhffpmJu3KmjNbCP1J9gw=;
	b=ZrHvf6RKZ8Vrt3Uzb7GEMFtuGYDlpujhRhiyH6S//UhQtTmOmulgn7lkNXeSopsyyO+7Kb
	2FXUyiY1ogBxPUw5m2ZMncRWKfz3uAeoIiSN0sVvcvpuKyBLL/N8b7BHv/9iisqpAyCg83
	WwCXWeV8XCav0AzAzE78iuJWzDfI1C8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-RmU7dpNTMOaCa8_IAQwJfA-1; Mon, 15 Jun 2026 06:12:29 -0400
X-MC-Unique: RmU7dpNTMOaCa8_IAQwJfA-1
X-Mimecast-MFC-AGG-ID: RmU7dpNTMOaCa8_IAQwJfA_1781518348
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef66cc579so1476965f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 03:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781518348; x=1782123148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5KDtylEulH4nzlQDklazM4BcDULe+/NGudq0xGCiOA=;
        b=JCMYRXMsvY5kIgnB2LZi6LJT9IA9Kl4j0zkP+mHv/+AwBRg4xi3EjW0KOhJj2qs0MZ
         E5iC3W8rsEXW4AOWtGq2M8K4hkGZFQerBCSVgkZPX5dGaS/tu/alaJf2Cz+Y5EbmTLZ7
         poCy/ZvU9a4EvE7cwkUF36O+YNNlOH9OCLtS9SvnB8psH1WsmEDWRhnoxUEGWNWgBqse
         NwSQMLwYUBE+9CAoaUDyv5E7diyGPij/eOYVRfT7v7elBKi0bCeTm0ArO6290tvB/M9f
         Adr0we3iSywSZG5u2PeV5q8VpV06wGoeFcmemCMjaExYyhk+ky11OPZWcIfhigxGdaf+
         fDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RW6ZhHQsEF+JkasbduPkUTsC1ktBjCWnDpxIjUFNkV5PBNwxvMnJ64x80ydi+Wqxsc9see7t/pFDhKtubk+A3ru8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuv4ugijdH1051lBCDsOkLHKSxHNknajiU3phk/yDOkGTJ5vxq
	MXLRapzKPPo+Hn3v9ITPwU0wLZMNS18JMScgtMsTF0KH7sQJplqa71Ct/SqFn7CwlOsxZdBkOaR
	rFL0zdvU+LyKJrkmtUJA7TPbeQIZYuSsOC/2wkc9rcHvrV1IRMss182soLrxsZOrYHd1YIpMUnA
	==
X-Gm-Gg: Acq92OG3+wLSaTq+duBPYAibsZJLa0aG71oP1WvO3wotylH/icawjdRYbGx2LG7hdRW
	LOuKUD+2AytIvKXpinjYOlgv8qjuc6opNeZvy9G2ksv/9JKM2bhyII5pB5HzIeukHzZnar5isYE
	rgt8/+rZfZZOjHwdC85SmFHoXyZ/oN2G+ocmJ5rrw0LbooCkNYOuAL/mkXDWgedw0w9qn+7bMgA
	mLEFz727FtfZyE6sVCkbof3s+AxvBKb316R39ivGxngrvc1MuMEXpcGNK1LcboWGGvKoLqxazKu
	DZHsE66Lkpw7rr/5o/HTXNGwbXa1HqWjJzmnjvdpHedOXJ+oMtds44CwyLH9euQ7bvH8/q9fPcX
	Xyae4HsHVvgNmZSZ9+SVkAV6Mhg==
X-Received: by 2002:a05:6000:41fe:b0:460:67b7:54f1 with SMTP id ffacd0b85a97d-4606dbbcc38mr19632469f8f.42.1781518347877;
        Mon, 15 Jun 2026 03:12:27 -0700 (PDT)
X-Received: by 2002:a05:6000:41fe:b0:460:67b7:54f1 with SMTP id ffacd0b85a97d-4606dbbcc38mr19632415f8f.42.1781518347348;
        Mon, 15 Jun 2026 03:12:27 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm31425885f8f.33.2026.06.15.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:12:26 -0700 (PDT)
Message-ID: <4442008c90e6957d9d6916a3b30afd1401b2f760.camel@redhat.com>
Subject: Re: [PATCH v3 4/9] rv/ha: fix ha_invariant_passed_ns silent bypass
 of invariant check
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 12:12:26 +0200
In-Reply-To: <812b7b8e8979b4ab00ac7727e3fea578799f2a8b.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <812b7b8e8979b4ab00ac7727e3fea578799f2a8b.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l9XH99Agw9Izd1fDrP75siG2tjdCyMongo6cSWM7C04_1781518348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> The function is documented as "prepare the invariant and return the
> time
> since reset", but on the first call (env_store =3D=3D U64_MAX) it exits
> early without calling ha_set_invariant_ns():
>=20
> =C2=A0 if (ha_monitor_env_invalid(ha_mon, env))=C2=A0 /* env_store =3D=3D=
 U64_MAX
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0 /* ha_set_invariant_=
ns skipped, env_store stays
> U64_MAX */
> =C2=A0 ...
> =C2=A0 ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
>=20
> This leaves env_store =3D=3D U64_MAX, so ha_check_invariant_ns() always
> passes on the first activation regardless of elapsed time:
>=20
> =C2=A0 return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns;=C2=A0 /* U6=
4_MAX >=3D
> any */
>=20
> Fix: establish the guard before converting to the invariant:
>=20
> =C2=A0 if (ha_monitor_env_invalid(ha_mon, env))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_reset_clk_ns(ha_mon, env, time_ns); /* =
guard: env_store =3D
> time_ns */
> =C2=A0 passed =3D ha_get_env(ha_mon, env, time_ns);
> =C2=A0 ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* invariant: env_store =3D t=
ime_ns +
> expire */
>=20
> Apply the same fix to ha_invariant_passed_jiffy().
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

This is neat and probably works just fine in your case. Anyway I'm
planning on a more seamless solution not involving invalid states at
all. Initialisation would include a reset, which should work better on
monitors doing da_handle_start(), so not running the first event.
That's, by the way, pretty much what you wanted by doing reset() on the
(virtual) init transition.

We first needs Nam's simplification though [1]. We can synchronise
during this development cycle, you probably won't really need to bother
for now.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/08188c28f274da63a3f8549add3086a92aef45e5.17809=
08661.git.namcao@linutronix.de

> ---
> =C2=A0include/rv/ha_monitor.h | 17 +++++++++++++----
> =C2=A01 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 28d3c74cabfc..e5860900a337 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -365,16 +365,22 @@ static inline bool ha_check_invariant_ns(struct
> ha_monitor *ha_mon,
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_ns - prepare the invariant and return the
> time since reset
> + *
> + * If the env has not been initialised yet (first entry into a state
> with an
> + * invariant), anchor the guard clock at the current time so that
> the full
> + * budget is available from this point.=C2=A0 This preserves the
> documented
> + * guard=E2=86=92invariant ordering: ha_set_invariant_ns() is always
> preceded by a
> + * valid guard representation in env_store.
> =C2=A0 */
> =C2=A0static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon,
> enum envs env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> +=09u64 passed;
> =C2=A0
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> -=09=09return 0;
> +=09=09ha_reset_clk_ns(ha_mon, env, time_ns);
> =C2=A0=09passed =3D ha_get_env(ha_mon, env, time_ns);
> =C2=A0=09ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
> =C2=A0=09return passed;
> @@ -404,16 +410,19 @@ static inline bool
> ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_jiffy - prepare the invariant and return the
> time since reset
> + *
> + * Same first-use semantics as ha_invariant_passed_ns(): anchor the
> guard clock
> + * now if the env has not been initialised.
> =C2=A0 */
> =C2=A0static inline u64 ha_invariant_passed_jiffy(struct ha_monitor
> *ha_mon, enum envs env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> +=09u64 passed;
> =C2=A0
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> -=09=09return 0;
> +=09=09ha_reset_clk_jiffy(ha_mon, env);
> =C2=A0=09passed =3D ha_get_env(ha_mon, env, time_ns);
> =C2=A0=09ha_set_invariant_jiffy(ha_mon, env, expire - passed);
> =C2=A0=09return passed;

