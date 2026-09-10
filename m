Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BD4BFE72
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008532; cv=none; b=n+Fost5GB3necf/BllECjVstBkUN3+zeDpgC1N9WOpwLrKDQIGjto6OWbv50lgZkNQgBB25z1PXioz/tP4u2+jeprcxEyStN2AD7px27lVSkK/C/nu/9j4kJ4d4FZvHrXNHyWge0YjrakEIA74Ql+sEUFjvzw0ijPNhy7fA/Xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008532; c=relaxed/simple;
	bh=x+t2yibhsbWU3nRw308p16O1fODHF7kTmX+Y60Sqgxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vExn7Y0AQD93hthVattK0xkf2ia4Of3XZ27i6hcM9jS863warp3lZpd+AzyOp6XPiNBGsSSv5ZSO8zjeVnEwb5cArMwG4MyohYyVz7S1PwjyW+njYboSm8wv6bJG5pkG5moI+CK6b1bz8+wEmum9QUoUT3pdWwIIPbuZPTRgGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtJneu/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtJneu/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3351F000FF;
	Thu, 10 Sep 2026 02:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008530;
	bh=dGkKx6cCwxR0efswsyF6Mqg7uv99uKDcFFxwFPwokq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DtJneu/e+uLSwMwbq51Rou85bO3VfIOqN/zEjjCIuNKnL/piRCZn8z8SbR+MXo4Ln
	 ycS9tG4xO716clh2BmO/MCWG3b2CBZGluGRO1NtDKa8KoExSYbs5S+kHCuymFOYORD
	 FAArUPeKIflBUb/TLPKhKGj9LK8FioNbo7hezxCwdyUftB9GA7imD1hjafFKJS8dq/
	 QnbMfHPQmmQ/Qfw418f907ic5jWXMlKH6JfngdVg5otkkBFf6fEdXyGmEO9LE1FVU9
	 KtmAZAXtIxDtFgPuXP8EXoym7xeVP3cLnmaO0FqyyAMssDPQLRQgDNtvg1Z8z46dSN
	 cYmP8djKK4NGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: uprobes: Fix slab use-after-free in
 filter_chain
Reply-To: sashiko-reviews@lists.linux.dev
To: zafir.taufik@starlabs.sg
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910023106.1795811-3-zafir.taufik@starlabs.sg>
References: <20260910023106.1795811-3-zafir.taufik@starlabs.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 02:48:49 +0000
Message-Id: <20260910024850.6E3351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition in unregister_trace_uprobe leads to use-after-f=
ree (UAF) of trace_uprobe during lockless read accesses.
--

commit 04fcafa318e6d04f74e677950139db1dd3bf079c
Author: Zafir Rasyidi Taufik <zafir.taufik@starlabs.sg>

tracing: uprobes: Fix slab use-after-free in filter_chain

This commit addresses a use-after-free in uprobe_mmap. It resolves an issue
where unregister_trace_uprobe() would fail to unlink the consumer when a
trace_probe has a sibling event.

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 861d857adadb3..110ec7b78b3dc 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -408,6 +408,11 @@ static int unregister_trace_uprobe(struct trace_upro=
be *tu)
>  		return ret;
> =20
>  unreg:
> +	if (tu->uprobe) {
> +		uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
> +		tu->uprobe =3D NULL;
> +		uprobe_unregister_sync();
> +	}
>  	dyn_event_remove(&tu->devent);
>  	trace_probe_unlink(&tu->tp);
>  	free_trace_uprobe(tu);

[Severity: Critical]
This is a pre-existing issue, but does this code leave a window for a
use-after-free of trace_uprobe during lockless read accesses?

When a sibling probe exists, this code unlinks and immediately frees the
trace probe without synchronizing with trace readers via RCU or shared lock=
s.

For example, when a user queries an attached perf event, it initiates a
lockless traversal:

bpf_task_fd_query()
  bpf_get_perf_event_info()
    bpf_get_uprobe_info()
      trace_uprobe_primary_from_call()

This accesses the trace probe structure without acquiring event_mutex or
trace_event_sem.

Additionally, even if trace_event_sem is held for read, such as during
print_uprobe_event(), unregister_trace_uprobe() bypasses taking
trace_event_sem for write when unregistering a sibling probe (it skips
unregister_uprobe_event() and jumps directly to unreg).

At the same time, if unregister_trace_uprobe() is called, it unlinks the
probe via trace_probe_unlink(). The list removal relies on standard
list_del_init() instead of list_del_rcu(), allowing concurrent lockless
readers to traverse into soon-to-be-freed nodes when free_trace_uprobe(tu)
is called immediately after.

Could this lead to memory corruption when readers access the freed probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910023106.1795=
811-3-zafir.taufik@starlabs.sg?part=3D1
