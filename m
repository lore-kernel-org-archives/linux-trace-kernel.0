Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CD22AE7A;
	Sun, 18 Jan 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768767751; cv=none; b=H8luzfZLhBtDEG3C60/DJ4/x5rYntit9arH09uuPLj2jGmGYAdY2T+uff0UB4u2s1IFpvVe09bslutIUEiPv2+gDOsgF9UOWjje+TQQNPnj4OeXag0kqMus39Ls30bR8kDFE97NF7yQJ+8W55JfFbFGbhLhubdaVbIwYf+kTiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768767751; c=relaxed/simple;
	bh=q//pica3AV44Fm9PXUee/SluWTMEByJY6QRUAywAlkE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PZm1EboROnvAj0rl0wdpR6L/9sb5r3+FGjbarP3iAz59SCkvq5r5VxKmUW9JL4IiwR1Esmitk+nZtweFQEWRhSi2mdyQogfA30G32+Z6f1jwsZNMtG+c0X0mYOZUKst2KvTRMnIKpCicBWp02ZG48+0+CPSnJTdyiSFLEObwb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nCgsRnLq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nCgsRnLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B90C116D0;
	Sun, 18 Jan 2026 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768767750;
	bh=q//pica3AV44Fm9PXUee/SluWTMEByJY6QRUAywAlkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCgsRnLqO8g7TvPco5FEGstL+Y46pSoIrNl48qQd0dfDSWANuOCldMzfDPc5N1juS
	 HFaFCXK8bj/3gaZwjhzxxZP5gKW0/QTa3JcBJuEVf5m8oVMVBX6/yXDeYq3pbufUwy
	 71f0awTl6zXtKym0wHM1FOXtE8WQ9PQ10y0vX/NA=
Date: Sun, 18 Jan 2026 12:22:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shivank Garg <shivankg@amd.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Zach O'Keefe <zokeefe@google.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Subject: Re: [PATCH V5 0/2] mm/khugepaged: fix dirty page handling for
 MADV_COLLAPSE
Message-Id: <20260118122229.dcdda884bbb19a9c30ec6f1e@linux-foundation.org>
In-Reply-To: <20260118190939.8986-2-shivankg@amd.com>
References: <20260118190939.8986-2-shivankg@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 19:09:38 +0000 Shivank Garg <shivankg@amd.com> wrote:

> MADV_COLLAPSE on file-backed mappings fails with -EINVAL when TEXT pages
> are dirty. This affects scenarios like package/container updates or
> executing binaries immediately after writing them, etc.
> 
> The issue is that collapse_file() triggers async writeback and returns
> SCAN_FAIL (maps to -EINVAL), expecting khugepaged to revisit later. But
> MADV_COLLAPSE is synchronous and userspace expects immediate success or
> a clear retry signal.
> 
> Reproduction:
>  - Compile or copy 2MB-aligned executable to XFS/ext4 FS
>  - Call MADV_COLLAPSE on .text section
>  - First call fails with -EINVAL (text pages dirty from copy)
>  - Second call succeeds (async writeback completed)
> 
> Issue Report:
> https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com

Updated, thanks.

Please tolerate a little whining about the timeliess here.  We're at
-rc6, v4 was added to mm.git over a month ago, had quite a lot of
review, this is very close to being moved into the mm-stable branch and now
we get v5.  Argh.

> V5:
> - In patch 2/2, Simplify dirty writeback retry logic (David)

Are you sure this is the only change?  It looks like a lot for a
simplification and I'm wondering if we should retain the v4 series and
defer a simplification for separate consideration during the next
cycle.

Below is how this updated altered mm.git.  Could reviewers please check
this fairly soon?


--- a/mm/khugepaged.c~b
+++ a/mm/khugepaged.c
@@ -2788,11 +2788,11 @@ int madvise_collapse(struct vm_area_stru
 	hend = end & HPAGE_PMD_MASK;
 
 	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
-		bool retried = false;
 		int result = SCAN_FAIL;
+		bool triggered_wb = false;
 
-		if (!mmap_locked) {
 retry:
+		if (!mmap_locked) {
 			cond_resched();
 			mmap_read_lock(mm);
 			mmap_locked = true;
@@ -2812,52 +2812,27 @@ retry:
 
 			mmap_read_unlock(mm);
 			mmap_locked = false;
+			*lock_dropped = true;
 			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
 							  cc);
-			fput(file);
-		} else {
-			result = hpage_collapse_scan_pmd(mm, vma, addr,
-							 &mmap_locked, cc);
-		}
-		if (!mmap_locked)
-			*lock_dropped = true;
-
-		/*
-		 * If the file-backed VMA has dirty pages, the scan triggers
-		 * async writeback and returns SCAN_PAGE_DIRTY_OR_WRITEBACK.
-		 * Since MADV_COLLAPSE is sync, we force sync writeback and
-		 * retry once.
-		 */
-		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !retried) {
-			/*
-			 * File scan drops the lock. We must re-acquire it to
-			 * safely inspect the VMA and hold the file reference.
-			 */
-			if (!mmap_locked) {
-				cond_resched();
-				mmap_read_lock(mm);
-				mmap_locked = true;
-				result = hugepage_vma_revalidate(mm, addr, false, &vma, cc);
-				if (result != SCAN_SUCCEED)
-					goto handle_result;
-			}
 
-			if (!vma_is_anonymous(vma) && vma->vm_file &&
-			    mapping_can_writeback(vma->vm_file->f_mapping)) {
-				struct file *file = get_file(vma->vm_file);
-				pgoff_t pgoff = linear_page_index(vma, addr);
+			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
+			    mapping_can_writeback(file->f_mapping)) {
 				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
 				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
 
-				mmap_read_unlock(mm);
-				mmap_locked = false;
-				*lock_dropped = true;
 				filemap_write_and_wait_range(file->f_mapping, lstart, lend);
+				triggered_wb = true;
 				fput(file);
-				retried = true;
 				goto retry;
 			}
+			fput(file);
+		} else {
+			result = hpage_collapse_scan_pmd(mm, vma, addr,
+							 &mmap_locked, cc);
 		}
+		if (!mmap_locked)
+			*lock_dropped = true;
 
 handle_result:
 		switch (result) {
_

