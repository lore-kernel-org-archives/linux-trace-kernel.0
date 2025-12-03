Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378E3594F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764729434; cv=none; b=cpzBG0QGfXwf2/4e4CCp36v3R439N4CwA+HczV1zTepZPooqlkf7geA8R+enx3POjIw126Vkh6y9Yiyxb8o/nJqvZ0HpGfuSzZQW6/b2dlgmE0WXdc5QAo2iy/OVaFPWnZy08S1jc1+mdClRmNcwtYGkw7wp1UcJqaYP9jFs6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764729434; c=relaxed/simple;
	bh=MZNxeEATSfZ3N3+RwYgFYpBJSJDCqLt1wuTXKJUxjKM=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hJJH5vhfCzNYsShsX6EuotPQM+Q7X4Y9C3NK04PslNJbZ2P4k70kT7Q4o+lxnl19/T4hfWFpBNQSj8rxhXkBJ2y+SM4vkq4xYVhj7RyZeo42cMIO/s64Hq1UZUkeJbrrFqy8A/3oKKBzKj0hkoGhGopg32y8xuaYWA+ZSA2wFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dLhbQ1wqzzKHMYV
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 10:36:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0C6631A1B80
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 10:37:07 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgAnCFJRoi9pxoKkAQ--.45874S3;
	Wed, 03 Dec 2025 10:37:06 +0800 (CST)
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod modules after
 ftrace_disabled
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20251125020536.2484381-1-yebin@huaweicloud.com>
 <20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
 <20251127131820.152fd7651ece26139778cc25@kernel.org>
 <6929089E.10706@huaweicloud.com>
 <20251202113248.e9e2e7c665bd3ee07b83e399@kernel.org>
Cc: naveen@kernel.org, davem@davemloft.net,
 linux-trace-kernel@vger.kernel.org, yebin10@huawei.com,
 Steven Rostedt <rostedt@goodmis.org>
From: yebin <yebin@huaweicloud.com>
Message-ID: <692FA251.3080100@huaweicloud.com>
Date: Wed, 3 Dec 2025 10:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251202113248.e9e2e7c665bd3ee07b83e399@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnCFJRoi9pxoKkAQ--.45874S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWDZFWkCry7Wr43uw1kuFg_yoW7tF18pr
	ykJFs8KF48XF1FkFy2vw15tr1xKrW7Aay7Xr18Gry8Jr1DKr17Gr1xtrW5uF95Ar1UArya
	qr4DXrW2grWrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/12/2 10:32, Masami Hiramatsu (Google) wrote:
> Cc: Steve,
>
> Since this is caused by ftrace_kill.
>
> On Fri, 28 Nov 2025 10:27:42 +0800
> yebin <yebin@huaweicloud.com> wrote:
>
>>
>>
>> On 2025/11/27 12:18, Masami Hiramatsu (Google) wrote:
>>> On Thu, 27 Nov 2025 12:52:48 +0900
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> Thanks for reporting!
>>>>
>>>>
>>>> On Tue, 25 Nov 2025 10:05:36 +0800
>>>> Ye Bin <yebin@huaweicloud.com> wrote:
>>>>
>>>>> From: Ye Bin <yebin10@huawei.com>
>>>>>
>>>>> There's a issue as follows when rmmod modules after ftrace disabled:
>>>>
>>>> You may see something like;
>>>>
>>>> Failed to unregister kprobe-ftrace (error -19)
>>>>
>>>> or
>>>>
>>>> Failed to disarm kprobe-ftrace at <function name> (error -19)
>>>>
>>>> right before this BUG, don't you?
>>>> If you reported with that line, it's more easier to understand.
>>>>
>> Yes, there is indeed a warning generated. I might not have expressed it
>> clearly enough. The issue below is related to the problem that occurs
>> when the second module is unloaded. When the first module was unloaded,
>> some nodes were left in the hash list, causing a use-after-free (UAF)
>> issue when traversing the hash list.
>> Therefore, this patch aims to resolve the UAF problem caused by residual
>> nodes in the hash list after unloading a module while ftrace is disabled.
>
> Yes, but I think your patch is redundant. Can you test the code
> which I suggested at the last?
>
Yes, indeed, your solution is simpler and doesn't require writing 
repetitive code.

