Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A99219E8D;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795823; cv=none; b=hBAhs2hRizTW78uJKRql3bOlveO1TQp9TcAMhYNkmViPZwVcFwRwYatK5sqJo/JemuLUkIPtNsXjVzRpBl4xChEwX20STei1DDIYsdkVtD5FpMVia3k9f1ZxV3CewPr35c0so5OUJpRKCZx+osGaBx8TIAHAxlouIbBP6iURRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795823; c=relaxed/simple;
	bh=CuFfCrM/KWTO6l4n6Pk5lAeKKczZbJi1XocjxEN0ARQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cLucNNS6AHQct3mtoJhFbUm998ahcrpAQfkTYhTacjYroLfMo7bhK0slxTBKESP86jcn0aLhvN0bE6z6Bq/S4Wgyyt1i7+nF9PUGGYtOdMHZKUiF3jUl46N47e4+LxR+5jYfqVNgtro+cZKb/3DeYkIS6K69af2AxH839nbWR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE51C4CEE6;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEZ-00000007gUd-2Prk;
	Wed, 05 Feb 2025 17:51:03 -0500
Message-ID: <20250205225103.425325060@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/8] ring-buffer: Add ring_buffer_meta_scratch()
References: <20250205225031.799739376@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that there's one page at the start of the persistent memory used by
the ring buffer, make the part of that page that is not used by the ring
buffer available for the tracer to use. This will allow the tracer to
store its own persistent data.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 8de035f4f0d9..b95f940fd07a 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -95,6 +95,7 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       struct lock_class_key *key);
 
 bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0446d053dbd6..5a81ff785665 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1730,6 +1730,9 @@ static bool rb_meta_init(struct trace_buffer *buffer)
 	bmeta->total_size = total_size;
 	bmeta->buffers_offset = (void *)ptr - (void *)bmeta;
 
+	/* Zero out the scatch pad */
+	memset((void *)bmeta + sizeof(*bmeta), 0, PAGE_SIZE - sizeof(*bmeta));
+
 	return false;
 }
 
@@ -2532,6 +2535,16 @@ bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kas
 	return true;
 }
 
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
+{
+	if (!buffer || !buffer->meta)
+		return NULL;
+
+	*size = PAGE_SIZE - sizeof(*buffer->meta);
+
+	return (void *)buffer->meta + sizeof(*buffer->meta);
+}
+
 /**
  * ring_buffer_free - free a ring buffer.
  * @buffer: the buffer to free.
-- 
2.45.2


