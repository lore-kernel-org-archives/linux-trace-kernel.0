Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DF1F3B87
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925245; cv=none; b=A7GDC28BHduncoUNauRK6ilGzIXwKfCi7SUUTzU3rprpepIqhvOhy6Jgt7VigdQDHXmqD5SovXpJKTRl5GaWfY+bqrUZOsGUKJnvl0uV/Xwf6hWd4PnQw7vyIu0dzTSzLTYR7t5qxDUviXqzml2ZpHMKtC5Ey0ukWJe1o4obW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925245; c=relaxed/simple;
	bh=CwgHrpQttJ9JEif/wCfZWfWACrIIISVZ0PQBMV+bREA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvOrXdmc2hHjp5BPbZDWQnwR6YbBi8y9i2bKbwpGT8SQXiQY8INkN9sNZqW28B4wZS68PD/dwVX8I04ngl3DKJ0z2MExsMoiPrHruHz3EDYKqQAiKmrDEFAMgSx4L9LDwR51FX/14Bxy3z4xR1/Ao3M3vryOLRoCUkiXeWII5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQYU7e/J; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQYU7e/J"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so639390a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762925242; x=1763530042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCo98k5zVGcrJMaFgGPWpScUCs9iIxNEITQOsVqAKIo=;
        b=aQYU7e/Jj+pjc7T9IOjCFn7lDzn3Dgs9gou/855HzmcAChrQcOB1U/amdNVscpXywS
         8tw8YurZh62DxviWXJ+158ESkoX9eowl/kCYgmQDrQ5pHY1j346+BmijVErQ9Onw0HCL
         XQpzt5QMZ5fN8oUXcxdE17IVm5JIKk9VA3boAn08vNkvMNV8F8av+rQQJZjNB39O0YJY
         Ix8blMjV5FUdDCuOmDx5iqek6PPhBAxZt7/jJhCHlHLNnBv+We3/ub1v1k48HNNBbhh8
         LlwLHtUuCpp2DDc0M0uiRDu5yQak9ri79qId8bqQBbpcmCXj+0bAjDUopBOr8yjNWPjx
         ME2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762925242; x=1763530042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCo98k5zVGcrJMaFgGPWpScUCs9iIxNEITQOsVqAKIo=;
        b=cSKzDEVmhF2/HHtykmBZh8IBFduQOrjBNtmIYaOT5cA1aW9stxmiU5Te+hX2k1b866
         W01x8wxWalP0uDfx4Mpw0zxYyFvFRcXHBAwGLeQ8WwszmyofJJf0NCs79soEtDMN48xH
         rURd/ACiuGaPDvxDwo6eN/da/Lqt0Pcd7ns9oVjQgsyRwhdikx+Xql+mvMEKCpNhNx0D
         8aEoQBDL9jQ1anzywV9+6d/zKJhWcBRL/AYwdP06V3YiuP3mffsQl6Vurg1BwHeMzwV8
         /9s1xf9qey078PpB4Xre0QxXKt/XlrDyDQXYgrPIv03rQ9we+OlOwoJE6YXdikmm1kyo
         5WPg==
X-Forwarded-Encrypted: i=1; AJvYcCXN7PZBt+Y9sg4jkgVb1HZNV2RyCB4UeHtzJCwiY51WQMa4M+I+Ln+lcsRascKXjWJLWPfLIU614aQwNQ/7r6giByQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqctNLyObCC99SKnvIvN+vJkYg4QGPxHCi+o7cJLfR+cx/kIh
	CueK+zmwZzXCMkkySoeKgZKTEhfeAGCXPTosr7MLjvnuvGlUYXxHqJZqvRZGH8sgHJzH83yv9fY
	TaxF8yRvsB79Ty08Nlt38vG+m3qYxebc=
