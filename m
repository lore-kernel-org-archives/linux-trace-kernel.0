Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EF19B3CB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143488; cv=none; b=TD6JLmiVlIr+E4oOo6KgS55NG8RLdVc7gmCqle//BHP7S3FE/sV2xTL8YNnRgAFSQbQq4HGXxhubiZpB1K+J2o8U5QafBqb5h5rLSSHOKSepl63fbV/rUwR/MSlTOzdGSakldajzkBUZuoihkjXbMiJbVpF7DoZZ5SRPzt9gETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143488; c=relaxed/simple;
	bh=uX8jMJ4IoX66fZyyrakJYdlwFn+wmx+5e4zWhyM+tJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJiSCpOenu3YW+4BW0ogtqFpW33sFmrySss2Y4zosxafzfakaOo3Fh++LEEbU42ZDkfjeDkUuT7IvH7Ai7AwV8f/Q5kaQPNaAHdtvfFrckRC2QU7WjVkE8IfakjJvEaADBFkPnsA+DPMaMCeSVnrXfa8nDqRm6Zl00EI3sD5fU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh1e+JDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh1e+JDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uX8jMJ4IoX66fZyyrakJYdlwFn+wmx+5e4zWhyM+tJA=;
	b=fh1e+JDExlMxw8cZA5gY4EA9PWWzQvh56JmTU4ZUpczYQfCn6VkFA6c2wNwHJZRVdACtFG
	5hqSXoRXICYfJuohS6FcDdCHAYyWpNt44zX9UN8ADc24kY2tsQfIyi/wKRESkabXF/ljD0
	QPpUmd4qUepzx+RU4Tayfo10h/tgw+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-qh1cA08MMWWBfi_7AgqgkA-1; Fri, 16 Oct 2026 09:38:03 +0000
X-MC-Unique: qh1cA08MMWWBfi_7AgqgkA-1
X-Mimecast-MFC-AGG-ID: qh1cA08MMWWBfi_7AgqgkA_1792143482
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df02e6b40so1535030f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 02:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143482; x=1792748282;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=odpzRyL/+qkTBXSWqxc0VNkikl0xH5c4tts12k5e6cU=;
        b=2CPWDR9qa1t3zMyk+kPwBGeTMDiOTqT+Sn2gqk9B/Cvft4+xNBFEsIhy5LxSUADv/U
         VOwvz+Nbtlac7FtaOcSjvMrbvqBC6o0Fc9xxPmD2Uv+FB7VvJEr8iygiT2rHmrKgtjQe
         42ss/DwSpbJZ57VXra+TS9wKyXRGCNENRibUyL3QMNZ1QeWPCRk/pXPFfyzx10C0SEJ+
         vQv/GbAXq3Ub7gd2GBmq9jU9834Dg2Peoiy5TRsxcjc5kp+wJppseoU/VmzsPSj++hGv
         oaOMbBmeX0VqpUW2koeo3M6JFNkm55lz55gene2hcHEReUoEnP+YSCuE3XYOos1ec0Vz
         iy4Q==
X-Forwarded-Encrypted: i=1; AKwUvByHBu/q7AhA8yScv+Lmf+61FoK6yk5lBOj4C5DdVdIrsIQ0mwjD9yxk9FZQ7nq8HrssnbXXxef+BWUWiEdTBeEClR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlbgGRGM4tEKPqxgaAP1/dacXdKtfFlxdFLoI4lHHIVDsqZ200
	VEMcO38WYCbg2t+abM9qrkSaaGTS3zl9PKxl0SnYkv1UNefYSBvps5RGPA95QDKE2M54HWlNZiS
	WLqog3xsXPjFYmZYUwS6jOfDQBGiTN8naxxNbd7OkrsllBuTQtgD7p6T6LnwZZno4MO+GnoaNAQ
	==
