Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC373644CD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894898; cv=none; b=bM00iF1/b5LsQCwcd2EWiPlvOQlIzL2WTwJVysI5zs/xU3IP73wjr+NV8nsXkzNWK3lqPRuJerjfhcpujlmPwnmE+k3LhnQpg6uKGjirVF5Hlhm/BP0soroXs8tXc6NWdBKjhha4G3wI4HkEH4JTgszgIIviSIqtTj2mnksK18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894898; c=relaxed/simple;
	bh=FAXlLyTu3UKN/2U8ksYz6To3YgrKMjplyJuKImUxQic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiHlgvhRm60Y8Dh5Qn6ZMXI8sOd5lXpCzF4uJ37cWMKddpwsXrxGGYME2T9RmLysDhhMnwtcMBnBHU2JHZaWv8YfY1OSBxjmIvO4vK+BSDY+eXDA2mz6lmI+sH83EJa4G1wYVs8ZhIztUHed+IEWvrCqjWWWZnjLMecS5eHtTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG1Zdz7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG1Zdz7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768894895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FAXlLyTu3UKN/2U8ksYz6To3YgrKMjplyJuKImUxQic=;
	b=OG1Zdz7Kx3QxSFjaf8A9EFBtSDLwj4mNyKBTyNFEbsj1vCfRb3JBqlgmziynKJTKYCCwli
	ddG0rYvMibsWHGdYBd2YZVopbEsI7jEEnQDtS8DsWh8VZAN5A8r4gOgWxeOVJkvhs+uY1A
	oLJOKNGI2IZYW6FFbNekfcq4XLZLlK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-RzWRmgAFOUaT3c0qMnEmPQ-1; Tue, 20 Jan 2026 02:41:33 -0500
X-MC-Unique: RzWRmgAFOUaT3c0qMnEmPQ-1
X-Mimecast-MFC-AGG-ID: RzWRmgAFOUaT3c0qMnEmPQ_1768894893
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so41121845e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894892; x=1769499692;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAXlLyTu3UKN/2U8ksYz6To3YgrKMjplyJuKImUxQic=;
        b=oZwcJVjxZUKXwC6bHq5enxpVkwZqFPJCSdLpCHQCq7uXc9qizJD3F7v427Am3fR9FK
         DiJ/fh2azjwK7Q3ZXabbpDdciv6+brd3TKusvVPLoapQzUI9GVSCS8nI+W25VDZLmF9p
         VAmcuHpIfC6qXVst3Dp65kC6jmexbshYcG7yLPvGtE9CKnPCUA+gTDaeSQEPNtmnGZ1J
         myMxdYm/OJ9i901FbjV8gAZwdu7993wtqcG/Xb5GMPyMoQLhiiiAtNwBAvYQr+LUrFWo
         Q5/OKXFqvL/AIU6Om3FBeXvL/mjfqL1xR+2vkqchYMxTATFMxjZoNbcAY7Y4aGSr28lZ
         PRuA==
X-Forwarded-Encrypted: i=1; AJvYcCU5NiciH9V+z6YC57+X+v8KDVT0l6ZeaIynNbhTyzht5YtuNHesClo0T3oxlnANPOo4vg/BNQoZUKxJKz5kRekPV4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOICB6GyKfDor3QWBPgoWQ8IwifdfuDYFMSo4cqFcGkZMjHzPT
	Zstuvx1vF+Yj3qu4cg7E/KLFD9citFodQT22AvngoLFnWsjJGuoafcIUWVJd66BXvZMgUYxIm2B
	ZEsq5aMW3ryBJF3d2sWCXEZMOKUUj34TozblBnvI5bhfJIvq6elHg7my1WNNsAwExXJ2e56mBoA
	==
X-Gm-Gg: AY/fxX40Q2JAyqFYCOwq6/8SYdNDOO/1/bdv1vLOnN6L/c2pKIdChP55XySEF7cQn1p
	gCUx7Nv1jG4Z/8zNn4DbUZy8XfqVBwGYO1pdyzH2pbK40idiW+ltdcszyFDbuX+n4lOSZ7X0i6/
	elNAp8Vbracz4YQKkmftSKTzREGXAWESTmYPgiMJFXtcO5dNBLYkrJEYkhh/+xMDB8NYD5PmQwi
	7qgzjAEd2JC4qQM0/rvK670Hk9GI2R4JGvoTK4IZPM4RLxhcX1exQSoJyDIn8CYJ1H7E7bX2e6v
	BhMyKYdUB71XKxWYgysq0Y5L+Jmlb/AEL8b7lwqLn/wGGY7mJgUi93vOYH8gOqtDsPEcohk05/J
	JPGhsJVnyNbyarqJC2IlDyVlfrrVhBEmS+HijzDSwQe/tNtD40ry31n3ADXVdtoBiDd2PMtsqJj
	7D0hb8SGEl
