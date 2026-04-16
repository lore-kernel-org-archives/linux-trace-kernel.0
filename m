Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316F34D3BE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341397; cv=none; b=QfV3lArGcBilWkw6h8MYlt73rIFAaTlZf0LuSWlUKU8+dC4lt+Rg0UpY+KftUco6fX6ff7uXZpWc4psSCRbBIU6+ZkqIGN+WDgLIeWqxP21F2LOs0GIQcVxGJhRoBSqeqoaheJP206NIf7OZHxccQo8yHQOldnWu9SacqsJ5xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341397; c=relaxed/simple;
	bh=vZUpbe4Nq5AzSB75xO1D91OeaKMxlGfbPN+Pra96jg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItPBHz0k2qc8/8DbbuzXB6w18Gk4y4WqsTNy4r6jb4oyroahJytaB1IYS59UTlOW99/FCDfyw1EIxjZxDv6gZdLSHHVqQ+PRyQJwsmUtUZoQ2uKem3zRHxddCFJkc8zIA8jMImTmodEEpXZUnIwoKIvrxVRo1pd2koRy+LLseuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8dlDRVQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8dlDRVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776341393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vZUpbe4Nq5AzSB75xO1D91OeaKMxlGfbPN+Pra96jg4=;
	b=B8dlDRVQv/NfWYXZC0v9y3ul5HRXqAE+vFjcuvF53bNWcXmNAMWaX0SV8Dy1KsJ52XWkjo
	7B/T25pfKxWIEQGvmSkA1CKwK6pB2Pf//930gv5YI16rnKX4hqpeBuulYpZ0L4Qzw5TmcN
	TSDM1M54pnekNlkZWeQEVUITFkU1M/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Ulvn4CdkOqekf4QpDiFeeA-1; Thu, 16 Apr 2026 08:09:52 -0400
X-MC-Unique: Ulvn4CdkOqekf4QpDiFeeA-1
X-Mimecast-MFC-AGG-ID: Ulvn4CdkOqekf4QpDiFeeA_1776341391
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488e097a270so37953435e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 05:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341391; x=1776946191;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBeTPIdOmLFHeL5xdgYC5Nuop26QGWWrfcP79AQppPI=;
        b=IcKo0robUqmzxcKgUoPizPAmCJ9+fJZixOz2s3NVT/8jXNtrf9lwHp26QDtOWUoJ3z
         KLU9yUCqFao85ByaZ9ClhsAx1noWWfj1ixZdff9nJXJ3g0HCwlzsI95QfpjHyErYl+mF
         0CcYQGnYcBgxRAbw7+aLNm0TZr3OHmNNv0vuRBtUCVyJIt4SGIZV6z22sT4y4A5ny1DK
         qk18BLavf7JrQVK2nifOVaox8kPq2WcxWcuzO5ntgdT1D3AWJIWaZnQY1eudHPPdIYOB
         O4mR8hxVhw6QBSQTDPCjft51CMHOtw8yHySDJXqTMUOI7uMXLQ54BprQGwUsi6b7i63A
         Q+Rw==
X-Gm-Message-State: AOJu0Ywhf+MWwQ6AqE9Xp4auX/aHEVqUV9ph94hIRNuNJaz06YQ0Ln+u
	XmDgfC9WGrRHQZLXmlwtvy9SYYOEmlW26nz6x8OjE4M4p3I2yZGk9sNv9Xs5sMeL3bZJ+v1MZr2
	/RNbhldFp1WTuiyjo/Hz6grXOL/N98hTM0yeJgdIeDZriWdrW1BM08a+jIiFG8exy3E703dxrCZ
	kEwmot2Nmq
X-Gm-Gg: AeBDieueNuK5uQbRgeG2UVUT9GCv9D9TOXSKMDvclh9Mp1ePaF5GaYzLtSWLRYiOFVJ
	J/SXWyW3cBXMYO7i5cMw+ZI56536TluY7sWuVAIXPjZapxD0O7FWI2terhOS1xPE5XHoGbLjxEp
	rTHHXlRCFNtSlM6YrKQCaW3139a2803xfRtyfwNoEAKhgV12ablw0VtpHZCdz1bvCT7DbPRivNJ
	rDf0Zmm9PD5MEyHE2GrwyIyZTW8wjZfhIoU2pp2eMx3lYzawlbZMfCTsQrjODSBJsRlOTcecqTF
	eCuKYTSJnrIQYJ0tq8FgDm6DGMTb4hay9n2FK65sOQp491NtE6bvVDObIISHPlSPRW99gyMBVNg
	6iXf1xLpl6JEPrUgUaXP0CRhk6zOa1VnwUnD2FKcLwaXrtMiz0eDZmmiB20GP9EtPtRKy3GKR1Y
	dtdyaAUpi8R/ceSQch2d9rt0VSHQ==
X-Received: by 2002:a05:600c:8585:b0:488:ba19:da25 with SMTP id 5b1f17b1804b1-488d6822a0bmr256272675e9.12.1776341390513;
        Thu, 16 Apr 2026 05:09:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8585:b0:488:ba19:da25 with SMTP id 5b1f17b1804b1-488d6822a0bmr256272095e9.12.1776341389745;
        Thu, 16 Apr 2026 05:09:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f58163cbsm49018055e9.1.2026.04.16.05.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:09:49 -0700 (PDT)
Message-ID: <e7180f342f27d49d259d6908ac170f0da718a357.camel@redhat.com>
Subject: Re: [RFC PATCH 3/4] rv/tlob: Add KUnit tests for the tlob monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Thu, 16 Apr 2026 14:09:47 +0200
In-Reply-To: <0a7f41ff8cb13f8601920ead2979db2ee5f2d442.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
	 <0a7f41ff8cb13f8601920ead2979db2ee5f2d442.1776020428.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6lOgmBgj_2FDl356CgjCrImQvA0DDMnqslI1sSXoRLk_1776341391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 03:27 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add six KUnit test suites gated behind CONFIG_TLOB_KUNIT_TEST
> (depends on RV_MON_TLOB && KUNIT; default KUNIT_ALL_TESTS).
> A .kunitconfig fragment is provided for the kunit.py runner.
>=20
> Coverage: automaton state transitions and self-loops; start/stop API
> error paths (duplicate start, missing start, overflow threshold,
> table-full, immediate deadline); scheduler context-switch accounting
> for on/off-CPU time; violation tracepoint payload fields; ring buffer
> push, drop-new overflow, and wakeup; and the uprobe line parser.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

