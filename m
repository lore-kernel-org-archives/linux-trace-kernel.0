Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0F17993
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164158; cv=none; b=WxtosElpry/M7WfZjm/lyyAm9RIhId3yvUR1KlaLjF2Je80xXLpQ9y11DRHlZqGj1Jz5g5R7B31uYVrZOPnLj+QmFPvc8Skn+BlRnXCDTwjZ+GvxDvnNco6brSmXPe5+NykX3slgZB99X4Xn3/ZG0u0KoY17V1ophBx7sEwTfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164158; c=relaxed/simple;
	bh=P70S/RSyEwRSypRMAYJWaMLMUHPOxfCAgMWBNS/a1kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqFhLKTFuDcfNgcFcxGw3J4mGjFcmzIkmekWFNN3SbW+ldkCanoyXR2e1e12wySAZSl6OEwJUDtxJ063U7mQKtgjhy5b5MTubWBf81f+By4WzRcIjYCyD+fMYzzE/WcsCEvsTpm6KesHK2/GwQst1MLPkhQHzguriUFw+n+P5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=quvgeL2k; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="quvgeL2k"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P70S/RSyEwRSypRMAYJWaMLMUHPOxfCAgMWBNS/a1kw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787164153; v=1; x=1787768953;
 b=quvgeL2kO9nUaZGz4rVOuSocWZb6xha4e/1Y8bd6NnW3BSazn6WOAIfU/UoYQexLdP8X855I
 VJrUrRm1ZFUXj/nCPQwefcQQk9Kubn7qdNU6Y62GpS5adip/VuVNrVd/JmZTUueFnsP/Mjl0A+v
 ZlvV4wIA6Dts1KQMq6E6dMMs=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from [192.168.1.71] (218.1.223.168)
	by smtp.migadu.com with ESMTPS id dc1603c7a99b7939;
	Wed, 19 Aug 2026 18:29:03 +0000
X-Mizu-Trace-ID: dc1603c7a99b7939
X-Migadu-Flow: FLOW_OUT
Message-ID: <030e600b-1df2-4118-93ba-a1e83635b092@linux.dev>
Date: Thu, 20 Aug 2026 02:29:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] rv: add generic uprobe infrastructure for RV
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1783524627.git.wen.yang@linux.dev>
 <31d0438f98e80503370a6fb3932d0ec7df0673c3.1783524627.git.wen.yang@linux.dev>
 <55912ee1fc569e5c81e25a32d516db54d1986336.camel@redhat.com>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <55912ee1fc569e5c81e25a32d516db54d1986336.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/20/26 23:22, Gabriele Monaco wrote:
