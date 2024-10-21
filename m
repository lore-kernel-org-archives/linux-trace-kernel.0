Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE751EF936
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535041; cv=none; b=p2fPByvv3xwbmG0eCbPMVUJSZQoXG0/cIHCWWa74SvNWo3JE36SNK8oGDt0ki1pAi9/ggJ/J+JK4leKE411QwSZdRoHaO2qkk9RrW26mReLWyuSZxaX4blMJ3isMFv0+pWU1c7N/i23AP4MH9tLzI3WfcjL9U7EHrYFlLAMPaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535041; c=relaxed/simple;
	bh=8hO7WVmgs/54rE/Qnx5FskJRGtxef3jfJ04J3wZOwwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGeiqv8qq/TAaMjIzk8k/adkP9fSWI4dicrK5ZfpNwxrga1Tof4gHn1V/GPVRQPaXIs0J1Ypd0NzJutHY/uUOD4EMoFLdhW/mVUFfASXVfGDZxRZQVobF5F5kz5b0qDROID3aTx+tAZkIWzNKxxO2abu4oQM+2mamrAHLHEG57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nZJKrTG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nZJKrTG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so7771683276.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729535037; x=1730139837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=0nZJKrTGc9HNp3zRFdJo5A52JGLbGL6pZq6tMspjwb8a+iBPAGxsinXdwmMJxmUaVc
         e8Asp1Us6mDpmouteQD69ST4+vDaA4Mf3R62TUnr/WAmADWhlxPOxyfoXYvxJaCt0byA
         Qw1kfLR0PevYzRqkr8MLbajzducDCfQlPWUe/xv8tfuC363dGavLTzdZEJHodQwwuDtV
         2M/hKMKNK1gjwNoohM6gRGBwfB3kgl4PW2EYg5YCT2DVZAQW+2MR5ok6HwYcuT6VHbYC
         bx4899LgiNwPVk27kCTNwz/tGDCnerCy/U0YEWYXh/mApp0i2gFmlNUq3Rijf7tWropu
         DMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535037; x=1730139837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=aXaE5qpyjj/2W/lVC16tyx9WREp1TGiqMI1JxJueHPcrDsQt9GkLT83roy+OAYM+Md
         Kk0tgETxF5IzwUGiQMKN/vRKK3hSj1+J02mO891I/foVZPirDO7FgGgsxErJVL6vrFsf
         4tqiSrmABqw/EZ32XJYbmlWvYtm8MrlDs2ATWOq+dmN6WKndF4XOwnoSxXiYxEeBWfr2
         zPqgv9OFIrXcuRDmkeizROBU6X5aKsU4PBdtoeqeKNeQRBQcpFAw55NVEdPc/tIISulX
         MvBpOvPPukbROmlflYkEmgcg29fj8I/NkluVgS7d8IuljkaGLDphJsfCecDBgTmIOFQ9
         E+4w==
X-Forwarded-Encrypted: i=1; AJvYcCWIf2o1+9y67NXeHOiSrvVNGssD4+VvIiWM6wervPsyTcX5n1PpZnvUcaLWxuLMRMdrAJV7aDjZ6Ts0yZVDhzOHAu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47BOS1IRuRJhdqdva8LulepDEkZDrSqRqix2FDQ1AQjW5dnXC
	Ne/FeA4RjeN3+Riyr1RiHwlX80RcFiBBp6Urv9K+0oXQ3V+I+VMN/lmi85zZeJ4AMEUT50lK+w=
	=
X-Google-Smtp-Source: AGHT+IGU9wQ/1p0Qc2O+WS90aQobDGhVJv5JsMEe6PkyP+aaKw6VNLs64wQj+yTMqXYj7j0ZxkJT/QBjqg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a25:dc8d:0:b0:e2b:d018:9690 with SMTP id
 3f1490d57ef6-e2bd0189713mr16383276.11.1729535037035; Mon, 21 Oct 2024
 11:23:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:23:47 +0000
