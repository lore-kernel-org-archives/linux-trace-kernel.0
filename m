Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5573A544C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348922; cv=none; b=SMI4bz7TKjclNa+wjDuNUWooIiwwrlnaoY24dgTyb/RpWR4EpXaYSfZvDlS+Dz01iHTFz125ej6LKZbRlkbsogTc1w9kKhi6ceFUfSjoyDjSwgGQ+5x4krOB95Q3DCxtnKCwVmFBk1hoMFHVN5mZ0KT3Zr3QunjE9nVDzc3eLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348922; c=relaxed/simple;
	bh=uFimuXuNtWCbg4vPg9NqUseCHxt1kY596j2Ug+FS3Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6iV/SC31MFsrb6/nIDvGTVziktpllQrIfZkoxmfB8SqNJfn3XFkFG+3mFsBg/G6/5ExZFyF0R9qObwpPlPiUpVWMuMXRUuphjtq+B7qMl5hWUK82aC3ZNZB7wR3J9WAU03w061U503WJqDbeu8A5sFsclnpg4pG5q6Yu4FQ4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8e0soz6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8e0soz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uFimuXuNtWCbg4vPg9NqUseCHxt1kY596j2Ug+FS3Mk=;
	b=N8e0soz6KTFEBoj0wsoIg6T1QnDw21SzE9j6QY4vBIfEEhANOtjhZPJVjsscfa22SFlyA7
	gRpMuZAD+ZtQ20fEDEutE/+Z3R6LvmIvjSdeu0W5PangvteTZ0H74kK3G8ssvJyO0scBfL
	5Kv9F4clFE8Pc9e7+eo3WZ0dNZpPdsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-hrFhIOwCOF2LpXlX9Pg2lg-1; Mon, 06 Jul 2026 10:41:58 -0400
X-MC-Unique: hrFhIOwCOF2LpXlX9Pg2lg-1
X-Mimecast-MFC-AGG-ID: hrFhIOwCOF2LpXlX9Pg2lg_1783348917
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493d88406cdso11474685e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 07:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348917; x=1783953717;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4vSocdhgQmY+88cc0lZGMxORd0li31CD/emUQkKxPo=;
        b=N8ql7/Ab3af8l/Sd17uypC3ljhm5Z6RpidS2jMVgAc12CxlqZlLffWp5njtibAKE/m
         megpvFUhmpKof01tUFtVLUTaadtt5woj41rPNnTHgvEgc202nEvgcmGxdLGIKvjOG6HY
         6A1jvaZoeAJadtcuLtqS8Wm2Q/oIXHgKBtMCMn183MQFPOhydiuab8zI01v5YsRy07jz
         Ns4g9dQCyuJblLY3RjIqSpyBYYIw9BYSdierR+mlMxoGwfWMChcgbQVDDMeNk+SZ3gdJ
         QIpf+LIHG+Nby5+69tnWuw0q9NQsAV7DO1gkn9K+mFq1Bw4DspCxlDNHziFX5/6FyMij
         ejmw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+nnL3rR0GDpyoTcL8j8buot4t7RZfqWeiYHvI8x6oTpE08Zg3rD+F0bi4wOa5taUhGZwJrN+n93ktFXjkio/Nrck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3SHfSMhEYL1HCJR1l3Ls9X8FX8qCQy7jUU57aRP4ctk29XV1
	7u7BsB8Kq2TNA4Aou2y2zO6Ko8ecxvD7qtru31xq/pwoioOnWtyjFVfSGv2EknhAR4i7s565loQ
	A/lpOnwIQhe3EEtbUpOXfSuTaRrZCmzY+5xXlb/MjNZHb8gXk+vOyALdjZspsWoSu0pVN1musCw
	==
