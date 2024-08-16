Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB113B293
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842639; cv=none; b=t25qKvZIFzW7jfiWLXaN+x1UCYbXVMfgoY8TtikDRnw1fhi2f4UKtafMgIx99gFji0vMCRMkDXXdVBQz15PU+XTwVkjoXnp2oRQsgO9zX1fnC8f99FzH203YjTFmFMERw1iKx+z5UY87PuQAkg42eDi9sq/Fv3pNg7DecurIKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842639; c=relaxed/simple;
	bh=MSC9Wsd9Cu5G7C0nXc29mjiGnfrNd0iG55mgzzoZ0Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXZCbleFuDFf9Y3VITR7/N9FqWJHs5urz6gvIbfFDMJbOIwqvx1sbruz0JIjLCHAXOtOw+C4Q38dfwO7a+EwpF5Qk7DW6ihCN60Qc/mkDeDNhB1P0bzs/wp1BhJ/3Z+Yr+bCRDoGhSeuVjYqy/x5yAVY+XQsd9LCKS+eGiIjQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nm3r609/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nm3r609/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a10b293432so1687059a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723842638; x=1724447438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIVamb0t+ukSevWtGDhnJxmQQeMGvGtS5gLAZtBpwhQ=;
        b=Nm3r609/NSmmN3JdOTs+0j3tSWhK4mF/QZZgZ0fL/dlR9nxcynUgzo6bekjBEOP2Xs
         +3dvr7Wx1hbgT3z3h6U8v7ViPiDy771vAxDvJbddXG54VpYh4Hi859VRvYKOwZfFVNu/
         udbhBM/FbTGtUYxUpsZ5IWuHqLM89RnEJuIM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723842638; x=1724447438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIVamb0t+ukSevWtGDhnJxmQQeMGvGtS5gLAZtBpwhQ=;
        b=kdInXv18rtX4xBE2gy/MSFVKyqWkQx9XV5R8C/5u70Em+WT1kJbq9bImHvUgfLppPI
         SWaJagHDjnF//SxmGNcT1AnRnWrpDKfwkOsv+CJo34Liu/DLSUIfPrctgSqpPGZvV2G5
         qXzKbT5LpnI2hlKjt6V9Vb+WLxG/6hlpN6MhrODqYVSOY3Kqt10N7GrumiVnUmbG7WwW
         q7jZpwJ/iib7oA/Vth0RqwoatPgKNB9FP4adgdqz5JuUSLx/1wdgyhmqfZuKNa8Ar4uH
         j3pMnty9QwiPDpMoGmDWqO1F0loumJsViO3/fupg9difrfy00MB7ouj93WBzGkTSfJT9
         7eFA==
X-Forwarded-Encrypted: i=1; AJvYcCXobyY9noXyQzwcQlO7dQkwytKYam/BS/1c+oa9ad8HjbGnkxM9GqPnKml7YFP7U9YvsgWc6BiPK6Wd6KkYkwE8GXGSkd4w14fY3zFffVQ2tNoo
X-Gm-Message-State: AOJu0Yxa5WDOKcjrWRUFZUc442vkGaJ5pQdA72FU8AMnavJU4xnO1PwP
	TEDIpZy9b/NVKzv9idejkna70Mw3W4uKsBtEzN47z9r7KLF5vSueTcOxwqK1
X-Google-Smtp-Source: AGHT+IEM/jRWr5rAkRLa/IpFUV9K3uejMQWznzf/9GJt778E8nRMTEi2Y3OtuwWQtPn8GLL5M3N1uw==
X-Received: by 2002:a17:90a:67c6:b0:2c9:5ecd:e3c5 with SMTP id 98e67ed59e1d1-2d4063e7697mr766956a91.33.1723842637621;
        Fri, 16 Aug 2024 14:10:37 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d3f0f1f51bsm1867399a91.32.2024.08.16.14.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:10:37 -0700 (PDT)
From: Takaya Saeki <takayas@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Junichi Uekawa <uekawa@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v4] filemap: add trace events for get_pages, map_pages, and fault
Date: Fri, 16 Aug 2024 21:10:29 +0000
Message-ID: <20240816211029.903842-1-takayas@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow precise tracking of page caches accessed, add new tracepoints
that trigger when a process actually accesses them.

The ureadahead program used by ChromeOS traces the disk access of
programs as they start up at boot up. It uses mincore(2) or the
'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
this information in a "pack" file and on subsequent boots, it will read
the pack file and call readahead(2) on the information so that disk
storage can be loaded into RAM before the applications actually need it.

A problem we see is that due to the kernel's readahead algorithm that
can aggressively pull in more data than needed (to try and accomplish
the same goal) and this data is also recorded. The end result is that
the pack file contains a lot of pages on disk that are never actually
used. Calling readahead(2) on these unused pages can slow down the
system boot up times.

To solve this, add 3 new trace events, get_pages, map_pages, and fault.
These will be used to trace the pages are not only pulled in from disk,
but are actually used by the application. Only those pages will be
stored in the pack file, and this helps out the performance of boot up.

With the combination of these 3 new trace events and
mm_filemap_add_to_page_cache, we observed a reduction in the pack file
by 7.3% - 20% on ChromeOS varying by device.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changelog between v4 and v3
- fix mm_filemap_get_pages by replacing last_index with last_index-1.
  it is an open interval while mm_filemap_map_pages's one is inclusive.

Changelog between v3 and v2
- Use a range notation in the printf format 

Changelog between v2 and v1
- Fix a file offset type usage by casting pgoff_t to loff_t
- Fix format string of dev and inode
 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 46c89c1e460c..f48fe637bfd2 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -56,6 +56,90 @@ DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
 	TP_ARGS(folio)
 	);
 
+DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
+
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+
+	TP_ARGS(mapping, index, last_index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+		__field(unsigned long, last_index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+		__entry->last_index = last_index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld-%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT,
+		((((loff_t)__entry->last_index + 1) << PAGE_SHIFT) - 1)
+	)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_get_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_map_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+TRACE_EVENT(mm_filemap_fault,
+	TP_PROTO(struct address_space *mapping, pgoff_t index),
+
+	TP_ARGS(mapping, index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT
+	)
+);
+
 TRACE_EVENT(filemap_set_wb_err,
 		TP_PROTO(struct address_space *mapping, errseq_t eseq),
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..e6b20cda9912 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index - 1);
 	return 0;
 err:
 	if (err < 0)
@@ -3287,6 +3288,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	trace_mm_filemap_fault(mapping, index);
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3653,6 +3656,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
 out:
 	rcu_read_unlock();
 
-- 
2.46.0.184.g6999bdac58-goog

