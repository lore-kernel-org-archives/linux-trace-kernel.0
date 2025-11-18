Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB8320CAC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431243; cv=none; b=Uz2VBXYCvLu2XJIwaR2erdNpQn85OOVMEEDFvkBWqn7ifxaJJW5Og3lEh+5lltE9c3Id4NtQmGgkwLqVALO4ACUakZK14H/ayKMOt9PWRRHhs3DIDG5MDzJh/flGmF10OAMSIe0TUx1VmKGMRoF5smF9LAABoH8YGxjlH11DpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431243; c=relaxed/simple;
	bh=kaylDlwQl1VqEc/tlQkL21uVVJ3iIahDpahKHEmXXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMqN4BENXtGCrJW1v2ltdL4/PXLyNAscHGOYdG7fTEIIhUkkSBJ+5FeZtRivO0KPH0wFURJsQLZCgSvpQoOUtTlRlwvLkr0hcSFj8kPElE60RI7M8pdWivV4SCrg6+XxtI22SKJqA0ymRLim2V3kJZ9l/zsL8BqvHnszAqnOptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzr1Exz2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzr1Exz2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7373fba6d1so519031466b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 18:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431237; x=1764036037; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjtZZ70/Qu6YbmmA5LKoN6Z9gQ7S03ZL5L4ASTauTjE=;
        b=Gzr1Exz2UtCbx9H8bYllUE7F8FfsmpCgPHLF3mH8yNdxr4DqsLcSrrh8ZZFlqzWia5
         TqBH56SKYbDyYwN5DF1HaRggjz5d7baptmy0NZMDlUtyf5prJ8DD9zZssUnw/SvXIjPn
         jiQSlv/hSF09d7ycR9rRAxojY8gUvBofMOPSslLEYQ2LmzXS98s3csbtsbp6ANPdiLDI
         0B+3RDBBPddzP+Qoj8Fv79+TsC2CR4tR9tGIjYuEbtcOXKr53QhsoFfGNhN7mDrcAuGv
         hTYUUUrdXwRIQoo+reliu54M3GAQDH37YuO1mSZUq3R/AVxiWXBhGX1Kg4hHPrf+MX28
         dr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431237; x=1764036037;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjtZZ70/Qu6YbmmA5LKoN6Z9gQ7S03ZL5L4ASTauTjE=;
        b=LeYb6IE8UoAvPL0mtyCIr3yvTooxJo+mhjNKsKUhvrSq5AnUNUz6NX5K/PQCFIJfkE
         6d/5yCiIUv5pXtpXNevg1PIg+dpL66YDl1PwG8MKdSgzECubE9ufr98dZY93asK+bvO6
         3+oeDU9dpvFQQfqxXWsW9MZtpkLrMGRSc3pOdGCk9AdfeZ9A8dtIKEfQ6Iqm8FNLSi3z
         OtDVvl1AAedXPxZec/ngI51e21VpFUqxHbjld9Fn2n9cT2L7v4SMf2rqsBQ+GeN0lLxT
         GcieO8MomXy6XA9cfsSJX+Bsxlm3Oisu0E4pbAEoKAC7MC9S8k+TeNc3qklRcokNEVpG
         01pA==
X-Forwarded-Encrypted: i=1; AJvYcCXjlT/gmP2Dw0J6HYiXdqTKmNtB0KHQSwyoJDeygVPcwJiDoL/D4KnyjcD9DAtS849CW3UAZtqnyp3whzbTL90Ckyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWb6XneHDMTgZ2VaxYr6f2RRKsv6kbz1lxw2wIl4dgetxPFP5
	ohWFMSdWiV8FVUZZWFwnb/Jj1H1vZpe01uiiplHhJ+tIrgeOtQEwRjuW
X-Gm-Gg: ASbGncuisf7i6TEdfvO3lVHrbk0k8LVaqi14fBWhS2a/MMuYbkio9lQHbftJZZ/0gAn
	LYY06gqoC4vR5csLCjr/16J1FjjzzrkYHgquh+Vgz3hT+Z58oQaTy33VrMisSL3nPgQoxE5nU+3
	nnOwU9p+woz48vwM+dpJwon9AZP8XjmT/wtbl8uUa5e1khx9C/hbc3lKn8PruDUjqZdbCOAMQiU
	IZUQJeuymY8aeZgdXRLMg8NgX7BeQtX98u1CF6XKJUbjYzl5/f2JCeFFKGuQL+rBl+isk8wAiLj
	WzWcL0NbYJcBKqAOzyy/ZaKjWqQ1X8YyKFkCeGfiNQHVZRqeSm26mzrPKsNHGHQxRUlMp8/pxKJ
	7QHEVDjjW+pVybP4VAF8cmgd6/Upiv6B0FuzaMXDaVXUGaacsEOKsmJSHnPMDfuaoxxyl3nmg8V
	5E+TAuaXrz7YZHCg==
X-Google-Smtp-Source: AGHT+IEIbHsmAR4qI1U7kAkJFbuJ0gMBeLqnpNcnfrzyBKIrXirysQ6AKJVPv8sKWVks0bFN76WI/A==
X-Received: by 2002:a17:907:d18:b0:b73:9b4a:5c02 with SMTP id a640c23a62f3a-b739b4a5cb6mr723067766b.49.1763431237209;
        Mon, 17 Nov 2025 18:00:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd7f37bsm1199178666b.35.2025.11.17.18.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
Date: Tue, 18 Nov 2025 02:00:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org,
	jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 13/15] khugepaged: avoid unnecessary mTHP
 collapse attempts
