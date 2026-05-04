Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0953DBD62;
	Mon,  4 May 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901639; cv=none; b=o63GH8+3xSY8iKo/gD4mfTcrBnVt1tKx3sJQY8mWAbjSuEL1t53KfVUwwJ6ZjOlg0C3keMrg3FvCxtxTDgYZd3e5kCiG0G0UHr9Kra3SZGJW5ku+/LWFGtkKgBRB2kVQS3xi34uIMjOt037S7rfILTDADR5fg1YdE+0psSSsMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901639; c=relaxed/simple;
	bh=j4VKZ+mQPT+jHXeOKikxNDC2FuxXNlUk0s6VUOf3Qt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSbOjVNekzcOOyGFBpkartJulPFz2b+ltCwyEkbfsce476khizFG9mvnUnz+8gK8GdRvKze5fg+cneCSFl3xeNjkBYpk53Uk3t3QpcekQCPQY1etvoafAfOrfr863lB1pJCAEO2uf7/+iSn5vHPuCu87zHQj2j8Mo1pmVezCXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnxcNfVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPUMNyPy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnxcNfVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPUMNyPy"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777901628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpOX3/VKQ3lN48t5AW459vOEXrjBWzZJsYyXv640W+c=;
	b=ZnxcNfVnablK7Zzse721Kb/S6oCnTWeI9wNL5sTZ5nxdRjc+d24SdntbTtYxZs4eIu7gF/
	5PCxO2jHBCE/bUba8oUrOc/PJUUE4sb2feQJjOhCqA80Mrqme54yIdD4/JPBzisZdc5sjr
	Pa09waZDDd+yQGLRsTME2/FsFfwCHDId/f3N07iC2801am7cX+6mpnXkVsplt4eYs7xONt
	q1KsH2oXYu+x13CG0zymXGQE2gFa42hdhfCfeS3fEJ5mvyQekDDgroMr0ocMV5JuvXT1qv
	f1/quyrweU2SLP3g8oEDXbNCFGPIKMmbXqkQn5/8gLP+4boUUDMypr68LbXi4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777901628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpOX3/VKQ3lN48t5AW459vOEXrjBWzZJsYyXv640W+c=;
	b=oPUMNyPyf07qaaysnqrPmvkQV3MfxlTwLVffLPcUhVY9mHT8OyWQWR4D/pJimE2+KAMKSP
	QKfNNG1lHuPCkBDg==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [RFC PATCH 10/12] rv: Add KUnit tests for some DA/HA monitors
In-Reply-To: <edc43db747832223dc2e7800c7b692327a1f5f82.camel@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
 <20260427151134.192971-11-gmonaco@redhat.com> <875x531scg.fsf@yellow.woof>
 <edc43db747832223dc2e7800c7b692327a1f5f82.camel@redhat.com>
Date: Mon, 04 May 2026 15:33:48 +0200
Message-ID: <87v7d38fk3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Mon, 2026-05-04 at 10:39 +0200, Nam Cao wrote:
>> Gabriele Monaco <gmonaco@redhat.com> writes:
>> > +obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) +=3D rv_monitors_test.o
>> > +# Stubbing rv_react triggers the error
>> > +CFLAGS_rv_monitors_test.o +=3D -Wno-suggest-attribute=3Dformat
>>=20
>> I try removing this flag, but my compiler does not produce any
>> warning. Which warning did you see?
>
> That's quite odd, I don't remember the exact GCC version that was showing=
 the
