Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEA326D55;
	Thu, 21 May 2026 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329294; cv=none; b=aBORieUryd26MAuWPehlSmllTKUGqsSDRN7lh/Ogn4XWYS8w5yuyudXoue3VubkY14XGeAKk77lCOLfRm5y+B0flOS1gCWyKYufGSC2oWRN4mB2iPV0LkP+af++fosfVu1VBZW1f5IoCDEosrrnYolzaOLoz754IBylutlCOTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329294; c=relaxed/simple;
	bh=w0hDiyMVHC/p6WP7EapY6Tl3ZbAkWbELiO2wIIEx29I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=My6hlgPRXvPIOAUDSCSVNCzU+glqabQCOJXKaUEsRgzZiHnGKpYZxO2WRTRFoZC8MD9JHBA1NVNoM/Ov8ovgcV8CWmhW9XpemjvTqtxb5kbXl+c276nxP8CRfoWIDJhyCVc99ZA6hU9bk6MreSdYnP38yWZ7XpYxdKqc3WVhEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 37057401A8;
	Thu, 21 May 2026 02:08:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 9302D32;
	Thu, 21 May 2026 02:08:02 +0000 (UTC)
Date: Wed, 20 May 2026 22:08:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] ring-buffer: Fix reporting of missed events in iterator
Message-ID: <20260520220801.4fd09d13@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9302D32
X-Rspamd-Server: rspamout06
X-Stat-Signature: aasyak63edfbbkzi4sdawrb89dxredo1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fQDB8lcdU2UWLbTe4vYly8A8L6qRCECw=
X-HE-Tag: 1779329282-672773
X-HE-Meta: U2FsdGVkX1+Jj3qVl5Ad2ppAsN6QGfnKTMpzWCqtg2IQgab/ReW3RjuULn4BdBDD9sLL/hVmYEQgwp9eCzezDBxbuzmPGrRskTEFIRH+KRvHrMkqra26C6feuV4zSzUHwxfDP08ePIv1p3Wd3I4UbGzTJPl2xqTGu4qQ/k0HJGURn09IaHL3d7tSYtBB0wTWCQhzD48n7M4yoO+DFGJ/e8u9t2/kw9dqbwk/efUdYvmodd1+aqIf1PrMp54iINkGop6T11bOqopgBsHHzAb3VZWSYCqsO+kTnTcW0CEp2hSFnRX/yDp9wHR6V96P8PIJq+7/FKiNKXoyBtReCMXvaSHvx/zR6RDXG79pPukyfgx24QWD4FKEAhvz4oruTSJvaEOjdtixMWuwsMfrMx+DACG4m6baTCU0x1hy6V0nTfmHAwfVuOwfXwXtZyNE21BFV16qSKnT+fxPk93uFSsEQaKv0DL10hqSYagCJbv2MDg=

=46rom c3651ad3ac95b331c7aa010d163704a3702855da Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 20 May 2026 14:28:17 -0400
Subject: [PATCH] ring-buffer: Fix reporting of missed events in iterator

When tracing is active while reading the trace file, if the iterator
reading the buffer detects that the writer has passed the iterator head,
it will reset and set a "missed events" flag. This flag is passed to the
output processing to show the user that events were missed:

  CPU:4 [LOST EVENTS]

The problem is that the flag is reset after it is checked in
ring_buffer_iter_dropped(). But the "trace" file iterates over all the CPU
ring buffers and it will check if they are dropped when figuring out which
buffer to print next. This prematurely clears the missed_events flag if
the CPU buffer with the missed events is not the one that is printed next.

On the iteration where the CPU buffer with the missed events is printed,
the check if it had missed events would return false and the output does
not show that events were missed.

Do not reset the missed_events flag when checking if there were missed
events, but instead clear it when moving the iterator head to the next
event.

Cc: stable@vger.kernel.org
Fixes: c9b7a4a72ff64 ("ring-buffer/tracing: Have iterator acknowledge dropp=
ed events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260520142817.4050abab@gandalf.=
local.home

- Added clearing iter->missed_events in rb_iter_reset() (Sashiko)

 kernel/trace/ring_buffer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7288383b1f27..7b07d2004cc6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5429,6 +5429,7 @@ static void rb_iter_reset(struct ring_buffer_iter *it=
er)
 	iter->head_page =3D cpu_buffer->reader_page;
 	iter->head =3D cpu_buffer->reader_page->read;
 	iter->next_event =3D iter->head;
+	iter->missed_events =3D 0;
=20
 	iter->cache_reader_page =3D iter->head_page;
 	iter->cache_read =3D cpu_buffer->read;
@@ -6108,10 +6109,7 @@ ring_buffer_peek(struct trace_buffer *buffer, int cp=
u, u64 *ts,
  */
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter)
 {
-	bool ret =3D iter->missed_events !=3D 0;
-
-	iter->missed_events =3D 0;
-	return ret;
+	return iter->missed_events !=3D 0;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_dropped);
=20
@@ -6273,7 +6271,7 @@ void ring_buffer_iter_advance(struct ring_buffer_iter=
 *iter)
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-
+	iter->missed_events =3D 0;
 	rb_advance_iter(iter);
=20
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
--=20
2.53.0

