Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DC3CCFD2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120326; cv=none; b=AlAUzMeaxvBD9jz0DOQiiEjLHNI5BUgI3qj4iUHLLQ1B97jjW/YvNCdQx07A85xod6Y2LMH1qntfwD5X7XFr18bbipRaqR4HXt6Jc5HFGnetxrQSoe0VaGjc+aFtrjsgWaG1owJCoM4Qbbka10J9MD/ELfe+lzgCC0sUMNXdYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120326; c=relaxed/simple;
	bh=XQGkjpt8U3DP9kZuesta0d6Dz38lDFdJ6QXs3+kuprQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJ6qtjbTEWTERowadomthyAiT1AG0lbBGTrSfMvx3p8OpLHT7qGstynNaxwOxq75nTgrWhv9iDo14E5PGqLEgD6kuHl1Ps9Q1GNd9CFss2m70xWtSJII5peh0wuYWyFUo4ONzHrT3ZYDDWOcPP+m1EFYUvld6OsPd8UQgoGeztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nFA4wQOy; arc=none smtp.client-ip=91.218.175.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nFA4wQOy"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XQGkjpt8U3DP9kZuesta0d6Dz38lDFdJ6QXs3+kuprQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120321; v=1; x=1789725121;
 b=nFA4wQOyIBrQBwFY0YQn7pJWTKPBQuIHbFT6LCYEkZWTC0Wi6VJxVRN6ynnmkz+0bwKRiGy2
 67DewT1CZbOikyoHssdNmpRrOdLdF3s/gccEi2Uku36BYg653EbLwww6vs1xMKrSBeGvy3SwGSK
 vuW14BlfifiD0TLQfy2Ureic=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da8b245db0b0c3fa;
	Fri, 11 Sep 2026 09:52:01 +0000
X-Mizu-Trace-ID: da8b245db0b0c3fa
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ae944a6-df67-4a8a-8ece-c34701715c8a@linux.dev>
Date: Fri, 11 Sep 2026 17:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] mm/memory-failure: convert process iterator to
 for_each_process_rculock
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-5-ye.liu@linux.dev>
 <20260911081351.A8FE81F00893@smtp.kernel.org>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260911081351.A8FE81F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/11 16:13, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Potential NULL pointer dereference or Use-After-Free of `folio->mapping` in `collect_procs_file()` due to concurrent truncation.
> --
> 
Unrelated to this patch. I will fix it later.

> commit 788d1f422c3f19026d9e0d86b550c238607720ed
> Author: Ye Liu <liuye@kylinos.cn>
> 
> mm/memory-failure: convert process iterator to for_each_process_rculock
> 
> This commit replaces the manual rcu_read_lock()/rcu_read_unlock() pairs
> combined with for_each_process() loop in mm/memory-failure.c with
> for_each_process_rculock(), which scopes the RCU read lock to the loop body
> via scoped_guard(rcu).
> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a8b03e2920ba8..7d93deb1f7b3d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
> [ ... ]
>> @@ -589,9 +587,8 @@ static void collect_procs_file(const struct folio *folio,
>>  	pgoff_t pgoff;
>>  
>>  	i_mmap_lock_read(mapping);
> 
> [Severity: High]
> This is a pre-existing issue, but could this lead to a NULL pointer
> dereference or a use-after-free of mapping due to a race with truncation?
> 
> In memory_failure(), the folio lock is dropped in hwpoison_user_mappings()
> before calling collect_procs(). collect_procs() performs an unlocked check of
> !folio->mapping:
> 
> static void collect_procs(...)
> {
> 	if (!folio->mapping)
> 		return;
> 	...
> 	else
> 		collect_procs_file(folio, page, tokill, force_early);
> }
> 
> If a concurrent truncation removes the folio from the page cache immediately
> after this check, folio->mapping becomes NULL. collect_procs_file() then
> initializes mapping = folio->mapping and calls i_mmap_lock_read(mapping).
> 
> If the compiler performs a second read of folio->mapping, mapping will be
> NULL, crashing the kernel on the semaphore acquisition. If the compiler
> caches the first read, mapping will point to an address_space whose host
> inode may have been concurrently freed, leading to a use-after-free since
> the elevated page refcount does not pin the inode and no RCU read lock is
> held during the blocking i_mmap_lock_read() call.
> 
>> -	rcu_read_lock();
>>  	pgoff = page_pgoff(folio, page);
>> -	for_each_process(tsk) {
>> +	for_each_process_rculock(tsk) {
>>  		struct task_struct *t = task_early_kill(tsk, force_early);
>>  		unsigned long addr;
> 

-- 
Thanks,
Ye Liu

