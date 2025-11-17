Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEC262808
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403444; cv=none; b=hyxLPeCqm4ySUxeQ4wqpINpnjkclvMR98AEGF+a7whII1W0CWEEAnjeu1pmDfuMnmTHx+o8uBrXHBQ5pp59+oJejcf9Ed0MOFXHBn8NZL1xjSfdxMg69C9xCZ88VJmwp5uBmPC5Pfj0W9iaZEoYysitcmz/tDQvrd13BXq+QXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403444; c=relaxed/simple;
	bh=YKpLpfQbjFweo5Huh4CKbCJxqw4yu2d6FrCGYDymEfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mtxkdb5+1f0e+mK+1pgtdnFz8BMwHLrGZgnBe323mA8nEhBiPqx6Phjf7soxYYntyqFf1B9JLHwFhP1djecrHwcNlcsKUKzwpEROkNy33NLJzFPEb62LrXQM4B60DzfD+otrHM5vuXqVTaxK+tx4PdrRl852f8qNIrBPmlrBEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kq2QDaJ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq2QDaJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763403441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLkBFyQphttyBlL0MaxtfpIa2M3df8GEH89TkAXYszg=;
	b=Kq2QDaJ+8++4msg+4EuZwhC1u2yQuys2/FjUWgL6pCq+kjpSNqNzL3uE65SId+0AMAqUyx
	94d5Nw5lIJgxbkszpoFAwW3vLnJ+aM6pN8UujZKzxj5aHCqEdLFT13lzQdQwLcGtGIrH4X
	h0MAj6hi1BaSJtyAPoEAfJCocL7dwto=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-c-dywP6-NJeLeWbKRWzYpA-1; Mon, 17 Nov 2025 13:17:20 -0500
X-MC-Unique: c-dywP6-NJeLeWbKRWzYpA-1
X-Mimecast-MFC-AGG-ID: c-dywP6-NJeLeWbKRWzYpA_1763403439
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63de18a36f1so6506230d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 10:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403439; x=1764008239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLkBFyQphttyBlL0MaxtfpIa2M3df8GEH89TkAXYszg=;
        b=H75KZtzaitXmTjEacIVdUeVVzlSoK/QtBsPiKq3U4Hu/E4dYzo3pF4HuDV78oLBml1
         vBEfQzOIHKYeb+c/g7mPpaEI51j2xEkN9U4dADDl/yYvQqbHZyynv1pcAdgxiqSrf2Xf
         rZ4qMuptHS//fO5Q/rBgfVQu5/HGNsGFkpEBDSCzUsjPfiQOw3px2cX6iHrgltVKrHtq
         Lzu0EOI65OV9Dy5xf+AOPjR67DEBkm8yVm75OwVEwb7C0pZbWXQJVtgVl/ZK8b52FNX3
         fZGYfZ8F9Fo2Nmrc4DQTfCwIDFOMgCxnoEYUE0FYAQhto+5GNMNRlN9DJi+mOmlihB2a
         RE8w==
X-Forwarded-Encrypted: i=1; AJvYcCUUK52uZ6uLJqihRADIJMCkNxWs0FDjtamd3uuu1zgM1YmUw4tEJHS7lxU9wyEL5zfiU3p6zTMe9JrM7A2PUq3rWko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlpfRoM+T9cd7cE/2BU7FMyEbPc2jTOp0x41OAc0xtL7LLFlo
	V6bXBj3w2vWLPtRndkjTceUEnCAqEYOaTu2IGZoCExtLCQ+eQOHM+lFpNL/dyOzE1tgT5Rvh0fQ
	wBZ6LD07RZGn2eDQmud+PFUPZJa2oRt8vK5We1Qc6XjOJJnQmPdpWJhT79fERaXG3Ph0MtiCtcL
	vXl2q7aD2tp5Z/eh4DENLMr5YeI6Ed5tcRjULAupLc84UH8JsP
X-Gm-Gg: ASbGncu+cEnKexmahw1cd+EgLSrEt+T0rgAaybDGQGF5HIjPVit7YHoL8w16orpev33
	fxBKi33ihMpM61dGSbLWgvSQIpsOWU7bNA23GjD7boNn0iwLUsbhAhkDF6rFwWQac68Tvn6MTG5
	q5r/t/q6rHSVQuoM+WshzXJEi4EB5Uh1SyWsJHUqMhCyQCJTwB1P1rXP+QVMkbp38EpM7j4Q==
X-Received: by 2002:a05:690e:d8a:b0:629:acb6:d8a with SMTP id 956f58d0204a3-641e7562fd0mr10867459d50.26.1763403439608;
        Mon, 17 Nov 2025 10:17:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqkBOn29yUwcPzlRUfZrCy2cM1EilWOd6JVaHoD7tCDRXb4G11MerU3OGL9P/y0HInk6+3E4wc78Xi4FqeiDU=
X-Received: by 2002:a05:690e:d8a:b0:629:acb6:d8a with SMTP id
 956f58d0204a3-641e7562fd0mr10867430d50.26.1763403439239; Mon, 17 Nov 2025
 10:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-14-npache@redhat.com>
 <20251109024013.fzt7xxpmxwi75xgr@master>
