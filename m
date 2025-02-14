Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E8267729;
	Fri, 14 Feb 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554501; cv=none; b=gU7oIkQj22mfxTzn6axI0K3mgi+i8FUQYCE//9Z92lNyWBzSQ5u1HuCJk0X315ulh+XOMLdVUVSnQyZYOGtXSPz02ip0wxJAXnXiSMb4ewlFEujol0+gTb31wPMWXk0vTlLRCkRXw15SOoCn7OEQ85Etezu4zxua+BORB4/Ci/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554501; c=relaxed/simple;
	bh=RdTlgalHnshCV0sh5+ciEsFgxnDihEsFXDYfNd5fo5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GrHRP+X5XGTnNb8cLFQsshiMbkkUMpLgdf8pfTq5wcVTIe8j81CEGQPpICy1/iLZsku9mmmVACYvr7BF2kdgmJxVXKpi0Cs7yYodwpwJhH7JRsBd/aqBLhwZNaD51DnZVd7rWsGxmKhCjYOEMiBYVVx2461/c5Tl1LuUnFeGswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A49C4CED1;
	Fri, 14 Feb 2025 17:34:59 +0000 (UTC)
Date: Fri, 14 Feb 2025 12:35:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Update pages_touched to reflect persistent 
 buffer content
Message-ID: <20250214123512.0631436e@gandalf.local.home>
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

The pages_touched field represents the number of subbuffers in the ring
buffer that have content that can be read. This is used in accounting of
"dirty_pages" and "buffer_percent" to allow the user to wait for the
buffer to be filled to a certain amount before it reads the buffer in
blocking mode.

The persistent buffer never updated this value so it was set to zero, and
this accounting would take it as it had no content. This would cause user
space to wait for content even though there's enough content in the ring
buffer that satisfies the buffer_percent.

Cc: stable@vger.kernel.org
Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0419d41a2060..bb6089c2951e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1850,6 +1850,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 				cpu_buffer->cpu);
 			goto invalid;
 		}
+
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
 		local_set(&cpu_buffer->head_page->entries, ret);
-- 
2.47.2

