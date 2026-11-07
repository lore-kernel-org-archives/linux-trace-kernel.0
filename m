Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032271;
	b=HCCT/YU+7A516YEK9YR0ZRbDJ7loH9ix/Ox3ATaACtx5HBiSjZCm8jC9Vv2UO0GLyW+7
	 MWSQto+nbF3/cdGLZozWzYMe4djQrYQimSSeP3WJkoF/BERR+yr3yDjuOQ5OAM2bbWQMM
	 4hMftb6xSKyxVQqmohyLenR5YIJ8I1uhT7cZwScJaDhsBYgeeAelnlDTKV4MrqjDOFQbT
	 Ier4QTB+tV3qdcPcsLI/LuDU/O62K00PBe8YB7nC9UGWlI3GaijcyDHh9VGB4wSUn4FUw
	 nQk/gXJiLsnZvbD9r8nQXZZA5j1eX5pvuEVX4TWtxbEcRDRJTueJuFDe4Yp3sUzW/ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4NUp6zKi7OhNAqO7TyxoIhg2M2oKnsNewifMx2J5Wu8=;
	b=Zf5SbYdMByN+SMGqlTfBQn+b5OT44K+S6TWveDYhLwMzDWJ95BmJMobkuu2dsqEJeej/
	 0Y5BYmZpVMgVF0FqEgyhAbnfYHcfa6gojjkWFW87J0bfT+avPwJXW355ihk+SPr0EtvJs
	 CqWckblULURILbwirKJaQavAUJ3Qa0BaQVk+xxcJJvNN9bzAZuHyFvntaP/PJNNeGrEIr
	 osDxTkge4AU9DuW8WF2kpt73hENhjNQrIF00cMapfYTff1Sh01DsukQz/Hx1wTZWNZnKf
	 I9NX3QJ6eRCJaED7pIDhafb9KCEGl1d1X+LRITuzwGPqF7ZmxUPhIsgC2r62z6C8ZGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARSIXRJs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E64606A326
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARSIXRJs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183AD1F0089F;
	Sat,  7 Nov 2026 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794032270;
	bh=4NUp6zKi7OhNAqO7TyxoIhg2M2oKnsNewifMx2J5Wu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARSIXRJsKst4yMR5LO6O/+l7CCPWKdg9/O2nb5z4cCrI4vwUR/XuWWAx+kjITlw1m
	 eeA1KyNStiwWenqfPeiLYt0ez9eVDT34gAxJtcZ0VtozyNZ4hhkuQEPOXxjW8/RC7+
	 P8uN+9mgfHuHcXtqhjoLwEyGiY9hITHAhInK9XW7+JHwCNOvP1jlz/hWzPLu91uWBP
	 7YrYIuH1bQhw0pT/dpjymchnP4amz4JCKZ1/YGzDeU6BHLicmGv14kTibB19jL48e9
	 f50e9gEgcuCoyFyURDubTYfT5DsvmzfusciC0rXSz8tDoIKbrTC1y8C6GxMVg5Y4vx
	 CcTdhhpTgzI3g==
Message-ID: <sashiko-outbox-202658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] tracing: Use the stackmap from the ftrace stack
 recording path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261107055139.3138633-3-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
 <20261107055139.3138633-3-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:17:49 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] tracing: missing RCU grace period in update_marker_trace()
  on disable [1]
--

commit 7075e3df3e37a58db04cf4e9626607b29d78b5fc
Author: Pengfei Li <lipengfei28@xiaomi.com>

tracing: Use the stackmap from the ftrace stack recording path

This commit hooks the stackmap into __ftrace_trace_stack() when the new
stackmap trace option is enabled, recording a TRACE_STACK_ID event with
the stack cookie and adding a "free" command to stack_map to release the
map when disabled.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 18710c190c924..cdae2976d224f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c

[ ... ]

> @@ -3996,6 +4101,15 @@ int set_tracer_flag(struct trace_array *tr, u64 ma=
sk, int enabled)
>  			return -EINVAL;
> =20
>  	switch (mask) {
> +	case TRACE_ITER(STACKMAP):
> +		if (enabled) {
> +			int ret =3D stackmap_set_flag(tr);
> +
> +			if (ret)
> +				return ret;
> +		}
> +		break;
> +
>  	case TRACE_ITER(TRACE_PRINTK):

[Severity: Critical]
This problem wasn't introduced by this patch, but can disabling
TRACE_ITER(COPY_MARKER) in set_tracer_flag() cause a use-after-free of tr
or corrupt marker_copies [1]?

kernel/trace/trace.c:update_marker_trace() {
	...
	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))
		return false;

	list_del_rcu(&tr->marker_list);
	tr->trace_flags &=3D ~TRACE_ITER(COPY_MARKER);
	return true;
}

In set_tracer_flag(), the TRACE_ITER(COPY_MARKER) case calls
update_marker_trace() without waiting for an RCU grace period when
disabling the flag.  Meanwhile, tracing_mark_write() and
tracing_mark_raw_write() walk marker_copies under RCU without holding
event_mutex:

CPU0                                    CPU1
tracing_mark_write()
  rcu_read_lock_sched_notrace()
  list_for_each_entry_rcu(tr,
      &marker_copies, marker_list)
                                        set_tracer_flag(tr, COPY_MARKER, 0)
                                          update_marker_trace(tr, 0)
                                            list_del_rcu(&tr->marker_list)
                                            tr->trace_flags &=3D ~COPY_MARK=
ER
                                        __remove_instance(tr)
                                          if (update_marker_trace(tr, 0))
                                            synchronize_rcu()  // skipped
                                          free_trace_buffers(tr)
                                          kfree(tr)
    __trace_array_vprintk(tr->...)  <-- use-after-free

Because COPY_MARKER was already cleared by set_tracer_flag(),
__remove_instance() sees update_marker_trace(tr, 0) return false, skips
synchronize_rcu(), and frees tr while CPU0 is still writing to it.
Similarly, toggling COPY_MARKER off and immediately back on re-inserts
tr->marker_list with list_add_rcu() before concurrent RCU readers have
finished traversing from it.

[1] https://sashiko.dev/#/bug/linux-3d780d38-c496-44e0-a5a4-9138bd4d11a0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107055139.3138=
633-1-lipengfei28@xiaomi.com?part=3D2
