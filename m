Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888D370ADC;
	Tue, 14 Jul 2026 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993863; cv=none; b=CNPcrhqpyjoyN/unP+igzs9M5dtcrAaoiqGn4e0n1UvZL65tIQ9kIfYZUKcCTuD8Axd+UJOB73Ttmf7oZbpcW54hZxHFmL+ArsPanzE6k0mx/5WsrNx647jZq+LK4/nFOtG5iX4DHKMobAdpRTbZE7PNmvwrMyRBsM8YQdjnDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993863; c=relaxed/simple;
	bh=1LdTcX9DGdAMvSEdGV1y4d76vngojMCGmhwbEz5Qqac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHyVKeB265sZFmtxfBr9g7yvo8Q8Gg0dn+N1bPb5pfg5Vi20ad6B8QsbVNmtxoiwH5XCP136TgEU5narn/noUi/XTV8zlPN6tajROi/SfPYm3HictcrO+6E+DTzigzs12klpVMh2OG/gd2T171kIztKqoBUvEoC+aPbFFL9s2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzj1t4SZvzYQtL6;
	Tue, 14 Jul 2026 09:50:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2A2A6408CB;
	Tue, 14 Jul 2026 09:50:57 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnL6D_lVVqeo2SBA--.30561S2;
	Tue, 14 Jul 2026 09:50:57 +0800 (CST)
Message-ID: <ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
Date: Tue, 14 Jul 2026 09:50:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
 <20260713153624.48fc4be4@robin>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260713153624.48fc4be4@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnL6D_lVVqeo2SBA--.30561S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryfCw1rKr17Jw1DZFWDArb_yoWDJFyxpF
	Z8t3s7Gr4kJrW2vF4DuF1rXrs7Jan8AFyUAFykGF1aqFykA345JryUAa1xurZxKa15AFZx
	C3WDuFW5Kr1jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Steven,

On 2026/7/14 3:36, Steven Rostedt wrote:
> On Mon, 13 Jul 2026 13:46:40 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> The trace_parser structure is allocated and initialized when a trace
>> file is opened, and is subsequently used in the write handler to parse
>> user input. If userspace opens a trace file descriptor and shares it
>> across multiple threads, concurrent write calls will race on the
>> parser's internal state, specifically the idx, cont, and buffer fields,
>> leading to corrupted input or undefined behavior.
>>
>> Fix this by embedding a mutex directly in struct trace_parser. The mutex
>> is initialized in trace_parser_get_init() and destroyed in
>> trace_parser_put(). All write-side users that access parser state
>> (trace_get_user() followed by checking trace_parser_loaded() /
>> trace_parser_cont() against the buffer) now hold the mutex across the
>> full critical section, avoiding any TOCTOU gap between the parse and the
>> subsequent consumption of parser->buffer.
>>
>> Affected write paths:
>>   - ftrace_graph_write / ftrace_graph_release
>>   - ftrace_regex_write / ftrace_regex_release
>>
>> Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
>> Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  kernel/trace/ftrace.c | 7 +++++++
>>  kernel/trace/trace.c  | 2 ++
>>  kernel/trace/trace.h  | 1 +
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index f93e34dd2328..ef47e5659283 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -5842,6 +5842,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
>>  	/* iter->hash is a local copy, so we don't need regex_lock */
>>  
>>  	parser = &iter->parser;
>> +
>> +	guard(mutex)(&parser->lock);
>>  	read = trace_get_user(parser, ubuf, cnt, ppos);
> 
> Why are the other users of trace_get_user() not a problem? If
> anything, trace_get_user() should have a lockdep assert to make sure
> the lock is held.
> 
> I think we need to add a lockdep assertion in all the callers that use
> the parser and we need to make sure it's taken by every user.
> 
> -- Steve

Other places that use trace_get_user():

ftrace_event_write
    trace_parser_get_init
    trace_get_user

trace_pid_write
    trace_parser_get_init
    trace_get_user

In both of these cases, the parser is allocated via trace_parser_get_init()
before use and freed immediately after, with no multi-threaded sharing.

