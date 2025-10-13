Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD32F7459
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344417; cv=none; b=apVl4vxZ8eoF9ed0gj4M0A6B6OIelJuVKR2xK2D23EUvW+KUHCbs6DYAuKI7QkFMNYGH5lJRSvayV62WnF2XMxjzyx/9mt4zvxI/gVQu8ajIsKMZ7H6c85SPam1i7Jr0gXcvfm0z6QZ/PrqzSVu5z1SPqW/Ci2S7e85ul2Xv0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344417; c=relaxed/simple;
	bh=Ubf7rJ2ZyPls1eD6mfBtWo+1S5slFjd2exjuLqImS4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M47/xSnQ+NkgtVpc4D8eqPfLNXGh3vITgJeRfWhpgQ6Weua+p1bq9t8/a+R4C7GZPpW1coMTtxjZnfcjU9l7ewldEAZ52KDkc3hiez5a/E83GkOoR0P9WK8VPzTnJG2r8++yK11nS7JWmXBUCKPavUVFzS//xpSB7pjUSXI+8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q561CKpG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q561CKpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760344414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ubf7rJ2ZyPls1eD6mfBtWo+1S5slFjd2exjuLqImS4s=;
	b=Q561CKpGlZLHqop0eyVMGsWidP5ZDqKGiIZ4d+4H09Xmjba4BkWlVvSQ51CcC32E/cU2/q
	sdyEAAGwEdV1trTN6omissaFGOLDVzn2H6HCHmH5jno6Y9lQcVhW0vg6P+D3j9bGuJb1X8
	0/NHpSiPRTTLFQpGL0wuJ2+MIkP8UV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-u0gjfz4ENi-udaHy7adKoQ-1; Mon, 13 Oct 2025 04:33:32 -0400
X-MC-Unique: u0gjfz4ENi-udaHy7adKoQ-1
X-Mimecast-MFC-AGG-ID: u0gjfz4ENi-udaHy7adKoQ_1760344411
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso24772555e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344411; x=1760949211;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHzqoTUxCIyvAxivdG8/KYPlObSpyBug5KjpaqaKlgI=;
        b=JYqmGNR1jpSo1i4g9+0eDRRnK8RN4+FN9sJGBGVRvWCk67qnzlZDHY7P03uqwb82Bt
         l+KoWB1ASxUVaTdDzpwV8zP5V9RJkbYOqDaYvU+NkXdzpgAWSXHLIIMRbPtOBU3y20dy
         bshtClzpW1++Z0ou124PfHF4Jz83npYbSkmlQ/Nfmd0Xoc7MielHnXJtQ07jhT3qLGnv
         hozxHbSwl3ERT0qzwLifli0qCeUubwgGBvQrdtH0TZETv8qhpN7uJDClZKie8WIoVOJb
         k4TOU/G1K41+kJGLqiUmlzPxxvrY5dBu7HI7X1FkT5Br/THRA9q7G67IPmgYcpVsC+YB
         XPgA==
X-Forwarded-Encrypted: i=1; AJvYcCVi4gMeoAPNHI1YZfxudpwEjI126k5Ri6PqPbO+QhUqHIpzkxU+lfbreVmv6bdPoO3jmKTjF/fNoW4o4l7VSWyRnN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+iozEh6M28EGVM89cp46wS01gZ45K0bwf9ylHjT1jnEbocY8
	Xu5j4XHvFGUHPD8a5TE3wWQPQ5Ducp/T57hJsj1IgIMPAqKzEPY9vKIGNj7Jt3mikWMzsG7XrQi
	sI6S3WbkzcdwcyI38FdxkHLu9jcOtSkWl3GyD3mJxQovAEEE2R/MsQXWMjau2ZPeNA1+Tp9dlCg
	==
X-Gm-Gg: ASbGnctAd/vPnWd4dJL9I44gFmZ23+3nMv1YQikGMB1hIoH2tA95xSDrFZXMWZVVoIY
	8c38vkSDvhQWpznOhEH6LYVenSNMN1KrEdUG4P3j+ZrejXEBocNpDS7lnTGAztm67qSEXmbyqF2
	nBgQLj2NQ9e7WYthqjvLVtc7DxUiDcCgtbxQ0EqhXK2MYQ7dZpxwYTTyXuzaA/Jmadl/mgZbMhZ
	Qwdq1oUo+FuYvdklqlThl1nXunIhl2ajQkgnLYfhOcGadLuWR8yWb1f5rwdaw9vlxdvyaF3+K6f
	CgOa/LhAwWxkIoFwJg9n8d3xVqcRUjFGcqBf2+ZQWiMiFhk+BhY16T0pNmU4XRdQTw==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-46fb42ee3camr82409135e9.41.1760344411403;
        Mon, 13 Oct 2025 01:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7PWpqFZ4D/w/JzkBafScgM+dm2uU2KKBj/FjHvRp7y+l21OlHRHMm58CWEcdN4EUMsrfFXg==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-46fb42ee3camr82408935e9.41.1760344410948;
        Mon, 13 Oct 2025 01:33:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm17203089f8f.49.2025.10.13.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:33:30 -0700 (PDT)
