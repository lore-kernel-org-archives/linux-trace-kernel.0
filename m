Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE01FDE2B;
	Fri, 14 Mar 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967457; cv=none; b=Qn06Dc6bTFolbCW6OZhLmvMEdorb71rHVBZU1zzDH7FZNym+ClAcKS/EWsoXyMF6WKIIw2JN2c5pymdpmNKy32fBgfWM7Si0Y6/55E0F3nca3QD9pgi5NDn2MjmYQVfw/h/yZDeUmgws/q/57dj7941aiqJrlr1K7In6aONmU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967457; c=relaxed/simple;
	bh=AKNeT7I9L8uYDztJZF47bgZZU5WqdSoQ6VPicq2vYtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAk7xvJOsZd3rgSUNzMTV4G6gB2LskEfTSzgdWvKREuuFbvs1iEJQcsWDqLiy1Kc+mFXYV6TqslSzEH8+HoQAQvzELLyMhhwDpas1bdP2MNc8PjdZlM0QeB4+dHAUCtVTEo2DIP8DZ0CbV+sHfM2+TAiDWjMiGvz2Yc48FAlD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcYq5A0O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcYq5A0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F5C4CEE3;
	Fri, 14 Mar 2025 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967457;
	bh=AKNeT7I9L8uYDztJZF47bgZZU5WqdSoQ6VPicq2vYtg=;
	h=From:To:Cc:Subject:Date:From;
	b=IcYq5A0O4zwSX0dY32dildB5YMgA3Le31v0uy4ihF6T8Yr7Qy7+9GNqRyhViXI3It
	 TC5yJyCJq9mjay+sgZ77jSpVCrN7lC6dSWu8nGq1LaFWjhN9GnIysuD9LNVza0XN41
	 8GQ0GPhQaoT7/kMdi4kBP0B9Z3PfmO4wdDI8L9HCb3qBYhXUZVCM6IIJSP2LOQ9R5D
	 96a3ucRwRFK1E8mDKaS8BPK7gmDnf51n34aOMDxbV3/pnkdtajVCOs91lrRWu8pGCy
	 ZtQmiQRpfsAp97053Z24az+2c7c1L8MzKvUZvsxDfsDs+v6ZZE2c0RVUl1ZGoBabmI
	 lLSuISDX78msQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix build without CONFIG_MODULES
Date: Fri, 14 Mar 2025 16:50:49 +0100
Message-Id: <20250314155052.4170214-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The tracing code fails to build when CONFIG_MODULES is disabled:

kernel/trace/trace.c: In function 'save_mod':
kernel/trace/trace.c:6041:45: error: invalid use of undefined type 'struct module'
 6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                             ^~

The problem here is that 'struct module' is not defined in this configuration.

Enclose the functions in another #ifdef, just like other parts of this file
already are.

Fixes: dca91c1c5468 ("tracing: Have persistent trace instances save module addresses")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a6105b6dcc2b..51c030b9887e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6019,6 +6019,7 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+#ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6043,6 +6044,7 @@ static int save_mod(struct module *mod, void *data)
 
 	return 0;
 }
+#endif
 
 static void update_last_data(struct trace_array *tr)
 {
@@ -6060,7 +6062,9 @@ static void update_last_data(struct trace_array *tr)
 		tscratch->nr_entries = 0;
 
 		guard(mutex)(&scratch_mutex);
+#ifdef CONFIG_MODULES
 		module_for_each_mod(save_mod, tr);
+#endif
 	}
 
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-- 
2.39.5

