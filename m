Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100853;
	b=c71mhuhtmnVGHqzlSvaibBYN+bmjM5Uo/Z4lhQKBHbnKMBWbAuEh/tdrDSj74ysRhhPz
	 krgTbeMOhZCc0/2yXiztmAodNWKFg2IBAPxtqCpn7aWdYJhbCr2KAyuGBHBYHupzhMoJa
	 H4ddUsYOmtLut/xNTJOqYMhweGUK2EhAynIcRbJACaKyDsGm7hjWAWH1AayKsmleJ+mG6
	 Cet/x+wTfGPvUp30B7/v4W8mg6aJvJ6r4xWoRzRa1eUPdj3PtsKGraEiz6JG3lw0kUvkA
	 fh4pg5guj5BFIlXA7q5ZyQdnY6LqGfi45J672NfJQPPRxx3uC/vuCMnJ+DoqDogvQSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100853;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=NMbJXpa8Ff5B9n0Xebju/UKReFbt+Ck0BYWkUwovowc=;
	b=aSHvS2Dtf6jBI7hffDPlDy3rQULy/7WSI2E/1RPsRXw4j9uDTTVUQqExNMjpa42GSjob
	 MJv/oocGg8X7ZfP40dca9KXYbk3Qgrvly9HNT2wiyM9ALU7v/st6Y3UZq2U3u67cMXuB6
	 JT3wfCLxVuqAmvI9qvAS5Rtl1s6/zftRyVeoACYi003Cub0QqTRetj/ovXXIZxCrD3cJW
	 WrJ5dbPG5xizDjU8Ksjdl+YZ/XRk//cnDHZBKTc0ereK0en5iEIcPh2ivTScn/B9pl8nV
	 ARLspne7f+KGFYNZl9uwqJAxPdfDqja81eScozgHdms3BwWQZ038UHiqkfrrKo3LxHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TujDq6zg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DE606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 15:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16DE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TujDq6zg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NMbJXpa8Ff5B9n0Xebju/UKReFbt+Ck0BYWkUwovowc=;
	b=TujDq6zgqPx2xjLyjPrsOaDOngN+/1ExoRvr8qjtgumiErcDH8n99Q98ssx9BIR2z909mc
	mj0czB77Dv11G/UqEFHPJ+pF8Id5EWs9NP2e871y/zt8Bg+BimgsN3sSuvpAMWpbEnilqo
	eiJx74FjZ8B0+lYB0HjGv/0qbXr2OXI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-aleif3wpNCOxc_6EDjOprg-1; Thu, 19 Nov 2026 10:07:29 -0500
X-MC-Unique: aleif3wpNCOxc_6EDjOprg-1
X-Mimecast-MFC-AGG-ID: aleif3wpNCOxc_6EDjOprg_1795100848
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48fbcf023dcso1050586f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 07:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100848; x=1795705648;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NMbJXpa8Ff5B9n0Xebju/UKReFbt+Ck0BYWkUwovowc=;
        b=QxQV+qGO+bzXmyLxihlykly3KFWHa2gO7oOF4cSyU/L7Ms/1bSXWApnwG9KRx041SO
         c1hlHqQAyTquhj5DxU5wPYpHlWRMNYl7SF4b5/w1V7ez4/ttSU9ABE9djTatkHzIuNwS
         CGkrS00RvTu20c/lPOS55CECwxe/AjQAnERjwKE2uJ3BvVRWQnDUEmpkwk93kIPJjh21
         VKoaEcx5AQWa+RGwg2vMG4mAF2h0r1iDjSdURi9aZiyTbf6sTn27eJt0DmQA+PSoPHft
         tfe2m0zN+ralIPU6GamspfEZzFvX5e7iiQLgHKkaErVuIzyDAb7Z8aFuNdu/QDdi+e1/
         aH2w==
X-Forwarded-Encrypted: i=1; AL+hErGlGftA6ngvr655kmJX+bOHVTFacPvZa/hAE07xJwBX/3EI4+TB5tMqyOi7oOLuL9c7AgLw7ewMMj9AVu1pbdDcz+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/V9ofQNOOmrKZTsyP7TxBXdiiCGUzOMrNAImjEK5ufasSNHvOP
	Pq878szaoalMH7uDWCoJlcVCdkZLrSJBUHDp8Bn1ttSQNY+gU6hH6SCNHx0xKF00j/9hMYKhKe6
	59rzOgY6fHCW+FVnvcghrSzgOD7pki4DuXRBcxU3/TM32PccLrgP2nVyl1avGn3z1IWPA99sHCQ
	==