X-Gm-Gg: AfdE7ck8LYmIM+Js7IIuSGLy1w5u7uhQIaokD2PIhhqKlLaRsZBp7hylZHHZrgXXVCH
	hTFZCtVpv9TS95EWeuqz4OdldsBmCpgxw4kdC9WLHJ9sfqSKWvwC5Wljh3jzCp6IGgj2GCPaBGz
	D2PcQSXUy2jVWOc2u76AKE8NyaK3C+fw91qn9MVft+zaMPYfgYoAuMfjQIUsSgtzrrNug5H2Hd2
	fHKch0FliPrzyfrxdUGiLErBkk+FcAXokP3SZvhB2IeG59c5DRqmBS/a8CyO2nNHR/MgZVAvaY9
	qj4eZGJyS9MjitsFPKqduSK8tK8ZySnSF8sI/C2dMEg0j6Ly3esxMMe1f1kJH3VBTwKNVKsL/l8
	yfHaEvcTWHEEhGb9nmC7WUttirxyrnlc3HUe8m/KFc0wPu0IcUkye5PkiQ6GkHyI3usDRXCDW0W
	+0nVWw
X-Received: by 2002:a05:600c:6386:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-493df073919mr9830435e9.14.1783348917412;
        Mon, 06 Jul 2026 07:41:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6386:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-493df073919mr9830075e9.14.1783348917015;
        Mon, 06 Jul 2026 07:41:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm24827680f8f.24.2026.07.06.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:41:56 -0700 (PDT)
Message-ID: <97dc3ac923f1910a6103665fa5d69aca28430b6a.camel@redhat.com>
Subject: Re: [PATCH 2/3] rv/reactors: add KUnit tests for reactor_printk
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 16:41:55 +0200
In-Reply-To: <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: Y4rMfV4Ti_YERFB74PL7YHfI0SsfIu-HXqx6qUiN5-g_1783348917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add KUnit tests for the printk reactor covering:
> - Reactor registration and unregistration lifecycle
> - React callback invocation via rv_react()
> - Double registration rejection
> - Multiple register/unregister cycles
>=20
> The mock callback calls vprintk_deferred() =E2=80=94 the same path as the=
 real
> reactor =E2=80=94 then busy-waits to simulate I/O back-pressure, exercisi=
ng the
> LD_WAIT_FREE constraint of rv_react() under load.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/reactor_printk_kunit.c | 123 ++++++++++++++++++++++=
+++
> =C2=A03 files changed, 134 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/reactor_printk_kunit.c
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 3884b14df375..ff47895c897f 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -104,6 +104,16 @@ config RV_REACT_PRINTK
> =C2=A0=09=C2=A0 Enables the printk reactor. The printk reactor emits a pr=
intk()
> =C2=A0=09=C2=A0 message if an exception is found.
> =C2=A0
> +config RV_REACT_PRINTK_KUNIT
> +=09bool "KUnit tests for reactor_printk" if !KUNIT_ALL_TESTS
> +=09depends on RV_REACT_PRINTK && KUNIT
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 This builds KUnit tests for the printk reactor. These are only
> +=09=C2=A0 for development and testing, not for regular kernel use cases.
> +
> +=09=C2=A0 If unsure, say N.
> +
> =C2=A0config RV_REACT_PANIC
> =C2=A0=09bool "Panic reactor"
> =C2=A0=09depends on RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 94498da35b37..ef0a2dcb927c 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -23,4 +23,5 @@ obj-$(CONFIG_RV_MON_NOMISS) +=3D monitors/nomiss/nomiss=
.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> +obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) +=3D reactor_printk_kunit.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> diff --git a/kernel/trace/rv/reactor_printk_kunit.c
> b/kernel/trace/rv/reactor_printk_kunit.c
> new file mode 100644
> index 000000000000..933aa5602226
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_printk_kunit.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for reactor_printk
> + *
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/rv.h>
> +#include <linux/printk.h>
> +#include <linux/sched/clock.h>
> +#include <linux/processor.h>
> +
> +/*
> + * Simulated execution time for mock_printk_react (sched_clock units,
> + * nanoseconds).=C2=A0 Models the time a real printk reactor callback ma=
y consume
> + * under I/O pressure, exercising the LD_WAIT_FREE constraint of rv_reac=
t().
> + */
> +#define MOCK_REACT_DURATION_NS=095000000ULL
> +
> +/*
> + * Mock react callback mirroring rv_printk_reaction().
> + *
> + * Calls vprintk_deferred() =E2=80=94 the same path as the real reactor =
=E2=80=94 then holds
> + * the CPU for MOCK_REACT_DURATION_NS via a sched_clock() timed busy-loo=
p,
> + * simulating a callback that is slow due to I/O back-pressure.
> + * sched_clock() is notrace and lock-free; no sleep or lock acquisition =
is
> + * performed, satisfying the LD_WAIT_FREE constraint of rv_react().
> + */
> +__printf(1, 0) static void mock_printk_react(const char *msg, va_list ar=
gs)
> +{
> +=09u64 start =3D sched_clock();
> +

I'm fine testing something that looks like the printk reactor rather than t=
he
real thing, but here sched_clock() is playing with preemption and could tri=
gger
one, this isn't accurate.

I'm not sure all implementations are free from this problem, but why don't =
you
just use mdelay() here?

> +=09vprintk_deferred(msg, args);
> +
> +=09while (sched_clock() - start < MOCK_REACT_DURATION_NS)
> +=09=09cpu_relax();
> +}
> +
> +static struct rv_reactor mock_printk_reactor =3D {
> +=09.name=09=09=3D "test_printk",
> +=09.description=09=3D "test printk reactor",
> +=09.react=09=09=3D mock_printk_react,
> +};
> +
> +/* Test 1: register and unregister reactor */
> +static void test_printk_register_unregister(struct kunit *test)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_register_reactor(&mock_printk_reactor);
> +=09KUNIT_EXPECT_EQ(test, ret, 0);

