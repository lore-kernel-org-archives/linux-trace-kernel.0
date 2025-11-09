Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2631D88A4
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Nov 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762656018; cv=none; b=ECxirbMC+VqNN4Y5p06N2dSM9szXM3sm80MbtWVyeQA+KSO2Bkk4/ddfQRFCcs9LuMr2cXjMDFXcEUD93k2QmjiGz2wx86i2I1zMjqUMS7bkQjHCI8lDRWj2uZ8CT9fnUTigmJFk20ppywmzr7igwpx5Dhl00kdIEKZA8jpPDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762656018; c=relaxed/simple;
	bh=exnwgGUjyTOwmeJou/djYuuiO8RTTslx9CZorimQ1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxsMe5THCLi8j6w1v+K6G4fsvG4pg3tcvNqynqN7YXemOA9xez/VmsMVakXKrPA+IOUgc6x5hL3doAuFramY/A3kFd542ZHwluYesKtAWC71NpxjUjx+K8bkJ2R1qfZfIcA7+5CVms15XBc/7azr+LsesFk014SC8llP8BnI72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaY/A+M+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaY/A+M+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so3886410a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 08 Nov 2025 18:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762656015; x=1763260815; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDJSjfjd98R9zyaioAZ2ttihCqA9hQAGiasYcBqo+LQ=;
        b=VaY/A+M+LZBIdV6t4UvuEsz0SNMiss/dfETjK3jkX3eKavpTqCnfcBhNkhsNMxN0T9
         rcBuw+ucmNsNwDHzfR27Z6v8UzPDiOSBctMyfDV7rk4LysRpMSJyQLEDrBIKiJ2xM73T
         fvljfCsWedFJ3fZIua/bK7QTjlv6JmY9hJiADp2ja5u2BqELqDAaBvOnyL0/SJCo/gd4
         zxaZlnwSJPJctwak1ZcA2+51lK/HVxCQqLGoagUjC3TqIlRkTzjU6gHhD7d9J80etLz2
         p6yQ1xVdyJL6dshNx08RVCL2wkTllNdZf7roYv+hn6rDPCAO3VsavXp657CdnOy4UYoq
         DrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762656015; x=1763260815;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDJSjfjd98R9zyaioAZ2ttihCqA9hQAGiasYcBqo+LQ=;
        b=FK25dospFl4bO5HepPi2AKGGlqvr9fp7n646dAqAYdbdiNbYJpX/qnqyDkEqEJHGyN
         QX+N31OdcKf8w3PR20y3WIfFtZ1dkOK95JcbJcMAbkSfcZy/UlkAmDJomzd4Vn7P0IEt
         3ybiAvvJ/HJQ5eOcXLvoDJYyLNdpzJquhPmfuEvcMjwwfDK/LaePQKuqYEneCQdlFxlc
         BI3dXYNQHeTDECwMQvl/kEZCE4doKAxiP6kZLsPv9ykxQH5pvrHdpJzDSP3SMQvVewE1
         GKNvnvp0ZY/1Cy1Wc42ClL+Ce9b6PTNr18/0BFEj/z1i5wmKKnMY0yy7ULA+MUIhw69G
         670Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy58TD3rAOfnq8ZAFLd4H+ZZAce9hgobAvlYxFnLCUIjllzW8N+1HrSGftnIgfgdJbpsyTGow7Xt10DT6VEGBPXks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3yxwjQI+r616/VoB3psaz0fQsJI6c2A218/e3AZaHC2QCxXG
	Nyz0o/mRe5eGRBe4dJgtuMfjzB0yjP2lfDh1eCuD0bxejieEAXu4z5wF
