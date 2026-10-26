Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007811;
	b=Nh5Q1vFGn88Ys35PZnT4En5543KpXLiEi4p8nK/Ude5ZVfwZ7yuqikIbl8OaDsIiSSpa
	 X4zFU+ktG8Ld1O8TqRbP81grTzgloLEAnFudHdhpbmvhQTX7Hm/EEZXPmMVelRCaaShGc
	 Otl+2LBPGGkNnnfsTf7hsBqXXheXF8/kCI74FLfh7BzCa27+I02ayubVY4nyeayg6e+QG
	 FXW2nGVAO8zKzVBC/jRbmS2R56Y3WIt+HumsbYE2mBsmnQE9KopSVssZ3Z5BZy86ejEmR
	 Se0cSehNw6llMN9SfdVx18MDcRVCz/s+HUI9Ayh68bvFZEKb0WuXytfm03wP6u6uG6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007811;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=phsYTN16LoRE+ARN9uh51eUjoF5oVqxh+Mds4pkpAH0=;
	b=Mz9+IGPUK+dVYneyW4TUsX1GLXIB7XygUeWM2jRWEYmHhptg9SHwv58erc0QH7m+/LtR
	 sa5MKdo38002UfDp/3Iby4xLHES3s4snnCHeZnul0nDXNHpZHkSm1sIuO7bOtGI0Vt9dp
	 DAj4mAh3R+sQfGqsQj14BvNTY3qvA90sYlgnFwB56+71gNoQPmpuH1w4kyK5lfW39svfM
	 TsdQWlLPliTnMRLKc4XzP6PO+2O1fo+a81FxeC4EYKWc991IYq1AlgYvhzsAbCaWE5rzd
	 sNAcDr0tg2nbYpxkEZk9vRXwTVppUepldjlMryhb43cP+V1FYCTsObvU1TF2bOLYhiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="IV/mYZX7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7288606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 09:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7288606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IV/mYZX7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793007809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=phsYTN16LoRE+ARN9uh51eUjoF5oVqxh+Mds4pkpAH0=;
	b=IV/mYZX704BDn7ea8fZnaebQxMwP1iZEmqH/9aRDhdhS1EPSnTMqqP2WJObK8wc+I0lra6
	rVnjKsmtcmLRkztI/5DTCuapRwyk+ivvqg0/mqx7ip4rZ4zR5oU0fJt4xQYFzwEgNdkz9j
	WjE+3UN/vJJXp5dUvt6UcbaI4M0EcSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-L52Qn0RtM3GQ9nQTKjh0mA-1; Mon, 26 Oct 2026 05:43:27 -0400
X-MC-Unique: L52Qn0RtM3GQ9nQTKjh0mA-1
X-Mimecast-MFC-AGG-ID: L52Qn0RtM3GQ9nQTKjh0mA_1793007807
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so10262595e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 02:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007806; x=1793612606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YzYyV3/dl4usk2Ucqfq7Nq0hoAaOh/AV9apr9Ut9AII=;
        b=INyB6+yOm0R+a9LYLvwJCSqTBUppyjVRyAiZ5NvKQiwcocn5QETCRt+UTLcLZSaMOj
         iS6zQRXKKswOcAGSp3OkQGo4hz6ZpEtqQ+2sAT8bmoEDsWBIH5HB67K+NrCDt99uHDC5
         jMmk1a1q3FeheEHhHY3H1kqfZySmNRQ/FhyySDAWOTBQ20NveihEq6w2P2a+nb/G0Rvo
         ak57TNyR+u4XvlaHYki4uceicj8GjpUZYGlftM4MyFjdIiFtb/TsqHeX2cbfU+EJ6aZj
         Z3YOQJ2epKn3T/+v3KAEO7yxmPQhDDeGX1KBIqpOvNyqGrp5OE0K7JGheVmG4H2Sium0
         EO5w==
X-Forwarded-Encrypted: i=1; AKwUvBzCAeU13JPD9ZVQJpG5sVY/TSfCJPs3oGbX404ORw49QQlqjnJWbuVuoguzoOg/zso0OiAcfnT0BBctD6j3FzKIX8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpo3Avyd6iITizMvcepozR2M3zfY17U5m+7tsi5icp3ZjA8RLx
	QNH5CqEytpUDDSkDW7sAdo1x7413ui6aBwGSlPnL7kAU7n2W7DtQJ4l0F4Id+U1WaC7gZcfGezS
	FBgtRdOFeQR1HGvpq+zMitLBDBtlsTZu7rdmIH2OvXijhgzP0bFNGmhiUhiPgxeGAFDgwCek5xg
	==
X-Gm-Gg: AYBFou0UbF77XZ990yrMZtIfVbPYsqDvpGarZq9xKDM06sArRpgaOkRJMcN173yxvP9
	xMhsl5Mral7/0y0JdNbuLbqxDqfQ/gcR+M0WL5JxQw0UGKbLnK3r2mbAVPt2KLMLFBigBWNCEgs
	PF37lesdiRicQDpMNEvZBceJksCSXblH8ceG7+WW2yoDNdsJOPn+aFhTHEKSpa+PJ1By2cITEpU
	d5MSqZR5uCsglb3Xgc/lW4loIFWkJjgQur1k/J4ByKX9zjXbZq19PegNuvceYSOHpJXv+xyrnt1
	0xxtROdKVxik2kesIbDrYKNfCEwsI6VnUmpOsYmueOKgdNYW9aII4xj3ruIyRts1OCW1gaXV/Sz
	17bIyfniRo6UiPtGmpleK942qx5Tv
X-Received: by 2002:a05:600c:4f86:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a35acbd064mr110624735e9.27.1793007806588;
        Mon, 26 Oct 2026 02:43:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f86:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a35acbd064mr110624495e9.27.1793007806185;
        Mon, 26 Oct 2026 02:43:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm487617515e9.1.2026.10.26.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:43:23 -0700 (PDT)
