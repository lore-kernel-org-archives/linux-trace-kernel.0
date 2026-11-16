Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843048;
	b=S08k1EV2zt8uX+yl+PUwVCg9nlhgeAunZD9wlMDDQ04ACDTx0w3ImCge/w7C+Gt9p9Fl
	 8sSmD5+p97qr3hsekK5ajb9WnH3uppeLjpEBNAD+JYQ5iXV0DYheU/riLlwt2ytsrDrMb
	 rrvv5qQ/wRHp1kDapRz8hbY7ps8Hi8QXKPa2KIXuBxcrWVOsR/AvEGeNCFKi1LeVr8Xyq
	 tgqcJ6QP4Y5hMqRdpoXdlwMQ4gGce7oG0QsxcnzOIZ3VJyNJxcBPloc4Cw9jPlC8kytiT
	 sibFQ/PVD7UbHzAWn05+cIze+VayoNLugEZxo3k/7+kcVKPjumJ2aUwa46WfyR6v10A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
	b=HKG+SwS24fbL7VfrbRXqewpLwJJii5lpDm+dVozZbTURHjF2oT7Yda+Dz+594xIPL0cE
	 s1i+hPPTI8X1S3dVzivJpt7U+zFtlmJUDIKr8ABglxFg5YIcRRiuXyYy483FtfN5wKqlk
	 gOxHm4ewLtfZfnWyKxIPhDq6c51XXUU9P5NR8qJk2N3E3DZNaAcaYFUy3zMr9K77iN8B9
	 9xC7/3AK7XEUljwWOPLUbh9/rPgpQ6svEzeKHWgBYwaXWsxnlWY6kMGGT5ewRs014vAGO
	 qNnjaJnxYuOKMDi/7WfQrhSe/hYcF3t2j8cPRQMQS2weKVi7wbAVFlHNBpYoPROtnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eAhCdfIK;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BD606A339
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573BD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eAhCdfIK
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so24183395e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794843047; x=1795447847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=eAhCdfIKl5mPrwQuKFbVoFA3q4oXWguQqagInhzpW4knYPgHyd/+RDBzfKdfDUhYrc
         B8YxxDd7tF5OawO5pQ1prRvBlKt6Ff1uJfp5058atdcuoGSs8UxE9WDjFpYaFKaSJaOU
         VhuLX80MPey6FZEe+WGZznQWSeo/HiVC2wkglBkhRAkVJC4dGCb3ptqvBTefe27K5wY7
         ft8VUxABnRKDLwjs5Sa8oLWEnVx7u8nujPT52t3wTTpydkZ7cW21QxFZuhEPe65xPJwa
         AN1TnrBi2DLTrq6KzGGB229v5ORJq+adCRoXoIoNt7NSTeTNyR3kAGJ3YHa8+5Yu2Lb+
         7qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843047; x=1795447847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=f4Q1QVmFDnkfy+xbrKpIigc95WKadR9LLvoKSnvBGs05lTtO76BHe/mjfXCDX/Y096
         g1r5Rfotrslb7VchDwbuLgx8YneUmiEiWJ4tOe/SH1HIt50FMKrYh7v8ICwN5vVsLXyp
         YpVOAkWBFZSX7TBZOYMs4gFLAtyjK8E0ikkz72cWmjMJipy1P8RpZSWFa2gEkWSk8h9a
         HxR6iZmPkdeUrkDmHJzFuYlpNUdyLacKZZqxeWPoVxr6B4DKNQut0XTn3nrMqrhCUnfP
         EDpa/bHvjthEkBCN/ss4ajgaN1Wh0/czzx9ZcvIMmqEyTl1Z23T2owgc1hL/bxKJdocH
         rY6A==
X-Forwarded-Encrypted: i=1; AL+hErGJvqsFYSU+YIP06WYozCCPGQHqTw0lqlW/qJ1kYOz2iR3l9SWGDzOTUo38b3TfJIglzAW/TTFMNA4F/PqdijpSyHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ONNXAtD5tdu+sY4nm0m1OSuIr0c4KvELRQamGifpHNSik8B2j
	EbX6laQWJDYrLsBYv745MUfW51iEDEguFHZOQVekZBOGmOwnT2Um7D4R6bOx0AbcBAs=
