Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CB28695
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897348; cv=none; b=hWPImFrorJ9agXD70R0WRTmvJupWH9nY4ZKWaBSPj19fqJNGNIw6pnM4crGtxSXR96DJjJWQceVdEvgBv1jpuv0rSknXFJSM0mQsHwgp2a2aEFyb/0lqHA9z/3uE5YERv6cMPVPIoAdSb4qgMZQR1owT8gPAJse6cKx/VLWj0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897348; c=relaxed/simple;
	bh=lJwDIPedNt2Z2UuEAHlq/adYCAGq6z1uz2X0ECUEVoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4dNMyPmwPEok0WwRS0fVeYi1wqBqri79rZ/zd94e0vOF8HDCseSNA2azKRAc74mEh79uO2UBaKO+vOGrodAwpK2xaSUPxH95l5PDyMV0pJjtlX3w6dlJdUlb2d7NiOCYeY4leBEOKSHTVBezeHMVvQez5ex9d3MoKQIxA5k0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlOF7mj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlOF7mj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLc193AFL/MGGHYspsBSJzTzaApnYYVdoylqhmtfcXQ=;
	b=OlOF7mj9ay5haQjfKvWU3ctUTzZaVmHEx5xI7e41w1DWGn3vPFlarbALNFChsNZ1t+ao4b
	ZZH7WZPNl1+Vbt/tEVrq2vaGwtOGSrf1784gpNedc0e6Y7s3lDP+6B3WVSBdfXRRAAXfl2
	lAzhmal5/jKR5RhRH+nZcymDMmh4x1k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Ekd5LtwLMk6cyVfxbrtgug-1; Fri, 26 Sep 2025 10:35:45 -0400
X-MC-Unique: Ekd5LtwLMk6cyVfxbrtgug-1
X-Mimecast-MFC-AGG-ID: Ekd5LtwLMk6cyVfxbrtgug_1758897344
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aff0df4c4abso257443866b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897344; x=1759502144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLc193AFL/MGGHYspsBSJzTzaApnYYVdoylqhmtfcXQ=;
        b=aHhSF9OrrZve7wqvvurZP2s7Ou02EFAQbpIOjphRkcgr9UKc4te6cNVXvB6p5FvV/v
         ySCwvDXAYVYwoW7mZTpRkTHVMmwr2lH0PkE9KWWA2EYZMdCxeH9fPaFQ/wMZK6bxDKvA
         rI/bPahsDUb8gYCyTIKEMkgNXEGFm/bscUk8jdKYqNcyN5S/2P09Vhi9t+w4R5bi2iY0
         qNnIKogSBkqfNud7N9cMMqHmJD4FRAI80I7jPPUpX0ieX4lGnSURA5ALKKokV9xGo4+Q
         ioA9nfbIvg/xb/hVMKr8dT/ia9btDLe4ruyoCJDRTQUJCK5oOcwKReNUxQqLP/F4/7KZ
         LENg==
X-Forwarded-Encrypted: i=1; AJvYcCWjf0CFlkQpattwOlfCjT+ZCoKvpO+3ZPMx/0ap1fvtEYKlyCr7AuQhi9wkwxeaEBVjHn43Nm5HPN94N/o0S4djU1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLfV6ZhtWuF4KWBi1AT7ZyyePor1qHS5mvcQxHm/ebeLhAfuq
	iJ0YnngmOOQ77KCTT51etdZlPYJ5xBm4s6OATgSRz6CYdZZKjNfDePPJ78bxtxRrLsXMG9cXVsE
	J4qfw8e8xeolj9qXO5HW8eMRrD5sioYUJ9xxl2uRCZot7lzjITzYJotgXiYbtAU+imXK8xbBRSs
	xHOELPUCq4yU4NOQTAqkUUhJi80h2uDOUGYSv6kGTtv8rkpD8T
X-Gm-Gg: ASbGncuhwW8T3MYIkEFIUHLhf8YQLSYi/R0P0klGFaEiB5JEhjKSASXHO8v4KezhMaU
	Wc4MRDe65c6YLEuJwfjzPfQpwRaBmSKxMYO0wR/fjlPnjjrHGLU2umRZ0ciXbYSwAupz1MDby0j
	BpOmDH5V3/Wc/3NpJclsEI
X-Received: by 2002:a17:907:c26:b0:b04:83af:b4ba with SMTP id a640c23a62f3a-b34be1065cdmr771299266b.52.1758897343782;
        Fri, 26 Sep 2025 07:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY/LqSurKjD4+Cltq9ZQJvKAnaky4bgALTiesjZyT2D53LoboMYhtdlyD8b25uhjT6K30D/Mn0/Fsum4Z49gw=
X-Received: by 2002:a17:907:c26:b0:b04:83af:b4ba with SMTP id
 a640c23a62f3a-b34be1065cdmr771295766b.52.1758897343356; Fri, 26 Sep 2025
 07:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915181101.52513-1-wander@redhat.com>
In-Reply-To: <20250915181101.52513-1-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 16:35:30 +0200
X-Gm-Features: AS18NWAh78RyB8X-IxL_YWJcf8fkp9YQu65AKBmgUXIOMx5d7V4hfI5CJPXQJ7U
Message-ID: <CAP4=nvRbfiMyRJYxMk_4emWw_JuZVAkAjfX+j7S0Cxi_OGoS0g@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vUgVbJvhFLu8ziJnoOrmCOwGUl9nloG9JdE0epniHGY_1758897344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven,

po 15. 9. 2025 v 20:11 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The condition to check if the actions buffer needs to be resized was
> incorrect. The check `self->size >=3D self->len` would evaluate to
> true on almost every call to `actions_new()`, causing the buffer to
> be reallocated unnecessarily each time an action was added.
>
> Fix the condition to `self->len >=3D self.size`, ensuring
> that the buffer is only resized when it is actually full.
>
> Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> ---
> v1 -> v2
> * Put the commit message in imperative language
>
> ---
>  tools/tracing/rtla/src/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Can you take this fix as well?

Thank you.

Tomas

PS: This should be all for RTLA now.

