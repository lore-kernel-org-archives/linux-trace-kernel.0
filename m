Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86035382395;
	Thu, 30 Jul 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384636; cv=none; b=QJBJD57m9DyY/wMjf/+MBsd0JPXEDtZy+QA3CV4SZhXGwQ3S3FJJaVwqeXdOSOGusQC5m4VvO3k4tdf/9k/MYfIXBt4tXVdOqLW0WdAcF/9HUe/o/y76mYZ2lxKcO5skdk0YfIF8P79oaVF6m7w1r4WP+9qF+N7+YZNMLY6NqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384636; c=relaxed/simple;
	bh=2N+Gw5yHKzsMEdolQPVPZoi+/0vDK4MBOqm0F1c+CX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siQt6YQNndZEWKwDcX6tdW6UYpwev5SL/WxD3x1PShHUjKO9bcTwQffXUEfh38yXxM3Ll5oKJo7NMYgw/Oka9SyltyHH0gLn7NpEA3nvbMd9YGCRvgsLtWdm0fJiWn/NP2kD8cMKAju2htD1DxJ8PimmUt0dhG3jLAaM9Mi5P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h9bLr1r0vzYQtrW;
	Thu, 30 Jul 2026 12:09:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6102B40539;
	Thu, 30 Jul 2026 12:10:22 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBXwIeqzmpqDNrPAQ--.7066S2;
	Thu, 30 Jul 2026 12:10:20 +0800 (CST)
Message-ID: <4812557d-3718-4bf5-8be1-c12d6da614ad@huaweicloud.com>
Date: Thu, 30 Jul 2026 12:10:18 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/snapshot: Avoid CPU buffer swap during
 reserve/commit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730011912.2325121-1-wutengda@huaweicloud.com>
 <20260729220448.13d19821@robin>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260729220448.13d19821@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXwIeqzmpqDNrPAQ--.7066S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4xJr15Jr4rXF43tFWxCrg_yoW3WF4rpr
	43Kr4Ykr4vqF1xAw4xAF4UZFyjvFsruF47ur4xJryvva1UWrn7Wry7Kr4akryDCrZ2vw17
	JFyUWw18Ka4jkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/30 10:04, Steven Rostedt wrote:
