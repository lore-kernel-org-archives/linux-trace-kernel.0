Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012734;
	b=waUgVbBp48L09ysvclzhARqmqGXlx7ylbonbEjDCwKm4wvAccajRJbM52QARJMfqDoKC
	 La2x5ly/7xVZDew5z2s/d8arRHmrKv1nE2aLaODmTYKYEwF57AwtZ3mIWkSWgyWOxrYX2
	 QXVnoYrx5cbQ2MeDvQ63FNH3zZ2J+B23bHTjJfMHcHBjbzIEMS2M14A8bN9cviyk5LKGu
	 mVaC65AfQpJMztjxqeLpp0pOBuWa0Mge9VYoK7uYoV63StKzMhmLcx9uB6OpSCXqVGczy
	 yBbDNHUw+JbP/zFndsWbSoAwHDFEZHJnO5lRw+QqfVp40UNTgo7+vOGnopnqb2tuyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012734;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=HsbaEe/nvTP0iwLeS1x890pi6M+BY0AFsfXGST+SUjA=;
	b=iJ8tuGp2DkUYbZtXaZKfD81uVSi2jfIeqt9bP+mFLpM8wj9+vyYM9lKzAC40ADb0McHB
	 A5wTKO9kPznEmFKBD5acxrU64A7XERiCibpZEIEvbzXSTWZgCjLNBeSBiizjGhXQbVBRl
	 2ZaWRq4UWpVmG7zqNi3hie0zUKnHkWbahm08esMla1J25gBa8kP4pQoLWf3NBWaOJH0Xi
	 sCY9ZD8HxGfHnRgUMuQC+5he26/D2AENJy2x4nXzMtGalq2Voh0xfunNpdGKSdZzyMY7A
	 q4J5t8utHctzjFHA6WiiYRRXsXthFpcOzJncJIXZ2linOtifU4ZyFNH01ERCRSIFb2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HuhG57QY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23C606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 11:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A23C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HuhG57QY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793012733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HsbaEe/nvTP0iwLeS1x890pi6M+BY0AFsfXGST+SUjA=;
	b=HuhG57QYvZxe8iL8J1QGM30nLobljBSrVNGx5i6AtwItjz/6pp6TwxXJ1HKQsE/MOAad91
	PnkH36U5nrvFdblVb89VlzcZCCBXo0CViwZU+dJ8oxEmJxPqamyr0ykKDuUu26dppcYAa+
	g1mJSeaLPD3T7jtmCqxWd1i0OIPHFHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-G9-SkGQLO8qx-gP8YQK-sA-1; Mon, 26 Oct 2026 07:05:31 -0400
X-MC-Unique: G9-SkGQLO8qx-gP8YQK-sA-1
X-Mimecast-MFC-AGG-ID: G9-SkGQLO8qx-gP8YQK-sA_1793012730
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so19243315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 04:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012730; x=1793617530;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HsbaEe/nvTP0iwLeS1x890pi6M+BY0AFsfXGST+SUjA=;
        b=qdoDEmGI7fonF7UnS9YENPUYUzi0dty66NAYrzr9IdVpMG0MoiWny8UvdiZExNJsbf
         GJWrAaLjoYj9iu/3gt9nOOJmnJbenEnkvLEyPXIs9hJzlzB8+kd22WCn2+Nc/11ieWUu
         XqUlVmXO+z4vSMXYi0R5H9azUHSQS42ta703QZavBxfZO7phXTAnPZjmoYo4wdfnXQEU
         V13igyU9OM1mTWZSP+YGTJf8DBGYZLcqJLRVm3mLDYXh2NFHqze5LklBYaQz8yKxZHNl
         27gvNyeNPTpHb/5eAPD8i2768Lv8yK3myhAe6kKeQ+EVeRs0s6azFMXqMYeWuq4Ti8D3
         pQVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLKZNMlFvoNgYPAxKn3H/wMMzPGj60oODkxIKHGJlUQ/Fy8fmVyjqAAsMAbl/q/yElzrQr70kln+bvLsR4WAI4rtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNrZcZ4f2v2xFZ+WeBFD9dOvdbH3StePaBRJ6a5KEeuiT3tub/
	9JlbPra5wujRW/wa70eBT6ie95lN4DbEBuWtu56CIydsu5QavIUCjHFYK5qyn5vkQkMw7U6iD3I
	V469apCXCojhEbAA9YySoMgs0DaR5t9bJnls9cIMbsdhSYjhJf5AkfcBcC7pa1c+Y3VXx6Z5Ucg
	==
