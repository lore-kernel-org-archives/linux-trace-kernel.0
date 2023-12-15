Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D32DB8B;
	Fri, 15 Dec 2023 13:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBE4C433C9;
	Fri, 15 Dec 2023 13:41:15 +0000 (UTC)
Date: Fri, 15 Dec 2023 08:41:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Have rb_time_cmpxchg() set the msb counter too
Message-ID: <20231215084114.20899342@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The rb_time_cmpxchg() on 32-bit architectures requires setting three
32-bit words to represent the 64-bit timestamp, with some salt for
synchronization. Those are: msb, top, and bottom

The issue is, the rb_time_cmpxchg() did not properly salt the msb portion,
and the msb that was written was stale.

Fixes: f03f2abce4f39 ("ring-buffer: Have 32 bit time stamps use all 64 bits")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78aacc78f03a..e9c10eabdb95 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -722,10 +722,12 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 cnt2 = cnt + 1;
 
 	 rb_time_split(val, &top, &bottom, &msb);
+	 msb = rb_time_val_cnt(msb, cnt);
 	 top = rb_time_val_cnt(top, cnt);
 	 bottom = rb_time_val_cnt(bottom, cnt);
 
 	 rb_time_split(set, &top2, &bottom2, &msb2);
+	 msb2 = rb_time_val_cnt(msb2, cnt);
 	 top2 = rb_time_val_cnt(top2, cnt2);
 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
 
-- 
2.42.0

