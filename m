Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FD47013E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720277; cv=none; b=VlAtR/z64H8OsyKpo4rjvoX9VNrEssa4SDEtfdMgJc+dgHEHcyFcyytBq9jfPlhJYrXGGOY6k51GI7YEpcHE+9aFn13suQzEiBn0+/9qFVwXmjWaMZ1KPqBf1iRaQ1qMgZUnBoynUwJM74tTK0dDwEBdAfSn3oanRP/+IWjOBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720277; c=relaxed/simple;
	bh=MFNau2VjMpC68Vv8cM6SHwmHntK8+e3OCTRPDazleNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMbzSsHxiUn+YeswGegreBsJCqsQ5IoOwHK605YmHbXVvQrXPWXXo4z9gRb3L/wG/hVH+CKWheDiSUyB3QuH+BPMP6bqkD4G/9Caq5ePPbjh12PpWnFilQx1dDnMnvaH1mCpiRhDNKD8B6OLdxwksSmZI7HKyLzkDGELJMDm5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLpW/StD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLpW/StD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784720274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFNau2VjMpC68Vv8cM6SHwmHntK8+e3OCTRPDazleNw=;
	b=WLpW/StDbrN+7eZcr+Oh9t+5kMEVk/rdVWvwLxCvyquem6u+7ZtmYdDJU7GztvIcyyh9o1
	tfsCCisjTsjvCtItG34VhRyaOMzkVk3GwSojwsH3OT0k456Ut8gnRf5tl8qrLfRGFnwbXN
	+nB2WdfzF+1uLcu7b45Hr2NFUXYgANk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-EBwlzc9RM9KIK89BHlxMAg-1; Wed, 22 Jul 2026 07:37:52 -0400
X-MC-Unique: EBwlzc9RM9KIK89BHlxMAg-1
X-Mimecast-MFC-AGG-ID: EBwlzc9RM9KIK89BHlxMAg_1784720272
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c167e032f03so83322466b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 04:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720272; x=1785325072;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kv4Fh6cCMLCK92Fu8BkvDkrCHd5Rl2hZHVs+Zxq4OOE=;
        b=YIQVxoZ1bY/RJZxX/jwXPgimX9x7lzJpepyFqcpg7jUrRzRKkpAjg+PWpQ8TaSvs4C
         gdi2t1ik+8pmkA60yJlTgGCwBcg6I40uVCZcZmMaHKioffKXoiioS3fTSMEe7tUaYceA
         uT8phy06J8XPbwBiENZ1kytSnZsBEELCwCIicVni5hMAO8eRjT9cCXtaqn3gPXPi/7gy
         y8LioCEpataoXc39IhPvpTcmbX8Z6H++Ene6XEDm17igAErHyj4HHcoTiP+g3VPB0zqO
         kntfn1kDXGxpWTIqJK9UJXjBsomiTVgCeGIRRW2jF8ezzi+DYRk/NilWYu3zwALZjbgu
         49EQ==
X-Forwarded-Encrypted: i=1; AHgh+RojqVsUQJb/uC9CecJuWGBkTeNkHh9TOtOz6JbbdOGJnSbiRn7eRMKeBRcF3ES0zQEL152orO12rKGuOE4FdLQe/6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgphiBxm/1RlxrBl6uwvDwxUwZQgqJZuNWN3tGyywPqlhCR2wb
	0txvpITrTjOUBTNDQdU70uv/e4k5eMqMjGqVzwJYvQhISfxk9rg2cFV3DVoKlN68NSXvX25aTNO
	+O3valbd3hwxo1aJq7s0swZJ0cUBTivW9lWt9vaX2CwWO2/0uQ/fLl1MNUvaX8+9rrm16gZhfpw
	5kkHKyBl8d
X-Gm-Gg: AR+sD12G3dJqqjz2yOHgN1RN126sd2K7zI57SkEnVdkL8xykn3toPPb5+1nJauMph3n
	Q71fM5th1QnTmNXXRKYJBimLohpJq3IOlzO3E3XAMgznYUORs16Rk3gAKkcOrFH5GT1Uq1YhBVv
	sXZqQiMdDRHbgQnXDPbSam1tK4QTazhR3gnAM/w2zZtq6wjv5zyfFWcV7hVWpsq9qxXCJQNydW5
	H+Ow3yqgDEc17hiPAHdaBoxfPw3FG21hNA7ipe45wYDUuJWX0JKtddOwjLmwERND97TaUfB558z
	oYtBS4aqLqBi797Wsea0yUkYm3cG5Cpr1vHTWaOTW05pXTdwCjwbJJbrV6b+aQUUY99nowPJS2A
	O58b0sEAMT6Ta1Wa4P3cmg5h/XkLJfZQdSuZ0yjfGFvcPfJQ6dmSzlf4p9cyTu/pyMkxHTw==
