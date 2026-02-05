Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40303542D4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275004; cv=none; b=sNgmuABsJZ4w+Iq5IBxwrb74oZb7Pea+JEt1Nz2XJapIp0RZufJruzgQu33NhhXb2BQ2mPW1b1DNkMOQHmIuPZBLs0FBxM97DfGMaX4q3aZcZFvXCx9fQSJCJkNWv1v0PxLlJkxzPwHVw+53a9VB1BCNhBPEuhKiYWIJjv5E/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275004; c=relaxed/simple;
	bh=1jvmF+JFbYJ1iZcqtkpCUpVHGgSD2QYjzGFCeSm2dn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBX8a+oqZrZqvWPmeqLKzgl32ctmyivZ422n4EQ0MDrLbmLnH/CuXbt/K4+NAAu0+EavkKPJAlZ5EugxAQ/uw41hujeC6SPBPeGgPed1WpwsoonUPoqgJDjeQW9IUrEnYjlWviVjtl9zYQvqOPtOeipOiczhE34ktTAnhHvn0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7+GBaMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7+GBaMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770275003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yKvHEfuOwc6AejWVpv1J8eYwloGKKUnIzQiWQBw1sS8=;
	b=R7+GBaMiMXlnLEgtWN6jD5z3fr3aALxxzN8xJC9d1M8G8FX1rZAFANj9DWmWz4qsy9Aj50
	jZtVo8pPRtVbYI3or6owa9fgH+pCJsSM8IUUR+CrcEkGyTUu6+HMiyqtSbVLFLpPkuwhx7
	mflHODluCGptd/dRugJkLxqksJkwcts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Nh5Mt9BEMOu7VY_JKyotTQ-1; Thu, 05 Feb 2026 02:03:20 -0500
X-MC-Unique: Nh5Mt9BEMOu7VY_JKyotTQ-1
X-Mimecast-MFC-AGG-ID: Nh5Mt9BEMOu7VY_JKyotTQ_1770274999
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fe16b481so410015f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 23:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274999; x=1770879799;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKvHEfuOwc6AejWVpv1J8eYwloGKKUnIzQiWQBw1sS8=;
        b=j2rDuI+BbLAA6Np2bRAXE/YUvUVf4SHmPS+GQ2GCmFAyZ5376R5LztQrZxumvPg6BU
         4+YABbkFf4wq1veksSQysrxJ5cmKWdWyd/p8win2LzCAUryl6efMoy4mXGqrnagpMZmo
         7h8XuxahXMmEnBYQr9rSxy5rHUql1VrAowoZ3j8qgw2OcJWPaaBIQ3gUoT4xPt9sRVyf
         TiK2030bfAexbpR3XgngCsyLgl+Oa0mDXAMqZT9oQ26/QR/tj2drRoL62brKVxIcTq6k
         ruXHV8A66sYN72An3wJ0O+VAAucgWmprdOe9tqdLTSckuZvtawUA8AaSxOejM9jZPPzB
         ISgA==
X-Forwarded-Encrypted: i=1; AJvYcCUTNvHmqVkJWM0fkUtJwPIuPwK/w8s3u2b9v4SlpeqMF5a/ql0ACjCUwxDQNpZTTC4DhfoMYGlkiBsSWpFvZ/o1mt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9SONSvxseAzyjN3aibA4iQt0Y4SSMa7t1hu1aaMxcE2p8GMp
	cnSPGRTBRy05eeIyApvRx0aDG0tUCXFs3xQGQddCIgFJgVuJ+2B5bYuS87mKCMu2lxbr3hl3M8M
	nOBuxoWg0UPDChK8P8zmC+yitxNRS28ARrZshyE1ZvEJ7myZ7uAFiufljE7NSApMED6ZazVFH5+
	sdQ/rL4cGL
