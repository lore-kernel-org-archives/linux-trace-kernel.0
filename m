Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B663F9F50
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107524; cv=none; b=YXBADAp7mW6AchgGne6iYd06BuzRT6xSzcSf76ipAdiGjNZ/MIqlxYc9P/d924KE7gly/uTFA2g7aLyz29aYdqu6GbHwnJFrmynthKU2Ngl1B5Ott/Jp1zGc6tfyaZJwCe2BobmCROOsUzyD4oJuR5jT4SIZ4iN3cnlnfYNshmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107524; c=relaxed/simple;
	bh=u4v43/Sd36brNlwbrbJ/ls1718vshZGyGcvjaF/4pqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDX3FESseoQOxhXahOUl6GaK2eyATGEYPwdlZIOgdTy4bb8AmmjSQKsmQbVJ55e5S0XqayI0w0tU3bm3Yq+wIs9BDzXdU+yosCMzdqNB/WbYCMgT/tRmoQDYUrt66V1m6iBzrT44F0cHEKBv388IE5nYLKlplkdcEfMzECSGoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnmPJe9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnmPJe9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784107521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u4v43/Sd36brNlwbrbJ/ls1718vshZGyGcvjaF/4pqo=;
	b=CnmPJe9PSlOVBULiaR95cDgpeBqWW6ApljAqwzuQ/k5dtnulAccBpamvQ/AM7AjuTHSB9a
	5bYiZ4kX41P3ErxjUWgC+LPITGyUez5xjPi9AS5i9yBj11oseSLEkiMkMALSJh7LO2lfA7
	LvYpk0D4AzSqh0LmZd+wdeWpRR1bNHo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ONrSiPMoNc6Yy7e1V8us5g-1; Wed, 15 Jul 2026 05:25:10 -0400
X-MC-Unique: ONrSiPMoNc6Yy7e1V8us5g-1
X-Mimecast-MFC-AGG-ID: ONrSiPMoNc6Yy7e1V8us5g_1784107509
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f0aea084so305147066b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 02:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784107509; x=1784712309;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u4v43/Sd36brNlwbrbJ/ls1718vshZGyGcvjaF/4pqo=;
        b=Vd9H+B4cqAm520CMP8Xt6K+6gjJL78mF0KRAfHJFt6tTJrXN37mwv0AuEmlanVaPY1
         6+RMfhyTPAEmKBsBuaw9V+YnYNS5Z4la1/CmRGGMpj47dEU573q7lx+JMZH7d6l+/TJt
         B/px6qhUoNPBjwzVqUPtRwGglBjNaRmW+p/hCoBUAXkLWlKrii0+nyQ9DqyZKdfvyIqD
         b3AYRfWNsgojSel4UOrZN1XPkb3iVpYmFZlWY51Pp9vUDrdRGUmdaLhbfndIZ/Wk4zaj
         utu47a22G3oyv76dbuXkO9nktQeMGQX+3E5zJsNUYE92a4843wn6r7HyoSPk6RLE5srP
         DDug==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Vlvp0tFj1Yh5NHUKPGCBYARryzmATKjeKWtg7qDePBmJWqLvaMK9CPcJWo+p7bmJdyEUWYBmL7UB8VafjdxiM6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNauCtMeq3YeQdMzArYUWJfWzkOWEGbpv5GGnUL6yzoLUQB2M
	jNiySlck2UxCgEpNMMwMiBGM3yM/LxhsYGS86UDB6uSpdnmb+KT8oPbwEn5fysktI4SfZekng/p
	gCuEsQoXcGOr2cjfIx+GqX0uddEWtyzoGBZw1F1uphfv4V4EyC8LkyrJePtFFz5ZFWr34P15lMV
	K0KqfX/QcC
X-Gm-Gg: AfdE7cncyJO0l4dT6U9iqUafU1xp39WZHpUWlHmTPfZ3q5rtMx+ADTe6DKxg49jYWlL
	HNyzKDNOqf5nAHM1ncIM1crobN6SFo2UVGwktr6uzP76k4IBEZwCn3fEk4+DDjnUsX+8jcL+qYV
	hLuTG0tSWRuF+GCNva6uuBzUIB1ITeDDT04dw6bCB1VQzTsft2nep8txDEBV1CCsRVoXlpiyGBO
	GA5d6BeQvVVlvFL3FK4seyiCS3ju1Ob5tx1F9Vid36Ms5LimeiTSjR8MypOMu7jJJkeb849oqfM
	UowpllPXc9CF1H2zKDVMBJHudC4t5dKooYBqLNMt7yTUGxqJsYlOK+nCymfpdxO8mmMMeGIJ0yd
	Bs4ae5OyLrl1obLfYIAmHRcfStvBrz3GJlnFCvUV/hX8Xzd9j8nxPq3NATOj3E1TQqnXGR7vSvO
	0fNf1/
X-Received: by 2002:a17:907:3e95:b0:c16:55e0:adaa with SMTP id a640c23a62f3a-c16794b68c9mr127733666b.58.1784107508935;
        Wed, 15 Jul 2026 02:25:08 -0700 (PDT)
X-Received: by 2002:a17:907:3e95:b0:c16:55e0:adaa with SMTP id a640c23a62f3a-c16794b68c9mr127730866b.58.1784107508348;
        Wed, 15 Jul 2026 02:25:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd293be91sm2643190a12.23.2026.07.15.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:25:07 -0700 (PDT)
Message-ID: <4885b2132ca1e8ed0fd6010ef9506d6e99e58fdb.camel@redhat.com>
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen
 kunit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh
	 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 15 Jul 2026 11:25:06 +0200
In-Reply-To: <a20ddbab-aebe-4f2c-9d07-ec8dee588eab@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-15-gmonaco@redhat.com>
	 <53f2d13c-cc1d-48fd-95f0-2c1ff1edfc88@linux.dev>
	 <ed538f5f3a0976ea8a0be66b20a446442f7260c1.camel@redhat.com>
	 <a20ddbab-aebe-4f2c-9d07-ec8dee588eab@linux.dev>
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
X-Mimecast-MFC-PROC-ID: O16PeoPmrKJWf-Ef9eSYGQzOa9v5FVeZldVvxlQfOvs_1784107509
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 01:49 +0800, Wen Yang wrote:
>=20
> Note that the same typo (handle_sample_event) appears in the other two
> LTL golden files added in patch 05/17 as well: ltl_pertask.c and
> test_ltl.c. The root is likely in the rvgen LTL template itself, so
> the fix there would regenerate all three consistently.

Yeah that's trivial to fix.

> Understood on the intent. One small concern:=C2=A0 MODULE_AUTHOR(/* TODO =
*/)
> is subtly different from an XXX comment =E2=80=94 a C preprocessor strips=
 the
> comment before macro expansion, leaving=C2=A0 MODULE_AUTHOR() with an emp=
ty
> argument. When the user does go to compile, they get a cryptic error
> rather than a clear "fill this in" hint.

Well, I believe a compiler failure was indeed the original intent (that's k=
inda
what we do in rv_attach_trace_probe), to avoid unauthored monitors.

Anyway an unauthored monitor isn't as bad as a missing tracepoint, so proba=
bly I
could make the LTL template consistent with the others.

Unless Nam has concerns with that.

Thanks,
Gabriele

