Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554094;
	b=DFTrcHAcNJP31y+k9A01oasod7BghOeWM4f64i8Cc8DIATFhizjNHp2emQcFYIIPCyX+
	 NIgHZTOJQvTGEBa4l+e6Zhgr+KVmEy2mohDfSf/rSYkiKMtB0a3jQ+8r/0hYfM78hV4KF
	 bMavyLWPO1j6AK+rkaM5fGZGrfbkBt8ZjMpPhsDcXogfUNjfa/33TrC+GDPl+608Pjso1
	 vEXVb8F5oRfYMtDG1XpZjwRcR7P+Yhsj6wfYyKO6ABxl8DQPpWvgHCCZc5o3872XCWLjZ
	 rt3nhdE5weJOsix79oIJAlDrub/ppbIgopmULz0wjvEteuTdmQCilI0YeWflZaodjJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554094;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1XzOzpinKAvWK/3tEYAMx8JxARuETBPVq5jOzUIWRWA=;
	b=B9UawoiiI6rDsj059pO/DOH4+xW0VPZqn++9jN17A4AsQ/f8UFu+pv2zP0Z/n79LOgnc
	 78+PkdkOir6nk7OWDGy6QjqicjRqcd3RMSV3JCb/UqyJqhYyv5C8Fr/cmgPQUWqg+41Yi
	 JCcE8pqNymKwByyuc9ZURrAj60VzLv2ZWAUzUyVL+Nd5uMDdSeMTin0vA3TMQvC5sUCxH
	 jp31l2n125Z0Mt2I4wCX3F52mCn5ShE4Xy/R+gPJ592ZddO3uZt6pIvtApsn2YRrRl2dh
	 BuNiW/jRIDqjOZlTZg/nUjTcKRXqtezoJotnl4auFN1f72CB/X9JxthjaWukNePqZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKr98lqJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F96606A334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKr98lqJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A685A1F000C4;
	Fri, 13 Nov 2026 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794554093;
	bh=1XzOzpinKAvWK/3tEYAMx8JxARuETBPVq5jOzUIWRWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKr98lqJJ+F3+NlzEOmQ35CWBZCaO+wP+FiGLF63hUic8E4cly3mmAIcR7tXb8nhB
	 8mL4pVg1N36O/Hm1BbqywZ3b2teXXS2zJ8wxXcrq+WPbA0n7GpFFUEOJjB7xoW5qO1
	 MfXb49quk90vFiIQ+2Px3sK2dYEatbUwryFX9VuNoq2Eay3uqSBm7JMwkYdaQ9e8aI
	 YjE3DX2JG9Zs3kNsfOJypy1FgsZ5rN8QZmj3c1YRIybsOWoYR+4Wmp9cTg2RrwLw5x
	 qIIIuzhyeBKDVQw87KBF8VbFcrgfgZ49aqK1p6xkOaNDH9FGJkRCGwXeJrJBVA3ckL
	 UC63ZqGBwL88A==
Message-ID: <sashiko-outbox-212329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113064103.3041704-6-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
 <20261113064103.3041704-6-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:14:53 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tracing/osnoise: missing migration detection in
  timerlat_fd_read()
--

commit d34bc9208d90b4be9c903307f53e72248c2ac3b7
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Per-cpu mutexes and fd detachment

This commit introduces per-cpu mutexes to protect kthread and timerlat file
descriptor state, replacing the SIGKILL mechanism for user-space timerlat
threads with a mutex-protected detachment mechanism.

[Severity: Medium]
In kernel/trace/trace_osnoise.c, timerlat_fd_read() removes the
cpu !=3D smp_processor_id() migration handling (which set
cpu_tmr_var(cpu)->uthread_migrate =3D 1, tainted osnoise, and stopped
tracing) and instead locks this_cpu_tmr_var()->detach_lock before checking
fdd !=3D osn_var->fdd or tlat->uthread_migrate.

Can this miss user-space thread migrations when NO_OSNOISE_WORKLOAD is
enabled after the timerlat tracer has already been started?

By default, OSN_WORKLOAD is set in osnoise_options. If the user enables
timerlat first and then writes NO_OSNOISE_WORKLOAD to osnoise/options (as
shown in Documentation/trace/timerlat-tracer.rst), osnoise_options_write()
does not call register_migration_monitor(), which only runs during initial
tracer startup in osnoise_workload_start() -> osnoise_hook_events() ->
hook_thread_events() -> register_migration_monitor() and skips registering
trace_sched_migrate_callback() when OSN_WORKLOAD is set.

Without trace_sched_migrate_callback() registered and with the migration
handling removed from timerlat_fd_read(), a thread that migrates to
another CPU and calls timerlat_fd_read() acquires the destination CPU's
tlat->detach_lock rather than fdd->cpu's lock, never sets
cpu_tmr_var(fdd->cpu)->uthread_migrate, and does not taint or stop
tracing; if the thread later migrates back to fdd->cpu, subsequent reads
continue succeeding instead of failing with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113064103.3041=
704-1-crwood@redhat.com?part=3D5