> BTW, can you explain why that ftrace_disabled was kicked?
> That usually means ftrace hits some bug.
>
Yes, there is a conflict between two modules causing ftrace_disabled.
>>>>
>>>>> BUG: unable to handle page fault for address: fffffbfff805000d
>>>>> PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
>>>>> Oops: Oops: 0000 [#1] SMP KASAN PTI
>>>>> CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
>>>>> Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>>> RIP: 0010:kprobes_module_callback+0x89/0x790
>>>>> RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
>>>>> RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
>>>>> RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
>>>>> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
>>>>> R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
>>>>> R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
>>>>> FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
>>>>> Call Trace:
>>>>>    <TASK>
>>>>>    notifier_call_chain+0xc6/0x280
>>>>>    blocking_notifier_call_chain+0x60/0x90
>>>>>    __do_sys_delete_module.constprop.0+0x32a/0x4e0
>>>>>    do_syscall_64+0x5d/0xfa0
>>>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> The above issue occurs because the kprobe was not removed from the hash
>>>>> list after ftrace_disable.
>>>>> To prevent the system from restarting unexpectedly after ftrace_disable,
>>>>> in such cases, unregister_kprobe() ensures that the probe is removed from
>>>>> the hash list, preventing subsequent access to already freed memory.
>>>>>
>>>>> Fixes: 6f0f1dd71953 ("kprobes: Cleanup disabling and unregistering path")
>>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>>> ---
>>>>>    kernel/kprobes.c | 26 ++++++++++++++++++++++++--
>>>>>    1 file changed, 24 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>>>> index ab8f9fc1f0d1..d735a608b810 100644
>>>>> --- a/kernel/kprobes.c
>>>>> +++ b/kernel/kprobes.c
>>>>> @@ -1731,8 +1731,30 @@ static int __unregister_kprobe_top(struct kprobe *p)
>>>>>
>>>>>    	/* Disable kprobe. This will disarm it if needed. */
>>>>>    	ap = __disable_kprobe(p);
>>>>> -	if (IS_ERR(ap))
>>>>> -		return PTR_ERR(ap);
>>>>> +	if (IS_ERR(ap)) {
>>>>> +		int ret = PTR_ERR(ap);
>>>>> +
>>>>> +		/*
>>>>> +		 * If ftrace disabled we need to delete kprobe node from
>>>>> +		 * hlist or aggregation list. If nodes are not removed when
>>>>> +		 * modules are removed, the already released nodes will
>>>>> +		 * remain in the linked list. Subsequent access to the
>>>>> +		 * linked list may then trigger exceptions.
>>>>> +		 */
>>>>> +		if (ret != -ENODEV)
>>>>> +			return ret;
>>>>> +
>>>>> +		ap = __get_valid_kprobe(p);
>>>>> +		if (!ap)
>>>>> +			return ret;
>>>>> +
>>>>> +		if (ap == p)
>>>>> +			hlist_del_rcu(&ap->hlist);
>>>>> +		else
>>>>> +			list_del_rcu(&p->list);
>>>>
>>>> Instead of repeating this process, we should ignore
>>>> -ENODEV error from ftrace directly. BTW, ftrace_disabled is set
>>>> when ftrace_kill() is called, that means ftrace is no more usable.
>>>> So I think we can just ignore ftrace operation in
>>>> __disarm_kprobe_ftrace().
>>>
>>> So, what we need is;
>>>
>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>> index ab8f9fc1f0d1..17d451553389 100644
>>> --- a/kernel/kprobes.c
>>> +++ b/kernel/kprobes.c
>>> @@ -1104,6 +1104,10 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>>>    	int ret;
>>>
>>>    	lockdep_assert_held(&kprobe_mutex);
>>> +	if (unlikely(kprobe_ftrace_disabled)) {
>>> +		/* Now ftrace is disabled forever, disarm is already done. */
>>> +		return 0;
>>> +	}
>>>
>>>    	if (*cnt == 1) {
>>>    		ret = unregister_ftrace_function(ops);
>>>
>
> This one, it should fix simply.
>
I tested it and it can solve the problem. This is indeed a good solution 
that reuses the original code.
Do you want me to send a new patch version according to your proposal?
> Thank you,
>
>>>
>>
>
>