X-Gm-Gg: AZFdTZeREvOUjXO1McL0p7ZzlrHhMkqcdvsCz1nE3CsoYOuUjzBdFi30D9yuw6zWni0
	39M0EpsB3uq+xVJ4s1HLnH1IB1x/DweLiCNE8mOrhWavoNr35p8eeO6HjOxR6sk6xrVQC5unHzX
	IZJApfcQh0NDK9KpDhvwHR7y3uq2TdrdGij3TapUKycSyNM2F83ebb7WmChl3vcTpEQnaFKi+Js
	YK8j6wmf40mmAp1J78QCkmja4qrymT/xFQsnDRb/p7c+tvfZK1YCeyoBHy+zj2aZlaHzRQ/jOuK
	f+jG6ehgNcKRlzJqNr1wVG747aE/Wp9YTRnrvcLr18wrcSLhN4lwiElJPSeGzSiiaJii5v6PSPb
	RPoi0/N4bZdGhXNSe3+UjVvOQEt7JbGy/xjsCuDD+TUZoyqy4WIHP2h1YLPhXH6xs/f7mcLQYTk
	+R
X-Received: by 2002:a5d:59c4:0:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4aa5396aa18mr3774255f8f.40.1795100848319;
        Thu, 19 Nov 2026 07:07:28 -0800 (PST)
X-Received: by 2002:a5d:59c4:0:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4aa5396aa18mr3774181f8f.40.1795100847854;
        Thu, 19 Nov 2026 07:07:27 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm72072f8f.42.2026.11.19.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:07:27 -0800 (PST)
Message-ID: <9e5ef6b35fe5788ddb425a3e64bb55c64dfb5ab1.camel@redhat.com>
Subject: Re: [PATCH v8 03/14] rv: Add a KUnit test for the HA timer underflow
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 16:07:26 +0100
In-Reply-To: <4ae656adc2e23939c3bf2138e1d6a9ee496fe4da.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <4ae656adc2e23939c3bf2138e1d6a9ee496fe4da.1793900349.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
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
X-Mimecast-MFC-PROC-ID: H2ZRxg8-zmQTa5IFRl-eCvSuFfYt4uEi6qZph1cPZHs_1795100848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add rv_ha_kunit.c as a standalone test suite with rvtest, a minimal
> per-object HA monitor, to test both underflows fixed by the previous
> patch: an invariant checked while the uptime is below the budget holds,
> and a timer armed after the budget elapsed expires now. Without that fix
> both expectations fail.
>=20
> Building the HA test in its own compilation unit keeps ha_monitor.h
> isolated from non-monitor test runners and avoids macro conflicts. The
> suite is guarded by IS_ENABLED(CONFIG_RV_HA_MONITOR) so kernels without
> HA monitors build cleanly.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0kernel/trace/rv/rv_ha_kunit.c | 152 +++++++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 153 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/rv_ha_kunit.c
>=20
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index cdbf68c84f5a..4b84b83b942b 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> =C2=A0obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_monitors_test.o
> +obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_ha_kunit.o

I think it's alright to reuse CONFIG_RV_MONITORS_KUNIT_TEST, but you aren't
doing it right in here.
CONFIG_RV_MONITORS_KUNIT_TEST depends (now) on RV_REACTORS, rv_ha_kunit doe=
s not
however. Also using IS_ENABLED(CONFIG_RV_HA_MONITOR) generates an empty mod=
ule.

I would either change the "depends on RV_REACTORS" in
CONFIG_RV_MONITORS_KUNIT_TEST to "depends on RV_REACTORS || RV_HA_MONITOR" =
and build
conditionally the two modules based on their requirements only (in Makefile=
):

ifdef CONFIG_RV_REACTORS
obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_monitors_test.o
endif
ifdef CONFIG_RV_HA_MONITOR
obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_ha_kunit.o
endif

Or just create a new CONFIG_ symbol.
I didn't test either, but in any case you shouldn't prevent compilation
of an entire C file from the C file itself, use Makefiles for that.

> diff --git a/kernel/trace/rv/rv_ha_kunit.c b/kernel/trace/rv/rv_ha_kunit.=
c
> new file mode 100644
> index 000000000000..e8aaee110fae
> --- /dev/null
> +++ b/kernel/trace/rv/rv_ha_kunit.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for RV hybrid automata (HA) framework
> + */
> +#include <kunit/test.h>
> +#include <linux/rv.h>
> +
> +#if IS_ENABLED(CONFIG_RV_HA_MONITOR)
> +
> +#include <rv_trace.h>
> +
> +/* rvtest: a minimal per-object HA monitor driven directly by the tests.=
 */
