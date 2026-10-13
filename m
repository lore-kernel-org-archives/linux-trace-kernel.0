Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C04F5E0B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894539; cv=none; b=DZlimBZ/GEjrHTIkTQpX6oUfozh2Swwb9YPjQvPrvuK0C5jaUooT8dztqamL6PmxBOUVHOvzt4eIKrHCKiu1goE4+yefHD8NjHFs6zT2oeCtMNtcBRYlX1qqxOi91j6jZllr8ScGxfdDOhFVO2Ofr2kdo4CHLt/6EacOluj9p4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894539; c=relaxed/simple;
	bh=eATuFUSIwV+3V0ZrsqfWU6U5J8CxIuWKDFXccmtQJz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAHC5zr/kLOlqi2jm2TagK7dhnmHMC3938VxhbQpfXWsqHSEgHXdLzQPzVxD5on7pbIcESLdOPbwuB5fEJwZPv7wYzkXK9pfsACci9ulAiNu8hxmBfdie38Pgo4MMA+YEGD7e0BsRWQeNgTeo6mk+SU6D9UCQAKkIgeRh3KXLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coNKTV5a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coNKTV5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eATuFUSIwV+3V0ZrsqfWU6U5J8CxIuWKDFXccmtQJz4=;
	b=coNKTV5aTH4grL2IUg0fdI2n393eEAq71ScGkI6UVi++DeVa4O4CGegZk2ZegZu//ieL9b
	ZNgFStc/zhMkOgjI5RgyG5hO1HOkcuObNs44Lh/3JuCdJzrFyVpK0OXjOrLuwvDnh4iXmP
	IA/3uSBdaJO/UzJgX3mx/jwKzI8Qjt0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-W-JjFjJQMPS1UW-0ZhOBqg-1; Tue, 13 Oct 2026 12:28:55 +0000
X-MC-Unique: W-JjFjJQMPS1UW-0ZhOBqg-1
X-Mimecast-MFC-AGG-ID: W-JjFjJQMPS1UW-0ZhOBqg_1791894534
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso34226085e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 05:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894534; x=1792499334;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cw0AdI14fFbB4gyvTD22R11FTQDGMXNOHMIi+cFmxmY=;
        b=Ku3T6E57f325+s35aEg/J9eKaxcLa8aspEpW5ld3tEIE3oEUWRX+YG4k61g6wbL9pJ
         kQRe6XFUJ19Jn8TGPukDtFEav4FKwoVq/bD8IT83ypl/0Xa2e9jgcvaDVHND9BNyhR0K
         CbC0wZKfnp0jVA1HTBV4GFxpcC29gh1fYM+ZTUAV4bzVVdVLycQXhlOXqHvHbysck0/V
         Sa57qOZ8dichzKL1RFx+A6ilMtYRkzK+tCzgE9SsPRZMZVrt/E+H0BkQo21n7br1rEtn
         gJiiQH/92MprlL2EBAFhcYY8jn/IwuKY/zcLTNtos9ln24MtKJDTEb8a2aCZE9ARPm+B
         88wQ==
X-Gm-Message-State: AFq9FYKPm6lHYs0Y9CIs7tWj9J1qfM5zOzt52EZL8xKkaXAkChnbN5NJ
	RxBWKHUFBOI4PgcLY64johY44gnctpt6kCCopZGEzcgmK996CkcVq0l3zR1HocPy/OHG3WcDqAv
	2COR4zjRjaMVwLrucorMFF49ZPTYWjqsejiml7+0YZZwfF/LAkSmVKqci4ANIxMsU0fWwRMrb8w
	==
