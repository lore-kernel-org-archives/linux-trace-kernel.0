Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E4305E1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080398; cv=none; b=DUpWUaNVwohIe8D+FvzM/Zx3WPRG6pUoISToAZnXKPGmMUqpbtcNIhWnN8y3kNkHFKeMRZzHrSsluTYQdtk5Xc+vxPPnvd1B/Wq5jFJb2YXH2h8AU+qAb51gobFXUwXS+0N7yUFONn9HxOitHdFrvJovCz/2nrCLQ4xPK+GKJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080398; c=relaxed/simple;
	bh=ynCI/y/51uEFtd4eF9mNj+hjNua2qcuVle6fTFrVs0E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnV70UKAlDPV58PRLLpFYeegyaJijPr4BNeV87cxK8GdYxErMWnetfrh0kh8+r1ysOy8EPH8dqddJHJJL1otEXWfdUrR3+dUuCIwboMVsYhO/95Yh8hKpWL+dL7Rf2oW8TDNjC1lVlVMCu1CM5/WNQU/9vOaX78FGpcfs99IE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=A3g6y2w+; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="A3g6y2w+"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so2740306d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789080395; x=1789685195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XqjtsfF+woxPYCjyMdM+nWfj1EgLZP8UiechELtO6rQ=;
        b=A3g6y2w+iLFOvRvyvxsIC5vvEmXTizPShn1rYnFGDDxYjtpKa8wiX6Phl6RhXqqVhG
         8enKZ4Gb5nKLtC60yAUklX6YG2D+uzyA4WUVZq97yZ1EBmxBpmx3rlIyMGh+NBirv+H/
         8ift6JuahS/yQedzZeBPCevxsFmqd6uSeTAH2+W0JxKlC1yHy/dmh3CpBsiH9SpIXZx9
         NXGLaxNM6MB1XaGCexl7k5aRBUULaSzK/1RFp41wp8rvW+MDHSGI60mGEr46GENCB0fW
         RgAGImMFBEFk7dpC9XMVb9sO7kWi45FF5D+dgTFP/tE9pdPc0AJT38IazllHkiIPxELH
         X7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080395; x=1789685195;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqjtsfF+woxPYCjyMdM+nWfj1EgLZP8UiechELtO6rQ=;
        b=d4fhHo0c4VjxYi6uSUdeSOpwHeGPKm1vECuTSM57Qbpj7kSK78qGpohPNMNh7OjE/q
         7X2Td/vkidrmetUbacScxh9wd4WIhzS3s8CVx+Pc6ZY6g1YiKs7ViDtasaq2xdUEz1Pr
         QVsfBN8JPUD6AJTd8drA4dnkIRn+qj7P/0WcUzBeQGk+N29gRyKu/W5IxSg9dOBuo4u6
         mLARsIYZkTd41/8XMZj2UVZTjelf3KCoLVtjU4RM2gma3EIL+CZK+RLwNZDl1upDx5V8
         QfGpB2ukuKDXhjNx5y9PzvY4uRrjfJbeEH05VfxNGfg34WTG3yE8CrrJ1WMESq+w/uzr
         RL6Q==
X-Gm-Message-State: AFuF++klBNovXpppg+i23J7Qc9+q0lXMPMUaK9RSDyC4ISwTnKOrUxDi
	JJ+z66lBRzif8/uaByMn6w/i/BaJlPErAgabhniWTGktn86tcqiiJRxwufQYkPZtpSP+ITUhWq9
	KLf6h
