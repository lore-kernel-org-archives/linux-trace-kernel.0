Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7444AB7E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807623; cv=none; b=VZFms0nTKnCkzE1SQW6gb43+pxOikDeVH0+LlaAUOKizjqPNHNKNgChSW3MUoA8fRdxKm5x3E+JMJeh4De0ZFburau+XIE8TfDHDcSQLE1DXqkYud/LzYVj6ohmxo7lDFx3WT7C1ZRssLlErciVoHo7GD7hmHZyBFvqN7kKJD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807623; c=relaxed/simple;
	bh=I9ElJyHTHgL0dhheWoEQ5QzwpnrG3WhTR6AJoM79zFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hty4ZVweQaHLF6kZ0J7dZCmfheyN2hThdMBYvw9UNB4e5D526wCistJakAMEzri8DVl33MZ2gsMr+vfaX4xQBfUrmrETSI2FdX2OeA8YMs/+5Rft8ZryXicSxe5nLLYurxj23HMar9jE1UalW834ogUGi1D0E5XdJZY+FkbRxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGEIJtpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGEIJtpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784807608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mETr9rWNO4Nf1EnysGVYWbx+xIYbg6c1FLaeDSNewCM=;
	b=HGEIJtpW2pkkFp/4ngsaveA07rL47tLV7s/WlSrhPB7SLZyjuQPo4fzTx6K7Bkt8v3Te81
	scec3koxTt07yDAPOSpsQyskktJlERG6ie1XEbJC0D0XMagPxVLnfz8eY/jjbVNPvpFoCA
	d8UAEHXEvyrwXtN/n1zNtv+3BZPkOR0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VPgyVqAYOMy7a2OlhPKYNQ-1; Thu, 23 Jul 2026 07:53:26 -0400
X-MC-Unique: VPgyVqAYOMy7a2OlhPKYNQ-1
X-Mimecast-MFC-AGG-ID: VPgyVqAYOMy7a2OlhPKYNQ_1784807605
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15deb3377eso50111566b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 04:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807605; x=1785412405;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mETr9rWNO4Nf1EnysGVYWbx+xIYbg6c1FLaeDSNewCM=;
        b=pU5Xf7JnTJxZnciBPiS25XJOWX1ml0yL2glGUX3iafKJwABcIBhwhrEmEleDABw4IS
         QxMjjOpBNnGsJaHwTtRqoVkG7dgkelqlzHe28huYKy1ZAuMS2b6FFxvrziIah3Ofa6w/
         noJOLtpo/a68HvPbfj4uFODDGXzq374mDTeNNhIE5A6XfSGPUbW7FKzM9njRGR0Bn/Sw
         VOftKhDlAON/c+6rnIb/50vsLTDXSOqF/51Wpi1TkOEePqoFjdsi31beLhpMwFAN+g8q
         fyevzNaWVn9zNWVvF7Z1bdc5vJn+h+kUhsUCwDqa367AioR8tFBWhzunwFjRR3VxkBbb
         rDQw==
X-Gm-Message-State: AOJu0Ywv4MKXjyMSn/RcN29YhGbgoKakLSkkcQkSD1BBShbc7wijKIia
	HHZHT/ffuxMEG1HVshW1QKBuSprObc54Lzs7sZ4juBNa0AkMH3pW9RiL2+Qs1mbE7WQhUsgUa6o
	zM0dlhdKu7HJridKE8LAcvtPpjtIZXIBBXw9+ZjoCblVYIeglCtzlQfZHw/Ksdmc4PJjAjBlyHw
	==
