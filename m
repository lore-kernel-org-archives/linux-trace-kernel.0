Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E556846C;
	Sun, 30 Mar 2025 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743305692; cv=none; b=anG7wHGAlt2N6KuDg0GB8+aqPJV5D2WwqvLXmIXdQYj+keYNzJlIbEqg8XTFyyCSbd5zvNr7PDjHPmHDWsRTeSPOarwAlbVs15WJg6I6Dm+McBc2kx/5x4FtWp2uIbfHmcjb/ev2DqT0pxgsVlohqLwOvj0FRLwXuxSFOfEb5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743305692; c=relaxed/simple;
	bh=ZpDmFfTqDod7fD8BFl62uGKzhbYu8m1a/T0HXQFr9M4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hcCLHyMV5N4aGdcGm4k/Q6jtXZffW0f+qF4fjKfVvTByXCLHumRwdjfQtLl8Qd3fg+6poevqL/sYYmgk7+zbXJNq/x4mUYpzZHhmrhzT69MifeJVPE/xZjQaR1RsLYgCZNuSLb2pZfaxZFeMdqEp0NELfcW7GwH95uBkcpt1/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDaSlhT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDaSlhT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C040C4CEE9;
	Sun, 30 Mar 2025 03:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743305691;
	bh=ZpDmFfTqDod7fD8BFl62uGKzhbYu8m1a/T0HXQFr9M4=;
	h=From:To:Cc:Subject:Date:From;
	b=CDaSlhT56kbl88GFwWZrtEXQK4sBMOeiHhmtktBayrDgJps2Xu81wTRVJGuH8mPwe
	 r9MBeJxRBY53bJU02PJKtSlV9H26l6O9qNLZYKgp5UlxFWpE0PSX5udUA4ROdmYgcT
	 KXBVagrg+GwlhvCf3plyaX1MoC5uO0ebalveqLFQDDBbaCRV54ha3Fiia4KKWXD34Z
	 C4UP3PCEES8RyZXft/NwR0wpq5Kn31JFBKr08FlsfoKUyTis1x/uJUqm5CfRAXx1Yx
	 zKEmnCkcERe5OZouc6rbqRf1pFIFmklPRdq70bhIBC3JTQjOz5XzaDCig8dELL1R4h
	 ac4CrdyNWLupA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH] tracing: fprobe: Fix to lock module while registering fprobe
Date: Sun, 30 Mar 2025 12:34:47 +0900
Message-ID: <174330568792.459674.16874380163991113156.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since register_fprobe() does not get the module reference count while
registering fgraph filter, if the target functions (symbols) are in
modules, those modules can be unloaded when registering fprobe to
fgraph.

To avoid this issue, get the reference counter of module for each
symbol, and put it after register the fprobe.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20250325130628.3a9e234c@gandalf.local.home/
Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   67 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 33082c4e8154..cb86f90d4b1e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -445,6 +445,7 @@ struct filter_match_data {
 	size_t index;
 	size_t size;
 	unsigned long *addrs;
+	struct module **mods;
 };
 
 static int filter_match_callback(void *data, const char *name, unsigned long addr)
@@ -458,30 +459,47 @@ static int filter_match_callback(void *data, const char *name, unsigned long add
 	if (!ftrace_location(addr))
 		return 0;
 
-	if (match->addrs)
-		match->addrs[match->index] = addr;
+	if (match->addrs) {
+		struct module *mod = __module_text_address(addr);
+
+		if (mod && !try_module_get(mod))
+			return 0;
 
+		match->mods[match->index] = mod;
+		match->addrs[match->index] = addr;
+	}
 	match->index++;
 	return match->index == match->size;
 }
 
 /*
  * Make IP list from the filter/no-filter glob patterns.
- * Return the number of matched symbols, or -ENOENT.
+ * Return the number of matched symbols, or errno.
+ * If @addrs == NULL, this just counts the number of matched symbols. If @addrs
+ * is passed with an array, we need to pass the an @mods array of the same size
+ * to increment the module refcount for each symbol.
+ * This means we also need to call `module_put` for each element of @mods after
+ * using the @addrs.
  */
-static int ip_list_from_filter(const char *filter, const char *notfilter,
-			       unsigned long *addrs, size_t size)
+static int get_ips_from_filter(const char *filter, const char *notfilter,
+			       unsigned long *addrs, struct module **mods,
+			       size_t size)
 {
 	struct filter_match_data match = { .filter = filter, .notfilter = notfilter,
-		.index = 0, .size = size, .addrs = addrs};
+		.index = 0, .size = size, .addrs = addrs, .mods = mods};
 	int ret;
 
+	if (addrs && !mods)
+		return -EINVAL;
+
 	ret = kallsyms_on_each_symbol(filter_match_callback, &match);
 	if (ret < 0)
 		return ret;
-	ret = module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match);
-	if (ret < 0)
-		return ret;
+	if (IS_ENABLED(CONFIG_MODULES)) {
+		ret = module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match);
+		if (ret < 0)
+			return ret;
+	}
 
 	return match.index ?: -ENOENT;
 }
@@ -543,24 +561,35 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
  */
 int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
-	unsigned long *addrs;
-	int ret;
+	unsigned long *addrs __free(kfree) = NULL;
+	struct module **mods __free(kfree) = NULL;
+	int ret, num;
 
 	if (!fp || !filter)
 		return -EINVAL;
 
-	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
-	if (ret < 0)
-		return ret;
+	num = get_ips_from_filter(filter, notfilter, NULL, NULL, FPROBE_IPS_MAX);
+	if (num < 0)
+		return num;
 
-	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
+	addrs = kcalloc(num, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs)
 		return -ENOMEM;
-	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
-	if (ret > 0)
-		ret = register_fprobe_ips(fp, addrs, ret);
 
-	kfree(addrs);
+	mods = kcalloc(num, sizeof(*mods), GFP_KERNEL);
+	if (!mods)
+		return -ENOMEM;
+
+	ret = get_ips_from_filter(filter, notfilter, addrs, mods, num);
+	if (ret < 0)
+		return ret;
+
+	ret = register_fprobe_ips(fp, addrs, ret);
+
+	for (int i = 0; i < num; i++) {
+		if (mods[i])
+			module_put(mods[i]);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe);

