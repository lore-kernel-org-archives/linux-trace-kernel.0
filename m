Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7873EEAE7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672056; cv=none; b=MADc0I1gKcrRBFPWfdPutOmA7GpGe/ifU8XP6r8WQV1qpRhFPtiK0+HNAL4330mydh6iM6yM9wUXv+WhcONkMqc76/XvZ/sQmD3y8pBBt57Oa0xmzXeE/xTroVrSkBtCpq4r0ghBdyauF8itgbbeLoOd99JWsKK6WA5qQRNflt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672056; c=relaxed/simple;
	bh=pYMzxbyGyzWckbiMue0GV7xGpiPYFW4FX+uY6ZfgX+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFDc0H9pOENaRB0HXubqnh6UyE+2IUGMV/8UyF4TizLZ7tnCg0CROiirgCyyH0J3nN4J/7tXu3fauXOOLQDJYH4E1Dg7j+UffkVTIIfMPDQ++vimMNtQhO05UnhjCXDxkQQcIzfgccxDoyplNiOIlWgslYndhG5KtBKg4ymCbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4tW1bUj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4tW1bUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783672054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pYMzxbyGyzWckbiMue0GV7xGpiPYFW4FX+uY6ZfgX+E=;
	b=J4tW1bUjNwC4KioH3cBTI9Q4WHTTMl1SLTSIedkVf4V+mcz9gMMNTFtrP6fF/fBRnXDBxP
	d3H82Ynmz3Ec9ikneyS79QLHdJ4CnYJlk4T2wQyVXcLDN7BBKWblDom/onjTR2x7tbWJgw
	13rfcSTMwizJ+aZlve28DfB9L22bil0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-gZgJAWIHO5aR2MsEbFvaRA-1; Fri, 10 Jul 2026 04:27:33 -0400
X-MC-Unique: gZgJAWIHO5aR2MsEbFvaRA-1
X-Mimecast-MFC-AGG-ID: gZgJAWIHO5aR2MsEbFvaRA_1783672052
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so3370155e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 01:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672052; x=1784276852;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pYMzxbyGyzWckbiMue0GV7xGpiPYFW4FX+uY6ZfgX+E=;
        b=NYRwbtQSN+OVmIV1l4hPDKNDQaiUWoiDMTL1Yoqnf5bL8QBVjWGk9gRWvVB0OTw4NO
         Q7qf1cSYQVd798+vSciXyPMJ+x25oazsukysgIXHYn+xBtYQYmjKzNSdofZT+3wCOKQm
         8n1LtxGDOjbQSOYet8m8Iz8LT4p8rsmCM9NxPr99Y/zVgO+KVg0yk9LNpPWtqYia91OI
         lXyiE/p5H/3Us5suchH34kfzx1jhpvFtVsokhML1zq0bqLpyGyLBG4I6dZYkDasaGWyW
         /Rw3cwhK6N1VFayg/4M60Tw7urKDG+00SadU3IERlORTIbo4obrSbg/d0jIPOkDB2Ccy
         wVFg==
X-Forwarded-Encrypted: i=1; AHgh+RpDv2EsMBM+K8N6AexHrGETZFa027j7LTv6g9hjY6QmSg09p4DNc6xN8rgV58yNVT2Z19e8ZW4F4uBKd1OfzXew9r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZzleVys49gnEcGIoVq3kcj2pLD4nifjB+t+xcCD6Zr7ydFvp
	r0eelGZzIKhp7HFmIF28MG/l1r6q9BxfF6Og5Do4nZYkkWtDQQTGKG+CuBGPhinbwnpCSZXyfjN
	MKDwYG8Uhhm/FC5lRw9niAmiveo2GU/PWbbTWmUFRClng18TWYlQcXV6ijolbDq2ysxfZ7kSxhg
	==
