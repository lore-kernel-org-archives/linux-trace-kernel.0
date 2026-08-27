Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2A30BB8A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816261; cv=none; b=FFlx4zChyoo5IxtI1iZc8Wbyn6ws40va7A6fHRcNWQ5TYRX5tY4yG8eGmehlZHT4JHzAadp+Re136L1KU+efDXBnTtDDHodKgtMOxc3EXQpCg53ctx2erb3Do4R7VIVX1hpcT4xmt0nfzEcUymMqgnBB5iRMonI3jmChqKFvk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816261; c=relaxed/simple;
	bh=QWDZBBrk6/C0O9MDyHYFpAxdgutUZXtapino8VL2nTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rW7VZMmXEv+vZ2lKNhRBa8sJE5oazligWxhwpv8z2yT/ICa1Qy9B9gSKAVm8aZueuIxQiWzjvD9Ta4b02vIbfGIiNhhUnff1LmgdE3xzfcfi26QdJfm17dSNC75Vbt6nP/WW+QwLAKSB4KHC0Ya55Euk4TcFvkUIwalGIkc8G3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdUZTYoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdUZTYoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C86F1F000E9;
	Thu, 27 Aug 2026 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816260;
	bh=fz7UffYFCSh3AGe9HiQ6UIp7hCvqMi/m0ypnrokznGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdUZTYoXCrvxV03KY0Y0NpUh6CSnslgA7Cjrnchs3TbDkOupV0uSyH41k5VZkMvg3
	 g9xCQkpTJznWWdqlZoMDLliGypWYF+t1ixcQYsa/2EBzaQMQ/+3pIhimwZdVcThYua
	 OvNZFG1F3qeATT8Dkr6qcCI8FWrGClYG07kgWEdyWn+fwrpy8/6WQ9fKzwxl6IjGsP
	 hchT1kGUvnH7zXadzdw5/L1WsDZs+UHERu5yqlDvoZEZFOUdk4VirJ9Qg837siId5e
	 wms5nNruEPHimsKNyhezcypFY8nwO4tMzzsGbyGTNIvcIApcZ7CTKxoHM9YgXXTw4P
	 sqE3K/hQYHR8Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 3/3] rv: collect per-edge dwell time for per-cpu DA/HA
 monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827072400.45734-4-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
 <20260827072400.45734-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:37:39 +0000
Message-Id: <20260827073740.2C86F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Race condition in rv_edge_setup error path causes Use-After-Fr=
ee and NULL pointer dereference by concurrent trace events.
- [High] Race condition and non-atomic update of state_ns leads to corrupte=
d per-edge dwell time statistics.

Pre-existing issues:
- [Critical] Use-After-Free and Control-Flow Hijack when reading tracefs fi=
les after the monitor module is unloaded.
--

commit 087c3d3fb8881f044270530a0540c2d8d606c74c
Author: Tobias Schaffner <tobias.schaffner@siemens.com>

rv: collect per-edge dwell time for per-cpu DA/HA monitors

With the core facility in place, hook it into the DA/HA layer so that any
per-cpu automaton monitor also reports how long it lingers in each state.

Add a selftest that enables a per-cpu monitor, checks the stats file
appears and is populated under load, and skips cleanly otherwise.

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 34b8fba9ecd44..59ca9a286c106 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h

[ ... ]

> +static void
> +rv_this_edge_name(unsigned int edge, char *buf, size_t len)
> +{
> +	snprintf(buf, len, "%s:%s", model_get_state_name(edge / EVENT_MAX),
> +		 model_get_event_name(edge % EVENT_MAX));
> +}
> +
> +static const struct rv_edge_cfg rv_this_edge_cfg =3D {
> +	.n_edges   =3D STATE_MAX * EVENT_MAX,
> +	.edge_name =3D rv_this_edge_name,
> +};

[Severity: Critical]
This is a pre-existing issue, but is it possible to trigger a use-after-free
and control-flow hijack when reading tracefs files after the monitor module
is unloaded?

The RV tracefs files (like stats, enable, desc) are created by the core RV
module, so their fops.owner does not pin the individual monitor modules.

If a user keeps monitors/<mon>/stats open and unloads the monitor module,
the module's memory is freed.

A subsequent read() on the open file descriptor invokes rv_edge_stats_show()
which dereferences seq->private pointing to the freed struct rv_monitor and
calls cfg->edge_name(), jumping to unmapped or attacker-controlled memory.

[ ... ]

> +/* Account the dwell in @curr, then stamp entry into the next state. */
> +static __always_inline void
> +rv_da_edge_account(struct da_monitor *da_mon, enum states curr, enum eve=
nts ev)
> +{
> +	u64 now =3D local_clock();
> +	u64 prev =3D da_mon->state_ns;
> +
> +	da_mon->state_ns =3D now;

[Severity: High]
Is this non-atomic update of state_ns detached from the atomic cmpxchg of
curr_state, allowing nested interrupts to read a stale timestamp or torn
value?

In da_event(), try_cmpxchg is used to safely advance curr_state under
concurrent execution on the same CPU.

If an interrupt fires immediately after try_cmpxchg succeeds but before this
rv_da_edge_account() runs, the nested interrupt will execute its own state
transition and read the stale state_ns.

It will attribute the outer state's dwell time to its own transition, and
write a new state_ns.

When the interrupt returns, the outer event resumes and overwrites state_ns
again, swapping timestamps and causing massive artificial spikes or
underflows in the statistics.

> +	/*
> +	 * local_clock() is not guaranteed monotonic; drop the sample if it did
> +	 * not advance so a backward step cannot underflow into a bogus dwell.
> +	 */
> +	if (rv_this.edge_pcpu && prev && now > prev)

[Severity: Critical]
Does reading rv_this.edge_pcpu here without READ_ONCE() or synchronization
make it vulnerable to a race condition with the error path in
rv_edge_setup()?

In rv_enable_single() from kernel/trace/rv/rv.c, mon->enable() is called to
activate trace events globally before rv_edge_setup() allocates edge_pcpu.

If rv_create_file() fails during rv_edge_setup(), the error path calls
free_percpu(mon->edge_pcpu) and sets the pointer to NULL while tracepoints
are already active.

If a concurrent trace event firing on another CPU evaluates
rv_this.edge_pcpu before it is NULLed but uses it after it is freed, a
use-after-free occurs.

Additionally, if the compiler reloads the NULL pointer, this_cpu_ptr(NULL)
resolves to the base address of the CPU's per-cpu region. This causes trace
events to overwrite critical per-cpu data (such as current_task or
irq_stack_ptr) and lead to an immediate kernel crash.

> +		rv_edge_account(&rv_this, curr * EVENT_MAX + ev, now - prev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827072400.4573=
4-1-tobias.schaffner@siemens.com?part=3D3