> On Thu, 30 Jul 2026 01:19:12 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> Commit 3163f635b20e ("tracing: Fix race issue between cpu buffer write
>> and swap") fixed most of the race conditions between snapshot's
>> ring_buffer_swap_cpu and ring_buffer_lock_{reserve, commit}. It achieved
>> this by replacing the asynchronous swap with smp_call_function_single to
>> trigger an interrupt on the target CPU to handle the swap.
> 
> I'm curious. How did you discover this race?
> 

Just run the POC provided in commit 3163f635b20e [1] day after day, and
the issue occurs. The call trace points out that the problem happens when
tracing the function:

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3163f635b20e9e1fb4659e74f47918c9dddfe64e

[   55.864661] ------------[ cut here ]------------
[   55.865536] WARNING: CPU: 0 PID: 1451 at kernel/trace/ring_buffer.c:3096 rb_commit.constprop.0+0x367/0x820
[   55.866993] Modules linked in: binfmt_misc rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[   55.869583] CPU: 0 PID: 1451 Comm: DTS202602110403 Not tainted 5.10.0+ #1
[   55.871729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   55.874671] RIP: 0010:rb_commit.constprop.0+0x367/0x820
[   55.871729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/0
1/2014
[   55.874671] RIP: 0010:rb_commit.constprop.0+0x367/0x820
[   55.875637] Code: 8d 7f 10 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 af 03 00 00 49 8b 5f 10 be 04 00 00 00 48 8d 7b 08 e8 dd a0 41 00 f0 ff 43 08 <0f> 0b 48 83 c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 54 58 2e 02 be
[   55.878367] RSP: 0018:ffffc90000b57a30 EFLAGS: 00010202
[   55.879227] RAX: 0000000000000001 RBX: ffff88800105ec00 RCX: ffffffff9e11db33
[   55.880366] RDX: ffffed100020bd82 RSI: 0000000000000004 RDI: ffff88800105ec08
[   55.881470] RBP: ffff88800105ec00 R08: 0000000000000001 R09: ffff88800105ec0b
[   55.882563] R10: ffffed100020bd81 R11: 0000000000000001 R12: ffff8880010520a0
[   55.883681] R13: ffff88800105ec40 R14: 0000000000000000 R15: ffff888001052000
[   55.884761] FS:  00007f6be3c5d740(0000) GS:ffff888065200000(0000) knlGS:0000000000000000
[   55.885980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.886876] CR2: 000055d8257879e0 CR3: 0000000005c78003 CR4: 0000000000770ef0
[   55.887994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.889113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.890232] PKRU: 55555554
[   55.890740] Call Trace:
[   55.891221]  ? s_show+0x2f0/0x2f0
[   55.891815]  ? kallsyms_lookup_size_offset+0x130/0x130
[   55.892684]  ring_buffer_unlock_commit+0x68/0x510
[   55.893490]  ? kallsyms_lookup_size_offset+0x130/0x130
[   55.894341]  ? seq_print_sym+0x13d/0x1a0
[   55.895024]  function_trace_call+0x266/0x370
[   55.895754]  ? ring_buffer_iter_advance+0x2f/0x80
[   55.896584]  0xffffffffc037406a
[   55.897180]  ? ring_buffer_iter_advance+0x2f/0x80
[   55.897966]  ? kallsyms_lookup+0x5/0x260
[   55.898640]  ? _raw_write_unlock_irqrestore+0x60/0x60
[   55.899481]  kallsyms_lookup+0x5/0x260

The vmcore indicates that the buffer in CPU 0 was swapped:

* array_buffer->buffers:

  cpu 0, ffff888001052000, committing = 0, entries = 10010687, commits = 10010686
  cpu 1, ffff888001fa4400, committing = 0, entries = 18780536, commits = 18780536
  cpu 2, ffff888100110400, committing = 0, entries = 20905896, commits = 20905896
  cpu 3, ffff888100111c00, committing = 0, entries = 20825484, commits = 20825484

* max_buffer->buffers:

  cpu 0, ffff888001052400, committing = 1, entries = 9768877, commits = 9768878
  cpu 1, ffff888001fa6400, committing = 0, entries = 0, commits = 0
  cpu 2, ffff888100112400, committing = 0, entries = 0, commits = 0
  cpu 3, ffff888100112800, committing = 0, entries = 0, commits = 0

We first checked if the problem could occur before rb_start_commit, but we
just couldn't get past the 'READ_ONCE(cpu_buffer->buffer) != buffer' check.
So we turned our attention to what happens after rb_start_commit, to see
if the committing counter might drop to 0 and then get incremented again.
In the end, we found that only rb_move_tail could cause this.

Honestly, it was a pretty tough journey.

>>
>> However, this interrupt can still break in at any point during
>> ring_buffer_lock_{reserve, commit}. Currently, ring_buffer_swap_cpu()
>> relies on a cooperative check where cpu_buffer->committing is combined
>> with a condition in rb_reserve_next_event() that verifies if
>> READ_ONCE(cpu_buffer->buffer) != buffer to ensure state consistency. In
>> principle, once the execution passes this conditional check, no issues
>> should arise as long as cpu_buffer->committing remains non-zero.
>> Unfortunately, there is a window where cpu_buffer->committing can drop
>> to zero, which subsequently triggers a warning during rb_commit:
>>
>>     ring_buffer_lock_reserve
>>         cpu_buffer = buffer->buffers[cpu];       // cpu_buffer_a
>>         rb_reserve_next_event
>>             rb_start_commit // inc committing
>>             if (unlikely(READ_ONCE(cpu_buffer->buffer) != buffer)) {...}
>>             __rb_reserve_next
>>                 rb_move_tail
>>                     rb_end_commit(cpu_buffer);   // dec committing => 0
>>                     /* smp_call interrupt hits here, successfully swaps! */
>>                     local_inc(&cpu_buffer->committing);
>>
>>     ring_buffer_unlock_commit
>>         cpu_buffer = buffer->buffers[cpu];      // cpu_buffer_b
>>         rb_commit
>>             rb_end_commit
>>             RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing))
>>                                                 // triggers warning
>>
>> Instead of maintaining fragile complexity to allow the swap to intervene at
>> arbitrary points, simply replace smp_call_function_single with work_on_cpu.
>> This ensures the swap operation runs in a process context on the target
>> CPU, guaranteeing it only executes after ring_buffer_lock_{reserve, commit}
>> has fully completed.
> 
> No this is not the answer. The issue is with the ring buffer swap code
> but you band-aid in with a fix to the user of the code. The fix needs
> to stay with the ring buffer. Yes that means it needs to handle the
> case where an interrupt comes in at a page swap.
> 
> It needs to find another way to know that it's in the middle of that
> swap, and return an -EBUSY from the interrupt.
> 
> -- Steve

The work_on_cpu approach does not fix the issue inside the ring buffer
itself. However, as far as the current codebase is concerned, the
snapshot operation is the only path that triggers a CPU buffer swap.
This fix has minimal impact and does not expose users to the internal
intermediate state of the ring buffer when they echo to snapshot, thus
avoiding the confusion of hitting an -EBUSY error.

If we were to fix this from within the ring buffer, we might need to
introduce a new flag (e.g., a local_t variable similar to committing)
to detect such race windows. Based on the current analysis, this race
only occurs during a very brief window in rb_move_tail. Adding a new
flag for this seems unnecessary.

Alternatively, we could simply remove both rb_end_commit(cpu_buffer)
and local_inc(&cpu_buffer->committing) inside rb_move_tail, thereby
eliminating the 1-0-1 transition of committing and preventing such a
race window from existing in the first place. In principle, committing
should remain non-zero from the moment rb_start_commit is called until
the commit is finished.

Thanks,
Tengda

