Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817819;
	b=hWLHu6pVtMKXU4T/MXnMtrjmBUZMEYzP81oZsnvny4xjLunM1EHCI0suWj4/ZvLXzzbq
	 2ti8feY/fAxB/0y6oDB7aYfTJM4BL3MVSWNs2nilY8R/G5JY9gZjUChBEnejXnyaM/Adh
	 vyxMeacgSqUjaDtAmqoymSeRULDa8zp8gctEYCmSp6x9ikMhgVkfRKXcZI8KiTw0V1ZQa
	 inLkXfN4D93OpFTZVAWd4w85whB94dcpSU9FaWDJpNwyfrs0VjdwdagHU35aKZEoV/ClL
	 N1luzQ1Jg/M3qlE3fgEZAG1rfbEVe70UXc7Q5VPrOsV1OGF6bbG/GKRM+qDo9Dd117w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fu9+FUsqnSURGxGtvWnDGZCY3BmLFFOBN+jxlcwTLJw=;
	b=bOCKnwdpV1bcSDsZSGLhqxJtId7G2BrDb4Q3xr1UYSMuuT0EmvaJUE0IihmU8aUHRp4V
	 w4s/Gbeffd68tFG4zkjqestfSaCU68s+7dY9e6+wbTYroEOCGubuG1mhwJ768tHWbT6Dz
	 rAdolFcQTaVQbw9ca1LM8RsmZGBVC2lVARmsXqSmzX+F5B62tBPafn+smzpFe5kLVUbAa
	 x+7w/FlSRhYRFIxoAArDpQX0JGNQNmsewYdmizVQhnA5qjx/hCQfwGTSDvyFSHFc10kvy
	 xNg45CWsVH9Qlym58W6i6KVKRB0qEIn5l9SIML4sZa3RWGaTc8I9FJUH+LVkVdSOe8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLAW0hYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D793606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLAW0hYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189721F00893;
	Fri, 27 Nov 2026 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795817819;
	bh=Fu9+FUsqnSURGxGtvWnDGZCY3BmLFFOBN+jxlcwTLJw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cLAW0hYcLD1WO2BEn0WVgDBAcoMdE3wc8gNdKqgLEQWKjst4OXX83rnw6Th9P8N/y
	 FAnJINCX0afFRpXtZUk1wTqQoU8dg1Kd6Ok33ej8hUUp107T49w6kbiG5Y//b9iBbc
	 soQkn92o94AFVofr+fEYqsz7wO8mqgwvyZ3XsH8Qftmlbn4zMg19cT0CK+ncljmxrU
	 R3JF1s5KCD78B7VHE0UZcct1UysNUnNVhyOLquzldz8G5SNYCGsxn6mNNHpmvt5ONm
	 cfuM1LrUGVvZJfwBhnvQB4z8pwiXx4MfmQb7ckMgCj0lRO2YWSnnEMOG03fku4D5rB
	 LBUzW2dutHZKA==
Message-ID: <sashiko-outbox-238322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched/isolation: Have housekeeping_any_cpu() use
 raw_smp_processor_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261127171034.60e9de0c@gandalf.local.home>
References: <20261127171034.60e9de0c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:16:58 +0000
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
- [Medium] sched/isolation: housekeeping_any_cpu() still warns in
  preemptible context
--

commit c1392718dea3b288dab2eb1637739fbba4e0fc9a
Author: Steven Rostedt <rostedt@goodmis.org>

sched/isolation: Have housekeeping_any_cpu() use raw_smp_processor_id()

This commit replaces smp_processor_id() with raw_smp_processor_id() in
 the housekeeping_any_cpu() fallback returns so that callers in preemptible
context do not trigger preemption warnings when isolation is not enabled.

> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 156025ef81b75..c1c84d72c7c5b 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -99,7 +99,7 @@ int housekeeping_any_cpu(enum hk_type type)
>  				     type !=3D HK_TYPE_TIMER);
>  		}
>  	}
> -	return smp_processor_id();
> +	return raw_smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_any_cpu);

[Severity: Medium]
Can housekeeping_any_cpu() still trigger CONFIG_DEBUG_PREEMPT warnings when
called from a preemptible context with CPU isolation enabled?

When housekeeping_overridden is active and housekeeping.flags has the
requested type set, housekeeping_any_cpu() takes the branch above this
fallback:

kernel/sched/isolation.c:housekeeping_any_cpu() {
	if (static_branch_unlikely(&housekeeping_overridden)) {
		if (housekeeping.flags & BIT(type)) {
			cpu =3D sched_numa_find_closest(housekeeping_cpumask(type), smp_processo=
r_id());
			if (cpu < nr_cpu_ids)
				return cpu;

			cpu =3D cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_onlin=
e_mask);
}

That path still passes smp_processor_id() to sched_numa_find_closest(), and
both sched_numa_find_closest() (under rcu_read_lock(), which remains
preemptible on CONFIG_PREEMPT_RCU kernels) and the fallback call
cpumask_any_and_distribute(), which uses __this_cpu_read() and
__this_cpu_write() on distribute_cpu_mask_prev.  A preemptible caller such
as ring_buffer_poll_remote() -> rb_wakeups() -> rb_irq_work_queue() on a
system booted with nohz_full=3D will therefore still hit smp_processor_id()
and __this_cpu_read() preemption splats.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127171034.60e9=
de0c@gandalf.local.home?part=3D1