Message-ID: <041c01207d23e6f9a02702428da6f528ce66599b.camel@redhat.com>
Subject: Re: [PATCH v2 13/20] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 13 Oct 2025 10:33:29 +0200
In-Reply-To: <87jz12yimw.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-14-gmonaco@redhat.com> <87jz12yimw.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: QsXtRqdudRl3hnmbwg0keN0068gtnPzFpIoFf4wrhuI_1760344411
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 15:46 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Describe theory and implementation of hybrid automata in the dedicated
> > page hybrid_automata.rst
> > Include a section on how to integrate a hybrid automaton in
> > monitor_synthesis.rst
> > Also remove a hanging $ in deterministic_automata.rst
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> This brings back bad memories from university..

:')

> > +It is important to note that any valid hybrid automaton is a valid
> > +deterministic automaton
>=20
> Perhaps remove the double "valid". Usually people use the phrase "any
> valid A is a valid B" to say that B is a superset of A, but it is
> opposite here.

Alright, will do.

> > +This is a combination of both iterations of the stall example::
> > +
> > +=C2=A0 /* enum representation of X (set of states) to be used as index=
 */
> > +=C2=A0 enum states {
> > +=09dequeued =3D 0,
>=20
> I think you already removed this " =3D 0" in an earlier patch?

Right, missed that.

> > +=09/* Validate invariants in i */
> > +=C2=A0=C2=A0=C2=A0 if (next_state =3D=3D curr_state || !res)
> =C2=A0=C2=A0 ^^^^
> =C2=A0=C2=A0 indentation error ;)

Good catch.

> > +Due to the complex nature of environment variables, the user needs to
> > provide
> > +functions to get and reset environment variables, although we provide =
some
> > +helpers for common types (e.g. clocks with ns or jiffy granularity).
>=20
> Is there theoretical reason that functions to get/set variables cannot
> be generated? Or you just do not have time for it yet?

Not theoretical but practical, the monitor cannot always define /what/ an
environment variable is. In case of clocks (jiffy and ns) that's easy and t=
he
parser does in fact generate get and reset functions, the user only needs t=
o
specify the measure unit as explained somewhere else.

It is possible to add more exotic variables that don't follow common clock =
rules
and need different get/reset definitions. Now, in practice, that may not ha=
ppen
with clocks (I cannot think of an alternative clock definition), but can ha=
ppen
for other variables. For instance if the variable describes the preempt cou=
nt,
the model cannot know in advance and the user will need to supply how to re=
ad
that in the kernel (just like we do with tracepoints, although event names
/might/ hint something).

As I get it, this isn't so clear so I should probably try and reword it.

I might just assume variables without unit but with a reset are, say, jiffy
clocks and never expect manual definition of the reset function, but that m=
ight
be misleading at times: e.g. if a user wants a ns clock but forgets the uni=
t,
the monitor would still build.

>=20
> > +Since invariants are only defined as clock expirations (e.g. *clk <
> > +threshold*), the callback for timers armed when entering the state is =
in
> > fact a
> > +failure in the model and triggers a reaction. Leaving the state stops =
the
> > timer
> > +and checks for its expiration, in case the callback was late.
>=20
> "callback for timers armed when entering the state is in fact a failure
> in the model and triggers a reaction." - I have problem parsing this
> sentence. How can "callback for timers" be armed? Or do you mean arming
> timers while entering a state is a failure in the model? What is it a fai=
lure?

Right, that sentence doesn't make sense.
We arm a timer when entering the state, expiration of such timer is a failu=
re.
The timer is cancelled when leaving the state, so in fact leaving the state
before the timer expiration is the only valid behaviour.

> > +It is important to note that timers introduce overhead, if the monitor=
 has
> > +several instances (e.g. all tasks) this can become an issue.
> > +If the monitor is guaranteed to *eventually* leave the state and the
> > incurred
> > +delay to wait for the next event is acceptable, guards can be use to l=
ower
> > the
> > +monitor's overhead.
>=20
> How about having some sort of a "background task" which periodically
> verifies the invariants?

I didn't update this part, but now timers can work also via timer wheel, wh=
ich
is cutting down costs by sacrificing some reactivity (not correctness thoug=
h). I
assume the background thread would be quite similar to what the timer wheel
already does.

But I definitely need to mention this because the timer wheel is not as hea=
vy as
the hrtimers and its overhead is usually acceptable (unless proven otherwis=
e for
a specific monitor/workload, I'd say).

> > +This is the full example of the last version of the 'stall' model in D=
OT::
> > +
> > +=C2=A0 digraph state_automaton {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {node [shape =3D circle] "enqueued"};
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {node [shape =3D plaintext, style=3Dinv=
is, label=3D""] "__init_dequeued"};
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {node [shape =3D doublecircle] "dequeue=
d"};
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {node [shape =3D circle] "running"};
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "__init_dequeued" -> "dequeued";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "enqueued" [label =3D "enqueued\nclk < =
threshold_jiffies"];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "running" [label =3D "running"];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dequeued" [label =3D "dequeued"];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "enqueued" -> "running" [ label =3D "sw=
itch_in" ];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "running" -> "dequeued" [ label =3D "de=
queue" ];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dequeued" -> "enqueued" [ label =3D "e=
nqueue;reset(clk)" ];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { rank =3D min ;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "__init_dequeue=
d";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dequeued";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Btw, the last block (rank =3D min) doesn't seem to serve any purpose. But
> the last time I checked months ago, the parser explodes if it is
> removed, not sure if it still does now. But this is another reason that
> I would like a rewrite.

Mmh, that's automatically generated by Supremica and, I believe, in some mo=
dels
it's tuning a bit the position of nodes. Quite strange that the parser expl=
oded,
those lines should be completely ignored.. Still, we know the parser needs =
this
big refactor.

Thanks,
Gabriele

