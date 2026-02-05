Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52693B8BB2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291881; cv=none; b=jlbXfH79zumFVE6WOuyimAMLjtIRWiQK1cRnxyt0OX72t6voIb/1Av9+0PgOax90UgCgBHYSGQxBYDHQO6gym2ypS95qJm8Uv1jR4PLmSwgqD8/S4WpwDB4fEaMTS8izUy9rLNhVdPpjVKtRb8lI1A9tc6XklCb2Bxqp7Z4mfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291881; c=relaxed/simple;
	bh=3B3r8ZFmlMmPEXMtcMW+cvfD6+8gvI+M8EXaZz18KoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlAaOmCSOOt9142Snp9Clr+vNBddahJ1JYyw0rhEemdnCXwGe5I8iU4n7BE4MjMhH9Z+iIqIJJeJTdGD8qDmIBRCU109n7pXVG+1Wqg49S1VKF73Fd3ZHu9pVeijstVe9Si15XyHBc3pBB3SSqjYBvLvzyOi422CuLTcs+TIUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgiDd4C4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgiDd4C4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770291879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3B3r8ZFmlMmPEXMtcMW+cvfD6+8gvI+M8EXaZz18KoA=;
	b=XgiDd4C4k/r34JruN/b4BO2hjX6x7jsvlyBHDzKCb5ja1V2QZGY+Vw/7cBw5iao195liVW
	RBZsDcehm4T6ql2UYEJDnaZhZ54DuGaZGVI+EMql1dhyFCBEAQ4pNMdXg3nMwYKU3H0FoD
	X/sDnNuemSkjjZo7LW5S4ueIR7zZN00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-U3x1vXY3N3u6YwlTEvQj8g-1; Thu, 05 Feb 2026 06:44:37 -0500
X-MC-Unique: U3x1vXY3N3u6YwlTEvQj8g-1
X-Mimecast-MFC-AGG-ID: U3x1vXY3N3u6YwlTEvQj8g_1770291876
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480686b3b4cso12374855e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 03:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291875; x=1770896675;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3B3r8ZFmlMmPEXMtcMW+cvfD6+8gvI+M8EXaZz18KoA=;
        b=KticryXj1Kp9G+vYbOWIol+g3Zwnolqz08ykcYo4x+d/NWo/0wvbNEYYA5kSAvNgG3
         5UBiZlRtWbqkaSFwaJGAvMTuzhj2d3yvfm+Tal93qwoX4320nx/xgPFAgjrklXfZyOXY
         ZrhwVZTmXNSumRea2cuOAHx17Jp2ykxCkYTOf7r9Rss4Vn90/OEn8Lhgr0f33b2QVSIL
         upWHnB5wViuZf5XllYmC0vQuOSyDuqlPpxcsNlD6JvRLo6+RosO3oQp7HlNJ5+BvPwdQ
         UXTISOT6qJdH0ugQ1jmkTIO3INWMG/BjhPFZpVrdH/ks8XeFhiUbCBtotyoaVKrjbZ4H
         QzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVIYqoh24oVbevRYc+M3Bvpi1VDcop0Pw+aZqP8ocrweZ21ibpuerIr6FKlX3sWqAgLEjpKdU/FXwlHtAfz5aT8qsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGuA61xxQ5fIG4O81E9rFTjOwVTeUuF/9xR6oCzTEmnE7ARXE
	yVj+ShrhLD05dZoPrdVI9N8nlj1CF0hnG5uJEP6GaQQUvnnLNU73ob9bNPkMyGdL3QQCIHBuUDY
	L7Ku981zRnXl7TIx+RRQrb6+4c4AQSg8KfO5to24/UuUCZumEqFKiTmzTNLKqWsCOyjHRYqEhFw
	==
X-Gm-Gg: AZuq6aJC5OqE0rZeoJ7YoOqxNI2h8S8ojV1XdK/NQ+r+DQOa2a4wvzPjCS8gmt2gKWK
	aYtUz0rHCfMzPi0NjdsqdTZJ0uvAogZwRYzVgZaBLHO/A4xyPeHlmxlpdqQ+suyZ+WbScp25lPl
	DY7s85cP0C2bY52NKot5TGhu/P0HtRGsO43KEqJkxG5Gq6bJiunI426C7PNHuLkqnwrM9Kq6wl0
	1PStn7J1n0FT6mBkgt8Z6cr/LSTrMSuysP/+d2Qpk1c5H2bAgmvooJJtOrTzRFUiJZtbIpATXVz
	kS/SugHRTKObHUxKVDTL/ostDcsWrU335oP8/aC6MXPYPJWadQFhbxTJ99gKWy9ZMnCYiQPoQnr
	Dba4OWGWfpGFEY9Zd9w41v5M2yCZodJC8pADZtraFUvbK4zjSZytIwYK4dtwnvLPGM1TgPmyR3L
	u2uo4B2n4H
X-Received: by 2002:a05:600c:3488:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-4830e970950mr81053375e9.25.1770291875401;
        Thu, 05 Feb 2026 03:44:35 -0800 (PST)
X-Received: by 2002:a05:600c:3488:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-4830e970950mr81053085e9.25.1770291874957;
        Thu, 05 Feb 2026 03:44:34 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d35684sm52376245e9.7.2026.02.05.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:44:34 -0800 (PST)
Message-ID: <613427efef5c10cf04920ae16f0380b64e580241.camel@redhat.com>
Subject: Re: [PATCH v2 17/20] rv/rvgen: enforce presence of initial state
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 12:44:33 +0100
In-Reply-To: <20260204144914.104028-18-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-18-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lxbsvqZAaJ3c11ehb5KKmIQfrmfYAPRQ1FfwPO8lNxs_1770291876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> The __get_state_variables() method parses DOT files to identify the
> automaton's initial state. If the input file lacks a node with the
> required initialization prefix, the initial_state variable is referenced
> before assignment, causing an UnboundLocalError or a generic error
> during the state removal step.
>=20
> Initialize the variable explicitly and validate that a start node was
> found after parsing. Raise a descriptive AutomataError if the definition
> is missing to improve debugging and ensure the automaton is valid.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index 270a3d0bf4ce7..cf82f04dbc661 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -105,6 +105,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # wait for node declarat=
ion
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_states =3D []
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initial_state =3D ""
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_final_states =3D Fal=
se
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor =3D self.__get_cu=
rsor_begin_states()
> @@ -131,6 +132,9 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_states.append(state)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_final_states =3D True
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not initial_state:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("The automaton doesn't have an initial
> state")
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states =3D sorted(set(st=
ates))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states.remove(initial_st=
ate)
> =C2=A0

