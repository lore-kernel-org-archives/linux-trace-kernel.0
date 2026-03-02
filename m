Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB8430BAC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435413; cv=none; b=r2Tueuf5xuVaCU7aLePDIeRKEk733WZMFVs1C1hUwOEWtZ2ySfydrecgjhoDCZYCTXZsmvXXPgwLxVLmN1HcGH1FR9g2EL6TNaXHIv7Mis8BZAuOEfJqtmyc3VBcWOwhFwIrZZ95JDiz6+x90GluykR+XZTjptVspD/KTKMizYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435413; c=relaxed/simple;
	bh=rAv8x/Quxw6An78VFqe0xzDJu7gqUOMT6mqYbPE1pq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tz/PCJmCXIUthxB/J6cIuW81Uep3LlMojgkqNJ5IhBCI/YNbsvlrOt4w5YHDHsJ4UgEeEnYIaGKWMIF0YCUnemEsDndLgcdDE4EKrUgEcPj8BKQD/JawG9F+Wn4l5SweOGhLm+HKEZQSeZ8q2fbSDepft0fCqRwNWauvOaj6bjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPbAkAZ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPbAkAZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772435411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAv8x/Quxw6An78VFqe0xzDJu7gqUOMT6mqYbPE1pq8=;
	b=SPbAkAZ9DWbyQsVc1dAg6HXonFDE/o/TV6aH799eg3pD8FPWRnfho49ZKr0ZA25pMsRqaN
	4KdBVPQlkIWH9z9GD7182WIf/EGocv9vnV0S4kcK5Oq1TCNslRw4YMpBZgcYje+U3+U3pP
	CpRbh10uLfhcXfWc6+xwi/afyl5ZLsg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-61fa2fpgPfGd_0-blaYIDQ-1; Mon, 02 Mar 2026 02:10:10 -0500
X-MC-Unique: 61fa2fpgPfGd_0-blaYIDQ-1
X-Mimecast-MFC-AGG-ID: 61fa2fpgPfGd_0-blaYIDQ_1772435409
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8fbe7a6f41so367096466b.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 01 Mar 2026 23:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772435408; x=1773040208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rAv8x/Quxw6An78VFqe0xzDJu7gqUOMT6mqYbPE1pq8=;
        b=SVsQnF6Yixu2a2ZQilSoz2aehPk0mScX6QSBtFzPQHXxS5AQMqbkTuIwSBb0QpnauZ
         3GJm6g57VsscsiIC066ThXfiupTYIUA4Yp+5IoN7k+Fis31hZXXLef1HIUbetA/ohh68
         p+l2JLlvjj3sF0nABBWd3BGwnPTv2Yi0i1MeZingkHt7E/nS2yFx1NbhWFClJwhmb01H
         AGrCXu1lSScpbuf2Wzn0kfW9iA/U1JUkkI09fr5CVkXJFrMYn1MbSajT60X7wRT65i1q
         xCYN9zA8P7NGHqsLAFlwDObKEY56zlOkty4nXf8I+dguPWBmuDaKF+m0N7tBpCNgQ0LR
         bOxg==
X-Forwarded-Encrypted: i=1; AJvYcCUqPAFwefBNBrsRPu00YRSSeTGcGVIt2Cgqk/aFAI4/p0OaQOnbODgvj2OeuWoJ53f7uWBM3XZPwmq2Kp4jGLlvX8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVLVj6EyA6G5PN9JfrS0VHw4VY5HzSDj/upU2oBdRyfwv+rCJ
	L1zzNFefsgY74/hy/JrD28Eu9ascuFWFPVrEoFdzvDKowWF6r3Ua56UZeA4+9hVQM9vlSIFOJhq
	2F+VJxy2w2vc83wE5O8oHtkfzdb5b00TWHKlr35P96GS9bfijAoQoSEvhq3md5dlIQDh+dmPLHp
	N2yRqxrWPfkYIP7ebZR4T72kdNy9VloJkt8xpo6qVyM8CgYASE+pQZKEvr
X-Gm-Gg: ATEYQzzb3CKFNMOkmMsQAsxsECzGBSAZ9P16yRrfc0dsGKCcFkW1mhLEIPFT73A4e5n
	CsQLC9ppG1EoigbRpr7BTNnnNl6Q807akoMHOSZWHI1dT/+hGxRd3RQUU8FcByu6BE6YP+O8YzK
	jk5oUedC0ZsWH0WBSDbgT9XXZ/WZKXIlQ/s7K53HjejHd0OAq19jD+c5PjeVfZ0BI/ygBEEsyvi
	SDLvYEfjpvTvhZH+NDJ7AYNnWTE94p+7ZUq
X-Received: by 2002:a17:906:9f92:b0:b93:a3db:a6a7 with SMTP id a640c23a62f3a-b93a3dbae83mr288266566b.29.1772435408297;
        Sun, 01 Mar 2026 23:10:08 -0800 (PST)
X-Received: by 2002:a17:906:9f92:b0:b93:a3db:a6a7 with SMTP id
 a640c23a62f3a-b93a3dbae83mr288264766b.29.1772435407865; Sun, 01 Mar 2026
 23:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227150420.319528-1-tglozar@redhat.com> <20260227105207.01473471@gandalf.local.home>
In-Reply-To: <20260227105207.01473471@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Mar 2026 08:09:55 +0100
X-Gm-Features: AaiRm50nZ-I9_lppRsu59mWwh2rp3CzvxOmA9qVmD3NsqSP00FrckZvPswb5CZg
Message-ID: <CAP4=nvST48Z5npeCbitExWL0Cps+D-kzfRjWXUjg29o5BOPRAg@mail.gmail.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0v-m-gzFYUd6h5-ikl6m_E_3Ofh2eP_NgGmbMeKuQuc_1772435409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 27. 2. 2026 v 16:51 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
> > Example:
> >
> > osnoise/timerlat_period is set to 1000, osnoise/timerlat_align_us is
> > set to 50. There are four threads, on CPUs 1 to 4.
>
> Is it set to 50 or 20?
>

That is a typo, good catch.

>
> So the first one here sets 'align_next' and all others fall into this pat=
h.
>
> As 'align_next' is a static variable for this function, what happens if y=
ou
> run timerlat a second time with different values?
>

That is an oversight. It worked during my testing, since timerlat took
the align_next of the previous run, and since it was far in the past,
it incremented it to be in the future, and everything worked. But that
is not the intended behavior (and will be slow if a lot of time passes
between the timerlat runs, since we increment it multiple times by the
period)

It should be a global variable reset with each run. I got too excited
about the patch and forgot this is not RTLA where static variables get
reset with each run (unless I want the user to reboot after each run).
I will fix it.

Tomas

