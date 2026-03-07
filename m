Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749B18CBE1;
	Sat,  7 Mar 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850259; cv=none; b=fyKOjtCEo1AW+dEDMqxuAG19M6PrpEvD00IwmFxMrBLTHRkX8UNI31lAlk4D9c48dCZ3RmY3esIiN7ppTP4AL4Tkhu0nYufSCFgbUsPfpEsKN2hClQQCP5WlYDmMNNH9+DTxCMWq00OLoArudfVfVpJOZ/2verGCiXNZzv7Hclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850259; c=relaxed/simple;
	bh=IriSIysXuyW/n/CKlW8k9HC5m49avRsUzrHjR/Kub78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=osZkSZZoZs9PuMNh4hc1qg+IZ5M2PnQtlkM4D4TreLpOXq9j9YrI73NeAlvaigPeSL78jvWPRNiIfXy11dXVdLVMt1A0iXIjZq2w2m7lTv2zwp9fSgfva4GuoGamq9Wp0GIzU5nFYg1wf/6kcxanhqueJnyWlY73dJnozTQa2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DCE9759E33;
	Sat,  7 Mar 2026 02:24:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 14ED932;
	Sat,  7 Mar 2026 02:24:07 +0000 (UTC)
Date: Fri, 6 Mar 2026 21:24:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 John Stultz <jstultz@google.com>
Subject: [PATCH] time/tracing: Make jiffies_64_to_clock_t() notrace
Message-ID: <20260306212403.72270bb2@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ttm369mf1ez6ntswggeqj81mdahq8g86
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 14ED932
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wd6oHTOhjKhh+P6L3aI8xxUlb/UiuJyk=
X-HE-Tag: 1772850247-691700
X-HE-Meta: U2FsdGVkX1+04j5qWqLwA8ZeFXm2bta4h4Tp4IuveREDCQ1KQHnmPxI5WV91c9AtkB4EbuZ4tpiTOHAkmzE5B3FlSrUnqejiDnzX61vz71dVuyQZUR/TexGv+K9LhJYhSlLAvNgR0347YOo6PTOXej/c1mVR4ic9C0Qv9Kq/DkzRriDs9U0AidbPWJT1EMleS3bvb+e5fGBWpsw2ETgXIQIus6QltjqP0YqINGNusvWsZPKHCD4b1CieI8ha/Uk6hn0Wj+7mPzKDuH03cKgWpR6tN3KTgIU3tYhcKz6kubJgIZTcVFShlqWyAQYgwXIK/SiB9OPELYqb/AskQm7vEdQA3oCaPuGq5niphj6bjIlBZEu3XUzn4dAbZFe8vJwy

From: Steven Rostedt <rostedt@goodmis.org>

The trace_clock_jiffies() function that handles the "uptime" clock for
tracing calls jiffies_64_to_clock_t(). This causes the function tracer to
constantly recurse when the tracing clock is set to "uptime". Mark it
notrace to prevent unnecessary recursion when using the "uptime" clock.

Fixes: 58d4e21e50ff3 ("tracing: Fix wraparound problems in "uptime" trace clock")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 36fd2313ae7e..0d832317d576 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -697,7 +697,7 @@ EXPORT_SYMBOL(clock_t_to_jiffies);
  *
  * Return: jiffies_64 value converted to 64-bit "clock_t" (CLOCKS_PER_SEC)
  */
-u64 jiffies_64_to_clock_t(u64 x)
+notrace u64 jiffies_64_to_clock_t(u64 x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
 # if HZ < USER_HZ
-- 
2.51.0

