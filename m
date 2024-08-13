Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA419AA73
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543401; cv=none; b=eyZSRfmAIOy4atQPpxU7/0FgyXlIrTtp0CAFUoqLwSwimnbOK/XFm7p5y+f770X4MGRQ3WvOUlzQCLOdxyYgrRbLILEP6FMUttdvzcmboeKFli9XnffCMMh8zVsLIB2ay+BxdqoRKKKaKQ3Xh2zy8qgOwkB6YPzs/F6p88n6UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543401; c=relaxed/simple;
	bh=ZaRZPIKMb9tT1bgJXnZN+jAzi+AtsUj/jTsR+EdbRoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv2oe8XuKp0IiSQyh3cmG0MH8Mq9AooWkL4AcsLRCnY4LWoMNLA8d9kgyr3fc7VrrVhxyeCfICyROVgjTMbJcKFoDK9BzkOGih49InR2orERsRzeXBH3lFQZO94QGMNOh/vMAtWHpZzB4hRU7X9l4D4dzKwFv/bnt0rgLNBGwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gB7aL9K8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB7aL9K8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso3638276a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723543399; x=1724148199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=gB7aL9K8rxT92KTPA0kUHFxVnq8g92F1/0AKw6e+zNZQ1SNqtgs+5iCbJPK89PagJa
         YQF478bmuSxDbkLlx5Qq1QqS0aH740VuEc7k8iTU5Yrjj61C/lmA74GZIHLWGEM+7FuR
         AA1zaADBs8Ye7lXJUM/vy2HwYIvJ9E2jt4A3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543399; x=1724148199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=aTCybK9FPWcXPe0J252E+pXm6QmAoGEAAzCW4BF1o3cehWEutof4BAtpSrp61LQBO0
         4/eBrXtF8HWEDcwvA4+KeVQdkjh0YyjLGKY5Iaj8Asj9HK2o5jO6ybsEo+kT9VBrzLLB
         IS4YRyPZV2hK8syh3Yz+kcG1SkPhbIHCVFlpi/zNET1TauwSRyof6BMgy4tsNtkYPakT
         +LfZ9pYYyZkqjuLE9xRNKcTdbEcMcdugL8I9OMY1zcW0pDPVSXDM1WtcQtgZ/FQfpUmG
         CiLnF9cfGUrDw/n4OxTfQITT5o6ZNqmSs4A9bY7XKnpW+rLipaJNb2+o3UDvfspzM/TP
         6teg==
X-Forwarded-Encrypted: i=1; AJvYcCU/5f3Xe+oXfwbbRi+AWpkF8lNzU9QTRCe1N5iYZq65oL3esH0NARelnIk1avI0h60uyksGGJ3sHaxc1dA4JNPKoVrxMfW6X4/Avu02AflmedIR
X-Gm-Message-State: AOJu0YztGjGM2VRhN3MhICE9iAbsKOuwbL1srgQTVKA+7M/fNNriGqjd
	1ddbdDF3TSHgA3tDqfNHng3lHjgVYxytWxNY2DRAmEZVA/bU9jDOacptxz6v
X-Google-Smtp-Source: AGHT+IFosWR7zkd7jgDT2HviKT6vEjybZ5RhsLylZWQSu4p1a07i1ADAXGsNcDrKZxIxqrj/LlkKPw==
X-Received: by 2002:a05:6a20:96c8:b0:1c8:d7b7:dcbd with SMTP id adf61e73a8af0-1c8d7b7dcf2mr2811688637.1.1723543399534;
        Tue, 13 Aug 2024 03:03:19 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c697a549d8sm944650a12.67.2024.08.13.03.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:03:18 -0700 (PDT)
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
Subject: [PATCH v3] filemap: add trace events for get_pages, map_pages, and fault
Date: Tue, 13 Aug 2024 10:03:12 +0000
Message-ID: <20240813100312.3930505-1-takayas@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
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
Changelog between v3 and v2
- Use a range notation in the printf format 

Changelog between v2 and v1
- Fix a file offset type usage by casting pgoff_t to loff_t
- Fix format string of dev and inode

 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

V2:https://lore.kernel.org/all/20240620161903.3176859-1-takayas@chromium.org/
V1:https://lore.kernel.org/all/20240618093656.1944210-1-takayas@chromium.org/

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
index d62150418b91..925eef5e16f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index);
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
2.46.0.76.ge559c4bf1a-goog

