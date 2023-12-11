Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6424F20D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC54C433C7;
	Mon, 11 Dec 2023 18:05:34 +0000 (UTC)
Date: Mon, 11 Dec 2023 13:06:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] ring-buffer: Add offset of events in dump on mismatch
Message-ID: <20231211130614.43ff4462@gandalf.local.home>
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

On bugs that have the ring buffer timestamp get out of sync, the config
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS, that checks for it and if it is
detected it causes a dump of the bad sub buffer.

It shows each event and their timestamp as well as the delta in the event.
But it's also good to see the offset into the subbuffer for that event to
know if how close to the end it is.

Also print where the last event actually ended compared to where it was
expected to end.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231207173108.484b912c@gandalf.local.home

- Also show where the last event added and where it expected to end.


 kernel/trace/ring_buffer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bc70cb9bbdb7..c28513624ab3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3429,29 +3429,34 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 		case RINGBUF_TYPE_TIME_EXTEND:
 			delta = rb_event_time_stamp(event);
 			ts += delta;
-			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
+			pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
 			ts = rb_fix_abs_ts(delta, ts);
-			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
+			pr_warn(" 0x%x:  [%lld] absolute:%lld TIME STAMP\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_PADDING:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d PADDING\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d PADDING\n",
+				e, ts, event->time_delta);
 			break;
 
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d\n",
+				e, ts, event->time_delta);
 			break;
 
 		default:
 			break;
 		}
 	}
+	pr_warn("expected end:%ld last event actually ended at:%d\n", tail, e);
 }
 
 static DEFINE_PER_CPU(atomic_t, checking);
-- 
2.42.0

