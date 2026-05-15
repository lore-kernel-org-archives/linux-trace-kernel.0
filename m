Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA1314B76
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850845; cv=none; b=Wqoj/RfGPtOhU/eVbeU+JehwPbavm/mUDjbiYqXgOaiJGjy9HJco3WsXY4NdoWscRy+KP2LBCV+zroDQkuOSt2GIN8WSC9MBWhomoIhcfVR41nOY45VIO4bfOvvdNcH5DpBDovSKYgXHBKFOu7UrSGTFHBdqRPnf+ZNboLQ51lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850845; c=relaxed/simple;
	bh=42hoG+DZIUSEV9N4Er6T0Ogb08XjB3zH1jlyQLlZRCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/wvk7hHKeDdk1Td+r+L3iacLafcKzNX1Z64e7OqcfBL0Ox+HAxzuNpYhKpMywoOPgCdIKl8JATRvpVr+RKy/CDjN+rdRBeKSMG8SkAs2nvHDm8SDC9WGCpzFZJPJBT6E2f8d2hmiPkUt9TsGAjXCI6SmdPfLOGw86RB3Xalj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0LooMJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0LooMJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778850842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42hoG+DZIUSEV9N4Er6T0Ogb08XjB3zH1jlyQLlZRCA=;
	b=B0LooMJ2JuczX2sYvSlCDSU2wYApVEaZG3w+PmT0MvB6vI4jdk6L9/Z6at7BuekWGAj7eA
	tvwmkm1uObjIjykSZCI9HUv0vaMZCkpBsiQk6rub72VgqB2lUFDKUuuqETyat60U7oaP+T
	yzGgURC5F4fesITOU+t7av4c7zCtjl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-GMK29MWrO6q2jIvga72KVQ-1; Fri, 15 May 2026 09:14:00 -0400
X-MC-Unique: GMK29MWrO6q2jIvga72KVQ-1
X-Mimecast-MFC-AGG-ID: GMK29MWrO6q2jIvga72KVQ_1778850839
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a122a5128so7006908f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850839; x=1779455639;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ3IjZ1Crx0ho8eU2lSqLekEpjxInuy6TMOwmj0GUS0=;
        b=Qqcx8GnovpPACDPrnEohv30+UlkvQXYrfhfYACStYU83RkQyN7h79+FwGPvVDVpAQF
         /qLQzI7sUYkajQ7K/4dysOXg0rIL9EYf3YOY99SBwqC1XuHD86VVS0owVTxphC+Kr4om
         lQ4+Qeu1dLSRWWTZryUpEV6hdnRjYEn1nvZPtAknI/dt6xz+3YZF3D7q6fnQLmTTg/WW
         RVzz4SL+cFJKVuJ6hgtf1K3w8uc4X3NdXzrmZaY8l7Azn9ZHC8AfqaAvE9IViNeuNtTF
         f6FHavHVZoF1IE1CB4W9LxrdlJma+5oei7bJv0xJkrdvR8LnmWfS0u9qOiSZpzFucz3W
         mqkA==
X-Gm-Message-State: AOJu0Yz8FuMfYe+v43nk03xikbJY+E7xn0jAaXQt/X/d/80HIx0E+6S1
	B/vGI3txTMH/RtWXj4ohBbBxXg33r8Rl5Rh6vUDXeL+IqKp5JrkuYqyaaAxZOOujylVKm5MkzaM
	WoVTPbnF/KKRUgg2JuVhoOLoSxJKHL8smGiOe8q4PMSUPUrFkfLQSfkaif+rbVcWZSQRrubV6c+
	9fTmeYTFmB
X-Gm-Gg: Acq92OFafhoOv30/iRMuLLCxe7nqDkl98BeKvNT2c8c1R8K0qGwIBycdzSCs4x5g6iO
	LECPEICkSA/8X2JclXt3YSbPD/JmFdZcD36iVKnC3voGiD0sgzHg9dApsfHheW0KgxM5tYZGgm/
	+2BsQKHmaTTS3EGzZ3LM/e1jDsjsePUCAsQWssj2aob0xYTnWoqSFbefo3YCDWQ1SaWQePizWOU
	FSv+fo0FDnY2vrnDdzAnk2Oa3q0o4aYHQf24JpV619tCjBgvs7f/VOQhYh+L4M0Du+zdwdurFtg
	qZVoP+0CcReGvYXMPHDHFn02Rp+qQ1x6vQWS+z4dpiPb3pjKErAGQFAoZNd0OFAg7jQyyRFT5et
	YX7qNAf3+HjdTFQG1UfnrfF+ikOJ3UWUsN6U+yhwdZNthHMYXbsKUEeF3LLwYlIShx8MVlX+rQA
	0NLESRUuBvVZvv17I=
X-Received: by 2002:a05:600c:4692:b0:48e:51f8:eb39 with SMTP id 5b1f17b1804b1-48fe6325746mr55896975e9.28.1778850838787;
        Fri, 15 May 2026 06:13:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:48e:51f8:eb39 with SMTP id 5b1f17b1804b1-48fe6325746mr55896445e9.28.1778850838211;
        Fri, 15 May 2026 06:13:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm61850415e9.3.2026.05.15.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:13:57 -0700 (PDT)