X-Gm-Gg: AR+sD131vc/EUmehXdD9nVqCGvmYAIx8gd6XWl0S9SlugGjPehAIBWSlhxoqV+oT2sd
	TXLdBmLiVdTn+i1/O1TCj02bvPLNqk3w8kcu2cWrPqVzvIN6gc6tBPS6AZ6Ta+JqdKNefCTVijh
	gWRlTekDUgROmBHsCzbR0seQuMO5SaYQYSuk+1FbgMahAJlwnT1TWU84BIac1MHwrFqlSJpj5Hq
	P6RD1HmwAo+UFNmlcX2ijqDjy6RzJuPOB+LJlW7lda4A116GuhuN4njory6LiEHWgxp1aS5JMi8
	oPNsT1Kwr52mV1nnFr1+hdA9w1q8gJxh+TAr22VkZW60luZARrfzG+FSx07QArw4xc76EwdhnXM
	UPNR6ngJHKe3bz4iylveG+4cg+7i8kJhvBZ5+CMNfK45OGPD0zGl+8V4wZKSmDtFUchKpNw==
X-Received: by 2002:a17:907:b049:20b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c1c50b443dfmr84233166b.12.1784807605373;
        Thu, 23 Jul 2026 04:53:25 -0700 (PDT)
X-Received: by 2002:a17:907:b049:20b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c1c50b443dfmr84231766b.12.1784807604795;
        Thu, 23 Jul 2026 04:53:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f13c96sm221010566b.62.2026.07.23.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:53:24 -0700 (PDT)
Message-ID: <cddd920af5b50dcf4b831ca32f224e4329d9dd2b.camel@redhat.com>
Subject: Re: [PATCH v4 0/8] rv/tlob: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 13:53:23 +0200
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: R-inNT3zz1x1fm_ExXIMdVSGSOWpU8vJ9hk-CkyEG28_1784807605
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>

Usually, within tracing, we try to make the commit titles consistent by
capitalising them after the tag (as you did only for the cover letter).

Also try not to introduce new tags, we have poor consistency, but I prefer =
only
to keep rv: when you modify kernel-side code (all your patches besides the
selftests one, which is correct).
Try to follow what you see with git log --oneline <modified files>

Overall:

  rv/da: introduce DA_MON_ALLOCATION_STRATEGY
  rv: add generic uprobe infrastructure for RV monitors
  rv/tlob: add tlob model DOT file
  ...

becomes

  rv: Introduce DA_MON_ALLOCATION_STRATEGY
  rv: Add generic uprobe infrastructure for RV monitors
  rv: Add tlob model DOT file
  ...

(note the uppercase A and I and the use of rv: , please apply these to othe=
r
commits too).

Thanks,
Gabriele

> This series introduces tlob (task latency over budget), a per-task
> hybrid automaton RV monitor that measures elapsed wall-clock time across
> a user-delimited code section and emits an error when the elapsed time
> exceeds a configurable budget.
>=20
> The monitor tracks three states (running, waiting, sleeping) driven by
> sched_switch and sched_wakeup tracepoints.=C2=A0 A single clock invariant=
,
> clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
> (HRTIMER_MODE_REL_HARD).=C2=A0 On expiry, error_env_tlob is emitted,
> followed by detail_env_tlob carrying a per-state time breakdown
> (running_ns, waiting_ns, sleeping_ns).
>=20
> Tasks are registered for monitoring by writing to the tracefs monitor
> file:
>=20
> =C2=A0 echo "p /path/to/binary:OFFSET_START OFFSET_STOP threshold=3DNS" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/tracing/rv/monitors/tl=
ob/monitor
>=20
> Two uprobes delimit the measured section without modifying the target
> binary.=C2=A0 Multiple uprobe pairs can be active simultaneously.
>=20
> Series structure
> ----------------
> Patch 1: rv/da: introduce DA_MON_ALLOCATION_STRATEGY
> =C2=A0 Compile-time allocation strategy selector for per-object DA storag=
e.
> =C2=A0 Three strategies: DA_ALLOC_AUTO (default kmalloc), DA_ALLOC_POOL
> =C2=A0 (pre-allocated llist pool), DA_ALLOC_MANUAL (caller-managed).
>=20
> Patch 2: rv: add generic uprobe infrastructure for RV monitors
> =C2=A0 Thin wrapper over uprobe_consumer for path resolution, registratio=
n,
> =C2=A0 and safe synchronous teardown.
>=20
> Patch 3: rv/tlob: add tlob model DOT file
> =C2=A0 Graphviz DOT specification of the tlob hybrid automaton.
>=20
> Patch 4: rv/ha: fix ha_invariant_passed_ns silent bypass
> =C2=A0 Without this fix, ha_invariant_passed_ns() returns 0 on first call=
 and