However, ftrace_graph_write() and ftrace_regex_write() are different.
The parser used by these two functions is allocated at open() time and
retrieved from struct file at write() time. Userspace can have multiple
threads invoking write() concurrently, e.g.:

    r0 = openat(AT_FDCWD, path, O_WRONLY | O_CREAT | O_TRUNC |
                O_NOCTTY | O_NONBLOCK, 0);
    r1 = dup(r0);
    write(r1, data1, len1);        /* thread 1 */
    pwrite64(r1, data2, len2, offset); /* thread 2 */

Without proper synchronization in trace_get_user(), the parser state
becomes undefined.

We have locally reproduced a slab-out-of-bounds issue with syzkaller [1],
which appears to be caused by this race.

Regarding the fix, adding a lockdep assertion to trace_get_user() does
not seem necessary. As mentioned above, ftrace_event_write() and
trace_pid_write() do not involve concurrency, so they do not require
locking, and thus do not need a lockdep assertion.

[1] slab-out-of-bounds call trace:

[   29.629421][ T1269] ==================================================================
[   29.630348][ T1269] BUG: KASAN: slab-out-of-bounds in strstr+0x44/0x190
[   29.631098][ T1269] Read of size 1 at addr ffff00000ffa95f3 by task syz.3.4/1269
[   29.632120][ T1269] 
[   29.632390][ T1269] CPU: 2 PID: 1269 Comm: syz.3.4 Not tainted 5.10.0-27349-g9a396a20c0b1-dirty #1
[   29.634205][ T1269] Hardware name: linux,dummy-virt (DT)
[   29.635862][ T1269] Call trace:
[   29.636949][ T1269]  dump_backtrace+0x0/0x510
[   29.637954][ T1269]  show_stack+0x34/0x44
[   29.638438][ T1269]  dump_stack+0x1d0/0x248
[   29.639006][ T1269]  print_address_description.constprop.0+0x2c/0x1fc
[   29.639776][ T1269]  __kasan_report+0xfc/0x160
[   29.640325][ T1269]  kasan_report+0x44/0x60
[   29.640904][ T1269]  __asan_load1+0x70/0xa0
[   29.641544][ T1269]  strstr+0x44/0x190
[   29.642074][ T1269]  ftrace_match+0x130/0x200
[   29.642662][ T1269]  ftrace_match_record.isra.0+0x16c/0x210
[   29.643317][ T1269]  ftrace_graph_set_hash+0x20c/0x440
[   29.643959][ T1269]  ftrace_graph_write+0x170/0x200
[   29.644534][ T1269]  vfs_write+0x17c/0x66c
[   29.645018][ T1269]  ksys_write+0x108/0x220
[   29.645510][ T1269]  __arm64_sys_write+0x54/0x70
[   29.646058][ T1269]  el0_svc_common.constprop.0+0xd8/0x37c
[   29.646683][ T1269]  do_el0_svc+0x50/0x130
[   29.647191][ T1269]  el0_svc+0x24/0x34
[   29.647648][ T1269]  el0_sync_handler+0x180/0x18c
[   29.648232][ T1269]  el0_sync+0x160/0x180
[   29.648712][ T1269] 
[   29.648994][ T1269] Allocated by task 1269:
[   29.649505][ T1269]  kasan_save_stack+0x28/0x60
[   29.650069][ T1269]  __kasan_kmalloc.constprop.0+0xd8/0x140
[   29.650794][ T1269]  kasan_kmalloc+0x10/0x20
[   29.651365][ T1269]  __kmalloc+0xd4/0x7c0
[   29.651902][ T1269]  trace_parser_get_init+0x3c/0xa0
[   29.652547][ T1269]  __ftrace_graph_open.part.0+0xc4/0x250
[   29.653178][ T1269]  ftrace_graph_open+0xd8/0x154
[   29.653715][ T1269]  do_dentry_open+0x400/0x950
[   29.654231][ T1269]  vfs_open+0x60/0x70
[   29.654681][ T1269]  do_open+0x4f0/0x6f0
[   29.655223][ T1269]  path_openat+0x268/0x3a4
[   29.655707][ T1269]  do_filp_open+0x10c/0x23c
[   29.656234][ T1269]  do_sys_openat2+0x4e4/0x700
[   29.656749][ T1269]  __arm64_sys_openat+0x11c/0x1a0
[   29.657335][ T1269]  el0_svc_common.constprop.0+0xd8/0x37c
[   29.657342][ T1269]  do_el0_svc+0x50/0x130
[   29.657350][ T1269]  el0_svc+0x24/0x34
[   29.657359][ T1269]  el0_sync_handler+0x180/0x18c
[   29.657366][ T1269]  el0_sync+0x160/0x180
[   29.657368][ T1269] 
[   29.657375][ T1269] The buggy address belongs to the object at ffff00000ffa9500
[   29.657375][ T1269]  which belongs to the cache kmalloc-256 of size 256
[   29.657383][ T1269] The buggy address is located 243 bytes inside of
[   29.657383][ T1269]  256-byte region [ffff00000ffa9500, ffff00000ffa9600)
[   29.657386][ T1269] The buggy address belongs to the page:
[   29.657398][ T1269] page:fffffe00001fea00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff00000ffa8500 pfn:0x4ffa8
[   29.657405][ T1269] head:fffffe00001fea00 order:2 compound_mapcount:0 compound_pincount:0
[   29.657417][ T1269] flags: 0x7ffff800010200(slab|head|node=0|zone=0|lastcpupid=0xfffff)
[   29.657430][ T1269] raw: 007ffff800010200 ffff0000c0000820 ffff0000c0000820 ffff0000c000cd00
[   29.657441][ T1269] raw: ffff00000ffa8500 0000000000100008 00000001ffffffff 0000000000000000
[   29.657445][ T1269] page dumped because: kasan: bad access detected
[   29.657447][ T1269] 
[   29.657451][ T1269] Memory state around the buggy address:
[   29.657458][ T1269]  ffff00000ffa9480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   29.657465][ T1269]  ffff00000ffa9500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   29.657473][ T1269] >ffff00000ffa9580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc
[   29.657477][ T1269]                                                              ^
[   29.657484][ T1269]  ffff00000ffa9600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   29.657491][ T1269]  ffff00000ffa9680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   29.657494][ T1269] ==================================================================
[   29.657498][ T1269] Disabling lock debugging due to kernel taint
[   29.657656][ T1269] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[   29.657668][ T1269] CPU: 2 PID: 1269 Comm: syz.3.4 Tainted: G    B             5.10.0-27349-g9a396a20c0b1-dirty #1
[   29.657672][ T1269] Hardware name: linux,dummy-virt (DT)
[   29.657676][ T1269] Call trace:
[   29.657685][ T1269]  dump_backtrace+0x0/0x510
[   29.657692][ T1269]  show_stack+0x34/0x44
[   29.657700][ T1269]  dump_stack+0x1d0/0x248
[   29.657711][ T1269]  panic+0x390/0x728
[   29.657719][ T1269]  check_panic_on_warn+0x108/0x12c
[   29.657727][ T1269]  end_report+0x5c/0xe0
[   29.657748][ T1269]  __kasan_report+0x118/0x160
[   29.657756][ T1269]  kasan_report+0x44/0x60
[   29.657764][ T1269]  __asan_load1+0x70/0xa0
[   29.657771][ T1269]  strstr+0x44/0x190
[   29.657780][ T1269]  ftrace_match+0x130/0x200
[   29.657790][ T1269]  ftrace_match_record.isra.0+0x16c/0x210
[   29.657799][ T1269]  ftrace_graph_set_hash+0x20c/0x440
[   29.657808][ T1269]  ftrace_graph_write+0x170/0x200
[   29.657815][ T1269]  vfs_write+0x17c/0x66c
[   29.657821][ T1269]  ksys_write+0x108/0x220
[   29.657828][ T1269]  __arm64_sys_write+0x54/0x70
[   29.657836][ T1269]  el0_svc_common.constprop.0+0xd8/0x37c
[   29.657842][ T1269]  do_el0_svc+0x50/0x130
[   29.657850][ T1269]  el0_svc+0x24/0x34
[   29.657858][ T1269]  el0_sync_handler+0x180/0x18c
[   29.657865][ T1269]  el0_sync+0x160/0x180
[   29.657876][ T1269] SMP: stopping secondary CPUs
[   29.657896][ T1269] Kernel Offset: disabled
[   29.690695][ T1269] HKRR parameters: disabled
[   29.691167][ T1269] CPU features: 0x0004,88040002,6a208038
[   29.691749][ T1269] Memory Limit: none
[   29.692186][ T1269] ---[ end Kernel panic - not syncing: KASAN: panic_on_warn set ... ]---

Thanks,
Tengda

