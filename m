Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACE369D45
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189287; cv=none; b=cz1e3Ik92VyK627j50AQU9JajDUZ+wbEwRfA9gwwd3AeKh0x3aHlXNEoZXdOFnd6kOkPGWCf/47Tly35nVtBGtsBiLIfsbYqPd4jwaFa9OpJd45Qh7SOJEJI25oEb6dAaE6yRhAfRpMV3REstPi/f56LhXrO1zl1wb1IDD1PROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189287; c=relaxed/simple;
	bh=jKH9+ilz8fHR4Mg1cRJQo1i88vTtkPLStOOUUCbcX9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lohmaWVdMZ1tUGQvkefaECXgCJPXadhzRbCon52YQByELy2Eu4Eapx5mHvgFvj1ItzpCQtJfJYlbeewAz5W63sXt8pL49q2G9S7wRyW4InD4iVN1u1BoG54b59owr/F4Qpqsuc7ddyjGZlSeFzIohURInl38aB3Hw6k0yqnoIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+3mDrwe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+3mDrwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779189280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jKH9+ilz8fHR4Mg1cRJQo1i88vTtkPLStOOUUCbcX9g=;
	b=G+3mDrweRazy3o9Lc5C3Solf+yFFs41aiGrXb+tG+KAQxrySBSZb3AHSMa76lSU0FgtOIc
	OvZjPh6raRUgI6AW+hOS0OIJTnxRZg3RO2COqFTqlAeonBjr35KhJ5CTMp8BGFmQvLGSLE
	7UsjU+W4b36cN7tZbOR5ivlA9mRXPl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-F9Q5mw4GNGaGUw5fdM-fEw-1; Tue, 19 May 2026 07:14:37 -0400
X-MC-Unique: F9Q5mw4GNGaGUw5fdM-fEw-1
X-Mimecast-MFC-AGG-ID: F9Q5mw4GNGaGUw5fdM-fEw_1779189276
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4497a0e3acaso3540965f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 04:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779189276; x=1779794076;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKH9+ilz8fHR4Mg1cRJQo1i88vTtkPLStOOUUCbcX9g=;
        b=S95EDhU3LlQZJpKvr4jF6206d5jLKkEuVrlr8wI3TxRgz79+b0iiTlB5AxTMfPMAz8
         Vbc2KmEvePbTEXHtBER0LTqyZ/j5dwW57WZ6uoazBOT4Q4MNdFNNoOzfSFjdgHjbvHw6
         +gwTsYKI148KOaqzG1vxqiDKKGhlEr5mxnB07v2jCCK4dSwCyXC3JduuKZy/vWupnI0n
         dCKvEyQlWkOZT2js+vPlBmPr6JMed89dJnGu6y2ji0UPvK+/LmIbzvde3QmfrFH4nQLH
         QfKOPe0wuS1J5u5LxL4q6PrgPqc88Z7AkDA9OiD9XcyLBjy72ujsZNiDx9CWWqEThJ9M
         CfrA==
X-Forwarded-Encrypted: i=1; AFNElJ+nhEa+K8JgR4ED3Itw0LGAD9app/81wSd1Te6LbsfqQbiJm+uiPSUZ3FCkl2iyUMhn4V1YNjjzGcy6W2ErftVAuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9ZqmtrF2ON2b3oI65E32gpMAi9tcxP9fPOEQ6RzSpyA3KfNE
	xDpI3Aur+FO7VcqW+AQ2Oo6uS8akVYZoTEqEyfCYeKur9TY4COfaWD8mU+onfuBrORazHlxplo3
	yqS1lmE6ASa787kN4ShsZcOT6oEG+YG7I6rKHy+/FkJDK9g4VrbIY/S/72BnvchBHy7aj7HWNYw
	==
X-Gm-Gg: Acq92OFoIjHNqGAkzHOuKPD0q7H3IQwIXXQb/m5U0ZOrhc0odIVvFfht2UULFRKeLNA
	mZ5Y+njiBGp1ZAWNkPht/qQSgYTIdTTHJ+qTspDU9zr2SSPXOPHGYSmqJ5/f5Mhet/5tVhm2pqa
	iWRzR7D6q6SSaFhDMwnp7utMXstMzqqwFySEJdl52MZQ95PGshp3K9z5QTxreEiKDOYQXj/I0Q8
	lfEtKrfwhq0w/YQWz5DECBe+aSxZ45AMPsD19QF5UbveU+tVIDJFiIYQOpwlsgF8gt6lW2sUz+S
	b0vlHQ9nfbpa8PWDaUmPJpE2aFcyUq7hD0pcJPTGoetbUE+BVkX8fTMJIAntZkv1JXwll8xW+1j
	X7vzw/V+VHmbCwysueoIIx3DWxCvW5mVgpB3imhN1XENT96IKG6XljapCYBRhzEfNzlnD4B1MuL
	BUQeT4ZU1OXIC8jZY=
