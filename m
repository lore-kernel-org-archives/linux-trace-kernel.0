Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643D3DA7E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783003; cv=none; b=RqVW10UTxz24umIqggGWU6x4snjzUJOI0eiBEkxDMbHLXAMesHF4T1wr7YoUCYtVq0pyVtwBxzkUlxbQi7cnP34HmPU7cU6akwaMJx3GBnTdDxDwuoUT8UBA5geZV0Z1BebMb6oLh8c5jaWy4I0ndLazfhryrEfjcSfa61VsnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783003; c=relaxed/simple;
	bh=YaIL/fgTTOpUmvZte+csBCMtSTkbP0d90ec0nW4Vuf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm9VJBgiknfFdckcempk13f7G3CvH+OGAUlqr+W/X0ZHqMD/TcUNEO6JEDrc4IXy8TKKirFe/CB6E6LbLqWbLx+YuNLhTyDnRuWTaZYEPkEbt00yXZSSl7zke5hMwjrjYox9zBQ1BijL0wl+IhLJqyOhTV5EfaL8BWVKgE8a1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG4xVt62; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG4xVt62"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so753394a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781783001; x=1782387801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uy+wslaGLTlcCcaujHMpqPGyDzguwt0VkdpSQM6UeA=;
        b=gG4xVt62k/tN0QKk0V0UDgfGjVq0rhyiOW5gVIVkOV+ekziWkzaPOcEbEcweubFrFW
         roiR2VZ4NfMGiDNEcr9f4coU2/jwxY+MRIGX+c7bz3aIi8+bgKW0U0upedk78IrnpD98
         i2p74gvTiXKLySlDjGwaoKjx5LhReav1yyJzvlHuyGj2sd5Sc6h0FwqSGfWIkmvcMJ6+
         BSc7DVe21nTYeb3hMr1dRCYbT1bx/ByIzzJxOsPtmdzmuILRzkGgUcKki6+RfvK31L/2
         9XkCKTFSILGag9XF1jt86M2yZSNB2qJJhZG0KDqpvk8LrDPaUOj9QbVI87hp1cI1qf/A
         zROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783001; x=1782387801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uy+wslaGLTlcCcaujHMpqPGyDzguwt0VkdpSQM6UeA=;
        b=U1t4lzN52h8OBz3MYDp+v5uIOQe8AePtNSyxfkD6XT+Sj9xBd30NTBMKLIqWkzrQ2Z
         2WWBp9xVe+nlVid/TAXcG0ocNFYrq5FG5wwYOWaxT+60Wx/HZv3QzSH+0YVGu+nTS+ka
         iPXGkoWEr8pxTO+/Z+Lz2ROgz9S1atVyPXC/n99Aid0ZB6vCgHwQxL1Xp74QuM6qBAzY
         Ws5lqRKECKBJo9fogsufUtwwkf8dXzaSrrlskQSgIXxlp8SYXCmQzZAKV9lZQ3Tc7nNd
         6/+GALfZgAuEIhBs+UKFxuCwjcMvHIDGlH+AbEjPqN+FKJzM70dlb28uOUjtfDRbyaTz
         WzBg==
X-Forwarded-Encrypted: i=1; AFNElJ9mRoJSLsAz5MkTS77FnZ7oZ/UJLchhYh6xGRNac0bPDXXdIh7Z1B3aGSSo/b6XaBvlqB/6zRlDtVrBwUesSD54kVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JMAAx1l2hqwDAR+KgESbCOf4Yd+Ly3uDMLr+Fb1Pu0TyhtNy
	Zz/HmByAaDTned3Sde1oDE9j14JxklTvajGfopuPBxLPn/GBG80H8Tz7
X-Gm-Gg: AfdE7ck+tY3kgPNt4C5xSZuRXNtOP66+ILC62PNPAXp3ZI3dRv5C+N/OB1ypYUYQrZS
	Nr91JTSU+3KjjnDdGehooWnnE3k9iT+yMR/3TOIwaMiPWX7geJqEBFiwJYafc0TLgjtkiOWRV7D
	tOEmklp+RaXv+R7+MNnmhz2vQV3J9wwIFGy/Jx9uc4G45kRn9xm/khAd2e1V4gU9qkWCVviZV/E
	chgfq6Uv5EQgt9mh2u9zy9FIfsaMlb2yu+xiDi6fa1rMYbBeTqVyqEvewTMkoqJjB/gBQNeQqdB
	cCpNhQQ7q7U30xcrVEIzzEVkEaH28Hhfjav1MqmxWz9oCZHLgKsR6tmHYPG7wPYJ0Op8pYveoIe
	raKxOOMg0a9alM2h4WZy5bwLR+qr5suWsqQERVLvVfc+gve1gOTDwtEMmwrAcUv0zIPzdnf2vGd
	BwZwjuGetrT/j7jpO+MSKt93rA1PTSXRI=
