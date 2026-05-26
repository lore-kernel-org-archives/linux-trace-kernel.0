Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06B402442
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808092; cv=none; b=R1kTB3DvENi0O7oXiQZFaB3STDzxw3gHbjKHT7FbMAoDsdNcCTxzIxCDi9ygI4C7BOtWMg9861M0y45IGQmchwJboy4o//fNKG6HbXvaNwya1O73goYZ9UUVG2ox6qu2MpajTfDJ2ndcu4W77ODJovfVq3hd2NIXj6Zo9qJsIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808092; c=relaxed/simple;
	bh=5IzNQDSqtUuXRoVdo0sy2147vW1b36fu2tbOzJPUKRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYRcwJElG4nAYXrIgdU7gNMN4e+BvXhDU00LY6HJZPBjt0tZND+1U0jXmPpDXheS6fQdLc5z0ymBpo6u8DSpWtUIkIX098k1j20YmTru24Q5t5OmIzDGddtjBksXk1LAXf6BdsZdkf1c6FgVGlM/fqmlIKvWDGUJ3MFSkEZ4nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IhRRJLg1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IhRRJLg1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IhRRJLg1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IhRRJLg1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3348767479;
	Tue, 26 May 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqSqltL1GnVn7PKoSl94YXnAsN5DYo+RIglrQTaw6ZE=;
	b=IhRRJLg1s5P5gbD17rJX9mZp818QbdvrFXhyx343oE+IaY0Kh+yGSPyqhhevxSLMM9kMpW
	xtcnReEWjm/8c1ay8xDj7uC+n3hhkvcCe5rSHQ151k0Qtc23cNKrxsvH+aYeIB3X9PRiY5
	6dAf2+JidkGM8r4dXSxeKh8mWnX64GU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqSqltL1GnVn7PKoSl94YXnAsN5DYo+RIglrQTaw6ZE=;
	b=IhRRJLg1s5P5gbD17rJX9mZp818QbdvrFXhyx343oE+IaY0Kh+yGSPyqhhevxSLMM9kMpW
	xtcnReEWjm/8c1ay8xDj7uC+n3hhkvcCe5rSHQ151k0Qtc23cNKrxsvH+aYeIB3X9PRiY5
	6dAf2+JidkGM8r4dXSxeKh8mWnX64GU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79085A280;
	Tue, 26 May 2026 15:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fIlCM1a3FWqUVQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 26 May 2026 15:08:06 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 1/5] x86/xen: Drop lazy mode from trace entries
Date: Tue, 26 May 2026 17:05:10 +0200
Message-ID: <20260526150514.129330-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526150514.129330-1-jgross@suse.com>
References: <20260526150514.129330-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

Drop the lazy mode (cpu or mmu) from the xen_mc_batch and xen_mc_issue
trace entries.

This is done in preparation of removing the xen_lazy_mode percpu
variable.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/xen-ops.h     | 11 +++++++----
 include/trace/events/xen.h | 33 +++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 6808010ac379..dc892f421f25 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -98,7 +98,7 @@ static inline void xen_mc_batch(void)
 
 	/* need to disable interrupts until this entry is complete */
 	local_irq_save(flags);
-	trace_xen_mc_batch(xen_get_lazy_mode());
+	trace_xen_mc_batch(flags);
 	__this_cpu_write(xen_mc_irq_flags, flags);
 }
 
@@ -114,13 +114,16 @@ void xen_mc_flush(void);
 /* Issue a multicall if we're not in a lazy mode */
 static inline void xen_mc_issue(unsigned mode)
 {
-	trace_xen_mc_issue(mode);
+	bool flush = !(xen_get_lazy_mode() & mode);
+	unsigned long flags = this_cpu_read(xen_mc_irq_flags);
 
-	if ((xen_get_lazy_mode() & mode) == 0)
+	trace_xen_mc_issue(flush, flags);
+
+	if (flush)
 		xen_mc_flush();
 
 	/* restore flags saved in xen_mc_batch */
-	local_irq_restore(this_cpu_read(xen_mc_irq_flags));
+	local_irq_restore(flags);
 }
 
 /* Set up a callback to be called when the current batch is flushed */
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index e3f139f0bc78..ad384969e2cb 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -12,24 +12,29 @@
 struct multicall_entry;
 
 /* Multicalls */
-DECLARE_EVENT_CLASS(xen_mc__batch,
-	    TP_PROTO(enum xen_lazy_mode mode),
-	    TP_ARGS(mode),
+TRACE_EVENT(xen_mc_batch,
+	    TP_PROTO(unsigned long flags),
+	    TP_ARGS(flags),
 	    TP_STRUCT__entry(
-		    __field(enum xen_lazy_mode, mode)
+		    __field(unsigned long, flags)
 		    ),
-	    TP_fast_assign(__entry->mode = mode),
-	    TP_printk("start batch LAZY_%s",
-		      (__entry->mode == XEN_LAZY_MMU) ? "MMU" :
-		      (__entry->mode == XEN_LAZY_CPU) ? "CPU" : "NONE")
+	    TP_fast_assign(__entry->flags = flags),
+	    TP_printk("start batch lazy flags %lx", __entry->flags)
 	);
-#define DEFINE_XEN_MC_BATCH(name)			\
-	DEFINE_EVENT(xen_mc__batch, name,		\
-		TP_PROTO(enum xen_lazy_mode mode),	\
-		     TP_ARGS(mode))
 
-DEFINE_XEN_MC_BATCH(xen_mc_batch);
-DEFINE_XEN_MC_BATCH(xen_mc_issue);
+TRACE_EVENT(xen_mc_issue,
+	    TP_PROTO(bool flush, unsigned long flags),
+	    TP_ARGS(flush, flags),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, flags)
+		    __field(bool, flush)
+		    ),
+	    TP_fast_assign(__entry->flush = flush;
+			   __entry->flags = flags;
+		    ),
+	    TP_printk("flush: %s, flags %lx",
+		      __entry->flush ? "yes" : "no", __entry->flags)
+	);
 
 TRACE_DEFINE_SIZEOF(ulong);
 
-- 
2.54.0

