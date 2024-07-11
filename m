Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50D15A865;
	Thu, 11 Jul 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696049; cv=none; b=qE3id0b3dZa+GkwIMpF+pxQLRNzsPowXJ74X/ppUzoIZbjTGc8S1vBltniXmGL1xnQ6U4WX79ZoiCVSwDqN0ZcU+QoXiKQ5BMQAOmAgZ6xj1CqXg2gmNvLkBg02B7X5O7aujqjGQqD/haaWpcgMejTJr+9rJXng4rIkTGBcESag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696049; c=relaxed/simple;
	bh=SK0WpGxdLIMwlY7T1cLR+yWEBYicF8l1blnSe1p7LCU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jGuH/uhYd8fXaGrA/OVBCkindRsFIrBhqaEj/dzhPjEaAjK1xktE0JKxstWZYJHm08X+oBiqV6Bc12SUmuAvoRmiuG+5ODXvUFKZ8XfFOQb0vqFKyVc+UWDwUSMaDpk3IBJ2qKiId+sDoTekI/Vpgyc59BFNZnIlZ2znBGayPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeH51iyO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeH51iyO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=VqlAJfIzp9p6gk1mqKZ345ZWdiXBhJmcK02is9mdROM=; b=ZeH51iyOE2w8ALI6fMUsjNe25t
	MnKaYe0b1r5INsD7cEdQlbKjk4uMKau6MaN/V+YCDeyanwYFaf/XkMCl1LHa9qhULfiVd0XPfVxrw
	19tdvPaX+z/iQhCN9SGOzYTaJBUwAO51CCohhlEMzFXFY6upXhdRdi5DMWGpXZHCJpZuM9MhRnAcq
	T2x35WAWZ4Q+BDp0Ns9bRcTIZgFG3m4aCg5ZKs2u834LcRPDKFHsZxQDe4BtSr7xFVBNoQSfZgjua
	t4t6El5MTGUPRZg2/VX1dEh5K1VI2VxaXug8JclihLdZQEXW0uWdWiaTHaga+PzTyK3OEZhVEqBEZ
	HOwsR9ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-0000000Ax6X-08o2;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C53E43021D4; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.768061729@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:40 +0200
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
Subject: [PATCH v2 05/11] perf/uprobe: Simplify UPROBE_HANDLER_REMOVE logic
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Specifically, get rid of the uprobe->consumers re-load, which isn't
sound under RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2101,6 +2101,7 @@ static void handler_chain(struct uprobe
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	bool had_handler = false;
 
 	down_read(&uprobe->register_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
@@ -2115,16 +2116,26 @@ static void handler_chain(struct uprobe
 		if (uc->ret_handler)
 			need_prep = true;
 
+		/*
+		 * A single handler that does not mask out REMOVE, means the
+		 * probe stays.
+		 */
+		had_handler = true;
 		remove &= rc;
 	}
 
+	/*
+	 * If there were no handlers called, nobody asked for it to be removed
+	 * but also nobody got to mask the value. Fix it up.
+	 */
+	if (!had_handler)
+		remove = 0;
+
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
 
-	if (remove && uprobe->consumers) {
-		WARN_ON(!uprobe_is_active(uprobe));
+	if (remove)
 		unapply_uprobe(uprobe, current->mm);
-	}
 	up_read(&uprobe->register_rwsem);
 }
 