X-Gm-Gg: AZuq6aJ6vb1lML90sVbhNwoSJNhd9+49qYCh6sOHTOKDxr1uVxvzIN7YlNscnY6izet
	AMiNWGL2zlHxqfs742YUQ2YyWwUcacQjAcaTY5mgltmUmRmsITGD+mNnMR/aVjZb/VUlH9M7XKR
	/bE6lajD2E30+F8l+AUiRNtsbGDkFApz0C/fBZcFEZvqYi3yHziksK+OOsy5Z5OUmsv9zoKOD+G
	0+UyriQR7sW8BUdD4q6IjEJKTFasOzHNIy1Ng8h0Rlinz577e26xW45gMO+P1H5ZbEQ113vS45R
	yE0nQlEN2fCeFKcb9c9hnhUYSDI8IzH0wPfkcE4E3uopkiurrDFLVxArsTOBFA2OOGOW2zECyRH
	yO6QRnKXkNAbexiODvMguQVZd5kV8VsF4Hm0s8j2QDbh+Imb3co1o8eF1DFfZ4f/c4EsEyD9X6b
	HX0/Rqm4w7
X-Received: by 2002:a05:6000:24c9:b0:42f:b9c6:c894 with SMTP id ffacd0b85a97d-4361805dd58mr8929357f8f.52.1770274998835;
        Wed, 04 Feb 2026 23:03:18 -0800 (PST)
X-Received: by 2002:a05:6000:24c9:b0:42f:b9c6:c894 with SMTP id ffacd0b85a97d-4361805dd58mr8929316f8f.52.1770274998426;
        Wed, 04 Feb 2026 23:03:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25e8csm10480333f8f.1.2026.02.04.23.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:03:18 -0800 (PST)
Message-ID: <90102c96156337943a5319ab25991f95f9f07cf5.camel@redhat.com>
Subject: Re: [PATCH v2 07/20] rv/rvgen: fix typos in automata and generator
 docstring and comments
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 08:03:16 +0100
In-Reply-To: <20260204144914.104028-8-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-8-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VzZ-9N3ODcOPANdKo5daBZL7k_O9JoDJ5fPjp67v5Q8_1770274999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> Fix two typos in the Automata class documentation that have been
> present since the initial implementation. Fix the class
> docstring: "part it" instead of "parses it". Additionally, a
> comment describing transition labels contained the misspelling
> "lables" instead of "labels".
>=20
> Fix a typo in the comment describing the insertion of the initial
> state into the states list: "bein og" should be "beginning of".
>=20
> Fix typo in the module docstring: "Abtract" should be "Abstract".
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>


While you're at it there are a few singular/plural inconsistencies, see bel=
ow.

Other than that it looks good, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>


> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py=C2=A0 | 6 +++---
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 2 +-
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index 1feb5f0c0bc3e..0d7cbd0c634a9 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -18,7 +18,7 @@ class AutomataError(Exception):
> =C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0
> =C2=A0class Automata:
> -=C2=A0=C2=A0=C2=A0 """Automata class: Reads a dot file and part it as an=
 automata.
> +=C2=A0=C2=A0=C2=A0 """Automata class: Reads a dot file and parses it as =
an automata.
> =C2=A0

Automata is plural, the singular is automaton (you can keep the class name
unchanged):=20

+    """Automata class: Reads a dot file and parses it as an automaton.

> =C2=A0=C2=A0=C2=A0=C2=A0 Attributes:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_file: A dot file wit=
h an state_automaton definition.
> @@ -113,7 +113,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states =3D sorted(set(st=
ates))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states.remove(initial_st=
ate)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Insert the initial state at=
 the bein og the states
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Insert the initial state at=
 the beginning of the states
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states.insert(0, initial=
_state)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not has_final_states:
> @@ -134,7 +134,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 line =3D self.__dot_lines[cursor].split()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 event =3D line[-2].replace('"','')
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # when a transition has more than one lables, they are l=
ike
> this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # when a transition has more than one labels, they are l=
ike
> this

This should be "more than one label" as singular.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # "local_irq_enable\nhw_local_irq_enable_n"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # so split them.
> =C2=A0
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index ee75e111feef1..a3fbb1ac74916 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -3,7 +3,7 @@
> =C2=A0#
> =C2=A0# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira
> <bristot@kernel.org>
> =C2=A0#
> -# Abtract class for generating kernel runtime verification monitors from
> specification file
> +# Abstract class for generating kernel runtime verification monitors fro=
m
> specification file
> =C2=A0
> =C2=A0import platform
> =C2=A0import os

