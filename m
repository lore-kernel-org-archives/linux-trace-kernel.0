Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BE244677;
	Thu, 12 Jun 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736721; cv=none; b=OZMWpU5fhR0w2vaCe6aAOwdqO8WOHH6A/SVKts7vlDxj/IlTIbMaPWWPUc4VzZprY/8SEQB0kRcqB8sI05BfZOTai9Ax1z2H/pOIp4zli3/6lDvJxJCgQUNbj+ckC6wsvKJjalr8pqkPLpc850E2pLqKCpX2XvNb+fr2s3HcehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736721; c=relaxed/simple;
	bh=5fG+ma7be2HXjLZY8eb1IqmlxKPaqchKCh/xX1V/3tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MqiS91tHQWFYANLkyENnHw51ZEafTpAYcFqjPqpONSQDgivbgKS/aEMYskCdM9bbgYrTMb9w23w6IX1DhJt3gv7QPCUr0v4zN26te+esAiBYedf1urr+cPI+JHm4fvForGABjpbvab/NQWk78SNM6FYjaLHFMFkHt8MIumw81aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2F5CE161545;
	Thu, 12 Jun 2025 13:58:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 556FB80013;
	Thu, 12 Jun 2025 13:58:29 +0000 (UTC)
Date: Thu, 12 Jun 2025 09:58:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] alarmtimer: Hide alarmtimer_suspend event when RTC_CLASS is
 not configured
Message-ID: <20250612095828.6d75dfa3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 556FB80013
X-Stat-Signature: rzt6kqk8ua561tgw3cbq78kzrcybddjk
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18vTyB+un0k1UFtVDec50hBidb6Mf66z3k=
X-HE-Tag: 1749736709-495039
X-HE-Meta: U2FsdGVkX19IPBBr4fOfFrdKCfTM4a/mK0amP6fvrFRKcEu5wAOkqxt0EK+DfBOCMGOTf2HMVHpXyPeoZhzox9wHHqVatbDgDFW7Z/fXwfykuJsOzaedor0V4YdGrvZ7/JEpHoRxcEwoHGPzTUzik6I5vSyedFBS8AY2e9uu9X5oS9pd0QGY/zqazdLzIWi32ukVti3kKDio4B1+BbEcVBgvCgZQcB91r4nX8FGsnptAY9q+/J5axGDBFFPFiQRUjA+9Vut94HsHRFV20ieLwnuW+NYpvP/JtwRkI5dj0OQmct17Wmgp4SI6fDfeCVyFIZXldlq2hUVEh0fA61R4H4PWK4iDNjKPOq4fWNUnt8CQmqmy6ftUrvhshw0U41tt

From: Steven Rostedt <rostedt@goodmis.org>

The trace event alarmtimer_suspend is only called when RTC_CLASS is not
defined. As every event created can create up to 5K of text and meta data
regardless if it is called or not it should not be created and waste
memory. Hide the event when CONFIG_RTC_CLASS is not defined.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 include/trace/events/alarmtimer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/alarmtimer.h b/include/trace/events/alarmtimer.h
index 13483c7ca70b..8e9c76a7f21b 100644
--- a/include/trace/events/alarmtimer.h
+++ b/include/trace/events/alarmtimer.h
@@ -20,6 +20,7 @@ TRACE_DEFINE_ENUM(ALARM_BOOTTIME_FREEZER);
 	{ 1 << ALARM_REALTIME_FREEZER, "REALTIME Freezer" },	\
 	{ 1 << ALARM_BOOTTIME_FREEZER, "BOOTTIME Freezer" })
 
+#ifdef CONFIG_RTC_CLASS
 TRACE_EVENT(alarmtimer_suspend,
 
 	TP_PROTO(ktime_t expires, int flag),
@@ -41,6 +42,7 @@ TRACE_EVENT(alarmtimer_suspend,
 		  __entry->expires
 	)
 );
+#endif /* CONFIG_RTC_CLASS */
 
 DECLARE_EVENT_CLASS(alarm_class,
 
-- 
2.47.2

