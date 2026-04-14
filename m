Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE331E82B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191758; cv=none; b=JcDk0xMY6Cr5jDPnLO9mTcDvs8dpGGW+8StyiG/kUNFL2Y74sDmAjVZkOlfv6IPwWsU2/WXvRHLMEUKIRISxWd0LUJ0k1ZctW2rizEYd2ClxRuZ7Mo6bWjsl5htUmuY3e8eNq16P7/u9U8XqncQ+9PRw5mBbme7enibt7NNHZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191758; c=relaxed/simple;
	bh=4uKTgMOmHlsR+e8TqtxTDuecI1rtiaGc6D1ySeWNnTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKGu3DwjgG8L/s7FsiZZu4WifTlZd5m0iIDuLKsxnkw0qCYgugwXh//3Glk63SdTPxxB5/QvdxukWKJk8+1+9qbvy4rJ92JKLw9I85zI0yyWIcVtwtU7DYwKK072KzCvFu8TXnDNkh/+LmNT8qX+R98q1AmyzDgbeeEem66dobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVw+15Yv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVw+15Yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776191756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uC1Vo5Pd77iZu5wFk9wyXLnn928QWwCwFFKMvCu6V14=;
	b=SVw+15YvGoE4UxPvTicfma421Jawv1HejIvF5pLgSw3dbW9kB+AtaP7gLoFByNwViQQp+7
	OErbpU1lsQiRMba1R3jVEsI9/chyGj6ktiQK5wxPiLeCjeFCwszULActpcVn1U9wxmMvS3
	W9lYAQJxOO01qWMOCr2rlQ06fbq2LCA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-O9y5SBPnNY6RsWL457_5uw-1; Tue, 14 Apr 2026 14:35:55 -0400
X-MC-Unique: O9y5SBPnNY6RsWL457_5uw-1
X-Mimecast-MFC-AGG-ID: O9y5SBPnNY6RsWL457_5uw_1776191755
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d5d03ae893so999420385a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 11:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776191755; x=1776796555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC1Vo5Pd77iZu5wFk9wyXLnn928QWwCwFFKMvCu6V14=;
        b=X9XHACzbZo6WxfidUKPEQQXRaGuwsBDR6QPmQHnoB0JDZ671j/5j/61Cea3Suow0IJ
         8gzhEnVvonx4MCfw5h2YgV7T2Fk+jVCrTSqQEfubwEmDQxRMg6V9QfHa80wKb180EP+w
         Mt11OupiQnitUw3vu8jzHCaSzZYTGzJKevrM/kMFd4vUGAxqcWZ8EVf42D8ZfCyujFnB
         3gM3Vr++MEtPRUqNxOm91n22Tg6Y0McCTqlXNVR6wpJ00pnVVER3LtnmcFFLN6dkjKAi
         tw0WSXmC7jGC9Ns02obBZpZwPPlViYQGDp6iwByBbeXrQpudVdzZOMe2GGD/5eolLOni
         PL5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yNF5CFThcGCRfUjJE0d/Mk82q3xFop3xZbQYOD3gBBKHOp7YS/oDWTkqIZ/id3yvGhz4+oHDf3J1FET6dVZa5Fwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9nxcav/PLe2HGF+wrQJmND4ji/XCQsG8DM3uanJRt35W7Mlh
	8ortJLTvT8c1cJXPNgbNXWZgIohT2KY2fooQN3O/Fxfv2WSRgsSoxvJN3aa2zjKwDrdld+p6hA4
	9Mcspv41fP3tat8R9WwMETCbp5IEgsZtoBotK5Amd/UfeZNBNibgoyo7SS83FgD+koNBos6mkug
	==
X-Gm-Gg: AeBDiesV4C3F/2z6CHF09XN6D4Vk8oWSnUYRFeJHujOSaXTpk4QefxQhVbacQcWf+Y1
	b1rk41QcucsfSHeBmLiTRFNcLbBRoy8ScN0n5uvG7OJjs/6dhZwOddueZQ8GKOubxfrZY0ttA07
	mfQ7AEyY04eHyWq7MuRmB9yqDNmXLNcbCpHDAGg9HxZ1yCTnZRrBIG1zfSgH2znpHZiYpzQK3XB
	kaj8975Cs5ozocTEH9sIQx9qPP/jTwNoXt+OrvgxbSkWfoJ0hTh5ZnoIS4roIZ80FhpSMkhypgz
	m6zIfYX+BLUpaeSC4CiJpwEo8+noK1qymYjREVEOQO7gTtLvWxcFPgAS1ESJXP5pmREkM+GsYon
	U5Ydvx30wIjY69/NSPeuT4+KJ8Lenar48ie/WKOPCxi71GBywfS93Qg==
X-Received: by 2002:a05:620a:7113:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8ddccb3040fmr2700053085a.3.1776191754621;
        Tue, 14 Apr 2026 11:35:54 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8ddccb3040fmr2700046185a.3.1776191754027;
        Tue, 14 Apr 2026 11:35:54 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb646d715sm1120511885a.15.2026.04.14.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:35:53 -0700 (PDT)
Message-ID: <1bc700d91efea3936bfebe77c058f3c402c16aa4.camel@redhat.com>
Subject: Re: [PATCH v2] tracing/osnoise: Add option to align tlat threads
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel	
 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 14 Apr 2026 13:35:52 -0500
In-Reply-To: <20260414080339.26193a6b@robin>
References: <20260302131316.385987-1-tglozar@redhat.com>
	 <20260414080339.26193a6b@robin>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SAkK_Vt5fkraQzb0QvN3mSHSNLxre09H2Z3o6f-sihQ_1776191755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-04-14 at 08:03 -0400, Steven Rostedt wrote:
> I noticed that I never ran this through my tests, and I just did now,
> and it failed with:
>=20
> /work/build/trace/nobackup/linux-test.git/kernel/trace/trace_osnoise.c: I=
n function =E2=80=98osnoise_workload_start=E2=80=99:
> /work/build/trace/nobackup/linux-test.git/kernel/trace/trace_osnoise.c:29=
29:23: error: =E2=80=98align_next=E2=80=99 undeclared (first use in this fu=
nction); did you mean =E2=80=98klist_next=E2=80=99?
>  2929 |         atomic64_set(&align_next, 0);
>       |                       ^~~~~~~~~~
>       |                       klist_next
> /work/build/trace/nobackup/linux-test.git/kernel/trace/trace_osnoise.c:29=
29:23: note: each undeclared identifier is reported only once for each func=
tion it appears in
>   CC [M]  drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.o
> make[5]: *** [/work/build/trace/nobackup/linux-test.git/scripts/Makefile.=
build:289: kernel/trace/trace_osnoise.o] Error 1
> make[5]: *** Waiting for unfinished jobs....

Looks like this should be moved into tlat_var_reset().


-Crystal

