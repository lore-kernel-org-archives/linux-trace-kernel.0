Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53312749FB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650499; cv=none; b=Vllu8ISi2nMWFg4JarbxxcMh404nr2Q9FcUHpya+0/5491dI+HVTT8w1vICdnF1uuddTgdRUZf7YOUPBDMqUhi7RaVbWqWXOoM79g5HUvNYrIhknwmksBjuz1kGYy3LWuMVWiuDKxGKAJURTe1N/oe+zzBHE9IiodCPuCfebGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650499; c=relaxed/simple;
	bh=aiLd1Prbx6RVlANLkdEsy51H4ZcT2wtliSG29JDWti0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV5oMPipldFZoM1a5da9XqaZ0Ph60bCkLh90iH3b7X1AMyQiVGD6K7HWhjTFl+PTBrigvdb6rAIM6y3wVZDSN1x4rh1O7v29TIu2mcLJQrZlmibegMhLgEboWDqyc0kUSBNnSV0Mci82yX4hlgMxAPTpejwuzixAKzbBN+RiZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGEsM0IM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGEsM0IM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747650496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aiLd1Prbx6RVlANLkdEsy51H4ZcT2wtliSG29JDWti0=;
	b=RGEsM0IM9IcABt5dk5KCGAWPTMXZOpc34aJRoznWR/S4vfQW7UbCTAaR/JIliDlftYKHZD
	g/Uk+7W/tYJK3+gA7o4QemkY/sa4DenCcFj8oq5rs7XGpvCxGxPM2aDPDPGQfj9pLazJc7
	YV9bgg94OWNlX6Qy1UEyS21hT0V17Lc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qVioC3uyN2-KmAh1ZaO0yw-1; Mon, 19 May 2025 06:28:15 -0400
X-MC-Unique: qVioC3uyN2-KmAh1ZaO0yw-1
X-Mimecast-MFC-AGG-ID: qVioC3uyN2-KmAh1ZaO0yw_1747650494
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso34110685e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 03:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650494; x=1748255294;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XPurQ6z4VsgTQPK3kgi30mDqS6+qhr1GgY7wHAfY/c=;
        b=ty6UHkxIgGjMCZ+/l3LKvLejNx40OcwkZuGs5prBpjTf+8GF+mucQm4vMYp8IPSvDj
         TsmE95RzJxwD6pzDv/2K5Po30gbNs/zYPBTFvnlDBd/heR0Gb5DzXTj0F7X0K+zhm/JQ
         9Rm/1OO6b8ZA69ONypVkquDzz1oyd1WnqqBS/rSnORUKVcZmEzPmdP3WvQ21p+XtTi6c
         xhhMVWFium5eus62T2aEtZpWrkQ1Kmz9BDoCA8m9QPJB1dQA8h8QoAUYj6wA/oY9fpSF
         R9kqXeOGKUyo0qCKmZ1ILF3yjkep2IkXCq2QPy+pNEH24MyZCFsbTc2AzfXdPu65vFAV
         yHwg==
X-Forwarded-Encrypted: i=1; AJvYcCXu3jN/1SiL146K92Y4HpncNYxyYUiJS4OrtnoEuzNmKjpspRuGbSt03v7eaf28qkRfKoDvdbytzdJiXh0xqTsWMZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CfhnhZgUaJg1aHVRFT/788nZ7TdWeeZoK4mEbqAhTPfoUu5R
	oJfSloz9QlSf/lbNpclm9UlUaIUOyT/LyV9W7lzWZoXXQjZEEH78MCbTctETlNyJzbDP+BJsviK
	Zyco5bfc4FbGPpN4x4J4KtPwWPZFKpaOvim2szn08UlkxtNlgA7sYPD8MOZZFkyi2bWBCuWJ9cw
	==
X-Gm-Gg: ASbGnctUFt+0zqrKeZ4oyVWCtJxxKqgpWQSO2i+FvPILIVGAszkZSpw5sd3PkupaXiv
	sT6EPu77kkbSW8U/f39kD+MA9+lJ9AreXuI0wAcz8SJ2R8Mu7Kn8L+otd8F33wKuup/K3GYcj6Q
	rdJj65sjJIr3qAMEF7y3n/mp85JlAmVOvcyg0Okqlfzg4sNYu+4Stoz+avliWUrn0iiOQbbSQLG
	5xTTyajuSu2varcX1qm+KvLlvpMzq70TNTc4p/VW2v15aDI4o+y/j+dxAR9pIrQcdQkbprWh1Q7
	H723MvlSqOGl8BO2XM4Sy94xJNuis1kStHPuSA==
X-Received: by 2002:a05:600c:a00b:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-442fd6313d2mr130831175e9.17.1747650494211;
        Mon, 19 May 2025 03:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmerFbIYeUlpq4trqMuAPoGFQ564+5/ovpfNjLErAG+OVI2RQw++iJWr2ZOv2hJcOHiNj30A==