> =C2=A0 leaves env_store at U64_MAX.=C2=A0 Every subsequent state transiti=
on resets
> =C2=A0 the hrtimer to the full budget instead of the remaining time, so t=
he
> =C2=A0 budget never expires for tasks that transition between states.=C2=
=A0 This
> =C2=A0 causes tlob's detail_sleeping and detail_waiting selftests to hang=
.
>=20
> =C2=A0 This patch is a minimal fix in the current dual-representation fra=
mework.
> =C2=A0 Nam's series [1] refactors ha_monitor.h to a single-representation
> =C2=A0 model; once it lands, tlob will need to be updated to the new API =
and
> =C2=A0 this patch will be superseded by Gabriele's planned framework-leve=
l
> =C2=A0 initialisation improvement.=C2=A0 We carry it here to keep the ser=
ies
> =C2=A0 self-contained and testable.
>=20
> =C2=A0 [1]
> https://lore.kernel.org/lkml/08188c28f274da63a3f8549add3086a92aef45e5.178=
0908661.git.namcao@linutronix.de
>=20
> Patches 5: rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL
> =C2=A0 #ifndef guards for da_monitor_reset_hook and EVENT_NONE_LBL.
>=20
> Patch 6: rv/tlob: add tlob hybrid automaton monitor
> =C2=A0 Main tlob implementation.
>=20
> Patches 7-8: Tests
> =C2=A0 KUnit tests for the uprobe-line parser; seven ftrace-style selftes=
ts.
>=20
> Changes since v3
> ----------------
> Patch 1 (rv/da):
> - Pool redesigned from spinlock+pointer-stack to lock-free llist
> =C2=A0 (cmpxchg-based): pool release from RCU callback context is now saf=
e
> =C2=A0 without acquiring a lock
> - DA_MON_POOL_SIZE alone selects pool mode; no separate
> =C2=A0 DA_MON_ALLOCATION_STRATEGY define required for monitors
> - All strategy dispatch uses plain C if() (no ifdeffery in functions)
> - da_monitor_destroy_pool() calls da_monitor_reset_all() and
> =C2=A0 da_monitor_sync_hook() before the hash iteration, preventing hrtim=
er
> =C2=A0 UAF when timer callbacks are still in flight
>=20
> Patch 2 (rv_uprobe):
> - struct rv_uprobe now embeds struct uprobe_consumer directly; no
> =C2=A0 separate heap allocation per probe, no rv_uprobe_free()
> - path_put() moved after uprobe_register() to keep the inode
> =C2=A0 referenced across the call as required by the uprobe API
>=20
> Patch 6 (tlob monitor):
> - da_get_target_by_id() wrapped in scoped_guard(rcu) in
> =C2=A0 tlob_start_task(): hash_for_each_possible_rcu() requires an explic=
it
> =C2=A0 RCU read-side CS on PREEMPT_RT where spinlock_t does not provide o=
ne
> - tlob_monitor_read() releases mutex before simple_read_from_buffer()
> =C2=A0 to avoid holding the mutex across copy_to_user()
> - kmem_cache replaced with a pre-allocated llist pool for
> =C2=A0 tlob_task_state, eliminating GFP_ATOMIC in the measurement window
> - EXPORT_SYMBOL_IF_KUNIT added for tlob_parse_uprobe_line() and
> =C2=A0 tlob_parse_remove_line() (required when CONFIG_TLOB_KUNIT_TEST=3Dm=
)
> - tlob_parse_remove_line() rejects negative offsets
> - Unnecessary includes removed; Kconfig entry placed after the
> =C2=A0 deadline monitors marker
>=20
> Patch 7 (KUnit):
> - Tests now call tlob_parse_uprobe_line() and tlob_parse_remove_line()
> =C2=A0 directly; no tracepoint enrollment, no uprobe or filesystem state
>=20
> Patch 8 (selftests):
> - ftracetest walk-up algorithm (Gabriele's suggestion) incorporated;
> =C2=A0 the separate verificationtest-ktap fix patch is dropped and the
> =C2=A0 series shrinks from 9 to 8 patches
> - All test scripts use "! cmd || false" throughout
>=20
> Testing
> -------
> Tested on x86_64 with CONFIG_PREEMPT_RT=3Dy (kernel 7.1 + virtme-ng):
> - All KUnit tests pass
> - All 7 selftests pass (uprobe_bind, uprobe_violation, uprobe_no_event,
> =C2=A0 uprobe_multi, uprobe_detail_{running,sleeping,waiting})
>=20
>=20
> Wen Yang (8):
> =C2=A0 rv/da: introduce DA_MON_ALLOCATION_STRATEGY
> =C2=A0 rv: add generic uprobe infrastructure for RV monitors
> =C2=A0 rv/tlob: add tlob model DOT file
> =C2=A0 rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
> =C2=A0 rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
> =C2=A0 rv/tlob: add tlob hybrid automaton monitor
> =C2=A0 rv/tlob: add KUnit tests for the tlob monitor
> =C2=A0 selftests/verification: add tlob selftests
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_tlob.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 177 ++++
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 247 ++++-
> =C2=A0include/rv/ha_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 24 +-
> =C2=A0include/rv/rv_uprobe.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 93 ++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/nomiss/nomiss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0kernel/trace/rv/monitors/tlob/.kunitconfig=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 8 +
> =C2=A0kernel/trace/rv/monitors/tlob/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 970 ++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 153 +++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.c=C2=A0=C2=A0=C2=A0 | 139 =
+++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_trace.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 52 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/rv_uprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 104=
 ++
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 18 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 19 +-
> =C2=A0.../verification/test.d/tlob/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 28 +
> =C2=A0.../test.d/tlob/run_tlob_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 90 ++
> =C2=A0.../verification/test.d/tlob/tlob_sym.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 209 ++++
> =C2=A0.../verification/test.d/tlob/tlob_target.c=C2=A0=C2=A0=C2=A0 | 138 =
+++
> =C2=A0.../verification/test.d/tlob/uprobe_bind.tc=C2=A0=C2=A0 |=C2=A0 37 =
+
> =C2=A0.../test.d/tlob/uprobe_detail_running.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 51 +
> =C2=A0.../test.d/tlob/uprobe_detail_sleeping.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 50 +
> =C2=A0.../test.d/tlob/uprobe_detail_waiting.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ++
> =C2=A0.../verification/test.d/tlob/uprobe_multi.tc=C2=A0 |=C2=A0 64 ++
> =C2=A0.../test.d/tlob/uprobe_no_event.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> =C2=A0.../test.d/tlob/uprobe_violation.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 67 ++
> =C2=A0tools/verification/models/tlob.dot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +
> =C2=A031 files changed, 2839 insertions(+), 46 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_tlob.rst
> =C2=A0create mode 100644 include/rv/rv_uprobe.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/.kunitconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
> =C2=A0create mode 100644 kernel/trace/rv/rv_uprobe.c
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/tlob=
/Makefile
> =C2=A0create mode 100755
> tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/tlob_target.c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.t=
c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
> =C2=A0create mode 100644 tools/verification/models/tlob.dot

