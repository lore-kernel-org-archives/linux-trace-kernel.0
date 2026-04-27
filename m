Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4E386C31;
	Mon, 27 Apr 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291804; cv=none; b=SNqsUFJ5tvHRw52DFpyken7FtD1Zg/wSmutVvYFvpSDz3hPVCvnMlwW7pKTIgPlcMfy7ZZw9xFZPjNYiuXUiIdraPKGF9VQTDZ2O8adlo0bAPLBChbAIPeMkw6skL4n5oNLtLsMFRx8L764hJOAezQSZLU1ieKKTRA21faTQgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291804; c=relaxed/simple;
	bh=bV2ndRXStbhZ2JNRS2ODSnm9jpg5L9ozE8bdTGsPo48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIxwnelDZh8fHp5TGIvtp587KLpt/z8Fe72sGpvApgp8vn5nw4Xg5FCr1CCtzw5eBIBbVqBsNATolx9Af0/c8NuFplPTa7RK3T+fqPMIk+5DNeOOiThUj6feO+HooIrycfJCa3Xg9qckIrvlLlbk1v3kpbuk8rGRjKoeOtijEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMwH+xOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMwH+xOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FFC19425;
	Mon, 27 Apr 2026 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777291803;
	bh=bV2ndRXStbhZ2JNRS2ODSnm9jpg5L9ozE8bdTGsPo48=;
	h=From:To:Cc:Subject:Date:From;
	b=eMwH+xOCVlLRba18hcp6Fp537KYBQzyl7+AtZ10zXKSEKdlA3hZUXc9LjPhjzyOD0
	 6Xl+WZPw4VeNwydLy+LjqyuPtdweiJmmmGY7au0BZtGamI+Bo+zg4olocoadZrLhnK
	 Q+Eb4wwL/Al5DLbKm+PyTxfAep1z6L5h7gxZsEDav46Lfrb9dxIpKwImVfwvtC8QVm
	 Fhir1ZuKk2q5XOruUfjegceCdO2f6ePVIn6eUYj4rmi7NzxGItKYjZU9YLlah/2WH5
	 GwEx0Xd4frColjlLgigmcI+lZogDKaE1S10OV/WWTZVb+rMXrjkNCgVU9k+jcDEZWl
	 B9pHfUddbft9g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous unregistration
Date: Mon, 27 Apr 2026 21:09:58 +0900
Message-ID:  <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
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

Currently, unregister_fprobe() removes the ftrace hooks but does not
wait for the RCU grace period to expire. This is efficient for batch
unregistration of multiple fprobes (to avoid multiple RCU grace period
latencies), but it leaves a window where probe handlers might still be
running on other CPUs after the function returns.
If a caller needs to free the fprobe structure or unload the module
immediately after unregistration, they must manually call
synchronize_rcu() to prevent use-after-free issues.

To simplify this use case, introduce unregister_fprobe_sync(). This
function unregisters the fprobe and waits for the RCU grace period to
complete before returning.

Also, update the documentation of unregister_fprobe() to clarify its
non-blocking behavior and suggest using unregister_fprobe_sync() for the
last probe in a batch. Finally, update the fprobe sample module to use
the synchronous version on exit to ensure safe module unloading.
And add a fix to use synchronous version in the sample code and
trace_fprobe (unexpected error case).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobe.rst  |   15 ++++++++++++---
 include/linux/fprobe.h          |    5 +++++
 kernel/trace/fprobe.c           |   30 ++++++++++++++++++++++++++++++
 kernel/trace/trace_fprobe.c     |    9 +++++++--
 samples/fprobe/fprobe_example.c |    2 +-
 5 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 95998b189ae3..eee4860ab29a 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -65,6 +65,12 @@ To disable (remove from functions) this fprobe, call::
 
   unregister_fprobe(&fp);
 
+Or if you need to wait for the RCU grace period to ensure no handlers
+are running on any CPU (e.g., before freeing the `fprobe` structure),
+use::
+
+  unregister_fprobe_sync(&fp);
+
 You can temporally (soft) disable the fprobe by::
 
   disable_fprobe(&fp);
