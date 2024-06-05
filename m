Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011B22615;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610646; cv=none; b=Wa8vYrkpD1JUaxFQEOZ2aAZ9bStQQCIFd1facCM1dhwj0lzjEalruAe5LMIDlj7qaN9Kx+3ELoapexhQ61vPcwMpyS1i1NTVBTYSssfSIlN79HkZAD8WuaV0K13hor3i30K1IQyqaprA4A1HuEI1OARucSDaDfR1saTQdemUjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610646; c=relaxed/simple;
	bh=2TJXagfC8pAu6tnAQ5vpaX2KJ7dFjjhqehXLDLvCGN4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b8LEy1oRrfOTjSvJNYX8a+4AhEUc4Yi7kz3JTbigmNNA3bo5Fo5p9YN7+c4/wqMGj+3UWaGLn1TmVAj766YjbBEq4Uk3gPJ9pjgFvLVTvCgZNEVf+fHFiGBUtuVT7e37SittIn8tQKexclfHgcVmGwUVTCcUJJ9obdUCQi8U+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC74C4AF0D;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEuzZ-00000000hYy-1L7v;
	Wed, 05 Jun 2024 14:04:09 -0400
Message-ID: <20240605180409.179520305@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 14:03:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/5] ftrace: Add comments to ftrace_hash_move() and friends
References: <20240605180334.090848865@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Describe what ftrace_hash_move() does and add some more comments to some
other functions to make it easier to understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83f23f8fc26d..ae1603e771c5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -169,6 +169,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
+/* Call this function for when a callback filters on set_ftrace_pid */
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
@@ -1317,7 +1318,7 @@ static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 	return hash;
 }
 
-
+/* Used to save filters on functions for modules not loaded yet */
 static int ftrace_add_mod(struct trace_array *tr,
 			  const char *func, const char *module,
 			  int enable)
@@ -1429,6 +1430,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 	return new_hash;
 }
 
+/* Move the @src entries to a newly allocated hash */
 static struct ftrace_hash *
 __ftrace_hash_move(struct ftrace_hash *src)
 {
@@ -1443,6 +1445,26 @@ __ftrace_hash_move(struct ftrace_hash *src)
 	return __move_hash(src, size);
 }
 
+/**
+ * ftrace_hash_move - move a new hash to a filter and do updates
+ * @ops: The ops with the hash that @dst points to
+ * @enable: True if for the filter hash, false for the notrace hash
+ * @dst: Points to the @ops hash that should be updated
+ * @src: The hash to update @dst with
+ *
+ * This is called when an ftrace_ops hash is being updated and the
+ * the kernel needs to reflect this. Note, this only updates the kernel
+ * function callbacks if the @ops is enabled (not to be confused with
+ * @enable above). If the @ops is enabled, its hash determines what
+ * callbacks get called. This function gets called when the @ops hash
+ * is updated and it requires new callbacks.
+ *
+ * On success the elements of @src is moved to @dst, and @dst is updated
+ * properly, as well as the functions determined by the @ops hashes
+ * are now calling the @ops callback function.
+ *
+ * Regardless of return type, @src should be freed with free_ftrace_hash().
+ */
 static int
 ftrace_hash_move(struct ftrace_ops *ops, int enable,
 		 struct ftrace_hash **dst, struct ftrace_hash *src)
-- 
2.43.0


