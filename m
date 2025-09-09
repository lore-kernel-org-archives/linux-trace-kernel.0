Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6311E7C12;
	Tue,  9 Sep 2025 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383918; cv=none; b=ioG+KsylPvAoVajgk2aXmm7feaSOfYetTMvH8Yoh9TMqo7LbwiTULAIxhyu8h9uiJaHFc+BxX4CgkV6tW00pE62WrJnT4WrHlpBkP/37KaUzOvZSawOsW33A2umZC+YahvGa0mw6yM3i8xGD950jtgQH6nEXTR4ynBYEdW8AJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383918; c=relaxed/simple;
	bh=+Qb/DM0RRK6qZzxfU2ONA179La2VSxxhvYOCDG6wXyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFsDHlA0w3O9d/T5wFGiNjeM1p0j24w9yBNib27UvMLnsJQEbzQfgipQJw/qTUfnyKE7gykNU7b6E8zFpaXfmAqG0P2YeazVgn+Yy9vWN4OL56PJdH7Cu7RBNvzqvbRIkOps+a38RmDYJJ/zIo4sH9eQTaDBtVyuDW1+2fVEhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLS4R6n4dzKHLyk;
	Tue,  9 Sep 2025 10:11:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1CF651A1B05;
	Tue,  9 Sep 2025 10:11:52 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgBXoo7ljL9o1QmCBw--.23994S2;
	Tue, 09 Sep 2025 10:11:50 +0800 (CST)
Message-ID: <1347f753-f135-4c17-93b1-5a99f9299310@huaweicloud.com>
Date: Tue, 9 Sep 2025 10:11:48 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Silence warning when chunk allocation fails
 in trace_pid_write
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250908024658.2390398-1-pulehui@huaweicloud.com>
 <20250908150257.23731d24@gandalf.local.home>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20250908150257.23731d24@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXoo7ljL9o1QmCBw--.23994S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rKr43Xr47Xr1xAryfXrb_yoWrKF4kpF
	y5GFn7KF4rtF4jyF18WF1rWr18J398AFyxJr1xGw1rAFnFkr1jgr47GryUX3Z8JrWUJrya
	yr1qvw45Kr4jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2025/9/9 3:02, Steven Rostedt wrote:
> On Mon,  8 Sep 2025 02:46:58 +0000
> Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Syzkaller trigger a fault injection warning:
>>
>> WARNING: CPU: 1 PID: 12326 at tracepoint_add_func+0xbfc/0xeb0
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G U 6.14.0-rc5-syzkaller #0
>> Tainted: [U]=USER
>> Hardware name: Google Compute Engine/Google Compute Engine
>> RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
>> Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff
>> RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
>> RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
>> RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
>> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
>> R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
>> FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
>>   register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
>>   register_pid_events kernel/trace/trace_events.c:2354 [inline]
>>   event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
>>   vfs_write+0x24c/0x1150 fs/read_write.c:677
>>   ksys_write+0x12b/0x250 fs/read_write.c:731
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> We can reproduce the warning by following the steps below:
>> 1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
>>     and register sched_switch tracepoint.
>> 2. echo ' ' >> set_event_pid, and perform fault injection during chunk
>>     allocation of trace_pid_list_alloc. Let pid_list with no pid and
>> assign to tr->filtered_pids.
>> 3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
>>     tr->filtered_pids.
>> 4. echo 9 >> set_event_pid, will trigger the double register
>>     sched_switch tracepoint warning.
>>
>> The reason is that syzkaller injects a fault into the chunk allocation
>> in trace_pid_list_alloc, causing a failure in trace_pid_list_set, which
>> may trigger double register of the same tracepoint. This only occurs
>> when the system is about to crash, but to suppress this warning, let's
>> add failure handling logic to trace_pid_list_set.
>>
>> Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
>> Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
> 
> FYI, when sending a v2, please state below the three dashes what was
> changed since v1. Something like:
> 
> Changes since v1: https://lore.kernel.org/all/20250821071721.3609109-1-pulehui@huaweicloud.com/
> 
> - Instead of returning -EINVAL before trace_parser_load() have
>    trace_pid_write() return error when trace_pid_list_set() returns an error.
> 
> 
> I have a Link tag to this email that is added by my scripts, with the idea
> that this email will have a link to the previous version and so on. It will
> create a chain of the email discussions that lead to what lands in mainline.

It's indeed necessary. Thanks Steven.

> 
> -- Steve
> 
> 
>>   kernel/trace/trace.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 1b7db732c0b1..f2a84d1ce4b7 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -834,7 +834,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>>   		/* copy the current bits to the new max */
>>   		ret = trace_pid_list_first(filtered_pids, &pid);
>>   		while (!ret) {
>> -			trace_pid_list_set(pid_list, pid);
>> +			ret = trace_pid_list_set(pid_list, pid);
>> +			if (ret < 0)
>> +				goto out;
>> +
>>   			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
>>   			nr_pids++;
>>   		}
>> @@ -871,6 +874,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>>   		trace_parser_clear(&parser);
>>   		ret = 0;
>>   	}
>> + out:
>>   	trace_parser_put(&parser);
>>   
>>   	if (ret < 0) {

