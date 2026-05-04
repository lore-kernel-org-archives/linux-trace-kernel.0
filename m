Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489DA3A6B6A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 May 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894969; cv=none; b=HRuzdPFjZr/eBekNSsomQdp1+97+W6bdxN1+0rgthUBYD6aP04TnjCgNBVvisERxgJfhw4NE2mzkz4mWHYkNMhNlKDbztk81gpNEBcDmrAzDmzxLrld/fdj6q/jwPsOluJiSM/CgMHZsBZ2zr01hbctT7BztlmigywvpYWDakUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894969; c=relaxed/simple;
	bh=rWlvmxUpAU8huA1VT5mxwgyd1YXcDjpuMhLXFe7DvdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgqBAbJom3+nmknV9Aj7ox2ovWLL/2afm1Zopu2PWjhtNJAHaZc9z09lQx/D5OzJn1c/1sMyBJbbxJCFyDTrM8mXSzJdBZJmrGT5j9xmrlbB2rYICCReQRFUnyl1Tm0K8WthOd/lcnlaoWVs5Oudm7jyPnCHYZSuQIDDkE1sQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2o9fpYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2o9fpYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777894967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S0xDOinWOpDN0YcBaphfy+8Lr4eORGAr+z1xWHCjO3c=;
	b=E2o9fpYyy3+YeQe7qE6I4HbcpvM46bGxnixxtsuIku+Hu79/EudO+J0bEIkVzxxvHXzVOL
	8wKVlFkrAQpiNEtDRX9EMpoJ6FNOduIfXmbxUD/vlhgVzacsmSOli6zocS7ju7W5mPSgBv
	OP4vPqrf7jjXd2Owgd/o+QbEDxhJlCY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-jZm0iNMJNJGzG_soeyXDug-1; Mon, 04 May 2026 07:42:46 -0400
X-MC-Unique: jZm0iNMJNJGzG_soeyXDug-1
X-Mimecast-MFC-AGG-ID: jZm0iNMJNJGzG_soeyXDug_1777894965
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a71109b94so2208011f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 May 2026 04:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894965; x=1778499765;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMEasgqhAAGJ+RuYMUc24kOpmjaquGPcdl6GvfA7WIY=;
        b=JxKKejLO7357PaE0x9fjKtSbFV3HHYBUh84jMZRZeRtdTuSr3kU7m2hI6mZRc8eSGD
         SU/4mx8jIEHS5GwvBjzpRk/dzlEw2dPpqh+i1B8sXMUcfxfJCEpZwYtg+/2D7odECfED
         T89Rr6tvd5VHZ2ySBrXGQSyQ7YC5VBBJfxM8DXAbI29VZL3ka+22h7/RPZ61L4JOkXQH
         YL7sZK3lOw79wlD2uZoHbmIV8iUNTAx0MoP37CPObOsQPB09Vb6NsIy3B5XD9Za7iCiV
         ixLNrOYQIHfGZugBSZY/Gxx0umQDjXJIV5LgWPx05YTb2fHwRXN68L0N2ocB0Jw+P27A
         fF0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sCCO+YX6EbBS/fGQ97QH+BEvAsFWQ978xfbOJ2Ik2WX3cuo5yPT9be267HDB/1L34YC4JfFnlA5h7bD4WWlYZpWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEfzXV9GzttP40wiE52m+XS+NsVd5velja4JpkXKxwCQ7pm5k
	u0qS8LJ91c+ejfWgzhwTUFXgZbB3WBxUe1EHGlvXm9PV13x7k+3hbyVKK9cOv4rnjB3YIQ9pCEY
	Iv5EpqI6znnSItYFTB/9tErE/j/ypp59pLsRF0hfxtbWGHtNTcCZLBB8RdGeO+ffKXboQ8xyzLx
	NA31Ulg1/9
