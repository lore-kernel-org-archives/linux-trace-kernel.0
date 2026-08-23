Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67559370AC0;
	Sun, 23 Aug 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487470; cv=none; b=HM1Uisky1AzZ943BMC3kf/JJ9byDBzvOERO1PfdZCJerSc2r9ykeihiXY70pjU2/Hr6EBGJ9jgYa9j8q37UykSF8mhv21TV2V0D56K8u2UWEarRJz4CUhkJdXblwLg9QuGdSBRp0xBOlcN3ReUtLzIH6GgwseGlEnlRrregtzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487470; c=relaxed/simple;
	bh=eKAV72nZkWs2TRtONUdCzTVplQjmUbvGS+hhJXUd1GM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWyNtrL4ApQnBKnwectgmrF7LRkNWkzg9sxy8GQyCpDEvAGEQWaw7EWXFkcBTKHGL9mGrLitrMMATlhXlkoEIEgup9JzYwhU34ZP5Z9pSzYnNPDmnKDiMlX58SgHQ4JtubzBhUgx+JeDk7j4PokvLvzNTPFF8mUl/YXncSeOrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=incwjgAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="incwjgAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CB1F000E9;
	Sun, 23 Aug 2026 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787487469;
	bh=isHahu0jRpz1uJRo3YiAtHQCbGtLanBl+0E0+Ww+aJY=;
	h=From:Subject:Date:To:Cc;
	b=incwjgAz5Ue8ij1brw1X3z2ppJxMCEPKvIC3rX+6eD2cf5WTGs4dVlnC2PKtLi5TP
	 BtSRA5GJLHQMzRwlD/TTjJBV2nWXFc1tFOFl0b/XrLncxN2MA1ulizkXqmkSLbzX0U
	 2N8k6dbYZ1MInvsdysbJBV0QIObtMDHJGZQOuyYSpOR4B32mGWI0PaftaM35oXhwzE
	 UDbdYQpGfBKVVYc+ImPluq5zlYUjhit9jaDYt+C3iCY4jBrQJgHkYulR+oL4BGIkuu
	 o/UA+3eMC9dAbBjbiP65GCJD0kL2AtYqRRnrOt7Wd0uWXSbbMjyXofMnOwKy3ff3q0
	 3IqcaSoBw6X0w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/6] userfaultfd: decouple uffd mode from VMA flags
Date: Sun, 23 Aug 2026 15:17:37 +0300
Message-Id: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrDIBBFfyXMukOjQgn9ldKFjzGxRFMclULIv
 9e0y3O55+zAlAMx3IcdMrXAYUsdxGUAu+g0EwbXGeQob+MkFVbvHbaIftUzYxNIpEgoYdQkHHT
 tncmHzy/5eP6Zq3mRLWfnfBjNhCbrZJdzinEr8Roj1sRFm5XgOL5rdDpBmAAAAA==
X-Change-ID: 20260823-uffd-vm-flags-v1-ee3e131b381d
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Muchun Song <muchun.song@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>, 
 Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev

Currently userfault related VMA flags have multiple meanings:
* identify VMAs that are registered with userfaultfd
* and also how exactly VMA is registered with uffd
* and also communicate kind of user fault between the page fault handler
  and handle_userfault()

Introduce an enum for user fault reasons and move the registration mode
into per VMA vm_uffd_state structure today known as vm_userfaultfd_ctx.

---
Mike Rapoport (Microsoft) (6):
      mm/gup: move gup_can_follow_protnone() to gup.c
      userfaultfd: constify VMA parameter of userfaultfd_*() helpers
      userfaultfd: use userfaultfd_*() helpers instead of open coded flag tests
      userfaultfd: rename vm_userfaultfd_ctx to vm_uffd_state
      userfaultfd: decouple fault reason from VMA flags
      userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP} into single VM_UFFD

 Documentation/mm/process_addrs.rst |   4 +-
 fs/proc/task_mmu.c                 |  18 +--
 include/linux/mm.h                 | 105 +++--------------
 include/linux/mm_types.h           |  11 +-
 include/linux/pgtable.h            |   4 +-
 include/linux/userfaultfd_k.h      | 155 ++++++++++++++-----------
 include/trace/events/mmflags.h     |  17 +--
 include/uapi/linux/userfaultfd.h   |   6 +-
 mm/gup.c                           |  39 +++++++
 mm/huge_memory.c                   |   6 +-
 mm/hugetlb.c                       |  12 +-
 mm/khugepaged.c                    |   2 +-
 mm/memory.c                        |  16 +--
 mm/mprotect.c                      |   2 +-
 mm/mremap.c                        |   4 +-
 mm/shmem.c                         |   6 +-
 mm/userfaultfd.c                   | 225 +++++++++++++++++++------------------
 mm/vma.c                           |   4 +-
 mm/vma.h                           |   6 +-
 mm/vma_init.c                      |   4 +-
 tools/testing/vma/include/dup.h    |  20 ++--
 tools/testing/vma/include/stubs.h  |   6 +-
 22 files changed, 323 insertions(+), 349 deletions(-)
---
base-commit: 4b2ae13f3393ef4b4bce0021e8762790354f369f
change-id: 20260823-uffd-vm-flags-v1-ee3e131b381d

--
Sincerely yours,
Mike.