Message-ID: <1a54c68e14e96cf81d6e52dafc5abfed3512118b.camel@redhat.com>
Subject: Re: [RFC PATCH v2 09/10] rv/tlob: add KUnit tests for the tlob
 monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Fri, 15 May 2026 15:13:56 +0200
In-Reply-To: <a12d14297b33b9b8d425bc1b813a8aecbd54bcc6.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <a12d14297b33b9b8d425bc1b813a8aecbd54bcc6.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1YiSI6VZH7wCEIvNKOKaLhQN4gNRElXUUMcwXAGqgJI_1778850839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add five KUnit test suites gated behind CONFIG_TLOB_KUNIT_TEST
> (depends on RV_MON_TLOB && KUNIT; default KUNIT_ALL_TESTS) with a
> .kunitconfig fragment for the kunit.py runner.
>=20
> tlob_task_api tests the start/stop API, error returns (-EEXIST,
> -ESRCH, -EOVERFLOW, -ENOSPC, -ERANGE).
> tlob_sched_integration covers context-switch accounting and monitoring
> a kthread.=C2=A0 tlob_parse_uprobe exercises the uprobe line parser.
> tlob_trace_output checks sched_switch and error_env_tlob field layout.
> tlob_violation_react verifies error_env_tlob fires once on budget
> expiry and zero times when the budget is not exceeded.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