> warning, my current one does not enable it by default, you can however en=
able it
> with:
>
>   CFLAGS_rv_monitors_test.o +=3D -Wsuggest-attribute=3Dformat
>
> Then you get:
>
> In file included from kernel/trace/rv/rv_monitors_test.c:11:
> kernel/trace/rv/rv_monitors_test.c: In function =E2=80=98rv_trigger_test_=
init=E2=80=99:
> kernel/trace/rv/rv_monitors_test.c:68:42: error: argument 2 of =E2=80=98_=
_kunit_activate_static_stub=E2=80=99 might be a candidate for a format attr=
ibute [-Werror=3Dsuggest-attribute=3Dformat]
>    68 |         kunit_activate_static_stub(test, rv_react, stub_rv_react);
>       |                                          ^~~~~~~~
> ./include/kunit/static_stub.h:97:44: note: in definition of macro =E2=80=
=98kunit_activate_static_stub=E2=80=99
>    97 |         __kunit_activate_static_stub(test, real_fn_addr, replacem=
ent_addr);     \
>       |                                            ^~~~~~~~~~~~
> kernel/trace/rv/rv_monitors_test.c:68:52: error: argument 3 of =E2=80=98_=
_kunit_activate_static_stub=E2=80=99 might be a candidate for a format attr=
ibute [-Werror=3Dsuggest-attribute=3Dformat]
>    68 |         kunit_activate_static_stub(test, rv_react, stub_rv_react);
>       |                                                    ^~~~~~~~~~~~~
> ./include/kunit/static_stub.h:97:58: note: in definition of macro =E2=80=
=98kunit_activate_static_stub=E2=80=99
>    97 |         __kunit_activate_static_stub(test, real_fn_addr, replacem=
ent_addr);     \
>       |                                                          ^~~~~~~~=
~~~~~~~~
>
>> If it is not a hassle, I would prefer to address the warning in C code.
>> Grep tells me the rest of the kernel does not use this, how do other
>> subsystems not suffer from this warning?
>
> When the compiler was caring about it, I tried all I could think of to av=
oid the
> warning, but I didn't manage, some other places do disable this warning (=
just
> not in the makefile but with pragmas):
>
> $ git grep "suggest-attribute=3Dformat"
> drivers/infiniband/hw/hfi1/trace_dbg.h:#pragma GCC diagnostic ignored "-W=
suggest-attribute=3Dformat"
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h:#pragma GCC=
 diagnostic ignored "-Wsuggest-attribute=3Dformat"
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg=
.h:#pragma GCC diagnostic ignored "-Wsuggest-attribute=3Dformat"
> drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:#pragma GCC diagnostic =
ignored "-Wsuggest-attribute=3Dformat"
> include/trace/events/qla.h:#pragma GCC diagnostic ignored "-Wsuggest-attr=
ibute=3Dformat"
> kernel/panic.c:#pragma GCC diagnostic ignored "-Wsuggest-attribute=3Dform=
at"
> lib/vsprintf.c:__diag_ignore(GCC, all, "-Wsuggest-attribute=3Dformat",
>
>
> Here, the error comes from macro expansions in KUnit and I'm not sure the=
re's
> any practical way to solve it, that's why I resorted to disabling the war=
ning
> altogether.
> I'm not sure whether a pragma would be cleaner though.

Thanks for sharing the details. I can see now that disabling the warning
is the way to go.

>> > +void rv_test_opid(struct kunit *test)
>> > +{
>> > +	struct rv_kunit_ctx *ctx =3D test->priv;
>> > +
>> > +	da_prepare_test(test, &rv_this);
>> > +
>> > +	/*
>> > +	 * The handlers are called with an additional level of preemption,
>> > +	 * ensure we start from 0 but apply it here to avoid warnings.
>> > +	 */
>> > +	KUNIT_ASSERT_TRUE(test, preemptible());
>> > +	guard(preempt)();
>> > +
>> > +	/* Wakeup with preemption and interrupts enabled */
>> > +	handle_sched_waking(NULL, NULL);
>> > +	RV_KUNIT_EXPECT_REACTION(test, ctx);
>> > +
>> > +	/* Need resched with interrupts enabled */
>> > +	scoped_guard(preempt)
>> > +		handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
>>=20
>> From my understanding, this last one is testing that need_resched with
>> interrupt enabled does not invoke the reactor? And if the monitor is
>> broken and the reactor is invoked, we would have no test failure here,
>> but instead we have test failure the next time
>> RV_KUNIT_EXPECT_REACTION() is called. And if this is the last test, we
>> would not see a failure?
>
> Not really, I just forgot an RV_KUNIT_EXPECT_REACTION().

I added that missing RV_KUNIT_EXPECT_REACTION(), but I still see a test
failure:

[    1.070721]     # module: rv_monitors_test
[    1.073512]     1..7
[    1.077641] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5
[    1.078494]     ok 1 rv_test_sco
[    1.083256]     ok 2 rv_test_sssw
[    1.085783]     ok 3 rv_test_sts # SKIP Monitor not enabled
[    1.092365]     ok 4 rv_test_opid
[    1.093462]     # rv_test_nomiss: EXPECTATION FAILED at kernel/trace/rv/=
monitors/nomiss/nomiss.c:306
[    1.093462]     Expected ctx->reactions =3D=3D ++ctx->expected, but
[    1.093462]         ctx->reactions =3D=3D 2 (0x2)
[    1.093462]         ++ctx->expected =3D=3D 1 (0x1)
[    1.095699]     not ok 5 rv_test_nomiss
[    1.109418]     ok 6 rv_test_pagefault # SKIP Monitor not enabled
[    1.115146]     ok 7 rv_test_sleep # SKIP Monitor not enabled
[    1.118050] # rv_trigger: pass:3 fail:1 skip:3 total:7
[    1.118053] # Totals: pass:3 fail:1 skip:3 total:7
[    1.120622] not ok 1 rv_trigger

Any idea why?

> So I'm actually thinking of defining yet another macro that fundamentally=
 does
>
> RV_KUNIT_EXPECT_NO_REACTION()
> handle_event()
> RV_KUNIT_EXPECT_REACTION()
>
> which would make sure the reaction happens exactly there, plus I'd add an
> RV_KUNIT_EXPECT_NO_REACTION() in the cleanup sequence to ensure no unexpe=
cted
> reaction occurred (or nobody forgot to expect a reaction like I did above=
).

Sounds nice, go for it.

> Yeah that should be neater, but weren't you the one not liking macros? ;)

It's not black and white, I like whatever makes the code clean and easy
to read. Sometimes macros are nice, other times not so much. I have
spent hours reading the tracepoints' macros and they are still black
magic to me (but to be fair, macros are probably the best we can do for
that case). I hope we can rewrite those in Rust's generic one day.

Nam