X-Received: by 2002:a17:907:cd07:b0:c15:ce72:934a with SMTP id a640c23a62f3a-c16b48331e9mr887107466b.48.1784720271605;
        Wed, 22 Jul 2026 04:37:51 -0700 (PDT)
X-Received: by 2002:a17:907:cd07:b0:c15:ce72:934a with SMTP id a640c23a62f3a-c16b48331e9mr887106566b.48.1784720271034;
        Wed, 22 Jul 2026 04:37:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac7041sm90086266b.14.2026.07.22.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:37:50 -0700 (PDT)
Message-ID: <2280c5a84ce419bf9f96b79552ad47775dc8997e.camel@redhat.com>
Subject: Re: [PATCH v4 13/17] rv: Add KUnit stub for current
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Nam
 Cao	 <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>,  Wen Yang <wen.yang@linux.dev>
Date: Wed, 22 Jul 2026 13:37:48 +0200
In-Reply-To: <20260717154638.220789-14-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
	 <20260717154638.220789-14-gmonaco@redhat.com>
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
X-Mimecast-MFC-PROC-ID: u2NdPp1pDMn2_228ONnqckVWHMBH7IOQyKNftC1Kl1Y_1784720272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 17:46 +0200, Gabriele Monaco wrote:
> Some monitors do not only rely on tracepoint arguments but also on the
> currently executing task.
> This makes it more challenging to mock events in KUnit.
>=20
> Define wrapper functions around current, the functionality is stubbed
> only during KUnit, however the additional function call is necessary
> whenever the KUnit tests are built in.
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

As reported by sashiko, using KUnit's standard stubbing can be dangerous. I=
n the
rare case of an NMI causing an RV event (e.g. a pagefault) when an unrelate=
d
KUnit test is running, the stub would end up using locks and causing issues=
.

Additionally, it isn't ideal to downgrade to a function call directly if th=
e
tests are built, which is for instance the default on the stock Fedora kern=
el
(CONFIG_KUNIT_ALL_TESTS=3Dm).

I'm soon going to send a V5 addressing both: no stub and function call only=
 if
KUnit is really running.
I'll reset the review since the patch essentially changes.

