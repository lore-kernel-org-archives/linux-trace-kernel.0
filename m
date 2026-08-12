Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AD30F548
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539509; cv=none; b=U75lHd3oLk78QvEEuVPbwE8hjc9mm0UguWzilvDmnFnsK4VvWAMqmqBGD4DG2L4tEE2P7ph9fn/yDvDpS23ajhnX9qLCI5L2SpGTUyP4nNV+2GK78ZL+wt7Kx2Wzp1y0ABP/cWsOU0LII8Qn0e6HpndBMQjzCOR+Bkb8KgqxETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539509; c=relaxed/simple;
	bh=VB8tFel0bLIZrX8cX/AT9FEF0W6fuoAcKbOxizIj2FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oboOiS0G3v1YDQVu7ZGqoZA7gf28hbfCIUU/SmIB4cVvklWbATU1ItUUOR32L+6rJ62xFZEiOl8lpiXoAE8pO78kUqBXhndiM1f7/Ehycl1tdWaqwPp3efdi6ECwg1a1PQSzHttEkBg2f4VNWLXTxd9MOCYjn0v5+/UZMTNwEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRIIjzHO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRIIjzHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786539507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VB8tFel0bLIZrX8cX/AT9FEF0W6fuoAcKbOxizIj2FU=;
	b=ZRIIjzHOmVcuCt3Ri96nbWP1mY/dz3SbFwd6lqPV9kQOWZ55gerBhE9nKhqK3aaAiF5d2T
	rsp/CeyrrZQz7PAuTBTI0eT1NSA9Xuhk+dZINwNoQ+zjFEN9P/ObJ8Wi4puxIdu38GXGDI
	8ouvQQ92F8KSd6tZEQAsCL8ifFTskyY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-KduckJm5N46zFA6dgVvZGw-1; Wed, 12 Aug 2026 08:58:24 -0400
X-MC-Unique: KduckJm5N46zFA6dgVvZGw-1
X-Mimecast-MFC-AGG-ID: KduckJm5N46zFA6dgVvZGw_1786539503
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so6654335e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 05:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539503; x=1787144303;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JZS83lnqCs33LC+4LLmdPuymKcj34JVEyMERpsgtAT4=;
        b=AQGWIbsrL0CbMp34EhkefYHyqJ1Vsvw72Oq2qIsxlUc4G5XtL2fWvmKZM2mLQhlG1V
         1NoDith+0Vtu6tB07RTOaeQy3uNPRyuufpJRwJIPABqtgQX63I7Ah94Y6alKCEZiLC1f
         bwKxspdlFoOf+RfGhfpsDWBBz4NfUubHN1jKq+keVFGOaHMpmoKx61EQU1bpUh8wetwm
         w1cfE8Y1P4mUCREzL8d82AjSK7FDfC3GI7nSbgLUcDOkyT7lW318R4giafPPcWeQn+uB
         YxndCIkpoRSfvXwzANgwLs+bjeTiewk6z55b7uL4Ycw5XZXcmMOVKbEXBDAHm1Gnsp/v
         gsGw==
X-Forwarded-Encrypted: i=1; AHgh+RqwoyhpAZzBIexl8pDo0rTGU3REc7wIVTtoGunkJlj92UxWCWoI5VMY4hKEEi356dUNZZuS2uM2RoWaKYgOQrOBdMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIgbo+e6xJ/AoaWeSHdMGFvsDGdqPNx7WeqIdNgg55s9jWMFz
	vHoh2jt0a7mXKCWpXBZ2Xeyn2vq9GHgd4EnD/RES+tku1rJbUhW+sRpzcsZcF4HyCJIcPtn+gHJ
	5xkFI2iX1BprGKhvnRRnKBEA+iLTXXPpFc7PcCFfp8AU8mkYpzoihPzpAOaWVP+d0XHmEetmRag
	==