X-Gm-Gg: AYBFou1wZ/kz3BvAdvD0LQXfkOYyT/uzo7B7z7QLywaFaUXBtS4irT7JXCDaBlACS2F
	+PdRljvEKRf5lzg1+H6rObb1TX/qMP9BNIrhErRIVqSrcLllhdtoHVGv0e0v7x9sR1VYcDp4SVc
	n5i8tEbryWvKzue52K8XurPt8dFjALLEcNqW6z2Ibph+eBVjKcqhHre74THguXvG3+0GMhn4juS
	FkiJ6Vxekbc15Gbt69+GulDPIHVC/Hb6Hl5wd72W9UNfACS7NcRH3ONzZl9vv5G48WPRmtXxjFd
	FcN6TZI7Kq3IJ8mzk9IDuLVW3oz0atBLCqJVliQhamoWxjhGnnl7ZhPw9mULFN/ac81pf4D33b+
	7SJxl+BeFWwrOnh2fpv8AJXldOVcJ
X-Received: by 2002:a05:600c:c091:b0:4a2:150f:1605 with SMTP id 5b1f17b1804b1-4a5015ef800mr66474485e9.24.1793012729985;
        Mon, 26 Oct 2026 04:05:29 -0700 (PDT)
X-Received: by 2002:a05:600c:c091:b0:4a2:150f:1605 with SMTP id 5b1f17b1804b1-4a5015ef800mr66473955e9.24.1793012729366;
        Mon, 26 Oct 2026 04:05:29 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2e8f25sm188625925e9.14.2026.10.26.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:05:28 -0700 (PDT)
Message-ID: <462351c6a891d1a2d57d2589124caf939225f9b2.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:05:27 +0100
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: V9sNxwsSMxeUpTAhsc0IokOSu2Iv_yACq_bwbcWOqYg_1793012730
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> New in this revision:
> =C2=A0 - Patches 1 and 2: the HA environment lifecycle and timer fixes, i=
n
> =C2=A0=C2=A0=C2=A0 that order (see above).=C2=A0 Patch 3 adds KUnit cover=
age for both.
>=20
> =C2=A0 - Patch 4 (was 1): the HA timer teardown fix, found while auditing
> =C2=A0=C2=A0=C2=A0 tlob's own teardown.=C2=A0 The gap is in the framework=
; a monitor cannot
> =C2=A0=C2=A0=C2=A0 close it.=C2=A0 Patch 5 adds KUnit coverage, and Patch=
 8 splits the
> =C2=A0=C2=A0=C2=A0 per-object teardown hook out of the tlob patch.
>=20
> =C2=A0 - Dropped detail_env_tlob and the per-state accounting.=C2=A0 Whic=
h phase
> =C2=A0=C2=A0=C2=A0 consumed the budget is now derived from event_tlob in =
user space;
> =C2=A0=C2=A0=C2=A0 monitor_tlob.rst documents the recipe.=C2=A0 This remo=
ves the per-record
> =C2=A0=C2=A0=C2=A0 lock and the accumulator from the hot path, and tlob n=
o longer
> =C2=A0=C2=A0=C2=A0 deviates from "run a model and spot violations" (Gabri=
ele, v2).

Very well.
You may find [1] of interest as it has some overlap with that accounting, a=
iming
to introduce stats into the DA infrastructure. It probably isn't a direct m=
atch
and only targets per-cpu for now.

By the way there has been a running discussion about keeping the C files fo=
r the
monitors as close as possible to the DOT representation, with a long-term g=
oal
to extend the DOT to represent everything and have logic represented there =
too
(at least simple trace filters).

Now I haven't been following this religiously either and some things are si=
mply
too hard to be represented there. But I'd like you to keep it in mind when
writing your model, since yours deviates considerably.

For example I'm still not convinced by the fact that you maintain a paralle=
l
state (OPEN/CLOSE/RETIRED). You do a lot of error reporting in tlob_start_t=
ask()
that is mainly discarded (return value ignored). What prevents you from all=
owing
the start event in running and just not allocate if you have already a targ=
et?