In-Reply-To: <20251109024013.fzt7xxpmxwi75xgr@master>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Nov 2025 11:16:53 -0700
X-Gm-Features: AWmQ_bnbDA-LvF9eb5QkiR_KgOmDIKODHM2kGY-8vhaQuyICX8DSbvUaiKBYszo
Message-ID: <CAA1CXcA9zaGqLPHnJWH=fKPUjb02dV+rKgfmsRZOGdeukiC8eg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 13/15] khugepaged: avoid unnecessary mTHP
 collapse attempts
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com, 
	pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nv2Pfu-3fXpGVSeOGzSHFlY5Iw0LDaRkH4-mCoSXtOM_1763403439
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 7:40=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 12:37:15PM -0600, Nico Pache wrote:
> >There are cases where, if an attempted collapse fails, all subsequent
> >orders are guaranteed to also fail. Avoid these collapse attempts by
> >bailing out early.
> >
> >Signed-off-by: Nico Pache <npache@redhat.com>
> >---
> > mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
> > 1 file changed, 30 insertions(+), 1 deletion(-)
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index e2319bfd0065..54f5c7888e46 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
> >@@ -1431,10 +1431,39 @@ static int collapse_scan_bitmap(struct mm_struct=
 *mm, unsigned long address,
> >                       ret =3D collapse_huge_page(mm, address, reference=
d,
> >                                                unmapped, cc, mmap_locke=
d,
> >                                                order, offset);
> >-                      if (ret =3D=3D SCAN_SUCCEED) {
> >+
> >+                      /*
> >+                       * Analyze failure reason to determine next actio=
n:
> >+                       * - goto next_order: try smaller orders in same =
region
> >+                       * - continue: try other regions at same order
> >+                       * - break: stop all attempts (system-wide failur=
e)
> >+                       */
> >+                      switch (ret) {
> >+                      /* Cases were we should continue to the next regi=
on */
> >+                      case SCAN_SUCCEED:
> >                               collapsed +=3D 1UL << order;
> >+                              fallthrough;
> >+                      case SCAN_PTE_MAPPED_HUGEPAGE:
> >                               continue;
> >+                      /* Cases were lower orders might still succeed */
> >+                      case SCAN_LACK_REFERENCED_PAGE:
> >+                      case SCAN_EXCEED_NONE_PTE:
> >+                      case SCAN_EXCEED_SWAP_PTE:
> >+                      case SCAN_EXCEED_SHARED_PTE:
> >+                      case SCAN_PAGE_LOCK:
> >+                      case SCAN_PAGE_COUNT:
> >+                      case SCAN_PAGE_LRU:
> >+                      case SCAN_PAGE_NULL:
> >+                      case SCAN_DEL_PAGE_LRU:
> >+                      case SCAN_PTE_NON_PRESENT:
> >+                      case SCAN_PTE_UFFD_WP:
> >+                      case SCAN_ALLOC_HUGE_PAGE_FAIL:
> >+                              goto next_order;
> >+                      /* All other cases should stop collapse attempts =
*/
> >+                      default:
> >+                              break;
> >                       }
> >+                      break;
>
> One question here:

Hi Wei Yang,

Sorry I forgot to get back to this email.

>
> Suppose we have iterated several orders and not collapse successfully yet=
. So
> the mthp_bitmap_stack[] would look like this:
>
> [8 7 6 6]
>        ^
>        |

so we always pop before pushing. So it would go

[9]
pop
if (collapse fails)
[8 8]
lets say we pop and successfully collapse a order 8
[8]
Then we fail the other order 8
[7 7]
now if we succeed the first order 7
[7 6 6]
I believe we are now in the state you wanted to describe.

>
> Now we found this one pass the threshold check, but it fails with other
> result.

ok lets say we pass the threshold checks, but the collapse fails for
any reason that is described in the
/* Cases were lower orders might still succeed */
In this case we would continue to order 5 (or lower). Once we are done
with this branch of the tree we go back to the other order 6 collapse.
and eventually the order 7.

>
> Current code looks it would give up at all, but we may still have a chanc=
e to
> collapse the above 3 range?

for cases under /* All other cases should stop collapse attempts */
Yes we would bail out and skip some collapses. I tried to think about
all the cases were we would still want to continue trying, vs cases
where the system is probably out of resources or hitting some major
failure, and we should just break out (as others will probably fail
too).

But this is also why I separated this patch out on its own. I was
hoping to have some more focus on the different cases, and make sure I
handled them in the best possible way. So I really appreciate the
question :)

* I did some digging through old message to find this *

I believe these are the remaining cases. If these are hit I figured
it's better to abort.

/* cases where we must stop collapse attempts */
case SCAN_CGROUP_CHARGE_FAIL:
case SCAN_COPY_MC:
case SCAN_ADDRESS_RANGE:
case SCAN_PMD_NULL:
case SCAN_ANY_PROCESS:
case SCAN_VMA_NULL:
case SCAN_VMA_CHECK:
case SCAN_SCAN_ABORT:
case SCAN_PMD_NONE:
case SCAN_PAGE_ANON:
case SCAN_PMD_MAPPED:
case SCAN_FAIL:

Please let me know if you think we should move these to either the
`continue` or `next order` cases.

Cheers,
-- Nico

>
> >               }
> >
> > next_order:
> >--
> >2.51.0
>
> --
> Wei Yang
> Help you, Help me
>

