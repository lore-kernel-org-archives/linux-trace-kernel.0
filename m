Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2973F8893
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910599; cv=none; b=qf5FaLqo9xMn2dWHA+VabeUr1H1soWCwSXXOcaaBi6eK4LS9MQzAoO5GCs0bSR7V0LIJD7hiyWcwksMCADgjJgawNPyXrvJ7lTQpwymhUS7c7YQhM8r3kocCyFD6LENU5UX9CK0tx0Pht53T0qjKbI70eQ+kZPFbU1WY5NSbaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910599; c=relaxed/simple;
	bh=7guDleq0s0OJXnsapyMbitAxUPm6h/J02spFV1lhlPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQPd5IsR1NDFFJu9yE2nT9wO7LQBomZ5rEKrjGjte8hadtqaPDqEtzq5ypKNnFIZbzyqlNoaH0U7J1j2snfUbxqDZl6yRGE08JsBgIF795E+JbbbKsUyC9e7B2sdVGyjUSr7hN/VAIn1vrss0p5t9w0pzQrf1uDMChsPjl9UbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjzZNZEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjzZNZEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787910592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7guDleq0s0OJXnsapyMbitAxUPm6h/J02spFV1lhlPU=;
	b=ZjzZNZECWlPUyWRuNt4ho+c5/JBTT/w24oLY+E/ZD68UTiezXarGKjkJemOOldfDQrlTfX
	QBAFoBrRgRk0fByjs8EXDSZgSas154TpLFMK+SvCn4pN5FH3r9xsyStQXlCTGNW0kAojJE
	TrBqKcaGohmni97dq0ePey5jU/nvYIE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-fmETPASUOiOf5U3u-DWyag-1; Fri, 28 Aug 2026 05:49:50 -0400
X-MC-Unique: fmETPASUOiOf5U3u-DWyag-1
X-Mimecast-MFC-AGG-ID: fmETPASUOiOf5U3u-DWyag_1787910589
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e984607e7so661117a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 02:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910589; x=1788515389;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fjus0cEE64rVoeyJBEwq4yXByfhMwbzT4sjrQJ9cSNI=;
        b=dYp/cl5XKtErdX4vDsUzrY2OnsEA6OzCetappyQ86xanGXzhsRoFmIUfe1qpWllXcM
         MNQBg/PsIfwJQdmodvlFoSP5s1jGDM8LX2wR0OiTok6oPc/jBXXoOdovLF3BldPsveA2
         T32XmL4vHJ20NYY+cEjenDyljhqOZzjxVH968XhKnXK/uXsZJXV47LUmCjmP2CYd3oTc
         eoyLu3kRVRZtJSqXzUxM5PyCaYizvB+HtEkph9wTecOUG8F6VZceRrY4Ny81QtRLDWBY
         st1SofQQ2Oj70n1RVi9B3v8eQm5Y9elHBQvIDwZYW0W30PImkYMl8tGTDSn6YGjA0JQA
         C8lA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5phE4kA7KPyAXoR3fYEbVRVA3FdWyF01sKk/yMUg/U25Y3lHL3R7lL3CzH4mx+2dR64CiJhe4DNcwUoC8I2A33Go=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ+Xgu23btaLOMk771asKq1017jq78AdDvzfrOd5oaFV6RSBZN
	48uKUtwcIWW1efzo7jxdKawos/ZRe6oSxdnYcRoftwzsIQ4tuqENU3e+5fdmy6UELASxzb2PWO9
	f5PZG6gOuzokEaV6sMAyJv9Qf23KZLR1SnsZB+Sgy6DvO2BQdj4QkfCN2IOUTlC0SdembyOS6hw
	==
X-Gm-Gg: AR+sD13qpvjVkz+hcYosR4yzC2cncupDBoAbOP/QaBRmS3f3cMXyhvU4GtZZwOtHN0r
	ZDBwMTJaEKI8gIwEqJ0E5G5hilzMBtY5AlXS55sDk0jG7NfiezkboKmr+PsyMW8kmp6E7C4k3BB
	xHwxaXgwiv3g7ibQAyQ4YB8MgJgQJPYNG34VG5LUUrgajr4w0is1zjzh/SzfTMepUz4Bk4iUOSs
	+CTTWkxiFLSUgaPoG9MMtGTKsXSi6VCh2vioy/JC+DXcD7KetlvznkwiEMSh3xpli8r3UXY7Lvv
	7SzaDxXPksFw3lWugnFXE7FOQlav6bjZub8Le/9uj2j8rrVbl7sLB4gcnZR9gtojB/FhZ3+lfo3
	ESbg6Ibyu+7vj7YIreMhVSi+ls2zXOC6Q8Cwy07QWjjZ09CrA8ApkkgvYLeC4QpWCIT3bCw==
X-Received: by 2002:a05:6402:2b86:b0:6a5:f9c7:7f61 with SMTP id 4fb4d7f45d1cf-6a60d2ff287mr3359142a12.3.1787910588848;
        Fri, 28 Aug 2026 02:49:48 -0700 (PDT)
X-Received: by 2002:a05:6402:2b86:b0:6a5:f9c7:7f61 with SMTP id 4fb4d7f45d1cf-6a60d2ff287mr3359090a12.3.1787910588305;
        Fri, 28 Aug 2026 02:49:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611c56ff0sm332874a12.25.2026.08.28.02.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:49:47 -0700 (PDT)
