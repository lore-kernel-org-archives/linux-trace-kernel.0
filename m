Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4967A22D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D996AC433CA;
	Tue, 12 Dec 2023 16:52:19 +0000 (UTC)
Date: Tue, 12 Dec 2023 11:53:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit
 archs
Message-ID: <20231212115301.7a9c9a64@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Mathieu Desnoyers pointed out an issue in the rb_time_cmpxchg() for 32 bit
architectures. That is:

 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
	unsigned long cnt, top, bottom, msb;
	unsigned long cnt2, top2, bottom2, msb2;
	u64 val;

	/* The cmpxchg always fails if it interrupted an update */
	 if (!__rb_time_read(t, &val, &cnt2))
		 return false;

	 if (val != expect)
		 return false;

<<<< interrupted here!

	 cnt = local_read(&t->cnt);

The problem is that the synchronization counter in the rb_time_t is read
*after* the value of the timestamp is read. That means if an interrupt
were to come in between the value being read and the counter being read,
it can change the value and the counter and the interrupted process would
be clueless about it!

The counter needs to be read first and then the value. That way it is easy
to tell if the value is stale or not. If the counter hasn't been updated,
then the value is still good.

Link: https://lore.kernel.org/linux-trace-kernel/20231211201324.652870-1-mathieu.desnoyers@efficios.com/

Cc: stable@vger.kernel.org
Fixes: 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit")
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d9caee7f542..e110cde685ea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -706,6 +706,9 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2, msb2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -713,7 +716,6 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 
-- 
2.42.0

