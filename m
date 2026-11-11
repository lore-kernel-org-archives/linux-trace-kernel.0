Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385077;
	b=vP3BI+YUDXwQ72pzj/hMF5Qq6v0Tz8nwEy1LZTgTx6vx0mJZDvxU4/wmx2RIyKeM9Wly
	 4v9CPtJBnoTFQXLWdo3NCtrf1GIbKe9nNoJhEyErYszMH0+R3/kQ+jOngXxmqo4ZeIT9w
	 HhjqvDhIpOz3HQ6QNz3w0kekRw3x5uE2dEkuPX8KUTown1KNamHZdAXrj1NrKx3vlYDSI
	 QL3Ii/RXw6vIFrdcJCIfkAbDaqwZtYRbyXvu7ysYFsyMo9ikROTfbGicPA0JVqqKveUcQ
	 xUZRcGN9gOtCXclbXcTNyUq7ObDc6Nh7k1W3oU48rJ+3r497l8Vd4JbwmwCIJARnMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385077;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JjqXs3HoQpEHN6otr6mHB8M84/EWiaNnxYY5mSAu4Q0=;
	b=lyf9/JNNVISEEobd/FkkOYS6lYUhgC6KPJi7kB/55/E1xsM9k7pg7/YNLtPu9TR/+PrC
	 3SoE6uN+Eyuq6QeQIrsBY7Vd29atVLhz9tFftqcGfoSqeDYdGHBJBmYAHvpcVBgAceDlH
	 /RUah1pExeY8zKCy/+3lveH+/KsjqXpBJuySws7Pg+W4LtmRxSH0h3x7++NOhb2WEIZX6
	 m6DxAP0I4vpX+RBAqYwLWofCXg0aj6z5LP9iRDoHkUD8JtZO9GbJ+JpTtgttkg3RAJAXZ
	 adaBaLB2myLwhGwxuGYK/Zp8LG3QnmWwbpkxqLk5md7EjoMPH1q/ai2v+bt9C126BzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0lg2dMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0C606A320;
	Wed, 11 Nov 2026 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0lg2dMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DBA1F00A05;
	Wed, 11 Nov 2026 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385076;
	bh=JjqXs3HoQpEHN6otr6mHB8M84/EWiaNnxYY5mSAu4Q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z0lg2dMzPTK2I/fb78yKkOyDefR41RgDE6wgeC5vIbTKMnC3M7veH0J5PL0PnYO2r
	 UkrfGCByL7Wya/iziyNm/lHZOO9yKX6OgBvNZbZL5ASWu3hoM1UJ+7XTFSGXN3emB+
	 ivyOa/JbkeIgjkMKGAUZtsx2Cw/AUyKiRfoEoIKmrWUleGk3J+7Xk0bnjcWqrQ3Hc7
	 f4ZFLrznIqd2imPtCkvhJ6mPRraoc+xDyd7RyX2ECrEXXcEUu9xqzpuoeUgfnqhsL9
	 6dBC3QVeNEdRJ6p/ZznhT2vi5iihjT712vi0Do7Utqd8Pa5MdMnSqSxhh9D7eAE8YS
	 MDVSudr6R6u7w==
Message-ID: <cd873616-28b4-4c81-95be-2a239d8680b3@kernel.org>
Date: Wed, 11 Nov 2026 09:17:42 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/khugepaged: check for empty PTE tables before
 retracting
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-2-82926b22704c@kernel.org>
 <sashiko-outbox-203403@kernel.org>
 <28b818cb-f038-43ce-a2e2-a9c97befba09@kernel.org> <avNO1pvPuMYIdYTE@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avNO1pvPuMYIdYTE@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 18:08, Lorenzo Stoakes (ARM) wrote:
> On Mon, Nov 09, 2026 at 04:08:23PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/8/26 00:51, sashiko-bot@kernel.org wrote:
>>> [Severity: Medium]
>>> Can removing the VM_COPY_ON_FORK flag checks here cause retract_page_tables()
>>> to race with copy_page_range() during fork()?
>>>
>>> In dup_mmap(), the child VMA is linked into mapping->i_mmap and
>>> i_mmap_unlock_write(mapping) is dropped before copy_page_range() runs.
>>> vma_needs_copy() copies page tables not only when vma_has_anon_rmap() is set,
>>> but also when VM_COPY_ON_FORK flags (VM_MAYBE_GUARD, VM_MAYBE_UFFD_POISON,
>>> VM_UFFD_WP, or VM_UFFD_RWP) are set on a file or shmem VMA whose anon_vma is
>>> still NULL.
>>
>> Ah, try_collapse_pte_mapped_thp() runs withe the mmap lock, whereby
>> retract_page_tables() only holds the rmap lock.
> 
> [ ... ]
> 
>>> Once the PMD is pmd_none, the next fault in finish_fault() installs a huge
>>> PMD before checking userfaultfd_armed(vma):
>>>
>>> mm/memory.c:finish_fault() {
>>> 	if (pmd_none(*vmf->pmd)) {
>>> 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
>>> 			ret = do_set_pmd(vmf, folio, page);
>>> 			if (ret != VM_FAULT_FALLBACK)
>>> 				return ret;
>>> 		}
>>>     ...
>>> 	/* Using per-page fault to maintain the uffd semantics */
>>> 	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
>>> 		nr_pages = 1;
>>> }
>>>
>>> When userspace later issues UFFDIO_RWPROTECT on that file or shmem VMA,
>>> change_pmd_range() sees pgtable_split_needed() is true and calls
>>> __split_huge_pmd(), which zaps the file huge PMD back to pmd_none without
>>> populating a PTE table (since pgtable_populate_needed() is false for
>>> MM_CP_UFFD_RWP), so RWP protection is lost and subsequent accesses fault the
>>> unprotected huge PMD back in without delivering RWP faults.  Installing a
>>> huge PMD also causes PAGEMAP_SCAN to report all 512 pages as accessed or
>>> written after a single 4KB page fault.
>>
>> "Since pgtable_populate_needed() is false for MM_CP_UFFD_RWP" I think RWP also
>> needs proper uffd marker support, independent of the change here.
> 
> Hey,
> 
> Wondered if you planned to do a respin on this? Want to know whether to delay
> review for that or not, thanks!

Let's move forward with patch #1 for now. Patch #2 is mostly a cleanup on top
that can wai.

-- 
Cheers,

David
