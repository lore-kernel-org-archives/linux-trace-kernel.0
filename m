Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9E3FE654
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363061; cv=none; b=ntAYyIj7gG3J6oLvWaWlufXTMPfKm//+Zr0YsN65H3r80lKW3rXlrbw7Vgg82FNgrLt3sKpPiYVmAlhSqSnnF2n4EpET9OzHtrA8RsptwGhMdags29yBJ/t9/kvE9wjo5nDXRyutvAFepk0DwdxIU6XzTJ+2AgMk95gGSZSeWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363061; c=relaxed/simple;
	bh=699+EuYTfOGm09dvRxxzgvX6V6xefV/3IhbRev+YX0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOBXl5SHYeL1QYiIu1eLiqruimR/toEHYXVALGnkO4DEHYYp7Dm3LvPewrqhJ4xOn/18nRkhDM7cHQxxY7dleDRbzcsUZQl+LjqVOxh0c+7DLlIEF8C2nxOxVreAXT2dv4zFvCrQrjRQYeJwbNUEWQ/zloVcTHUggZOfcDLZOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hqa+8wI1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqa+8wI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774363059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
	b=Hqa+8wI1mOn0RytKf/RGxTtTkIYlwWiPLBXtZl2K9P9MIov7sloAIifr/+S33NKl8ur0kS
	oIlCcqqm+KKoyyOaz2nvGgoxIvlM5pttoBiL6PnKbalGCYTKLz00z2iA4hTMbs6ahqkmIL
	OIsk3YtRlLVZFWYdtMWm8DNWdDJ55iE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-kBBaSpLmNDSgolnls1iaqw-1; Tue, 24 Mar 2026 10:37:38 -0400
X-MC-Unique: kBBaSpLmNDSgolnls1iaqw-1
X-Mimecast-MFC-AGG-ID: kBBaSpLmNDSgolnls1iaqw_1774363057
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b979930aafeso415709866b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 07:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363057; x=1774967857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
        b=mOpWj83O0WAPG1EE9SPg/6oOGUxs/bUYM2kF5ett2hbBpbByDZP3Ghg5fTDaTseAvt
         5alyNmNQqqxs9AO2yIfb03ECPtZQstRJLhZEEX8UsvIY/cGJeGgt9c1eN7zv4u51oMVj
         nBlqPsHA+O6hKtkggJ5uqmx4BY18OWLgCfflj//1lAJW+OmAGtesartYzTiWKWPo1So7
         XzbRH5w1GN15+3NilGyneQXBD98OdREwebHWbyBU2RaJ8Yc5rolc1/21nSOqMOkI9ObJ
         UQ8VIzBUiLfay0S8pOSLIRStCNoO8cQIcoavozD5yL6QEsZb8DQUQeMlplAJJU9HKmLx
         rOHg==
X-Forwarded-Encrypted: i=1; AJvYcCWHOH9rSsQnLRrzjOEU0O6x6zmwcmC+90opWABOJhC8CjmSfgBDtrQa6XgQk89pPrLKh6GVI7gi+Q96pLob1IT4m1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRImkeULc4edy8V4ZiMaPSySP8CbXYGjIYpAuqR/8jf3qmWxQB
	0/fYe+TvpYuN33qx44qhXBgo4ZY1ferU5P0jTWlubbRx5QeBr0/hi5MhSySIrTEHuFBtaAefcEE
	UtdHfQ9hPLfGpUNwjelSvQC59Fq5o/Mbr29oh/cilFFWIXURVe+wHTuVKBOppnhIQF6ppb/b70i
	GUt/wixI427AITzIzzyb20mDemGKfHcVc2U/fssKKA0/Zq3o52
X-Gm-Gg: ATEYQzxX5evLGWGdrP71ALlTp5M44tte2bNag/5kwEQJ2AnZBnW0srL1LaoUpfQibRF
	XnYxjIPrkSSei9bjxMleUVb4I3y6zpt+UUOcFf+WGca0NrITcF5K2xVjK1eGrDiIuBrV8bVqDh2
	UVPjzM7nHFr8tpuXfGDW9vPQlx98sEQFzuzXlzWN1rmOPs+9g71m4z8AC0l3ynGzQjK7kc398ta
	bmgcQ==
X-Received: by 2002:a17:907:a0d5:b0:b97:a4bf:d184 with SMTP id a640c23a62f3a-b982f21d39fmr1127229166b.1.1774363056685;
        Tue, 24 Mar 2026 07:37:36 -0700 (PDT)
X-Received: by 2002:a17:907:a0d5:b0:b97:a4bf:d184 with SMTP id
 a640c23a62f3a-b982f21d39fmr1127225666b.1.1774363056116; Tue, 24 Mar 2026
 07:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com> <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
In-Reply-To: <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 24 Mar 2026 15:37:23 +0100
X-Gm-Features: AaiRm528YmqufVfzflCbFXRp_BZEkBFumbc6jhPk-OsU1m9G19dp5RLFmh0vY18
Message-ID: <CAP4=nvQDpfh5J6OF7U63UD46BsvKPSQS+_FxHuFPbnCsC-sDQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LCfUzj4KgPstkSs1mqmvJ6N-pFmP3EwqmQWSjv-n6Aw_1774363057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 23. 3. 2026 v 15:26 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> na=
psal:
> > --no-irq clashes with auto-negation of --irq
> >
> >  File: src/cli.c:1042
> >  Cause: libsubcmd auto-generates --no-X negations for every option.
> > --no-irq (histogram boolean) collides with the auto-negation of --irq
> > (stop threshold). The first match wins, so --irq was matched first and
> > its negation intercepted the call.
> >  Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
> > the options array so the explicit --no-irq boolean is found first.
> >
> ...
> Reshuffling the RTLA option array could work, too, but is
> unintuitive from the developer's point of view, and will also force
> histogram options to be before threshold options in the help message,
> which is not what I wanted.
>

Actually, it doesn't. Just as defining --irq implicitly defines
--no-irq, defining --no-irq implicitly defines --irq, so the long
option --irq stops working when putting HIST_OPT_NO_IRQ before
RTLA_OPT_STOP('i', "irq", "irq latency").

So the only solution appears to be to add a flag to libsubcmd that can
disable this behavior (auto-parsing the counterpart of --opt/--no-opt)
in a new patch in v2. Since this patchset already has a change to
libsubcmd and CC to linux-perf-users, that should work.

Tomas