X-Gm-Gg: AYBFou1t3KbC5fncg8sa56uUssczGgOFQzf11NRKAbZCfIDEgblkR19QA+YnatY7Ub1
	i1f5azhPNBzyB1KPfeolj6tuJqXRF0GUJgfKOu6pv7N/hmgY5wNWG8eiu6opyMvXGWvqrx4sJ7h
	2+Z8S7+mnW8OSF9Oj9z6vXks+qDiwOQQJhAz+BdW+f9EFwIp7eeQS8cyPDydBvM4Zm4md3N38Ca
	k1ASV0A40wVIGEFmwG/uhRUCJiqsE7xwjaQMqiAQ8SNjKml9dXDRL2KXbEYfKdBWJOFfmxNfzoH
	CborAfBQv/Hw2czzVeI9UusfV3SKItN9UwNO8hAiQwgvlsSpvJgGH2rklfFjggXPhy0Xt8wcat/
	PZELqXL0U2zqmQ67Y7P/L7vNO9l1R
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id 5b1f17b1804b1-4a196611b9amr321481055e9.32.1792143482407;
        Fri, 16 Oct 2026 02:38:02 -0700 (PDT)
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id 5b1f17b1804b1-4a196611b9amr321480385e9.32.1792143481221;
        Fri, 16 Oct 2026 02:38:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm25645125e9.4.2026.10.16.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:38:00 -0700 (PDT)
Message-ID: <f759977bab11b886198ec5f9678404ff3fc80724.camel@redhat.com>
Subject: Re: [PATCH v2] verification/rvgen: reject ambiguous state/event
 transitions
From: Gabriele Monaco <gmonaco@redhat.com>
To: heath@mathgraph.org
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 11:37:59 +0200
In-Reply-To: <f8a773ce204c7dfe5b15bdefe21131b1@mathgraph.org>
References: <11d37dced04f512153c023b8b7361309@mathgraph.org>
	 <9fc2d6a03fabc2c756bfa696bc907ef23dcc175a.camel@redhat.com>
	 <f8a773ce204c7dfe5b15bdefe21131b1@mathgraph.org>
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
X-Mimecast-MFC-PROC-ID: 4w17WULRrLz11zKjQcZ_SwBtdJmNwcXq0nioIjMekSQ_1792143482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-16 at 04:28 -0400, heath@mathgraph.org wrote:
> Thanks, Gabriele! Really appreciate you taking the patch and the=20
> clarification on LLM disclosures.
>=20
> One small question- this work is part of MathGraph, developed at=20
> Metalogic Labs. Is there a conventional way to acknowledge that=20
> affiliation in the commit? No worries at all if not =E2=80=94 I wouldn=E2=
=80=99t want to=20
> complicate or delay the patch.

Hi Heath,

you may find more information in [1], as far as I know, the affiliation is =
clear
from your email in the signoff.
Often people using personal emails or kernel.org accounts specify their
affiliation in parenthesis.

In short, you either do the following in the signoff:

1. John Doe <jdoe@acme.com>

or

2. John Doe (ACME) <john@doe.org>

your case falls in 1. (@mathgraph.org) I don't think you need extra steps.


Gabriele


[1] - https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l