X-Gm-Gg: AR+sD10/6S8am054nht0eugYXDihACc8V7I+AA+0QI9pMmstO3MiX16mU/WpbUe/UQD
	+/zFm7p4aSVpR72MUv+OceqSXcS1lVTyIWBSTOHBogmpTz+WMXjju8FL90tZHsxEUbuQgcnbUkt
	+S0mVR6jdqgnPH9rPcz8l7Z7c2FAVubGA7xxUKPUbkwg2nCvRmhsrRKhqS757uybA0kJzxLek4R
	LTXVuEjl8KoWUz+yYmAG+zbTaBujpttPccB7tixkKBudqqmm8z0CdqEcUX5iKs2F49zB+p/caeS
	GHwBnzFWxZDBDisOH1qImWvw6eD8XbtGu6MLWqty52KBWYrB4B13z3oAUECfCjpro1Z8TsFXQpC
	9+8jKEQYXwkBjJObil8MNwwmzTxeB
X-Received: by 2002:a05:600c:4692:b0:498:519:e660 with SMTP id 5b1f17b1804b1-4997c0f7161mr53347725e9.4.1786539502704;
        Wed, 12 Aug 2026 05:58:22 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:498:519:e660 with SMTP id 5b1f17b1804b1-4997c0f7161mr53347325e9.4.1786539502270;
        Wed, 12 Aug 2026 05:58:22 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abeba23sm67013875e9.11.2026.08.12.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:58:21 -0700 (PDT)