That's quite extensive, but what caught my eyes are tests enrolling tracepo=
ints
handlers. If you go there you're no longer doing unit testing, what's the
advantage of testing the entire monitor here over doing that in selftests?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/monitors/tlob/.kunitconfig |=C2=A0=C2=A0 5 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 26 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.c | 881 ++++++++++++++++++=
+++
> =C2=A03 files changed, 912 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
>=20
> diff --git a/kernel/trace/rv/monitors/tlob/.kunitconfig
> b/kernel/trace/rv/monitors/tlob/.kunitconfig
> new file mode 100644
> index 000000000000..977c58601ab7
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_FTRACE=3Dy
> +CONFIG_KUNIT=3Dy
> +CONFIG_RV=3Dy
> +CONFIG_RV_MON_TLOB=3Dy
> +CONFIG_TLOB_KUNIT_TEST=3Dy
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> index 475e972ae9aa..90e7035a0b55 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -1024,6 +1024,7 @@ EXPORT_SYMBOL_IF_KUNIT(tlob_num_monitored_read);
> =C2=A0/* Tracepoint probes for KUnit; rv_trace.h is only included here. *=
/
> =C2=A0static struct tlob_captured_event=C2=A0=C2=A0=C2=A0=C2=A0 tlob_kuni=
t_last_event;
> =C2=A0static struct tlob_captured_error_env tlob_kunit_last_error_env;
> +static struct tlob_captured_detail=C2=A0=C2=A0=C2=A0 tlob_kunit_last_det=
ail;
> =C2=A0static atomic_t tlob_kunit_event_cnt=C2=A0=C2=A0=C2=A0 =3D ATOMIC_I=
NIT(0);
> =C2=A0static atomic_t tlob_kunit_error_env_cnt =3D ATOMIC_INIT(0);
> =C2=A0
> @@ -1054,6 +1055,17 @@ static void tlob_kunit_error_env_probe(void *data,=
 int
> id, char *state,
> =C2=A0=09atomic_inc(&tlob_kunit_error_env_cnt);
> =C2=A0}
> =C2=A0
> +static void tlob_kunit_detail_probe(void *data, int pid, u64 threshold_u=
s,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 u64 running_ns, u64 waiting_ns,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 u64 sleeping_ns)
> +{
> +=09tlob_kunit_last_detail.pid=09=09=3D pid;
> +=09tlob_kunit_last_detail.threshold_us=09=3D threshold_us;
> +=09tlob_kunit_last_detail.running_ns=09=3D running_ns;
> +=09tlob_kunit_last_detail.waiting_ns=09=3D waiting_ns;
> +=09tlob_kunit_last_detail.sleeping_ns=09=3D sleeping_ns;
> +}
> +
> =C2=A0int tlob_register_kunit_probes(void)
> =C2=A0{
> =C2=A0=09int ret;
> @@ -1069,6 +1081,12 @@ int tlob_register_kunit_probes(void)
> =C2=A0=09=09unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
> =C2=A0=09=09return ret;
> =C2=A0=09}
> +=09ret =3D register_trace_detail_env_tlob(tlob_kunit_detail_probe, NULL)=
;
> +=09if (ret) {
> +=09=09unregister_trace_error_env_tlob(tlob_kunit_error_env_probe,
> NULL);
> +=09=09unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
> +=09=09return ret;
> +=09}
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_IF_KUNIT(tlob_register_kunit_probes);
> @@ -1077,6 +1095,7 @@ void tlob_unregister_kunit_probes(void)
> =C2=A0{
> =C2=A0=09unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
> =C2=A0=09unregister_trace_error_env_tlob(tlob_kunit_error_env_probe, NULL=
);
> +=09unregister_trace_detail_env_tlob(tlob_kunit_detail_probe, NULL);
> =C2=A0=09tracepoint_synchronize_unregister();
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_IF_KUNIT(tlob_unregister_kunit_probes);
> @@ -1105,6 +1124,7 @@ void tlob_error_env_count_reset(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_IF_KUNIT(tlob_error_env_count_reset);
> =C2=A0
> +
> =C2=A0const struct tlob_captured_event *tlob_last_event_read(void)
> =C2=A0{
> =C2=A0=09return &tlob_kunit_last_event;
> @@ -1117,6 +1137,12 @@ const struct tlob_captured_error_env
> *tlob_last_error_env_read(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_IF_KUNIT(tlob_last_error_env_read);
> =C2=A0
> +const struct tlob_captured_detail *tlob_last_detail_read(void)
> +{
> +=09return &tlob_kunit_last_detail;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_last_detail_read);
> +
> =C2=A0#endif /* CONFIG_KUNIT */
> =C2=A0
> =C2=A0VISIBLE_IF_KUNIT int tlob_enable_hooks(void)
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> new file mode 100644
> index 000000000000..ed2e7c7abaf8
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> @@ -0,0 +1,881 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the tlob RV monitor.
> + *
> + * tlob_task_api:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
start/stop lifecycle, error paths, violations.
> + * tlob_sched_integration: per-state accounting across real context swit=
ches.
> + * tlob_uprobe_format:=C2=A0=C2=A0=C2=A0=C2=A0 uprobe binding format; ad=
d/remove acceptance and
> rejection.
> + * tlob_trace_output:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace event format f=
or event_tlob, error_env_tlob.
> + * tlob_violation_react:=C2=A0=C2=A0 error count per budget expiry; per-=
state
> breakdown.
> + *
> + * tlob_add_uprobe() duplicate-(binary, offset_start) constraint is not
> covered
> + * here: kern_path() requires a real filesystem; see selftests instead.
> + */
> +#include <kunit/test.h>
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/ktime.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/sched/rt.h>
> +#include <linux/sched/task.h>
> +
> +#include "tlob.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +/*
> + * Kthread cleanup guard: registers a kunit action that stops a kthread =
on
> + * test exit, even when a KUNIT_ASSERT fires before normal teardown code
> runs.
> + *
> + * Caller must call get_task_struct() before registering the guard.
> + * Set guard->task =3D NULL before normal-path teardown to prevent doubl=
e-stop.
> + * Pass the completion to unblock on early exit, or NULL if not needed.
> + */
> +struct tlob_kthread_guard {
> +=09struct task_struct=09*task;
> +=09struct completion=09*unblock;
> +};
> +
> +static void kthread_guard_fn(void *arg)
> +{
> +=09struct tlob_kthread_guard *g =3D arg;
> +
> +=09if (!g->task)
> +=09=09return;
> +=09if (g->unblock)
> +=09=09complete(g->unblock);
> +=09kthread_stop(g->task);
> +=09put_task_struct(g->task);
> +}
> +
> +static struct tlob_kthread_guard *
> +tlob_guard_kthread(struct kunit *test, struct task_struct *task,
> +=09=09=C2=A0=C2=A0 struct completion *unblock)
> +{
> +=09struct tlob_kthread_guard *g;
> +
> +=09g =3D kunit_kzalloc(test, sizeof(*g), GFP_KERNEL);
> +=09if (!g)
> +=09=09return NULL;
> +=09g->task =3D task;
> +=09g->unblock =3D unblock;
> +=09if (kunit_add_action_or_reset(test, kthread_guard_fn, g))
> +=09=09return NULL;
> +=09return g;
> +}
> +
> +/* Suite 1: task API - lifecycle, error paths, violations. */
> +
> +/* Basic start/stop cycle */
> +static void tlob_start_stop_ok(struct kunit *test)
> +{
> +=09int ret;
> +
> +=09ret =3D tlob_start_task(current, 10000000ULL);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_num_monitored_read(), 0);
> +}
> +
> +/* Double start must return -EALREADY; double stop must return -ESRCH. *=
/
> +static void tlob_double_start(struct kunit *test)
> +{
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(current, 10000000ULL), 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_start_task(current, 10000000ULL), -
> EALREADY);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_num_monitored_read(), 0);
> +}
> +
> +/* Stop without start must return -ESRCH. */
> +static void tlob_stop_without_start(struct kunit *test)
> +{
> +=09tlob_stop_task(current);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_num_monitored_read(), 0);
> +}
> +
> +/* threshold_us =3D=3D 0 is invalid and must return -ERANGE. */
> +static void tlob_zero_threshold(struct kunit *test)
> +{
> +=09KUNIT_EXPECT_EQ(test, tlob_start_task(current, 0), -ERANGE);
> +}
> +
> +/* 1 ns budget: timer almost certainly fires before tlob_stop_task(). */
> +static void tlob_immediate_deadline(struct kunit *test)
> +{
> +=09int ret =3D tlob_start_task(current, 1);
> +
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +=09udelay(100);
> +=09/* timer fired -> -EOVERFLOW; if we won the race, 0 is also valid */
> +=09ret =3D tlob_stop_task(current);
> +=09KUNIT_EXPECT_TRUE(test, ret =3D=3D 0 || ret =3D=3D -EOVERFLOW);
> +=09KUNIT_EXPECT_EQ(test, tlob_num_monitored_read(), 0);
> +}
> +
> +/*
> + * kthreads provide distinct task_structs; fill to TLOB_MAX_MONITORED,
> + * then verify -ENOSPC.
> + */
> +struct tlob_waiter_ctx {
> +=09struct completion start;
> +=09struct completion done;
> +};
> +
> +static int tlob_waiter_fn(void *arg)
> +{
> +=09struct tlob_waiter_ctx *ctx =3D arg;
> +
> +=09wait_for_completion(&ctx->start);
> +=09complete(&ctx->done);
> +=09return 0;
> +}
> +
> +static void tlob_enospc(struct kunit *test)
> +{
> +=09struct tlob_waiter_ctx *ctxs;
> +=09struct task_struct **threads;
> +=09int i, ret;
> +
> +=09ctxs =3D kunit_kcalloc(test, TLOB_MAX_MONITORED,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*ctxs), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, ctxs);
> +
> +=09threads =3D kunit_kcalloc(test, TLOB_MAX_MONITORED,
> +=09=09=09=09sizeof(*threads), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, threads);
> +
> +=09KUNIT_ASSERT_EQ(test, tlob_num_monitored_read(), 0);
> +
> +=09for (i =3D 0; i < TLOB_MAX_MONITORED; i++) {
> +=09=09init_completion(&ctxs[i].start);
> +=09=09init_completion(&ctxs[i].done);
> +
> +=09=09threads[i] =3D kthread_run(tlob_waiter_fn, &ctxs[i],
> +=09=09=09=09=09 "tlob_waiter_%d", i);
> +=09=09if (IS_ERR(threads[i])) {
> +=09=09=09KUNIT_FAIL(test, "kthread_run failed at i=3D%d", i);
> +=09=09=09threads[i] =3D NULL;
> +=09=09=09goto cleanup;
> +=09=09}
> +=09=09get_task_struct(threads[i]);
> +
> +=09=09ret =3D tlob_start_task(threads[i], 10000000ULL);
> +=09=09if (ret !=3D 0) {
> +=09=09=09KUNIT_FAIL(test, "tlob_start_task failed at i=3D%d:
> %d",
> +=09=09=09=09=C2=A0=C2=A0 i, ret);
> +=09=09=09put_task_struct(threads[i]);
> +=09=09=09complete(&ctxs[i].start);
> +=09=09=09threads[i] =3D NULL;
> +=09=09=09goto cleanup;
> +=09=09}
> +=09}
> +
> +=09ret =3D tlob_start_task(current, 10000000ULL);
> +=09KUNIT_EXPECT_EQ(test, ret, -ENOSPC);
> +
> +cleanup:
> +=09/* cancel monitoring and unblock first, then wait for full exit */
> +=09for (i =3D 0; i < TLOB_MAX_MONITORED; i++) {
> +=09=09if (!threads[i])
> +=09=09=09break;
> +=09=09tlob_stop_task(threads[i]);
> +=09=09complete(&ctxs[i].start);
> +=09}
> +=09for (i =3D 0; i < TLOB_MAX_MONITORED; i++) {
> +=09=09if (!threads[i])
> +=09=09=09break;
> +=09=09kthread_stop(threads[i]);
> +=09=09put_task_struct(threads[i]);
> +=09}
> +}
> +
> +/*
> + * Holder kthread holds a mutex for 80 ms; arm a 10 ms budget, burn ~1 m=
s
> + * on-CPU, then block on the mutex; timer fires while sleeping -> -EOVER=
FLOW.
> + */
> +struct tlob_holder_ctx {
> +=09struct mutex=09=09lock;
> +=09struct completion=09ready;
> +=09unsigned int=09=09hold_ms;
> +};
> +
> +static int tlob_holder_fn(void *arg)
> +{
> +=09struct tlob_holder_ctx *ctx =3D arg;
> +
> +=09mutex_lock(&ctx->lock);
> +=09complete(&ctx->ready);
> +=09msleep(ctx->hold_ms);
> +=09mutex_unlock(&ctx->lock);
> +=09return 0;
> +}
> +
> +static void tlob_deadline_fires_sleeping(struct kunit *test)
> +{
> +=09struct tlob_holder_ctx *ctx;
> +=09struct tlob_kthread_guard *guard;
> +=09struct task_struct *holder;
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, ctx);
> +=09ctx->hold_ms =3D 80;
> +=09mutex_init(&ctx->lock);
> +=09init_completion(&ctx->ready);
> +
> +=09holder =3D kthread_run(tlob_holder_fn, ctx, "tlob_holder_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, holder);
> +=09get_task_struct(holder);
> +
> +=09guard =3D tlob_guard_kthread(test, holder, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard);
> +
> +=09wait_for_completion(&ctx->ready);
> +
> +=09ret =3D tlob_start_task(current, 10000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 1000)
> +=09=09cpu_relax();
> +
> +=09/* block on mutex: running->sleeping; timer fires while sleeping */
> +=09mutex_lock(&ctx->lock);
> +=09mutex_unlock(&ctx->lock);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -EOVERFLOW);
> +
> +=09guard->task =3D NULL;
> +=09kthread_stop(holder);
> +=09put_task_struct(holder);
> +}
> +
> +/*
> + * yield() triggers a preempt sched_switch (prev_state=3D=3D0): running-=
>waiting.
> + * Busy-spin 50 ms so the 2 ms budget fires regardless of scheduler timi=
ng.
> + */
> +static void tlob_deadline_fires_waiting(struct kunit *test)
> +{
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09ret =3D tlob_start_task(current, 2000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09yield();
> +
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 50000)
> +=09=09cpu_relax();
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -EOVERFLOW);
> +}
> +
> +/* Arm a 1 ms budget and busy-spin for 50 ms; timer fires in running sta=
te.
> */
> +static void tlob_deadline_fires_running(struct kunit *test)
> +{
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09ret =3D tlob_start_task(current, 1000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 50000)
> +=09=09cpu_relax();
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -EOVERFLOW);
> +}
> +
> +/* Start three tasks, reinit monitor, verify all entries are gone. */
> +static int tlob_dummy_fn(void *arg)
> +{
> +=09wait_for_completion((struct completion *)arg);
> +=09return 0;
> +}
> +
> +static void tlob_reinit_clears_all(struct kunit *test)
> +{
> +=09struct completion *done1, *done2;
> +=09struct tlob_kthread_guard *guard1, *guard2;
> +=09struct task_struct *t1, *t2;
> +=09int ret;
> +
> +=09done1 =3D kunit_kzalloc(test, sizeof(*done1), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, done1);
> +=09done2 =3D kunit_kzalloc(test, sizeof(*done2), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, done2);
> +
> +=09init_completion(done1);
> +=09init_completion(done2);
> +
> +=09t1 =3D kthread_run(tlob_dummy_fn, done1, "tlob_dummy1");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t1);
> +=09get_task_struct(t1);
> +=09guard1 =3D tlob_guard_kthread(test, t1, done1);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard1);
> +
> +=09t2 =3D kthread_run(tlob_dummy_fn, done2, "tlob_dummy2");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t2);
> +=09get_task_struct(t2);
> +=09guard2 =3D tlob_guard_kthread(test, t2, done2);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard2);
> +
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(current, 10000000ULL), 0);
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(t1, 10000000ULL), 0);
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(t2, 10000000ULL), 0);
> +
> +=09tlob_destroy_monitor();
> +=09ret =3D tlob_init_monitor();
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(t1), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(t2), -ESRCH);
> +
> +=09/* null guards before teardown to prevent double-stop */
> +=09guard1->task =3D NULL;
> +=09guard2->task =3D NULL;
> +=09complete(done1);
> +=09complete(done2);
> +=09kthread_stop(t1);
> +=09kthread_stop(t2);
> +=09put_task_struct(t1);
> +=09put_task_struct(t2);
> +}
> +
> +static int tlob_task_api_suite_init(struct kunit_suite *suite)
> +{
> +=09rv_kunit_monitoring_on();
> +=09return tlob_init_monitor();
> +}
> +
> +static void tlob_task_api_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_destroy_monitor();
> +=09rv_kunit_monitoring_off();
> +}
> +
> +static void tlob_task_api_exit(struct kunit *test)
> +{
> +=09/*
> +=09 * tlob_stop_task() returns pool slots via call_rcu
> (da_pool_return_cb).
> +=09 * Wait for all pending callbacks so each test starts with a full
> pool.
> +=09 */
> +=09rcu_barrier();
> +}
> +
> +static struct kunit_case tlob_task_api_cases[] =3D {
> +=09KUNIT_CASE(tlob_start_stop_ok),
> +=09KUNIT_CASE(tlob_double_start),
> +=09KUNIT_CASE(tlob_stop_without_start),
> +=09KUNIT_CASE(tlob_zero_threshold),
> +=09KUNIT_CASE(tlob_immediate_deadline),
> +=09KUNIT_CASE(tlob_enospc),
> +=09KUNIT_CASE(tlob_deadline_fires_sleeping),
> +=09KUNIT_CASE(tlob_deadline_fires_waiting),
> +=09KUNIT_CASE(tlob_deadline_fires_running),
> +=09KUNIT_CASE(tlob_reinit_clears_all),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_task_api_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_task_api",
> +=09.suite_init =3D tlob_task_api_suite_init,
> +=09.suite_exit =3D tlob_task_api_suite_exit,
> +=09.exit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D tlob_task_api_exit,
> +=09.test_cases =3D tlob_task_api_cases,
> +};
> +
> +/* Suite 2: sched integration - per-state ns accounting. */
> +
> +struct tlob_ping_ctx {
> +=09struct completion ping;
> +=09struct completion pong;
> +};
> +
> +static int tlob_ping_fn(void *arg)
> +{
> +=09struct tlob_ping_ctx *ctx =3D arg;
> +
> +=09wait_for_completion(&ctx->ping);
> +=09complete(&ctx->pong);
> +=09return 0;
> +}
> +
> +/* Force two context switches and verify stop returns 0 (within budget).=
 */