X-Received: by 2002:a05:600c:41ca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47f428adf95mr144656165e9.6.1768894892578;
        Mon, 19 Jan 2026 23:41:32 -0800 (PST)
X-Received: by 2002:a05:600c:41ca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47f428adf95mr144655995e9.6.1768894892193;
        Mon, 19 Jan 2026 23:41:32 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe2c1c6sm99094905e9.9.2026.01.19.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:41:31 -0800 (PST)
Message-ID: <7e9a637abca628611746c2df47a2d12da4c1d32c.camel@redhat.com>
Subject: Re: [PATCH 04/26] rv/rvgen: replace __len__() calls with len()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:41:30 +0100
In-Reply-To: <20260119205601.105821-5-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-5-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: q16jg-nLY2escx1b1zFmRLIvEDR-qoQk5yD42wktFJ4_1768894893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace all direct calls to the __len__() dunder method with the
> idiomatic len() built-in function across the rvgen codebase. This
> change eliminates a Python anti-pattern where dunder methods are
> called directly instead of using their corresponding built-in
> functions.
>=20
> The changes affect nine instances across two files. In automata.py,
> the empty string check is further improved by using truthiness
> testing instead of explicit length comparison. In dot2c.py, all
> length checks in the get_minimun_type, __get_max_strlen_of_states,
> and get_aut_init_function methods now use the standard len()
> function. Additionally, spacing around keyword arguments has been
> corrected to follow PEP 8 guidelines.
>=20
> Direct calls to dunder methods like __len__() are discouraged in
> Python because they bypass the language's abstraction layer and
> reduce code readability. Using len() provides the same functionality
> while adhering to Python community standards and making the code more
> familiar to Python developers.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---

Totally needed.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> =C2=A0tools/verification/rvgen/rvgen/automata.py |=C2=A0 2 +-
> =C2=A0tools/verification/rvgen/rvgen/dot2c.py=C2=A0=C2=A0=C2=A0 | 16 ++++=
++++--------
> =C2=A02 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index 3e24313a2eaec..ed02d0c69b410 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -42,7 +42,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
raise AutomataError(f"not a dot file: {self.__dot_path}")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model_name =3D ntpath.sp=
litext(basename)[0]
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if model_name.__len__() =3D=
=3D 0:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not model_name:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
raise AutomataError(f"not a dot file: {self.__dot_path}")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return model_name
> diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> b/tools/verification/rvgen/rvgen/dot2c.py
> index 78959d345c26e..0fb3617ad8ce9 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -86,14 +86,14 @@ class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0 def get_minimun_type(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_type =3D "unsigned c=
har"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.states.__len__() > 25=
5:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(self.states) > 255:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
min_type =3D "unsigned short"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.states.__len__() > 65=
535:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(self.states) > 65535:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
min_type =3D "unsigned int"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.states.__len__() > 10=
00000:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError(f"Too many states: {self.states.__len__()}")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(self.states) > 1000000=
:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError(f"Too many states: {len(self.states)}")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return min_type
> =C2=A0
> @@ -149,12 +149,12 @@ class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return buff
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def __get_max_strlen_of_states(self):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_state_name =3D max(self.s=
tates, key =3D len).__len__()
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return max(max_state_name, se=
lf.invalid_state_str.__len__())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_state_name =3D len(max(se=
lf.states, key=3Dlen))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return max(max_state_name, le=
n(self.invalid_state_str))
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def get_aut_init_function(self):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_states =3D self.states.__l=
en__()
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_events =3D self.events.__l=
en__()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_states =3D len(self.states=
)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_events =3D len(self.events=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff =3D []
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxlen =3D self.__get_ma=
x_strlen_of_states() + len(self.enum_suffix)

