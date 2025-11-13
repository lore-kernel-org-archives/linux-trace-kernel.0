Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C627F163;
	Thu, 13 Nov 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046317; cv=none; b=Xh6yjVmQvtSiHBI2yXscd6f1zZrbadvJ/kPpuiD5EbSZHso2BPszRWfa7tnPjVHuPaQ3H8vjERY4xNIxwg78CFJym0AnO2+bpAEO9LSYrSXouH3/feM6kA+3Gsm43SZ3japYtPYRRPTr6X01tn7Z4sRQZ4M7m2aQnRp81vfmCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046317; c=relaxed/simple;
	bh=nX0vwLr7NSPj3u4DRTbZ9f+IFX6p0EPvKktthwZzTog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rs/VeFTYLAZD5IQHozsam9YXJWScQeACrrC/kFVneqpQcEU5Nf5IUacP0a7BxkpzKgAVvmCm24E7JQ3deTOs4nBL9JvVmhAcU0ztdEVZW0MtIv7CaqhUN3oxk03O7TvHNZnnUpjJSeUCGJkG9sB3nyOJa2AfzSG9SyOvqAGi+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id ED66F1609FD;
	Thu, 13 Nov 2025 15:05:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id D0C022F;
	Thu, 13 Nov 2025 15:05:10 +0000 (UTC)
Date: Thu, 13 Nov 2025 10:05:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113100524.5c5f6bdc@gandalf.local.home>
In-Reply-To: <20251113141515.iZSIDK0T@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
	<20251113073420.yko6jYcI@linutronix.de>
	<CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
	<20251113141515.iZSIDK0T@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D0C022F
X-Stat-Signature: 5wcokhfhqgxxrxwjnxkqt8nkeooo7cyr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19oNHDBa3v7hySsWnATvUjZl+7gHbMyvNU=
X-HE-Tag: 1763046310-611143
X-HE-Meta: U2FsdGVkX1/MKhdmMk43l8/KYcCOgg00LqAPI4PyjzfdVglkOKcvCmC1IMrCbIgEzKdwyPHB7xxW3EDlbd3QmkNjwXXNt4qx1RQHr+DdonPpMZnKj1S15PEF14lQO6sRbrVDKgOBy///7jI824+Sn5wFRwdVZeiH0WoPl1Y1c9UfZQwa9ZjliI5qyTTWo8x6a07jkFkVONPuWs4EV0av23HyQzUnZ4eZ8xr/anZS0/aczFx0w4DWJBtRrFhurtbnUzXTTY1Pe3HeixDKhgd388OKKs6A4iEzoW5HjgfO6gGR4B1uDcB2IdY+X81L6J+G

On Thu, 13 Nov 2025 15:15:15 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I don't see why RCU work shouldn't work here.
> If a pid is removed then it might result that a chunk cleared/ removed
> then upper_chunk/ lower_chunk can become NULL. The buffer itself can be
> reused and point to something else. It could lear to a false outcome in
> test_bit(). This is handled by read_seqcount_retry().
> 
> You could assign upper1, upper2, to NULL/ buffer as now and the removal
> (in put_lower_chunk(), put_upper_chunk()) delay to RCU so it happens
> after the grace period. That would allow you to iterate over it in
> trace_pid_list_is_set() lockless since the buffer will not disappear and
> will not be reused for another task until after all reader left.

The chunks are reused. When they are cleared, they go to a free-list, and
when a new chunk is needed, it is taken from the free-list so that we do
not need to allocate.

When all the bits in a chunk are cleared it moves to the free-list. This
can happen in exit, when a task exits and it clears its pid bit from the
pid_list.

Then a chunk can be allocated in fork, when a task whose pid is in the
pid_list adds its child to the list as well.

This means that the chunks are not being freed and we can't be doing
synchronize_rcu() in every exit.

> 
> Additionally it would guarantee that the buffer is not released in
> trace_pid_list_free(). I don't see how the seqcount ensures that the
> buffer is not gone. I mean you could have a reader and the retry would
> force you to do another loop but before that happens you dereference the
> upper_chunk pointer which could be reused.