Message-ID: <f9ba0be51e1a3c27357bfdd9a78160c06214f291.camel@redhat.com>
Subject: Re: [PATCH v6 8/9] selftests/verification: Add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 11:49:46 +0200
In-Reply-To: <c1305284e09e0522c5c88e8ebf4a0f6e59541999.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <c1305284e09e0522c5c88e8ebf4a0f6e59541999.1787243842.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: B3iHBHJvVtHhJ1HXlWGxop0WidmA-bKjjnFiGVTA-E0_1787910589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> +
> +/* start probe; busy-spin so running_ns dominates */
> +noinline void tlob_busy_work(unsigned long duration_ms)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < duration_ms * 1000000UL);

I really don't like repeated code, cannot this go to a static inline
__tlob_busy_wait(duration_ms) and you call that from tlob_busy_work() and
tlob_preempt_work() ?

> +
> +=09tlob_busy_work_done();
> +}
> +
> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_sleep_work_done(void)
> +{
> +=09asm volatile("" ::: "memory");
> +}
> +
> +/* start probe; nanosleep so sleeping_ns dominates */
> +noinline void tlob_sleep_work(unsigned long duration_ms)
> +{
> +=09struct timespec ts =3D {
> +=09=09.tv_sec=C2=A0 =3D duration_ms / 1000,
> +=09=09.tv_nsec =3D (long)(duration_ms % 1000) * 1000000L,
> +=09};
> +=09nanosleep(&ts, NULL);
> +=09tlob_sleep_work_done();
> +}
> +
> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_preempt_work_done(void)
> +{
> +=09asm volatile("" ::: "memory");
> +}
> +
> +/*
> + * start probe; busy-spin so an RT competitor on the same CPU drives
> + * waiting_ns (prev_state=3D=3D0 -> preempt event, task stays runnable o=
ff-CPU).
> + */
> +noinline void tlob_preempt_work(unsigned long duration_ms)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < duration_ms * 1000000UL);

So here you'd just call __tlob_busy_wait(duration_ms).

> +
> +=09tlob_preempt_work_done();
> +}

Tests look good. Apparently all that started_list/started_node thing in
tlob.c is for multiple tasks sharing the same binding right. Shouldn't
that be tested? I just got a simple test for that, it's generated and
manually fixed but you may want to double check if it's really relevant
for this.

Anyway that isn't too important, for now:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi_=
instance.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi=
_instance.tc
new file mode 100644
index 000000000000..33404683d29a
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instanc=
e.tc
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor multiple instances of same uprobe binding=
 (concurrent tasks on same binding)
+# requires: tlob:monitor
+
+# Fall back to the verification directory relative to FTRACETEST_ROOT when=
 not
+# set by make (e.g. in installed kselftest environments).
+: "${VERIFICATIONTEST_BINDIR:=3D"$FTRACETEST_ROOT/../verification"}"
+
+UPROBE_TARGET=3D"${VERIFICATIONTEST_BINDIR}/tlob_target"
+TLOB_SYM=3D"${VERIFICATIONTEST_BINDIR}/tlob_sym"
+TLOB_MONITOR=3Dmonitors/tlob/monitor
+UPROBE_COMM=3D$(basename ${UPROBE_TARGET})
+
+busy_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/=
dev/null)
+busy_stop=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done =
2>/dev/null)
+
+# Start 3 concurrent instances of the target running the same binary probe
+"$UPROBE_TARGET" 30000 &
+pid1=3D$!
+"$UPROBE_TARGET" 30000 &
+pid2=3D$!
+"$UPROBE_TARGET" 30000 &
+pid3=3D$!
+
+teardown() {
+=09kill "$pid1" 2>/dev/null || true; wait "$pid1" 2>/dev/null || true
+=09kill "$pid2" 2>/dev/null || true; wait "$pid2" 2>/dev/null || true
+=09kill "$pid3" 2>/dev/null || true; wait "$pid3" 2>/dev/null || true
+}
+trap teardown EXIT
+sleep 0.05
+
+echo 1 > ../events/rv/event_tlob/enable
+echo 1 > ../tracing_on
+echo 1 > monitors/tlob/enable
+echo > ../trace
+
+# 5 s budget on the busy probe - must not fire in 200 ms loops
+echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=3D500000000=
0" > "$TLOB_MONITOR"
+
+# Wait up to 2 s for all three pids to be registered and transition throug=
h start.
+# This proves multiple tasks can hit the same uprobe binding concurrently.
+found1=3D0; found2=3D0; found3=3D0
+i=3D0
+while [ "$i" -lt 20 ]; do
+=09sleep 0.1
+=09grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid1}" && found=
1=3D1
+=09grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid2}" && found=
2=3D1
+=09grep "event_tlob" ../trace | grep -wq "${UPROBE_COMM}-${pid3}" && found=
3=3D1
+=09if [ "$found1" =3D "1" ] && [ "$found2" =3D "1" ] && [ "$found3" =3D "1=
" ]; then
+=09=09break
+=09fi
+=09i=3D$((i+1))
+done
+
+[ "$found1" =3D "1" ]
+[ "$found2" =3D "1" ]
+[ "$found3" =3D "1" ]
+
+# Removing the uprobe while tasks are active must succeed cleanly and unbi=
nd them.
+# Active tasks will be detached (binding set to NULL), parked tasks will b=
e destroyed.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR" || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > ../events/rv/event_tlob/enable
+echo > ../trace

