Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10B2E406;
	Thu, 10 Jul 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156136; cv=none; b=Z9LJawLMXyhF3VmoJl9naXPfMYMwH9Ne9Ednt4dYR3zCqxLkrKW6N2DLIjH+Lc7dH8yXaz35FXEx0RC6P6qoj01mZcO52zV7zRSJjPUxnLV7KZbZctRl0NiBknAGoRHTTlLHquwvlbeAFlt3hSN7WbcOYF/7+Off117+yAUyKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156136; c=relaxed/simple;
	bh=Ijmbj3xOzEkLZirDypj5Z1yFCDCFkMyCGXynqHEowqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZTvlHWxpbTll/xg5WfHCTcY6edn6OkhHylStIM9eDZKH5j49kKENb1iVQpRYNRV81meG9Nw6CEqUgLbMH9JrtD8GJOObtSIdjKiqHfAUHBjZo324AE7PAb2Qq2xWxZWZHkBdR6tN5BOUJCAk2Zd2OJ9DibVcjaU1HbH1Ra45dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8C5341D72E1;
	Thu, 10 Jul 2025 13:56:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 064BD60016;
	Thu, 10 Jul 2025 13:56:27 +0000 (UTC)
Date: Thu, 10 Jul 2025 09:56:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix comment in trace_module_remove_events()
Message-ID: <20250710095628.42ed6b06@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j78xgr3jiageuapf5kjw7y3ukrrfzj96
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 064BD60016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hSOZpqMxsj0Oy5LhnPgKNXsqWB23nXSE=
X-HE-Tag: 1752155787-452959
X-HE-Meta: U2FsdGVkX18XxSX59ydGaeGJ9fZSwp9EuqxEtW6ncX+B95PalRV2/+aGk2VxgOf9zOCjNbknIWvwQv73jqFUUybeIQPCAHoW1WXsuVL6F+LeMAROsP6pUJk0wQPYu8tsC6HKhBwSfE1L+W8a1gNrQBn/3E4lv+hNkvJ+tSirlHrtkAsdzeWD8Y5s1j3vO9zZPhuwuvHgoTZfHp6clpthhvtlYdU4JtAZE1k1lIjo/pwpLP/yyXK3SNCoV/2iF9dc12Zp3XoIgUkmO+NX43rOd3JaMq7NYpL2yYO8yNSoBt7PE9Yw90tl/zqwiDKkQL7NcRHwu4focvq7F1L4L3//kEj5mwMNWJzb8+mAttKZkaPDhjnAIVXYTANmK66ZZ9u5

From: Steven Rostedt <rostedt@goodmis.org>

Fix typo "allocade" -> "allocated".

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..cdd4993d4a4a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3695,7 +3695,7 @@ static void trace_module_remove_events(struct module *mod)
 		if (call->module == mod)
 			__trace_remove_event_call(call);
 	}
-	/* Check for any strings allocade for this module */
+	/* Check for any strings allocated for this module */
 	list_for_each_entry_safe(modstr, m, &module_strings, next) {
 		if (modstr->module != mod)
 			continue;
-- 
2.47.2

