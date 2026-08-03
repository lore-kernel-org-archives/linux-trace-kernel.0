Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FB411660
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761354; cv=none; b=qYe0exQ1v0n6ZUAMVK7tASv6vrJh7QUdlZQcKejY8RKyJGHhmkBNUP8dSiNH/ZnF43vouty3jb+HEgtb7ajx9O+lMrWuehLWCTepUmeK92aWLvSHEaWtchmWHCpHNEROdkc1VUVs9vyjqLDuKZJP7m/RlxVUsjvH3sx3fsFn/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761354; c=relaxed/simple;
	bh=wj7NUe9x08lEh1Fo3mn5CmlzMZefOM2QSdmrgIFx4pQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXxiUL9ROuq/MmHM+1kVNslgikRC9wkAQwgjcIn4A3jmwfemDBqGiQb8gAkTnu2GTYmHf2bgYtVkyX2s8uiS2R0lL3Pnq4YMi41u9IdokPrKbUipWIEKhGuEQ1oiRCmz4n+l9iHAO4SmuspzeOHil2XTgKrjzQDRJHi22WctFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyMBo00m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyMBo00m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785761352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8mSVLtH2u+KHDyfKn+Lr3+etOAnoe77d21/Ch96qtAE=;
	b=AyMBo00mu44BV2/8fQxQPnO2V4qbRQiwdQE52Hgt0bzEwuA9/YNYfcYUN4m0wuygwvRO7z
	uVNsIVM1KvUH+0D5EyKWSuyiHYY+/I1Vzq+enO200rElpk7IcYCShMztZDqs5G6+7/OzJ+
	O1JrwAVHMkWgxuL7gG75QG1Y8v/KKGY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ZtwXIIyLNCm5OAAUwyinNw-1; Mon, 03 Aug 2026 08:49:11 -0400
X-MC-Unique: ZtwXIIyLNCm5OAAUwyinNw-1
X-Mimecast-MFC-AGG-ID: ZtwXIIyLNCm5OAAUwyinNw_1785761350
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so21754705e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 05:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761350; x=1786366150;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wy0Vs4Ln8sXF3zFU/v51FDbJv/h2bqSlAWl9ZiAyaTI=;
        b=nRqKoq6PFJ6JktRPayRljlVkYCk+FM/FCa5FEZpyMKFp0mnu8b83mI0LQZKgk/aQ63
         iSzuMcPUO0vdMYYGcIZYq2XNEWvzY6txT4XbLHgnyHj0aPHRt/0rz2IYOxyc9pnehxn9
         9ohm/GkIAuT+g6iw92wF1TDKn3ZtupD71rAA9UIxOEMvaGR5wS2RChkvZEdbGja4crdq
         zhEnGrPwYPbNmdrPJSIZpuY1CJ2f+tYDdE3LUgRrKwJXwqkVvUxMMSNWdNWQunw2gUQN
         +g3RyyQutGEMcnwko0e61GboRHkb3wyQW05wW0k6jwmpltDWq2Hp/u69fIkeT1ihqfGH
         Ghyg==
X-Forwarded-Encrypted: i=1; AHgh+RoLi1g2E+NpEXFpO+z+G74fbFCQKtVZSTMw0tbz0AJ/gxkwgmXMuEnoBxKJE+qzjG/8a4jMKpGzdRs3OI0SaT87qhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCp5FB47Hd41vvuZICBJuwLTKqF1DT2/5dc4lZxgcJ/XNte7+
	3DaviSDwg300M14btwk9qbct6KP50WrinhLvsWCA5QoI4Z64zkgLuGNlu/TPMt54Skl8xrNx9Ij
	43aOsLavhr/zvTEXpO18cxXirYIgdbebK8+zpHe0ekYtQZDKvj+L/wjq/KEbdh7+l994pfjzNRg
	==
X-Gm-Gg: AR+sD12d5kIQt+GrjrW7la0ESvlHPEv0fqqjeeGRu/UVvY6x953HIR8w4wKz9oxFD5G
	kYEu0Y5/DJH87ohe26W6Aa0NGdaPGgYxi039NER9llzJbOlv3nC5ADivY/k+1sKQ/hIUthl1tzk
	5q+pGOFTkCmEitQWF+sRFK1DvN7Upr4qgBofEv6HgN5Zi9iPyqY1MJnHJ8YrGZkOoENozW0CnO1
	0/c1zVTp7qOvcIxuOP3EoUCTH1ZVXJhe8NoZzY7mzypIXmDMXdRcKevf0owGsoLiXttWivxqfOa
	9XmONflSMqxvYga+vKb2Ug35GAomcgZI2N+TFhgCCaNMu88MNtTsWxSA6nW9MUERIgAhF2REiru
	WcvnMvpGsEMuwXG6hRY/IGXDNP3As
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr194744815e9.0.1785761349667;
        Mon, 03 Aug 2026 05:49:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr194743855e9.0.1785761349018;
        Mon, 03 Aug 2026 05:49:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ef9sm254878215e9.1.2026.08.03.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:49:08 -0700 (PDT)
