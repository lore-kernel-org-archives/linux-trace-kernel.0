Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAD14D294;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536534; cv=none; b=OpDvC/z97/fvv7MEyHBadHscHAlWNsCc07eHduNKiDGair7XKLJR2l6p1HZp5Tjj/Y+f444g82z809PISFscYE+5CjH99Xr1dycc19NnDHbfpewHKHHP8Svp0UfijgvAJVKHzMQUrpUQLgos684v2Oc1KIb5qfVcq8cZvtTzmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536534; c=relaxed/simple;
	bh=cbZW4vL3SMGQ0M8GRVOAdEPhzxcmYTygyL7401g8GNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bFYggO0eTS3Db/336bP9t2o82F8G0GkA7iKuuNiGZyalYUyc4R6JJSubTNghS06VUrZ9gsFJ2x0DV5Gowyceecpglu9T6prJKpsz+GeVT9mGR5MRBBH358CNZ/flH4huyOhamKvXdNrtY2VGzwzkJ7zy+IhmVPfRXaXp9WVDhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D7C4AF0A;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEbiB-00000000bFI-1T5m;
	Tue, 04 Jun 2024 17:28:55 -0400
Message-ID: <20240604212855.208119464@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 17:28:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] ftrace: Add comments to ftrace_hash_move() and friends
References: <20240604212817.384103202@goodmis.org>
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
index 021024164938..2d955f0c688f 100644
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
@@ -1431,6 +1432,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 	return new_hash;
 }
 
+/* Move the @src entries to a newly allocated hash */
 static struct ftrace_hash *
 __ftrace_hash_move(struct ftrace_hash *src)
 {
@@ -1445,6 +1447,26 @@ __ftrace_hash_move(struct ftrace_hash *src)
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


