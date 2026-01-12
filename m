Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3A2561AA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229434; cv=none; b=qNZRf9dAZnVq0y/sS0kJnNYCVwv6cWjxVExX/wzrUVQqE5sXV6xXMZbnmlmZwzjwf9RI9niX4UIZHz9n5WjKjkuDW4Vh71f/R8XMVDsrBbDq12IPJHZudMlEexm7qgPi7iwMZhXUOlETjGEvPUr4mpgxnP2mbt/UdpqB1iKDDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229434; c=relaxed/simple;
	bh=FBUKgISXjQP7h2ZUxM2NKHPRvEVafeVb0rFtr9MUEwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4SxIUk8y2wfzMwzKDIQEhtTRGOeT+3/flNSo871K6aLfoX9Ua3r70wV1qWxHSHvKJ+LiSjd4oFRamNVY4i6//0S1mdXOOapZcrYlCukYqwZgSu2XNo3H+DN+Z+v9Lp78gqchvFg7HmVK0vAE9hDqyKqjB0zMgt8ZFp4ygw2Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTEdERzm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTEdERzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU1pOUpPJD8GyUjQoyVblF8+EXaq9e5quyrO1Q8Ro4g=;
	b=eTEdERzmN1vB/YF9XFgm0HBbPbmRtl6c+dt0r3K7C5VKC0GiJCHg/zM0B+b2duT4Sby4TG
	Z2otYoagfp//rN7QcIGX8zwc72w0lEWQRJDnfiCNm1IC66yqb+6nqphJdF1pSdsOr2mz6y
	GRdryKOlvgsiC9EItcUUVz/4nv2FA+k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Hk1vQgE2Obq945U6ZUSKTQ-1; Mon, 12 Jan 2026 09:50:31 -0500
X-MC-Unique: Hk1vQgE2Obq945U6ZUSKTQ-1
X-Mimecast-MFC-AGG-ID: Hk1vQgE2Obq945U6ZUSKTQ_1768229430
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64d53a7817eso9168226a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229429; x=1768834229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dU1pOUpPJD8GyUjQoyVblF8+EXaq9e5quyrO1Q8Ro4g=;
        b=R1mYPF7KJLkKXECjYaF73sCa8lj5c+B7L9v+Mr0vgJuVvVyILaPRJV/foDV1tZBrW2
         NQOa+3OnGsf5f8m/Asnq+W0HCota50muA0WkzbuthPvCoK4tywgTEK0mbSH8O/h1+IUE
         7BYbQ5XRMCbOj/yNDLh2JhFW5hRXbmbz6OKMmSuQHHPdVpnShJW5t+Jw9fXEW77uB3g+
         BSMaPWz6wPMIOpZfsyj2av5H1Q4gfMjPSuMovzoOKs6rAAhEYCzOFfYvXA8PNRPqLv6n
         uh8gU2h5uw1dA3eetHN5z23+58y1gvBPh9oWrKx2OEUz17a9UKyUofqO3D6PYRim9H/W
         enPA==
X-Forwarded-Encrypted: i=1; AJvYcCUwPit1e75If3FekHXAecavd4IdJi97+U7lkTenDcHHqxuPpkX4EvBM/I9B4YYx8MTBPJPnZKgmSyAgKF/esEOr8iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEss0FtyP7g84sWnfZVNJYMsyyfIl1X4z2qAOXzpVL29ZkmdT
	Ba9UDrmQ5hpdhu2PNONh6shlzHrsGUCgVWXPbGgrEanB9Il8m6KP5BFoz2aKBRKgiCIc30iH+0h
	QJHq+Fr7JpoXCjkqNRTXnovlM2QBqs8YI9VhprcBGIQfIWnSORyHGxhvptNr81zEP/Dgk6KUZW8
	J6tWyWw6XuerjyDM1lI34rQKmspnFzH+qpWYvRbyCi8U+CzH29
X-Gm-Gg: AY/fxX5N/rfJUzzo2yR08ki1ZYAp9j3VMbbbyKVOpOTgTPJR+a6JuHUcn/XrFM1MY8G
	BFKwSSsYXOZPR/LZW4DsuvvBNdXX5GDfo/1PnQDG3v8kgdIofcg6qZYJPTFZIMzIAyiKP2LmDJ4
	ev9lbjw+SuPk08fFclOCHElZn0ug2tXKwbUkokaioETGx4/dYyHT1VKHrvoRbBG1OQHRpnZXPzH
	pWOihSDLe7H2ifwRgJsGBsQ
X-Received: by 2002:a17:907:1b21:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8445031bf9mr1904001266b.12.1768229428923;
        Mon, 12 Jan 2026 06:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVswVJX7+RGyKonqDuQLS/2kvXXdHWhI5lIgW465/OpcQ/6QKv8Dj66vuACavoRLdvwP2lOQwCBLaIktWAh2w=