X-Gm-Gg: AYBFou0xmTXknuP1CdSkTdOtWo7lpvvjAknJq7rDKwoPBi8qyQ6EG7zkjSGeGEC6p1h
	ZwkOIuPGd34YHBysKJ1IGe0zKlktf68yDwMe80dhUbWcQrIO4U4YCPNltiElFxjZQkYt25RVUsV
	/iPpe2fF9ax2tnbVGq5eGvYvG2EyRCHqs8PyY5Lz3qie6itPGUyCJXhEyjscCHKtEnr4wX2/lGr
	MxiT4TAMVQ6cHZ8w+548MBO5fggpU6rgbiqY4U6V4u3BMgonweVIJe+rcOLBnb2mi8D9HhRBLTS
	fd7AR0fcfLvedVP58m9cWvY2fEGdGeJCXIXNePo9q5EBoFZhR0mTdOlkYVMGD8uTPSnp9T02ASF
	q0UjGl/Z9HWqOq+7m30gmsEqd/qBfanLB/NVpatdfR/knjPZeVwp9NnZ/7xI3S3/uFZsqzveObl
	nSnjKk39ICBU0jp8YOp5Q5UfBhHviAAqFYIuptGZ+9IRVuMpA5/tLfWjCkzhFPnwY78uYI0C4NR
	RQY6g4XwJNOMGt3CCbZ5An9PXnSVEV6CeAUNF3KBmQCObS2bYEl3AKW/KyFf1QCo5CUyt9ZlEsM
	8CftINXaKfaVuMBZl7g0GBuNMoqpPCs=
X-Received: by 2002:a05:600d:8449:b0:4bb:5f07:10d7 with SMTP id 5b1f17b1804b1-4bb5f07134dmr146384475e9.26.1794843046610;
        Mon, 16 Nov 2026 07:30:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm315252695e9.11.2026.11.16.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:30:45 -0800 (PST)
Date: Mon, 16 Nov 2026 16:30:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: john.ogness@linutronix.de, rostedt@goodmis.org,
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/5] panic, sys_info: Fix duplicate and dropped
 all-CPU backtraces in panic
Message-ID: <avshouTNBIeM5qtP@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-2-atomlin@atomlin.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-2-atomlin@atomlin.com>

On Mon 2026-11-02 21:44:49, Aaron Tomlin wrote:
> When sys_info() was factored out of kernel/panic.c by
> commit b76e89e50fc3 ("panic: generalize panic_print's function to show
> sys info"), __sys_info() gained an unconditional call to
> trigger_all_cpu_backtrace() when SYS_INFO_ALL_BT is set, while
> panic_other_cpus_shutdown() retained its own call to
> panic_trigger_all_cpu_backtrace().
> 
> This causes two problems during a kernel panic:
> 
>     1.  vpanic() invokes panic_trigger_all_cpu_backtrace() inside
>         panic_other_cpus_shutdown() before stopping secondary CPUs, and
>         then invokes trigger_all_cpu_backtrace() a second time inside
>         sys_info(panic_print) after secondary CPUs have already been
>         shut down, stalling for up to 10 seconds waiting for offline
>         CPUs to respond to NMIs. Furthermore, if SYS_INFO_ALL_BT is
>         configured via the kernel.kernel_sys_info sysctl rather than
>         panic_print, panic_other_cpus_shutdown() misses it prior to CPU
>         shutdown.
> 
>     2.  If sys_info(SYS_INFO_ALL_BT) is invoked on the panicking CPU
>         prior to panic_other_cpus_shutdown(), calling
>         trigger_all_cpu_backtrace() directly bypasses
>         panic_trigger_all_cpu_backtrace() and leaves
>         panic_triggering_all_cpu_backtrace unset. Because panic_cpu is
>         already active, vprintk_emit() silently drops all NMI backtrace
>         messages originating from non-panic CPUs.
> 
> Export panic_trigger_all_cpu_backtrace() with a panic_on_this_cpu() and
> one-shot guard so all-CPU backtraces are only emitted once before
> secondary CPUs are stopped, consult sys_info_get_mask(panic_print) in
> panic_other_cpus_shutdown(), record prior Oops stack dumps in
> panic_try_start(), and route SYS_INFO_ALL_BT in __sys_info()
> through panic_trigger_all_cpu_backtrace() on the panicking CPU.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -451,13 +452,21 @@ bool panic_try_start(void)
>  	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
>  
> -	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> +	if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> +		return false;
> +
> +	if (atomic_read(&panic_redirect_cpu) == PANIC_CPU_INVALID &&
> +	    (test_taint(TAINT_DIE) || oops_in_progress))
> +		panic_this_cpu_backtrace_printed = true;

This would be pretty hard to maintain. The complexity of the check
shows how many code paths affect the decision. I can't imagine how
to synchonize all the pieces this way.

We need another approach. I remember that I have already proposed
something some time ago.

The idea was to enhance sys_info() API to remember what has already
been printed. trigger_all_cpu_backtrace() and frieds should
not longer be called directly. They should be called only via
sys_info() API.

See https://lore.kernel.org/all/aj5tFiwhRqPkAkqU@pathway.suse.cz/
for more details.

I think that this would be a better way to go.
What do you think, please?

Best Regards,
Petr
