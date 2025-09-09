Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757222F5E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417153; cv=none; b=COqoj8oQaARgCLlybxGDCic6h90/YjDhlop9zV1EAoVv1Rxq3ATDsyqh2HYmgqKWOufX3b08vm8/Y8imFKx8k3CQof0Q7DgJRoB01VokahtgVGDpcqotm7dBRn9eiaFojLcUQAsiKnw20OypOjum4j4vu9h7WrCViHeewwqo65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417153; c=relaxed/simple;
	bh=Q9FbQUZ5URjqQVVOu1N6zHK7KaHfVu166G0k+3m1kn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK5NHkdsxH1kulXW4lYHnyYdaN2idhImGkfnLAd3gcEMqolWJS7mTzGaUkYFpo/0YdZgSVsWv6tI0DzkqQTWfzmgKDrQbUCl0a+rteurEhQXTikMGFrIX65inBQLoR9jdtQv363A6CYwA4KIdZnMhjvTD6kjnZVUcRru1dJoX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSYmbjQI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSYmbjQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757417150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67kLMlzJHu1zizON4sZWeLtQA79a0BMr9YCFQKhVd+0=;
	b=HSYmbjQIDo3mYGNEI76p8otC3X0HatVZAzSgM/E6umCVQnJdSwdGtD9quKiqXsgTUPxHb6
	ihM3WB+MteuQg3kMZ6cX1Gk/cGBZ54ENn7mS9ek1nirEr2MHugShWLKKmNFiXjeJbTG2Sn
	K4TamSppZVmYzGfD9bOuazcx6lCOYXg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kY4gBH2hNM2KMEfUqTeowA-1; Tue, 09 Sep 2025 07:25:49 -0400
X-MC-Unique: kY4gBH2hNM2KMEfUqTeowA-1
X-Mimecast-MFC-AGG-ID: kY4gBH2hNM2KMEfUqTeowA_1757417148
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b042eb3ac03so485502466b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417148; x=1758021948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67kLMlzJHu1zizON4sZWeLtQA79a0BMr9YCFQKhVd+0=;
        b=CNrI6MTokYTL878HlXxBxJOJ+3mC9BKFwOrUHfrDMjBtyZKQAdi0kOGE320/De0oZn
         OPXl9TgYhvIsx0nGTR5+YIzABOYH9DmGsQTr6unIF2ZanQS6Gc++EdqP21SfCIDflVET
         XTJ2z4YUl9rY4yczXoDKN5Oj5D+iAoviJHWG4PUHMH+4P4rV/x+T7AqcEHhuQM4vsKKl
         XW+pozt2J9R/ZVv6L0REpgGMnMT5V2N0D0XabbxsyAuDQ1MKbtzfUit/aZ4/EBZivnr2
         L15JrhcjDSV2R3Ud47d6e/1g8/PXfPxngDNxnYLzfzCwD5s2Mcr9yaUwMekuk3WMq53Y
         IMcA==
X-Forwarded-Encrypted: i=1; AJvYcCU8i3ajz7nK+j/j8mnMOzj89jRTgXCU3J0eYQB29mqfpy+3EdlsPwtZcPEEWuTl3r2LwEJaJm46gYb8A0UrAynjYxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsE2MueVOMC4dtDhpM2yNYrpYMmRkCg30UGPEKfW9ZCVwTOXt
	GLmhMi6f17XLPFkxW5UX8iIba+RpY7Wr2F4c9HTx9g5bqRsF6AUA+JJOi6I0SP7l/0saho2JNOt
	fNuyQp+P7tFKD9J0XKy3RPRT4l7gLyrFIgoW353JuIeghk32DKyeu7i8HJXbk39I0fAwdA4xNhu
	AECSFL2yAj0JHCrXsuzgsl/VBjHSFyrkux1drSJYxE9qfdLpX9QhSyUvQt1Fk=
X-Gm-Gg: ASbGncsVwaamzio9w2gpoORuOgKpW6t/fC0BQp52hcMOnW3Cvl3firrIB1VdCkIde1P
	ylrxgPrSk1Bb4i/+My6jFBNxbwFKOLwIepD29GqjaqDh8Hs1JqwY/3K7NrTBxnePrajMapu2a+B
	mMBqzcyTRtgt7p4pKn2PY=