I'd really prefer to have the complexity moved to the model. I'm probably
missing some background here, but I see an open/closed window as something
mostly matching the monitor's state, while the retired state as the result =
of a
race with cleanup.
Where are you seeing such races? When the monitor is stopped while a window=
 is
still open? da_extra_cleanup() is supposed to run after everything else set=
tled
down, if you have evidence this isn't the case, let's discuss about that fi=
rst.

If you could drop these states, you'd also no longer need tlob_reset_notify=
()
and many other things will get simplified and closer to what rgven gives yo=
u.

And it's also good to keep everything rvgen gives you as is
(ha_verify_invariants() and friends). Otherwise you'd never tell your model
deviated from the code.

These are general guidelines, the C files cannot yet be a 1-to-1 product of=
 the
model, but shouldn't be a completely different story either.

>=20
> =C2=A0 - The model gives stopped a self-loop for every scheduler event, a=
nd the
> =C2=A0=C2=A0=C2=A0 sched handlers call da_handle_event() unconditionally.=
=C2=A0 The
> =C2=A0=C2=A0=C2=A0 source-side gate that skipped events while stopped is =
gone; the logic
> =C2=A0=C2=A0=C2=A0 lives in the model (Gabriele, v6).
>=20
> =C2=A0 - tlob_sym.c (a 235-line ELF parser) is replaced by a sym_offset()
> =C2=A0=C2=A0=C2=A0 shell helper built on readelf (Gabriele, v3).

Great! Let's keep the code to maintain to a minimum.

>=20
> =C2=A0 - tlob_preempt_work, identical to tlob_busy_work, is dropped and t=
he
> =C2=A0=C2=A0=C2=A0 busy-wait body is shared (Gabriele, v3).
>=20
> =C2=A0 - The KUnit and DOT commit messages were rewritten as requested
> =C2=A0=C2=A0=C2=A0 (Gabriele, v6).
>=20
> =C2=A0 - Dropped three patches that no longer stand on their own: "rv: Fi=
x
> =C2=A0=C2=A0=C2=A0 ha_invariant_passed_ns silent bypass of invariant chec=
k" (Patch 1
> =C2=A0=C2=A0=C2=A0 makes it unnecessary), "rv: Check the decoded fields i=
n the tlob
> =C2=A0=C2=A0=C2=A0 parser tests" and "selftests/verification: Fix up the =
tlob selftests"
> =C2=A0=C2=A0=C2=A0 (folded into the patches they fix, so each patch is co=
mplete on its
> =C2=A0=C2=A0=C2=A0 own).
>=20

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20261020095512.863754-1-tobias.schaffner@sieme=
ns.com