X-Gm-Gg: ASbGncvL1R0aM+pTBYvep9A9vmTYvmER2v5ukQyi0XXls27s8KEm38RuOJ7t6Wn+3sw
	udJkcaG1pHTvX8mqrBBlvpe3KFl8f2NYrvTlWqRkOECvDbLqlYPpymGG+wMIscLOr1qC21HWt4F
	1PTo7oVUClVsgjV/ZLe0u3gQp8zubzJQhEmSGc/sgk22kev5D5alridS0kSXOaig4+FTkzmR0S7
	NHhmtJ9HuDTXdqe7MsGwimJv6R546cj96Py5U4Zd4vwSpxxyzmncnXvtrP1
X-Google-Smtp-Source: AGHT+IFTh1AedixfwUaVcieQDb69lpIZKCzgYFFppt1bkt2eJhfVvzZzY1/8j+gyAXu2Ck/cIyuG9vJylgn49QZX6mk=
X-Received: by 2002:a17:907:6d0d:b0:b70:b5b9:1f82 with SMTP id
 a640c23a62f3a-b7331a6ef31mr189013366b.31.1762925241289; Tue, 11 Nov 2025
 21:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015114952.4014352-1-leonylgao@gmail.com> <20251110183854.48b33b50@gandalf.local.home>
 <20251111081314.j8CFfAD6@linutronix.de> <20251111102739.2a0a64cf@gandalf.local.home>
In-Reply-To: <20251111102739.2a0a64cf@gandalf.local.home>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Wed, 12 Nov 2025 13:27:10 +0800
X-Gm-Features: AWmQ_bmnu2v8TbyZK6CGcTDW02AMhsuIyjYsDXPPjpZO667gKjMESzrWwoQr1Bw
Message-ID: <CAJxhyqDCFRT_fPWHb67x-PUu+Om91UrbrQEifcF7m+dkZ35dqA@mail.gmail.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>, 
	Huang Cun <cunhuang@tencent.com>, frankjpliu@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thank you for your detailed response and the proposed RCU-like approach.

I've looked into using a regular seqlock instead of the current
implementation, but as you pointed out, the write side is indeed a
critical path. More importantly, I found that even with seqlock, the
write_seqlock() function internally uses spin_lock() which on
PREEMPT_RT gets converted to an mutex. This would cause the same
issues we're trying to avoid - potential sleep in atomic contexts.

bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pi=
d)
{
    union upper_chunk *upper_chunk;
    union lower_chunk *lower_chunk;
    unsigned int seq;
    unsigned long flags;
    unsigned int upper1;
    unsigned int upper2;
    unsigned int lower;
    bool ret =3D false;

    if (!pid_list)
        return false;

    if (pid_split(pid, &upper1, &upper2, &lower) < 0)
        return false;

    do {
        local_irq_save(flags);
        seq =3D read_seqbegin(&pid_list->lock);
        ret =3D false;
        upper_chunk =3D pid_list->upper[upper1];
        if (upper_chunk) {
            lower_chunk =3D upper_chunk->data[upper2];
            if (lower_chunk)
                ret =3D test_bit(lower, lower_chunk->data);
        }
        local_irq_restore(flags);
    } while (read_seqretry(&pid_list->lock, seq));

    return ret;
}

 BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 192, name: bash
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 CPU: 3 UID: 0 PID: 192 Comm: bash Not tainted 6.18.0-rc5+ #84 PREEMPT_{RT,=
LAZY}
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4f/0x70
  __might_resched+0x113/0x160
  rt_spin_lock+0x41/0x130
  trace_pid_list_set+0x52/0x150
  ftrace_pid_follow_sched_process_fork+0x19/0x30
  kernel_clone+0x1b8/0x3e0
  __do_sys_clone+0x65/0x90
  do_syscall_64+0x48/0xa60
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Your proposed solution using atomic counters and memory barriers
should provide the lock-free read path we need while maintaining code
correctness. However, to achieve this correctly requires careful
consideration of all memory ordering scenarios, and I'm concerned
about introducing subtle bugs given the complexity.

Would you be willing to submit a patch implementing your approach?

