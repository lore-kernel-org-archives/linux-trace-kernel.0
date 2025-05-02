Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED03211A05;
	Fri,  2 May 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219230; cv=none; b=coHkn/kwrGpSNaYT6hTfZIHiio4XbR0BQbz3Za+tsDEf7/+SwOWLBHCg5jghnhkKuMbSgSvWFoDCJlGMWpW1OsvaavAO6defUjUYFEuyyeA+29/jVGhtMyJjSi7ZgYLEXqlXEIyLOSyagoB5QKki9Hm0OQPuf9h2HzCIj/TCJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219230; c=relaxed/simple;
	bh=ntjYQudrFrlV6oqiTHASZOhqo5CjgZj8Hu+aw8K3usg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mMQVZ5ITtQM3VamlKYqqtWUmehxZdSG2Zm3dloF/HI9rd83S9n9Er+NPkA9fvL6CbyupdjjZ3om+Be8IfK5sNxzCtSVsIHUekIib3S3DtUez3CT4XCMRDp5ku1YWpBorqhmdyO70UiJg9Rlyd4eS2OBfD13YM1kYze6sbDQb86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB3FC4CEF1;
	Fri,  2 May 2025 20:53:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOH-000000006F5-3rJ6;
	Fri, 02 May 2025 16:53:49 -0400
Message-ID: <20250502205349.780984353@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/12] tracing: Remove unused buffer_page field from trace_array_cpu
 structure
References: <20250502205147.283272733@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace_array_cpu had a "buffer_page" field that was originally going to
be used as a backup page for the ring buffer. But the ring buffer has its
own way of reusing pages and this field was never used.

Remove it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 646fb5c1066e..499f8d294861 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -184,7 +184,6 @@ struct trace_array;
  */
 struct trace_array_cpu {
 	local_t			disabled;
-	void			*buffer_page;	/* ring buffer spare */
 
 	unsigned long		entries;
 	unsigned long		saved_latency;
-- 
2.47.2


