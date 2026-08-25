Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325737C930
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676778; cv=pass; b=IyGLI+6d7dU8Eft49xTE23VEQyjyNRYdTXwDRnBbXWPtDSTfqGUlKvZwyg0ZyxJ3Kq0+IuhY1gZHQ5Tpikk/V2BwvoHQpvG71Myu1iGGORrAdtHf6jrbITD06ZbPV980BPWTUDc5BGWdAPebA4JTRvFv2yiGNwKnBGlzGFmczRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676778; c=relaxed/simple;
	bh=A5rbQUVdXmCBXh8cS9dRt5lu7uhOJRVPi0ZJmSOwvEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOYUdKosZc8K8CZ6IpZ/pv8n+XbF2I4xOqqD8r+kVXFVb3foWa9/HHt/XasudD8uv9LWhyQr92pROoBPCrKNq0y8YxgxUtxiA+8tgtd7ingEMWP1u44jE3W0Mtvo+CdkN5CnfY21gewfVEDj3rqiVnP8qfi+gkIMZGY/hV5VYpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9YPmGKX; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9YPmGKX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso128955ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 09:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787676776; cv=none;
        d=google.com; s=arc-20260327;
        b=jEI+Inh1SUFYOkNIYa3k6He0wJG1vEksgUb4G4Gi7MuErYzzRg80Y5zXsnJYznkFZf
         85pxLqKAEB983GAprf6pSs8f2t8NJlPhvLDyP9MYWSGacmEbchQTguH0DsHTRGbkjMPx
         ZhWzVhy/MRWHeMdj22Vqp6+zD1wwnnL+tDKvjIJtVUwknIU3AWMFH6xO/0eJrCEmQlKh
         Vos7EsJqHgn3Tm4PiSOmbwP5cEx2kREiL9ZZk39taVKLRF3myZBla5Nf/N8Yw2Nnf5rU
         YfzkCS8ex6zptf7oD15ow2fPMfJS+jHAcPhL8VleHXywfg3E1TBdGIIDxFCjJU8ZJdFY
         p63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ImkuahcqiET0r0yh2i1x0Wqcf5zuafLmEw6TOE3oMq4=;
        fh=HWqX7Ozs6N+V0Zm++S9QGhQBJ2AJc/JHVe+yiP/S4EQ=;
        b=jwfy//kCjdWU46Syk/EGkdT5t+Tlalk/Tng0E/oBUx32YerSMKUSmzbCSBMkxg4k/M
         J1Aj6GlSrg6StKTaf+c09d5i2iuR0i65vpCteOYy70qpbUmTFFE9+OyAUXs/7rWjAsuq
         TTi4dllJegDRKLiouC19bRtXspEa8vypobR3aJARhi1q/2Dw8wx2ivAmn4fomuBszm3/
         pK3fUKGMYYsIYL9zp9HhWMLOvI7Jz/ALJpHG5bRFUs+SFTWgaRBj5aspeE9iuu4ZVc3R
         lj6stWsw3qpMXBb6u4TAqMVgbt6UFd9MkvRLxcx2jZtK64ZYY7o+Je2J1Z1Ir/RKhQD9
         8cMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787676776; x=1788281576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImkuahcqiET0r0yh2i1x0Wqcf5zuafLmEw6TOE3oMq4=;
        b=I9YPmGKXlkGQLRB3WsRrm6J7NNac5Y+u90Dj6v+ZdElThLVs4zxZL1fwt+jZeLluVW
         eStQTJXcasyfe0DrwkPbK0ptSWcdRk9yT1cu3eNGSDNmKRVAnhBg/+bMcBD5WeL8xQ62
         JT/ugJ1GmXM/N2sJQ9hXvSivyRYjgXemLkET3pLDSqjpaju3ZAr/j6hHwRj/sH9TcrRU
         4qKriNXvh0gTl+tBUXEJyrmu79U/HLK/E8HAS4T9fltKhlMJyPJTUGZdrMIawJVIxrGC
         wN6U+a34+vO119VU+E0OBJ5BbB3CF8qNCFd//7fT3B26+3Rr0oqxt3an6xPeGc4iTB0r
         so8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676776; x=1788281576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImkuahcqiET0r0yh2i1x0Wqcf5zuafLmEw6TOE3oMq4=;
        b=pv4uBZljqjHOFJNLgBglQXjlBA7c77rOVc674cIyqqQzBTMAAPYdH9eDB+sNf/Yzjq
         ajeQ9nevHyAhQ3HA2eigNeCxk+OQYbgyzD62JqJROVeMu0DyBTUrzW6tK+a2CpTgUj6q
         ngsu8YKDyHRcInqAYFgvG0pWiwgUwlT4BY1rbfxGD/TWR532BqQWc06w6VYLvSHrAWv0
         4/2LfiINVJNAvfjS6XgjJQhy+DWqVWq62EZiHT9DpGcQAwlmxaiAUFCzP7pvJKN+v7re
         XEFi0KJqy7lro+dAsY2hfk8kidGFpP9izeOhYW7dqu5dE1pdPGdtTfcGFe04vl4+Vs0Z
         zmgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfX6DtTTfRflhbkk9bU5eHDQ5cQJv8YV3vWin46gOTkc4iVMAATo8wFiksVR82tlppUuwe8pbSwu3T/1Lp1WIH3Do=@vger.kernel.org
