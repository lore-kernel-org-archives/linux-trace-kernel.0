Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B40445ACE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423907; cv=none; b=bLqu3mtsltswf/I19vBGUYbf9kyVlSdOsbqkNNPsEkzD/PDjD/ZUBPO2Trgf7BGPUekA9MXmyN72yTZBfZXB+/nGd7NRmafcIcmml1kp6GXv62KRnEmisblkECPujD7M8Hck5d5akVR2yZVvcQSOO5Jr3OVIH7JC0WR7BG4HlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423907; c=relaxed/simple;
	bh=ZWsK5kmob8SD6IqELo8YMKFpgsJgozluOyfkz+m4T+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+wmle5fnNS5FARdzwAnSk8D6GjxKIEycF25k7T8BOXEwWapLGE6MYmyeN64Iqt9j/8kjcCLJ3upUAfbl97dRK+aIk+qZD5Z0sRbQVYxeKZl2hmoQvsZ70gh8J4VJRav4WBnpIqcyOxzAmOoMvErm/KAgEatio7xPPAhYgGxCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p3rFWt8Q; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p3rFWt8Q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785423903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1OHYXEOzQMj232WABEM985nRKksG+guHX6je/Sfi50=;
	b=p3rFWt8QiUvL4oy7UZtaYEXZP6GNFrL3YHG20klGEgSsx8pKe6V5pqMo/8kZFU1rAe9ZRe
	0ZNuU/9M+mjUp9qwjhQaPLsI/7zhgm/ic/dGWbdkrD656p1Zi0po3NKNXMxa9i+2WIhSxa
	5R+/KzrI09jWgtNB4a8j/3TNeBqa6h0=
From: Leon Hwang <leon.hwang@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH 4/4] ftrace: Drop extra comma in trace_buffered_event_enable
Date: Thu, 30 Jul 2026 23:04:11 +0800
Message-ID: <20260730150411.88667-5-leon.hwang@linux.dev>
In-Reply-To: <20260730150411.88667-1-leon.hwang@linux.dev>
References: <20260730150411.88667-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the extra comma in "scoped_guard()" to cleanup the code.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 19cc07360005..19b0d7a53c58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1788,7 +1788,7 @@ void trace_buffered_event_enable(void)
 
 		per_cpu(trace_buffered_event, cpu) = event;
 
-		scoped_guard(preempt,) {
+		scoped_guard(preempt) {
 			if (cpu == smp_processor_id() &&
 			    __this_cpu_read(trace_buffered_event) !=
 			    per_cpu(trace_buffered_event, cpu))
-- 
2.55.0