X-Gm-Gg: ASbGncuyog5Py4p5eA91DyT2odaReCWamtwvpvT14pIegyIo7AH70KVmblyOs23AbyU
	X5zmV8gGOreK09laXgQegjcEsIEgmoAu3AKGAVTcT3LJGYHusAbR/fRrKrc07cnd1CXmHwfCyt8
	Ho8mR+lMZxnXJ9kWSyifhWxMxyqOq6Gk6nJQ7Jtr8yoj70D//IdoAWQUO8Iq/+JWXAdkXfnND5P
	EYN156Yr65CrJb8DE72aAF21u+1ocqCL1YPiSxwk+jNqWn7b3kRrqtSaDNH5CeRiWAsq971ZdgD
	jFS6ksGn59kNiALa4bW/t1O8lpIrJ1DjmFsS5wOvnNw4Yr3rP6KBExo0NZI8EBQrDjZ/Jq6pIlw
	QoR8Wlnduh98BQavcpSyOi02MAdpwM7/ulvydG8gMG8Nvu5UvhD1NMdd+yvOEbM1hFhP043n4+X
	o=
X-Google-Smtp-Source: AGHT+IE2Wq8Y+ygBID6i/t3iykn6/9+oUOxVHVcNRiQ6+GmbFnEIqdu/5sD0+e0Gaz1ul5lCkjm1dQ==
X-Received: by 2002:a17:907:1c03:b0:b72:9c81:48ab with SMTP id a640c23a62f3a-b72e050415bmr364444366b.59.1762656014957;
        Sat, 08 Nov 2025 18:40:14 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcadb5sm713642666b.9.2025.11.08.18.40.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Nov 2025 18:40:13 -0800 (PST)
Date: Sun, 9 Nov 2025 02:40:13 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
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
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 13/15] khugepaged: avoid unnecessary mTHP
 collapse attempts
Message-ID: <20251109024013.fzt7xxpmxwi75xgr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-14-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-14-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:15PM -0600, Nico Pache wrote:
>There are cases where, if an attempted collapse fails, all subsequent
>orders are guaranteed to also fail. Avoid these collapse attempts by
>bailing out early.
>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---
> mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
> 1 file changed, 30 insertions(+), 1 deletion(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index e2319bfd0065..54f5c7888e46 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1431,10 +1431,39 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> 			ret = collapse_huge_page(mm, address, referenced,
> 						 unmapped, cc, mmap_locked,
> 						 order, offset);
>-			if (ret == SCAN_SUCCEED) {
>+
>+			/*
>+			 * Analyze failure reason to determine next action:
>+			 * - goto next_order: try smaller orders in same region
>+			 * - continue: try other regions at same order
>+			 * - break: stop all attempts (system-wide failure)
>+			 */
>+			switch (ret) {
>+			/* Cases were we should continue to the next region */
>+			case SCAN_SUCCEED:
> 				collapsed += 1UL << order;
>+				fallthrough;
>+			case SCAN_PTE_MAPPED_HUGEPAGE:
> 				continue;
>+			/* Cases were lower orders might still succeed */
>+			case SCAN_LACK_REFERENCED_PAGE:
>+			case SCAN_EXCEED_NONE_PTE:
>+			case SCAN_EXCEED_SWAP_PTE:
>+			case SCAN_EXCEED_SHARED_PTE:
>+			case SCAN_PAGE_LOCK:
>+			case SCAN_PAGE_COUNT:
>+			case SCAN_PAGE_LRU:
>+			case SCAN_PAGE_NULL:
>+			case SCAN_DEL_PAGE_LRU:
>+			case SCAN_PTE_NON_PRESENT:
>+			case SCAN_PTE_UFFD_WP:
>+			case SCAN_ALLOC_HUGE_PAGE_FAIL:
>+				goto next_order;
>+			/* All other cases should stop collapse attempts */
>+			default:
>+				break;
> 			}
>+			break;

One question here:

Suppose we have iterated several orders and not collapse successfully yet. So
the mthp_bitmap_stack[] would look like this:

[8 7 6 6]
       ^
       |

Now we found this one pass the threshold check, but it fails with other
result.

Current code looks it would give up at all, but we may still have a chance to
collapse the above 3 range?

> 		}
> 
> next_order:
>-- 
>2.51.0

-- 
Wei Yang
Help you, Help me
