Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB153FCB0C;
	Wed, 20 May 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303005; cv=none; b=eNyDUXEV85AACMNEquMUrxBdzyqrDihgWPHBBM1b5ShOBhlUoMzN93d4UKY7QTer9egX9dc7RPn9+BIGj6g+KBQuehvKjig0oFct6i9DM4DNAyuytrTQ2I1fMiiViMLLOv9GK0RFGOJuwNZpDx26GnXdqcEMU7SLT/ZuTNpjjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303005; c=relaxed/simple;
	bh=7cStp9iAFCfzNIMOS1aeqeiXWQXiHMpbhyTbXVbKyF4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lyAFGda58s06QHlvC7mUyspRGTimsCJh9n7NSwFs/RC17iqa2DD7xWaiu9Vv+dWIMGcFggQFp5USpdaUkMsckVusmR+aosGbuhUngkg1tm7tvU7SmBf79V1PUFPAA5mnQ3Vo7WPJIz/49gHBarem+J9VX/MA4EwRy8saqtJHs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+N5UzLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+N5UzLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB3A1F00893;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302998;
	bh=U/nH3wN6/B7CzarRELedI5Kh63j9KxKoMaDk29Z7PXA=;
	h=Date:From:To:Cc:Subject:References;
	b=U+N5UzLGp+lpgwVNcOqmB0liFqRHLkFo0rar4H1Y4ElTReCJVenHhT2gCGv7Da3jv
	 h6wZfRwDASeikjoexq7/P7/W3gBEKMdhI3uEl8/RGq0loVsghtedXgIXw+i6GCXdfM
	 2Po7m5vRbXYi108DP/Pt2iHOSAlwTmW16pp+3l5cO2kgAwQqw4TtZ8XpqAfAe19k/9
	 RDkNC7ybuFMSFN+OnyU591GDChe+3XfggWM1SzZmRZWWoO/iJaVoP5CImDaqC7J3kJ
	 QcazbGVg6x5d+sorrgu8AYCJVH+Gs9qXesogTC9gyqtjUls7gvJDcKefzSUpwj7LQP
	 jCdL1iiCEE0HA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzm-00000004qTo-0jiZ;
	Wed, 20 May 2026 14:50:18 -0400
Message-ID: <20260520185018.051228084@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 07/10] ring-buffer: Skip invalid sub-buffers for iterator
References: <20260520184938.749337513@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

On bootup if the persistent ring buffer finds an invalid sub-buffer, it
only invalidates the invalid sub-buffer and continues. Several sub-buffers
may be invalid and this can cause the iterator to loop more than 3 times
looking for a new event. If that happens, then it returns NULL. Having a
NULL return early can confuse the iterator looking for the next event, and
may show events out of order.

Have the same logic for the consuming read for the iterator that will
allow the loop to find the next event to happen the number of sub-buffers
and not just 3.

Fixes: **TBD** ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6c2f92bfc24..bda53a2d2159 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6103,12 +6103,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
+	int max_loops;
 
 	if (ts)
 		*ts = 0;
 
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
+	max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
 
 	/*
 	 * Check if someone performed a consuming read to the buffer
@@ -6131,7 +6133,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	 * the ring buffer with an active write as the consumer is.
 	 * Do not warn if the three failures is reached.
 	 */
-	if (++nr_loops > 3)
+	if (++nr_loops > max_loops)
 		return NULL;
 
 	if (rb_per_cpu_empty(cpu_buffer))
-- 
2.53.0