X-Received: by 2002:a17:90b:3a43:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-37ce45455d8mr3452661a91.16.1781783000992;
        Thu, 18 Jun 2026 04:43:20 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325e477sm16709082a12.10.2026.06.18.04.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:43:19 -0700 (PDT)
Message-ID: <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
Date: Thu, 18 Jun 2026 19:43:09 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 02:52, Vlastimil Babka (SUSE) wrote:
> On 6/4/26 04:38, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> compact_unevictable_allowed is default 0 under PREEMPT_RT,
>> isolate_migratepages_block() skips folios with PG_unevictable set.
>> However, mlock_folio() sets PG_mlocked immediately but defers
>> PG_unevictable to mlock_folio_batch(), result in a folio with
>> PG_mlocked=1 but PG_unevictable=0. Compaction will isolate such a
>> folio.
>>
>> Fix by checking folio_test_mlocked() together with the existing
>> folio_test_unevictable() check.
>>
>> A similar issue has been reported by Alexander Krabler on a 6.12-rt
>> aarch64 system. Vlastimil suggested to check the mlocked flag [1].
>>
>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
> 
> Well in that thread, Hugh doubted my suggestion and then it seems we didn't
> concluded anything. Did you actually in practice observe the issue that
> Alexander had, and that this patch fixed it, or is that theoretical?
> 
Yes, I wrote a test case that can reproduce it in a few second.

The test case contains 3 steps:
1. mlockall
2. mmap file(2GB) + trigger file write page fault;
3. during step 1, trigger compact via /proc/sys/vm/compact_memory


My reproduction environment is qemu with 4GB ram, 8 core, aarch64,
preempt_rt and includes the tracepoint in patch 02.
After running the reproduction program for a few seconds, the
following output appears.

repro-403     [004] ....1   101.270505: mm_compaction_isolate_folio: pfn=0x71e3a mode=0x0 flags=referenced|uptodate|mlocked
repro-403     [004] ....1   101.270507: mm_compaction_isolate_folio: pfn=0x71e3b mode=0x0 flags=referenced|uptodate|mlocked
repro-403     [004] ....1   101.270513: mm_compaction_isolate_folio: pfn=0x71e3c mode=0x0 flags=referenced|uptodate|mlocked
repro-403     [004] ....1   101.270515: mm_compaction_isolate_folio: pfn=0x71e3d mode=0x0 flags=uptodate|mlocked
repro-403     [004] ....1   101.270517: mm_compaction_isolate_folio: pfn=0x71e3e mode=0x0 flags=uptodate|mlocked
repro-403     [004] ....1   101.270520: mm_compaction_isolate_folio: pfn=0x71e3f mode=0x0 flags=uptodate|mlocked


Unfortunately, I recently found that there is still a bug in the
fix patch. Setting mlocked in the mlock_folio function could happen
even after the page is successfully isolated, so it still cannot
prevent migration. Because of this, I need to think more about how
to fix it.

Perhaps we should double-check whether the page is mlocked during
the actual migration phase.

What do you think of this best-effort approach?


Best regards,
Wandun





The full reproducer is as below:

/* gcc repro.c -o repro -lpthread */

#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

#define PAGE_SIZE       4096
#define NR_PAGES        32
#define FILE_SIZE       (2ULL * 1024 * 1024 * 1024)

static void *worker_fn(void *arg)
{
	int fd = (long)arg;
	size_t len = (size_t)FILE_SIZE;
	char *p = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (p == MAP_FAILED)
		return NULL;

	for (size_t off = 0; off + NR_PAGES * PAGE_SIZE <= len;
	     off += NR_PAGES * PAGE_SIZE) {
		for (int i = 0; i < NR_PAGES; i++)
			p[off + i * PAGE_SIZE] = 1;
		usleep(200);
	}

	munmap(p, len);
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
	mlockall(MCL_CURRENT | MCL_FUTURE);

	int fd = open("./repro_largefile.dat", O_RDWR | O_CREAT, 0600);
	if (fd < 0)
		return 1;
	unlink("./repro_largefile.dat");
	if (ftruncate(fd, (off_t)FILE_SIZE) < 0)
		return 1;

	printf("repro_largefile: 1 worker, %d pages/batch, Ctrl-C to stop\n",
	       NR_PAGES);

	pthread_t compact, worker;
	pthread_create(&compact, NULL, compact_fn, NULL);
	pthread_create(&worker, NULL, worker_fn, (void *)(long)fd);

	pthread_join(worker, NULL);
	return 0;
}

>> ---
>>  mm/compaction.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index b776f35ad020..7e07b792bcb5 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>  		is_unevictable = folio_test_unevictable(folio);
>>  
>>  		/* Compaction might skip unevictable pages but CMA takes them */
>> -		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
>> +		if (!(mode & ISOLATE_UNEVICTABLE) &&
>> +		    (is_unevictable || folio_test_mlocked(folio)))
>>  			goto isolate_fail_put;
>>  
>>  		/*
> 

