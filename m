Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7F3328EE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714544; cv=none; b=DjdFaHvQU080a9VQFiJbKyfBwg1S2aHT7D65swSYydFlnKiKre37PVXpL7kOU6/mjLIiySsicSU59XZ/XROKMja+H6EMVTJv9BJMQFDzISNxMbgoG2ZnbsiuNM/O5eKRObrpebQ+/bxwvC+LBuDfW1FqkiIrPMjou4eugJo1eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714544; c=relaxed/simple;
	bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrOeaBnqV8ImeOS/4Cj7RRwBwUUYmiL4ZMcztbCDqlDgjI3oKi1rEzKSHVRFUVYKw+XFf2v9ExBJsji62OrAiD6gBw5APQ92h94Fvg/FD2P4jWePu3vumCiRC2ijdVM/Gh0CKVv72Y7g8l3U6xi5G44/Mh5DxGSZQjemjVr+L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0c8i9Fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0c8i9Fw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760714541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
	b=S0c8i9FwQtbOGVjIR9TALJ0+923V4PTIPgJ4zsXE71W+Jxx3yr5jzwSYWrPmQdWDzsYeD/
	OsaFtz8+4mUS8SDtXuQR55KE/Ws5/LlAzkGq4by75E2SrEfxRDFZjV0rLqOap1Owh4UfTE
	AFTRDS4FlVRthufysuv/ZGA9sgeUPy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-zLSm7V-qNe-CbqJbcWRUhg-1; Fri, 17 Oct 2025 11:22:18 -0400
X-MC-Unique: zLSm7V-qNe-CbqJbcWRUhg-1
X-Mimecast-MFC-AGG-ID: zLSm7V-qNe-CbqJbcWRUhg_1760714537
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f62a7so857477f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714537; x=1761319337;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBJgtLmvS+3GwkRQM1AZBtM9oRQ/SXhWehiVu3kfg/o=;
        b=nM9nL3eG7nuq5pw7eS1HwYZIZo3pspFQMpZw/Zq39ui1lHWkqnGP5L1RWYaKZS2OEJ
         d3lzyQRa7ufZxpsqv22Na1/WYxBa8DHx5E2assrCRVR3i1uQPsRW0S+dQ19MjYcNM/VI
         drW0hsNXKAlBpMN52C0S7YNZYd3JSq3cwkmauNxtcMTpb6/oKnX5FFcwJTDyfR2rm1eK
         wnXsUOCjPLiGGb57XzO9crJZBZ3xGCjXidH4fIbXeEtUw3sRGBCd4RZ4yoVyNXhkgXx2
         OfmCQaJ/TCooSlGNE+aum2C5rKevJEU68KVGAIk+3wcZf6j22yTIQf8uqsdjUH8BUB39
         LQqg==
X-Forwarded-Encrypted: i=1; AJvYcCWnT10tIBYh8XsjNEP8hWTYgWQPjtZlXHm1ohBUHOHEqXg57G0VXMYL2oBMw2N1BTzPwGbFD7w/++9YiUAwJlgdGM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoxodymyw77StkSbY4/P+w6GH3LWqjefEvr8qj0krdSFHlT48
	KiWjzyrOIW5e/dpHVgAbeNpZLjs8Hz41mtIvLEVaPsL4muiauq/uJqlGKWTHRxrWBmP3f3Q0f/v
	m4tWWjZa+IYTlk+pGoBlL8rLeTzfwEzZaJ5frM+xthiVXm5TFI8AKALjPvHMmDP+yXpFAbTgQ5Q
	==
