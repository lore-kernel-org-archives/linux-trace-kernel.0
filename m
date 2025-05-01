Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAE8635B;
	Thu,  1 May 2025 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746127144; cv=none; b=iy6w3l50q7ve/UdHduSR0iG0Tmnh73u24jE+4RHoEVxYzmB+R/EE1ljklW/A6dPXTUYdkp0IhwOTybsnipX6g5mTjA0NkID0MgyQBXCBG4Ohl4/Sm21PzvJ18GfwCf4hL3BnnGscd1tp7lCb/APs4/xAUVOfs3CmfbKSOm/gWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746127144; c=relaxed/simple;
	bh=TQeURipehEIVflObywpRqH/FmcyF79jIRGkpy/RBLnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=STJNuFw/iqus3fu74TR0+l/aLxr8siCfXqa7+FeGqnAYOV1fAFHHoq8OXZPplGh4w3GOlW9EIKvvODneSBjNPROWM6/SX9Xfk6Bm12942W9y4KdoMgSQ1qHDxnGMYl/i688mlBvUyFI1LAkSOCJuDZqDUEjCGrg6bUWZadxYAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C91C4CEE3;
	Thu,  1 May 2025 19:19:03 +0000 (UTC)
Date: Thu, 1 May 2025 15:19:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix trace_adjust_address() when there is no
 modules in scratch area
Message-ID: <20250501151909.65910359@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The function trace_adjust_address() is used to map addresses of modules
stored in the persistent memory and are also loaded in the current boot to
return the current address for the module.

If there's only one module entry, it will simply use that, otherwise it
performs a bsearch of the entry array to find the modules to offset with.

The issue is if there are no modules in the array. The code does not
account for that and ends up referencing the first element in the array
which does not exist and causes a crash.

If nr_entries is zero, exit out early as if this was a core kernel
address.

Fixes: 35a380ddbc653 ("tracing: Show last module text symbols in the stacktrace")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..7f586ce946f1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6043,8 +6043,10 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 	tscratch = tr->scratch;
 	/* if there is no tscrach, module_delta must be NULL. */
 	module_delta = READ_ONCE(tr->module_delta);
-	if (!module_delta || tscratch->entries[0].mod_addr > addr)
+	if (!module_delta || !tscratch->nr_entries ||
+	    tscratch->entries[0].mod_addr > addr) {
 		return addr + tr->text_delta;
+	}
 
 	/* Note that entries must be sorted. */
 	nr_entries = tscratch->nr_entries;
-- 
2.47.2

