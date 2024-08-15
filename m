Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A419EEA4;
	Thu, 15 Aug 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737035; cv=none; b=t8qwHyRv1ru1hJf8YQI5jroyimnTj3h225t27MpoZr003KDmL6JE6J+oz3LCzGn6B33n3+3ooExbmie1PYdfrCSaKs25fUztcAN0GChgxWoMtNZi5wrTIbW/Np9MZ9HxTDQDkewc5zxRHwSQrZ+rJ2AbRaNsU1PeuXlpPpSBtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737035; c=relaxed/simple;
	bh=R8HdVbH/c1X4P4zF6q1ObFI49LFeJcgJjRZMzDcnxCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SqGW62Lj5GNZgsTKEk5rSB5avIfN248hx2Pz/rdP6XNzu64rmkS524+5N5cCcLRuwkj40WH760gvX0ibPw5/YOljKeIiTGrFj6aBHZdDdKkaWgjnt7FJot+2TyLyjRNIvz6T6hKcnI4SfluVj008f5zhFWbskJ7qoRNU9cIDOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1320C32786;
	Thu, 15 Aug 2024 15:50:33 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:50:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Add magic and struct size to boot up meta data
Message-ID: <20240815115032.0c197b32@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Add a magic number as well as save the struct size of the ring_buffer_meta
structure in the meta data to also use as validation. Updating the magic
number could be used to force a invalidation between kernel versions, and
saving the structure size is also a good method to make sure the content
is what is expected.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b16f301b8a93..c3a5e6cbb940 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -44,7 +44,11 @@
 
 static void update_pages_handler(struct work_struct *work);
 
+#define RING_BUFFER_META_MAGIC	0xBADFEED
+
 struct ring_buffer_meta {
+	int		magic;
+	int		struct_size;
 	unsigned long	text_addr;
 	unsigned long	data_addr;
 	unsigned long	first_buffer;
@@ -1627,6 +1631,13 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	/* Check the meta magic and meta struct size */
+	if (meta->magic != RING_BUFFER_META_MAGIC ||
+	    meta->struct_size != sizeof(*meta)) {
+		pr_info("Ring buffer boot meta[%d] mismatch of magic or struct size\n", cpu);
+		return false;
+	}
+
 	/* The subbuffer's size and number of subbuffers must match */
 	if (meta->subbuf_size != subbuf_size ||
 	    meta->nr_subbufs != nr_pages + 1) {
@@ -1858,6 +1869,9 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 
 		memset(meta, 0, next_meta - (void *)meta);
 
+		meta->magic = RING_BUFFER_META_MAGIC;
+		meta->struct_size = sizeof(*meta);
+
 		meta->nr_subbufs = nr_pages + 1;
 		meta->subbuf_size = PAGE_SIZE;
 
-- 
2.43.0