> +static void tlob_sched_switch_accounting(struct kunit *test)
> +{
> +=09struct tlob_ping_ctx *ctx;
> +=09struct tlob_kthread_guard *guard;
> +=09struct task_struct *peer;
> +=09int ret;
> +
> +=09ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, ctx);
> +=09init_completion(&ctx->ping);
> +=09init_completion(&ctx->pong);
> +
> +=09peer =3D kthread_run(tlob_ping_fn, ctx, "tlob_ping_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, peer);
> +=09get_task_struct(peer);
> +
> +=09guard =3D tlob_guard_kthread(test, peer, &ctx->ping);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard);
> +
> +=09ret =3D tlob_start_task(current, 5000000ULL);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* complete(ping) -> peer runs, forcing a context switch out and back
> */
> +=09complete(&ctx->ping);
> +=09wait_for_completion(&ctx->pong);
> +
> +=09ret =3D tlob_stop_task(current);
> +=09KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +=09guard->task =3D NULL;
> +=09kthread_stop(peer);
> +=09put_task_struct(peer);
> +}
> +
> +/* start/stop monitoring a kthread other than current */
> +static int tlob_block_fn(void *arg)
> +{
> +=09struct completion *done =3D arg;
> +
> +=09msleep(20);
> +=09complete(done);
> +=09return 0;
> +}
> +
> +static void tlob_monitor_other_task(struct kunit *test)
> +{
> +=09struct completion *done;
> +=09struct tlob_kthread_guard *guard;
> +=09struct task_struct *target;
> +=09int ret;
> +
> +=09done =3D kunit_kzalloc(test, sizeof(*done), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, done);
> +=09init_completion(done);
> +
> +=09target =3D kthread_run(tlob_block_fn, done, "tlob_target_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, target);
> +=09get_task_struct(target);
> +
> +=09guard =3D tlob_guard_kthread(test, target, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard);
> +
> +=09ret =3D tlob_start_task(target, 5000000ULL);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09wait_for_completion(done);
> +
> +=09/* 5 s budget won't fire in 20 ms; 0 or -EOVERFLOW are both valid */
> +=09ret =3D tlob_stop_task(target);
> +=09KUNIT_EXPECT_TRUE(test, ret =3D=3D 0 || ret =3D=3D -EOVERFLOW);
> +
> +=09guard->task =3D NULL;
> +=09kthread_stop(target);
> +=09put_task_struct(target);
> +}
> +
> +static int tlob_sched_suite_init(struct kunit_suite *suite)
> +{
> +=09rv_kunit_monitoring_on();
> +=09return tlob_init_monitor();
> +}
> +
> +static void tlob_sched_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_destroy_monitor();
> +=09rv_kunit_monitoring_off();
> +}
> +
> +static struct kunit_case tlob_sched_integration_cases[] =3D {
> +=09KUNIT_CASE(tlob_sched_switch_accounting),
> +=09KUNIT_CASE(tlob_monitor_other_task),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_sched_integration_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_sched_integration=
",
> +=09.suite_init =3D tlob_sched_suite_init,
> +=09.suite_exit =3D tlob_sched_suite_exit,
> +=09.test_cases =3D tlob_sched_integration_cases,
> +};
> +
> +/* Suite 3: uprobe binding format - add/remove acceptance and rejection.=
 */
