Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4C41DED8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137349; cv=none; b=uTZumZnA1RWIMCN2kDrvvyafb9QvbCRKTLabc4AU6iEwR4Kf6z8JDGcfPIb2Zb820D7S+hVqcNGnwq7qH0Ihvi1fSdgRp+KBJyIrHX3paUctdwZ80UEOwKHhJtPJPurpVTSFijtp1n92uyAODPu8ksm3OKHRGk3CmDDRrdfpklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137349; c=relaxed/simple;
	bh=/BqQhShWy66vr79xAchyBrmzQUGd7GLLa4H5qFDcvrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkT3MvYyuCg2V0EJmvDNf75n7dfX9Xg2xKPMg3ZJlFQbyGk354zYRVOsTKpD5SheW9DaJ1bL14COB9Yk7R3/GxMjPjwZAFQzzbbQwmJ+51eNwocuFE9sm3sbYnHFK82rO1KFtLf+RjPBEE1kOSa2rQ6f+jsuNW2vsTpFuTutBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNf4jiuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNf4jiuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792137343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/BqQhShWy66vr79xAchyBrmzQUGd7GLLa4H5qFDcvrY=;
	b=CNf4jiuTTjTPfETosXEdRsfYiZlHQLOvE4u8GcVJ5FaQc0OFLvYoYs3PZirOGRDyHAyt+6
	GyJ9+Ciml0zJpDzM4CkFzlt6Im0v6KiYQfNtlPXBmW5ZR9JNyulBQwhP0tdk4RPttVGFmG
	E09MkM54a+/7hQ4nLgf1ddwx0KfxhiE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-adcPUAhJN9uO02FN5S81lA-1; Fri, 16 Oct 2026 07:55:41 +0000
X-MC-Unique: adcPUAhJN9uO02FN5S81lA-1
X-Mimecast-MFC-AGG-ID: adcPUAhJN9uO02FN5S81lA_1792137340
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c46582442so1502910f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 00:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137340; x=1792742140;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K4A98+Ja2PbDshcI2GUMvWoRwGyHcotmF1kYvCzQUdM=;
        b=zwfYwQ0aeppZgSaduieSexCsp824DzRfLPfqjkL8g6H6GzIb6ok0cfVjnxXYKuvg0R
         Q1wGEGEa036gvE+Fuc0EglHpmx6cZRqE8QU/ap3HpchttOSmkP9rjFTGcsT78QvTbWk7
         AcuP2TRUOdBj7ol7hfFAntxsBY6P0zZPbrev5GXJCPLJx7m7MRCLjfKmm5vKLs1PSTnA
         wjdRTte62ywhVRxCnrxgAtEgQaMkAVOYXRkk6yk+KBlL9zyxcev58RLrFt3B5loyzbpT
         YZwT/G6OSPLWSrY64xWNxnPJS5h7oO+v3nfPjUAm/QsS2HfKS5hOBZcE5Fy/DYkJWnK0
         n6kA==
X-Gm-Message-State: AFq9FYJGuV88yLwv16Tnk6UxlhQ4324aPWQVxVWayJcOeaWOX7DFXOHx
	Uty7yGlzRRtmiu9XGPZXqAaWJqT5LKL/gxiLLnhF7ERW2AMAtIRaUCQHOMzH8yrVaofSyqjwJ+w
	nEZV8yeN1LwBfYJUZPJlF10Juwhqvb0doLP9pBiREgl76Wtw0tunPSEsOuhUdJwskxjSkxTP7YA
	==
X-Gm-Gg: AYBFou2TolvIIiHr3+YF8WCvGp90hKcOjqJhBXEkMsB7PR99b5BZr4wb0QVlVIRChea
	k5YMz+MoRkHbTsqcRyL7m9Ijyb3pSGxBX7fiaeW2HHZk/Km1PvMe89+XASsGHFYpGhshZjZPtBR
	8GBB9BzIJ3hmBL48EKUVvA2RZMJ6tLKd+vXxISeqc3JR4URMFt4/UkfrtzluAdtag6SCYPwMdor
	3pn49HD+410OQ86P8aimY6scMmqjjjKgUY6r0OP2GmbxePEZ6IVLVCaBh3tE4VvVyPMYEnEVfnJ
	DNAHHkzr3YJ88UMu2qvhIiPGs4NwaWBiPR88cIn+w0ens4OoRDva8oaoR1HfKTun7N6VzmZFcl0
	7KAJqJBUl91thfYRmiOGAbpRVIJkA