Message-ID: <d2bbe352facbd02de931305d23bcc2115d14fba5.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 14:49:07 +0200
In-Reply-To: <55a167aacaf1497fafbbe9fd578ffe14cbee368f.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
	 <55a167aacaf1497fafbbe9fd578ffe14cbee368f.1785695669.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: tBriX28shaXSxB2F4MdF7mcxMdQ35qQasUcVgx5bHz8_1785761350
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
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
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/rv_reactors_kunit.c | 143 +++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 156 insertions(+)
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
> index 000000000000..32c25dcf0cb6
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors_kunit.c
> @@ -0,0 +1,143 @@
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
> +/*
> + * rv_unregister_reactor() on a reactor that was never registered would
> + * list_del() an uninitialized list_head, so track registration and only
> + * unregister in the teardown if it is still on the list.
> + */
> +static bool test_reactor_registered;

I'm not too fond of adding more logic than necessary in the test, but if yo=
u
really want to keep the dynamic teardown cannot this variable stay somehow =
in
test-specific memory (test->priv)?

That feels to me a bit cleaner, although the reactor and obviously the reac=
tors
list are still static, so we probably wouldn't gain a huge deal.

What do you think?

> +
> +static int unregister_test_reactor(void)
> +{
> +=09int ret =3D 0;
> +
> +=09if (test_reactor_registered) {
> +=09=09ret =3D rv_unregister_reactor(&test_reactor);
> +=09=09test_reactor_registered =3D false;

rv_unregister_reactor() cannot fail and probably never will (I'm not quite =
sure
it should return int).
But setting test_reactor_registered to false here is assuming it didn't fai=
l
while the rest of the test doesn't make this assumption.

Maybe let's make it void and stop tracking a result that can never change (=
and
that real reactors already have to ignore).

If we do that you may even stop unregistering manually and rely only on the
teardown, and perhaps get rid of test_reactor_registered. Even
test_register_unregister() would be mostly already covered by the next one.
Just throwing in the idea.

> +=09}
> +
> +=09return ret;
> +}
> +
> +/*
> + * The teardown action guarantees the reactor is unregistered even if a
> + * test fails mid-way, so a leftover entry cannot corrupt later tests.
> + */
> +static void reactor_teardown(void *arg)
> +{
> +=09unregister_test_reactor();
> +}
> +
> +static void register_test_reactor(struct kunit *test)
> +{
> +=09KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
> +=09test_reactor_registered =3D true;
> +=09KUNIT_ASSERT_EQ(test,
> +=09=09=09kunit_add_action_or_reset(test, reactor_teardown,
> NULL), 0);
> +}
> +
> +static void test_register_unregister(struct kunit *test)
> +{
> +=09register_test_reactor(test);
> +
> +=09KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
> +}
> +
> +static void test_double_register(struct kunit *test)
> +{
> +=09register_test_reactor(test);
> +
> +=09KUNIT_EXPECT_EQ(test, rv_register_reactor(&test_reactor), -EINVAL);
> +
> +=09KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
> +}
> +
> +static void test_name_too_long(struct kunit *test)
> +{
> +=09/* Name length of MAX_RV_REACTOR_NAME_SIZE (32) must be rejected. */
> +=09static struct rv_reactor long_reactor =3D {
> +=09=09.name =3D "kunit_reactor_name_too_long_xxx_",
> +=09};
> +
> +=09KUNIT_ASSERT_EQ(test, (int)strlen(long_reactor.name),
> +=09=09=09MAX_RV_REACTOR_NAME_SIZE);

You probably want KUNIT_ASSERT_GE, or even better
_Static_assert(sizeof(long_name) - 1 >=3D MAX_RV_REACTOR_NAME_SIZE)

(you'd need to save the name to a static array first for sizeof() to work a=
s
expected)

> +=09KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
> +}
> +
> +static struct kunit_case rv_reactor_registration_cases[] =3D {
> +=09KUNIT_CASE(test_register_unregister),
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
> +=09/* rv_react() must silently return when monitor->react is NULL. */
> +=09rv_react(&monitor, "no callback");

So what are we testing here? That the kernel doesn't panic? It's fair to ex=
pect
a silent return, but we cannot really validate that.

If that's your intent, maybe specify it better, since, in fact, KUnit canno=
t
validate this. Something like:

  "The only possible failure in this test case is a kernel panic"

Thanks,
Gabriele

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