I was considering adding Kunit tests and thought to have them a bit more
integrated ([1] if you want to have a peek before I submit it for RFC, mind=
 it's
a bit raw).

The problem with reimplementing the da_handle_event() is that you are in fa=
ct
validating only the model matrix, several other things could go wrong befor=
e you
get there (whether the monitor was started properly, other things you might=
 be
doing from the tracepoint handler before you handle events, etc.).

Also, I believe it's a bit of an overkill to validate every single transiti=
on
like this, especially considering the work once you update the model for
whatever reason.

One meaningful thing to validate is that a certain sequence of events with =
a
certain timing causes a violation (or if you want, that a good sequence doe=
s
not), for instance. But that's just my opinion, of course.

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/tlob/.kunitconfig |=C2=A0=C2=A0=C2=A0 5 +
> =C2=A0kernel/trace/rv/monitors/tlob/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 12 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.c | 1194 +++++++++++++++++=
+++
> =C2=A05 files changed, 1213 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
>=20
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index cc3781a3b..6d963207d 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_RV_MON_NRP) +=3D monitors/nrp/nrp.o
> =C2=A0obj-$(CONFIG_RV_MON_SSSW) +=3D monitors/sssw/sssw.o
> =C2=A0obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> =C2=A0obj-$(CONFIG_RV_MON_TLOB) +=3D monitors/tlob/tlob.o
> +obj-$(CONFIG_TLOB_KUNIT_TEST) +=3D monitors/tlob/tlob_kunit.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/tlob/.kunitconfig
> b/kernel/trace/rv/monitors/tlob/.kunitconfig
> new file mode 100644
> index 000000000..977c58601
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_FTRACE=3Dy
> +CONFIG_KUNIT=3Dy
> +CONFIG_RV=3Dy
> +CONFIG_RV_MON_TLOB=3Dy
> +CONFIG_TLOB_KUNIT_TEST=3Dy
> diff --git a/kernel/trace/rv/monitors/tlob/Kconfig
> b/kernel/trace/rv/monitors/tlob/Kconfig
> index 010237480..4ccd2f881 100644
> --- a/kernel/trace/rv/monitors/tlob/Kconfig
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -49,3 +49,15 @@ config RV_MON_TLOB
> =C2=A0=09=C2=A0 For further information, see:
> =C2=A0=09=C2=A0=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> =C2=A0
> +config TLOB_KUNIT_TEST
> +=09tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS
> +=09depends on RV_MON_TLOB && KUNIT
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 Enable KUnit in-kernel unit tests for the tlob RV monitor.
> +
> +=09=C2=A0 Tests cover automaton state transitions, the hash table helper=
s,
> +=09=C2=A0 the start/stop task interface, and the event ring buffer inclu=
ding
> +=09=C2=A0 overflow handling and wakeup behaviour.
> +
> +=09=C2=A0 Say Y or M here to run the tlob KUnit test suite; otherwise sa=
y N.
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> index a6e474025..dd959eb9b 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -784,6 +784,7 @@ VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf=
, u64
> *thr_out,
> =C2=A0=09*path_out=C2=A0 =3D buf + n;
> =C2=A0=09return 0;
> =C2=A0}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
> =C2=A0
> =C2=A0static ssize_t tlob_monitor_write(struct file *file,
> =C2=A0=09=09=09=09=C2=A0 const char __user *ubuf,
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> new file mode 100644
> index 000000000..64f5abb34
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> @@ -0,0 +1,1194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the tlob RV monitor.
> + *
> + * tlob_automaton:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DA tr=
ansition table coverage.
> + * tlob_task_api:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tlob_start_task()/tlob_stop_task() lifecycle and
> errors.
> + * tlob_sched_integration: on/off-CPU accounting across real context
> switches.
> + * tlob_trace_output:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_budget_exceeded=
 tracepoint field
> verification.
> + * tlob_event_buf:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring =
buffer push, overflow, and wakeup.
> + * tlob_parse_uprobe:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uprobe format string=
 parser acceptance and
> rejection.
> + *
> + * The duplicate-(binary, offset_start) constraint enforced by
> tlob_add_uprobe()
> + * is not covered here: that function calls kern_path() and requires a r=
eal
> + * filesystem, which is outside the scope of unit tests. It is covered b=
y the
> + * uprobe_duplicate_offset case in tools/testing/selftests/rv/test_tlob.=
sh.
> + */
> +#include <kunit/test.h>
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/ktime.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <linux/tracepoint.h>
> +
> +/*
> + * Pull in the rv tracepoint declarations so that
> + * register_trace_tlob_budget_exceeded() is available.
> + * No CREATE_TRACE_POINTS here=C2=A0 --=C2=A0 the tracepoint implementat=
ion lives in
> rv.c.
> + */
> +#include <rv_trace.h>
> +
> +#include "tlob.h"
> +
> +/*
> + * da_handle_event_tlob - apply one automaton transition on @da_mon.
> + *
> + * This helper is used only by the KUnit automaton suite. It applies the
> + * tlob transition table directly on a supplied da_monitor without touch=
ing
> + * per-task slots, tracepoints, or timers.
> + */
> +static void da_handle_event_tlob(struct da_monitor *da_mon,
> +=09=09=09=09 enum events_tlob event)
> +{
> +=09enum states_tlob curr_state =3D (enum states_tlob)da_mon->curr_state;
> +=09enum states_tlob next_state =3D
> +=09=09(enum states_tlob)automaton_tlob.function[curr_state][event];
> +
> +=09if (next_state !=3D INVALID_STATE)
> +=09=09da_mon->curr_state =3D next_state;
> +}
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +/*
> + * Suite 1: automaton state-machine transitions
> + */
> +
> +/* unmonitored -> trace_start -> on_cpu */
> +static void tlob_unmonitored_to_on_cpu(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D unmonitored_tlob };
> +
> +=09da_handle_event_tlob(&mon, trace_start_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +}
> +
> +/* on_cpu -> switch_out -> off_cpu */
> +static void tlob_on_cpu_switch_out(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D on_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, switch_out_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)off_cpu_tlob);
> +}
> +
> +/* off_cpu -> switch_in -> on_cpu */
> +static void tlob_off_cpu_switch_in(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D off_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, switch_in_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +}
> +
> +/* on_cpu -> budget_expired -> unmonitored */
> +static void tlob_on_cpu_budget_expired(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D on_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, budget_expired_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +/* off_cpu -> budget_expired -> unmonitored */
> +static void tlob_off_cpu_budget_expired(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D off_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, budget_expired_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +/* on_cpu -> trace_stop -> unmonitored */
> +static void tlob_on_cpu_trace_stop(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D on_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, trace_stop_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +/* off_cpu -> trace_stop -> unmonitored */
> +static void tlob_off_cpu_trace_stop(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D off_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, trace_stop_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +/* budget_expired -> unmonitored; a single trace_start re-enters on_cpu.=
 */
> +static void tlob_violation_then_restart(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D unmonitored_tlob };
> +
> +=09da_handle_event_tlob(&mon, trace_start_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +
> +=09da_handle_event_tlob(&mon, budget_expired_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +
> +=09/* Single trace_start is sufficient to re-enter on_cpu */
> +=09da_handle_event_tlob(&mon, trace_start_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +
> +=09da_handle_event_tlob(&mon, trace_stop_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +/* off_cpu self-loops on switch_out and sched_wakeup. */
> +static void tlob_off_cpu_self_loops(struct kunit *test)
> +{
> +=09static const enum events_tlob events[] =3D {
> +=09=09switch_out_tlob, sched_wakeup_tlob,
> +=09};
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(events); i++) {
> +=09=09struct da_monitor mon =3D { .curr_state =3D off_cpu_tlob };
> +
> +=09=09da_handle_event_tlob(&mon, events[i]);
> +=09=09KUNIT_EXPECT_EQ_MSG(test, (int)mon.curr_state,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 (int)off_cpu_tlob,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 "event %u should self-loop in off_cpu",
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 events[i]);
> +=09}
> +}
> +
> +/* on_cpu self-loops on sched_wakeup. */
> +static void tlob_on_cpu_self_loops(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D on_cpu_tlob };
> +
> +=09da_handle_event_tlob(&mon, sched_wakeup_tlob);
> +=09KUNIT_EXPECT_EQ_MSG(test, (int)mon.curr_state, (int)on_cpu_tlob,
> +=09=09=09=C2=A0=C2=A0=C2=A0 "sched_wakeup should self-loop in on_cpu");
> +}
> +
> +/* Scheduling events in unmonitored self-loop (no state change). */
> +static void tlob_unmonitored_ignores_sched(struct kunit *test)
> +{
> +=09static const enum events_tlob events[] =3D {
> +=09=09switch_in_tlob, switch_out_tlob, sched_wakeup_tlob,
> +=09};
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(events); i++) {
> +=09=09struct da_monitor mon =3D { .curr_state =3D unmonitored_tlob };
> +
> +=09=09da_handle_event_tlob(&mon, events[i]);
> +=09=09KUNIT_EXPECT_EQ_MSG(test, (int)mon.curr_state,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 (int)unmonitored_tlob,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 "event %u should self-loop in
> unmonitored",
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 events[i]);
> +=09}
> +}
> +
> +static void tlob_full_happy_path(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D unmonitored_tlob };
> +
> +=09da_handle_event_tlob(&mon, trace_start_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +
> +=09da_handle_event_tlob(&mon, switch_out_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)off_cpu_tlob);
> +
> +=09da_handle_event_tlob(&mon, switch_in_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +
> +=09da_handle_event_tlob(&mon, trace_stop_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +static void tlob_multiple_switches(struct kunit *test)
> +{
> +=09struct da_monitor mon =3D { .curr_state =3D unmonitored_tlob };
> +=09int i;
> +
> +=09da_handle_event_tlob(&mon, trace_start_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +
> +=09for (i =3D 0; i < 3; i++) {
> +=09=09da_handle_event_tlob(&mon, switch_out_tlob);
> +=09=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state,
> (int)off_cpu_tlob);
> +=09=09da_handle_event_tlob(&mon, switch_in_tlob);
> +=09=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)on_cpu_tlob);
> +=09}
> +
> +=09da_handle_event_tlob(&mon, trace_stop_tlob);
> +=09KUNIT_EXPECT_EQ(test, (int)mon.curr_state, (int)unmonitored_tlob);
> +}
> +
> +static struct kunit_case tlob_automaton_cases[] =3D {
> +=09KUNIT_CASE(tlob_unmonitored_to_on_cpu),
> +=09KUNIT_CASE(tlob_on_cpu_switch_out),
> +=09KUNIT_CASE(tlob_off_cpu_switch_in),
> +=09KUNIT_CASE(tlob_on_cpu_budget_expired),
> +=09KUNIT_CASE(tlob_off_cpu_budget_expired),
> +=09KUNIT_CASE(tlob_on_cpu_trace_stop),
> +=09KUNIT_CASE(tlob_off_cpu_trace_stop),
> +=09KUNIT_CASE(tlob_off_cpu_self_loops),
> +=09KUNIT_CASE(tlob_on_cpu_self_loops),
> +=09KUNIT_CASE(tlob_unmonitored_ignores_sched),
> +=09KUNIT_CASE(tlob_full_happy_path),
> +=09KUNIT_CASE(tlob_violation_then_restart),
> +=09KUNIT_CASE(tlob_multiple_switches),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_automaton_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_automaton",
> +=09.test_cases =3D tlob_automaton_cases,
> +};
> +
> +/*
> + * Suite 2: task registration API
> + */
> +
> +/* Basic start/stop cycle */
> +static void tlob_start_stop_ok(struct kunit *test)
> +{
> +=09int ret;
> +
> +=09ret =3D tlob_start_task(current, 10000000 /* 10 s, won't fire */, NUL=
L,
> 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), 0);
> +}
> +
> +/* Double start must return -EEXIST. */
> +static void tlob_double_start(struct kunit *test)
> +{
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(current, 10000000, NULL, 0),
> 0);
> +=09KUNIT_EXPECT_EQ(test, tlob_start_task(current, 10000000, NULL, 0), -
> EEXIST);
> +=09tlob_stop_task(current);
> +}
> +
> +/* Stop without start must return -ESRCH. */
> +static void tlob_stop_without_start(struct kunit *test)
> +{
> +=09tlob_stop_task(current);=C2=A0 /* clear any stale entry first */
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +}
> +
> +/*
> + * A 1 us budget fires before tlob_stop_task() is called. Either the
> + * timer wins (-ESRCH) or we are very fast (0); both are valid.
> + */
> +static void tlob_immediate_deadline(struct kunit *test)
> +{
> +=09int ret =3D tlob_start_task(current, 1 /* 1 us - fires almost
> immediately */, NULL, 0);
> +
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +=09/* Let the 1 us timer fire */
> +=09udelay(100);
> +=09/*
> +=09 * By now the hrtimer has almost certainly fired. Either it has
> +=09 * (returns -ESRCH) or we were very fast (returns 0). Both are
> +=09 * acceptable; just ensure no crash and the table is clean after.
> +=09 */
> +=09ret =3D tlob_stop_task(current);
> +=09KUNIT_EXPECT_TRUE(test, ret =3D=3D 0 || ret =3D=3D -ESRCH);
> +}
> +
> +/*
> + * Fill the table to TLOB_MAX_MONITORED using kthreads (each needs a
> + * distinct task_struct), then verify the next start returns -ENOSPC.
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
> +=09/* Start TLOB_MAX_MONITORED kthreads and monitor each */
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
> +=09=09ret =3D tlob_start_task(threads[i], 10000000, NULL, 0);
> +=09=09if (ret !=3D 0) {
> +=09=09=09KUNIT_FAIL(test, "tlob_start_task failed at i=3D%d:
> %d",
> +=09=09=09=09=C2=A0=C2=A0 i, ret);
> +=09=09=09put_task_struct(threads[i]);
> +=09=09=09complete(&ctxs[i].start);
> +=09=09=09goto cleanup;
> +=09=09}
> +=09}
> +
> +=09/* The table is now full: one more must fail with -ENOSPC */
> +=09ret =3D tlob_start_task(current, 10000000, NULL, 0);
> +=09KUNIT_EXPECT_EQ(test, ret, -ENOSPC);
> +
> +cleanup:
> +=09/*
> +=09 * Two-pass cleanup: cancel tlob monitoring and unblock kthreads
> first,
> +=09 * then kthread_stop() to wait for full exit before releasing refs.
> +=09 */
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
> + * A kthread holds a mutex for 80 ms; arm a 10 ms budget, burn ~1 ms
> + * on-CPU, then block on the mutex. The timer fires off-CPU; stop
> + * must return -ESRCH.
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
> +static void tlob_deadline_fires_off_cpu(struct kunit *test)
> +{
> +=09struct tlob_holder_ctx ctx =3D { .hold_ms =3D 80 };
> +=09struct task_struct *holder;
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09mutex_init(&ctx.lock);
> +=09init_completion(&ctx.ready);
> +
> +=09holder =3D kthread_run(tlob_holder_fn, &ctx, "tlob_holder_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, holder);
> +=09wait_for_completion(&ctx.ready);
> +
> +=09/* Arm 10 ms budget while kthread holds the mutex. */
> +=09ret =3D tlob_start_task(current, 10000, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* Phase 1: burn ~1 ms on-CPU to exercise on_cpu accounting. */
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 1000)
> +=09=09cpu_relax();
> +
> +=09/*
> +=09 * Phase 2: block on the mutex -> on_cpu->off_cpu transition.
> +=09 * The 10 ms budget fires while we are off-CPU.
> +=09 */
> +=09mutex_lock(&ctx.lock);
> +=09mutex_unlock(&ctx.lock);
> +
> +=09/* Timer already fired and removed the entry -> -ESRCH */
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +}
> +
> +/* Arm a 1 ms budget and busy-spin for 50 ms; timer fires on-CPU. */
> +static void tlob_deadline_fires_on_cpu(struct kunit *test)
> +{
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09ret =3D tlob_start_task(current, 1000 /* 1 ms */, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* Busy-spin 50 ms - 50x the budget */
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 50000)
> +=09=09cpu_relax();
> +
> +=09/* Timer fired during the spin; entry is gone */
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +}
> +
> +/*
> + * Start three tasks, call tlob_destroy_monitor() + tlob_init_monitor(),
> + * and verify the table is empty afterwards.
> + */
> +static int tlob_dummy_fn(void *arg)
> +{
> +=09wait_for_completion((struct completion *)arg);
> +=09return 0;
> +}
> +
> +static void tlob_stop_all_cleanup(struct kunit *test)
> +{
> +=09struct completion done1, done2;
> +=09struct task_struct *t1, *t2;
> +=09int ret;
> +
> +=09init_completion(&done1);
> +=09init_completion(&done2);
> +
> +=09t1 =3D kthread_run(tlob_dummy_fn, &done1, "tlob_dummy1");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t1);
> +=09get_task_struct(t1);
> +
> +=09t2 =3D kthread_run(tlob_dummy_fn, &done2, "tlob_dummy2");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t2);
> +=09get_task_struct(t2);
> +
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(current, 10000000, NULL, 0),
> 0);
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(t1, 10000000, NULL, 0), 0);
> +=09KUNIT_ASSERT_EQ(test, tlob_start_task(t2, 10000000, NULL, 0), 0);
> +
> +=09/* Destroy clears all entries via tlob_stop_all() */
> +=09tlob_destroy_monitor();
> +=09ret =3D tlob_init_monitor();
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* Table must be empty now */
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(current), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(t1), -ESRCH);
> +=09KUNIT_EXPECT_EQ(test, tlob_stop_task(t2), -ESRCH);
> +
> +=09complete(&done1);
> +=09complete(&done2);
> +=09/*
> +=09 * completions live on stack; wait for kthreads to exit before
> return.
> +=09 */
> +=09kthread_stop(t1);
> +=09kthread_stop(t2);
> +=09put_task_struct(t1);
> +=09put_task_struct(t2);
> +}
> +
> +/* A threshold that overflows ktime_t must be rejected with -ERANGE. */
> +static void tlob_overflow_threshold(struct kunit *test)
> +{
> +=09/* KTIME_MAX / NSEC_PER_USEC + 1 overflows ktime_t */
> +=09u64 too_large =3D (u64)(KTIME_MAX / NSEC_PER_USEC) + 1;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_start_task(current, too_large, NULL, 0),
> +=09=09-ERANGE);
> +}
> +
> +static int tlob_task_api_suite_init(struct kunit_suite *suite)
> +{
> +=09return tlob_init_monitor();
> +}
> +
> +static void tlob_task_api_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_destroy_monitor();
> +}
> +
> +static struct kunit_case tlob_task_api_cases[] =3D {
> +=09KUNIT_CASE(tlob_start_stop_ok),
> +=09KUNIT_CASE(tlob_double_start),
> +=09KUNIT_CASE(tlob_stop_without_start),
> +=09KUNIT_CASE(tlob_immediate_deadline),
> +=09KUNIT_CASE(tlob_enospc),
> +=09KUNIT_CASE(tlob_overflow_threshold),
> +=09KUNIT_CASE(tlob_deadline_fires_off_cpu),
> +=09KUNIT_CASE(tlob_deadline_fires_on_cpu),
> +=09KUNIT_CASE(tlob_stop_all_cleanup),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_task_api_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_task_api",
> +=09.suite_init =3D tlob_task_api_suite_init,
> +=09.suite_exit =3D tlob_task_api_suite_exit,
> +=09.test_cases =3D tlob_task_api_cases,
> +};
> +
> +/*
> + * Suite 3: scheduling integration
> + */
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
> +=09/* Wait for main to give us the CPU back */
> +=09wait_for_completion(&ctx->ping);
> +=09complete(&ctx->pong);
> +=09return 0;
> +}
> +
> +/* Force two context switches and verify stop returns 0 (within budget).=
 */