> +
> +static const char * const tlob_format_valid[] =3D {
> +=09"p /usr/bin/myapp:4768 4848 threshold=3D5000",
> +=09"p /usr/bin/myapp:0x12a0 0x12f0 threshold=3D10000",
> +=09"p /opt/my:app/bin:0x100 0x200 threshold=3D1000",
> +};
> +
> +static const char * const tlob_format_invalid[] =3D {
> +=09/* add: malformed */
> +=09"p /usr/bin/myapp:0x100 0x200 threshold=3D0",
> +=09"p :0x100 0x200 threshold=3D5000",
> +=09"p /usr/bin/myapp:0x100 threshold=3D5000",
> +=09"p /usr/bin/myapp:-1 0x200 threshold=3D5000",
> +=09"p /usr/bin/myapp:0x100 0x200",
> +=09"p /usr/bin/myapp:0x100 0x100 threshold=3D5000",
> +=09/* remove: malformed */
> +=09"-usr/bin/myapp:0x100",
> +=09"-/usr/bin/myapp",
> +=09"-/:0x100",
> +=09"-/usr/bin/myapp:abc",
> +};
> +
> +/*
> + * Valid add lines return -ENOENT (path does not exist in the test
> environment)
> + * rather than 0; a non-(-EINVAL) return confirms the format was accepte=
d.
> + */
> +static void tlob_format_accepted(struct kunit *test)
> +{
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_format_valid); i++) {
> +=09=09strscpy(buf, tlob_format_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_NE(test, tlob_create_or_delete_uprobe(buf), -
> EINVAL);
> +=09}
> +}
> +
> +static void tlob_format_rejected(struct kunit *test)
> +{
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_format_invalid); i++) {
> +=09=09strscpy(buf, tlob_format_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_create_or_delete_uprobe(buf), -
> EINVAL);
> +=09}
> +}
> +
> +static struct kunit_case tlob_uprobe_format_cases[] =3D {
> +=09KUNIT_CASE(tlob_format_accepted),
> +=09KUNIT_CASE(tlob_format_rejected),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_uprobe_format_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_uprobe_format",
> +=09.test_cases =3D tlob_uprobe_format_cases,
> +};
> +
> +/* Suite 4: trace output - verify event_tlob and error_env_tlob field va=
lues.
> */
> +
> +static void tlob_trace_event_format(struct kunit *test)
> +{
> +=09const struct tlob_captured_event *ev;
> +=09int pid =3D current->pid;
> +=09int ret;
> +
> +=09tlob_event_count_reset();
> +=09ret =3D tlob_start_task(current, 5000000ULL);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* sleep/wakeup/switch_in: running->sleeping->waiting->running */
> +=09msleep(20);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), 0);
> +
> +=09KUNIT_EXPECT_GE(test, tlob_event_count_read(), 3);
> +
> +=09ev =3D tlob_last_event_read();
> +=09KUNIT_EXPECT_EQ(test,=C2=A0=C2=A0=C2=A0 ev->id,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid);
> +=09KUNIT_EXPECT_STREQ(test, ev->state,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "waiting");
> +=09KUNIT_EXPECT_STREQ(test, ev->event,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "switch_in");
> +=09KUNIT_EXPECT_STREQ(test, ev->next_state,=C2=A0 "running");
> +=09KUNIT_EXPECT_TRUE(test,=C2=A0 ev->final_state);
> +}
> +
> +static void tlob_trace_error_env_format(struct kunit *test)
> +{
> +=09const struct tlob_captured_error_env *err;
> +=09ktime_t t0;
> +=09int pid =3D current->pid;
> +=09int ret;
> +
> +=09tlob_error_env_count_reset();
> +=09ret =3D tlob_start_task(current, 1000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 50000)
> +=09=09cpu_relax();
> +
> +=09tlob_stop_task(current);
> +
> +=09KUNIT_ASSERT_GE(test, tlob_error_env_count_read(), 1);
> +
> +=09err =3D tlob_last_error_env_read();
> +=09KUNIT_EXPECT_EQ(test,=C2=A0=C2=A0=C2=A0 err->id,=C2=A0=C2=A0=C2=A0 pi=
d);
> +=09KUNIT_EXPECT_STREQ(test, err->state, "running");
> +=09KUNIT_EXPECT_STREQ(test, err->event, "budget_exceeded");
> +=09KUNIT_EXPECT_TRUE(test, strncmp(err->env, "clk_elapsed=3D", 12) =3D=
=3D 0);
> +}
> +
> +static int tlob_trace_suite_init(struct kunit_suite *suite)
> +{
> +=09int ret;
> +
> +=09rv_kunit_monitoring_on();
> +=09ret =3D tlob_init_monitor();
> +=09if (ret)
> +=09=09goto err_mon_off;
> +=09ret =3D tlob_register_kunit_probes();
> +=09if (ret)
> +=09=09goto err_destroy;
> +=09ret =3D tlob_enable_hooks();
> +=09if (ret)
> +=09=09goto err_probes;
> +=09return 0;
> +
> +err_probes:
> +=09tlob_unregister_kunit_probes();
> +err_destroy:
> +=09tlob_destroy_monitor();
> +err_mon_off:
> +=09rv_kunit_monitoring_off();
> +=09return ret;
> +}
> +
> +static void tlob_trace_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_disable_hooks();
> +=09tlob_unregister_kunit_probes();
> +=09tlob_destroy_monitor();
> +=09rv_kunit_monitoring_off();
> +}
> +
> +static struct kunit_case tlob_trace_output_cases[] =3D {
> +=09KUNIT_CASE(tlob_trace_event_format),
> +=09KUNIT_CASE(tlob_trace_error_env_format),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_trace_output_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_trace_output",
> +=09.suite_init =3D tlob_trace_suite_init,
> +=09.suite_exit =3D tlob_trace_suite_exit,
> +=09.test_cases =3D tlob_trace_output_cases,
> +};
> +
> +/*
> + * Suite 5: violation reaction - complement to Suite 4.
> + * Suite 4 checks trace field values; Suite 5 checks semantics:
> + * error count per budget expiry and per-state ns breakdown.
> + */
> +
> +/* generous budget; usleep forces state transitions; no error must fire =
*/
> +static void tlob_no_error_within_budget(struct kunit *test)
> +{
> +=09tlob_error_env_count_reset();
> +=09tlob_event_count_reset();
> +
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(current, 10000000ULL), 0);
> +=09usleep_range(5000, 10000);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_error_env_count_read(), 0);
> +=09KUNIT_EXPECT_GE(test, tlob_event_count_read(), 2);
> +}
> +
> +/* busy-spin 50 ms >> 1 ms budget; running_ns must dominate */
> +static void tlob_detail_running_dominates(struct kunit *test)
> +{
> +=09const struct tlob_captured_detail *d;
> +=09u64 total_ns;
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09tlob_error_env_count_reset();
> +
> +=09ret =3D tlob_start_task(current, 1000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 50000)
> +=09=09cpu_relax();
> +
> +=09tlob_stop_task(current);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_error_env_count_read(), 1);
> +=09d =3D tlob_last_detail_read();
> +=09KUNIT_EXPECT_EQ(test, d->pid, current->pid);
> +=09KUNIT_EXPECT_EQ(test, d->threshold_us, 1000ULL);
> +=09total_ns =3D d->running_ns + d->waiting_ns + d->sleeping_ns;
> +=09KUNIT_EXPECT_GE(test, total_ns, 1000ULL * 1000);
> +=09KUNIT_EXPECT_GT(test, d->running_ns, d->sleeping_ns + d->waiting_ns);
> +}
> +
> +struct tlob_hog_ctx {
> +=09int spin_ms;
> +};
> +
> +static int tlob_hog_fn(void *arg)
> +{
> +=09struct tlob_hog_ctx *ctx =3D arg;
> +=09ktime_t t0 =3D ktime_get();
> +
> +=09while (!kthread_should_stop() &&
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_ms_delta(ktime_get(), t0) =
< ctx->spin_ms)
> +=09=09cpu_relax();
> +=09return 0;
> +}
> +
> +/*
> + * SCHED_FIFO kthread bound to the same CPU preempts the monitored task
> + * (sched_switch prev_state =3D=3D 0: running->waiting) and holds the CP=
U for
> + * 80 ms >> 10 ms budget, guaranteeing the timer fires in waiting state.
> + */
> +static void tlob_detail_waiting_dominates(struct kunit *test)
> +{
> +=09struct tlob_hog_ctx *ctx;
> +=09struct task_struct *hog;
> +=09struct tlob_kthread_guard *guard;
> +=09const struct tlob_captured_detail *d;
> +=09struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO - 1 };
> +=09int ret;
> +
> +=09tlob_error_env_count_reset();
> +
> +=09ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, ctx);
> +=09ctx->spin_ms =3D 80;
> +
> +=09hog =3D kthread_create(tlob_hog_fn, ctx, "tlob_s5_hog");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hog);
> +=09get_task_struct(hog);
> +
> +=09kthread_bind(hog, smp_processor_id());
> +=09sched_setscheduler_nocheck(hog, SCHED_FIFO, &param);
> +
> +=09guard =3D tlob_guard_kthread(test, hog, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard);
> +
> +=09ret =3D tlob_start_task(current, 10000); /* 10 ms budget */
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09wake_up_process(hog);
> +=09yield(); /* sched_switch prev_state =3D=3D 0: running->waiting */
> +
> +=09tlob_stop_task(current);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_error_env_count_read(), 1);
> +=09d =3D tlob_last_detail_read();
> +=09KUNIT_EXPECT_EQ(test, d->sleeping_ns, 0ULL);
> +=09KUNIT_EXPECT_GT(test, d->waiting_ns, d->running_ns + d->sleeping_ns);
> +
> +=09guard->task =3D NULL;
> +=09kthread_stop(hog);
> +=09put_task_struct(hog);
> +}
> +
> +/* block on mutex for 80 ms >> 10 ms budget; sleeping_ns must dominate *=
/
> +static void tlob_detail_sleeping_dominates(struct kunit *test)
> +{
> +=09struct tlob_holder_ctx *ctx;
> +=09struct tlob_kthread_guard *guard;
> +=09struct task_struct *holder;
> +=09const struct tlob_captured_detail *d;
> +=09int ret;
> +
> +=09tlob_error_env_count_reset();
> +
> +=09ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +=09KUNIT_ASSERT_NOT_NULL(test, ctx);
> +=09ctx->hold_ms =3D 80;
> +=09mutex_init(&ctx->lock);
> +=09init_completion(&ctx->ready);
> +
> +=09holder =3D kthread_run(tlob_holder_fn, ctx, "tlob_s5_detail");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, holder);
> +=09get_task_struct(holder);
> +
> +=09guard =3D tlob_guard_kthread(test, holder, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, guard);
> +
> +=09wait_for_completion(&ctx->ready);
> +
> +=09ret =3D tlob_start_task(current, 10000);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09mutex_lock(&ctx->lock);
> +=09mutex_unlock(&ctx->lock);
> +
> +=09tlob_stop_task(current);
> +
> +=09KUNIT_EXPECT_EQ(test, tlob_error_env_count_read(), 1);
> +=09d =3D tlob_last_detail_read();
> +=09KUNIT_EXPECT_GT(test, d->sleeping_ns, d->running_ns + d->waiting_ns);
> +
> +=09guard->task =3D NULL;
> +=09kthread_stop(holder);
> +=09put_task_struct(holder);
> +}
> +
> +static int tlob_violation_suite_init(struct kunit_suite *suite)
> +{
> +=09int ret;
> +
> +=09rv_kunit_monitoring_on();
> +=09ret =3D tlob_init_monitor();
> +=09if (ret)
> +=09=09goto err_mon_off;
> +=09ret =3D tlob_register_kunit_probes();
> +=09if (ret)
> +=09=09goto err_destroy;
> +=09ret =3D tlob_enable_hooks();
> +=09if (ret)
> +=09=09goto err_probes;
> +=09return 0;
> +
> +err_probes:
> +=09tlob_unregister_kunit_probes();
> +err_destroy:
> +=09tlob_destroy_monitor();
> +err_mon_off:
> +=09rv_kunit_monitoring_off();
> +=09return ret;
> +}
> +
> +static void tlob_violation_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_disable_hooks();
> +=09tlob_unregister_kunit_probes();
> +=09tlob_destroy_monitor();
> +=09rv_kunit_monitoring_off();
> +}
> +
> +static struct kunit_case tlob_violation_react_cases[] =3D {
> +=09KUNIT_CASE(tlob_no_error_within_budget),
> +=09KUNIT_CASE(tlob_detail_running_dominates),
> +=09KUNIT_CASE(tlob_detail_sleeping_dominates),
> +=09KUNIT_CASE(tlob_detail_waiting_dominates),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_violation_react_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_violation_react",
> +=09.suite_init =3D tlob_violation_suite_init,
> +=09.suite_exit =3D tlob_violation_suite_exit,
> +=09.test_cases =3D tlob_violation_react_cases,
> +};
> +
> +kunit_test_suites(&tlob_task_api_suite,
> +=09=09=C2=A0 &tlob_sched_integration_suite,
> +=09=09=C2=A0 &tlob_uprobe_format_suite,
> +=09=09=C2=A0 &tlob_trace_output_suite,
> +=09=09=C2=A0 &tlob_violation_react_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for the tlob RV monitor");
> +MODULE_LICENSE("GPL");