X-Gm-Message-State: AFuF++mo6qJqco35hcNzBljZ9zarAIb2LMokRXyYefyNEhKE0idA3Tqf
	setd/i/ezs48AfvcmjHCipWaNDRoU1o2vA5VHsRJirWFdXkvAAPfdNJ1IoC8YvqiBRp+SG6EJgA
	unpiK7SZnYhdEeCaMRluEOnKnPryH1cgMX10IQZzX
X-Gm-Gg: AR+sD12h50Am0ck2LQuyktYxXBVXyq50Thm5U8B41pG/M3UQSzKytnHGc7Khws+UoNx
	vMR7y5c+10QnHD7wpzMcYj3TLjwWEh2E7uYuTA9C8jGm5l6ArETvnB4RxCNLW/l1BOzFOilCEr/
	7bmC4K2FbHwxmwvJ2ZTAK3keYQSPN12OHOxIt6M6VCJmFpZWRYn4WG9rYOkcgWv7Ini2uQObvr6
	co551USr+nSOlGI7btT3OmzoHqjhNaumQSkKFpmw19mT6cckuNvOEWuREvVFvenAGrgKbJYT5ga
	DNrfVRAGhmczDGy/84wV/HL+UEZH4Y9dt09pTA5/5yVApbtef3uTrDysUwb+GD8HCldHFnJ7rAG
	eBK452o9ZktDS3c+6XJD6X/+Zwu0M6U2f7w4ZAnnD
X-Received: by 2002:a17:902:f705:b0:2d5:db3d:1a41 with SMTP id
 d9443c01a7336-2d6e0757d7amr9055105ad.14.1787676775185; Tue, 25 Aug 2026
 09:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816224609.308019-1-kirill@shutemov.name> <20260816224609.308019-20-kirill@shutemov.name>
In-Reply-To: <20260816224609.308019-20-kirill@shutemov.name>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 18:52:17 +0200
X-Gm-Features: AcwNN1Vvom-LUSAxEjMWXrQR9qZrcTO8aY2l_-w47SQrAcC9eH4E9yF2js957ac
Message-ID: <CAG48ez1fiCzTMATN07HHfzvUGFuZ5gELNpZXdXx=ySa7nihxmA@mail.gmail.com>
Subject: Re: [RFC PATCH 19/57] mm/collapse: install a PMD leaf as the terminal layer
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, liam@infradead.org, 
	mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, 
	usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kas@kernel.org, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 12:46=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.n=