> +static void tlob_sched_switch_accounting(struct kunit *test)
> +{
> +=09struct tlob_ping_ctx ctx;
> +=09struct task_struct *peer;
> +=09int ret;
> +
> +=09init_completion(&ctx.ping);
> +=09init_completion(&ctx.pong);
> +
> +=09peer =3D kthread_run(tlob_ping_fn, &ctx, "tlob_ping_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, peer);
> +
> +=09/* Arm a generous 5 s budget so the timer never fires */
> +=09ret =3D tlob_start_task(current, 5000000, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/*
> +=09 * complete(ping) -> peer runs, forcing a context switch out and
> back.
> +=09 */
> +=09complete(&ctx.ping);
> +=09wait_for_completion(&ctx.pong);
> +
> +=09/*
> +=09 * Back on CPU after one off-CPU interval; stop must return 0.
> +=09 */
> +=09ret =3D tlob_stop_task(current);
> +=09KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +/*
> + * Verify that monitoring a kthread (not current) works: start on behalf
> + * of a kthread, let it block, then stop it.
> + */
> +static int tlob_block_fn(void *arg)
> +{
> +=09struct completion *done =3D arg;
> +
> +=09/* Block briefly, exercising off_cpu accounting for this task */
> +=09msleep(20);
> +=09complete(done);
> +=09return 0;
> +}
> +
> +static void tlob_monitor_other_task(struct kunit *test)
> +{
> +=09struct completion done;
> +=09struct task_struct *target;
> +=09int ret;
> +
> +=09init_completion(&done);
> +
> +=09target =3D kthread_run(tlob_block_fn, &done, "tlob_target_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, target);
> +=09get_task_struct(target);
> +
> +=09/* Arm a 5 s budget for the target task */
> +=09ret =3D tlob_start_task(target, 5000000, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09wait_for_completion(&done);
> +
> +=09/*
> +=09 * Target has finished; stop_task may return 0 (still in htable)
> +=09 * or -ESRCH (kthread exited and timer fired / entry cleaned up).
> +=09 */
> +=09ret =3D tlob_stop_task(target);
> +=09KUNIT_EXPECT_TRUE(test, ret =3D=3D 0 || ret =3D=3D -ESRCH);
> +=09put_task_struct(target);
> +}
> +
> +static int tlob_sched_suite_init(struct kunit_suite *suite)
> +{
> +=09return tlob_init_monitor();
> +}
> +
> +static void tlob_sched_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_destroy_monitor();
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
> +/*
> + * Suite 4: ftrace tracepoint field verification
> + */
> +
> +/* Capture fields from trace_tlob_budget_exceeded for inspection. */
> +struct tlob_exceeded_capture {
> +=09atomic_t=09fired;=09=09/* 1 after first call */
> +=09pid_t=09=09pid;
> +=09u64=09=09threshold_us;
> +=09u64=09=09on_cpu_us;
> +=09u64=09=09off_cpu_us;
> +=09u32=09=09switches;
> +=09bool=09=09state_is_on_cpu;
> +=09u64=09=09tag;
> +};
> +
> +static void
> +probe_tlob_budget_exceeded(void *data,
> +=09=09=09=C2=A0=C2=A0 struct task_struct *task, u64 threshold_us,
> +=09=09=09=C2=A0=C2=A0 u64 on_cpu_us, u64 off_cpu_us,
> +=09=09=09=C2=A0=C2=A0 u32 switches, bool state_is_on_cpu, u64 tag)
> +{
> +=09struct tlob_exceeded_capture *cap =3D data;
> +
> +=09/* Only capture the first event to avoid races. */
> +=09if (atomic_cmpxchg(&cap->fired, 0, 1) !=3D 0)
> +=09=09return;
> +
> +=09cap->pid=09=09=3D task->pid;
> +=09cap->threshold_us=09=3D threshold_us;
> +=09cap->on_cpu_us=09=09=3D on_cpu_us;
> +=09cap->off_cpu_us=09=09=3D off_cpu_us;
> +=09cap->switches=09=09=3D switches;
> +=09cap->state_is_on_cpu=09=3D state_is_on_cpu;
> +=09cap->tag=09=09=3D tag;
> +}
> +
> +/*
> + * Arm a 2 ms budget and busy-spin for 60 ms. Verify the tracepoint fire=
s
> + * once with matching threshold, correct pid, and total time >=3D budget=
.
> + *
> + * state_is_on_cpu is not asserted: preemption during the spin makes it
> + * non-deterministic.
> + */
> +static void tlob_trace_budget_exceeded_on_cpu(struct kunit *test)
> +{
> +=09struct tlob_exceeded_capture cap =3D {};
> +=09const u64 threshold_us =3D 2000; /* 2 ms */
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09atomic_set(&cap.fired, 0);
> +
> +=09ret =3D register_trace_tlob_budget_exceeded(probe_tlob_budget_exceede=
d,
> +=09=09=09=09=09=09=C2=A0 &cap);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09ret =3D tlob_start_task(current, threshold_us, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* Busy-spin 60 ms=C2=A0 --=C2=A0 30x the budget */
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 60000)
> +=09=09cpu_relax();
> +
> +=09/* Entry removed by timer; stop returns -ESRCH */
> +=09tlob_stop_task(current);
> +
> +=09/*
> +=09 * Synchronise: ensure the probe callback has completed before we
> +=09 * read the captured fields.
> +=09 */
> +=09tracepoint_synchronize_unregister();
> +=09unregister_trace_tlob_budget_exceeded(probe_tlob_budget_exceeded,
> &cap);
> +
> +=09KUNIT_EXPECT_EQ(test, atomic_read(&cap.fired), 1);
> +=09KUNIT_EXPECT_EQ(test, (int)cap.pid, (int)current->pid);
> +=09KUNIT_EXPECT_EQ(test, cap.threshold_us, threshold_us);
> +=09/* Total elapsed must cover at least the budget */
> +=09KUNIT_EXPECT_GE(test, cap.on_cpu_us + cap.off_cpu_us, threshold_us);
> +}
> +
> +/*
> + * Holder kthread grabs a mutex for 80 ms; arm 10 ms budget, burn ~1 ms
> + * on-CPU, then block on the mutex. Timer fires off-CPU. Verify:
> + * state_is_on_cpu =3D=3D false, switches >=3D 1, off_cpu_us > 0.
> + */
> +static void tlob_trace_budget_exceeded_off_cpu(struct kunit *test)
> +{
> +=09struct tlob_exceeded_capture cap =3D {};
> +=09struct tlob_holder_ctx ctx =3D { .hold_ms =3D 80 };
> +=09struct task_struct *holder;
> +=09const u64 threshold_us =3D 10000; /* 10 ms */
> +=09ktime_t t0;
> +=09int ret;
> +
> +=09atomic_set(&cap.fired, 0);
> +
> +=09mutex_init(&ctx.lock);
> +=09init_completion(&ctx.ready);
> +
> +=09holder =3D kthread_run(tlob_holder_fn, &ctx, "tlob_holder2_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, holder);
> +=09wait_for_completion(&ctx.ready);
> +
> +=09ret =3D register_trace_tlob_budget_exceeded(probe_tlob_budget_exceede=
d,
> +=09=09=09=09=09=09=C2=A0 &cap);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09ret =3D tlob_start_task(current, threshold_us, NULL, 0);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09/* Phase 1: ~1 ms on-CPU */
> +=09t0 =3D ktime_get();
> +=09while (ktime_us_delta(ktime_get(), t0) < 1000)
> +=09=09cpu_relax();
> +
> +=09/* Phase 2: block -> off-CPU; timer fires here */
> +=09mutex_lock(&ctx.lock);
> +=09mutex_unlock(&ctx.lock);
> +
> +=09tlob_stop_task(current);
> +
> +=09tracepoint_synchronize_unregister();
> +=09unregister_trace_tlob_budget_exceeded(probe_tlob_budget_exceeded,
> &cap);
> +
> +=09KUNIT_EXPECT_EQ(test, atomic_read(&cap.fired), 1);
> +=09KUNIT_EXPECT_EQ(test, cap.threshold_us, threshold_us);
> +=09/* Violation happened off-CPU */
> +=09KUNIT_EXPECT_FALSE(test, cap.state_is_on_cpu);
> +=09/* At least the switch_out event was counted */
> +=09KUNIT_EXPECT_GE(test, (u64)cap.switches, (u64)1);
> +=09/* Off-CPU time must be non-zero */
> +=09KUNIT_EXPECT_GT(test, cap.off_cpu_us, (u64)0);
> +}
> +
> +/* threshold_us in the tracepoint must exactly match the start argument.=
 */
> +static void tlob_trace_threshold_field_accuracy(struct kunit *test)
> +{
> +=09static const u64 thresholds[] =3D { 500, 1000, 3000 };
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(thresholds); i++) {
> +=09=09struct tlob_exceeded_capture cap =3D {};
> +=09=09ktime_t t0;
> +=09=09int ret;
> +
> +=09=09atomic_set(&cap.fired, 0);
> +
> +=09=09ret =3D register_trace_tlob_budget_exceeded(
> +=09=09=09probe_tlob_budget_exceeded, &cap);
> +=09=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09=09ret =3D tlob_start_task(current, thresholds[i], NULL, 0);
> +=09=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09=09/* Spin for 20x the threshold to ensure timer fires */
> +=09=09t0 =3D ktime_get();
> +=09=09while (ktime_us_delta(ktime_get(), t0) <
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s64)(thresholds[i] * 20))
> +=09=09=09cpu_relax();
> +
> +=09=09tlob_stop_task(current);
> +
> +=09=09tracepoint_synchronize_unregister();
> +=09=09unregister_trace_tlob_budget_exceeded(
> +=09=09=09probe_tlob_budget_exceeded, &cap);
> +
> +=09=09KUNIT_EXPECT_EQ_MSG(test, cap.threshold_us, thresholds[i],
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 "threshold mismatch for entry %u", i);
> +=09}
> +}
> +
> +static int tlob_trace_suite_init(struct kunit_suite *suite)
> +{
> +=09int ret;
> +
> +=09ret =3D tlob_init_monitor();
> +=09if (ret)
> +=09=09return ret;
> +=09return tlob_enable_hooks();
> +}
> +
> +static void tlob_trace_suite_exit(struct kunit_suite *suite)
> +{
> +=09tlob_disable_hooks();
> +=09tlob_destroy_monitor();
> +}
> +
> +static struct kunit_case tlob_trace_output_cases[] =3D {
> +=09KUNIT_CASE(tlob_trace_budget_exceeded_on_cpu),
> +=09KUNIT_CASE(tlob_trace_budget_exceeded_off_cpu),
> +=09KUNIT_CASE(tlob_trace_threshold_field_accuracy),
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
> +/* Suite 5: ring buffer */
> +
> +/*
> + * Allocate a synthetic rv_file_priv for ring buffer tests. Uses
> + * kunit_kzalloc() instead of __get_free_pages() since the ring is never
> + * mmap'd here.
> + */
> +static struct rv_file_priv *alloc_priv_kunit(struct kunit *test, u32 cap=
)
> +{
> +=09struct rv_file_priv *priv;
> +=09struct tlob_ring *ring;
> +
> +=09priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +=09if (!priv)
> +=09=09return NULL;
> +
> +=09ring =3D &priv->ring;
> +
> +=09ring->page =3D kunit_kzalloc(test, sizeof(struct tlob_mmap_page),
> +=09=09=09=09=C2=A0=C2=A0 GFP_KERNEL);
> +=09if (!ring->page)
> +=09=09return NULL;
> +
> +=09ring->data =3D kunit_kzalloc(test, cap * sizeof(struct tlob_event),
> +=09=09=09=09=C2=A0=C2=A0 GFP_KERNEL);
> +=09if (!ring->data)
> +=09=09return NULL;
> +
> +=09ring->mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D cap - 1;
> +=09ring->page->capacity=C2=A0 =3D cap;
> +=09ring->page->version=C2=A0=C2=A0 =3D 1;
> +=09ring->page->data_offset =3D PAGE_SIZE; /* nominal; not used in tests =
*/
> +=09ring->page->record_size =3D sizeof(struct tlob_event);
> +=09spin_lock_init(&ring->lock);
> +=09init_waitqueue_head(&priv->waitq);
> +=09return priv;
> +}
> +
> +/* Push one record and verify all fields survive the round-trip. */
> +static void tlob_event_push_one(struct kunit *test)
> +{
> +=09struct rv_file_priv *priv;
> +=09struct tlob_ring *ring;
> +=09struct tlob_event in =3D {
> +=09=09.tid=09=09=3D 1234,
> +=09=09.threshold_us=09=3D 5000,
> +=09=09.on_cpu_us=09=3D 3000,
> +=09=09.off_cpu_us=09=3D 2000,
> +=09=09.switches=09=3D 3,
> +=09=09.state=09=09=3D 1,
> +=09};
> +=09struct tlob_event out =3D {};
> +=09u32 tail;
> +
> +=09priv =3D alloc_priv_kunit(test, TLOB_RING_DEFAULT_CAP);
> +=09KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +=09ring =3D &priv->ring;
> +
> +=09tlob_event_push_kunit(priv, &in);
> +
> +=09/* One record written, none dropped */
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_head, 1u);
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_tail, 0u);
> +=09KUNIT_EXPECT_EQ(test, ring->page->dropped,=C2=A0=C2=A0 0ull);
> +
> +=09/* Dequeue manually */
> +=09tail =3D ring->page->data_tail;
> +=09out=C2=A0 =3D ring->data[tail & ring->mask];
> +=09ring->page->data_tail =3D tail + 1;
> +
> +=09KUNIT_EXPECT_EQ(test, out.tid,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 in.tid);
> +=09KUNIT_EXPECT_EQ(test, out.threshold_us, in.threshold_us);
> +=09KUNIT_EXPECT_EQ(test, out.on_cpu_us,=C2=A0=C2=A0=C2=A0 in.on_cpu_us);
> +=09KUNIT_EXPECT_EQ(test, out.off_cpu_us,=C2=A0=C2=A0 in.off_cpu_us);
> +=09KUNIT_EXPECT_EQ(test, out.switches,=C2=A0=C2=A0=C2=A0=C2=A0 in.switch=
es);
> +=09KUNIT_EXPECT_EQ(test, out.state,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 in.state);
> +
> +=09/* Ring is now empty */
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_head, ring->page->data_tail);
> +}
> +
> +/*
> + * Fill to capacity, push one more. Drop-new policy: head stays at cap,
> + * dropped =3D=3D 1, oldest record is preserved.
> + */
> +static void tlob_event_push_overflow(struct kunit *test)
> +{
> +=09struct rv_file_priv *priv;
> +=09struct tlob_ring *ring;
> +=09struct tlob_event ntf =3D {};
> +=09struct tlob_event out =3D {};
> +=09const u32 cap =3D TLOB_RING_MIN_CAP;
> +=09u32 i;
> +
> +=09priv =3D alloc_priv_kunit(test, cap);
> +=09KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +=09ring =3D &priv->ring;
> +
> +=09/* Push cap + 1 records; tid encodes the sequence */
> +=09for (i =3D 0; i <=3D cap; i++) {
> +=09=09ntf.tid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
i;
> +=09=09ntf.threshold_us =3D (u64)i * 1000;
> +=09=09tlob_event_push_kunit(priv, &ntf);
> +=09}
> +
> +=09/* Drop-new: head stopped at cap; one record was silently discarded
> */
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_head, cap);
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_tail, 0u);
> +=09KUNIT_EXPECT_EQ(test, ring->page->dropped,=C2=A0=C2=A0 1ull);
> +
> +=09/* Oldest surviving record must be the first one pushed (tid =3D=3D 0=
) */
> +=09out =3D ring->data[ring->page->data_tail & ring->mask];
> +=09KUNIT_EXPECT_EQ(test, out.tid, 0u);
> +
> +=09/* Drain the ring; the last record must have tid =3D=3D cap - 1 */
> +=09for (i =3D 0; i < cap; i++) {
> +=09=09u32 tail =3D ring->page->data_tail;
> +
> +=09=09out =3D ring->data[tail & ring->mask];
> +=09=09ring->page->data_tail =3D tail + 1;
> +=09}
> +=09KUNIT_EXPECT_EQ(test, out.tid, cap - 1);
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_head, ring->page->data_tail);
> +}
> +
> +/* A freshly initialised ring is empty. */
> +static void tlob_event_empty(struct kunit *test)
> +{
> +=09struct rv_file_priv *priv;
> +=09struct tlob_ring *ring;
> +
> +=09priv =3D alloc_priv_kunit(test, TLOB_RING_DEFAULT_CAP);
> +=09KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +=09ring =3D &priv->ring;
> +
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_head, 0u);
> +=09KUNIT_EXPECT_EQ(test, ring->page->data_tail, 0u);
> +=09KUNIT_EXPECT_EQ(test, ring->page->dropped,=C2=A0=C2=A0 0ull);
> +}
> +
> +/* A kthread blocks on wait_event_interruptible(); pushing one record mu=
st
> + * wake it within 1 s.
> + */
> +
> +struct tlob_wakeup_ctx {
> +=09struct rv_file_priv=09*priv;
> +=09struct completion=09 ready;
> +=09struct completion=09 done;
> +=09int=09=09=09 woke;
> +};
> +
> +static int tlob_wakeup_thread(void *arg)
> +{
> +=09struct tlob_wakeup_ctx *ctx =3D arg;
> +=09struct tlob_ring *ring =3D &ctx->priv->ring;
> +
> +=09complete(&ctx->ready);
> +
> +=09wait_event_interruptible(ctx->priv->waitq,
> +=09=09smp_load_acquire(&ring->page->data_head) !=3D
> +=09=09READ_ONCE(ring->page->data_tail) ||
> +=09=09kthread_should_stop());
> +
> +=09if (smp_load_acquire(&ring->page->data_head) !=3D
> +=09=C2=A0=C2=A0=C2=A0 READ_ONCE(ring->page->data_tail))
> +=09=09ctx->woke =3D 1;
> +
> +=09complete(&ctx->done);
> +=09return 0;
> +}
> +
> +static void tlob_ring_wakeup(struct kunit *test)
> +{
> +=09struct rv_file_priv *priv;
> +=09struct tlob_wakeup_ctx ctx;
> +=09struct task_struct *t;
> +=09struct tlob_event ev =3D { .tid =3D 99 };
> +=09long timeout;
> +
> +=09priv =3D alloc_priv_kunit(test, TLOB_RING_DEFAULT_CAP);
> +=09KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +=09init_completion(&ctx.ready);
> +=09init_completion(&ctx.done);
> +=09ctx.priv =3D priv;
> +=09ctx.woke =3D 0;
> +
> +=09t =3D kthread_run(tlob_wakeup_thread, &ctx, "tlob_wakeup_kunit");
> +=09KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t);
> +=09get_task_struct(t);
> +
> +=09/* Let the kthread reach wait_event_interruptible */
> +=09wait_for_completion(&ctx.ready);
> +=09usleep_range(10000, 20000);
> +
> +=09/* Push one record=C2=A0 --=C2=A0 must wake the waiter */
> +=09tlob_event_push_kunit(priv, &ev);
> +
> +=09timeout =3D wait_for_completion_timeout(&ctx.done,
> msecs_to_jiffies(1000));
> +=09kthread_stop(t);
> +=09put_task_struct(t);
> +
> +=09KUNIT_EXPECT_GT(test, timeout, 0L);
> +=09KUNIT_EXPECT_EQ(test, ctx.woke, 1);
> +=09KUNIT_EXPECT_EQ(test, priv->ring.page->data_head, 1u);
> +}
> +
> +static struct kunit_case tlob_event_buf_cases[] =3D {
> +=09KUNIT_CASE(tlob_event_push_one),
> +=09KUNIT_CASE(tlob_event_push_overflow),
> +=09KUNIT_CASE(tlob_event_empty),
> +=09KUNIT_CASE(tlob_ring_wakeup),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_event_buf_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_event_buf",
> +=09.test_cases =3D tlob_event_buf_cases,
> +};
> +
> +/* Suite 6: uprobe format string parser */
> +
> +/* Happy path: decimal offsets, plain path. */
> +static void tlob_parse_decimal_offsets(struct kunit *test)
> +{
> +=09char buf[] =3D "5000:4768:4848:/usr/bin/myapp";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=090);
> +=09KUNIT_EXPECT_EQ(test, thr,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u64)5000);
> +=09KUNIT_EXPECT_EQ(test, start,=C2=A0=C2=A0=C2=A0 (loff_t)4768);
> +=09KUNIT_EXPECT_EQ(test, stop,=C2=A0=C2=A0=C2=A0=C2=A0 (loff_t)4848);
> +=09KUNIT_EXPECT_STREQ(test, path,=C2=A0 "/usr/bin/myapp");
> +}
> +
> +/* Happy path: 0x-prefixed hex offsets. */
> +static void tlob_parse_hex_offsets(struct kunit *test)
> +{
> +=09char buf[] =3D "10000:0x12a0:0x12f0:/usr/bin/myapp";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=090);
> +=09KUNIT_EXPECT_EQ(test, start,=C2=A0=C2=A0 (loff_t)0x12a0);
> +=09KUNIT_EXPECT_EQ(test, stop,=C2=A0=C2=A0=C2=A0 (loff_t)0x12f0);
> +=09KUNIT_EXPECT_STREQ(test, path, "/usr/bin/myapp");
> +}
> +
> +/* Path containing ':' must not be truncated. */
> +static void tlob_parse_path_with_colon(struct kunit *test)
> +{
> +=09char buf[] =3D "1000:0x100:0x200:/opt/my:app/bin";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=090);
> +=09KUNIT_EXPECT_STREQ(test, path, "/opt/my:app/bin");
> +}
> +
> +/* Zero threshold must be rejected. */
> +static void tlob_parse_zero_threshold(struct kunit *test)
> +{
> +=09char buf[] =3D "0:0x100:0x200:/usr/bin/myapp";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=09-EINVAL);
> +}
> +
> +/* Empty path (trailing ':' with nothing after) must be rejected. */
> +static void tlob_parse_empty_path(struct kunit *test)
> +{
> +=09char buf[] =3D "5000:0x100:0x200:";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=09-EINVAL);
> +}
> +
> +/* Missing field (3 tokens instead of 4) must be rejected. */
> +static void tlob_parse_too_few_fields(struct kunit *test)
> +{
> +=09char buf[] =3D "5000:0x100:/usr/bin/myapp";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=09-EINVAL);
> +}
> +
> +/* Negative offset must be rejected. */
> +static void tlob_parse_negative_offset(struct kunit *test)
> +{
> +=09char buf[] =3D "5000:-1:0x200:/usr/bin/myapp";
> +=09u64 thr; loff_t start, stop; char *path;
> +
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09tlob_parse_uprobe_line(buf, &thr, &path, &start, &stop),
> +=09=09-EINVAL);
> +}
> +
> +static struct kunit_case tlob_parse_uprobe_cases[] =3D {
> +=09KUNIT_CASE(tlob_parse_decimal_offsets),
> +=09KUNIT_CASE(tlob_parse_hex_offsets),
> +=09KUNIT_CASE(tlob_parse_path_with_colon),
> +=09KUNIT_CASE(tlob_parse_zero_threshold),
> +=09KUNIT_CASE(tlob_parse_empty_path),
> +=09KUNIT_CASE(tlob_parse_too_few_fields),
> +=09KUNIT_CASE(tlob_parse_negative_offset),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_parse_uprobe_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_parse_uprobe",
> +=09.test_cases =3D tlob_parse_uprobe_cases,
> +};
> +
> +kunit_test_suites(&tlob_automaton_suite,
> +=09=09=C2=A0 &tlob_task_api_suite,
> +=09=09=C2=A0 &tlob_sched_integration_suite,
> +=09=09=C2=A0 &tlob_trace_output_suite,
> +=09=09=C2=A0 &tlob_event_buf_suite,
> +=09=09=C2=A0 &tlob_parse_uprobe_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for the tlob RV monitor");
> +MODULE_LICENSE("GPL");

