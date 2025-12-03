Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CADDAB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732074; cv=none; b=pLtK8Pg8D0qJGexv/w5jB5E6FhAuse4LlYfUzpqN3JbhCFWH7j8G/OL5gDl5bvdn4clAs14Tf8jgGc7OZCUtvPc+XL+JH81pFA4gBWt53pgXPAv3rq9DvVacPDXMIr0sSXQSRMKUpXkFagSB90VLs0uYQKVJHwcH/26d3ATiiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732074; c=relaxed/simple;
	bh=3iz8CrDAVuYpz1Srczo/CfnZgTLNw6i6IBNwYRS+0cA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mXJnXdEUuk18sVoHHtaAxr2BI8r1uG5+XmZCyJ88yFb4lORLyPFx5kFKFV2k/PkKZVKqbmwoie9x/RiJL74gT7tomUYTnKsQJZdtFzU1yDj4czOR5CZee/IdgquKPduLxFQrZZUlD0JhC0GiTuFrQu1y0QPOZGZ6Ff2oQtb4dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dLjZB04L0zKHLyg
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 11:20:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CADB61A01A1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 11:21:06 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgBnR1GgrC9pbxCoAQ--.45947S3;
	Wed, 03 Dec 2025 11:21:06 +0800 (CST)
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod modules after
 ftrace_disabled
To: Steven Rostedt <rostedt@goodmis.org>
References: <20251125020536.2484381-1-yebin@huaweicloud.com>
 <20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
 <20251127131820.152fd7651ece26139778cc25@kernel.org>
 <6929089E.10706@huaweicloud.com> <20251202114358.5e46cbae@gandalf.local.home>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, naveen@kernel.org,
 davem@davemloft.net, linux-trace-kernel@vger.kernel.org, yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <692FACA0.7090703@huaweicloud.com>
Date: Wed, 3 Dec 2025 11:21:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251202114358.5e46cbae@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnR1GgrC9pbxCoAQ--.45947S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xCF1DGF1rCw4kJrykuFg_yoW5JF4DpF
	WakFyYyrs8Xa1vva92gr1xtF4xG3yrKrWjvFn5Gr1UJ398CrnFvF4xtr4Y9FyUCw4UCFyx
	ZF4jyr47u3yDZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/12/3 0:43, Steven Rostedt wrote:
> On Fri, 28 Nov 2025 10:27:42 +0800
> yebin <yebin@huaweicloud.com> wrote:
>
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
> ftrace_disabled is equivalent to BUG(). But it doesn't crash the system
> immediately, but requires a reboot ASAP.
>
> I'm not interested in fixing residual bugs that happen because of a
> ftrace_disabled was triggered. The ftrace_disabled triggering is the cause
> of this. It should *never* happen. If it does, it needs to be fixed.
>
> Let's focus our attention on fixing the cause of ftrace_disabled. Anything
> else is just waste of effort.
>
> Do you have the output of the first warning when ftrace_disabled was
> triggered?

The reason for ftrace_disable is a conflict between a livepatch and a 
module. This issue must be resolved. However, since this problem occurs 
in the current network environment, it does not affect the normal 
operation of services, so customers may not necessarily be willing to 
restart their systems to fix it. The only thing that can be done is to 
implement proper exception protection to ensure the system can continue 
to function until the customer is willing to upgrade and restart.

  WARNING: CPU: 0 PID: 2394 at kernel/trace/ftrace.c:2603 
ftrace_modify_all_code+0x81/0x140
  CPU: 0 PID: 2394 Comm: insmod Tainted: P           OE K
  RIP: 0010:ftrace_modify_all_code+0x81/0x140
  Call Trace:
   arch_ftrace_update_code+0xc/0x20
   ftrace_run_update_code+0x13/0x70
   ftrace_startup+0xc0/0x190
   register_ftrace_function+0x44/0x60
   arm_kprobe+0xc7/0x120
   register_kprobe+0x5f0/0x6a0
   kxxx_emerge_init+0x89/0xe0 [kxxx]
   kxxx_region_init+0x16d/0x330 [kxxx]
   kxxx_init+0xe3/0x1000 [kxxx]
   do_one_initcall+0x46/0x1c8
   do_init_module+0x5b/0x1fb
   load_module+0x15a7/0x1e20
   __do_sys_finit_module+0xe9/0x110
   do_syscall_64+0x5b/0x1b0
   entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> -- Steve
>