This protection has nothing to do with trace_pid_list_free(). In fact,
you'll notice that function doesn't even have any locking. That's because
the pid_list itself is removed from view and RCU synchronization happens
before that function is called.

The protection in trace_pid_list_is_set() is only to synchronize with the
adding and removing of the bits in the updates in exit and fork as well as
with the user manually writing into the set_*_pid files.

> 
> So I *think* the RCU approach should be doable and cover this.

Where would you put the synchronize_rcu()? In do_exit()?

Also understanding what this is used for helps in understanding the scope
of protection needed.

The pid_list is created when you add anything into one of the pid files in
tracefs. Let's use /sys/kernel/tracing/set_ftrace_pid:

  # cd /sys/kernel/tracing
  # echo $$ > set_ftrace_pid
  # echo 1 > options/function-fork
  # cat set_ftrace_pid
  2716
  2936
  # cat set_ftrace_pid
  2716
  2945

What the above did was to create a pid_list for the function tracer. I
added the bash process pid using $$ (2716). Then when I cat the file, it
showed the pid for the bash process as well as the pid for the cat process,
as the cat process is a child of the bash process. The function-fork option
means to add any child process to the set_ftrace_pid if the parent is
already in the list. It also means to remove the pid if a process in the
list exits.

When I enable function tracing, it will only trace the bash process and any
of its children:

 # echo 0 > tracing_on
 # echo function > current_tracer
 # cat set_ftrace_pid ; echo 0 > tracing_on
 2716
 2989
 # cat trace
[..]
            bash-2716    [003] ..... 36854.662833: rcu_read_lock_held <-mtree_range_walk
            bash-2716    [003] ..... 36854.662834: rcu_lockdep_current_cpu_online <-rcu_read_lock_held
            bash-2716    [003] ..... 36854.662834: rcu_read_lock_held <-vma_start_read
##### CPU 6 buffer started ####
             cat-2989    [006] d..2. 36854.662834: ret_from_fork <-ret_from_fork_asm
            bash-2716    [003] ..... 36854.662835: rcu_lockdep_current_cpu_online <-rcu_read_lock_held
             cat-2989    [006] d..2. 36854.662836: schedule_tail <-ret_from_fork
            bash-2716    [003] ..... 36854.662836: __rcu_read_unlock <-lock_vma_under_rcu
             cat-2989    [006] d..2. 36854.662836: finish_task_switch.isra.0 <-schedule_tail
            bash-2716    [003] ..... 36854.662836: handle_mm_fault <-do_user_addr_fault
[..]

It would be way too expensive to check the pid_list at *every* function
call. But luckily we don't have to. Instead, we set a per-cpu flag in the
instance trace_array on sched_switch if the next pid is in the pid_list and
clear it if it is not. (See ftrace_filter_pid_sched_switch_probe()).

This means, the bit being checked in the pid_list is always for a task that
is about to run.

The bit being cleared, is always for that task that is exiting (except for
the case of manual updates).

What we are protecting against is when one chunk is freed, but then
allocated again for a different set of PIDs. Where the reader has the chunk,
it was freed and re-allocated and the bit that is about to be checked
doesn't represent the bit it is checking for.

    CPU1					CPU2
    ----					----

 trace_pid_list_is_set() {
   lower_chunk = upper_chunk->data[upper2];

					do_exit() {
					  trace_pid_list_clear() {
					    lower_chunk = upper_chunk->data[upper2]; // same lower_chunk
					    clear_bit(lower, lower_chunk->data);
					    if (find_first_bit(lower_chunk->data, LOWER_MAX) >= LOWER_MAX)
					      put_lower_chunk(pid_list, lower_chunk);
					    [..]
					  }
					}

					fork() {
					  trace_pid_list_set() {
					    lower_chunk = get_lower_chunk(pid_list);
					    upper_chunk->data[upper2] = lower_chunk; // upper2 is a different value here
					    set_bit(lower, lower_chunk->data);
					  }
					}

   ret = test_bit(lower, lower_chunk->data);

And if the "lower" bit matches the set_bit from CPU2, we have a false
positive. Although, this race is highly unlikely, we should still protect
against it (it could happen on a VM vCPU that was preempted in
trace_pid_list_is_set()).

-- Steve
