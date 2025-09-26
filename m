Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A04C8FE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897189; cv=none; b=lbsYqkGnMeJjGa00lSYBEtrmpLChT5WT3iVHs7TRBom/TyJ5W7lBs9sA2ku8KdEltYCmS9AxBgWCe0SoyPeZEEBSRgNKwbE1cKJ+LtQ78Exnk5wmwoUa/NlRk6tDef3r7QQTwnl0rq8HSyQcH075wfAHQmxwsmFbjRDUIPIRm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897189; c=relaxed/simple;
	bh=zyzn3ZcezAK9aa7VZIAtRCcKzdP/B8eYrPAfL36Gs6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjmE5f//7OcSAj129o00NvwGeWO7ppGU8JFpGM0zTrcbRzgdvtw6qCSZRh1lWhmAyqlNpBVnnK5dF+Srt5lbqI/5awasienjOuv1CjrkH50N8iql2vC8iI2yl3jRdk8oPCkqqjHZif2m+NWb4uwakMMTjlKj56GjZIL5L0pZv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USA+vZf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USA+vZf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOJaLah4ePiQxdQez6Be1i94MUmLOsj+O0iioPNAuew=;
	b=USA+vZf2QMK2pDvamwg5VB3hN6qEm+HBp6Qo3+puUCvUmKTr3kJKD6rdj7Tco+E7cwIURh
	4dU4/moVACg8xUmjivu1WnwYT1VftFmEbZQlRl3bcILDT41CxeqEVpOTbZwZQe0iGJ/c0U
	o6Mv1kHHXYkeluES2JX+Ud5+bNRinl0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-lMXNMARdOb6LtdcQOCBL8g-1; Fri, 26 Sep 2025 10:33:05 -0400
X-MC-Unique: lMXNMARdOb6LtdcQOCBL8g-1
X-Mimecast-MFC-AGG-ID: lMXNMARdOb6LtdcQOCBL8g_1758897184
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2f989de76eso416333866b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897184; x=1759501984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOJaLah4ePiQxdQez6Be1i94MUmLOsj+O0iioPNAuew=;
        b=wFQpgJoKRbS7wikPt6+1UYJgygfRqTyyI44r/UcBBnl75JdSeHoArQB0S2qGgDDJ5o
         SHC63MaWGT1OFODtcoEKRZxLzW/Yk298yurs56JGAor0IrzYDTi+mG6uQCwKY3FuugvJ
         0capC0HxQytjA/zP7Z/i0Q926EZppBj8ms1Hvznbz9fawO0CaQxlXAyXhf6Cb76C6XyA
         LvhRv7WUJflWthfeXmXI9BfxR2f1WtzlgZqI6zrHG4SYQih4/BypcnG5mD87BXV1lzUi
         qnIJuv4pxrPG4vKoabzQDnYEItlhtxcYCS+IU1R5rSqR59tFDnbgXmW+PsFAI+vu0R3L
         NWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtm69V+S5elu+bk6QkxWQAcsRrAyTLPLv7xw84Zv/6Ci7GcAXO6w0MN3M6/f/dFrMpjok09kMUgu/P8bdX/l+FXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQ5Yf5yN9nXPp4ZQsSxsNiVrfn+vrv6zmS3x/zV3QKjLMzKwf
	esK8o0zcq1FQiCCm3XxdVj5lEdVUYx6+YUQVp2wjpr0EtoLkBN7ZtmO+p3ykAX0/nS48rZQboXL
	EYQe4oQbQO4rZqbDM0m9u7bhxdomnc8xnjNof4bi+0UjNPyuq5FcUKW9UogxHiNN9LwY4HNuPkt
	Vqq20X8fnyLwqsv/jw2PWiZfcF1ptg7W8P6RNRssGEEA3Ltep6
X-Gm-Gg: ASbGncs/VPjQ/pBQu5qKZAfCa2CZyX6a5gtM9ms/oa5AVIzR3qTbgrvRV6lXc1MU+I+
	8IF08vYSZSBzGCWam+EvZg/OREvmuMf7uvOwA7xNDYnw2YnFRzabax2DT4irYapqljLFDJJWEE2
	TaxXCsUSRZKJUq+zuEaQcm
X-Received: by 2002:a17:907:93c7:b0:b07:e348:8278 with SMTP id a640c23a62f3a-b354d73f016mr505472966b.25.1758897183984;
        Fri, 26 Sep 2025 07:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo+itkF3w4Rk3YxWgiaRXreqg0X/y6Z1uD9ARYPdkidf9i+Pmr8YhdRDy8sGsq6sp96MKGBRKUhp9lPqQJf8=
X-Received: by 2002:a17:907:93c7:b0:b07:e348:8278 with SMTP id
 a640c23a62f3a-b354d73f016mr505471066b.25.1758897183586; Fri, 26 Sep 2025
 07:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 16:32:52 +0200
X-Gm-Features: AS18NWCTGFAnet0Nl0vdl1CmepDisUb588HKCFc7aZTYKNqaEC4lLhouSKrNNuM
Message-ID: <CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rtla: fix buffer overflow in actions_parse
To: rostedt@goodmis.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _mmE6zbVi8Y6_PINO6fQJ_naNpQAhBB2ZCP6sxhYQ9E_1758897184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven,

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:
>
>     *** buffer overflow detected ***: terminated
>     timeout: the monitored command dumped core
>
> The result of running `sudo make check` is
>
>     tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
>       Failed tests:  3, 13-22
>     Files=3D3, Tests=3D34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.6=
3 cusr
>     27.96 csys =3D 55.67 CPU)
>     Result: FAIL
>
> Fix buffer overflow in actions_parse to avoid this error. After this
> change, the tests results are
>
>     tests/hwnoise.t ... ok
>     tests/osnoise.t ... ok
>     tests/timerlat.t .. ok
>     All tests successful.
>     Files=3D3, Tests=3D34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.1=
0 cusr
>     44.38 csys =3D 85.55 CPU)
>     Result: PASS
>
> Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> Reviewed-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Could you take this simple fix? (Might require tweaking the starting
letter "fix" -> "Fix", I don't care that much about it, but as you
said, tracing requires capital letters there :) )

The rest of the patchset conflicts with [1] but this one doesn't and
is also more important.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=3D=
999703

Tomas