X-Received: by 2002:a5d:44d2:0:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-45e739b3f89mr12331588f8f.0.1779189276307;
        Tue, 19 May 2026 04:14:36 -0700 (PDT)
X-Received: by 2002:a5d:44d2:0:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-45e739b3f89mr12331549f8f.0.1779189275707;
        Tue, 19 May 2026 04:14:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm44278581f8f.30.2026.05.19.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:14:35 -0700 (PDT)
Message-ID: <5183dc18d63b617ab0f19290e8a790fa6898f372.camel@redhat.com>
Subject: Re: [PATCH] Re: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated
 storage pool for per-object monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Date: Tue, 19 May 2026 13:14:33 +0200
In-Reply-To: <6d2f3490-5e30-4966-a3cd-372a34e10ba2@linux.dev>
References: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
		 <20260515083002.106512-1-gmonaco@redhat.com>
		 <6d2f3490-5e30-4966-a3cd-372a34e10ba2@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uJ9Qywcr8jyCdvMEuQGvy8fTicz4i_7UhWPOP7iRTTo_1779189276
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wen,

On Mon, 2026-05-18 at 01:13 +0800, Wen Yang wrote:
>=20
> Yes.=C2=A0 The ftracetest check_requires logic calls `command -v <binary>=
` to
> satisfy `requires: <name>:program` directives.=C2=A0 Without the script's
> directory in PATH those checks evaluate to exit_unsupported and test case=
s
> are skipped rather than run.=C2=A0 The make path avoids this only because=
 make
> sets OUTDIR and the runner appends it to PATH internally.
>=20

So you're overriding PATH so the selftest's binaries can be found from
the test, right?

Wouldn't it be simpler to just put the absolute paths in the tests and
don't touch PATH.

