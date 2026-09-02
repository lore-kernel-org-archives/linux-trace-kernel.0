Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897C3AD512
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332271; cv=none; b=KiyeLpnNLXszKa/s+EmM4wtkwfKXiWApZUxrkUPtDCf8mRfn9mR456V3/62fPBYBKSA05CbFpggQ1gkkq37wXLQfhY2FOyZdD2emdfFAaAm6e4JTmKWv9szjYUfpL2XcxeODTM94zoSojuZnRrostPP29YL5LYiGt+j88jVXlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332271; c=relaxed/simple;
	bh=sWZEH6v3orLVDC4hq0BbMz9yPIQ1VdwJtt/VQko/DHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSzFIZ+uWjFzO6j324UvgKPrxZD6NnIYhNx+Dq6BbZiivHxix6qEl+8xeTQVSbVRcSFdGkCVM3+wd70quPKqBayv6XPGUV2FveIdHC+e42VV8VnKC+B4dD/1KMWVTnEEJ+15zVeqX76y4babPgoo7HPPDckgQHT44bIR8ilDtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmKkT9wl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmKkT9wl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA1E1F000E9;
	Wed,  2 Sep 2026 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332265;
	bh=qlN1Ni6EOQ0t1O9os7L+gh+wSTEJ8OXLJXGXmF/2GCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XmKkT9wl1zwK+poKP0oic/7t+VrVk0i3fqWUKN3IjMCUUQ/YtZAzNESPrhsQG6dQd
	 8NNBk+Qar8dlhVuGd39GV3dpyDV+rJjJcKBO08e0IIqPHyqOdREcKs2ug2eqDMNIUz
	 vilL+MdSmhWHHv2btzzUSy/v2EM5FJf+yHIh/PzSA6+MwGyfrK6VJH/spc6LDiOXJ1
	 cuWrJ2SGQXlgA7GDKI3XjDgWK5QvvRUYJn6raNiQBedGu9fwK4cFkFXkemkvHJls/M
	 pB7gbVZPKD+PBJp+kJgjfD/RBAy6d8IYM9t2Z6xk94iDb+eQdoqFlKYRwE44aKRn75
	 djngfXizC1jWg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 1/3] trace: add lock-free stackmap for stack
 trace deduplication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902064242.28606-2-lipengfei28@xiaomi.com>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com>
 <20260902064242.28606-2-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:57:44 +0000
Message-Id: <20260902065744.DFA1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ftrace_stackmap_reset() omits ring buffer clearing and tracing s=
tate verification, violating the design claimed in the commit message.
--

commit 5edd2c96008787e0c0b7c542cb960e049ed8c84f
Author: Pengfei Li <lipengfei28@xiaomi.com>

trace: add lock-free stackmap for stack trace deduplication

This commit adds a lock-free hash map (ftrace_stackmap) to deduplicate kern=
el
stack traces for the ftrace ring buffer. By storing a 4-byte stack_id inste=
ad
of full traces, it reduces buffer usage while providing NMI-safe, lock-free
inserts and lookups.

> diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
> new file mode 100644
> index 0000000000000..6d938aa414dca
> --- /dev/null
> +++ b/kernel/trace/trace_stackmap.c
[ ... ]
> +int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
> +{
> +	int cpu;
> +
> +	if (!smap)
> +		return 0;
> +
> +	if (atomic_cmpxchg(&smap->resetting, 0, 1) !=3D 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * synchronize_rcu() itself is a full barrier; no extra smp_mb()
> +	 * is needed before it. It drains in-flight ftrace callbacks that
> +	 * may have already passed the resetting check with the old value.
> +	 */
> +	synchronize_rcu();

[Severity: Medium]
The commit message states: "Reset uses atomic_cmpxchg() to claim the resett=
ing
flag, then verifies tracer_tracing_is_on() returns false."=20

Is there a missing check here? It looks like ftrace_stackmap_reset() omits
the tracing state verification entirely, meaning a reset could proceed while
tracing is active despite the design claims.

[ ... ]
> +	/*
> +	 * Take the reader_sem in exclusive mode. This serializes the
> +	 * memset against any tracefs reader (seq_file iteration or
> +	 * stack_map_bin snapshot) that may currently hold the rwsem
> +	 * for read. synchronize_rcu() already drained the hot path;
> +	 * this rwsem covers process-context readers that aren't
> +	 * preempt-disabled.
> +	 */
> +	down_write(&smap->reader_sem);
> +
> +	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);

[Severity: Medium]
The commit message explicitly states: "Reset is destructive: under the
reader_sem write lock it clears the owning trace_array's ring buffer (and
snapshot buffer) BEFORE the map, so an external observer never sees 'trace
still has <stack_id N> but the map is already empty'. The buffers are clear=
ed
with tracing_reset_all_cpus()".

Should tracing_reset_all_cpus() be called before this memset? As it is
implemented, the map is cleared without the ring buffer being cleared first.

Could this lead to misleading or corrupted trace data resolution from the
user's perspective, violating the design outlined in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902064242.2860=
6-1-lipengfei28@xiaomi.com?part=3D1
