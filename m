Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33331AD48C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900353; cv=none; b=D7KI65Qpd9xzk2zk9CZs+suDFx7eStM2pOFZ/eMwGu8Gp9PNpGGpGnw+pi0U2z1ZKqIozTyIpGrhgHSc07K+h8skm07eooTp3b+ioaWApVhpqZP2e7V2djuytpfssZqFRAW8znTqKSf5fbeuoKd6d7+elU/CUTjXlKYt2o77kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900353; c=relaxed/simple;
	bh=oVLl+XcsKvcWdYE77A2RFFRwvfhdCY0dhp5sI6AvCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUoQ6dwga/csJqTzCqbbShRJp1LbFi7VYBmhpDHYqE6R8z/5Gz3F5R6I5/bkLcR1+b3HhDlWBvF3d+HusFgojDaU8lzcxuFGDpzFDvxJbdV88Va9YtAD58wvwrBclp0XMeeMGL8Y/YymbA7AsCgLOhQgFLHAu06tgLm2fuQku/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hlQYb1Rj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hlQYb1Rj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d10so8967625ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718900351; x=1719505151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDTwzMRp7r7igVV+ZTOkGMM8uRoM9/iMzbfcbOs3NYs=;
        b=hlQYb1RjDm/dAQxclkDOO4GKMXYg/SoDBVBZVczfRlNf4nMiwuaF49akqzraU9rVHJ
         7qKWNhsFEu+w3S/ayk630UuncOfiUq0OHvswtVIK4b4Csgzw/YuNdIgZck0PR8ZrefqP
         xhjYqQd7FLZouI8R6CHc8T3RmQ0G41d4gCV1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900351; x=1719505151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDTwzMRp7r7igVV+ZTOkGMM8uRoM9/iMzbfcbOs3NYs=;
        b=CECtBN9rdQo9YAu3jQNcVO5zxxYeeup8mahrfXJsKt/M1md06GKWKjp98R5FXm7/Sv
         0DgFA/pN6cAYtUq0hfIguwKsN1Xj3YjdDNY7q9MH49P3ccbPr4QuieEhdSkz+PfCX7qx
         NSFzBZUCP+DiTVCmmAasBYKu2h7vUymyCke0+tiP7vaMid/b9KCeDFgiLewsT9pmIGya
         dqaulpg7YhkWlvaRfgxznsP7jAT73OqM2/iEZ86yWJJiMuNx+Wa3JcvDySBrrVYMmNfI
         6obdF3c3d8FB2pydHx8q9+YIXpC9HuS5xJZzOMKZrJNWyZw92s4nXrIaIR+/6TBfiRjJ
         JvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBOTy4jCmtFc4RKqlzVC+S6DtH0nJzHlehggURV6OX3MSS+DkaGN0hk2eBphNdL/GMnBNDfVAT6Qpuqmtw2MIm5BJP4v3+BbPp8uMPgSEsp62i
X-Gm-Message-State: AOJu0YwlsY8kpWAsdhP9vwxrEZP6kN/Z8BGtpHYKbK4lHTaBKS1UfYlC
	fRmUTGbgSUePildaF29Jsz32qqESfPjEuXdg88oRr+1/wv4NnHJyDLySNFP5
X-Google-Smtp-Source: AGHT+IFSW1DtPmzfkyXjIzCznsvC4863obnU5C/WxGZH3fmU++B5UFx8192lW0ggQO9pfsgefF865g==
X-Received: by 2002:a17:903:11cc:b0:1f6:ea71:34ee with SMTP id d9443c01a7336-1f9aa3ce954mr69656465ad.16.1718900351103;
        Thu, 20 Jun 2024 09:19:11 -0700 (PDT)
Received: from localhost (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f9c72085f9sm18696855ad.79.2024.06.20.09.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 09:19:10 -0700 (PDT)
From: Takaya Saeki <takayas@chromium.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Junichi Uekawa <uekawa@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v2] filemap: add trace events for get_pages, map_pages, and fault
Date: Thu, 20 Jun 2024 16:19:03 +0000
Message-ID: <20240620161903.3176859-1-takayas@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
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
---
Changelog between v2 and v1
- Fix a file offset type usage by casting pgoff_t to loff_t
- Fixed format string of dev and inode

 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

V1:https://lore.kernel.org/all/20240618093656.1944210-1-takayas@chromium.org/

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 46c89c1e460c..3a94bd633bf0 100644
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
+		"dev=%d:%d ino=%lx ofs=%lld max_ofs=%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT,
+		((loff_t)__entry->last_index) << PAGE_SHIFT
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
index 876cc64aadd7..39f9d7fb3d2c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index);
 	return 0;
 err:
 	if (err < 0)
@@ -3286,6 +3287,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	trace_mm_filemap_fault(mapping, index);
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3652,6 +3655,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
 out:
 	rcu_read_unlock();
 
-- 
2.45.2.627.g7a2c4fd464-goog

