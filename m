Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9D15A87B;
	Thu, 11 Jul 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696051; cv=none; b=ttvgfvzEiEXeE2nkz3z71Cpm4BBU3didiRWVBkaa1/sDnxfz+Iuw8x92VcSZEdO+QKz4owLUwiBEzZZGGE6cM/bzQAsqqxjsqG4qoZuUuOsGh/uXfV3dCgRoy1tNnGuqc273gCxH8o6gWpzBrtQwjsAgx5lWbmAzavFopRGBolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696051; c=relaxed/simple;
	bh=aHcz8je/K6D8qyRMNtQ30mbLo3y2E4SL+2Pr8zv5Wis=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ssdiSucmM9Dn4elRpCVskQdSb1c7Nb9neOpnOn53848mForLFKzH+HcWFsACiMbDrc679AdVD6/WttGTUXUU0icI44Q9JO37UnLt3qOjvL6zrjjF6ZxQdtX65PMt9yhiJjEfP+CgCuYFzOTSmgCoLq3lWZ0qEQUPVtBnH02J7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qJ/k11So; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJ/k11So"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1bUUAiw4/p70dXaUe2S6wv8W5kuKSZvbGkuAwwX7C3c=; b=qJ/k11SoQ7qwRI0yYeCmgokzqd
	h2ProHEQ51A14hrd289eUmBOztF+sg9LYyeOmtMaKRaxxA8m0yqPxxV1bRLZCiQ/UD6IR85lywXoN
	WbVkrFg891iAxbWj/JKfAjo2r64K9lyis+BD3N02Z13fsEAuaEq4f1A/8G86pLbX1K4C65qsZWev1
	V8yXtEHEFY8xqKuC7N8uUBJy50Hq2gzKTOCMHxHz1SDS8EDbgifzbEQV1tEey2aIIQN+mK0PKhiNs
	OhVJY4q4wIEXJUmbylQFTmcB7KfzxwDGYYw/a18Pq4Na00Q05QJWBbEmSyGQjWHIGs9Gylerd03km
	N7tUc1Rw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRrdz-000000015VR-1nLT;
	Thu, 11 Jul 2024 11:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B8911300CBA; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.421616631@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:37 +0200
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
Subject: [PATCH v2 02/11] perf/uprobe: Remove spurious whitespace
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -67,7 +67,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -95,18 +95,18 @@ static LIST_HEAD(delayed_uprobe_list);
  * allocated.
  */
 struct xol_area {
-	wait_queue_head_t 		wq;		/* if all slots are busy */
-	atomic_t 			slot_count;	/* number of in-use slots */
-	unsigned long 			*bitmap;	/* 0 = free slot */
+	wait_queue_head_t		wq;		/* if all slots are busy */
+	atomic_t			slot_count;	/* number of in-use slots */
+	unsigned long			*bitmap;	/* 0 = free slot */
 
 	struct vm_special_mapping	xol_mapping;
-	struct page 			*pages[2];
+	struct page			*pages[2];
 	/*
 	 * We keep the vma's vm_start rather than a pointer to the vma
 	 * itself.  The probed process or a naughty kernel module could make
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
-	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			vaddr;		/* Page(s) of instruction slots */
 };
 
 /*