Message-ID: <abff002f4287ccbaf80d098ce1b369012394627c.camel@redhat.com>
Subject: Re: [PATCH v3 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 12 Aug 2026 14:58:20 +0200
In-Reply-To: <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
	 <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: vLnHI20YEP3tz1Rx5OkyjnVU7Nk_yVOGPFwZkNkA8xw_1786539503
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add KUnit tests covering the reactor register/unregister lifecycle
> (including duplicate and name-length rejection) and rv_react() dispatch
> (a no-op without a callback, exactly one invocation with one; the mdelay
> callback keeps the CPU busy so a timer interrupt exercises the LD_WAIT_SP=
IN
> lockdep context).=C2=A0 The Kconfig entry is tristate so the tests can be=
 built
> as a module when CONFIG_KUNIT=3Dm; only RV_REACTORS is required.
>=20

Looks simple and good now.

> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>

Same as before, you can leave only

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks
Gabriele

> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/rv_reactors_kunit.c | 119 +++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 132 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/rv_reactors_kunit.c
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index efa930f94ea4..9bfd429ffdea 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -113,6 +113,18 @@ config RV_REACT_PANIC
> =C2=A0=09=C2=A0 Enables the panic reactor. The panic reactor emits a prin=
tk()
> =C2=A0=09=C2=A0 message if an exception is found and panic()s the system.
> =C2=A0
> +config RV_REACTORS_KUNIT
> +=09tristate "KUnit tests for RV reactors" if !KUNIT_ALL_TESTS
> +=09depends on KUNIT
> +=09depends on RV_REACTORS
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 Enable KUnit tests for RV reactor registration and dispatch.
> +=09=C2=A0 These tests verify the register/unregister lifecycle, duplicat=
e
> +=09=C2=A0 rejection, and that rv_react() correctly invokes callbacks.
> +
> +=09=C2=A0 If unsure, say N.
> +
> =C2=A0config RV_MONITORS_KUNIT_TEST
> =C2=A0=09tristate "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
> =C2=A0=09depends on KUNIT && RV && RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index cdbf68c84f5a..c895d81dfdad 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_RV_MON_WAKEUP) +=3D monitors/wakeup/wakeup=
.o
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> +obj-$(CONFIG_RV_REACTORS_KUNIT) +=3D rv_reactors_kunit.o
> =C2=A0obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_monitors_test.o
> diff --git a/kernel/trace/rv/rv_reactors_kunit.c
> b/kernel/trace/rv/rv_reactors_kunit.c
> new file mode 100644
> index 000000000000..d5b731eb11f3
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors_kunit.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for RV reactor registration and dispatch.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/rv.h>
> +#include <linux/delay.h>
> +#include <linux/atomic.h>
> +#include "rv.h"
> +
> +static struct rv_reactor test_reactor =3D {
> +=09.name=09=09=3D "kunit_test_reactor",
> +=09.description=09=3D "KUnit test reactor",
> +};
> +
> +static void reactor_teardown(void *arg)
> +{
> +=09rv_unregister_reactor(&test_reactor);
> +}
> +
> +static void register_test_reactor(struct kunit *test)
> +{
> +=09KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
> +=09KUNIT_ASSERT_EQ(test,
> +=09=09=09kunit_add_action_or_reset(test, reactor_teardown,
> NULL), 0);
> +}
> +
> +static void test_double_register(struct kunit *test)
> +{
> +=09register_test_reactor(test);
> +=09KUNIT_EXPECT_EQ(test, rv_register_reactor(&test_reactor), -EINVAL);
> +}
> +
> +/*
> + * Use a fixed-size array so sizeof() gives the exact byte count at
> + * compile time.
> + */
> +static const char long_reactor_name[] =3D "kunit_reactor_name_too_long_x=
xx_";
> +_Static_assert(sizeof(long_reactor_name) - 1 >=3D MAX_RV_REACTOR_NAME_SI=
ZE,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "long_reactor_name must be at le=
ast MAX_RV_REACTOR_NAME_SIZE
> chars");
> +
> +static void test_name_too_long(struct kunit *test)
> +{
> +=09static struct rv_reactor long_reactor =3D {
> +=09=09.name =3D long_reactor_name,
> +=09};
> +
> +=09KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
> +}
> +
> +static struct kunit_case rv_reactor_registration_cases[] =3D {
> +=09KUNIT_CASE(test_double_register),
> +=09KUNIT_CASE(test_name_too_long),
> +=09{}
> +};
> +
> +static struct kunit_suite rv_reactor_registration_suite =3D {
> +=09.name=09=09=3D "rv_reactor_registration",
> +=09.test_cases=09=3D rv_reactor_registration_cases,
> +};
> +
> +static atomic_t react_call_count;
> +
> +__printf(1, 0) static void mock_react(const char *msg, va_list args)
> +{
> +=09atomic_inc(&react_call_count);
> +=09/*
> +=09 * Hold the CPU for 5 ms so a timer interrupt is likely to fire
> +=09 * inside rv_react()'s lockdep context, exercising the LD_WAIT_SPIN
> +=09 * constraint.=C2=A0 mdelay() is a calibrated busy-wait with no sched=
uler
> +=09 * interaction.
> +=09 */
> +=09mdelay(5);
> +}
> +
> +static void test_react_no_callback(struct kunit *test)
> +{
> +=09struct rv_monitor monitor =3D {
> +=09=09.name =3D "kunit_null_react",
> +=09};
> +
> +=09atomic_set(&react_call_count, 0);
> +=09rv_react(&monitor, "no callback");
> +
> +=09/*
> +=09 * The only possible failure in this test case is a kernel panic.
> +=09 * NULL react guard: callback must NOT have been invoked
> +=09 */
> +=09KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 0);
> +}
> +
> +static void test_react_callback_invoked(struct kunit *test)
> +{
> +=09struct rv_monitor monitor =3D {
> +=09=09.name=09=3D "kunit_dispatch_monitor",
> +=09=09.react=09=3D mock_react,
> +=09};
> +
> +=09atomic_set(&react_call_count, 0);
> +=09rv_react(&monitor, "callback invocation test");
> +=09KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 1);
> +}
> +
> +static struct kunit_case rv_react_dispatch_cases[] =3D {
> +=09KUNIT_CASE(test_react_no_callback),
> +=09KUNIT_CASE(test_react_callback_invoked),
> +=09{}
> +};
> +
> +static struct kunit_suite rv_react_dispatch_suite =3D {
> +=09.name=09=09=3D "rv_react_dispatch",
> +=09.test_cases=09=3D rv_react_dispatch_cases,
> +};
> +
> +kunit_test_suites(&rv_reactor_registration_suite, &rv_react_dispatch_sui=
te);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for RV reactor registration and dispatch=
");