ame> wrote:
> Fill in the PMD install.  Under the pmd lock, with the pte ptl nested
> inside it: verify, detach the table with pmdp_collapse_flush(), deposit a
> fresh one and map the leaf.
>
> That is one atomic section, so no pmd_none() window ever exists: faults

What do you mean by "atomic" and "no pmd_none() window ever exists"?
Is that supposed to be with respect to a subset of readers?

While the PMD table spinlock is held, you clear the PMD entry
(pmdp_collapse_flush) and set it to a new value
(map_anon_folio_pmd_nopf). But codepaths that walk page tables don't
take that spinlock unless they already know they're in a THP case.

zap_pmd_range() does not lock the PMD table before checking
pmd_none(), and if that is true, it skips over the PMD. I think this
means that THP collapse can race with MADV_DONTNEED or zap_vma_range()
such that the zap wrongly has no effect?

> stay held down at pte level by the migration entries throughout.  It is

But you don't have a migration entry at the PMD level, right?

> what lets PMD collapse run under mmap_read like everything else here.
>
> Two things force that nesting, which is the one the tree already uses to

I'm lost, what is "the tree"?

> reinstall a table.  A racing zap of a frozen entry takes the pte ptl, so
> the verify has to hold it.  And the table must not come apart between
> verify and detach, which is the pmd lock's job.
>
> Nothing leaves the section early, aborts included.  An abort only
> restores PTEs and would need no pmd-level exclusion of its own, except
> that its pte pointer came from pte_offset_map_rw_nolock(), whose caller
> must establish that the pmd is stable.
>
> The deposited table is the freshly allocated one, never the table just
> detached.  A deposited table has to be quiescent, because whoever
> withdraws it frees it immediately with nothing to hold a lockless walker
> off first, and a table that has never been reachable is quiescent by
> construction.
>
> The detached one is not: GUP-fast and RCU pte walks that read the old PMD
> may still be inside it, and on broadcast-TLBI architectures the flush
> expels nobody.  Quiescing it would need an IPI, which has nowhere to go
> here -- outside the pmd lock it opens the pmd_none() window this design
> does not have, inside it is a broadcast under a spinlock.  So the
> detached table goes to pte_free_defer(), which holds the free until those
> walkers finish.  One transient table page per PMD collapse is the cost.
>
> No anon_vma_lock_write() is taken, unlike the mechanism being replaced:
>
>  - rmap walks on the sources are unreachable, their refcounts frozen and
>    their folio locks held from freeze to putback;

To be clear, we can concurrently rmap-walk into the PMD, right?
Because we might be looking at a different folio which was created in
the parent process or something like that? And so a
page_vma_mapped_walk() without PVMW_SYNC might look at stale PTEs?
(Which may or may not be fine, but would not be what this commit
message claims.)

>  - non-rmap pte walkers see migration entries;
>  - pmd-level observers see either the old table or the leaf, never an
>    intermediate;

(or pmd_none(), see above)

> +       old_pmd =3D pmdp_collapse_flush(vma, cand->addr, pmd);
> +       old_table =3D pmd_pgtable(old_pmd);
[...]
> +       pgtable_trans_huge_deposit(mm, pmd, cand->deposit);
> +       map_anon_folio_pmd_nopf(cand->new_folio, pmd, vma, cand->addr);
[...]
> +out_unlock:
> +       if (pte_ptl !=3D pmd_ptl)
> +               spin_unlock(pte_ptl);
> +       pte_unmap(pte);
> +       spin_unlock(pmd_ptl);
> +
> +       /* The deposit balanced the detached table, so the count is alrea=
dy right */
> +       if (old_table)
> +               pte_free_defer(mm, old_table);

What does old_table contain at this point - migration entries? I
wonder if we should zero all the PTEs inside it before dropping its
spinlock and scheduling its freeing, so that a concurrent
pte_offset_map_rw_nolock()+spin_lock() wouldn't see dangling migration
entries. (I'm not sure if we actually have a codepath that does that,
but even if not, this seems like it might cause problems later.)