> +#define MONITOR_NAME rvtest
> +#define RV_MON_TYPE RV_MON_PER_OBJ
> +#define HA_TIMER_TYPE HA_TIMER_HRTIMER
> +typedef void *monitor_target;
> +
> +#define rv_monitoring_on()=09=09true
> +#define trace_rv_retries_error(...)=09do { } while (0)
> +#define trace_event_rvtest(...)=09=09do { } while (0)
> +#define trace_error_rvtest(...)=09=09do { } while (0)
> +#define trace_error_env_rvtest(...)=09do { } while (0)
> +
> +enum states_rvtest {
> +=09idle_rvtest,
> +=09armed_rvtest,
> +=09state_max_rvtest,
> +};
> +
> +#define INVALID_STATE state_max_rvtest
> +
> +enum events_rvtest {
> +=09start_rvtest,
> +=09event_max_rvtest,
> +};
> +
> +enum envs_rvtest {
> +=09clk_rvtest,
> +=09env_max_rvtest,
> +=09env_max_stored_rvtest =3D env_max_rvtest,
> +};
> +
> +#define HA_CLK_NS
> +
> +struct automaton_rvtest {
> +=09char *state_names[state_max_rvtest];
> +=09char *event_names[event_max_rvtest];
> +=09char *env_names[env_max_rvtest];
> +=09unsigned char function[state_max_rvtest][event_max_rvtest];
> +=09unsigned char initial_state;
> +=09bool final_states[state_max_rvtest];
> +};
> +
> +static const struct automaton_rvtest automaton_rvtest =3D {
> +=09.state_names =3D { "idle", "armed" },
> +=09.event_names =3D { "start" },
> +=09.env_names =3D { "clk" },
> +=09.function =3D {
> +=09=09{ armed_rvtest },=09/* idle */
> +=09=09{ INVALID_STATE },=09/* armed */
> +=09},
> +=09.initial_state =3D idle_rvtest,
> +=09.final_states =3D { 1, 0 },
> +};
> +
> +#include <rv/ha_monitor.h>
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
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +=09=09=09=09 enum states curr_state, enum events event,
> +=09=09=09=09 enum states next_state, u64 time_ns)
> +{
> +=09return true;
> +}
> +
> +static const struct rv_kunit_mon rvtest_mon __maybe_unused =3D
> RV_MON_OPS_INIT();
> +
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

A failed ASSERT quits the test and doesn't run any cleanup, either use a mo=
nitor
type that doesn't require cleanup or arm the cleanup here da_monitor_destro=
y()
and enabled =3D 0 should be enough).
The way we arm teardown_test() in rv_monitors_test.c should do.

> +=09da_monitor_init();
> +=09rv_this.enabled =3D 1;
> +
> +=09da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +=09scoped_guard(rcu)
> +=09=09da_mon =3D da_get_monitor(id, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, da_mon);
> +=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09/* Uptime below the budget: time_ns - expire_ns would underflow. */

This comment isn't quite meaningful as again it describe how the code was /=
once/
broken.
Be assertive like "Expect no underflow even if uptime is below budget (0)"

> +=09ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
> +=09KUNIT_EXPECT_TRUE(test, ha_check_invariant_ns(ha_mon, clk_rvtest, 0,
> +=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RVTEST_BUDGET_NS));
> +
> +=09/*
> +=09 * Budget already elapsed: expire - passed would underflow and queue
> +=09 * the timer at KTIME_SEC_MAX. Reset first so the expiry does not
> +=09 * report.
> +=09 */

So here what you're trying to simulate is:
* reset with now =3D 0
* start the timer when now =3D BUDGET + 1s
* validate the expires didn't overflow (timer expires in past)

The NSEC_PER_SEC is just a magic number to avoid off-by-ones right?
In both cases we aren't really waiting for 1s, but maybe just use
1ns (+ 1) to avoid confusion. Wouldn't that work?

The comment looks a bit misleading to me.
Again I would say something like "Expect no underflow if timer is
armed when already elapsed".
I wonder if the reset (timer cancel) is really required here.

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
> +=09da_destroy_storage(id);
> +=09da_monitor_destroy();
> +=09rv_this.enabled =3D 0;

This is the part I would /only/ put in a teardown helper triggered by
KUnit, and only the last 2 statements, the others are implied in the
destroy() aren't they?

Thanks,
Gabriele

> +}
> +
> +static struct kunit_case rv_ha_kunit_cases[] =3D {
> +=09KUNIT_CASE(rv_test_rvtest_underflow),
> +=09{}
> +};
> +
> +static struct kunit_suite rv_ha_kunit_suite =3D {
> +=09.name =3D "rv_ha",
> +=09.test_cases =3D rv_ha_kunit_cases,
> +};
> +
> +kunit_test_suite(rv_ha_kunit_suite);
> +
> +#endif /* CONFIG_RV_HA_MONITOR */
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for RV hybrid automata (HA) framework");

