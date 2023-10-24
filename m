Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40592C872;
	Tue, 24 Oct 2023 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTMdiJcv"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254F111;
	Tue, 24 Oct 2023 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PSnegE5ssburDqDLTAjk5xgoc42EdNbvgsI+b2wWw0s=; b=NTMdiJcv2ouSLgHvHcqXvhcZuU
	xrl2U/Sybh5O2OX9h2UekTwi3V1sXLFZXDbYyl7XJFyzB0q1jWRzMF5YYrus1QynYo8hXYJgUoTpT
	qvKUoXL5+UXxsvmd8uAL/oBEk5l8OQRMXPc7uZWMyWmIYZuoSBTUUX/MOMZ1F0yekxQ77hX9P6q9u
	ZfBvbtSwmAI8u9+U8TZKi0nJPAq0n33HB6cuGFGDk7S/+xdUERCUVMIgBQXqbNblq18Y9FzUw33ho
	oh/cqMyYFc1aKaUQ5ajIdT1jPa11BIoeBIEOTdqPDDfeSrlZZL6KZHXtOJWfJNQR+TBii53OQGmye
	aPi7+FVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvIp7-0036N7-Mv; Tue, 24 Oct 2023 14:56:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Remove initialisation of readpos
Date: Tue, 24 Oct 2023 15:55:59 +0100
Message-Id: <20231024145600.739451-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While powerpc doesn't use the seq_buf readpos, it did explicitly
initialise it for no good reason.

Fixes: d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/powerpc/kernel/setup-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2f1026fba00d..34975532e44c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -601,7 +601,6 @@ struct seq_buf ppc_hw_desc __initdata = {
 	.buffer = ppc_hw_desc_buf,
 	.size = sizeof(ppc_hw_desc_buf),
 	.len = 0,
-	.readpos = 0,
 };
 
 static __init void probe_machine(void)
-- 
2.40.1

