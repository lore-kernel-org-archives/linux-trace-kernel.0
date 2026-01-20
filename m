Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79F3B8D5B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895773; cv=none; b=jVY47es8tojiE927CYCf58CMSGJngkBcqVC880lLDEo9j+JCxhMDWivA76XHWd2qsdf7F7YLKljp2NclcftmM93LcDcpjaQfZqef43a0ulyTaIQyNgwZPOh2370oyp3OBakoXPEIa2NXFkjXgyg3EsJP9gt+F8OiMMnL3y5fprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895773; c=relaxed/simple;
	bh=OGh0veNi//haBVMN+b6cSjciQM0klpprK47DoiMQjDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPNbJx3dbHbLazH8LFCY/lKRYE/ieAS468yWyFKTNOJx6Ij5Ol6QQPx1/nN1w9yNgi61Fa8UB+Da+N1uC1ziOvyTV375HHv+z9814b6GUsklY7uvnEVOyuv638BweOnj5kHq4FOq+pazY1OHGUNDS2ZFMz8Sy7e45p8D8lM28ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU+wfvan; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU+wfvan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768895770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OGh0veNi//haBVMN+b6cSjciQM0klpprK47DoiMQjDk=;
	b=aU+wfvanCH6T/WMrnXKGLHtrMba/M4Bie1KDTJTvm2qFo9mYHu3oOAsNTp0WIJg4jNTJbl
	Z8qYkEkIXcXgzFLgXbZjuGow4jA1G6YAQ2Xrm8nsIacL3pJdKt1vLoU5zxSpQ+eUKTwwhN
	G0Eoxsvs4QTRLy5fkk7UxAM1mBgzSK0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-jZ5mx0yYMwyyK9FDPRLQLw-1; Tue, 20 Jan 2026 02:56:07 -0500
X-MC-Unique: jZ5mx0yYMwyyK9FDPRLQLw-1
X-Mimecast-MFC-AGG-ID: jZ5mx0yYMwyyK9FDPRLQLw_1768895766
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so46186645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895766; x=1769500566;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGh0veNi//haBVMN+b6cSjciQM0klpprK47DoiMQjDk=;
        b=bKIuuizAln+MIVFw3WkPn2txAvEniG/rqMdvJLCazKe4H5E3jdghoOG0ebvE9EwbSe
         2fE+hu2dA0ttGh73PSmx7Y/gfwUUChhk5S0U/UiFgyBHmIGUinDT7RV0lWq9bGK+Pkaz
         /nyNxslfKz0w1GcWJZ9LglQpgTEvgteNb7KoWE4Kp+sYo3W+zAuXhgluVhrffWqz+JTG
         ka7YBTOrktaHCAijQBcTS42yoS9oe/8dzFsSztnRcRO7VwMS+AJNjrqSsrTShypYXFd/
         9rB8A8HQOIvGg2CeHHx9bq/c0BYCa6ptbStggFuZJMb/RO4rm6mYQ8hCiYm518RS0m/h
         8CpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVZrevKbFu9f+fnNEwanKA6FI6+fXB/um1083tDTQ3PdFeeRIsaBm0sNTOmUzvGluhjfP4+KMD/RVcNW+TMqYUo5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywed+t6lAS/TvlEVrz53sR5nq8ODkjyMIX/4gsg9NYGiSL+v/0Z
	XMps/ilvbKCezfRXx/RU5c6AfnY3SQo847WS3HiMzn3zVJ+Fnq0qot7Y2nfEtmmb4771kyUV/z4
	Js4W5lMw8Nlr1YGlt3jKSa0XpnDxGnAatYc9UJ9XBReVNL0AMkML+ed7mX/b30VCayAGBneRPrw
	==
X-Gm-Gg: AY/fxX7FHE44fJyOM+Ve19JYcaOOfCnJA5hinUmGVomhhba9Vo7DbryDpTNLLav2upw
	K44pfuiAplNoz3wK8iiVYrUkN6DVpnTZP3VeUMS3TSjmYZe1mpvOwKmiNEJbhHWiX+/9po9ZODG
	DaKIYIDLFaVPBhnvhEchxS3nuo6KWoCA4gAhXhSLhEXsE2ue0HM8PomFuINpNhvb4cyscukYE7t
	wsV7m6IdUE+hkdroXI0aoKRvZnOoGWxB1RsOj8axxJ2IKedu4/PtMqfn78SKImusIOzcigvKM6q
	ZZbnNnmiHppRtZWYukv+ZFfpvvsFhf+7/AgA6sKt8ItNYHvStx9A5M9ytyjAcBjeYLBEOHEXr0m
	4mZiMfIiq8SLvVHa3+nZtDdWN+X+zpcg5SGyIz6lTMDrFmmWdMFd6VFUBcy9h5Xy0mtt/ay9H87
	aS0dBkyjbz
X-Received: by 2002:a05:600c:1387:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-4801e30ba55mr195432785e9.15.1768895766001;
        Mon, 19 Jan 2026 23:56:06 -0800 (PST)
X-Received: by 2002:a05:600c:1387:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-4801e30ba55mr195432535e9.15.1768895765655;
        Mon, 19 Jan 2026 23:56:05 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879537sm235505055e9.5.2026.01.19.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:56:05 -0800 (PST)
Message-ID: <328a77d7b602242763597b45592fbffc20b9c528.camel@redhat.com>
Subject: Re: [PATCH 13/26] rv/rvgen: fix DOT file validation logic error
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:56:04 +0100
In-Reply-To: <20260119205601.105821-14-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-14-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: BJGP8CuUOhF3RulRMxqLUXDMezLQidKQl3QKBHBVzeA_1768895766
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Fix incorrect boolean logic in automata DOT file format validation
> that allowed malformed files to pass undetected. The previous
> implementation used a logical AND operator where OR was required,
> causing the validation to only reject files when both the first
> token was not "digraph" AND the second token was not
> "state_automaton". This meant a file starting with "digraph" but
> having an incorrect second token would incorrectly pass validation.
>=20
> The corrected logic properly rejects DOT files where either the
> first token is not "digraph" or the second token is not
> "state_automaton", ensuring that only properly formatted automaton
> definition files are accepted for processing. Without this fix,
> invalid DOT files could cause downstream parsing failures or
> generate incorrect C code for runtime verification monitors.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Right, that slipped. Thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index 9e1c097ad0e4a..7841a6e70bad2 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -59,7 +59,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # checking the first lin=
e:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D dot_lines[curso=
r].split()
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (line[0] !=3D "digraph") a=
nd (line[1] !=3D "state_automaton"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (line[0] !=3D "digraph") o=
r (line[1] !=3D "state_automaton"):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
raise AutomataError(f"Not a valid .dot format:
> {self.__dot_path}")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cursor +=3D 1