> ---
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/rv/kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++++-
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 24 +++++++++----------
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++
> =C2=A08 files changed, 47 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 773564720ba1..9f7ba443d777 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,6 +16,7 @@
> =C2=A0
> =C2=A0#include <rv/automata.h>
> =C2=A0#include <linux/rv.h>
> +#include <rv/kunit.h>
> =C2=A0#include <linux/stringify.h>
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> diff --git a/include/rv/kunit.h b/include/rv/kunit.h
> index ff98b5137285..6d16a422a80c 100644
> --- a/include/rv/kunit.h
> +++ b/include/rv/kunit.h
> @@ -2,7 +2,10 @@
> =C2=A0/*
> =C2=A0 * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@r=
edhat.com>
> =C2=A0 *
> - * Declaration of utilities to run KUnit tests.
> + * Declaration of wrappers to allow stubbing core functionality, like
> current,
> + * and other testing utilities.
> + * Necessary only when mocking may be needed. If the RV KUnit test is
> + * enabled, the wrappers incur an additional function call overhead.
> =C2=A0 */
> =C2=A0
> =C2=A0#ifndef _RV_KUNIT_H
> @@ -16,6 +19,7 @@
> =C2=A0
> =C2=A0int rv_set_testing(struct kunit_suite *suite);
> =C2=A0void rv_clear_testing(struct kunit_suite *suite);
> +struct task_struct *rv_get_current(void);
> =C2=A0
> =C2=A0#define RV_KUNIT_MAX_MOCK_TASKS 8
> =C2=A0
> @@ -23,6 +27,7 @@ struct rv_kunit_ctx {
> =C2=A0=09int reactions, expected;
> =C2=A0=09int mock_task_count;
> =C2=A0=09struct task_struct *mock_tasks[RV_KUNIT_MAX_MOCK_TASKS];
> +=09struct task_struct *curr;
> =C2=A0};
> =C2=A0
> =C2=A0#define RV_KUNIT_EXPECT_REACTION(test, ctx)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> @@ -57,5 +62,11 @@ void prepare_test(struct kunit *test, const struct
> rv_kunit_mon *mon);
> =C2=A0void teardown_test(void *arg);
> =C2=A0struct task_struct *rv_kunit_alloc_mock_task(struct kunit *test);
> =C2=A0
> +#define rv_mock_current(ctx, task) (ctx->curr =3D task)
> +
> +#else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
> +
> +#define rv_get_current() current
> +
> =C2=A0#endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
> =C2=A0#endif /* _RV_KUNIT_H */
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 56e83edcf0c4..d7dc01db4dd9 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/stringify.h>
> =C2=A0#include <linux/seq_buf.h>
> =C2=A0#include <rv/instrumentation.h>
> +#include <rv/kunit.h>
> =C2=A0#include <trace/events/task.h>
> =C2=A0#include <trace/events/sched.h>
> =C2=A0
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 34c1feb35a9b..7bae9723cdbf 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -121,4 +121,7 @@ config RV_MONITORS_KUNIT_TEST
> =C2=A0=09=C2=A0 These tests verify that monitors correctly detect violati=
ons by
> =C2=A0=09=C2=A0 triggering fake events and validating the expected reacti=
ons.
> =C2=A0
> +=09=C2=A0 Enabling this may slightly increase overhead of some monitors =
even
> +=09=C2=A0 when the KUnit test is not running.
> +
> =C2=A0=09=C2=A0 If unsure, say N.
> diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c
> b/kernel/trace/rv/monitors/pagefault/pagefault.c
> index 5e1a2a606783..e52500fd2de0 100644
> --- a/kernel/trace/rv/monitors/pagefault/pagefault.c
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -38,7 +38,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0static void handle_page_fault(void *data, unsigned long address, st=
ruct
> pt_regs *regs,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long error_code)
> =C2=A0{
> -=09ltl_atom_pulse(current, LTL_PAGEFAULT, true);
> +=09ltl_atom_pulse(rv_get_current(), LTL_PAGEFAULT, true);
> =C2=A0}
> =C2=A0
> =C2=A0static int enable_pagefault(void)
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index 12328ce663f5..71d2005ce520 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -102,7 +102,7 @@ static void handle_sched_waking(void *data, struct
> task_struct *task)
> =C2=A0=09if (this_cpu_read(hardirq_context)) {
> =C2=A0=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
> =C2=A0=09} else if (in_task()) {
> -=09=09if (current->prio <=3D task->prio)
> +=09=09if (rv_get_current()->prio <=3D task->prio)
> =C2=A0=09=09=09ltl_atom_pulse(task,
> LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
> =C2=A0=09} else if (in_nmi()) {
> =C2=A0=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_NMI, true);
> @@ -112,12 +112,12 @@ static void handle_sched_waking(void *data, struct
> task_struct *task)
> =C2=A0static void handle_contention_begin(void *data, void *lock, unsigne=
d int
> flags)
> =C2=A0{
> =C2=A0=09if (flags & LCB_F_RT)
> -=09=09ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
> +=09=09ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX,
> true);
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_contention_end(void *data, void *lock, int ret)
> =C2=A0{
> -=09ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
> +=09ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX, false);
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_sys_enter(void *data, struct pt_regs *regs, long=
 id)
> @@ -126,7 +126,7 @@ static void handle_sys_enter(void *data, struct pt_re=
gs
> *regs, long id)
> =C2=A0=09unsigned long args[6];
> =C2=A0=09int op, cmd;
> =C2=A0
> -=09mon =3D ltl_get_monitor(current);
> +=09mon =3D ltl_get_monitor(rv_get_current());
> =C2=A0
> =C2=A0=09switch (id) {
> =C2=A0#ifdef __NR_clock_nanosleep
> @@ -135,11 +135,11 @@ static void handle_sys_enter(void *data, struct pt_=
regs
> *regs, long id)
> =C2=A0#ifdef __NR_clock_nanosleep_time64
> =C2=A0=09case __NR_clock_nanosleep_time64:
> =C2=A0#endif
> -=09=09syscall_get_arguments(current, regs, args);
> +=09=09syscall_get_arguments(rv_get_current(), regs, args);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] =3D=
=3D
> CLOCK_MONOTONIC);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] =3D=3D
> CLOCK_TAI);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] =3D=3D
> TIMER_ABSTIME);
> -=09=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
> +=09=09ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, true);
> =C2=A0=09=09break;
> =C2=A0
> =C2=A0#ifdef __NR_futex
> @@ -148,25 +148,25 @@ static void handle_sys_enter(void *data, struct pt_=
regs
> *regs, long id)
> =C2=A0#ifdef __NR_futex_time64
> =C2=A0=09case __NR_futex_time64:
> =C2=A0#endif
> -=09=09syscall_get_arguments(current, regs, args);
> +=09=09syscall_get_arguments(rv_get_current(), regs, args);
> =C2=A0=09=09op =3D args[1];
> =C2=A0=09=09cmd =3D op & FUTEX_CMD_MASK;
> =C2=A0
> =C2=A0=09=09switch (cmd) {
> =C2=A0=09=09case FUTEX_LOCK_PI:
> =C2=A0=09=09case FUTEX_LOCK_PI2:
> -=09=09=09ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
> +=09=09=09ltl_atom_update(rv_get_current(), LTL_FUTEX_LOCK_PI,
> true);
> =C2=A0=09=09=09break;
> =C2=A0=09=09case FUTEX_WAIT:
> =C2=A0=09=09case FUTEX_WAIT_BITSET:
> =C2=A0=09=09case FUTEX_WAIT_REQUEUE_PI:
> -=09=09=09ltl_atom_update(current, LTL_FUTEX_WAIT, true);
> +=09=09=09ltl_atom_update(rv_get_current(), LTL_FUTEX_WAIT,
> true);
> =C2=A0=09=09=09break;
> =C2=A0=09=09}
> =C2=A0=09=09break;
> =C2=A0#ifdef __NR_epoll_wait
> =C2=A0=09case __NR_epoll_wait:
> -=09=09ltl_atom_update(current, LTL_EPOLL_WAIT, true);
> +=09=09ltl_atom_update(rv_get_current(), LTL_EPOLL_WAIT, true);
> =C2=A0=09=09break;
> =C2=A0#endif
> =C2=A0=09}
> @@ -174,7 +174,7 @@ static void handle_sys_enter(void *data, struct pt_re=
gs
> *regs, long id)
> =C2=A0
> =C2=A0static void handle_sys_exit(void *data, struct pt_regs *regs, long =
ret)
> =C2=A0{
> -=09struct ltl_monitor *mon =3D ltl_get_monitor(current);
> +=09struct ltl_monitor *mon =3D ltl_get_monitor(rv_get_current());
> =C2=A0
> =C2=A0=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> =C2=A0=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> @@ -182,7 +182,7 @@ static void handle_sys_exit(void *data, struct pt_reg=
s
> *regs, long ret)
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> -=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> +=09ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, false);
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_kthread_stop(void *data, struct task_struct *tas=
k)
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index cfe950fef3b4..edb10812f296 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -142,6 +142,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> +#include <kunit/static_stub.h>
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_MON_EVENTS
> =C2=A0#define CREATE_TRACE_POINTS
> @@ -893,4 +894,11 @@ void rv_clear_testing(struct kunit_suite *suite)
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
> +
> +struct task_struct *rv_get_current(void)
> +{
> +=09KUNIT_STATIC_STUB_REDIRECT(rv_get_current);
> +=09return current;
> +}
> +EXPORT_SYMBOL_GPL(rv_get_current);
> =C2=A0#endif
> diff --git a/kernel/trace/rv/rv_monitors_test.c
> b/kernel/trace/rv/rv_monitors_test.c
> index 2145c85d4c9a..2108973383b2 100644
> --- a/kernel/trace/rv/rv_monitors_test.c
> +++ b/kernel/trace/rv/rv_monitors_test.c
> @@ -106,6 +106,13 @@ struct task_struct *rv_kunit_alloc_mock_task(struct =
kunit
> *test)
> =C2=A0=09return tsk;
> =C2=A0}
> =C2=A0
> +static struct task_struct *stub_rv_get_current(void)
> +{
> +=09if (active_ctx && active_ctx->curr)
> +=09=09return active_ctx->curr;
> +=09return current;
> +}
> +
> =C2=A0static int rv_mon_test_init(struct kunit *test)
> =C2=A0{
> =C2=A0=09struct rv_kunit_ctx *ctx;
> @@ -115,6 +122,8 @@ static int rv_mon_test_init(struct kunit *test)
> =C2=A0
> =C2=A0=09test->priv =3D ctx;
> =C2=A0
> +=09kunit_activate_static_stub(test, rv_get_current,
> stub_rv_get_current);
> +
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0