> On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -59,6 +59,13 @@ config RV_PER_TASK_MONITORS
>>   	  This option configures the maximum number of per-task RV monitors
>> that can run
>>   	  simultaneously.
>>   
>> +config RV_UPROBE
>> +	bool
>> +	depends on RV && UPROBES
>> +	help
>> +	  Generic uprobe infrastructure for RV monitors.  Provides path
>> +	  resolution, registration, and safe synchronous teardown.
> 
> This isn't exposed, it's selected automatically when required, I don't
> even think the help text is visible (menuconfig doesn't show it), do we
> really need it?
> 

Thanks, the bool config stays (it gates the obj build for monitors that 
need it)but the invisible help text is dropped in v5; the entry is now just:

   config RV_UPROBE
         bool
         depends on RV && UPROBES


>> +
>>   source "kernel/trace/rv/monitors/wip/Kconfig"
>>   source "kernel/trace/rv/monitors/wwnr/Kconfig"
>>   
> 
> ...
> 
>> +++ b/kernel/trace/rv/rv_uprobe.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Generic uprobe infrastructure for RV monitors.
>> + *
>> + * struct rv_uprobe embeds struct uprobe_consumer directly.  This is safe
>> + * because rv_uprobe_sync() calls uprobe_unregister_sync(), which calls
>> + * synchronize_rcu_tasks_trace().  handler_chain() runs under
>> + * rcu_read_lock_trace(), so after synchronize_rcu_tasks_trace() returns,
>> + * all in-flight handler_chain() iterations, including any pending
>> + * uc->cons_node.next reads, have completed on all CPUs.  The caller may
>> + * then free the struct containing rv_uprobe immediately.
>> + */
>> +#include <linux/dcache.h>
>> +#include <linux/fs.h>
>> +#include <linux/namei.h>
>> +#include <linux/uprobes.h>
>> +#include <rv/rv_uprobe.h>
>> +
>> +/**
>> + * rv_uprobe_register - initialise and register an uprobe
>> + */
>> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprobe
>> *p)
>> +{
>> +	struct inode *inode;
>> +	struct path path;
>> +	int ret;
>> +
>> +	if (!p->uc.handler && !p->uc.ret_handler)
>> +		return -EINVAL;
> 
> uprobe_register() does this already, do we need it here too?
> 
>> +
>> +	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!d_is_reg(path.dentry)) {
>> +		path_put(&path);
>> +		return -EINVAL;
>> +	}
>> +
>> +	inode = d_real_inode(path.dentry);
>> +	p->inode = inode;
>> +
>> +	/*
>> +	 * uprobe_register() requires the inode (and mount) to remain
>> +	 * referenced across the call.  Keep the path alive until after
>> +	 * uprobe_register() has stored its own reference, then release it.
>> +	 */
>> +	p->uprobe = uprobe_register(inode, offset, 0, &p->uc);
>> +	path_put(&path);
> 
> I believe I was mistaken here, as sashiko pointed out, uprobe_register()
> doesn't keep a reference to the inode, (explicitly stated in it's docs:
> "Caller of uprobe_register() is required to keep @inode (and the
> containing mount) referenced.").
> 
> We should probably revert back to holding path instead of inode and
> putting it after synchronous cleanup. That's also what BPF does.
> 

Thanks.
Done in v5: struct rv_uprobe now keeps a struct path to the probed
binary.  rv_uprobe_register() resolves it via kern_path() and does not
drop it after uprobe_register(); rv_uprobe_unregister() releases it with
path_put() only after rv_uprobe_sync() has drained in-flight handlers,
so no inode reference outlives the probe.

--
Best wishes,
Wen

> 
>> +	if (IS_ERR(p->uprobe)) {
>> +		ret = PTR_ERR(p->uprobe);
>> +		p->uprobe = NULL;
>> +		p->inode = NULL;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(rv_uprobe_register);
>> +
>> +/**
>> + * rv_uprobe_is_registered - test whether an uprobe is currently active
>> + */
>> +bool rv_uprobe_is_registered(const struct rv_uprobe *p)
>> +{
>> +	return p && p->uprobe;
>> +}
>> +EXPORT_SYMBOL_GPL(rv_uprobe_is_registered);
>> +
>> +/**
>> + * rv_uprobe_unregister - synchronously unregister a uprobe
>> + */
>> +void rv_uprobe_unregister(struct rv_uprobe *p)
>> +{
>> +	if (!p || !p->uprobe)
>> +		return;
>> +
>> +	rv_uprobe_unregister_nosync(p);
>> +	rv_uprobe_sync();
>> +}
>> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
>> +
>> +/**
>> + * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
>> + */
>> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
>> +{
>> +	if (!p || !p->uprobe)
>> +		return;
>> +
>> +	uprobe_unregister_nosync(p->uprobe, &p->uc);
>> +	p->uprobe = NULL;
>> +	p->inode = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
>> +
>> +/**
>> + * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
>> + */
>> +void rv_uprobe_sync(void)
>> +{
>> +	uprobe_unregister_sync();
>> +}
>> +EXPORT_SYMBOL_GPL(rv_uprobe_sync);
> 