In-Reply-To: <67121037.050a0220.10f4f4.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67121037.050a0220.10f4f4.000f.GAE@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021182347.77750-1-jrife@google.com>
Subject: Re: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
From: Jordan Rife <jrife@google.com>
To: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

I performed a bisection and this issue starts with commit a363d27cdbc2
("tracing: Allow system call tracepoints to handle page faults") which
introduces this change.

> + *
> + * With @syscall=0, the tracepoint callback array dereference is
> + * protected by disabling preemption.
> + * With @syscall=1, the tracepoint callback array dereference is
> + * protected by Tasks Trace RCU, which allows probes to handle page
> + * faults.
>   */
>  #define __DO_TRACE(name, args, cond, syscall)				\
>  	do {								\
> @@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		preempt_disable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_lock_trace();				\
> +		else							\
> +			preempt_disable_notrace();			\
>  									\
>  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>  									\
> -		preempt_enable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)

Link: https://lore.kernel.org/bpf/20241009010718.2050182-6-mathieu.desnoyers@efficios.com/

I reproduced the bug locally by running syz-execprog inside a QEMU VM.

> ./syz-execprog -repeat=0 -procs=5 ./repro.syz.txt

I /think/ what is happening is that with this change preemption may now
occur leading to a scenario where the RCU grace period is insufficient
in a few places where call_rcu() is used. In other words, there are a
few scenarios where call_rcu_tasks_trace() should be used instead to
prevent a use-after-free bug when a preempted tracepoint call tries to
access a program, link, etc. that was freed. It seems the syzkaller
program induces page faults while attaching raw tracepoints to
sys_enter making preemption more likely to occur.

kernel/tracepoint.c
===================
> ...
> static inline void release_probes(struct tracepoint_func *old)
> {
> 	...
> 	call_rcu(&tp_probes->rcu, rcu_free_old_probes); <-- Here
> 	...
> }
> ...

kernel/bpf/syscall.c
====================
> static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
> {
> 	bpf_prog_kallsyms_del_all(prog);
> 	btf_put(prog->aux->btf);
> 	module_put(prog->aux->mod);
> 	kvfree(prog->aux->jited_linfo);
> 	kvfree(prog->aux->linfo);
> 	kfree(prog->aux->kfunc_tab);
> 	if (prog->aux->attach_btf)
> 		btf_put(prog->aux->attach_btf);
> 
> 	if (deferred) {
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
> 		else
> 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> 	} else {
> 		__bpf_prog_put_rcu(&prog->aux->rcu);
> 	}
> }
> 
> static void bpf_link_free(struct bpf_link *link)
> {
> 	const struct bpf_link_ops *ops = link->ops;
> 	bool sleepable = false;
> 
> 	bpf_link_free_id(link->id);
> 	if (link->prog) {
> 		sleepable = link->prog->sleepable;
> 		/* detach BPF program, clean up used resources */
> 		ops->release(link);
> 		bpf_prog_put(link->prog);
> 	}
> 	if (ops->dealloc_deferred) {
> 		/* schedule BPF link deallocation; if underlying BPF program
> 		 * is sleepable, we need to first wait for RCU tasks trace
> 		 * sync, then go through "classic" RCU grace period
> 		 */
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> 		else
> 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> 	} else if (ops->dealloc)
> 		ops->dealloc(link);
> }

After patching things locally to ensure that call_rcu_tasks_trace() is
always used in these three places I was unable to induce a KASAN bug
to occur whereas before it happened pretty much every time I ran 
./sys-execprog within a minute or so.

I'm a bit unsure about the actual conditions under which
call_rcu_tasks_trace() should be used here though. Should there perhaps
be another condition such as `preemptable` which is used to determine
if call_rcu_tasks_trace() or call_rcu() should be used to free
links/programs? Is there any harm in just using call_rcu_tasks_trace()
every time in combination with rcu_trace_implies_rcu_gp() like it is
in bpf_link_defer_dealloc_mult_rcu_gp()?

> static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)?
> {
> 	if (rcu_trace_implies_rcu_gp())
> 		bpf_link_defer_dealloc_rcu_gp(rcu);
> 	else
> 		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> }

- Jordan
