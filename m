Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD753245008;
	Thu, 13 Feb 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470788; cv=none; b=MS2b18FBER3PFB7JRyucubxeWO9Urk8yEGJHxGeIHEY5B4aX77VhyiPiDAUESLdvCwrp84+pr9WGalhOEkYJAECW9nfTnr78LVAOjH8d3OkmHNFQr40ovkWrDHu9WoyUbOhgKph7/nr9xitmPVEu3jwudzspLA3ikxDr4yrHwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470788; c=relaxed/simple;
	bh=VuurLnqN+FB3hPgjykP4dy2hW3XD6JxMvkT5P4qSHG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kCWzONJCmArLszKnQRM6SooytrYd1O6+ZKBH0sL2YjNZALypG6TbbdiUJiMwPVoOWxH8N77+zFQZPX+nOCREdjbrv47/sVSNABlDWFR+k1TNy8XxiJ99oAIf8oyNONqCLnqKRPNxDXEWfqXjgTDJkFri6QzXnYXKYw3xtGhs9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8DAC4CED1;
	Thu, 13 Feb 2025 18:19:47 +0000 (UTC)
Date: Thu, 13 Feb 2025 13:19:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Unlock resize on mmap error
Message-ID: <20250213131957.530ec3c5@gandalf.local.home>
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

Memory mapping the tracing ring buffer will disable resizing the buffer.
But if there's an error in the memory mapping like an invalid parameter,
the function exits out without re-enabling the resizing of the ring
buffer, preventing the ring buffer from being resized after that.

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e0ae15ca5b..07b421115692 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7126,6 +7126,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		kfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
 unlock:
-- 
2.47.2