> Also folded into the patches they belong to, from earlier review rounds:
> the DA_MON_POOL_SIZE dual-macro simplification and DA_ALLOC_MANUAL
> (Gabriele), the invariant-check rewrite (sashiko-bot), and the tlob
> teardown/error-path fixes: security_locked_down(LOCKDOWN_TRACEFS) in
> tlob_monitor_open(), the single tlob_record_state word with
> TLOB_RETIRED as the only licence to free, tlob_add_uprobe()'s rollback
> running the full nosync/quiesce/sync/reap sequence, and
> tlob_remove_all_uprobes() holding tlob_uprobe_mutex across the sync and
> the reap.
>=20
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> Environment: x86_64, CONFIG_PREEMPT_RT=3Dy, kernel built with virtme-ng
> (vng --build), selftests built on the host and run inside the VM via
> `ftracetest --rv ../verification` (the verificationtest-ktap entry
> point, with logs redirected to /tmp):
> - KUnit: rv_mon suite (CONFIG_RV_MONITORS_KUNIT_TEST), rv_test_tlob case
> =C2=A0 covering the uprobe-line parser
> - 11 ftrace-style selftests: uprobe_bind, uprobe_violation,
> =C2=A0 uprobe_no_event, uprobe_multi, uprobe_multi_instance,
> =C2=A0 uprobe_detail_{running,sleeping,waiting}, uprobe_restart,
> =C2=A0 uprobe_overlap_register, uprobe_restart_violation
> Both suites pass.=C2=A0 The pre-existing rv_* tests in the same directory
> and the rest of the rv_mon KUnit suite (nomiss, sco, sssw, sts, opid,
> pagefault, sleep) keep passing as well.
>=20
> v6: https://lore.kernel.org/all/cover.1787243842.git.wen.yang@linux.dev/
> v4: https://lore.kernel.org/all/cover.1783524627.git.wen.yang@linux.dev/
> v3: https://lore.kernel.org/all/cover.1780847473.git.wen.yang@linux.dev/
> v2: https://lore.kernel.org/all/cover.1778522945.git.wen.yang@linux.dev/
> v1: https://lore.kernel.org/all/cover.1776020428.git.wen.yang@linux.dev/
>=20
> Gabriele Monaco (1):
> =C2=A0 rv: Force environment reset action on HA monitor start
>=20
> Wen Yang (13):
> =C2=A0 rv: Fix ha_monitor timer and invariant underflow
> =C2=A0 rv: Add a KUnit test for the HA timer underflow
> =C2=A0 rv: Disarm HA timers on the storage free path
> =C2=A0 rv: Add a KUnit test for the storage free path
> =C2=A0 rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
> =C2=A0 rv: Introduce DA_MON_ALLOCATION_STRATEGY
> =C2=A0 rv: Add per-object teardown hook da_extra_cleanup
> =C2=A0 rv: Add generic uprobe infrastructure for RV monitors
> =C2=A0 rv: Add tlob model DOT file
> =C2=A0 rv: Add tlob hybrid automaton monitor
> =C2=A0 rv: Add KUnit tests for the tlob monitor
> =C2=A0 selftests/verification: Add tlob selftests
> =C2=A0 selftests/ftrace: Walk up parent dirs to find test.d/functions
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_tlob.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 154 +++
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 154 ++-
> =C2=A0include/rv/ha_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 61 +-
> =C2=A0include/rv/rv_uprobe.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 35 +
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/nomiss/nomiss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A0kernel/trace/rv/monitors/opid/opid.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/tlob/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1049 +++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 142 +++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 151 +++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 18 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_trace.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 20 +
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 162 +++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/rv_uprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 56 +
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 19 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0=C2=A0=C2=A0 1=
 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0=C2=A0=C2=A0 4=
 +
> =C2=A0tools/testing/selftests/verification/config=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 3 +
> =C2=A0.../selftests/verification/test.d/functions=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 9 +
> =C2=A0.../test.d/tlob/run_tlob_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 32 +
> =C2=A0.../verification/test.d/tlob/uprobe_bind.tc=C2=A0=C2=A0 |=C2=A0=C2=
=A0 47 +
> =C2=A0.../test.d/tlob/uprobe_breakdown.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 136 +++
> =C2=A0.../test.d/tlob/uprobe_disable_live.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 79 ++
> =C2=A0.../verification/test.d/tlob/uprobe_multi.tc=C2=A0 |=C2=A0=C2=A0 58=
 +
> =C2=A0.../test.d/tlob/uprobe_multi_instance.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 65 +
> =C2=A0.../test.d/tlob/uprobe_no_event.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 17 +
> =C2=A0.../test.d/tlob/uprobe_overlap_register.tc=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 66 ++
> =C2=A0.../test.d/tlob/uprobe_restart.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 66 ++
> =C2=A0.../test.d/tlob/uprobe_restart_violation.tc=C2=A0=C2=A0 |=C2=A0=C2=
=A0 48 +
> =C2=A0.../test.d/tlob/uprobe_unbind_live.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 65 +
> =C2=A0.../test.d/tlob/uprobe_violation.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 53 +
> =C2=A0.../selftests/verification/tlob_target.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 127 ++
> =C2=A0tools/verification/models/tlob.dot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 27 +
> =C2=A0tools/verification/rvgen/rvgen/dot2c.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A038 files changed, 2930 insertions(+), 20 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_tlob.rst
> =C2=A0create mode 100644 include/rv/rv_uprobe.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
> =C2=A0create mode 100644 kernel/trace/rv/rv_uprobe.c
> =C2=A0create mode 100755
> tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_breakdown.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_disable_live.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_multi_instance.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_overlap_register.=
tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_restart.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_restart_violation=
.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_unbind_live.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
> =C2=A0create mode 100644 tools/testing/selftests/verification/tlob_target=
.c
> =C2=A0create mode 100644 tools/verification/models/tlob.dot

