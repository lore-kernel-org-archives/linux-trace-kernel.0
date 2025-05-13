Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3C1ACE0C;
	Tue, 13 May 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151408; cv=none; b=Qvun8MlrsRpsk5sYpzHW90MHRACdO0+2btiY9w/9uza/hcy3FTtcJgerh8NACqOZeqqH+pL9NDNV4YeOhnCXRCyoWpJ8XI2Vl/LdnPfuntrg0gjFwaVvOscLRmrpv3NBbZTD7Bqx8S0wZp4aenaQnIFi8Kgrb8xYjeKapXmP+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151408; c=relaxed/simple;
	bh=zKwFqYWMP6cuugdV9Ke6/xcQfhHjHZP9xRGohNCx+wE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k1W9gUoOokEq6rHsqvT1IXahZN9otgvdtujH4M9AX8bMZlf/v1UrnwgOKjVCItw7kV7ZOiSeZzSi6xQvnElQAevXweyOCKz18+1Ccyc4mild+9g+zYEjXw6sAi5cdMZ07gOdSsDo1KV2rGE6HTDxCJ5wYHfS4JSL1pwj42htOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D3C4CEE4;
	Tue, 13 May 2025 15:50:07 +0000 (UTC)
Date: Tue, 13 May 2025 11:50:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH] ring-buffer: Fix persistent buffer when commit page is the
 reader page
Message-ID: <20250513115032.3e0b97f7@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

\From: Steven Rostedt <rostedt@goodmis.org>

The ring buffer is made up of sub buffers (sometimes called pages as they
are by default PAGE_SIZE). It has the following "pages":

  "tail page" - this is the page that the next write will write to
  "head page" - this is the page that the reader will swap the reader page with.
  "reader page" - This belongs to the reader, where it will swap the head
                  page from the ring buffer so that the reader does not
                  race with the writer.

The writer may end up on the "reader page" if the ring buffer hasn't
written more than one page, where the "tail page" and the "head page" are
the same.

The persistent ring buffer has meta data that points to where these pages
exist so on reboot it can re-create the pointers to the cpu_buffer
descriptor. But when the commit page is on the reader page, the logic is
incorrect.

The check to see if the commit page is on the reader page checked if the
head page was the reader page, which would never happen, as the head page
is always in the ring buffer. The correct check would be to test if the
commit page is on the reader page. If that's the case, then it can exit
out early as the commit page is only on the reader page when there's only
one page of data in the buffer. There's no reason to iterate the ring
buffer pages to find the "commit page" as it is already found.

To trigger this bug:

  # echo 1 > /sys/kernel/tracing/instances/boot_mapped/events/syscalls/sys_enter_fchownat/enable
  # touch /tmp/x
  # chown sshd /tmp/x
  # reboot

On boot up, the dmesg will have:
 Ring buffer meta [0] is from previous boot!
 Ring buffer meta [1] is from previous boot!
 Ring buffer meta [2] is from previous boot!
 Ring buffer meta [3] is from previous boot!
 Ring buffer meta [4] commit page not found
 Ring buffer meta [5] is from previous boot!
 Ring buffer meta [6] is from previous boot!
 Ring buffer meta [7] is from previous boot!

Where the buffer on CPU 4 had a "commit page not found" error and that
buffer is cleared and reset causing the output to be empty and the data lost.

When it works correctly, it has:

  # cat /sys/kernel/tracing/instances/boot_mapped/trace_pipe
        <...>-1137    [004] .....   998.205323: sys_enter_fchownat: __syscall_nr=0x104 (260) dfd=0xffffff9c (4294967196) filename=(0xffffc90000a0002c) user=0x3e8 (1000) group=0xffffffff (4294967295) flag=0x0 (0

Cc: stable@vger.kernel.org
Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1ca482955dae..6859008ca34d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1887,10 +1887,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	head_page = cpu_buffer->head_page;
 
-	/* If both the head and commit are on the reader_page then we are done. */
-	if (head_page == cpu_buffer->reader_page &&
-	    head_page == cpu_buffer->commit_page)
+	/* If the commit_buffer is the reader page, update the commit page */
+	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
+		cpu_buffer->commit_page = cpu_buffer->reader_page;
+		/* Nothing more to do, the only page is the reader page */
 		goto done;
+	}
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
-- 
2.47.2

