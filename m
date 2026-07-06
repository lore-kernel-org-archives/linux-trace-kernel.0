Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510EC3A9615
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349342; cv=none; b=Q0lOOACK+eB1Y6ZNFTDu9BWCjxOHKvFIyqHqtIEMIvqaHhsIvwu0jgZbttKH/VKZI0OUGLgZI3G+QVZlw2cbM2ZPdIwi71FqPy7fiHw+lM/zHp88uap0WSprd7fTCSsT67VjIaRJ/ZvUlt7HBczhHS5pyH9Z5TKFJQ/dWRgE5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349342; c=relaxed/simple;
	bh=4+UYFD9nTN96JUY1ca1P6/m61ytFY0OJQEwjeybh2eE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJfY3A40iUU3PI220HGMxVi1D2aGku/dN/IEPaRuw/KCcRa2uEzgvjHmejznER07lURLD2XnrPSJPyGj1PjjER69MXno5AnARBP4CPsXjU31UDGz7ts7mK2MU+KIwTUchzQXpD1wle5C5FlSiiMG6o6YIedqsOHYCdhTfzVINaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFEf+unq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFEf+unq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783349340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4+UYFD9nTN96JUY1ca1P6/m61ytFY0OJQEwjeybh2eE=;
	b=JFEf+unqXF7cvoPAJ3dSTuXzNBQET5GadQrXdqQvHa9UnSaN7UvZarH+lJDIe+ekAcnU8X
	/PQW/yNrR6XTddkWYuwEQKzjiVhiQGu9y7wxVgL10e73HCTGCUhy04vIkVcmPSuWtx8HVl
	dvdeFYTqwZz38YZGN9VWj1wdO+Deohw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-wM7ZxnbgPtywW9T_q147Ug-1; Mon, 06 Jul 2026 10:48:56 -0400
X-MC-Unique: wM7ZxnbgPtywW9T_q147Ug-1
X-Mimecast-MFC-AGG-ID: wM7ZxnbgPtywW9T_q147Ug_1783349335
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so30654275e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 07:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349335; x=1783954135;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOMnvqGP4lOoTQG9VISXpd6zj1FzYhNYSBHInVki2Z8=;
        b=iK5C64JjfsmZfh2xV+Zy0eBpe3I9Rmq0I6FNA75acr5v0qxjTxzC1gBxCPwy5lp32G
         dFOKp306TWwwV9BsuDKNx4mWJ8AF5eDLw+EYlVOnBB8/neit1Hmf5IDfCqLBu7jhRwYu
         A9FDNrcSmUOLaMx2pS6p/EObiwZH5Ikpp+mtaHX06YK8yZjnprytc/lfY2RQUcODPCjd
         2mhAwA6kJSQ6x9GTZf9esrY/uSMlld7LBzj2Hsp3n8xwtcrsT9GcP+C2l4PyNZM3Mcgx
         Ww6gKhj+l3iD0hDVfhmwYRIDYDHEwDz7ShyCsLDEbiIEO6jYUjB8DCxe8k5FBsIaZZDJ
         oC5A==
X-Forwarded-Encrypted: i=1; AHgh+RrolxWdFb6721JWj6GsmlaEp/zw9wO7dwKqpYUIxWPLoskkSw0lo5yPRUm6O5tcpkfzm+9nLTD4hyYxSMgRYyjbj1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnPYta311iI6FSHf0J/myVD17wISBXW5HfZ16OCwdVaFSiZax
	ZToiok9ljgNUd4TVGdPQsMiHJ/ydK6Cc0NpVd2Jt4ERk0UkijJt4STL88bQJfU5d1dpebEE5rXf
	ycQKQz74uXGjPhfCTf+HGIxoxnHilnP18XTtjxOL/XEJA7latsdpzo2ZwpHO12YBMq0eqiMw4xQ
	==
