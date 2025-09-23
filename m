Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEC194A6C;
	Tue, 23 Sep 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605302; cv=none; b=YB03Jrh4/RR9xonmcq9TFSjSoo1XjEJ/+lOAz+sbfq89XICPY8iLzso0YC06qsLhtKjBCdna61+vd5qAlbnNg/lPtgxfgfSWEU3aDKLMhuaGlq6oXoQLzHsWByirw50HAw0Qtas4UB4YxR8z3/KX9kkTScEm2F4Bt9QHoQPDF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605302; c=relaxed/simple;
	bh=oMyUQ1Jw7hmSS+yVktkef93mpaC3gOqtbbY8bboJJrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KquGG4cai9UyY85X4iZQoZ3Ed7+hfgzVOMJ1O3J7LbVU0OKjCBpEahyokS4wXbg34YwZfl11bkLzJIHjqSUK7PBc8CqnE/UCslqbuzyrOvs1UrhVKFcrfAJjZPhWVPZGRjLoomZmxHkylaVd6t50gw9waB5LOJs4Lgibr+4RLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yiVCwiWg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwgYRp71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yiVCwiWg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwgYRp71"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758605299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYQtq9XeaLI0p8KOqa5dhttLdUVs+XkHPdFghw3nLRY=;
	b=yiVCwiWgnCvVsTwTSPMGdVcMrArUoMQB+GHBKJy+qj2b/HtTBfIbU5wdcjxftqmr7xiPJ0
	9wKVU8jQBUsTE+oGAX0mrwfEFZKSoo/5lltECEbAeTuhT+u0NoHE3tWLRF08xGEmnC8sk4
	4vKM1qC7lYQWMUoKgrLLUeExrAQ7kN+aFFToiaZbj43eEHoyz2TBWqbrnTHbiK3f2txKzA
	wCd6vxvYkohd5y0Y1bB9SoEKaImawE50Xhr1Q7o/vQp2YfZ1c+nogqMhMEwhPxmwOCT7Eg
	3g01yVFFRU2ONCwfhT8AVDEBvV8X5ytGlVlDissGQUPNpvtWnVBNrKTj+1EOnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758605299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYQtq9XeaLI0p8KOqa5dhttLdUVs+XkHPdFghw3nLRY=;
	b=qwgYRp71gKHVestK+cZqn3eoW51RNKzLatEiVr5IfwGhUr4orqH3IZl4eZtetND4wk/wUe
	0BGFPvXT9je4V2BA==
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
In-Reply-To: <20250923002004.GA2836051@ax162>
References: <20250806120911.989365-1-namcao@linutronix.de>
 <20250923002004.GA2836051@ax162>
Date: Tue, 23 Sep 2025 07:28:18 +0200
Message-ID: <87tt0t4u19.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Nathan,

Nathan Chancellor <nathan@kernel.org> writes:
> I am seeing a crash when reading from /sys/kernel/tracing/rv/enabled_monitors
> on a couple of my arm64 boxes running Fedora after this change, which
> landed in mainline in 6.17-rc7. I can reproduce this in QEMU pretty
> easily.
...
> With this change reverted, there is no crash. As this change seems to
> have proper justification, is there some other latent bug here?

Thanks for the report.

Yes, this patch is broken, because argument 'p' of
enabled_monitors_next() *is* a pointer to struct rv_monitor. I'm not
sure how did I even test this patch... Steven is right, we really need
something in kselftest for RV, another thing in my RV TODO list.

But reverting is not the real fix, because monitors_show() still expects
a pointer to list_head. Changing monitors_show() is not an option,
because it is shared with the 'available_monitors' interface.

So the real fix is completely changing the iterator to be list_head
instead of rv_monitor.

Best regards,
Nam

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 48338520376f..43e9ea473cda 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
 		if (mon->enabled)
-			return mon;
+			return &mon->list;
 	}
 
 	return NULL;
@@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor *mon;
+	struct list_head *head;
 	loff_t l;
 
 	mutex_lock(&rv_interface_lock);
@@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
 
-	mon = list_entry(&rv_monitors_list, struct rv_monitor, list);
+	head = &rv_monitors_list;
 
 	for (l = 0; l <= *pos; ) {
-		mon = enabled_monitors_next(m, mon, &l);
-		if (!mon)
+		head = enabled_monitors_next(m, head, &l);
+		if (!head)
 			break;
 	}
 
-	return mon;
+	return head;
 }
 
 /*
