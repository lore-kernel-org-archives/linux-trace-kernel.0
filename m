Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A77125DF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174735; cv=none; b=aXj5AN6NQHdhOQF0QlhSOVokTcN5S/UZhomfuIbgEyaUlvL2FROmHFPBfm9LQTTFLQsQif5SHNJQIb5HkGAEKa5z4iIm3zQzzWKVlj8N/cSHEXeHX8R+3C+rJpRJ219Vl5Mi3ROmLwdCDCtJODeY6+xegpuiOn8hRbk+NFiOqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174735; c=relaxed/simple;
	bh=L807FrWlb6ex2FD/dGnEEwXo/W0GFGJ3mzPvhCLU4yY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mEKUx1/S3OXRq9wlDEe4+EkcQwAAlY7ZnVQhGr0vQ0/tTMp6Q0m6RdSsyzkyV4mRQoJEA+/e15Rml3R+TKxu9j3aH+8rshpuASKBy9A/uVTP/It7phgo8y0pcCNqAhkunP8zZtDYPVTKmFKeTZiQsho+DyZ59y09W+a1SM6glTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bD47Z28snzYQvFP
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 09:52:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 567A61A0A78
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 09:52:09 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_HSUJo6sWQOg--.47848S3;
	Fri, 06 Jun 2025 09:52:09 +0800 (CST)
Subject: Re: [PATCH v3 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
To: Steven Rostedt <rostedt@goodmis.org>
References: <20250529111955.2349189-1-yebin@huaweicloud.com>
 <20250529111955.2349189-2-yebin@huaweicloud.com>
 <20250602112823.4a83daa1@gandalf.local.home>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <684249C7.8050000@huaweicloud.com>
Date: Fri, 6 Jun 2025 09:52:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250602112823.4a83daa1@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH61_HSUJo6sWQOg--.47848S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1UtF1fur1DJr43uFWrGrg_yoW7uw1xpr
	WfJr4jkF48KF42yF4xCr1DJr1UKrWUAayUJF1xGr1Sv3WDCr1UXry8JF4UWF9rJr18X34I
	yF4DX34IqrykWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/6/2 23:28, Steven Rostedt wrote:
> On Thu, 29 May 2025 19:19:54 +0800
> Ye Bin <yebin@huaweicloud.com> wrote:
>
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> BUG: unable to handle page fault for address: ffffffffc05d0218
>> PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
>> Oops: Oops: 0000 [#1] SMP KASAN PTI
>> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> RIP: 0010:sized_strscpy+0x81/0x2f0
>> RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
>> RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
>> RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
>> R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
>> R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
>> FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   ftrace_mod_get_kallsym+0x1ac/0x590
>>   update_iter_mod+0x239/0x5b0
>>   s_next+0x5b/0xa0
>>   seq_read_iter+0x8c9/0x1070
>>   seq_read+0x249/0x3b0
>>   proc_reg_read+0x1b0/0x280
>>   vfs_read+0x17f/0x920
>>   ksys_read+0xf3/0x1c0
>>   do_syscall_64+0x5f/0x2e0
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Above issue may happens as follow:
>> (1) Add kprobe trace point;
>> (2) insmod test.ko;
>> (3) Trigger ftrace disabled;
>> (4) rmmod test.ko;
>> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
>> ftrace_mod_get_kallsym()
>> ...
>> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
>> ...
>>
>> As ftrace_release_mod() judge 'ftrace_disabled' is true will return,
>> and 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no
>> chance to release. Therefore, this also causes residual resources to
>> accumulate. To solve above issue, unconditionally clean up'mod_map'.
>> Of course, the root cause of this problem is the presence of
>> ftrace_disabled. The fixes tags patch introduces the possibility of
>> residual resources in the case of ftrace_disabled. The root cause of
>> the problem is ftrace_disabled. This patch only adds protection when
>> ftrace_disabled occurs.
>>
>
> I've updated the above change log to state the below. It adds a bit more
> details about what exactly went wrong:
>
> -- Steve
>
Thank you very much for your detailed and clear explanation. Do I need 
to send another version?
>
> The following issue happens with a buggy module:
>
> BUG: unable to handle page fault for address: ffffffffc05d0218
> PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
> Oops: Oops: 0000 [#1] SMP KASAN PTI
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> RIP: 0010:sized_strscpy+0x81/0x2f0
> RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
> RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
> RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
> R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
> R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
> FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ftrace_mod_get_kallsym+0x1ac/0x590
>   update_iter_mod+0x239/0x5b0
>   s_next+0x5b/0xa0
>   seq_read_iter+0x8c9/0x1070
>   seq_read+0x249/0x3b0
>   proc_reg_read+0x1b0/0x280
>   vfs_read+0x17f/0x920
>   ksys_read+0xf3/0x1c0
>   do_syscall_64+0x5f/0x2e0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The above issue may happen as follows:
> (1) Add kprobe tracepoint;
> (2) insmod test.ko;
> (3)  Module triggers ftrace disabled;
> (4) rmmod test.ko;
> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
> ftrace_mod_get_kallsym()
> ...
> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> ...
>
> The problem is when a module triggers an issue with ftrace and
> sets ftrace_disable. The ftrace_disable is set when an anomaly is
> discovered and to prevent any more damage, ftrace stops all text
> modification. The issue that happened was that the ftrace_disable stops
> more than just the text modification.
>
> When a module is loaded, its init functions can also be traced. Because
> kallsyms deletes the init functions after a module has loaded, ftrace
> saves them when the module is loaded and function tracing is enabled. This
> allows the output of the function trace to show the init function names
> instead of just their raw memory addresses.
>
> When a module is removed, ftrace_release_mod() is called, and if
> ftrace_disable is set, it just returns without doing anything more. The
> problem here is that it leaves the mod_list still around and if kallsyms
> is called, it will call into this code and access the module memory that
> has already been freed as it will return:
>
>    strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
>
> Where the "mod" no longer exists and triggers a UAF bug.
>