X-Gm-Gg: AfdE7ckA+xvc5Ti/UCPCv0RVq+SS6+HpRFIwLj0sgGo2hPwbitwLyiEdvnRZoJ7Jl3y
	+xKPgg/qA7BQmWlXDRfrZXrYj7cTxshUTZsG/cb4wrYARpHn0snuRcb7jFPW2Gsrzgw48StdxAs
	U8olTOJYSAO2Ymbvi3cAnN8q3nOP5t3S56eoYN7mJdD1eIIYuxqIqqpKIOK4ZijDLRoNGGPix4P
	ecZuxr95VBciB7I6a9/7zISLkWAtzDjNcAkptO4Ingq9tZPX/mMbHq+MLvpAF3+nLP+tCwGDgba
	UYom1gWgx+7dLZ5NBOQ5LMjTkeLJ5SJrdFR7CrYJXv1aJ9sdOicTLSEtRkar+1yqVAo+OUb96Vr
	y6LyJtcZU61OZ4VLgr3MXqN3hd2yvwmxhZRDi6oS3NKQN6a4av40vILE42kzR7UVlgm1dDw7oT1
	bfZVK6
X-Received: by 2002:a05:600c:4753:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493e6892718mr104680665e9.22.1783672051615;
        Fri, 10 Jul 2026 01:27:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4753:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493e6892718mr104680405e9.22.1783672051181;
        Fri, 10 Jul 2026 01:27:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm58176872f8f.13.2026.07.10.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:27:30 -0700 (PDT)
Message-ID: <0bc975ab8f3f7cf411ac0a5fa1c79d382827cdac.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 10 Jul 2026 10:27:28 +0200
In-Reply-To: <18dcc24d-329e-43f4-bc69-e368c1f1d066@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
	 <c8c7568dd9293b0a718584c1aa193692c128d77d.camel@redhat.com>
	 <18dcc24d-329e-43f4-bc69-e368c1f1d066@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSV9BQogz7GjDiVapd9zfIvtgmULqRVj_ZTWNR2JSMU_1783672052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-10 at 00:46 +0800, Wen Yang wrote:
> Since rv_panic_reaction calls vpanic() which is __noreturn, direct=20
> testing is not feasible in KUnit.
>=20
> A preparatory v2 drops reactor_printk_kunit.c and reactor_panic_kunit.c
> entirely, replacing them with a single rv_reactors_kunit.c containing
> two suites:
>=20
> =C2=A0=C2=A0 rv_reactor_registration: register/unregister lifecycle, dupl=
icate
> =C2=A0=C2=A0=C2=A0=C2=A0 rejection (-EINVAL), name-too-long rejection, an=
d safe unregister
> =C2=A0=C2=A0=C2=A0=C2=A0 of a never-registered reactor.
>=20
> =C2=A0=C2=A0 rv_react_dispatch: null-callback guard, callback invocation =
check,
> =C2=A0=C2=A0=C2=A0=C2=A0 and the mdelay lockdep stress test.
>=20
>=20
> v2 also adds EXPORT_SYMBOL_GPL for rv_react(), rv_register_reactor(),=20
> and rv_unregister_reactor(), and the Kconfig entry is tristate.

Alright, sounds good.

> Additional fix: rv_unregister_reactor()
>=20
> Testing exposed a real bug: rv_unregister_reactor() called list_del()
> unconditionally.=C2=A0 On a never-registered reactor the list_head is
> zero-initialised, so list_del() dereferences NULL->prev and crashes.
> v2 adds a patch that iterates rv_reactors_list first and only calls
> list_del() when the reactor is found.=C2=A0 test_unregister_nonexistent
> documents and guards this behaviour.

Mmh, besides unit testing, when can we even see a reactor unregistration be=
fore
it's ever registered? Do we really need to actively guard against this?

What is probably an issue is to call unregistration also if registration fa=
iled
in reactors (which would cause the /bug/ you see, but shouldn't happen on
current reactors anyway), we can fix that.

I wouldn't guard against an issue that can only be triggered by broken code=
.
What am I missing?

Thanks,
Gabriele