>=20
> Thanks again!
>=20
> Heath Sanchez
> Metalogic Labs | MathGraph
> https://mathgraph.org
>=20
> On 2026-10-16 03:55, Gabriele Monaco wrote:
> > On Tue, 2026-10-13 at 15:51 -0400, heath@mathgraph.org=C2=A0wrote:
> > > The rvgen generator builds a transition table indexed by source state
> > > and event. A DOT specification with different destinations for the=20
> > > same
> > > key is currently accepted, and the selected destination depends on th=
e
> > > iteration order of parsed transitions.
> > >=20
> > > Reject duplicate state/event keys after sorting the transitions,=20
> > > before
> > > generating the monitor. This prevents silently selecting an arbitrary
> > > destination without changing valid automata.
> > >=20
> > > OpenAI GPT-6 assisted in finding the issue, developing the fix and
> > > tests,
> > > and drafting the changelog. I reviewed the changes and take
> > > responsibility
> > > for this contribution.
> > >=20
> > > Fixes: cad252db78a9 ("verification/rvgen: Switch __create_matrix() to
> > > Lark")
> > > Assisted-by: LLM
> > > Signed-off-by: Heath Sanchez <heath@mathgraph.org>
> >=20
> > Thanks for the quick V2. I'm going to take this.
> >=20
> > As a side note, I just read ([1], subscription required) that the=20
> > Maintainers
> > decided at the 2026 Summit that models used and other LLM details are=
=20
> > no longer
> > to be included in the changelog.
> >=20
> > You don't need to send a V3, I'm trimming that paragraph. Anyway this=
=20
> > kind of
> > transparency is largely appreciated, so feel free to include it after=
=20
> > the --- on
> > your next contributions.
> >=20
> > Thanks,
> > Gabriele
> >=20
> > [1] - https://lwn.net/Articles/1099594
> >=20
> > > ---
> > > Changes in v2:
> > > - Drop the redundant hybrid-automaton regression fixture and test.
> > > - Match the full traceback prefix in the negative assertion.
> > > - Move detailed qualification results outside the permanent changelog=
.
> > >=20
> > > Verification: original rvgen suite 30/30; revised suite 31/31;
> > > 64 deterministic/hybrid hash-seed replays rejected malformed models.
> > > https://github.com/metalogiclabs/mathgraph/actions/runs/38452477359
> > >=20
> > > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > > b/tools/verification/rvgen/rvgen/automata.py
> > > index fd37ce3..1f9a56a 100644
> > > --- a/tools/verification/rvgen/rvgen/automata.py
> > > +++ b/tools/verification/rvgen/rvgen/automata.py
> > > @@ -418,6 +418,13 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transitions.append(Transition(src, dst, e=
vent,=20
> > > reset,
> > > rule))
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transitions.so=
rt(key=3Dlambda t : (t.src, t.event))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 previous_key =3D None
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for transition in transit=
ions:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
ey =3D (transition.src, transition.event)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f key =3D=3D previous_key:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 raise AutomataError(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f"Duplicate transition for=
 event=20
> > > {transition.event}
> > > in state {transition.src}")
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
revious_key =3D key
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return transit=
ions
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def __parse_states(self):
> > > diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t
> > > b/tools/verification/rvgen/tests/rvgen_monitor.t
> > > index 5f25626..8d635fc 100644
> > > --- a/tools/verification/rvgen/tests/rvgen_monitor.t
> > > +++ b/tools/verification/rvgen/tests/rvgen_monitor.t
> > > @@ -84,4 +84,9 @@ check "invalid ltl file syntax" \
> > > =C2=A0=C2=A0=09"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl=
 -t
> > > per_task"=20
> > > 1
> > > \
> > > =C2=A0=C2=A0=09"No terminal matches 'i'" "Traceback (most recent call=
 last)"
> > >=20
> > > +# Reject ambiguous source state/event pairs.
> > > +check "reject conflicting deterministic automaton transitions" \
> > > +=09"$RVGEN monitor -c da -s tests/specs/test_nondeterministic_da.dot
> > > -t
> > > per_cpu" 1 \
> > > +=09"Duplicate transition for event event_2 in state state_a"
> > > "Traceback
> > > (most recent call last)"
> > > +
> > > =C2=A0 test_end
> > > diff --git
> > > a/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
> > > b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
> > > new file mode 100644
> > > index 0000000..1b63b5d
> > > --- /dev/null
> > > +++=20
> > > b/tools/verification/rvgen/tests/specs/test_nondeterministic_da.dot
> > > @@ -0,0 +1,16 @@
> > > +digraph state_automaton {
> > > +=09{node [shape =3D circle] "state_b"};
> > > +=09{node [shape =3D plaintext, style=3Dinvis, label=3D""]
> > > "__init_state_a"};
> > > +=09{node [shape =3D doublecircle] "state_a"};
> > > +=09{node [shape =3D circle] "state_a"};
> > > +=09"__init_state_a" -> "state_a";
> > > +=09"state_a" [label =3D "state_a"];
> > > +=09"state_a" -> "state_a" [ label =3D "event_2" ];
> > > +=09"state_a" -> "state_b" [ label =3D "event_2" ];
> > > +=09"state_b" [label =3D "state_b"];
> > > +=09"state_b" -> "state_a" [ label =3D "event_2" ];
> > > +=09{ rank =3D min ;
> > > +=09=09"__init_state_a";
> > > +=09=09"state_a";
> > > +=09}
> > > +}

