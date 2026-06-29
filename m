Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A53F7A9E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724072; cv=none; b=rfyMMU3kyjPedIlpiE2sbtEA1Y3FXunuMbgn1W0++r2F04ODUhaa6SE5vEwdSDjDp0e40JXQeu6euB4B92MOsNzl1KKTQcUW8tjQ6oCYRjjCSdK4tzKiQ3qw3qVkErPufSzi4VxOZfX23TEfFvs11b1XBfjrqbOK95ARGR5qO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724072; c=relaxed/simple;
	bh=QkpYU2x6d5CTRAQnAvLOpdP6PC0148ML6LlO38w3JO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyV/RbRO6ydNsTgyDo4za52LKw3tdLEX0IBYpngeZ9jlswNrvv6PR0LNwykPt3rX602DndPGHVcFEXaiCaweeJ6cu9fbFOXxE9YnK+av5Vo7N2NQ+JaR6xTyQbWXH0PV7GvN6lD565ufkOvhXrHnwdvIDK3Z9YpjhMsj7Ze4wH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9kdiYzn; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9kdiYzn"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1231376a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782724070; x=1783328870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83HbAI6qOdVU1QL6jhPAqEWUlv3tiZPtQ6kqfm9JAYo=;
        b=h9kdiYzn+0/nrMVd+ug2h6uMDqjsLs3SyeIHDgkkKo+zOA1ZfVP4wdQ2wwAefiaU6E
         999oyL+//qu1+dpJAcLcKJIe/tiQo047yG14ZlGYHBFEji+03FVOfP+r9Ht2g9u+4mBJ
         +kAUKEBOqT+cyqovOy+zUM8XN3lpRsG+jYLjbJ1MjPBcc4/7CaUjjlnlNyIcBVacYbwk
         n/O6gtgAGcnvOthR6k2wMFDtIbRrJudWukttI44jS7DPcW+Zwp+H9u+obEoQNxpHfIwe
         PlUZOeGVF06qRSLuZ12ezy1HAF2yiK61iuVxacHVPkTsfBuEwnuq0eV1VEhCV3r9CjpB
         7VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724070; x=1783328870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83HbAI6qOdVU1QL6jhPAqEWUlv3tiZPtQ6kqfm9JAYo=;
        b=RZl/JF1bll8A5ej5aTiZtKGzEabyWdjcWuZHxtf2mMBvq71/mP6TqkvMsnFKZIxPan
         q3RAxLCeMy+EyXvETdwmZH8HbTPqx2PipT0NLam8cVlTDDcA0ANbV4sa/L+me7wG5cpu
         Ij2d8HE8j6y47CnC9NAv7WuSh0VUR3KlZVzAmVKZU7ydzTWkTXnuuRpYLLabeIIdk9yh
         9mFyRGl/iaoBKxoG2AwehpHHgjPwkinWPgrn5SEAI151GurD5VJxfLJ9x3MY7RpU7EBU
         TtyljRo2kAIIijbU4HVKcMFO9sbhYhICN4vazT+PErIB6/DVTQ0VYswYUubGDjv4y9vf
         yWog==
X-Forwarded-Encrypted: i=1; AFNElJ+FE8kVWaOej+Z3Tf6Wpcu4Rnd34IOYQno1NjcAvUkBorZleytRMMmxPwJ6RCQndetdosLIrqtAaEhEwKHcapsP0Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno+DbtwiCHkeRw7+rAmEVLG6v6I7nz8Ok6DzUuxZSaVpRCJdG
	G2Dhhj3g3IUAJSHSAUyxpkwIQGrxsr61zvW23BURMSN9JvQjMWBlBynt
X-Gm-Gg: AfdE7cmx4oX4p+PQz3NTQyxoFLD7MfBe2Kvv8YtOUahcCiV9SnZ5JaOMKqS+koJcMeb
	5D5pvzMMcuroPGLa7izXEupYFcFcVeWBrmije0SRHaPicHgIjxBy5JXtgfFlkM32Zid8+bD4ay/
	lYv35hUbP3uAGE313T/DqJeEYFyq9YeISi9owjKfN7PZPPXMmhaoO2t03u8jkFv6dMm8AT7Rzgm
	RQK6DB9AeXQHuRWzp776NwNh1AL0ah4wypZVGVt/yg+G7FExmprvXYvUzJ0oYTm74/VG2r/QSUJ
	UR4gZtY4sQLD8XMDtCodHY7nb7p8rNZMeyzJ1ebfgVoAD5LhE9/8j8xZXKs+MDGYG0VvViw/NTa
	O+ocvnn8LLJrip35LIci15woMcwnounmydAwFX+aH4YNO6eY2NiB6s1y7fQJS1qy1+D/rEWZNlk
	ombWM1f6VLAf+nskxbUuyO
X-Received: by 2002:a05:6a20:3d21:b0:3b4:85db:1be8 with SMTP id adf61e73a8af0-3bd4af22a37mr16709071637.36.1782724069917;
        Mon, 29 Jun 2026 02:07:49 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1df037sm7189768a12.17.2026.06.29.02.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:07:48 -0700 (PDT)
Message-ID: <05d7369e-341c-49f4-ae13-df3d0ad930d7@gmail.com>
Date: Mon, 29 Jun 2026 17:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: Alexander Krabler <Alexander.Krabler@kuka.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "jackmanb@google.com" <jackmanb@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "david@kernel.org" <david@kernel.org>, "ljs@kernel.org" <ljs@kernel.org>,
 "liam@infradead.org" <liam@infradead.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
 <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
 <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
 <PR3PR01MB6666EC8D53E75F742B37270282EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <PR3PR01MB6666EC8D53E75F742B37270282EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/26 21:42, Alexander Krabler wrote:
