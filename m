Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C28BA21
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912602; cv=none; b=QWidcSxF2HC4g+HGPdQ22rH2ZidiwW3su6e4hs5ECVtUxHKJhMltZOFJYH40uufyTbjsAKCATSMx0uj+jnIKTc3mfWx5ZbfHgshOOc7r+ygz9v5/n0IwaoaRxo7+HGC03TXqp7XNynqvWzj4EbYYvU4LAXgmlRRCK9qN6vB3sTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912602; c=relaxed/simple;
	bh=aXwAIsCSH4SDEfjq9aN8agt/at4w19pksE8ic5Ls3hU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXFGjMPcRJUsE3CTSU2NPIE9Ugplvl26fEGff6CxYKpgX+gvCQiG+3ppLAJgTadsLeaytFHWglWH3IRzopbiNQiDAt53E9iiC3aWsaLIlZQEluFZ7v6V8cOC0PPA/pzqwIf4S+0n5P8kcB6/0rfyslV5YTwGrVsynUICY5vPZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC9ca+Fg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC9ca+Fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768912599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aXwAIsCSH4SDEfjq9aN8agt/at4w19pksE8ic5Ls3hU=;
	b=AC9ca+Fg89MkWosAWb8Q2ud/MHsTUYLtY5oasIO7joeUNIOuCGfZc2xkgj28eEZ/ZKERRr
	54R7uHOREuYfE3EAvyjcmBn6ttkj7y+K+zjTRImN+qFEOqKhCoeOaOdZRuSKvW9/+s0NTn
	pG3hYm25vq+5qXWI7x48F4IcMMIWXNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-i5--IM78OPuqXnE-WNcA9A-1; Tue, 20 Jan 2026 07:36:38 -0500
X-MC-Unique: i5--IM78OPuqXnE-WNcA9A-1
X-Mimecast-MFC-AGG-ID: i5--IM78OPuqXnE-WNcA9A_1768912597
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so46851905e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 04:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912597; x=1769517397;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXwAIsCSH4SDEfjq9aN8agt/at4w19pksE8ic5Ls3hU=;
        b=M5VyL9KrSAC3Y25e9nWyzBf+puWAQErKBK6qVhxCtLkj80Nh4XR1B4LKfiJ0Um0HJt
         CYAU/VUl60IwxLOEwjHDPNr4U7FkrLxubKMUwJzq+pnw4SJx/0ZjCKu5lZoEKbhlqwV3
         0wvNq6qbIiwlmYH3dTBDmgrbspI2CxWoVj9Ux8jQNi2VKoFgjUeo2WJL2DcejU18lEEV
         gdFySjoS4g9yFqUKqrSGl9IWKwqEUr+WB6ast8c03ZiWmbvzRD3mt5svMZaRIp9FHggk
         kuqdm06DQ0lVZ1t8PW72GNtC9cZIQLnko3Y6xj5wt4oYzLHVopf9bP2SwJdDQ9M7XgaD
         aU6w==
X-Forwarded-Encrypted: i=1; AJvYcCWdyKRdHVf00125OA32aEvn98W/Tbkq+2xp+Oa/yviniOImv/qgv0oQuc77vFQwCLUv0Ophu+U0vLPiaFvbZJ6xoKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBi2TslHWov6d9C6dG8hKku7U3Xk3G+gZvNPmGisuVRuv8rVw
	oo7mUKOLFe0DoHg5tbWl94YBAwVJ+rOsA6nyKgGRPqqg18nnKPg/owMLgQLqbh48MZOHKx/Va/e
	1JiWbDTqv6RQxwIQIl5H8rOsy0AymOHWtc/ypd6d5b8hKbM9hDmlZqu/M1CeTZ/qTbPesJL5VQA
	==
X-Gm-Gg: AY/fxX40r8EVbq6iHOg0T+rXVr+nN+gOfqVIG1SdG5cI3plxXKjE5/nzTTMV6xFG+zo
	tv3RO0THTYnxLbakHerxIg0JxPPo1k9W2hSklSj+N5/xPPqL4xfayN+YZB8+oRmQIUzyC+3tIPq
	+3+iRJAOjJGCqX2X2yueCMM2p+Rdw5a3XXloPuBKbA7KDOOc4XrHlFn/DN701zcnJVldtrlNS9N
	am/XLLxiQMJUaO8fdGe5C00FmsXl1EcwcKo4+wzEEtG2E3/nM2xN8SR8Y0Nm+AR3OZ2wyNqb/ho
	nME/LHz6ifkJk527nfTsEzMTnPjV/4K1XroWwRKz6T33rGAsl0WWUeRcPGlGo4tdZtB8ZdszEU3
	oh5t4RUHpEQX30tkctVReYvSKg1dd73OG3qwPp+sWbcZZnWUcGzDa0Gy/v+RKOL0MEjiT3DF0kX
	m9xTGQ3PR8