X-Received: by 2002:a05:600c:a00b:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-442fd6313d2mr130830905e9.17.1747650493866;
        Mon, 19 May 2025 03:28:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8c7sm202303115e9.38.2025.05.19.03.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:28:13 -0700 (PDT)
Message-ID: <5f1365f2cd84597fd3547544fcceab5c79682624.camel@redhat.com>
Subject: Re: [RFC PATCH v2 10/12] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>
Date: Mon, 19 May 2025 12:28:12 +0200
In-Reply-To: <20250519090626.zjiYgUGW@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-11-gmonaco@redhat.com>
	 <20250519090626.zjiYgUGW@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r6MXaS9txw1HOd_UhnoYKVdyjFGm26OPJaSmcLUSBB0_1747650494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-05-19 at 11:06 +0200, Nam Cao wrote:
> On Wed, May 14, 2025 at 10:43:12AM +0200, Gabriele Monaco wrote:
> > -static inline
> > void=09=09=09=09=09=09=09=09=09=09\
> > -da_monitor_set_state_##name(struct da_monitor *da_mon, enum
> > states_##name state)=09=09\
> > +static inline
> > bool=09=09=09=09=09=09=09=09=09=09\
> > +da_monitor_set_state_##name(struct da_monitor *da_mon, enum
> > states_##name prev_state,=09=09\
> > +=09=09=09=C2=A0=C2=A0=C2=A0 enum states_##name
> > state)=09=09=09=09=09=09\
> > =C2=A0{=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > -=09da_mon->curr_state =3D
> > state;=09=09=09=09=09=09=09=09\
> > +=09return try_cmpxchg(&da_mon->curr_state, &prev_state,
> > state);=09=09=09=09\
> > =C2=A0}=09=09=09=09=09=09=09=09
> > =09=09=09=09\
>=20
> This is a very thin wrapper. Should we just call try_cmpxchg()
> directly?

Mmh, right, at this point the wrapper does nothing but making the code
more obscure, will do.

>=20
> > =C2=A0static inline
> > bool=09=09=09=09=09=09=09=09=09=09\
> > =C2=A0da_event_##name(struct da_monitor *da_mon, enum events_##name
> > event)=09=09=09=09\
> > =C2=A0{=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > -=09type curr_state =3D
> > da_monitor_curr_state_##name(da_mon);=09=09=09=09=09\
> > -=09type next_state =3D model_get_next_state_##name(curr_state,
> > event);=09=09=09\
> > +=09bool
> > changed;=09=09=09=09=09=09=09=09=09=09\
> > +=09type curr_state,
> > next_state;=09=09=09=09=09=09=09=09\
> > =C2=A0=09=09=09=09=09=09=09=09
> > =09=09=09=09\
> > -=09if (next_state !=3D INVALID_STATE)
> > {=09=09=09=09=09=09=09\
> > -=09=09da_monitor_set_state_##name(da_mon,
> > next_state);=09=09=09=09\
> > +=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> > {=09=09=09=09=09\
> > +=09=09curr_state =3D
> > da_monitor_curr_state_##name(da_mon);=09=09=09=09\
>=20
> For the follow-up iterations (i > 0), it is not necessary to read
> curr_state again here, we already have its value from try_cmpxchg()
> below.

Yeah good point.

>=20
> Also, thinking about memory barrier hurts my main, but I'm not
> entirely
> sure if reading curr_state without memory barrier here is okay.
>=20

I guess we are on the same boat here. I couldn't really understand how
much of a barrier is the try_cmpxchg imposing (if any), but didn't see
any noticeable difference adding an explicit smp write barrier to pair
with the READ_ONCE in da_monitor_curr_state, so straight assumed we can
do without it.
But I definitely appreciate opinions on this.

> How about something like below?
>=20
> curr_state =3D da_monitor_curr_state_##name(da_mon);
> for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> =09next_state =3D model_get_next_state_##name(curr_state, event);
> =09if (next_state =3D=3D INVALID_STATE)
> =09=09break;
> =09if (try_cmpxchg(&da_mon->curr_state, &curr_state,
> next_state))
> =09=09break;
> }
>=20

Yeah, that's neater.

> Furthermore, it is possible to replace for(...) with while (1)? I
> don't
> think we can have a live lock, because if we fail to do
> try_cmpxchg(),
> the "other guy" surely succeed.
>=20

Mmh, although definitely unlikely, I'm thinking of a case in which the
event starts on one CPU and at the same time we see events in IRQ and=20
on another CPU, let's say continuously. Nothing forbids that between
any two consecutive try_cmpxchg another CPU/context changes the next
state (making the local try_cmpxchg fail).
In practice I've never seen it going on the second iteration, as the
critical section is really tiny, but I'm not sure we can guarantee this
never happens.
Or am I missing something?

Thanks,
Gabriele