> On 6/26/26 11:38, Wandun wrote:
>> On 6/26/26 16:45, Alexander Krabler wrote:
>>> However, we were not able to reproduce the actual race
>>> (mlockall() process waiting on a migration PTE),
>>> not in the past, not now. Might be hard to trigger that race.
>>
>> Not hard to trigger that case, I added a debug message, such as below,
>> lots of messages occur in a few second.
>>
>> diff --cc mm/memory.c
>> index ff338c2abe92,ff338c2abe92..6552b3b14f78
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@@ -4768,6 -4768,6 +4768,8 @@@ vm_fault_t do_swap_page(struct vm_faul
>>                 if (softleaf_is_migration(entry)) {
>>                         migration_entry_wait(vma->vm_mm, vmf->pmd,
>>                                              vmf->address);
>> +                       if (!strcmp(current->comm, "repro"))
>> +                               pr_err("============== hit ================\n");
>>                 } else if (softleaf_is_device_exclusive(entry)) {
>>                         vmf->page = softleaf_to_page(entry);
>>                         ret = remove_device_exclusive_entry(vmf);
> 
> I have a kprobe on migration_entry_wait set and logged into a ftrace buffer
> (including kernel stacktrace).
> Yes, this function is hit, but only inside the mmap-syscall, which is okay,
> memory allocation is not realtime-safe.
> 
>            repro-2090    [002] d....   811.129549: frt_migration_entry_wait: (migration_entry_wait+0x0/0x100)
>            repro-2090    [002] d....   811.129553: <stack trace>
>  => migration_entry_wait
>  => __handle_mm_fault
>  => handle_mm_fault
>  => __get_user_pages
>  => populate_vma_page_range
>  => __mm_populate
>  => vm_mmap_pgoff
>  => ksys_mmap_pgoff
>  => __arm64_sys_mmap
>  => el0_svc_common.constprop.0
>  => do_el0_svc
>  => el0_svc
>  => el0t_64_sync_handler
>  => el0t_64_sync
> 
> The original race was an instruction abort interrupt out of nothing due
> to the migration PTE set by kcompactd.
> And these kind of races I see quite often on non mlockall()-processes,
> but can't reproduce on memory locked processes.
> 
> Example:
>           podman-832     [000] d....   812.447820: frt_migration_entry_wait: (migration_entry_wait+0x0/0x100)
>           podman-832     [000] d....   812.447823: <stack trace>
>  => migration_entry_wait
>  => __handle_mm_fault
>  => handle_mm_fault
>  => do_page_fault
>  => do_translation_fault
>  => do_mem_abort
>  => el0_da
>  => el0t_64_sync_handler
>  => el0t_64_sync

Hi, Alexander

From the perspective of the root cause, there is no fundamental difference
between these two call stacks. I modified the reproduction program, and it
can still reproduce the situation of the second call stack
(although it doesn't occur as frequently). The complete reproduction program
is as follows:


#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/sysinfo.h>
#include <unistd.h>

#define PAGE_SIZE       4096
#define NR_PAGES        10000

static void *worker_fn(void *arg)
{
	int fd = (long)arg;
	size_t len = NR_PAGES * PAGE_SIZE;

	while (1) {
		if (ftruncate(fd, 0) < 0) {}
		if (ftruncate(fd, len) < 0) {}

		char *p = mmap(NULL, len, PROT_READ | PROT_WRITE,
			       MAP_SHARED, fd, 0);
		if (p == MAP_FAILED)
			continue;

		mlockall(MCL_ONFAULT |  MCL_FUTURE);

		for (int i = 0; i < NR_PAGES; i++) {
			for (int j = 0; j < PAGE_SIZE; j++) {
				p[i * PAGE_SIZE + j] = 1;
			}
		}

		usleep(200);
		munmap(p, len);
	}
	return NULL;
}

static void *compact_fn(void *arg)
{
	(void)arg;
	int fd = open("/proc/sys/vm/compact_memory", O_WRONLY);
	if (fd < 0)
		return NULL;

	while (1) {
		if (write(fd, "1", 1) < 0) {}
		usleep(5000);
	}
}

int main(void)
{
	int nproc = sysconf(_SC_NPROCESSORS_ONLN);
	if (nproc < 1)
		nproc = 1;

	int *fds = calloc((size_t)nproc, sizeof(int));
	if (!fds)
		return 1;

	size_t len = NR_PAGES * PAGE_SIZE;
	for (int i = 0; i < nproc; i++) {
		char path[64];
		snprintf(path, sizeof(path), "./repro_%d.dat", i);
		unlink(path);
		fds[i] = open(path, O_RDWR | O_CREAT, 0600);
		if (fds[i] < 0)
			return 1;
		if (ftruncate(fds[i], len) < 0)
			return 1;
	}

	printf("repro: %d workers, %d pages, Ctrl-C to stop\n",
	       nproc, NR_PAGES);

	pthread_t compact;
	pthread_create(&compact, NULL, compact_fn, NULL);

	pthread_t *threads = calloc((size_t)nproc, sizeof(pthread_t));
	for (int i = 0; i < nproc; i++)
		pthread_create(&threads[i], NULL, worker_fn, (void *)(long)fds[i]);

	pthread_join(compact, NULL);
	return 0;
}




> 
> Thanks,
> Alexander
> 
> --
> 
> KUKA Deutschland GmbH   Board of Directors: Michael Jürgens (Chairman), Johan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914
> 
> This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized copying, disclosure or distribution of contents of this e-mail is strictly forbidden.
> 
> Please consider the environment before printing this e-mail.