If the selftests are run via makefile, it ensures the required binaries
are built and available, so there's no need to go through the `requires:
<name>:program` infrastructure (that's more about what's installed on
the system.

Or if you don't want anything hardcoded, you could pass the $OUTDIR from
the environment and use that in scripts, whatever looks cleaner.

Does it make sense to you?

>=20
> -- Patch 04: pre-allocated storage pool
>=20
> =C2=A0> Since you're using spinlocks, isn't that going to sleep on PREEMP=
T_RT?
>=20
> User-mode uprobe handlers run with preempt_count =3D=3D 0, fully preempti=
ble on
> both PREEMPT_RT and non-PREEMPT_RT.=C2=A0 The strongest evidence is in tl=
ob
> itself: tlob_start_task() takes a mutex and calls kmem_cache_zalloc(...,
> GFP_KERNEL) from the uprobe entry handler; both are illegal in atomic
> context and would trigger lockdep splats immediately.
>=20
> On PREEMPT_RT, spinlock_t becoming a sleeping lock in the uprobe handler=
=20
> iscfine: both call sites (da_create_or_get_pool() from the handler and
> da_pool_return_cb() from the rcuc kthread) are in sleepable task context.
>=20

Yeah exactly, the uprobe is fine with anything (even the automatic
`kmalloc_nolock`), but sure preallocation at least guarantees the slots
are there.

> =C2=A0> We can have a macro DA_MON_ALLOCATION_STRATEGY =3D {DA_ALLOC_AUTO=
,
> =C2=A0> DA_ALLOC_POOL, DA_ALLOC_MANUAL} where DA_MON_POOL also requires
> =C2=A0> DA_MON_POOL_SIZE to be defined (force that with an #error).
> =C2=A0>
> =C2=A0> Anyway, this way you probably wouldn't need to define a different=
 init
> =C2=A0> function and let everything handled more transparently.
> =C2=A0>
> =C2=A0> Also you don't need to call da_create_or_get() explicitly,
> =C2=A0> da_handle_start_event() should do it for you.
>=20
> Agreed on all counts.=C2=A0 We plan to implement this in v3 as follows.
> The three strategies would be a compile-time selection in da_monitor.h:
>=20
> =C2=A0=C2=A0 DA_ALLOC_AUTO=C2=A0=C2=A0 (default) - lock-free kmalloc_nolo=
ck on the hot path;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unbounded capacity.
>=20
> =C2=A0=C2=A0 DA_ALLOC_POOL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pre-allocated fixed-size pool;=20
> DA_MON_POOL_SIZE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required, enforced with #error if missing=
.
>=20
> =C2=A0=C2=A0 DA_ALLOC_MANUAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - caller pre-inserts storage via
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_create_empty_storage() before the firs=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_handle_start_event(); the framework on=
ly
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 links the target field.
>=20
> da_monitor_init_prealloc() would be removed; da_monitor_init() would
> select pool or kmalloc initialisation internally based on the strategy.
>=20
> da_handle_start_event() and da_handle_start_run_event() would both call
> da_prepare_storage() at compile time:
>=20
> =C2=A0=C2=A0 DA_ALLOC_AUTO=C2=A0=C2=A0 -> da_create_storage()=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (kmalloc_nolock)
> =C2=A0=C2=A0 DA_ALLOC_POOL=C2=A0=C2=A0 -> da_create_or_get_pool()
> =C2=A0=C2=A0 DA_ALLOC_MANUAL -> da_fill_empty_storage()=C2=A0=C2=A0=C2=A0=
 (link target into pre-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allocated slot; no a=
llocation on the hot path)
>=20
> No explicit da_create_or_get() call would be needed in any monitor.
>=20
> da_create_or_get_kmalloc() would be removed: as you noted, a caller that
> uses kmalloc_nolock does so because locking is forbidden; a GFP_KERNEL
> fallback is equally forbidden if the lockless attempt fails, so the
> function has no viable use case.
>=20
> tlob would define:
> =C2=A0=C2=A0 #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_POOL
> =C2=A0=C2=A0 #define DA_MON_POOL_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TLOB_MAX_MONITORED
>=20
> nomiss would define:
> =C2=A0=C2=A0 #define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL
>=20
> and call da_create_empty_storage() from handle_sys_enter() (the
> sched_setscheduler syscall path), which runs in safe task context;
> da_fill_empty_storage() would then link the sched_dl_entity target on
> the first da_handle_start_run_event() call in handle_sched_switch().

Yeah good point, there's no need to make it a special path even if we
have the target ready, da_handle_start_run_event() can do it just fine.

>=20
>=20
> -- Patch 05: generic uprobe infrastructure
>=20
> Carried unchanged into v3 (as part of the 08-b split described below).
>=20
>=20
> -- Patch 06: rvgen __init arrow reset
>=20
> Thanks, carried unchanged into v3.
>=20

Well, if you don't need reset() on the __init arrow we can drop this,
right? Also it doesn't seem fully wired with the rest and requires a
separate event to do handle_monitor_start(), which can be only just
another handler for tlob, nothing general.

>=20
> =C2=A0> Why don't you make it a separate event (e.g. "start_tlob") [...] =
then
> =C2=A0> you also wouldn't need to call reset() and start_timer() manually=
.
>=20
> Good suggestion.=C2=A0 We plan to use a dedicated start_tlob event instea=
d,
> with a self-loop in tlob.dot:
>=20
> =C2=A0=C2=A0 "running" -> "running" [ label =3D "start;reset(clk_elapsed)=
" ]
>=20
> da_handle_start_run_event(task->pid, ws, start_tlob) would put the
> monitor into running and deliver start_tlob, which resets clk_elapsed
> and arms the budget hrtimer via the generated ha_setup_invariants() =E2=
=80=94
> no manual reset() or start_timer() calls needed.
>=20
> One guard would be added in tlob's ha_setup_invariants() to make the
> self-loop work correctly:
>=20
> =C2=A0=C2=A0 if (next_state =3D=3D curr_state && event !=3D start_tlob)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> Without this, the start_tlob self-loop would be treated the same as any
> repeated switch_in (already running) and ha_setup_invariants() would
> return early, leaving the timer unarmed.=C2=A0 Does this look right to yo=
u?
>=20

If you just add a separate event rvgen should take care of everything,
you should be able to take ha_verify_constraint() and friends as-is from
the generated code.

But yeah, that's what it would end up doing.

>=20
> -- Patch 08: tlob monitor
>=20
> --- Patch structure ---
>=20
> =C2=A0> Could you have everything that isn't strictly tlob-related in ano=
ther
> =C2=A0> patch.
>=20
> Agreed.=C2=A0 With the ioctl interface deferred (see below), v3 would kee=
p
> patch 08 as the tlob monitor only:
>=20
> =C2=A0=C2=A0 05-b: rv: extend uprobe API with three-phase detach helpers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (rv_uprobe.c, rv_uprobe.=
h, rv_uprobe_detach refactoring)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=94 extension of p=
atch 05, independent of tlob
>=20
> =C2=A0=C2=A0 08:=C2=A0=C2=A0 rv/tlob: add the tlob monitor itself
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (tlob.c, tlob.h, tlob_tr=
ace.h, Kconfig/Makefile, Documentation,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_trace.h include=
; ha_monitor.h EVENT_NONE_LBL override
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bundled here as it=
 is only needed by tlob)
>=20
> The chardev infrastructure (rv_chardev.c, rv.h additions) and the UAPI
> header (include/uapi/linux/rv.h) would move to a follow-up series
> together with the ioctl self-instrumentation feature.
>=20
> --- ioctl interface design ---
>=20
> =C2=A0> I'm not particularly fond of ioctls, they aren't that flexible an=
d in
> =C2=A0> this way I don't really see an added value.
> =C2=A0> [...] cannot the same thing be achieved using uprobes alone, e.g.=
 by
> =C2=A0> registering a function address or the current instruction pointer=
?
> =C2=A0> [...] wouldn't a sysfs/tracefs file achieve a similar purpose wit=
hout
> =C2=A0> much of the boilerplate code?
>=20
> Fair point.=C2=A0 We plan to ship v3 with the tracefs/uprobe interface on=
ly
> and defer the ioctl (/dev/rv chardev) to a follow-up series once there
> is a concrete in-tree user that requires it.
>=20
> The unique value of the ioctl is that TLOB_IOCTL_TRACE_STOP returns a
> synchronous per-call result (-EOVERFLOW or 0) to the calling thread,
> which neither uprobes nor tracefs writes can provide.=C2=A0 We want to ke=
ep
> that option open for later, but agree it should not block the initial
> tlob submission.
>=20
> Does this approach work for you?
>=20
> What is your preference?

Yeah looks good to me.
Ioctls are cumbersome to set up also for the user, perhaps another sysfs
file in the monitor directory would keep the control entirely in tlob.c
and give you roughly the same value with easier setup.

Heck we might even think of an RV reactor that does that: e.g. creates a
file where reads sleep until the first reaction (-EOVERFLOW) and returns
0 in other scenarios. I'm gonna have a thought on that, but anyway I
don't see why a sysfs file cannot do this.

Let's defer it for now.

>=20
> --- Handler simplification ---
>=20
> =C2=A0> Perhaps keep the handler simpler by moving this reporting to a he=
lper
> =C2=A0> function and use guard(rcu)() there.
>=20
> Done.=C2=A0 The accumulation logic is extracted into three inline helpers=
, each
> using scoped_guard(rcu) and returning bool (true if the task is monitored=
):
>=20
> =C2=A0=C2=A0 tlob_acc_running(prev)=C2=A0=C2=A0 - accumulate running_ns o=
n sched-out
> =C2=A0=C2=A0 tlob_acc_waiting(next)=C2=A0=C2=A0 - accumulate waiting_ns o=
n sched-in
> =C2=A0=C2=A0 tlob_acc_sleeping(task)=C2=A0 - accumulate sleeping_ns on wa=
keup
>=20
> handle_sched_switch() and handle_sched_wakeup() become one-liners:
>=20
> =C2=A0=C2=A0 static void handle_sched_switch(...)
> =C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool prev_preempted =3D (prev_state =
=3D=3D 0);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tlob_acc_running(prev))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_handle_ev=
ent(prev->pid, NULL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 prev_preempted ? preempt_tlob : sleep_tlob);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tlob_acc_waiting(next))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_handle_ev=
ent(next->pid, NULL, switch_in_tlob);
> =C2=A0=C2=A0 }

Yeah sounds good.

>=20
> =C2=A0> You probably don't need these. da_handle_event should skip tasks =
without
> =C2=A0> a monitor.
>=20
> Agreed; the do_prev/do_next flags are gone.=C2=A0 The helpers return fals=
e
> for unmonitored tasks, and da_handle_event() skips them too =E2=80=94 bot=
h paths
> are no-ops for tasks with no pool entry.
>=20
> --- scoped_guard(rcu) ---
>=20
> =C2=A0> That should be a scoped_guard(rcu), definitely use guards if you =
have
> =C2=A0> return paths, the compiler is going to clean up (unlock) for you.
>=20
> Applied to all RCU-protected sections in tlob_start_task() and
> tlob_stop_task().=C2=A0 tlob_start_task() now uses guard(mutex) for the
> serialised duplicate-check (replacing the explicit mutex_lock/unlock),
> and tlob_stop_task() uses scoped_guard(rcu) for the atomic CAS section:
>=20
> =C2=A0=C2=A0 scoped_guard(rcu) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ws =3D da_get_target_by_id(task->pid=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ws)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ESRC=
H;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_cmpxchg_release(&ws->stop=
ping, 0, 1) !=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGA=
IN;
> =C2=A0=C2=A0 }

Perfect.

>=20
> --- tlob_stop_all removal ---
>=20
> =C2=A0> All this function does should be done by da_monitor_destroy. We c=
ould
> =C2=A0> add a way to pass some additional deallocation for all the other =
cleanup
> =C2=A0> you're doing on each storage.=C2=A0 Something like a da_extra_cle=
anup() you
> =C2=A0> can define as whatever you need and gets called in all per-obj
> =C2=A0> destruction paths.
>=20
> Agreed.=C2=A0 tlob_stop_all() (~50 lines) has been removed entirely.
>=20
> A da_extra_cleanup() hook macro is introduced in da_monitor.h: the defaul=
t
> is a no-op; a monitor may override it before including the header.=C2=A0 =
tlob
> defines:
>=20
> =C2=A0=C2=A0 static inline void tlob_extra_cleanup(struct da_monitor *da_=
mon)
> =C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ha_monitor *ha_mon =3D to_ha_=
monitor(da_mon);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tlob_task_state *ws =3D da_ge=
t_target(ha_mon);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ws)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_cmpxchg_release(&ws->stop=
ping, 0, 1) !=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_cancel_timer_sync(ha_mon);
After my patch making timer callbacks RCU read-side critical section,
you won't need that, just let the usual reset asynchronously stop the
timer and put everything that needs it stopped in your RCU callback.

Of course make sure the timer was stopped before this extra cleanup, so
put the macro accordingly.

I don't think da_extra_cleanup in general should be expected to sleep
and call_rcu should do the heavy lifting (it may run from any tracepoint).

Anyway we can see it later after that's merged.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&tlob_num_monitored);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_task_struct(ws->task);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_rcu(&ws->rcu, tlob_free_rcu);
> =C2=A0=C2=A0 }
> =C2=A0=C2=A0 #define da_extra_cleanup tlob_extra_cleanup
>=20
> da_monitor_destroy() iterates remaining entries via da_extra_cleanup +
> hash_del_rcu + call_rcu, then waits for all callbacks via rcu_barrier().
> tlob's disable path is now simply:
>=20
> =C2=A0=C2=A0 static void __tlob_destroy_monitor(void)
> =C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_destroy();
> =C2=A0=C2=A0 }

Looks good, let's see the full picture.

> --- EVENT_NONE_LBL ---
>=20
> =C2=A0> Why don't you just override EVENT_NONE_LBL (and if you prefer cal=
l it
> =C2=A0> MONITOR_TIMER_EVENT_NAME) without the need for another function?
>=20
> Done.=C2=A0 model_get_timer_event_name() has been removed from automata.h=
.
> In ha_monitor.h, EVENT_NONE_LBL is now overridable:
>=20
> =C2=A0=C2=A0 #ifndef EVENT_NONE_LBL
> =C2=A0=C2=A0 #define EVENT_NONE_LBL "none"
> =C2=A0=C2=A0 #endif
>=20
> tlob.c defines it before including the model header:
>=20
> =C2=A0=C2=A0 #define EVENT_NONE_LBL "budget_exceeded"
>=20
> The two call sites in ha_monitor.h that previously called
> model_get_timer_event_name() now use EVENT_NONE_LBL directly.
>=20
> --- KUnit config / tristate ---
>=20
> =C2=A0> Do you need to add this here? Since you have a patch adding KUnit=
 tests
> =C2=A0> to tlob, cannot you put everything kunit-related there?
> =C2=A0> I couldn't build it as module.
>=20
> Agreed on moving the Kconfig entry to patch 09.
>=20
> The module build issue is fixed by exporting the symbols needed by the
> test via EXPORT_SYMBOL_IF_KUNIT (EXPORTED_FOR_KUNIT_TESTING namespace);
> tlob_kunit.c imports the namespace with MODULE_IMPORT_NS.=C2=A0 We plan t=
o
> keep tristate rather than changing to bool.=C2=A0 Does that work for you?

Yeah it's good as long as it works as module too.

I might have a look at making my patch module-ready, for now it just
can't work but I wonder if we can do something nicer to allow it
(like in your case a bunch of exports, a separate file and a standalone
testcase, perhaps all wrapped in some helper).

>=20
> --- detail_env_tlob tracepoint ---
>=20
> =C2=A0> Since you are not documenting the detail_env_tlob tracepoint, is =
it
> =C2=A0> something really required? I would at the very least document its=
 usage.
>=20
> Fair point.=C2=A0 detail_env_tlob emits (running_ns, waiting_ns, sleeping=
_ns)
> so the user can see which phase consumed the budget: high sleeping_ns
> indicates I/O latency, high waiting_ns indicates scheduler pressure, high
> running_ns indicates a compute overrun.=C2=A0 Without this breakdown the =
user
> only knows the total elapsed time exceeded the threshold, not why.
>=20

Alright, then this can go into the docs.

>=20
> --- Documentation ---
>=20
> =C2=A0> This is standard tracepoints usage, there's nothing about tlob we=
 should
> =C2=A0> document here.
> =C2=A0> Same here, standard RV [for enable/desc tracefs files].
> =C2=A0> And this is duplicating what mentioned above about uprobes, isn't=
 it?
>=20
> Agreed.=C2=A0 The following have been removed:
>=20
> =C2=A0=C2=A0 - "Violation events" section: generic trace-cmd examples and=
 cat-trace
> =C2=A0=C2=A0=C2=A0=C2=A0 instructions (standard tracepoints usage).
> =C2=A0=C2=A0 - tracefs files: "enable (rw)" and "desc (ro)" entries (stan=
dard RV).
> =C2=A0=C2=A0 - tracefs files: "monitor (rw)" description condensed to one=
 line with
> =C2=A0=C2=A0=C2=A0=C2=A0 a cross-reference to the uprobes section above.
>=20
> In their place, a new "Violation tracepoints" subsection documents both
> tlob-specific tracepoints with fields and a worked example:
>=20
> =C2=A0=C2=A0 error_env_tlob: id, state, event ("budget_exceeded"), env ("=
clk_elapsed")
>=20
> =C2=A0=C2=A0 detail_env_tlob: id, threshold_us, running_ns, waiting_ns, s=
leeping_ns
> =C2=A0=C2=A0=C2=A0=C2=A0 Use sleeping_ns to diagnose I/O latency, waiting=
_ns for scheduler
> =C2=A0=C2=A0=C2=A0=C2=A0 pressure, running_ns for compute overruns.
>=20
> =C2=A0=C2=A0 Example:
> =C2=A0=C2=A0=C2=A0=C2=A0 trace-cmd record -e error_env_tlob -e detail_env=
_tlob &
> =C2=A0=C2=A0=C2=A0=C2=A0 # ... run workload ...
> =C2=A0=C2=A0=C2=A0=C2=A0 trace-cmd report

Yeah sounds good, also pointing out to enable the monitor.
We might think of a general way to do this kind of thing in
tools/rv, although detail_env_tlob is non-standard.

> =C2=A0> Is kernel code going to use this API? RV monitors are meant to be
> =C2=A0> enabled by userspace. What's the use-case here?
>=20
> Agreed.=C2=A0 The uprobe interface is driven from userspace; tlob_start_t=
ask()
> and tlob_stop_task() are the internal implementation functions it calls,
> not a public API for external kernel modules.=C2=A0 The hypothetical
> kernel-module use case would be removed from the documentation; the
> kernel-doc block is retained for code maintainers.
>=20
> =C2=A0> That's probably a bit too detailed for this page. If you really w=
ant
> =C2=A0> this information somewhere couldn't it stay in the code?
>=20
> Agreed; moved to comments in handle_sched_switch() and
> handle_sched_wakeup().=C2=A0 The "Limitations" subsection is retained.
>=20
> -- Patch 09: KUnit tests
>=20
> =C2=A0> What caught my eyes are tests enrolling tracepoints handlers. If =
you
> =C2=A0> go there you're no longer doing unit testing, what's the advantag=
e of
> =C2=A0> testing the entire monitor here over doing that in selftests?
>=20
> Agreed.=C2=A0 The three suites that register tracepoint handlers or creat=
e
> kthreads (tlob_sched_integration, tlob_trace_output, tlob_violation_react=
)
> have been removed from KUnit and will be added to selftests in v3.
>=20
> Two pure unit test suites remain in KUnit:
>=20
> =C2=A0=C2=A0 tlob_task_api:
> =C2=A0=C2=A0=C2=A0=C2=A0 Tests tlob_start_task / tlob_stop_task return va=
lues (-ENODEV,
> =C2=A0=C2=A0=C2=A0=C2=A0 -EALREADY, -ESRCH, -EOVERFLOW, -ENOSPC, -ERANGE)=
 via direct calls
> =C2=A0=C2=A0=C2=A0=C2=A0 (these functions are the internal implementation=
 used by both the
> =C2=A0=C2=A0=C2=A0=C2=A0 uprobe and, in future, the ioctl interface).
> =C2=A0=C2=A0=C2=A0=C2=A0 No tracepoints, no scheduling.
>=20
> =C2=A0=C2=A0 tlob_uprobe_format:
> =C2=A0=C2=A0=C2=A0=C2=A0 Tests the uprobe line parser (tlob_parse_uprobe_=
line,
> =C2=A0=C2=A0=C2=A0=C2=A0 tlob_parse_remove_line) against valid and invali=
d input strings.
> =C2=A0=C2=A0=C2=A0=C2=A0 Pure string parsing; no scheduling, no tracepoin=
ts.
>=20
> This also resolves the tristate-vs-bool issue: with only pure unit tests
> there is no dependency on sched_setscheduler_nocheck, so bool is correct.
>=20

Yeah looks good.

>=20
> --=C2=A0 Patch 10: selftests
>=20
> --- PREEMPT_RT RCU stall ---
>=20
> =C2=A0> I run it on a VM and have it hanging at step 9 [...] rcu_preempt =
stall.
> =C2=A0> Did you see that? Am I doing something wrong?
>=20
> Thanks for reporting.=C2=A0 The patch changed ha_monitor.h from
> HRTIMER_MODE_REL_HARD (the existing upstream value) to REL_SOFT; the
> stall appeared on PREEMPT_RT after that change.=C2=A0 We have not fully
> confirmed whether REL_SOFT is the root cause =E2=80=94 REL_SOFT defers th=
e
> callback to the ktimers kthread, which could starve rcu_preempt under
> certain PREEMPT_RT configurations, but other factors may be involved.
>=20
> We plan to revert to HRTIMER_MODE_REL_HARD at both sites in ha_monitor.h
> as the conservative choice:
>=20
> =C2=A0=C2=A0 ha_setup_timer():=C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL_S=
OFT -> HRTIMER_MODE_REL_HARD
> =C2=A0=C2=A0 ha_start_timer_ns():=C2=A0 HRTIMER_MODE_REL_SOFT -> HRTIMER_=
MODE_REL_HARD
>=20
> Do you have more insight into the stall, or does REL_HARD resolve it on
> your setup?

Right, good point, any specific reason why you wanted REL_SOFT?

I indeed always test under PREEMPT_RT but I still see the same splat
also after reverting REL_HARD..
Could you reproduce it on your setup?

My config is nothing special: what vng gives you adding
PREEMPT_RT/RCU_PREEMPT and lockdep (PROVE_LOCKING/PROVE_RCU).

>=20
> --- Selftest structure ---
>=20
> =C2=A0> This should be tested together with the other monitors (enable/di=
sable),
> =C2=A0> we could at most expand those with the check_requires.
> =C2=A0> Let's focus on tlob-only features in this patch.
>=20
> Agreed.=C2=A0 In v3 we plan to drop tracefs.tc (covered by the generic
> rv_monitor_enable_disable.tc) and keep only the six uprobe-specific
> test cases under test.d/tlob/
>=20
> ioctl.tc is deferred with the ioctl interface to the follow-up series.
> The KUnit integration tests (sched_switch accounting, budget-expiry
> tracepoint) would be moved to selftests as additional test cases.
>=20

Thanks,
Gabriele