X-Received: by 2002:a17:907:1b21:b0:b73:6f8c:6127 with SMTP id
 a640c23a62f3a-b8445031bf9mr1903998166b.12.1768229428434; Mon, 12 Jan 2026
 06:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112132140.156956-1-costa.shul@redhat.com>
In-Reply-To: <20260112132140.156956-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 12 Jan 2026 15:50:17 +0100
X-Gm-Features: AZwV_QiGeFMyelYvVFWeTcv5Rxh3mVIJEgQwCNnBoWjD5hXWbD9dturmLWgBdLk
Message-ID: <CAP4=nvRUA2VvCVXO4J5zA3XMUWnG8L-1zhvWUYJ5atRQuPb4yQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix parse_cpu_set() and add unit test
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa <wander@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L6laeMy-WiJtwPswKNQaksEUjTdlKfb9Lhc0HhyQYic_1768229430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 12. 1. 2026 v 14:22 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The patch "Replace atoi() with a robust strtoi()" introduced a bug
> in parse_cpu_set(), which relies on partial parsing of the input
> string.
>
> Restore the original use of atoi() in parse_cpu_set().
>
> Add a unit test to prevent accidental regressions.
>
> Fixes: 7e9dfccf8f11 ("rtla: Replace atoi() with a robust strtoi()")
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

The convention is not to insert a blank line between Fixes and Signed-off-b=
y.

> ---
>  tools/tracing/rtla/Makefile           |  3 ++
>  tools/tracing/rtla/src/utils.c        | 10 ++--
>  tools/tracing/rtla/tests/Makefile     | 12 +++++
>  tools/tracing/rtla/tests/test_utils.c | 74 +++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 6 deletions(-)
>  create mode 100644 tools/tracing/rtla/tests/Makefile
>  create mode 100644 tools/tracing/rtla/tests/test_utils.c
>

Could you split this into three commits?

1. Fix the bug.
2. Add unit test framework.
3. Add the specific unit tests for utils.

IMHO, it would be easier to modify the test in tests/timerlat.t to
cover this case for now, and implement unit tests later in an entirely
separate patchset. (See comments for the unit tests below.)

> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 2701256abaf3..1805916c7dba 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -109,7 +109,10 @@ clean: doc_clean fixdep-clean
>         $(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
>         $(Q)rm -rf feature
>         $(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat=
_bpf_action.o
> +
> check: $(RTLA) tests/bpf/bpf_action_map.o
> +       make -C tests/ check
>        RTLA=3D$(RTLA) BPFTOOL=3D$(SYSTEM_BPFTOOL) prove -o -f -v tests/
> +
> examples: example/timerlat_bpf_action.o
> .PHONY: FORCE clean check

The unit tests should be a separate target, so that you can run unit
tests and end-to-end tests separately. Also, the directory structure
should reflect that there are two types of tests. For example, in
rteval, Test:Harness-based end-to-end tests (inspired by and very
similar to RTLA tests) are in tests/e2e while unit tests are in tests/
directly; it might be even better to have them in tests/unit.

> diff --git a/tools/tracing/rtla/tests/test_utils.c b/tools/tracing/rtla/t=
ests/test_utils.c
> new file mode 100644
> index 000000000000..92ed49d60d33
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/test_utils.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Unit tests for src/utils.c parsing functions
> + */
> +
> +#define _GNU_SOURCE
> +#include <check.h>
> +#include <unistd.h>
> +
> +#include "../src/utils.h"
> +

Here, you add an external dependency on libcheck. That has to be
documented in both the commit message and README, and it should also
be added to tools/build dependency detection (in a separate commit)
first before being added to RTLA, so that RTLA can check for the
dependency and disable unit tests if it is not present.

> diff --git a/tools/tracing/rtla/tests/Makefile b/tools/tracing/rtla/tests=
/Makefile
> new file mode 100644
> index 000000000000..fe187306a404
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/Makefile
> @@ -0,0 +1,12 @@
> +LIBS :=3D -lcheck
> +
> +test_utils: test_utils.c ../src/utils.c
> +       $(CC) $(CFLAGS) -o $@ $^ $(LIBS)
> +
> +check: test_utils
> +       ./test_utils
> +
> +clean:
> +       rm -f test_utils
> +
> +.PHONY: check clean

Is there a reason for doing a separate Makefile for the tests? That
will require explicitly passing variables to the child make during the
build. It appears to me that it would be more natural to just include
unit tests into the main Makefile (or a file included from it, e.g.
Makefile.test), which already covers end-to-end tests. That would also
allow it to use RTLA build system's dependency detection.

Thanks,
Tomas

