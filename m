Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293129;
	b=bTk3jjidYTT3znib6uiyDw4yZizJ6q4uDNuTXLDzoFyulEPkQZPCpYxQU6KshQbM8gYd
	 XUDJny6fT5+ve3Fnl6HbMde3M3NEo6a+YIU8CJOAr+7r3r1kP1WTxAqkdzdGof1Vd0ZUa
	 qAAYrpZ291VGKQ2hqIpPPfEGeCeiSaL7j8UPGn5pxk13TCVXagt0uxoXusRqWpOUFWYF+
	 YVq+52PkUB3TgvR3t10EdcI612DIkd4lCV2STUGscLUBG5dYuasUaTwYo8NrrsMo56GnI
	 nFkRgsTA1DbbTnMxglEvB1EmvI+wNi6M6HUPRl33Rz7fcZTfjyNjbpW5TlGd6EM6z9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293129;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=zWbrffbK2ezJuYqmT2VVu4kuubCH5WGTAKTy2AnfvOQ=;
	b=UexByGuRL3SbahCgnBlRTdT3lb5Z6oMkEuigI4fv1tidbh9Y6jwo23EGTppB9Sp0/Xm+
	 SRjVB2FSvNavo+yO6RS+wOL5b1vNx73Y189/X4VzKO1NMUIelW/URbkc6WsadbQ972dWq
	 ltf0ydDd3hFe7EQbaKwMbljwvDFrCuV+ge0gMXlFOUEtIo6oEtnd/dR7Ot8PUsQMfnBOg
	 6Xi0VoS6oFYhU+YCvF8HQxB7Wm2tK9e2Vy9m/DuxkN410ZQuDaYts/6la5Px2dQjcBzw5
	 fs4pr/0ZBG9v55CYqc8ozJO99yocOl73B+oPIkGK27xMJssaXorco4gedcgjrIwI6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SlMldNAO;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034A606CB17
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 06:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0034A606CB17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SlMldNAO
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2BFD51208B5;
	Tue, 10 Nov 2026 06:45:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 4DE692002C;
	Tue, 10 Nov 2026 06:45:18 +0000 (UTC)
Date: Tue, 10 Nov 2026 01:45:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Haoli Zhang"
 <26031212468@stu.xidian.edu.cn>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: ring_buffer: wait for writers before removing
 pages
Message-ID: <20261110014511.6e724f4f@fedora>
In-Reply-To: <sashiko-outbox-206337@kernel.org>
References: <20261110045850.2786-1-26031212468@stu.xidian.edu.cn>
	<sashiko-outbox-206337@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6ox6haocbta5nbke7wa5pb89ktdxp6dg
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4DE692002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/COKrdZA1V9yLguhOCHo/y2Jw3DiulTmo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=zWbrffbK2ezJuYqmT2VVu4kuubCH5WGTAKTy2AnfvOQ=; b=SlMldNAOeS49J621qVqE10axFJjonZP7ucA9o8hoIE4bnVy9koyVyF2KmPUeo6BzQoH2w+2U4S/YUEj+LSyGncJEqVRlAZVe0NN0UN2NAnhb5+q3Wl/zYFFYEYvGT8buKC/6SP+5vXdlItjxHnI289RvfRqjCa2x+MrJYgr6IBo=
X-HE-Tag: 1794293118-24425
X-HE-Meta: U2FsdGVkX18AnirAGflLCZQzo94O2KKAshkt4Q0FTjILxQHoWGPR9+Hbqm9yCQ/+PVZ5evyZm1ppicKpvOctG8l8TkHU3UKlxAqbY044Uty9nz/TEvJcw9EStAuhaGNV+rGYUzn1Jj0ig84/wUDDx2Rf0YZGlZwgpY2KEjl3AiJs0KS5P50OLOWk1EWPe5Cfq6GiW0Y/Q9fEaRYWp5kNrpVEX7ZYIyuXe7OLf6Cw0DiMWT0AzPtWOTQXtzrAJVHzS6k8tlgFDsgcEghqgQXXBO7xxSeatC9HWoq8kXPYuQ9bo/g32rRoxyCeUXidEroJ8JR8V6LQZf93g35u77MNnO9iK65hzYFfYbwzXv5gN4tcWknvdlCjRIAqbuELa6+YNmdgOhEU/uosGpQo0IRjghvwXGhqHHiCaVrTHcvhoQCgYEgJz/thN1EsBiqsDIY7WRCm7bIUvfShchEqEuBqWg==