Message-ID: <e39bfec47ecf06453242e3f6bf919e9fd2e04caf.camel@redhat.com>
Subject: Re: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 10:43:22 +0100
In-Reply-To: <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
	 <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -jsRUokzWh2FQ3dx4rNBaXIusSnAR8QZ8CJeTN3sRaI_1793007807
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add rvtest, a minimal per-object HA monitor, and a test for both
> underflows fixed by the previous patch: an invariant checked while the
> uptime is below the budget holds, and a timer armed after the budget
> elapsed expires now.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/rv_monitors_test.c | 122 ++++++++++++++++++++++++++=
+++
>=20
> =C2=A0#include <linux/rv.h>
> =C2=A0#include "rv.h"
> =C2=A0
> +#include <rv_trace.h>
> +
> +/* rvtest: a minimal per-object HA monitor driven directly by the tests.=
 */
> +#define MONITOR_NAME rvtest
> +#define RV_MON_TYPE RV_MON_PER_OBJ
> +#define HA_TIMER_TYPE HA_TIMER_HRTIMER
> +typedef void *monitor_target;
> +

...
> +#include <rv/ha_monitor.h>

Uhm, this isn't meant to be imported in things that aren't monitors, if we =
just
decided to create another test monitor here it would be a problem.

I'd suggest you put this all in a new C file and build it as a separate obj=
ect.
Then you may export rv_test_rvtest_underflow()  (extern function, not expor=
t
symbol) for rv_monitors_test to use or whatever works best.
Feel free to add a new rv/kunit folder if it looks cleaner, it isn't necess=
ary
for now though.

Be mindful that it should still build as a module (trace_rv_retries_error()=
 and
rv_monitoring_on() aren't exported, you can shortcircuit them to nothing li=
ke
you did for the other tracepoints).

I think you should be able to keep it as part of rv_monitors_test.ko but I
haven't tried.

It's very good to have unit tests for these things, but in case you cannot =
get
this ready for the next merge window I'd still get the other fix first.

Thanks,
Gabriele

> +
> +#define RVTEST_BUDGET_NS (300ULL * NSEC_PER_MSEC)
> +
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_rvtest env,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 time_ns)
> +{
> +=09return ha_get_clk_ns(ha_mon, env, time_ns);
> +}
> +
> +static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_rvtest env=
,
> +=09=09=09 u64 time_ns)
> +{
> +=09ha_reset_clk_ns(ha_mon, env, time_ns);
> +}
> +
> +/* The tests arm the timer themselves. */
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +=09=09=09=09 enum states curr_state, enum events event,
> +=09=09=09=09 enum states next_state, u64 time_ns)
> +{
> +=09return true;
> +}
> +
> +static const struct rv_kunit_mon rvtest_mon =3D RV_MON_OPS_INIT();
> +
> =C2=A0/*
> =C2=A0 * An easy way to pass the context is to use kunit_get_current_test=
()->priv,
> =C2=A0 * but this doesn't always work (e.g. a reactor running from anothe=
r context
> @@ -146,6 +227,46 @@ static void rv_test_dummy(struct kunit *test)
> =C2=A0=09active_ctx =3D NULL;
> =C2=A0}
> =C2=A0
> +/*
> + * rv_test_rvtest_underflow - the HA clock math must not underflow as u6=
4
> + *
> + * An invariant checked while the uptime is below the budget holds, and =
a
> + * timer armed after the budget elapsed expires now.
> + */
> +static void rv_test_rvtest_underflow(struct kunit *test)
> +{
> +=09struct ha_monitor *ha_mon;
> +=09struct da_monitor *da_mon;
> +=09const int id =3D 4242;
> +
> +=09prepare_test(test, &rvtest_mon);
> +=09da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +=09scoped_guard(rcu)
> +=09=09da_mon =3D da_get_monitor(id, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, da_mon);
> +=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09/* Uptime below the budget: time_ns - expire_ns would underflow. */
> +=09ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
> +=09KUNIT_EXPECT_TRUE(test, ha_check_invariant_ns(ha_mon, clk_rvtest, 0,
> +=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RVTEST_BUDGET_NS));
> +
> +=09/*
> +=09 * Budget already elapsed: expire - passed would underflow and queue
> +=09 * the timer at KTIME_SEC_MAX.
> +=09 */
> +=09da_monitor_reset(&ha_mon->da_mon);
> +=09ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
> +=09ha_start_timer_ns(ha_mon, clk_rvtest, RVTEST_BUDGET_NS,
> +=09=09=09=C2=A0 RVTEST_BUDGET_NS + NSEC_PER_SEC);
> +=09KUNIT_EXPECT_TRUE(test,
> +=09=09=09=C2=A0 ktime_before(hrtimer_get_expires(&ha_mon->hrtimer),
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_get() + NSEC_PER_=
SEC));
> +
> +=09ha_cancel_timer_sync(ha_mon);
> +}
> +
> =C2=A0#include "monitors/sco/sco_kunit.c"
> =C2=A0#include "monitors/sssw/sssw_kunit.c"
> =C2=A0#include "monitors/sts/sts_kunit.c"
> @@ -163,6 +284,7 @@ static struct kunit_case rv_mon_test_cases[] =3D {
> =C2=A0=09KUNIT_CASE(rv_test_nomiss),
> =C2=A0=09KUNIT_CASE(rv_test_pagefault),
> =C2=A0=09KUNIT_CASE(rv_test_sleep),
> +=09KUNIT_CASE(rv_test_rvtest_underflow),
> =C2=A0=09{}
> =C2=A0};
> =C2=A0