X-Gm-Gg: AfdE7ckqs10opGNSSOTCXSniuqhN8U/VyJc70p+iN9T8FKEOAx2lQvs4x2hchaUAUi/
	NfuvQVJ3PwMKoJdE+E+GH77XgLXu8IJeiuaStqN5GzJVHsS5yQOH7e6OWVz+pm6UsOjRlw5B4LM
	uo3H5eBmRC20AkvusXsFmnpByhoQvtEK7wGX0QOcMs5e/c+ObFQbH6CCODfkMiNT/7Ogokd+V+p
	P65Qk2gUKQMw7AADR5VbuYO2FwzndtmYn0W3SYJNU0kHj7lkurI1WmzYoW14GqH0QdLaLQ6e8hn
	CKMvr+rrnCln9DL6Ou2P1MxghWg0JKGOw9Ivhatn9N862KAELzu2qltZHLBu1FOXuihVGIeXewI
	xo9i7CSSueKHbkcmWBaNqkbLxMVI6nhJXqJAdXz/037dKAGa4P/TYe+tuLOopJmn96BT5ckk0Qc
	YQ5227
X-Received: by 2002:a05:600c:6286:b0:493:c3e4:c9c0 with SMTP id 5b1f17b1804b1-493df092ad0mr10095485e9.24.1783349334707;
        Mon, 06 Jul 2026 07:48:54 -0700 (PDT)
X-Received: by 2002:a05:600c:6286:b0:493:c3e4:c9c0 with SMTP id 5b1f17b1804b1-493df092ad0mr10095145e9.24.1783349334213;
        Mon, 06 Jul 2026 07:48:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm673339825e9.7.2026.07.06.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:48:53 -0700 (PDT)
Message-ID: <0575d651270c6ee2d10571c2e7ecb537398885e5.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 16:48:52 +0200
In-Reply-To: <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: f4rl5JOgqa2961cvGsKlUtHWfEjKR05OFvH2s10sJQM_1783349335
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add KUnit tests for the panic reactor covering:
> - Reactor registration and unregistration lifecycle
> - Panic notifier chain reachability
>=20
> The real rv_panic_reaction() calls vpanic(), which is __noreturn and
> halts the system. KUnit cannot test across that boundary. Instead, the
> test drives atomic_notifier_call_chain(&panic_notifier_list, ...) directl=
y
> with a high-priority mock notifier that returns NOTIFY_STOP, verifying
> that the panic notification propagates without triggering real handlers
> (kdump, watchdog, reboot).
>=20
> The mock notifier busy-waits to simulate real handler execution time
> (e.g., crash_save_vmcoreinfo, emergency_restart preamble) under the
> panic context constraints.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/reactor_panic_kunit.c | 106 +++++++++++++++++++++++=
+++
> =C2=A03 files changed, 117 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/reactor_panic_kunit.c
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index ff47895c897f..6c6c43c5f86c 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -121,3 +121,13 @@ config RV_REACT_PANIC
> =C2=A0=09help
> =C2=A0=09=C2=A0 Enables the panic reactor. The panic reactor emits a prin=
tk()
> =C2=A0=09=C2=A0 message if an exception is found and panic()s the system.
> +
> +config RV_REACT_PANIC_KUNIT
> +=09bool "KUnit tests for reactor_panic" if !KUNIT_ALL_TESTS
> +=09depends on RV_REACT_PANIC && KUNIT
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 This builds KUnit tests for the panic reactor. These are only
> +=09=C2=A0 for development and testing, not for regular kernel use cases.
> +
> +=09=C2=A0 If unsure, say N.
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index ef0a2dcb927c..2ebfe5e5068c 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) +=3D reactor_printk_kunit.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> +obj-$(CONFIG_RV_REACT_PANIC_KUNIT) +=3D reactor_panic_kunit.o
> diff --git a/kernel/trace/rv/reactor_panic_kunit.c
> b/kernel/trace/rv/reactor_panic_kunit.c
> new file mode 100644
> index 000000000000..f9a09ae7aaad
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_panic_kunit.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for reactor_panic
> + *
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/rv.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/notifier.h>
> +#include <linux/limits.h>
> +#include <linux/sched/clock.h>
> +#include <linux/processor.h>
> +
> +/* Simulated execution time for mock panic notifier (nanoseconds). */
> +#define RV_PANIC_NOTIFIER_EXEC_NS=092000000ULL
> +
> +/* Test state */
> +static struct {
> +=09bool notifier_called;
> +} panic_test_state;