On Tue, Nov 11, 2025 at 11:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 11 Nov 2025 09:13:14 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
> > Nope, no read-write lock that can be used in atomic sections. Well,
> > there is RCU.
>
> Well, it can't simply be replaced by RCU as the write side is also a
> critical path. It happens when new tasks are spawned.
>
> Now we could possibly do some RCU like magic, and remove the lock in the
> read, but it would need some care with the writes.
>
> Something like this (untested):
>
> bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int =
pid)
> {
>         union upper_chunk *upper_chunk;
>         union lower_chunk *lower_chunk;
>         unsigned long flags;
>         unsigned int upper1;
>         unsigned int upper2;
>         unsigned int lower;
>         bool ret =3D false;
>
>         if (!pid_list)
>                 return false;
>
>         if (pid_split(pid, &upper1, &upper2, &lower) < 0)
>                 return false;
>
>         upper_chunk =3D READ_ONCE(pid_list->upper[upper1]);
>         if (upper_chunk) {
>                 lower_chunk =3D READ_ONCE(upper_chunk->data[upper2]);
>                 if (lower_chunk)
>                         ret =3D test_bit(lower, lower_chunk->data);
>         }
>
>         return ret;
> }
>
> Now when all the bits of a chunk is cleared, it goes to a free-list. And
> when a new chunk is needed, it acquires it from that free-list. We need t=
o
> make sure that the chunk acquired in the read hasn't gone through the
> free-list.
>
> Now we could have an atomic counter in the pid_list and make this more of=
 a
> seqcount? That is, have the counter updated when a chunk goes to the free
> list and also when it is taken from the free list. We could then make thi=
s:
>
>  again:
>         counter =3D atomic_read(&pid_list->counter);
>         smp_rmb();
>         upper_chunk =3D READ_ONCE(pid_list->upper[upper1]);
>         if (upper_chunk) {
>                 lower_chunk =3D READ_ONCE(upper_chunk->data[upper2]);
>                 if (lower_chunk) {
>                         ret =3D test_bit(lower, lower_chunk->data);
>                         smp_rmb();
>                         if (unlikely(counter !=3D atomic_read(&pid_list->=
counter))) {
>                                 ret =3D false;
>                                 goto again;
>                         }
>                 }
>         }
>
>
> And in the set we need:
>
>         upper_chunk =3D pid_list->upper[upper1];
>         if (!upper_chunk) {
>                 upper_chunk =3D get_upper_chunk(pid_list);
>                 if (!upper_chunk) {
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
>                 atomic_inc(&pid_list->counter);
>                 smp_wmb();
>                 WRITE_ONCE(pid_list->upper[upper1], upper_chunk);
>         }
>         lower_chunk =3D upper_chunk->data[upper2];
>         if (!lower_chunk) {
>                 lower_chunk =3D get_lower_chunk(pid_list);
>                 if (!lower_chunk) {
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
>                 atomic_inc(&pid_list->counter);
>                 smp_wmb();
>                 WRITE_ONCE(upper_chunk->data[upper2], lower_chunk);
>         }
>
> and in the clear:
>
>         if (find_first_bit(lower_chunk->data, LOWER_MAX) >=3D LOWER_MAX) =
{
>                 put_lower_chunk(pid_list, lower_chunk);
>                 WRITE_ONCE(upper_chunk->data[upper2], NULL);
>                 smp_wmb();
>                 atomic_inc(&pid_list->counter);
>                 if (upper_empty(upper_chunk)) {
>                         put_upper_chunk(pid_list, upper_chunk);
>                         WRITE_ONCE(pid_list->upper[upper1], NULL);
>                         smp_wmb();
>                         atomic_inc(&pid_list->counter);
>                 }
>         }
>
> That is, the counter gets updated after setting the chunk to NULL and
> before assigning it a new value. And reading it, the counter is read befo=
re
> looking at any of the chunks, and tested after getting the result. If the
> value is the same, then the chunks are for the correct PID and haven't
> swapped in a free/alloc swap where it's looking at a chunk for a differen=
t
> PID.
>
> This would allow for the read to not take any locks.
>
> -- Steve
