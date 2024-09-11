Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9421714AC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060503; cv=none; b=uUeKwcumnDlvp3/OE9If+wJgIzLaRie2KgAMasFg0UAU3gOZCppnbZ+HE8ae/7YFtC0UrWE3Ay5tR0aDqKa6EPcs77kJRAdlTLrAwm72hekeGH6wZwIAu2m/E9X/3anron52gP+Ig/ji9jWs2DahSeWL+Lb1HCo90Q5NAfnjjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060503; c=relaxed/simple;
	bh=XZt2G0aH559xirzR6l9JrVn5VjcuatzDQvtdbhhVi0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtNoFz9wTv3oZhC7sK/rZ08sBg1Kg6ZTIlvJKNa4sNcmHtZT+WzkAp/bQPCeJf2+85kBY7AEq66SwtQnxUjH+vkl6vOB9fxIH3iyOv5LRDSYiCMtiR4EzT8pqj9VVL+1WrgjmG396AcPk1qOEsiwFYw7buz3s9SgXu0g8XdapAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+i6CP3E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+i6CP3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726060500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWyaJKdBH3JeLKIKrzSApQMd3n2jcApw7CnibmGsTg=;
	b=I+i6CP3EtS+em0ma587C47wIblkZ3GtKYlgiNSM+RBlopXHhGamGeJ0u3n589SAb4CTkiV
	TJqRCWDCyN6F7BfvHGL6awZd7rpqcjcCvv4NdClN0i6CuufcjmMQVe1r0CMV/9By2YvqG9
	ijLW+/rze9fbU9l1MzBgeS/RZUgH/T4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-A0mHO4ajN8u2MKgW2T49hg-1; Wed,
 11 Sep 2024 09:14:59 -0400
X-MC-Unique: A0mHO4ajN8u2MKgW2T49hg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DFD61955D45;
	Wed, 11 Sep 2024 13:14:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5477419560A3;
	Wed, 11 Sep 2024 13:14:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 15:14:44 +0200 (CEST)
Date: Wed, 11 Sep 2024 15:14:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH -mm 3/3] uprobes: turn xol_area->pages[2] into xol_area->page
Message-ID: <20240911131437.GC3448@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240911131320.GA3448@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911131320.GA3448@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now that xol_mapping has its own ->fault() method we no longer need
xol_area->pages[1] == NULL, we need a single page.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a478e028043f..94a17435cfe6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -99,7 +99,7 @@ struct xol_area {
 	atomic_t 			slot_count;	/* number of in-use slots */
 	unsigned long 			*bitmap;	/* 0 = free slot */
 
-	struct page 			*pages[2];
+	struct page			*page;
 	/*
 	 * We keep the vma's vm_start rather than a pointer to the vma
 	 * itself.  The probed process or a naughty kernel module could make
@@ -1437,7 +1437,7 @@ static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
 {
 	struct xol_area *area = vma->vm_mm->uprobes_state.xol_area;
 
-	vmf->page = area->pages[0];
+	vmf->page = area->page;
 	get_page(vmf->page);
 	return 0;
 }
@@ -1512,10 +1512,9 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->pages[0] = alloc_page(GFP_HIGHUSER);
-	if (!area->pages[0])
+	area->page = alloc_page(GFP_HIGHUSER);
+	if (!area->page)
 		goto free_bitmap;
-	area->pages[1] = NULL;
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
@@ -1523,12 +1522,12 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
 	insns = arch_uprobe_trampoline(&insns_size);
-	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
+	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
 		return area;
 
-	__free_page(area->pages[0]);
+	__free_page(area->page);
  free_bitmap:
 	kfree(area->bitmap);
  free_area:
@@ -1570,7 +1569,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 	if (!area)
 		return;
 
-	put_page(area->pages[0]);
+	put_page(area->page);
 	kfree(area->bitmap);
 	kfree(area);
 }
@@ -1637,7 +1636,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 	if (unlikely(!xol_vaddr))
 		return 0;
 
-	arch_uprobe_copy_ixol(area->pages[0], xol_vaddr,
+	arch_uprobe_copy_ixol(area->page, xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 
 	return xol_vaddr;
-- 
2.25.1.362.g51ebf55