X-Received: by 2002:a05:600c:620f:b0:49f:dc71:e609 with SMTP id 5b1f17b1804b1-4a18e499874mr410207645e9.20.1792137340027;
        Fri, 16 Oct 2026 00:55:40 -0700 (PDT)
X-Received: by 2002:a05:600c:620f:b0:49f:dc71:e609 with SMTP id 5b1f17b1804b1-4a18e499874mr410206735e9.20.1792137337796;
        Fri, 16 Oct 2026 00:55:37 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8af2fcesm41176545e9.8.2026.10.16.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:55:37 -0700 (PDT)
Message-ID: <9fc2d6a03fabc2c756bfa696bc907ef23dcc175a.camel@redhat.com>
Subject: Re: [PATCH v2] verification/rvgen: reject ambiguous state/event
 transitions
From: Gabriele Monaco <gmonaco@redhat.com>
To: heath@mathgraph.org, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 09:55:35 +0200
In-Reply-To: <11d37dced04f512153c023b8b7361309@mathgraph.org>
References: <11d37dced04f512153c023b8b7361309@mathgraph.org>
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
X-Mimecast-MFC-PROC-ID: dQAYH33ChDU3-2fcjCk6wHRk1Xfa3esrGA-Ep0lPI2Y_1792137340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-13 at 15:51 -0400, heath@mathgraph.org wrote:
> The rvgen generator builds a transition table indexed by source state
> and event. A DOT specification with different destinations for the same
> key is currently accepted, and the selected destination depends on the
> iteration order of parsed transitions.
>=20
> Reject duplicate state/event keys after sorting the transitions, before
> generating the monitor. This prevents silently selecting an arbitrary
> destination without changing valid automata.
>=20
> OpenAI GPT-6 assisted in finding the issue, developing the fix and=20
> tests,
> and drafting the changelog. I reviewed the changes and take=20
> responsibility
> for this contribution.
>=20
> Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to=20
> Lark")
> Assisted-by: LLM
> Signed-off-by: Heath Sanchez <heath@mathgraph.org>

Thanks for the quick V2. I'm going to take this.

As a side note, I just read ([1], subscription required) that the Maintaine=
rs
decided at the 2026 Summit that models used and other LLM details are no lo=
nger
to be included in the changelog.

You don't need to send a V3, I'm trimming that paragraph. Anyway this kind =
of
transparency is largely appreciated, so feel free to include it after the -=
-- on
your next contributions.

Thanks,
Gabriele

[1] - https://lwn.net/Articles/1099594

> ---
> Changes in v2:
> - Drop the redundant hybrid-automaton regression fixture and test.
> - Match the full traceback prefix in the negative assertion.
> - Move detailed qualification results outside the permanent changelog.
>=20
> Verification: original rvgen suite 30/30; revised suite 31/31;
> 64 deterministic/hybrid hash-seed replays rejected malformed models.
> https://github.com/metalogiclabs/mathgraph/actions/runs/38452477359
>=20
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
> index 5f25626..8d635fc 100644
> --- a/tools/verification/rvgen/tests/rvgen_monitor.t
> +++ b/tools/verification/rvgen/tests/rvgen_monitor.t
> @@ -84,4 +84,9 @@ check "invalid ltl file syntax" \
> =C2=A0=C2=A0=09"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t =
per_task" 1
> \
> =C2=A0=C2=A0=09"No terminal matches 'i'" "Traceback (most recent call las=
t)"
>=20
> +# Reject ambiguous source state/event pairs.
> +check "reject conflicting deterministic automaton transitions" \
> +=09"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot -t=
=20
> per_cpu" 1 \
> +=09"Duplicate transition for event event_2 in state state_a" "Traceback=
=20
> (most recent call last)"
> +
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