Message-ID: <20251118020034.rdgisvkqs53lwabz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-14-npache@redhat.com>
 <20251109024013.fzt7xxpmxwi75xgr@master>
 <CAA1CXcA9zaGqLPHnJWH=fKPUjb02dV+rKgfmsRZOGdeukiC8eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcA9zaGqLPHnJWH=fKPUjb02dV+rKgfmsRZOGdeukiC8eg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Nov 17, 2025 at 11:16:53AM -0700, Nico Pache wrote:
>On Sat, Nov 8, 2025 at 7:40 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Wed, Oct 22, 2025 at 12:37:15PM -0600, Nico Pache wrote:
>> >There are cases where, if an attempted collapse fails, all subsequent
>> >orders are guaranteed to also fail. Avoid these collapse attempts by
>> >bailing out early.
>> >
>> >Signed-off-by: Nico Pache <npache@redhat.com>
>> >---
>> > mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
>> > 1 file changed, 30 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> >index e2319bfd0065..54f5c7888e46 100644
>> >--- a/mm/khugepaged.c
>> >+++ b/mm/khugepaged.c
>> >@@ -1431,10 +1431,39 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
>> >                       ret = collapse_huge_page(mm, address, referenced,
>> >                                                unmapped, cc, mmap_locked,
>> >                                                order, offset);
>> >-                      if (ret == SCAN_SUCCEED) {
>> >+
>> >+                      /*
>> >+                       * Analyze failure reason to determine next action:
>> >+                       * - goto next_order: try smaller orders in same region
>> >+                       * - continue: try other regions at same order
>> >+                       * - break: stop all attempts (system-wide failure)
>> >+                       */
>> >+                      switch (ret) {
>> >+                      /* Cases were we should continue to the next region */
>> >+                      case SCAN_SUCCEED:
>> >                               collapsed += 1UL << order;
>> >+                              fallthrough;
>> >+                      case SCAN_PTE_MAPPED_HUGEPAGE:
>> >                               continue;
>> >+                      /* Cases were lower orders might still succeed */
>> >+                      case SCAN_LACK_REFERENCED_PAGE:
>> >+                      case SCAN_EXCEED_NONE_PTE:
>> >+                      case SCAN_EXCEED_SWAP_PTE:
>> >+                      case SCAN_EXCEED_SHARED_PTE:
>> >+                      case SCAN_PAGE_LOCK:
>> >+                      case SCAN_PAGE_COUNT:
>> >+                      case SCAN_PAGE_LRU:
>> >+                      case SCAN_PAGE_NULL:
>> >+                      case SCAN_DEL_PAGE_LRU:
>> >+                      case SCAN_PTE_NON_PRESENT:
>> >+                      case SCAN_PTE_UFFD_WP:
>> >+                      case SCAN_ALLOC_HUGE_PAGE_FAIL:
>> >+                              goto next_order;
>> >+                      /* All other cases should stop collapse attempts */
>> >+                      default:
>> >+                              break;
>> >                       }
>> >+                      break;
>>
>> One question here:
>
>Hi Wei Yang,
>
>Sorry I forgot to get back to this email.
>

No problem, thanks for taking a look.

>>
>> Suppose we have iterated several orders and not collapse successfully yet. So
>> the mthp_bitmap_stack[] would look like this:
>>
>> [8 7 6 6]
>>        ^
>>        |
>
>so we always pop before pushing. So it would go
>
>[9]
>pop
>if (collapse fails)
>[8 8]
>lets say we pop and successfully collapse a order 8
>[8]
>Then we fail the other order 8
>[7 7]
>now if we succeed the first order 7
>[7 6 6]
>I believe we are now in the state you wanted to describe.
>
>>
>> Now we found this one pass the threshold check, but it fails with other
>> result.
>
>ok lets say we pass the threshold checks, but the collapse fails for
>any reason that is described in the
>/* Cases were lower orders might still succeed */
>In this case we would continue to order 5 (or lower). Once we are done
>with this branch of the tree we go back to the other order 6 collapse.
>and eventually the order 7.
>
>>
>> Current code looks it would give up at all, but we may still have a chance to
>> collapse the above 3 range?
>
>for cases under /* All other cases should stop collapse attempts */
>Yes we would bail out and skip some collapses. I tried to think about
>all the cases were we would still want to continue trying, vs cases
>where the system is probably out of resources or hitting some major
>failure, and we should just break out (as others will probably fail
>too).
>

Thanks, your explanation is very clear.

>But this is also why I separated this patch out on its own. I was
>hoping to have some more focus on the different cases, and make sure I
>handled them in the best possible way. So I really appreciate the
>question :)
>
>* I did some digging through old message to find this *
>
>I believe these are the remaining cases. If these are hit I figured
>it's better to abort.
>

I agree we need to take care of those cases.

>/* cases where we must stop collapse attempts */
>case SCAN_CGROUP_CHARGE_FAIL:
>case SCAN_COPY_MC:
>case SCAN_ADDRESS_RANGE:
>case SCAN_PMD_NULL:
>case SCAN_ANY_PROCESS:
>case SCAN_VMA_NULL:
>case SCAN_VMA_CHECK:
>case SCAN_SCAN_ABORT:
>case SCAN_PMD_NONE:
>case SCAN_PAGE_ANON:
>case SCAN_PMD_MAPPED:
>case SCAN_FAIL:
>
>Please let me know if you think we should move these to either the
>`continue` or `next order` cases.

Take a look into these cases, it looks good to me now.

Also one of my concern is this coding style is a little hard to maintain. In
case we introduce a new result, we should remember to add it here. Otherwise
we may stop the collapse too early.

While it maybe a separate work after this patch set merged.

>
>Cheers,
>-- Nico
>
>>
>> >               }
>> >
>> > next_order:
>> >--
>> >2.51.0
>>
>> --
>> Wei Yang
>> Help you, Help me
>>

-- 
Wei Yang
Help you, Help me