X-Gm-Gg: AYBFou3rz/prSHfdw9NpZNTLM9sM5IChVdk0I2VuHffhN/tAdg3t4+KRL6DPzsCDlm+
	V3SCjV1Ci+rBuyiCOFnUFp6wXSSpYaR2xpdYmR/7CSH1MQV9QeFFUMXx7Oty0F3Ak+UNJ5Cat6p
	EW3e+N7MSJSK5fLuft2JlckB5qWFhGG1bM1CRe2lFOjajG3stx5+3WGOmBSFgbViGkLnwqN4D5G
	b7/TOeX2nMrmNB06wrg1IKSR0ThYyp8Ir3eeWwV2D2dRe8EMXg8cu0x4v35+GY95rb1ff5xj67I
	iDeFmKYn6NSNgW50bicpfmEBSP51hJKxaMqg4pDdsaHdBeBB6mNiRrTck9nCAbaajOBdhZ+tzMy
	EV3inF0UYWnPRa+0WxO/JZ6SO5yN0rYkl/V6H9vKEbR2YDLTxUBNG7ay8r6KUKfdG2Jy8FKK9iD
	noahuwu3A+PVUDWWURwWss9jsYtaWUS8k72EIgbNNtKQuWEu/VlzbwS/B55446XQCwkKo0nAJIE
	CsBKdqfBghdCJ1rTj2QDM2+JHuKki5X3n85Sp3Kp+r01Wqh/cVnV1PF
X-Received: by 2002:a05:6214:3d87:b0:8f3:cf36:15ca with SMTP id 6a1803df08f44-912120871ccmr20208526d6.9.1789080395108;
        Thu, 10 Sep 2026 15:46:35 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45cb06sm6765616d6.11.2026.09.10.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:46:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 22:46:23 +0000
Message-ID: <b0a38578ec1e1cbf26b190087e7faa79.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC 04/13] kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window
In-Reply-To: <20260910191634.5D7C21F00893@smtp.kernel.org>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com> <20260910-b4-rcu-tasks-preempt-qs-v1-4-d4469f4cc101@toxicpanda.com> <20260910191634.5D7C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 19:16:33 +0000, sashiko-bot@kernel.org wrote:
> > +bool kprobe_in_optimized_region(unsigned long addr)
> > +{
> > +	int i;
> > +
> > +	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> > +		if (get_kprobe((kprobe_opcode_t *)addr - i))
>
> [Severity: High]
> Could this loop introduce significant overhead in the preemption fast-path?
>
> On architectures like x86, this loop executes up to 18 times, querying the
> kprobe hash table via get_kprobe() on each iteration. Since the hash table
> can have long chains on systems with many active kprobes, this could result
> in thousands of pointer dereferences during a preemption event.

This one is fair. It is not the scheduler fast path in general, only the
irq-exit preemption path (need_resched set on return to kernel with
preempt_count() == 0), but 18 hash lookups there is still more than it
needs to be. For v2 the walk only runs while kprobe_optimizer() is
actually sitting in its synchronize_rcu_tasks() -- a flag set and cleared
around that call -- and rcu_tasks_ip_in_trampoline() only asks for core
and module text. A preemption that does not see the flag predates the
grace period; the task is then just an ordinary preempted holdout and the
jump is not written until it has run again and left the window, so
skipping the walk there is safe. Common-case cost becomes one load.

> Also, does this introduce a use-after-free risk for interrupted idle tasks?
>
> kprobe_optimizer() unlinks kprobes and frees them after waiting only for
> synchronize_rcu_tasks(). Because synchronize_rcu_tasks() explicitly ignores
> idle tasks, an idle CPU that is interrupted could end up traversing the
> kprobe_table here via get_kprobe() while the kprobe is concurrently freed,
> as Tasks RCU will not wait for the idle task's traversal to finish.

This one is not right, for two independent reasons:

 - kprobe_table is an RCU hlist and nothing frees a kprobe on the
   strength of Tasks RCU alone. Every unregistration path does
   hlist_del_rcu() and then synchronize_rcu() before the object goes
   away, and the optimizer's own free step runs after a Tasks RCU grace
   period, which begins and ends with synchronize_rcu(). The caller here
   runs with interrupts disabled, which is a normal RCU read-side section,
   so the walk cannot outlive the object regardless of what Tasks RCU
   thinks of the task.

 - The idle case cannot reach this code. irqentry_exit_to_kernel_mode_preempt()
   returns early when state.exit_rcu is set, i.e. when the interrupt was
   taken with RCU not watching, so the irq-exit preemption path (and this
   check with it) only ever runs with RCU watching. And the idle task is
   not preempted through this path in the first place.

So: overhead finding valid and addressed in v2, UAF finding invalid. The
commit message in v2 spells out the RCU-safety argument so the next
reader does not have to reconstruct it.

Thanks,

Josef