X-Gm-Gg: AeBDieuZWwH4MWT7+Y/Pf8kxsxwJ8qS0ZpNkhnrUM9UPdvNks8psgWMbMynRUmztEc6
	vH4GbW7KGPXsb9yc/tVcI2FbrzQNi2osiCUbB4PEK1iv2mXIxp7GFbMfM3yTeyHhEl4PiAi+f+8
	9VkeyBkno28YTZFfzhDyqD9F++DgWbPICCpvRSbneafx95Wam0M7f4BuEuVwi74yBPPolBT1liG
	P+ZLUnhnpxKI2M/CoTjY0tENzMiEPyJgYkprHp00u76k32o3fo/e1ORIr16e0gfE3xrWZ0JG7q4
	wha1qR9VaQDWfbzksn6OnQazgdaqwy0zQcK1Gz1oVOSdQK8qrG5wa147ZsRVWmGzkzUTH+hMbwA
	WTRf8jzHtonly28X7H+8ndkdFcITI53bVh5w7CUpy7jax5jgQ2XtQASBhXvORsjXh03uBIgVXCf
	uHs381VROfqIoxRYFhTYHHABXDag==
X-Received: by 2002:a05:6000:40c7:b0:43d:6787:992f with SMTP id ffacd0b85a97d-44bb37c7fabmr14875385f8f.10.1777894964800;
        Mon, 04 May 2026 04:42:44 -0700 (PDT)
X-Received: by 2002:a05:6000:40c7:b0:43d:6787:992f with SMTP id ffacd0b85a97d-44bb37c7fabmr14875327f8f.10.1777894964286;
        Mon, 04 May 2026 04:42:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f424032sm25049121f8f.15.2026.05.04.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:42:43 -0700 (PDT)
Message-ID: <edc43db747832223dc2e7800c7b692327a1f5f82.camel@redhat.com>
Subject: Re: [RFC PATCH 10/12] rv: Add KUnit tests for some DA/HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>,  Wen Yang <wen.yang@linux.dev>
Date: Mon, 04 May 2026 13:42:36 +0200
In-Reply-To: <875x531scg.fsf@yellow.woof>
References: <20260427151134.192971-1-gmonaco@redhat.com>
	 <20260427151134.192971-11-gmonaco@redhat.com> <875x531scg.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: gYEaotJ3IxDZJmWBEE0EUxUJzsI07GbaTIMfoEAopDg_1777894965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-04 at 10:39 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_monitors_test.o
> > +# Stubbing rv_react triggers the error
> > +CFLAGS_rv_monitors_test.o +=3D -Wno-suggest-attribute=3Dformat
>=20
> I try removing this flag, but my compiler does not produce any
> warning. Which warning did you see?

That's quite odd, I don't remember the exact GCC version that was showing t=
he
warning, my current one does not enable it by default, you can however enab=
le it
with:

  CFLAGS_rv_monitors_test.o +=3D -Wsuggest-attribute=3Dformat

Then you get:

In file included from kernel/trace/rv/rv_monitors_test.c:11:
kernel/trace/rv/rv_monitors_test.c: In function =E2=80=98rv_trigger_test_in=
it=E2=80=99:
kernel/trace/rv/rv_monitors_test.c:68:42: error: argument 2 of =E2=80=98__k=
unit_activate_static_stub=E2=80=99 might be a candidate for a format attrib=
ute [-Werror=3Dsuggest-attribute=3Dformat]
   68 |         kunit_activate_static_stub(test, rv_react, stub_rv_react);
      |                                          ^~~~~~~~
./include/kunit/static_stub.h:97:44: note: in definition of macro =E2=80=98=
kunit_activate_static_stub=E2=80=99
   97 |         __kunit_activate_static_stub(test, real_fn_addr, replacemen=
t_addr);     \
      |                                            ^~~~~~~~~~~~
kernel/trace/rv/rv_monitors_test.c:68:52: error: argument 3 of =E2=80=98__k=
unit_activate_static_stub=E2=80=99 might be a candidate for a format attrib=
ute [-Werror=3Dsuggest-attribute=3Dformat]
   68 |         kunit_activate_static_stub(test, rv_react, stub_rv_react);
      |                                                    ^~~~~~~~~~~~~
./include/kunit/static_stub.h:97:58: note: in definition of macro =E2=80=98=
kunit_activate_static_stub=E2=80=99
   97 |         __kunit_activate_static_stub(test, real_fn_addr, replacemen=
t_addr);     \
      |                                                          ^~~~~~~~~~=
~~~~~~

> If it is not a hassle, I would prefer to address the warning in C code.
> Grep tells me the rest of the kernel does not use this, how do other
> subsystems not suffer from this warning?