@@ -81,9 +87,12 @@ Same as ftrace, the registered callbacks will start being called some time
 after the register_fprobe() is called and before it returns. See
 Documentation/trace/ftrace.rst.
 
-Also, the unregister_fprobe() will guarantee that both enter and exit
-handlers are no longer being called by functions after unregister_fprobe()
-returns as same as unregister_ftrace_function().
+Also, the `unregister_fprobe_sync()` will guarantee that both enter and exit
+handlers are no longer being called by functions after it returns.
+On the other hand, `unregister_fprobe()` does not wait for the RCU grace period,
+so handlers might still be running on other CPUs for a short time after it returns.
+This is useful when you unregister multiple fprobes in a batch to avoid
+waiting for the RCU grace period for each one.
 
 The fprobe entry/exit handler
 =============================
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 0a3bcd1718f3..6ae452e250a1 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -94,6 +94,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
 int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
 int unregister_fprobe(struct fprobe *fp);
+int unregister_fprobe_sync(struct fprobe *fp);
 bool fprobe_is_registered(struct fprobe *fp);
 int fprobe_count_ips_from_filter(const char *filter, const char *notfilter);
 #else
@@ -113,6 +114,10 @@ static inline int unregister_fprobe(struct fprobe *fp)
 {
 	return -EOPNOTSUPP;
 }
+static inline int unregister_fprobe_sync(struct fprobe *fp)
+{
+	return -EOPNOTSUPP;
+}
 static inline bool fprobe_is_registered(struct fprobe *fp)
 {
 	return false;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index cc49ebd2a773..5f3e48385a47 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -1097,6 +1097,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
  * @fp: A fprobe data structure to be unregistered.
  *
  * Unregister fprobe (and remove ftrace hooks from the function entries).
+ * Note: This function does not wait for RCU grace period, since user
+ * may use several fprobes (and then unregister them one by one). In that
+ * case, it is recommended to use unregister_fprobe_sync() for the last fprobe.
  *
  * Return 0 if @fp is unregistered successfully, -errno if not.
  */
@@ -1110,6 +1113,33 @@ int unregister_fprobe(struct fprobe *fp)
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 
+/**
+ * unregister_fprobe_sync() - Unregister fprobe synchronously with RCU grace period.
+ * @fp: A fprobe data structure to be unregistered.
+ *
+ * Unregister fprobe (and remove ftrace hooks from the function entries) and
+ * wait for the RCU grace period to finish. This is useful for preventing
+ * the fprobe from being used after it is unregistered.
+ *
+ * Return 0 if @fp is unregistered successfully, -errno if not.
+ */
+int unregister_fprobe_sync(struct fprobe *fp)
+{
+	int ret;
+
+	guard(mutex)(&fprobe_mutex);
+	if (!fp || !fprobe_registered(fp))
+		return -EINVAL;
+
+	ret = unregister_fprobe_nolock(fp);
+	if (ret)
+		return ret;
+
+	synchronize_rcu();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unregister_fprobe_sync);
+
 static int __init fprobe_initcall(void)
 {
 	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..fa5b41f7f306 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -845,8 +845,13 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 /* Internal unregister function - just handle fprobe and flags */
 static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 {
-	if (trace_fprobe_is_registered(tf))
-		unregister_fprobe(&tf->fp);
+	/*
+	 * Here, @tf must NOT be busy, so it MUST be unregistered already.
+	 * But if it is unexpectedly registered, unregister it synchronously.
+	 */
+	if (WARN_ON_ONCE(trace_fprobe_is_registered(tf)))
+		unregister_fprobe_sync(&tf->fp);
+
 	if (tf->tuser) {
 		tracepoint_user_put(tf->tuser);
 		tf->tuser = NULL;
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index bfe98ce826f3..382d2f67672a 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -142,7 +142,7 @@ static int __init fprobe_init(void)
 
 static void __exit fprobe_exit(void)
 {
-	unregister_fprobe(&sample_probe);
+	unregister_fprobe_sync(&sample_probe);
 
 	pr_info("fprobe at %s unregistered. %ld times hit, %ld times missed\n",
 		symbol, nhit, sample_probe.nmissed);