Yeah checking the return value is the maximum we can do without exporting
internal static functions. I'd say we don't need to be too pedantic on that=
.

> +=09KUNIT_EXPECT_STREQ(test, mock_printk_reactor.name, "test_printk");
> +
> +=09rv_unregister_reactor(&mock_printk_reactor);
> +}
> +
> +/* Test 2: react callback is invoked via rv_react() */
> +static void test_printk_react_called(struct kunit *test)
> +{
> +=09struct rv_reactor reactor =3D {
> +=09=09.name=09=3D "printk_cb_test",
> +=09=09.react=09=3D mock_printk_react,
> +=09};
> +=09struct rv_monitor monitor =3D {
> +=09=09.name=09=3D "test_monitor",
> +=09=09.reactor =3D &reactor,
> +=09=09.react=09=3D mock_printk_react,
> +=09};
> +
> +=09rv_react(&monitor, "printk violation message");
> +}
> +
> +/* Test 3: double registration should fail */
> +static void test_printk_double_register(struct kunit *test)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_register_reactor(&mock_printk_reactor);
> +=09KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +=09ret =3D rv_register_reactor(&mock_printk_reactor);
> +=09KUNIT_EXPECT_NE(test, ret, 0);
> +
> +=09rv_unregister_reactor(&mock_printk_reactor);
> +}
> +
> +/* Test 4: register/unregister cycle */
> +static void test_printk_register_cycle(struct kunit *test)
> +{
> +=09int ret, i;
> +
> +=09for (i =3D 0; i < 5; i++) {
> +=09=09ret =3D rv_register_reactor(&mock_printk_reactor);
> +=09=09KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +=09=09rv_unregister_reactor(&mock_printk_reactor);
> +=09}
> +}
> +
> +/* Test 5: react callback is not NULL (printk reactors must provide reac=
t) */
> +static void test_printk_react_not_null(struct kunit *test)
> +{
> +=09KUNIT_EXPECT_NOT_NULL(test, mock_printk_reactor.react);

As others pointed out, those assertions on a variable you control aren't ne=
eded.

Thanks,
Gabriele

> +}
> +
> +static struct kunit_case reactor_printk_kunit_cases[] =3D {
> +=09KUNIT_CASE(test_printk_register_unregister),
> +=09KUNIT_CASE(test_printk_react_called),
> +=09KUNIT_CASE(test_printk_double_register),
> +=09KUNIT_CASE(test_printk_register_cycle),
> +=09KUNIT_CASE(test_printk_react_not_null),
> +=09{}
> +};
> +
> +static struct kunit_suite reactor_printk_kunit_suite =3D {
> +=09.name=09=09=3D "rv_reactor_printk",
> +=09.test_cases=09=3D reactor_printk_kunit_cases,
> +};
> +
> +kunit_test_suite(reactor_printk_kunit_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for reactor_printk");

