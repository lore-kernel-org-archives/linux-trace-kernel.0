Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FF15B0E8;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696050; cv=none; b=Ov76A9IGvKsqXM4ZukVQIBnIU9eUSEgzMXJ7Cdzhyu5QcDa1kwp1f8ExK8LotIm9Wm6VgxA5av16BXyOoCJH4/juC000xA+uJqaWtjreSIXV9nfXVYe8jOyuvL/rmQUYommnmZnDFVmHQ/SG1VF+tl/n/yxrXYNW5nYSA+7xo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696050; c=relaxed/simple;
	bh=iPnzJDPYV69x97yqOMsVW8M8RvXBmzlPMZ6dojO6w9w=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J876YGQY6EhwwhlCvtAC0jdcthCxu/gXEH7KuVs29HI6VJ0N2/G+JvW2udR9jzTXpwNzJZaFmihWIF7EIR80Dv8fTpUQ1uSCXPLJVEq69SHIlL2PgoF6lLo9CtKrgZ2Qet5lZeCauCWxxuxDrfLRVKxBWCfgKYq1QdeqblSfshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oETD364e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oETD364e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=D/qnIt6lTHMe7dedD5Wou6cHbGCP/Pb/6K/ANgI22y8=; b=oETD364eYO3X8m54frROBJ4DTa
	PLYe9JBO5SzzVZH17OWyRRRHTbHxUkdqQfaErD5ZR7Pqy2wC0U5AbKfHDN1DB5pSEeNkAdcrqhAfk
	zThljKlATbWKBMO3zaq4p488VTXuJO3tEgtFhyf9vpt5MSe9i066Hn3TuQI3WTd83QIui76vLlojP
	hiKEs28mhcB3EomOv74NHlrpzSqzxEo/0e5BabMDbMWfPfJERVjbgYei9ELYqnBjfe+QmUy3kDHoZ
	8dhIcKkTXADhyrtAoxER4PWvWt9AGQiRfdCmjtHKjRRuG8hAGqXUjy5JIxhHjS9rt4Q5owlLLDOUw
	NCO9FdJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRrdz-000000015VS-1nLT;
	Thu, 11 Jul 2024 11:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B3690300848; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.309670567@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org,
 oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH v2 01/11] perf/uprobe: Re-indent labels
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Remove the silly label indenting.

 s/^\ \([[:alnum:]]*\):$/\1:/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
 	folio_put(old_folio);
 
 	err = 0;
- unlock:
+unlock:
 	mmu_notifier_invalidate_range_end(&range);
 	folio_unlock(old_folio);
 	return err;
@@ -857,7 +857,7 @@ static int prepare_uprobe(struct uprobe
 	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
- out:
+out:
 	up_write(&uprobe->consumer_rwsem);
 
 	return ret;
@@ -965,7 +965,7 @@ build_map_info(struct address_space *map
 	struct map_info *info;
 	int more = 0;
 
- again:
+again:
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 		if (!valid_vma(vma, is_register))
@@ -1019,7 +1019,7 @@ build_map_info(struct address_space *map
 	} while (--more);
 
 	goto again;
- out:
+out:
 	while (prev)
 		prev = free_map_info(prev);
 	return curr;
@@ -1068,13 +1068,13 @@ register_for_each_vma(struct uprobe *upr
 				err |= remove_breakpoint(uprobe, mm, info->vaddr);
 		}
 
- unlock:
+unlock:
 		mmap_write_unlock(mm);
- free:
+free:
 		mmput(mm);
 		info = free_map_info(info);
 	}
- out:
+out:
 	percpu_up_write(&dup_mmap_sem);
 	return err;
 }
@@ -1159,7 +1159,7 @@ static int __uprobe_register(struct inod
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
 		return -EINVAL;
 
- retry:
+retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
@@ -1468,7 +1468,7 @@ static int xol_add_vma(struct mm_struct
 	ret = 0;
 	/* pairs with get_xol_area() */
 	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
- fail:
+fail:
 	mmap_write_unlock(mm);
 
 	return ret;
@@ -1512,7 +1512,7 @@ static struct xol_area *__create_xol_are
 	kfree(area->bitmap);
  free_area:
 	kfree(area);
- out:
+out:
 	return NULL;
 }
 
@@ -1915,7 +1915,7 @@ static void prepare_uretprobe(struct upr
 	utask->return_instances = ri;
 
 	return;
- fail:
+fail:
 	kfree(ri);
 }
 
@@ -2031,7 +2031,7 @@ static int is_trap_at_addr(struct mm_str
 
 	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
- out:
+out:
 	/* This needs to return true for any variant of the trap insn */
 	return is_trap_insn(&opcode);
 }
@@ -2159,7 +2159,7 @@ static void handle_trampoline(struct pt_
 	utask->return_instances = ri;
 	return;
 
- sigill:
+sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
 