X-Received: by 2002:a17:907:2d25:b0:af9:a5f8:2f0c with SMTP id a640c23a62f3a-b04b1476a9bmr1018593166b.28.1757417147785;
        Tue, 09 Sep 2025 04:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHFzOpKo6IgPt9Fre5tBMKMQaCvkwdCdi7dZPsOl6NBwM1CgHkN959EUhsitLdkdjkCwWVuFu4TCyFJ0oeB2o=
X-Received: by 2002:a17:907:2d25:b0:af9:a5f8:2f0c with SMTP id
 a640c23a62f3a-b04b1476a9bmr1018589666b.28.1757417147346; Tue, 09 Sep 2025
 04:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907022325.243930-1-crwood@redhat.com>
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 9 Sep 2025 13:25:36 +0200
X-Gm-Features: Ac12FXxzV7ROCA3ThDL-gCaGW8FDfHdWHFSkEll3JyFYe9dG030nch0wAzhi_Sw
Message-ID: <CAP4=nvTgBPRbUvSLEJGW4nAQ6i6jghhE+qVGs657Dtb9ZWE3eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise actions
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tMHm9Z5BssTVl5x4IgN9jjlghNeNLAQBK2U19mGOPIs_1757417148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 7. 9. 2025 v 4:23 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> napsa=
l:
>
> v2: minor changes from Tomas's feedback
>

Thank you! Looks good now. (The help message for rtla-osnoise-top
shows --on-end without the argument, but that is my typo (it's also in
timerlat), let's just fix that later.)

> v1: https://lore.kernel.org/linux-trace-kernel/20250821035719.137161-1-cr=
wood@redhat.com/T/#t
>
> Costa Shulyupin (1):
>   tools/rtla: Consolidate common parameters into shared structure
>
> Crystal Wood (6):
>   tools/rtla: Move top/hist params into common struct
>   tools/rtla: Create common_apply_config()
>   tools/rtla: Consolidate code between osnoise/timerlat and hist/top
>   tools/rtla: Fix -A option name in test comment
>   tools/rtla: Add test engine support for unexpected output
>   tools/rtla: Add remaining support for osnoise action
>
>  Documentation/tools/rtla/common_options.rst   |  61 ++
>  .../tools/rtla/common_osnoise_options.rst     |   8 +
>  .../tools/rtla/common_timerlat_options.rst    |  74 +-
>  Documentation/tools/rtla/rtla-hwnoise.rst     |   2 +
>  .../tools/rtla/rtla-osnoise-hist.rst          |   2 +
>  Documentation/tools/rtla/rtla-osnoise-top.rst |   2 +
>  .../tools/rtla/rtla-timerlat-hist.rst         |   2 +
>  .../tools/rtla/rtla-timerlat-top.rst          |   2 +
>  tools/tracing/rtla/src/Build                  |   1 +
>  tools/tracing/rtla/src/actions.c              |   8 +-
>  tools/tracing/rtla/src/actions.h              |   2 +-
>  tools/tracing/rtla/src/common.c               | 344 ++++++++++
>  tools/tracing/rtla/src/common.h               | 154 +++++
>  tools/tracing/rtla/src/osnoise.c              | 101 ++-
>  tools/tracing/rtla/src/osnoise.h              | 114 +---
>  tools/tracing/rtla/src/osnoise_hist.c         | 369 ++++------
>  tools/tracing/rtla/src/osnoise_top.c          | 303 +++------
>  tools/tracing/rtla/src/timerlat.c             | 210 ++++--
>  tools/tracing/rtla/src/timerlat.h             |  55 +-
>  tools/tracing/rtla/src/timerlat_bpf.c         |  22 +-
>  tools/tracing/rtla/src/timerlat_hist.c        | 642 +++++-------------
>  tools/tracing/rtla/src/timerlat_top.c         | 568 ++++------------
>  tools/tracing/rtla/src/trace.h                |   3 -
>  tools/tracing/rtla/tests/engine.sh            |  26 +-
>  tools/tracing/rtla/tests/osnoise.t            |  27 +-
>  tools/tracing/rtla/tests/timerlat.t           |   4 +-
>  26 files changed, 1395 insertions(+), 1711 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/common.c
>  create mode 100644 tools/tracing/rtla/src/common.h
>
> --
> 2.48.1
>

Reviewed-by: Tomas Glozar  <tglozar@redhat.com>

Tomas