On Tue, 10 Nov 2026 05:44:54 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] tracing: ring_buffer: ineffective synchronize_rcu() in
>   rb_remove_pages()
> - [Low] tracing: ring_buffer: missing Fixes trailer for
>   rb_remove_pages() fix
> --
> 
> commit 47d13d1f3cd83bf8e86c2d2c4091f144764c4470
> Author: Haoli Zhang <26031212468@stu.xidian.edu.cn>
> 
> > tracing: ring_buffer: wait for writers before removing pages
> >
> > A writer can still be using the ring buffer page list when a concurrent
> > resize removes and frees pages. Disabling recording prevents new writers
> > from entering, but it does not wait for writers that are already in the
> > reserve/commit path. The reader lock protects reader-side page operations
> > and does not provide that writer-side synchronization.
> >
> > Disable recording before waiting for a grace period, then wait for
> > pre-existing writers to finish before taking the reader lock and changing
> > the page list. Keep recording disabled until after the page list has been
> > updated and the reader lock has been released. The removed pages are
> > unlinked and subsequently freed.
> >
> > This adds a grace-period wait to the resize path; it does not add
> > synchronization to the normal ring-buffer write path.
> >
> > Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=37e1793bdb0061ea3a47
> > Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> > Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> > Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> > Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> > Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>  
> 
> [Severity: Low]
> This is a bug fix for rb_remove_pages().  Should it include:
> 
>   Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atomic")
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index e760d2fe386fb..7ec0e12493f52 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3080,8 +3080,11 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
> >  
> >  	head_bit = 0;
> >  
> > -	raw_spin_lock_irq(&cpu_buffer->reader_lock);
> >  	atomic_inc(&cpu_buffer->record_disabled);
> > +	/* Wait for in-flight writers to finish before unlinking pages. */
> > +	synchronize_rcu();
> > +
> > +	raw_spin_lock_irq(&cpu_buffer->reader_lock);  
> 
> [Severity: Medium]
> Can any writer on cpu_buffer actually be in flight when rb_remove_pages()
> reaches synchronize_rcu()?
> 
> ring_buffer_lock_reserve() and ring_buffer_write() disable preemption with
> preempt_disable_notrace() across the entire reserve/commit path and only
> write to the local CPU's cpu_buffer.  Meanwhile, ring_buffer_resize() only
> runs rb_update_pages() -> rb_remove_pages() in task context on the target
> CPU itself (via schedule_work_on() or directly under migrate_disable()) or
> while the CPU is offline under cpus_read_lock():
> 
> kernel/trace/ring_buffer.c:ring_buffer_resize() {
>     ...
> 			if (!cpu_online(cpu)) {
> 				rb_update_pages(cpu_buffer);
> 				cpu_buffer->nr_pages_to_update = 0;
> 			} else {
> 				/* Run directly if possible. */
> 				migrate_disable();
> 				if (cpu != smp_processor_id()) {
> 					migrate_enable();
> 					schedule_work_on(cpu,
> 							 &cpu_buffer->update_pages_work);
> 				} else {
> 					update_pages_handler(&cpu_buffer->update_pages_work);
> 					migrate_enable();
> 				}
> 			}
>     ...
> }
> 
> Because rb_remove_pages() runs in task context on cpu_buffer->cpu, no
> task-context writer on that CPU can be inside its preempt-disabled
> reserve/commit section, and any interrupting softirq, hardirq, or NMI
> writer that started before atomic_inc(&cpu_buffer->record_disabled) has
> already finished before returning to task context.
> 
> Calling synchronize_rcu() here therefore does not wait for any writer.
> Instead, it stalls recording on cpu_buffer for an entire RCU grace period,
> blocks ring_buffer_resize() under migrate_disable() before scheduling work
> on remaining CPUs, and leaves the use-after-free unfixed when
> __rb_get_reader_page() leaves cpu_buffer->reader_page->list.prev pointing
> to a buffer_page that rb_remove_pages() subsequently unlinks and frees
> before a writer checks rb_is_reader_page() in rb_move_tail() or
> rb_set_commit_to_write().
> 

Exactly, this "fix" is bogus.

-- Steve