X-Gm-Gg: AYBFou20NGmVTJEemWbLrlo7VcNmtEt3A7LNao9/bgAifVXO8bsgs6eyYOlGLgyKxpT
	z8e8RgIInT4dMOTH2A0klTF3jAp0rNDBaheZQp74kgrJ/wCgiSd+Wza5/Ny/IhfufF5pI1fGTqz
	HaksfJI5tRSzDHTr8oMWHoMSi0bwd/Van4ZolNWPbD7yMOBrBaFB/2p8G4VZm3i0Q82EHvSx2IZ
	QYmAjwdNgqpB83usYOBWKIIxsUJV8/eVyKIiKbdmoiFFqfTUaHu1EK7kHQMD6qcAv6iHtfzFKD5
	BVIEjgd3XmiaPE1q7qFqwNnDH8cbX8lWL2tTaB5bPPM2jb2rXjdk8X3draGPWmjrznf7ouHu2WI
	D7WwlIRdWaaFrDzkZcTFQgfD12kbb
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18e4c05e5mr250446635e9.19.1791894534019;
        Tue, 13 Oct 2026 05:28:54 -0700 (PDT)
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18e4c05e5mr250446075e9.19.1791894533515;
        Tue, 13 Oct 2026 05:28:53 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195b300f5sm136781275e9.1.2026.10.13.05.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:28:49 -0700 (PDT)
Message-ID: <78291e0f91f64bbb43da80ccd9201a237ca2d468.camel@redhat.com>
Subject: Re: [PATCH] verification/rvgen: reject ambiguous state/event
 transitions
From: Gabriele Monaco <gmonaco@redhat.com>
To: heath@mathgraph.org, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 14:28:44 +0200
In-Reply-To: <0201537cbcba3268512d2c3f6a0b51c9@mathgraph.org>
References: <0201537cbcba3268512d2c3f6a0b51c9@mathgraph.org>
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
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iRsRPzjhGh6eavgpSM6xqbd73-mY5BZK2sJEIOemmTc_1791894534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heath,

thanks for your contribution! Looks good to me.
I have a couple of minor nits.

On Fri, 2026-10-09 at 16:17 -0400, heath@mathgraph.org wrote:
> The rvgen generator builds a transition function indexed by source state
> and event. If a DOT specification contains different destinations for
> one key, the generator silently chooses one. Parsed transitions are
> set-derived, so the choice can vary across Python hash seeds for an
> unchanged specification.
>=20
> Reject duplicate (state, event) keys after sorting the parsed=20
> transitions,
> before synthesizing a monitor. This uses constant auxiliary memory and
> does not depend on the INVALID_STATE sentinel. Both deterministic and
> hybrid monitors require a unique destination for each state/event pair.
>=20



> Add deterministic and hybrid negative fixtures. On the pinned Linux=20
> tree, the original rvgen suite passes 30/30 tests and the patched suite p=
asses
> 32/32; both malformed specifications are rejected across 64 seeded
> processes. Fifteen existing models retain identical transition matrices.
>=20
> Evidence:=20
> https://github.com/metalogiclabs/mathgraph/actions/runs/37983741146

I'm not sure this statement above adds much value and the evidence is good =
but I
wouldn't include it in the commit message. If you want to add more details =
to a
single patch (without a cover letter), you can append them right after the =
---
so they don't get included in the git history.

>=20
> OpenAI GPT-6 assisted in identifying the issue, producing and refining
> the code and tests, and drafting this submission. I reviewed the patch
> and accept responsibility for the contribution.
>=20
> Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to=20
> Lark")
> Assisted-by: LLM
> Signed-off-by: Heath Sanchez <heath@mathgraph.org>
> ---
> diff --git a/tools/verification/rvgen/rvgen/automata.py=20
> b/tools/verification/rvgen/rvgen/automata.py
> index fd37ce3..1f9a56a 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -418,6 +418,13 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transitions.append(Transition(src, dst, even=
t, reset,=20
> rule))
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transitions.sort(k=
ey=3Dlambda t : (t.src, t.event))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 previous_key =3D None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for transition in transitions=
:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key =
=3D (transition.src, transition.event)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ke=
y =3D=3D previous_key:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raise AutomataError(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f"Duplicate transition for event=
 {transition.event}=20
> in state {transition.src}")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 previ=
ous_key =3D key
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return transitions
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def __parse_states(self):
> diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t=20
> b/tools/verification/rvgen/tests/rvgen_monitor.t
> index 5f25626..6209c00 100644
> --- a/tools/verification/rvgen/tests/rvgen_monitor.t
> +++ b/tools/verification/rvgen/tests/rvgen_monitor.t
> @@ -84,4 +84,14 @@ check "invalid ltl file syntax" \
> =C2=A0=C2=A0=09"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t =
per_task" 1
> \
> =C2=A0=C2=A0=09"No terminal matches 'i'" "Traceback (most recent call las=
t)"
>=20
> +# Only one transition per source state/event is representable in=20
> rvgen's
> +# generated table, even if one of the transitions has a hybrid guard.
> +check "reject conflicting deterministic automaton transitions" \
> +=09"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot -t=
=20
> per_cpu" 1 \
> +=09"Duplicate transition for event event_2 in state state_a" "Traceback"
> +

