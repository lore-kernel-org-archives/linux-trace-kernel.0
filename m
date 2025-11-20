Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C93368E02;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672197; cv=none; b=n1rWe76qn2HcIDg5OnU27F2LAW/ed+jzCvCFFNsOP33TDXsdduzHRUvRhoKqoe/s6OeZRernLR3idqIV/niNlGfzKGYvrHjg4/9qpAl+WqGlB+EUVGYuqt79bzaFopouEhKVyJlF3sTCkaCnGNGk5wORdv/+rJAFPV2+zEKhMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672197; c=relaxed/simple;
	bh=UQ0Fj894LqN0Ds2iUKog/SfQ2yXKaokcZWHHyVwFHJE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=It+y2s0bASAnhvU7Pq6gVbpYRrxPbdaraw5NHUNJn0k22Yympu7Aehv8O+mOP6zq2XUcM6oDqcfrVrkosIkVZO6M8hfBwf7/JL7Ls63mjikKTpqzJjkuulgI+lP2yPW7PAjM5xP7IK86bTmuYzT1QiaIeY3IzANS9Ax2JmA8SYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWVA54Ug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWVA54Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63116C116B1;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763672197;
	bh=UQ0Fj894LqN0Ds2iUKog/SfQ2yXKaokcZWHHyVwFHJE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PWVA54UgEIS69m+ngWwxajhW43QeN5YD3oChMDNvXUaUeC3DvS9qQcx5kDeICv7hr
	 j4vif8OHe0gmMQcRj/BUii++liAEg3NZjiyee/mHyg9BzNB8ExTuhVKtk2xMBCPQRu
	 GWx3blMe+Yq0lB9+CsntA30dzwj8+fh/Kk1WSMdPbV+4I9RUQSNzXY2BQC0NbEqsbF
	 GBGx6ZDMeEmO4fBoBWHfFPF9yIxtEYL+hrtDiC1fc04VBojEKFq0BB3BA4yM813NIV
	 twETmdZDldkVj+N1rZy7Gfy64ENxECHiI8+FXJJsmypnCUxT5f41O9mXUrdQKriWng
	 eBbvDaiORPskg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vMBiI-00000003zBQ-0Xuv;
	Thu, 20 Nov 2025 15:57:10 -0500
Message-ID: <20251120205709.984522508@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 20 Nov 2025 15:56:01 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/3] tracing: Remove unneeded event_mutex lock in
 event_trigger_regex_release()
References: <20251120205600.570673392@kernel.org>
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


