Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794721373;
	b=QK4I15hqEBEItUGyKW8uKrM/nAXb9m9k7lolSXYzZolMWaGR+TmKurRSihVn458SRtha
	 Vk9xhHcktOAOwzztybxMHF90FTwnkzdocp1ozdTsLXsQGT5MvGCh2AHh4U4n98rWZSMBN
	 3esh9EY94r939I6XD/N/ASclj7u5xADy1cFzlWstSTqMXIVICy4gMQyd0xzl9GoVpHXy7
	 PWGs0ikNCt3kywUTOqf+m503W1Eg2CMA0XGFRQdGeAg9/0aRACuG9SBfSBDnP2WX158sL
	 AemsQTl2BvYWNjFOLNt75H3JDa/qj5hfjfs8OX1uoTWtKL7mWv78VLcFFrFuV+mMBGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794721373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nyBkJVwlUhwTxJyGO+bv5cKEFN7sPZnmNLTwTWcdOtQ=;
	b=Z9alVZeG8A62p/SayIthW4wRDybdjfOoLpUdcq6r5ism2/KkZLnv349zHEzIVwyiNE/b
	 MaEipuElHppXPvTUx75ahyNGSMsTk1ddmbTAMrkpds98LLpPPb3AI8t69rL0oHUzxmItr
	 uNXHhUbLauCiUQ8TBLyfNFTWvctmOn6FnC+bP93Zd6iaio28E/EJc4XJ09t34+it0HIG4
	 2YtxHrEdZOSkv0iCEkkLRhBpSrT+2Kc3yJZLiEYetkJ0Cl9KunazwsK6ZBroWHDW5+xNV
	 nbbj8NBkNKHGiNxTxvSmUrP5QQzw1G8z5JhxSJ+Th+Ds5YxOYt173xfs/P7JQqJRfVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LCGBC/PO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D529606A329;
	Sun, 15 Nov 2026 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCGBC/PO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9FE1F000C4;
	Sun, 15 Nov 2026 05:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794721372;
	bh=nyBkJVwlUhwTxJyGO+bv5cKEFN7sPZnmNLTwTWcdOtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCGBC/POf5Gn/rnspd1Eu2NhGBKKHCC5PeEenTKJRyjA1UBFCM1dny8zz0QppLOUM
	 HUiWHTNDTXtwkwW1OQyWllS/gQ2v0jl/x5WpfwxLL+0Q1BzwRwMyIlkhwZlBlvE/Nd
	 u783YyJBqEacJoSMuwJIlCy0bup1mHkGTtHTODpEBhAfROGZ8kPKWfgrFdV+YB5MFy
	 QY5pke4h0wswcPg0lWCW9z7Rv2iPlZabnpStD0oVk2erJMzkbG57hrs/O/pJjgnnkB
	 qIXZaGwq/OZ4+T05gvgbrOOtA288S3SeslMygDVYek2efEcTJVgcLvbLaxObJC7QL+
	 TWu2cBtCMwfug==
Date: Sun, 15 Nov 2026 07:42:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/userfaultfd: prevent poison marker loss
Message-ID: <avlGUD3Gl4UF0Upt@kernel.org>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>
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
In-Reply-To: <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>

On Sat, Nov 07, 2026 at 12:51:05AM +0100, David Hildenbrand (Arm) wrote:
> Unregistering userfaultfd leaves poison markers in the page tables.
> However, once unregistered, hugetlb PMD tables can be shared again.
> 
> Further, shmem page-table retraction can discard poison markers even
> while registered in missing mode, and fork() can skip copying page
> tables containing poison markers.
> 
> To fix it, add VM_MAYBE_UFFD_POISON and set it before installing poison
> markers. Preserve it across unregistration, splits, merges and fork(),
> just like we do with guard markers.
> 
> Use the new atomic VMA flag to disable PMD sharing and page-table
> retraction, and to force page-table copying during fork().
> 
> Move VM_UFFD_WP to bit 44 and make HAVE_ARCH_USERFAULTFD_WP depend on
> 64BIT, freeing bit 12 for the new flag on both 32-bit and 64-bit systems.
> Expose the flag as "up" in smaps.
> 
> Losing poison markers, while unpleasant, is not really fatal, and the
> use case is rather a niche thing. In addition, we rely on the atomic
> VMA flags infrastructure ... so let's not CC stable.
> 
> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 45 ++++++++++++++++++++++++--------------
>  include/linux/userfaultfd_k.h      |  7 ++++--
>  include/trace/events/mmflags.h     |  9 +++++++-
>  mm/Kconfig                         |  1 +
>  mm/khugepaged.c                    |  9 ++++----
>  mm/userfaultfd.c                   |  3 +++
>  tools/testing/vma/include/dup.h    | 20 ++++++++++++-----
>  9 files changed, 70 insertions(+), 28 deletions(-)

-- 
Sincerely yours,
Mike.