Here you may want to use "Traceback (most recent call last)" for the negati=
ve
match: more consistent and robust.

> +check "reject conflicting guarded hybrid transitions" \
> +=09"$RVGEN monitor -c ha -s tests/specs/test_nondeterministic_ha.dot -t=
=20
> per_task" 1 \
> +=09"Duplicate transition for event event2 in state S2" "Traceback"
> +

The code for DA and HA is shared, I'm not sure we really need both test cas=
es.
I'd keep only the DA, we're already not testing every single error conditio=
n and
the test is starting to take longer and longer.
What do you think?

Thanks,
Gabriele


> =C2=A0 test_end
> diff --git=20
> a/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot=20
> b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
> new file mode 100644
> index 0000000..1b63b5d
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
> @@ -0,0 +1,16 @@
> +digraph state_automaton {
> +=09{node [shape =3D circle] "state_b"};
> +=09{node [shape =3D plaintext, style=3Dinvis, label=3D""] "__init_state_=
a"};
> +=09{node [shape =3D doublecircle] "state_a"};
> +=09{node [shape =3D circle] "state_a"};
> +=09"__init_state_a" -> "state_a";
> +=09"state_a" [label =3D "state_a"];
> +=09"state_a" -> "state_a" [ label =3D "event_2" ];
> +=09"state_a" -> "state_b" [ label =3D "event_2" ];
> +=09"state_b" [label =3D "state_b"];
> +=09"state_b" -> "state_a" [ label =3D "event_2" ];
> +=09{ rank =3D min ;
> +=09=09"__init_state_a";
> +=09=09"state_a";
> +=09}
> +}
> diff --git=20
> a/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot=20
> b/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot
> new file mode 100644
> index 0000000..d21b91b
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/specs/test_nondeterministic_ha.dot
> @@ -0,0 +1,27 @@
> +digraph state_automaton {
> +=09center =3D true;
> +=09size =3D "7,11";
> +=09{node [shape =3D circle] "S1"};
> +=09{node [shape =3D plaintext, style=3Dinvis, label=3D""] "__init_S0"};
> +=09{node [shape =3D doublecircle] "S0"};
> +=09{node [shape =3D circle] "S0"};
> +=09{node [shape =3D circle] "S2"};
> +=09{node [shape =3D circle] "S3"};
> +=09"__init_S0" -> "S0";
> +=09"S0" [label =3D "S0\nclk < bar_ns()", color =3D green3];
> +=09"S1" [label =3D "S1"];
> +=09"S2" [label =3D "S2\nclk < BAR_NS()"];
> +=09"S3" [label =3D "S3"];
> +=09"S1" -> "S0" [ label =3D "event0;reset(clk)" ];
> +=09"S0" -> "S1" [ label =3D "event1;reset(clk)" ];
> +=09"S0" -> "S0" [ label =3D "event0;reset(clk)" ];
> +=09"S1" -> "S2" [ label =3D "event2;env1 =3D=3D 0;reset(clk)" ];
> +=09"S2" -> "S3" [ label =3D "event2" ];
> +=09"S2" -> "S2" [ label =3D "event2;clk < foo_ns" ];
> +=09"S3" -> "S0" [ label =3D "event0;clk < FOO_NS && env2 =3D=3D 0" ];
> +=09"S3" -> "S1" [ label =3D "event1;clk < 5us && env1 =3D=3D 1;reset(clk=
)" ];
> +=09{ rank =3D min ;
> +=09=09"__init_S0";
> +=09=09"S0";
> +=09}
> +}

