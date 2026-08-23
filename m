Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D9370AC0;
	Sun, 23 Aug 2026 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487486; cv=none; b=O/kbGAvhKUBhNp5moZeLlBrjYZv5l5IyBriB4J8XYg8Z0SrHWVLFY0yr8HnWYYdOcu/yCsQgv9gbgGKLDvuLgzAzFYPjvIO4W7gpoO2CrNBrfVF+iczozC5rdjMkS1hWR93p8bcE4QGc+aTOzxOYukAfxYkiifxCQGt7+2hNgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487486; c=relaxed/simple;
	bh=dbBYm+aOrSlQd/YFVsrZ8xIVQNUwkL/QqULON7EGjzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crr57pdsVuvE9HeBP1b4m67KTXAel9KShjWgFLlNWpPe/65tfWcBvuUIcDjiJHJqpNuq4G8RRTQFeZ7vzRLiJel1Cu+0QiVrVMTjIfmPVeSerp4ugbsdvyft9zxDeSrNBJARHlR97UHebwYc6t97gW+Hy/1gKpI0FitgUATdJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh4r+QK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh4r+QK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DCB1F000E9;
	Sun, 23 Aug 2026 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787487485;
	bh=kndwtv5Cm5Svk82exojGXyoNLdRzxaTi6Z5eoExMZW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hh4r+QK2GdpFEuv6ihYd8/+0ZW1NQU+UeKZdTxUMtpnRo78N4CPidoNDY5bHIHEh7
	 R2QKLcipnEJbDJbbS/Dryi1+nkvs1RVC1oV64SnN7k2nbxm32zx8oGLesqLons5Z1x
	 2N743kbgL182hjg41CyjOn542aZh8zZCGbLPjXBGPpUuHth2xsSL+YIvT3nZoXK0qB
	 nyoOjCJERvpXxA2wQcf5+ArmjXQXhaDd1jr/iBCUxiuFkUuo6Bany7IjY+sHLJobD7
	 kWXhJOkJCu06p9sKN9b9omMLEuVZzBXGdQqUa6awxh/fuEgRLWRTd6XAExltaipQcH
	 DRctSy1CvIbDw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 23 Aug 2026 15:17:39 +0300
Subject: [PATCH 2/6] userfaultfd: constify VMA parameter of userfaultfd_*()
 helpers
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
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

userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected() only
read the VMA.

Make their vma parameter const.

No functional change.

Assisted-by: copilot:claude-opus-5
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/userfaultfd_k.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a4351cffc60c..3396d270b159 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -204,22 +204,22 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 					VMA_UFFD_MINOR));
 }
 
-static inline bool userfaultfd_missing(struct vm_area_struct *vma)
+static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
 }
 
-static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma, VMA_UFFD_WP);
 }
 
-static inline bool userfaultfd_minor(struct vm_area_struct *vma)
+static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
 }
 
-static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
+static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
 {
 	/*
 	 * Callers gate PAGE_NONE usage on this; PAGE_NONE is a BUILD_BUG()
@@ -230,7 +230,7 @@ static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
 	return vma_test_single_mask(vma, VMA_UFFD_RWP);
 }
 
-static inline bool userfaultfd_protected(struct vm_area_struct *vma)
+static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
 {
 	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
 }
@@ -353,27 +353,27 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
-static inline bool userfaultfd_missing(struct vm_area_struct *vma)
+static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_minor(struct vm_area_struct *vma)
+static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
+static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_protected(struct vm_area_struct *vma)
+static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
 {
 	return false;
 }

-- 
2.53.0

