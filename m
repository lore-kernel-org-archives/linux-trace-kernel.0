Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18371F9F70;
	Mon,  7 Apr 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039358; cv=none; b=YfD0+Fz6Itv1jWbdGKKmHkKr6wf3K5QmamIz0ilP4ppbYzUD/fjLl6FHZDzek8HQBr5SjTigjBCRLTk4yxcnvktbGQfD4uLELeV5bV82TUbKyjPaCSFRVoA9WympHglk810cTGwtYr+PlV8U+ZOCD0SSlGxJRgKgz3Iv48UidiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039358; c=relaxed/simple;
	bh=Fyy15kwhH1t3BBHKQP8IoJ5dLieJYZ+OgC0xKokOJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f93lO586ynKChvTVIbcDsRIOuCUPB4M4S0Iv0u6Lc9fNUMjhIwZXFn92ytdbB1rJmVlL/vxQ4A0dWIeqGUjltyiarEx7cMfcCYeD7W8uG+jkLLCPR0CU3SjVt2FcME3Z1NX5LAQxKJYkImChJGTG8Y6Wftz+YlpKr5QI8aymPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91EC4CEDD;
	Mon,  7 Apr 2025 15:22:37 +0000 (UTC)
Date: Mon, 7 Apr 2025 11:23:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann
 Horn <jannh@google.com>
Subject: Re: [PATCH v6 3/4] tracing: Use vmap_page_range() to map memmap
 ring buffer
Message-ID: <20250407112352.264e12b0@gandalf.local.home>
In-Reply-To: <4f8ece8b-8862-4f7c-8ede-febd28f8a9fe@roeck-us.net>
References: <20250402144903.993276623@goodmis.org>
	<20250402144953.754618481@goodmis.org>
	<4f8ece8b-8862-4f7c-8ede-febd28f8a9fe@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Apr 2025 10:39:27 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> non-MMU builds (xtensa:nommu_kc705_defconfig):

Bah!

> 
> kernel/trace/trace.o:(.init.literal+0x250): undefined reference to `get_vm_area'

Does this fix it?

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b581e388a9d9..8ddf6b17215c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9806,6 +9806,7 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
+#ifdef CONFIG_MMU
 static u64 map_pages(unsigned long start, unsigned long size)
 {
 	unsigned long vmap_start, vmap_end;
@@ -9828,6 +9829,12 @@ static u64 map_pages(unsigned long start, unsigned long size)
 
 	return (u64)vmap_start;
 }
+#else
+static inline u64 map_pages(unsigned long start, unsigned long size)
+{
+	return 0;
+}
+#endif
 
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.


-- Steve
