Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27202853E2;
	Mon, 11 Aug 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894548; cv=none; b=K1uk5O3pIUkxairXTW1vWIMd+6EbfxR3jLUhBY1KcjVwwc9/ljfgcOJd3kRCduQp0D9S45oL7FhKtaeCWoLjSdMDSgARIAigL6L/iUm+BYje72HpfB8mwrJTK53ViU7JVD6X2t7l2DW0SH+zd/CV5BzkKbyr34edJHdodCYVbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894548; c=relaxed/simple;
	bh=lG11KhyzuKq5MfwV+1H/tvxyhKnhO3Ybqcw29O/gs1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2fjs7KnUbmNtaSpYk8LpFPYDrjXB0LembX5+Kw32s5BMwd0KTnzQUUthVKPK3NEcHcrNcKkZbepehDYEF37XLqN7DH+hPAazs2mDvvjyb058kjEF8AZk5Lw6y3xCj1VZniAM9mwSA8JIc5laylzuxyHFK0zT+opsHHjQ/o0GjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] tracing/osnoise: Use for_each_online_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 14:41:58 +0800
Message-ID: <20250811064158.2456-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
more readable and equivalent for_each_online_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/trace/trace_osnoise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..4cb464894faf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -271,7 +271,7 @@ static inline void tlat_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 		if (tlat_var->kthread)
 			hrtimer_cancel(&tlat_var->timer);
@@ -295,7 +295,7 @@ static inline void osn_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 		memset(osn_var, 0, sizeof(*osn_var));
 	}
-- 
2.36.1

