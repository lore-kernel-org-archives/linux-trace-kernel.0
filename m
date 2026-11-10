Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330506;
	b=VpG1Qn2QTEGUNE4JiVMI0gHUs4kmLoSTyeNLWTyOIOMB57Jx7nMzJjLsJBBwKJ8UCgKr
	 rulZZnds138gQ4hNfX44+oAFNRiFRJ+vjgqFUjAD3kFBYdlUikL4QhZp6/ACwLcrrNfKD
	 jA2NiWq6gtT2XG10aSUqIExGM/Ec6BGIM9v4s02RLyT0pRcSQkIi6FvDpb+T7VzBJbzgR
	 TPVO+rS/a8dI8a7JY8iQ2C7IyD8VrFBMzIgALpjDB/ZAVispjbooIHfPYS3TF5tNMt4lp
	 Vbf40nTbDPfLuCgBFfKEunU73+DrKxC88zT2yEJTBg2A/62v54lW30DxrIhhlikFIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W4toJnlwxo6gYnBNO7MZe8ejf7vNnhvthFCmzNs0KII=;
	b=ZIMzwV4CqCpBUOA+zSN8oqh9uRvjlUEriI5sj54XhDYEt46Dwk3l2QmpicUpjsehURWN
	 3tUlgVAJMj8Z2aOgPsAjtdPMUYHaOVCIu7HLaax9vLP2cVPgP3+vL6aWe8vpxoqqhGzMc
	 bnORc63e09fqz87BKt1I27OTk0LPh4vWYIZWaoeDWErRUQd99ue5AxNSs4asR28pjiuKY
	 EDCNKciNnrkLg2ftlxWoPGnCzgNCA850pfGR+KAlE8kPI/tFSGKXJ0zDSem6YehICp9M5
	 9Mrsz+cfd65dp81ZmUiIWHY7r2rvqck5xDDZiZJoHrvyRyLaYnkeQ+7GXxb7Dv4Jsfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2lMMVu0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAC606A31C;
	Tue, 10 Nov 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2lMMVu0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA21F0089F;
	Tue, 10 Nov 2026 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330505;
	bh=W4toJnlwxo6gYnBNO7MZe8ejf7vNnhvthFCmzNs0KII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k2lMMVu0DXMibVy3EmJeXu1BBP9LzaZ+qFOkFKbiyyr7I71yF6EsgqCzDR8pdSBIo
	 qecPgaS/MhiunL7X1SEnw3lR2lTP6BwoqZk6uefjwRjRbQpIt3Utr6+IQq3CSj7pCQ
	 XuEgxQRvnh4tbyEQ9lTeLUeqX5tcFuGX7BoqIWr9+3bzH3FYABV5RskZjyVzl/TwRL
	 NC/8/5/TdYHyIGoySa9+EKyv2VRc5c3liUe3/jVGmom9XU6RvUbD5a3HLqd5U+224c
	 6gvIde6SvgNeiem1HcakWSaA3CtHngQNEUb1XPQY4lYKzm3SV68pAXSyJlGO0ENOi7
	 JSCCNvxWyTW+A==
Date: Tue, 10 Nov 2026 17:08:15 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: check for empty PTE tables before
 retracting
Message-ID: <avNO1pvPuMYIdYTE@gremlin>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-2-82926b22704c@kernel.org>
 <sashiko-outbox-203403@kernel.org>
 <28b818cb-f038-43ce-a2e2-a9c97befba09@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b818cb-f038-43ce-a2e2-a9c97befba09@kernel.org>

On Mon, Nov 09, 2026 at 04:08:23PM +0100, David Hildenbrand (Arm) wrote:
> On 11/8/26 00:51, sashiko-bot@kernel.org wrote:
> > [Severity: Medium]
> > Can removing the VM_COPY_ON_FORK flag checks here cause retract_page_tables()
> > to race with copy_page_range() during fork()?
> >
> > In dup_mmap(), the child VMA is linked into mapping->i_mmap and
> > i_mmap_unlock_write(mapping) is dropped before copy_page_range() runs.
> > vma_needs_copy() copies page tables not only when vma_has_anon_rmap() is set,
> > but also when VM_COPY_ON_FORK flags (VM_MAYBE_GUARD, VM_MAYBE_UFFD_POISON,
> > VM_UFFD_WP, or VM_UFFD_RWP) are set on a file or shmem VMA whose anon_vma is
> > still NULL.
>
> Ah, try_collapse_pte_mapped_thp() runs withe the mmap lock, whereby
> retract_page_tables() only holds the rmap lock.

[ ... ]

> > Once the PMD is pmd_none, the next fault in finish_fault() installs a huge
> > PMD before checking userfaultfd_armed(vma):
> >
> > mm/memory.c:finish_fault() {
> > 	if (pmd_none(*vmf->pmd)) {
> > 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
> > 			ret = do_set_pmd(vmf, folio, page);
> > 			if (ret != VM_FAULT_FALLBACK)
> > 				return ret;
> > 		}
> >     ...
> > 	/* Using per-page fault to maintain the uffd semantics */
> > 	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
> > 		nr_pages = 1;
> > }
> >
> > When userspace later issues UFFDIO_RWPROTECT on that file or shmem VMA,
> > change_pmd_range() sees pgtable_split_needed() is true and calls
> > __split_huge_pmd(), which zaps the file huge PMD back to pmd_none without
> > populating a PTE table (since pgtable_populate_needed() is false for
> > MM_CP_UFFD_RWP), so RWP protection is lost and subsequent accesses fault the
> > unprotected huge PMD back in without delivering RWP faults.  Installing a
> > huge PMD also causes PAGEMAP_SCAN to report all 512 pages as accessed or
> > written after a single 4KB page fault.
>
> "Since pgtable_populate_needed() is false for MM_CP_UFFD_RWP" I think RWP also
> needs proper uffd marker support, independent of the change here.

Hey,

Wondered if you planned to do a respin on this? Want to know whether to delay
review for that or not, thanks!

--
Cheers, Lorenzo