X-Received: by 2002:a05:600c:1d19:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4803e7e7dc4mr21331175e9.23.1768912596797;
        Tue, 20 Jan 2026 04:36:36 -0800 (PST)
X-Received: by 2002:a05:600c:1d19:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4803e7e7dc4mr21330785e9.23.1768912596393;
        Tue, 20 Jan 2026 04:36:36 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm298023235e9.10.2026.01.20.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:36:36 -0800 (PST)
Message-ID: <85c7d4762464e6a50b4318f4ea56a70202a4b287.camel@redhat.com>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 13:36:35 +0100
In-Reply-To: <aW9nfu8r0YcGj0z5@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-27-wander@redhat.com>
	 <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
	 <aW9nfu8r0YcGj0z5@fedora>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VSXMyKJtQt7j86dLa4I70ibWi1PIt998dAQlSsWEvQ0_1768912597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 08:34 -0300, Wander Lairson Costa wrote:
> On Tue, Jan 20, 2026 at 10:03:20AM +0100, Gabriele Monaco wrote:
> > On Mon, 2026-01-19 at 17:46 -0300, Wander Lairson Costa wrote:
> > > Add a node_marker class constant to the Automata class to replace the
> > > hardcoded "{node" string literal used throughout the DOT file parsing
> > > logic. This follows the existing pattern established by the init_mark=
er
> > > and invalid_state_str class constants in the same class.
> > >=20
> > > The "{node" string is used as a marker to identify node declaration
> > > lines in DOT files during state variable extraction and cursor
> > > positioning. Extracting it to a named constant improves code
> > > maintainability and makes the marker's purpose explicit.
> > >=20
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >=20
> > Looks fine for me, thanks!
> >=20
> > I wonder if we could merge this patch with 15/26 that is introducing a =
very
> > similar change on init_marker.
>=20
> The idea was to make each patch doing one thing to make the reviewer's
> life easier (I think I broke my own rule in a couple of patch). But if
> there is a strong feeling about the merge, I could merged them in a
> possible v2 patch series.
>=20

Yeah I get the idea, I guess I could just pick the most obvious patches and=
 send
a PR to Steve before the merge window, so I can see directly if it makes se=
nse
to squash them and you don't need to send them all in the v2.

I'm leaving the longer or trickier ones for the next cycle so that I can te=
st
them a bit better and perhaps get some rvgen selftest help with that. Also =
for
some it's better to wait for Nam's comments.

Will let you know the ones I pick. Thanks again for the extensive work!

Gabriele

> >=20
> > Anyway:
> >=20
> > Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> >=20
> > > ---
> > > =C2=A0tools/verification/rvgen/rvgen/automata.py | 9 +++++----
> > > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > > b/tools/verification/rvgen/rvgen/automata.py
> > > index a6889d0c26c3f..5f23db1855cd3 100644
> > > --- a/tools/verification/rvgen/rvgen/automata.py
> > > +++ b/tools/verification/rvgen/rvgen/automata.py
> > > @@ -29,6 +29,7 @@ class Automata:
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 invalid_state_str =3D "INVALID_STATE"
> > > =C2=A0=C2=A0=C2=A0=C2=A0 init_marker =3D "__init_"
> > > +=C2=A0=C2=A0=C2=A0 node_marker =3D "{node"
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, file_path, model_name=3DN=
one):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__dot_path =3D =
file_path
> > > @@ -76,7 +77,7 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for cursor, line in =
enumerate(self.__dot_lines):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 split_line =3D line.split()
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f len(split_line) and split_line[0] =3D=3D "{node":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f len(split_line) and split_line[0] =3D=3D self.node_marker:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cursor
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise AutomataError(=
"Could not find a beginning state")
> > > @@ -91,9 +92,9 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if state =3D=3D 0:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if line[0] =3D=3D "{node":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if line[0] =3D=3D self.node_marker:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state =3D 1
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
lif line[0] !=3D "{node":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
lif line[0] !=3D self.node_marker:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 raise AutomataError("Could not find beginning event")
> > > @@ -116,7 +117,7 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # process nodes
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for line in islice(s=
elf.__dot_lines, cursor, None):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 split_line =3D line.split()
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f not split_line or split_line[0] !=3D "{node":
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f not split_line or split_line[0] !=3D self.node_marker:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 raw_state =3D split_line[-1]

