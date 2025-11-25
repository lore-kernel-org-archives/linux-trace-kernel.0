Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD91D61A3;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764106787; cv=none; b=BEAmweuv0+7Sl4SDFjyq5zmmDv6V69zl/+T2RHaYy0xUJry0pCSRcuRNbheI96ZcXlZkCoVzm5I9+Il3JnEVWL71aQa+ZnTXZ+6OMY34T9Ie0176EcPqdz4aQGilfEKgPzeDkQa5QLD5AiDAAKzKNpgAmZ3onMhOZfcegwgs8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764106787; c=relaxed/simple;
	bh=LBC2NLYIzg53Cvi5iggo757bpBm9xkAtIbRZJPAhd8g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O5WSKXNnAp5dfY+vg3tfbObL/mwrYR3kDAQJ31c2t7e+MWg0skh+irCk9edJyyrw+vSbt7H2UGDalkd0y4ShBIYeN5/KIUiMcxUvAluZG4UgetiUDmO4erVAA82Pf5n2RZx04YZVXqPrM6mSXs3CvacayD9yP7A1Hk31e1sAzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG6zBRAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG6zBRAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7FFC116D0;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764106787;
	bh=LBC2NLYIzg53Cvi5iggo757bpBm9xkAtIbRZJPAhd8g=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fG6zBRAOsVg5Xht9c5/jVFLG83KQMBlhi5brKTan4TI85NC81+rP+AjM8c5JztinC
	 Ua5vJSydhe6+9QNBYHSeG24TJl1CBv3xX8Ai4gaIZUFHVBO7gzEguMIvrAGQIcagGB
	 4JW1wSg7tNOuYyWSmwIDCSwH5KnVXlzgYVIhZ3Js93BYc0RVyM+NrEIVEZtIg1MhCZ
	 CqmJh2ZDnP5WxxoqGLi9Rmn2AikdTcFMwchSgCp59CLKEHU2uKnLdXrFXpmisfmAjs
	 Et+P8EHA9kvQn0Dhdt2/Joe/qbN9S0YZPtMvwfHnw5cN8v4ISYtvANCK5Oq6Ra97Xd
	 yWtFgsNZEmZ+w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vO0m0-00000005rNv-0WSN;
	Tue, 25 Nov 2025 16:40:32 -0500
Message-ID: <20251125214031.975879283@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 16:40:05 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 1/3] tracing: Remove unneeded event_mutex lock in
 event_trigger_regex_release()
References: <20251125214004.396482401@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In event_trigger_regex_release(), the only code is:

	mutex_lock(&event_mutex);
	if (file->f_mode & FMODE_READ)
		seq_release(inode, file);
	mutex_unlock(&event_mutex);

	return 0;

There's nothing special about the file->f_mode or the seq_release() that
requires any locking. Remove the unnecessary locks.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 7795af600466..e5dcfcbb2cd5 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -314,13 +314,9 @@ static ssize_t event_trigger_regex_write(struct file *file,
 
 static int event_trigger_regex_release(struct inode *inode, struct file *file)
 {
-	mutex_lock(&event_mutex);
-
 	if (file->f_mode & FMODE_READ)
 		seq_release(inode, file);
 
-	mutex_unlock(&event_mutex);
-
 	return 0;
 }
 
-- 
2.51.0


