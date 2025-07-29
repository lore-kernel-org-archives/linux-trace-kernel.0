Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53225771;
	Tue, 29 Jul 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781843; cv=none; b=Ce3smi0ZL+2QBa/aYUieD906dyEZAx4+oe106VPplDPDmdD+W6Hwiea2Rg6CErd6xxoPPm+frNfZ0Oyt8Fj8Q9LJHlQE/i8DhV0vG3dhiiuVyJgpjmJjG6mvTmdmFygIRevLWnDnkGK26mrgsNg7EfhZVCQqvW3lcgARPeMqVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781843; c=relaxed/simple;
	bh=lZ0AHVqB1QzMLMVmGFdBECLpNw4aLXTiDdM0Wq9t4es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mePdaF459rWHQokNyOdEn6nmsdZOUI3xDDmhsWnWgYLEdQedMHLGm04QAwlQBuhWmJ0sxi8pjyaUsMJ/yHNtgFrn0eSfMqImuwy1mFnccwztcQd+2BIsCF9WrlGF+4iEeyE/4Y8Yvv7bQJBpGAoNwWvz9OtvWBBlXXAWYn8U5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhvSGpr4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydXDh17l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhvSGpr4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydXDh17l"
Date: Tue, 29 Jul 2025 11:37:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753781838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij+xa7oEKZkTb8e6artpCZaauM3myIyDtaaIfBRouzc=;
	b=RhvSGpr4kgAhsRTiZdRPHNJaxFVzQmlLNL5HBT2bBevMZ6ny0sEQSphagjr45ABAXSP0Qo
	vxbnWWz/fuRRTNMW4S7i5j/WqPQGQzejRMyVLlqbWau5L1nl4tvMbSp66p6e4lEovOp01n
	UCks8bQVS43zXZLPoce+rmKE8o2WvtSSxc36PjHw2b51v064xCqueKLA2xnS9J1GV34QPo
	KniY1fvDQZEViqSq6k+x6FygFEf9ryIblnQoLeLODQWJrFwmftfOfHKbagmH3fuKu71dly
	2RkCP3T28O+/+9cUSBA9G5JbuGfIG2dDuqKWuh4/bRFXwlVdN1Sd+7+OVhEGeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753781838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij+xa7oEKZkTb8e6artpCZaauM3myIyDtaaIfBRouzc=;
	b=ydXDh17lsoUiyZGwA6GGTf2Zvl+pX5IVe2MU3FULJMqCa0mUzgSjgJOavaBBded0AN07vZ
	AwSoxO46jFnzd5DQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250729093717.3AqIu_f0@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
 <20250729092510._Hq3RWF_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729092510._Hq3RWF_@linutronix.de>

On Tue, Jul 29, 2025 at 11:25:12AM +0200, Nam Cao wrote:
> On Tue, Jul 29, 2025 at 10:46:51AM +0200, Gabriele Monaco wrote:
> > On Mon, 2025-07-28 at 17:53 +0200, Nam Cao wrote:
> > > I gave this a try on riscv64 and observed some errors:
> > > 
> > > [  620.696055] rv: monitor sts does not allow event sched_switch on
> > > state enable_to_exit
> > > [  621.047705] rv: monitor sts does not allow event sched_switch on
> > > state enable_to_exit
> > > [  642.440209] rv: monitor sts does not allow event sched_switch on
> > > state enable_to_exit
> > > 
> > > I tested with two user programs:
> > > 
> > >     int main() { asm ("unimp"); }
> > >     int main() { asm ("ebreak"); }
> > > 
> > > The two programs are repeatedly executed:
> > > 
> > >     #!/bin/bash
> > >     ./test1 &
> > >     ./test2 &
> > >     # ... repeat lots of time
> > > 
> > > Any idea?
> > 
> > Mmh I see what you're doing here..
> > Those instructions are supposed to raise some sort of exception in the
> > CPU which apparently disables and enables interrupts without raising an
> > interrupt handler tracepoint (the discriminator for this monitor).
> > This lets the monitor believe we passed the time a switch is possible
> > and complain when it actually sees one.
> > 
> > I still couldn't reproduce it on my VM, yet I find the timing a bit
> > strange: it's alright we handle the illegal instruction like this, but
> > do we really end up doing that while scheduling although it doesn't
> > look like an interrupt?!
> > 
> > Could you share a bit more about your riscv setup? It might some
> > configuration/hardware specific thing.
> 
> Kernel:
>   - base: ftrace/for-next
>   - config: defconfig + mod2noconfig + PREEMPT_RT + monitors
> 
> Hardware:
> 	qemu-system-riscv64 -machine virt \
> 	-kernel ../linux/arch/riscv/boot/Image \
> 	-append "console=ttyS0 root=/dev/vda rw" \
> 	-nographic \
> 	-drive if=virtio,format=raw,file=riscv64.img \
> 	-smp 4 -m 4G
> 
> 	riscv64.img is a Debian trixie image from debootstrap
> 
> Test:
> 	echo 0 > /proc/sys/debug/exception-trace
> 	./testall # see attached

I should note that this takes a few tries before something shows up.

Below is the backtrace, in case it helps:

illegal    3246 [000]  1020.132675: rv:error_sts: event sched_switch not expected in the state enable_to_exit
        ffffffff8013231c __traceiter_error_sts+0x28 ([kernel.kallsyms])
        ffffffff8013231c __traceiter_error_sts+0x28 ([kernel.kallsyms])
        ffffffff80138aa4 da_event_sts+0x198 ([kernel.kallsyms])
        ffffffff80138cf0 handle_sched_switch+0x46 ([kernel.kallsyms])
        ffffffff80aaf222 __schedule+0x4ba ([kernel.kallsyms])
        ffffffff80aafb80 preempt_schedule_irq+0x32 ([kernel.kallsyms])
        ffffffff80aac714 irqentry_exit+0x76 ([kernel.kallsyms])
        ffffffff80aac1dc do_irq+0x38 ([kernel.kallsyms])
        ffffffff80ab7da6 __lock_text_end+0x12e ([kernel.kallsyms])
        ffffffff80a93e50 mas_find+0x0 ([kernel.kallsyms])
        ffffffff8021ea60 vms_clear_ptes+0xe8 ([kernel.kallsyms])
        ffffffff8021f81a vms_complete_munmap_vmas+0x58 ([kernel.kallsyms])
        ffffffff80220706 do_vmi_align_munmap+0x15c ([kernel.kallsyms])
        ffffffff802207d0 do_vmi_munmap+0xa6 ([kernel.kallsyms])
        ffffffff80221f3c __vm_munmap+0xa2 ([kernel.kallsyms])
        ffffffff8020be7c vm_munmap+0xe ([kernel.kallsyms])
        ffffffff802bbdbe elf_load+0x14c ([kernel.kallsyms])
        ffffffff802bc1f4 load_elf_binary+0x36e ([kernel.kallsyms])
        ffffffff80264426 bprm_execve+0x254 ([kernel.kallsyms])
        ffffffff8026570c do_execveat_common.isra.0+0x11e ([kernel.kallsyms])
        ffffffff802664de __riscv_sys_execve+0x32 ([kernel.kallsyms])
        ffffffff80aabf84 do_trap_ecall_u+0x1bc ([kernel.kallsyms])
        ffffffff80ab7dc8 __lock_text_end+0x150 ([kernel.kallsyms])