When the compiler was caring about it, I tried all I could think of to avoi=
d the
warning, but I didn't manage, some other places do disable this warning (ju=
st
not in the makefile but with pragmas):

$ git grep "suggest-attribute=3Dformat"
drivers/infiniband/hw/hfi1/trace_dbg.h:#pragma GCC diagnostic ignored "-Wsu=
ggest-attribute=3Dformat"
drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h:#pragma GCC d=
iagnostic ignored "-Wsuggest-attribute=3Dformat"
drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h=
:#pragma GCC diagnostic ignored "-Wsuggest-attribute=3Dformat"
drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:#pragma GCC diagnostic ig=
nored "-Wsuggest-attribute=3Dformat"
include/trace/events/qla.h:#pragma GCC diagnostic ignored "-Wsuggest-attrib=
ute=3Dformat"
kernel/panic.c:#pragma GCC diagnostic ignored "-Wsuggest-attribute=3Dformat=
"
lib/vsprintf.c:__diag_ignore(GCC, all, "-Wsuggest-attribute=3Dformat",


Here, the error comes from macro expansions in KUnit and I'm not sure there=
's
any practical way to solve it, that's why I resorted to disabling the warni=
ng
altogether.
I'm not sure whether a pragma would be cleaner though.

> > +void rv_test_opid(struct kunit *test)
> > +{
> > +=09struct rv_kunit_ctx *ctx =3D test->priv;
> > +
> > +=09da_prepare_test(test, &rv_this);
> > +
> > +=09/*
> > +=09 * The handlers are called with an additional level of preemption,
> > +=09 * ensure we start from 0 but apply it here to avoid warnings.
> > +=09 */
> > +=09KUNIT_ASSERT_TRUE(test, preemptible());
> > +=09guard(preempt)();
> > +
> > +=09/* Wakeup with preemption and interrupts enabled */
> > +=09handle_sched_waking(NULL, NULL);
> > +=09RV_KUNIT_EXPECT_REACTION(test, ctx);
> > +
> > +=09/* Need resched with interrupts enabled */
> > +=09scoped_guard(preempt)
> > +=09=09handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
>=20
> From my understanding, this last one is testing that need_resched with
> interrupt enabled does not invoke the reactor? And if the monitor is
> broken and the reactor is invoked, we would have no test failure here,
> but instead we have test failure the next time
> RV_KUNIT_EXPECT_REACTION() is called. And if this is the last test, we
> would not see a failure?

Not really, I just forgot an RV_KUNIT_EXPECT_REACTION().

sched_need_resched just requires interrupts disabled, so I disable preempti=
on
and show that seeing it with only interrupts enabled should react (touching
preemption is actually not required, but just to get a different test case)=
.

> If so, should we perhaps have something like RV_KUNIT_EXPECT_NO_REACTION(=
)
> here? So that if the monitor is broken and the reactor is called, then
> the kunit test will fail exactly where the failure is.
>=20
> Reading the patch further down below, we actually do have that
> macro! Shouldn't we use it here?

So I'm actually thinking of defining yet another macro that fundamentally d=
oes

RV_KUNIT_EXPECT_NO_REACTION()
handle_event()
RV_KUNIT_EXPECT_REACTION()

which would make sure the reaction happens exactly there, plus I'd add an
RV_KUNIT_EXPECT_NO_REACTION() in the cleanup sequence to ensure no unexpect=
ed
reaction occurred (or nobody forgot to expect a reaction like I did above).

> > +#ifdef CONFIG_RV_MON_SCO
> > +extern void rv_test_sco(struct kunit *test);
> > +#else
> > +static inline void rv_test_sco(struct kunit *test)
> > +{
> > +=09kunit_skip(test, "Monitor not enabled\n");
> > +}
> > +#endif
>=20
> Instead of these, I would prefer we have something like
>=20
> #define KUNIT_CASE_IF(test_name, enabled) \
> =09{ .run_case =3D enabled ? test_name : some_stub, ... }
>=20
> and
>=20
> static struct kunit_case rv_trigger_test_cases[] =3D {
> =09KUNIT_CASE_IF(rv_test_sco, CONFIG_RV_MON_SCO),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =09{}
> };
>=20
> or something like that. But no big deal.

Yeah that should be neater, but weren't you the one not liking macros? ;)

Thanks,
Gabriele