A struct isn't really needed I guess, but good to have a way to test there =
was a
call.

> +
> +/*
> + * Mock panic notifier callback.
> + *
> + * Runs at INT_MAX priority and returns NOTIFY_STOP to prevent real pani=
c
> + * handlers (kdump, watchdog) from executing during the test.=C2=A0 Busy=
-waits
> + * RV_PANIC_NOTIFIER_EXEC_NS to simulate a real handler's execution time=
.
> + */
> +static int mock_panic_notifier_fn(struct notifier_block *nb,
> +=09=09=09=09=C2=A0 unsigned long action, void *data)
> +{
> +=09char *msg =3D data;
> +=09u64 start =3D sched_clock();
> +
> +=09panic_test_state.notifier_called =3D true;
> +=09pr_emerg("KUnit: reactor_panic test intercepted panic notifier:
> %s\n",
> +=09=09 msg ? msg : "(no message)");

Since we cannot panic(), do we really need to test yet another mock reactor=
?
What if you put the notifier_called in the other test and drop this test
altogether?

We can simulate what panic() does right now, but it isn't too representativ=
e if
this ever changes.

Also it's good to make this reactor test buildable as a module. Currently s=
ome
functions aren't exported, feel free to just EXPORT_SYMBOL_GPL() them. Ther=
e is
no need not to have modular reactors, just nobody did it before.

Thanks,
Gabriele

> +
> +=09while (sched_clock() - start < RV_PANIC_NOTIFIER_EXEC_NS)
> +=09=09cpu_relax();
> +
> +=09return NOTIFY_STOP;
> +}
> +
> +static struct notifier_block mock_panic_nb =3D {
> +=09.notifier_call=09=3D mock_panic_notifier_fn,
> +=09.priority=09=3D INT_MAX,
> +};
> +
> +static struct rv_reactor mock_panic_reactor =3D {
> +=09.name=09=09=3D "test_panic",
> +=09.description=09=3D "test panic reactor",
> +};
> +
> +static int reactor_panic_kunit_init(struct kunit *test)
> +{
> +=09panic_test_state.notifier_called =3D false;
> +=09return 0;
> +}
> +
> +/* Test 1: register and unregister reactor */
> +static void test_panic_register_unregister(struct kunit *test)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_register_reactor(&mock_panic_reactor);
> +=09KUNIT_EXPECT_EQ(test, ret, 0);
> +=09KUNIT_EXPECT_STREQ(test, mock_panic_reactor.name, "test_panic");
> +
> +=09rv_unregister_reactor(&mock_panic_reactor);
> +}
> +
> +/*
> + * Test 2: panic notifier chain is reachable.
> + *
> + * vpanic() calls atomic_notifier_call_chain(&panic_notifier_list, ...).
> + * Drive the chain directly to verify panic notifiers receive the
> notification =E2=80=94
> + * the observable side-effect of reactor_panic without halting the syste=
m.
> + */
> +static void test_panic_notifier_called(struct kunit *test)
> +{
> +=09atomic_notifier_chain_register(&panic_notifier_list, &mock_panic_nb);
> +=09atomic_notifier_call_chain(&panic_notifier_list, 0,
> +=09=09=09=09=C2=A0=C2=A0 "panic violation message");
> +=09atomic_notifier_chain_unregister(&panic_notifier_list,
> &mock_panic_nb);
> +
> +=09KUNIT_EXPECT_TRUE(test, panic_test_state.notifier_called);
> +}
> +
> +static struct kunit_case reactor_panic_kunit_cases[] =3D {
> +=09KUNIT_CASE(test_panic_register_unregister),
> +=09KUNIT_CASE(test_panic_notifier_called),
> +=09{}
> +};
> +
> +static struct kunit_suite reactor_panic_kunit_suite =3D {
> +=09.name=09=09=3D "rv_reactor_panic",
> +=09.init=09=09=3D reactor_panic_kunit_init,
> +=09.test_cases=09=3D reactor_panic_kunit_cases,
> +};
> +
> +kunit_test_suite(reactor_panic_kunit_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for reactor_panic");

