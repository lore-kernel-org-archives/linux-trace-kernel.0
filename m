Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810649;
	b=aBoxkEDqt4dxvR/5Gh7gRYw4/YyRQ4JbT1jpucmrsb8zXOLzu3iVh+mebLGIex+ffukS
	 j5hYDlc341r7+i315nppqXqldCmwRpuaeOF+G5nWLvTi2zTROKlHRYtUs816BQqudPwnA
	 cJrJpEqiAemIpx41z2ydq94vkAbeudZvi3zeSArBjXBaPadpLFvZGQO9Ea8u78UypGD+l
	 rv+gOWPMq1AG5m0u4jt07Jt+xMswTtHvlyz7pzcer3cjf4r93hfVTpkdMY2/aThAH7l4A
	 JXPONzRVMz6/eoaEW18A2r5a4zfyGN4gQuRzJAxeWmrS0jmTv3PAzzlzDXxzw7CzdYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nV2r7k/wz3b04bHgUI3RSPi8hDfS8dQ4mmisBszesNM=;
	b=tGdizXuWF2H4+He47s19K6m8ZUkSb0leeGCEx491h7bcHShws3lsnPJo/AqOeKSPsp1V
	 GoVBxBbzgLWMHOyHsX5D0IPXWZQfOS8zyFg2OLa1EyKlTCbilKOWScM+BxynD3R1rbXoy
	 VxZM5U0HK5lliK5/RN1Mn0qQZk2XnY5lrkm/2j8REIcImfn/dPE6GZIiNUwO38Ay1em01
	 9wazA57uZPaGjUFV1MIpmwbXTB/W9mtIoRxnQkLDPUt1hu07WgThSXv7r/FqERKcWKLYf
	 mwz3vPCnCZl54rT6x60hyGoPYcU9tmwZ7oDJsS00i2FsHShc4nRXijcZ39CmQ9OK8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKEZ2WTE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8F606A31B;
	Wed,  4 Nov 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKEZ2WTE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56331F00919;
	Wed,  4 Nov 2026 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810648;
	bh=nV2r7k/wz3b04bHgUI3RSPi8hDfS8dQ4mmisBszesNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKEZ2WTEZWvhk5E1QImCHa+zgLWKLh42i4IGhtK9/lzjld+huug8FmkAYfQDRt6tC
	 TFKmHyD3Do2Fj4MXTKNJ88+lq7+mZuIprb4dr/KyAPpd8PTzj+n1e/r15AjwCkKoYM
	 Pk90ig60K1LT9scXLdl9ONZdFPmiSU4VH4Oderv4vM1xm/Z7FUgSVj4KJkFDMlcpHN
	 4O9okUk+cOFfPObPOqej4sixBNFiOS+ZBnKVQBpeuvAEfwaMIB0g9I7z/7ZqDzzi9j
	 Duj0q6vf+zquCFglJhnIgPt687O4BXxkTgt1LjpWIHrbdVRJklt4dEZtClbp8EEOn7
	 Hc+QUn6MTfGhA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH 3/3] kprobes: Arm reused optprobe on cooling list
Date: Thu, 05 Nov 2026 01:44:04 +0900
Message-ID: <undine-1793810644673369233-54123b0cf19aa6b9@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261103-kprobes-optprobe-state-v1-3-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu> <20261103-kprobes-optprobe-state-v1-3-6aaac612abe6@columbia.edu>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 03 Nov 2026 13:46:01 -0500, Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -536,6 +536,7 @@ static struct optprobe_generation optprobe_gens[OPTPROBE_GEN_MAX];
>  static int optprobe_cur_gen;
>  
>  static void optimize_kprobe(struct kprobe *p);
> +static void __arm_kprobe(struct kprobe *p);

If reuse_unused_kprobe() leaves arming to register_aggr_kprobe()
(via arm_kprobe()), this forward declaration of __arm_kprobe() will not be needed.

>  static struct task_struct *kprobe_optimizer_task;
>  static wait_queue_head_t kprobe_optimizer_wait;
>  static atomic_t optimizer_state;
> @@ -1067,6 +1068,13 @@ static int reuse_unused_kprobe(struct kprobe *ap)
>  	if (!kprobe_optready(ap))
>  		return -EINVAL;
>  
> +	if (optprobe_queued_cooling(op)) {

Instead of arming the probe directly here, consider let
register_aggr_kprobe() to arm it:


if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
	ap->flags &= ~KPROBE_FLAG_DISABLED;
	if (!kprobes_all_disarmed) {
		ret = arm_kprobe(ap);
		...


The reason a cooling probe didn't fire in the first place is that
reuse_unused_kprobe() unconditionally cleared KPROBE_FLAG_DISABLED.
Because a cooling probe was already unoptimized and disarmed,
it should remain disabled while on the cooling list.

If reuse_unused_kprobe() does not clear KPROBE_FLAG_DISABLED when
optprobe_queued_cooling(op) is true, register_aggr_kprobe() will
naturally arm the probe via arm_kprobe(ap) only if the newly attached
probe is enabled (!kprobe_disabled(p)), handle any error unwinding
if arm_kprobe() fails, and keep it disabled if 'p' is disabled.

> +		/* Already disarmed. It will be optimized again upon finalize */
> +		if (!kprobes_all_disarmed)
> +			__arm_kprobe(ap);

Arming the probe here unconditionally when it is on a cooling list
introduces a bug when the new probe 'p' being registered is disabled
(e.g., registered via tracefs before being enabled or with KPROBE_FLAG_DISABLED).

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
