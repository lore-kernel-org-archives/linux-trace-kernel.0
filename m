Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930883D3309
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120550; cv=none; b=YvtjPWHS7EPGboluqfMqU3HlAPIRUgj3zuv1ubepiNedoawG/plhn+TJL2QDBDSk2SfsqFdIFDWEBO4GUMaERncjhhuFhu22wKyGVVS8pjwJAKbXN96XraE+IKzBfaTRw02jgywrzV85O21rLtxhrnK0p5jiM2ZyppoZMpwLOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120550; c=relaxed/simple;
	bh=Wx+nwPJRj0GLmrahJZq2fuBSqm4bV9rgjAq9rKd17bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p96KOb+XY92FevUuhGOX9JKqPTG44XEO7upmwrWjLzvfU0gEFc2iNSFFXOLD+JbDXMlJM6VgNMA7/sSXU3WpEC2mwndKxvBEGkktO7xg+SUhk8Z0P+vqo+F18IHEySPSdHNCH4yvsow3wSwUCRNbNChvwEXaLSqlYoUG87SH9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=huhgAcls; arc=none smtp.client-ip=91.218.175.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="huhgAcls"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wx+nwPJRj0GLmrahJZq2fuBSqm4bV9rgjAq9rKd17bo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120545; v=1; x=1789725345;
 b=huhgAclsHA2KMc6f707SHkCqcOAv7613VaZsesMIBevM0w4/cOZdpvClvOLG9uEIZvoyr6RB
 ZAW7Ny1tyxoeyMKg3q9XCUecMM1aKVSckIjdzKrQF3enixqvEJrSikX1pzZ2NpIqpWpbtly5mgX
 E3OYPdesJ3YuTAC9Vna6tTr8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6387c94353b709c9;
	Fri, 11 Sep 2026 09:55:45 +0000
X-Mizu-Trace-ID: 6387c94353b709c9
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ec3887b-9beb-484b-924f-666763994421@linux.dev>
Date: Fri, 11 Sep 2026 17:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] cpu/hotplug: convert thread iterator to
 for_each_thread_rculock
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-6-ye.liu@linux.dev>
 <20260911081120.542271F000FF@smtp.kernel.org>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260911081120.542271F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/11 16:11, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message incorrectly claims to replace `for_each_thread()` with `for_each_thread_rculock()`, but the code actually replaces `for_each_process()` with `for_each_process_rculock()`.
> --
> 
> commit 3ac98de6fbc4e97ba4981ef0c4941692c15a9309
> Author: Ye Liu <liuye@kylinos.cn>
> 
> cpu/hotplug: convert thread iterator to for_each_thread_rculock
> 
> This commit replaces a manual rcu_read_lock() and rcu_read_unlock() pair
> in clear_tasks_mm_cpumask() with a scoped RCU lock iterator macro.
> 
>> cpu/hotplug: convert thread iterator to for_each_thread_rculock
>>     
>> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
>> with for_each_thread() loop in kernel/cpu.c with for_each_thread_rculock(),
> 
> [Severity: Medium]
> Is the commit message accurate regarding the iterator being replaced?
> 
> The commit message subject and body describe converting a thread iterator
> using for_each_thread() to for_each_thread_rculock(). However, looking at
> clear_tasks_mm_cpumask() in the diff:
> 
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index b3c8553d7bd6c..00638d2abc0f6 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1254,8 +1254,7 @@ void clear_tasks_mm_cpumask(int cpu)
>>  	 * full-fledged tasklist_lock.
>>  	 */
>>  	WARN_ON(cpu_online(cpu));
>> -	rcu_read_lock();
>> -	for_each_process(p) {
>> +	for_each_process_rculock(p) {
> 
> The code actually replaces for_each_process() with for_each_process_rculock().
> 
> Could the commit message be updated to match the process iterator actually
> used in the patch to avoid confusion during review or bisection?
> 

Sorry, copy error. It should be the following content:

cpu/hotplug: convert process iterator to for_each_process_rculock
    
    Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
    with for_each_process() loop in kernel/cpu.c with for_each_process_rculock(),
    which scopes the RCU read lock to the loop body via scoped_guard(rcu).
    
    No functional change.

-- 
Thanks,
Ye Liu