X-Gm-Gg: ASbGncsa5mydfI2+XLX91W+yDZgXTrvG6FZvpqdFohToYBJfXChyXYMCJUreFvT0L7D
	JuGk9RwIMJbWlN2K4+0PmR/p/AKDjQa+hnvtCtSdTSC698i3H0Xwx14cpstUBeAkiIKoYn9PC2a
	i7J5ly3ujSU98wdXFx86En/o5+IJFBE10nITGZr+cJxh89ld5umOkAVw4I1nVX0I+JwK16dLDFt
	z16Np2+AsLhH0UhdZRmu/tq6UJoM3ppmHLXx0QwyTkUsbnAWbIGCcllFyOOLKWjT3Gkq19/yXmQ
	O31zEhH7A0G6HGN/duxuMZOwd1INr6L/47rAs39peVX8Q3rwojc77nFKkENUcg5vqpd/BGr0PZq
	dNRdZe3aNdH+cmwLcFCLP+4aF
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr3075536f8f.36.1760714536911;
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoHGID/pkuiaJ4RfGLI4OcwnA8+eh8UgRZ4XAaH/jRsagXl9UHzOOtyF00rC63dnUFcejKnw==
X-Received: by 2002:a05:6000:2c0c:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-42704d9397amr3075515f8f.36.1760714536506;
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm42747615f8f.10.2025.10.17.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:22:16 -0700 (PDT)
Message-ID: <0c61c0bbbdc2002efb638dccda1f0a18c51d29df.camel@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 17 Oct 2025 17:22:14 +0200
In-Reply-To: <87frbhwudz.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-11-gmonaco@redhat.com> <87ldl9x6h7.fsf@yellow.woof>
	 <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
	 <87frbhwudz.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G613nOWmYQPKtrVUKTQO9wI0yNGE2lhjYm26Ofzniyc_1760714537
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-17 at 15:05 +0200, Nam Cao wrote:
>=20
> Ok, now things start to make sense. Thanks for the explanation.
>=20
> At least to me, using the same variable to store different time values
> is a bit confusing.
>=20
> Is it possible that we always store the timestamp of the last clock reset=
?
>=20
> The invariant bound value (N) is fixed for each state, so we can have
> the bound value in ha_verify_invariants() instead. For example, the
> Python script can generate something like
>=20
> static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum states curr_state, enum events
> event,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum states next_state, u64 time_ns)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (curr_state =3D=3D enqueued_stall=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ha_check_invariant_jiffy(ha_mon, threshold_jiffies,
> time_ns);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> }
>=20
> Is that possible?

Alright, that /should/ be possible, provided the value used to set invarian=
ts is
constant or at least doesn't change until we leave the state.
This seems a fair assumption to make but doesn't stand for the throttle mon=
itor,
in that case I read the remaining runtime from the dl entity, that one is
updated frequently, for instance when a task is throttled, it's negative, b=
ut
this doesn't mean the invariant should expect time to be negative.

Runtime is consumed only when a task is running, so here I use an invariant=
 set
up on the /remaining/ runtime when reaching the running state, that's why a=
lso
switch_in resets the clock (runtime is not replenished, but the runtime_lef=
t
value doesn't need to be subtracted anything).

An alternative would be to have some sort of pause/resume operations on clo=
cks,
and a task would just pause the clock when preempted, but those operations =
are
not backed up by theory and wouldn't really simplify the implementation (us=
e 2
variables per clock or a single one and some hack to mark it as paused).

Again, there may be better ways, but I found this one the "simplest".

Does it makes sense or am I just crystallising to this implementation?

Thanks,
Gabriele

>=20
> > Kinda, it would solve the problem for this specific subtraction, but ra=
cing
> > handlers could still lead to problems although the subtraction is "corr=
ect".
> >=20
> > Since this is the only time the env storage needs to be an atomic_t and=
 it's
> > fairly rare (only complicated models require calling this function at a=
ll,
> > others are happy with READ_ONCE/WRITE_ONCE) I didn't want to change the
> > storage
> > implementation for some perceived safety.
> >=20
> > I wrote that comment exactly to motivate why we aren't using atomic_t, =
but I
> > should probably reword that. Does this make sense to you?
>=20
> I think if we always store the timestamp since last reset, we can get
> rid of this function. Let's see how that discussion go..
> >=20

