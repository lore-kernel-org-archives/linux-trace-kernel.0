Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192939;
	b=fP09V2MEISAFO01Ct6Jj41rt+GdMS0TcQKeVm1bRPaDo6hJ2i/W6EOH7rNu+F20J3Qph
	 kRIRjkOs8hiPDSubY4KwcG/8hv3G0xJeI57hV5VI3JHcNtuDyMb12eXPbPUs7LCQCY+E6
	 Om/y5WTFn/apQtg2bVAkHC/wlEIPEANMokzEjmYPegqd0jB8Wjfr+KTQfXuqc8s8JPf4V
	 LhbCfV1pUaTsa9jjE27cS82l5BSyWjBq09Nlu39hX/H1d4O+6nuobuf0XWBCIoyaVAaBU
	 iPTlVtnmPD8+9sP8QDrEtTxJeQw4sMcLcuoviKRIBd0GD1q/qRrOLs3/DRoumalXhfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192939;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4ZU4BW5tpDuq5rGEYxp09JU2RCU7i5x6/SS5iCRervw=;
	b=HLubg2yJHdHa2b9jwrpt5UA0p1J7VhG2N8b2HvvbHBt/aRrWD1fGxz5fffTlKCeyM7lM
	 szVbvU6CEV0YcrZFi6iLiLwEBpXfa2afb2taOL3LfvPaWtCSJsI3fYHZBRK8BnOIGOXiS
	 b1C8KVS0MTVTgr9tjDOEyVzYcBWFUWtP8eU+XIAVmLZoHQikqHNshBs8drvtpr94yQFqz
	 ajC2SM8JleObaB8YQq/DOu77VzoXKA6pjN0C3PEG9icuxqv+jY3L92g/P3ClUecveIW0N
	 NJqxd+Zgzxr1qhAC0Ron3cVJrsaTvLtvxiAsEXEefwpHRhGjC6mEqg66wSNKsqYdpsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SVW0lgn2;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1152606A320;
	Mon,  9 Nov 2026 02:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1152606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SVW0lgn2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794192915; bh=4ZU4BW5tpDuq5rGEYxp09JU2RCU7i5x6/SS5iCRervw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVW0lgn2UXY0TiiH0ezn9U3A4t7LfTGB9ZWKpNCOvI3R7AZVLrYPQK9qNKh/2nrQF
	 N1+7IA0NjlJBYCfP8c1XG0+6gVOkhzqqnI54ng3aV4VRuy1b8cEDKgZVIhRGP6GCxI
	 AyEAg62nrfrMOGgO4y83PEd4QiPeLa7pSm3Od/ZU=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id DCCAECE2; Mon, 09 Nov 2026 10:55:12 +0800
X-QQ-mid: xmsmtpt1794192912tju46cxdb
Message-ID: <tencent_1C5982E4E79A087063C5142622DDF7A4B909@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJm00y6rP0EAb1STJWmk9HRZRoZjB2Cv7iGHIhAnUX0035QRqO5o
	 0tiXicJbtFhMOjVgz4M54gjQ4+vjOZSXhFT8BRsYknaG6IhxLbjL9BOM8RUHzDXVijEYDnnyuKoN
	 gL7X4EprYgi0YT3ZNL3mIKQ1XrTzrbfjBECErytW/TIFSd2tDt9yZoqsZr8Dbmm2ar/FXqTjonOT
	 j9tocBfU+DpLsMOvUAcnc4hyrPdQx89EOxPsyLMALylPejnx9FG6btTgBUQj3MmAQdj3UZYb5Z7U
	 scbbIKRvEAH7LinKpfoUy5tZi2wWvxjVXDzleflGig6ICvonje7tg01zyYaw3AXU7nOB+Qw1sA/y
	 LqjfIhV5yWjKnmf8tG7PAiaV3MLtwP7OmnMXN+ItfjD+wm8jfU1mWiEG7g7OmWHR/ASZxwPBxuiE
	 yZsdTxWXToVa5KtAQ/QB6sIeA82/6IdKIf4pFTm7C3bSYxEmyXCA5PwBkNb4tjEKQOiB6Fe2Iock
	 3nH9ueBS1q+dcUuR1/fxEMy4VLtykDfsGidG9DQzWht23eEUlW3EUzv91PGFn6jGee6MrPEmQtiB
	 9HWB04qX+RHkeY+B6Gngn2upJJL8IsYDU57AkicuBb5NFaRYgD1yks70BZPqT6UAN1NWrPbrXWBQ
	 ldJSSkCSMkME6APcs+tWgJvZ9TLNAgHZ77IhyeulUuz2oyV99fgMqQISdiY+DfOdXeBe3QvcJnRs
	 phny8Urw0O295tHwcPQnNCsMeW5EobnhomkW7QVhmERbdFOXm9AuthTIlm8eNjvou24g2SFezC31
	 8Uw9r4BedO8XgWjOwfy2XFT+yy7hfmWBwP+ilajfxNNytxOD/yQp/hBjSX/4TKSchL4UqvjXoR9c
	 Qk0lpSScKJ7oOt5O281pHDnzvQRpQfQ4fYYivK7Nkp3AZaNpxG2uihnG9S0SpOKlbLF4vIIepUKN
	 3suCoOjYxyWMtaQwgyAWM5MRnIBuMhiLP/nQD79BwW2erhedHLLg94PDlRnHaHUe2FjhpLQrEuTP
	 SWpmhfrY4x5J1PzQZs7LV2cbYsvaecue0HG8HQQZHEv76oD5eOW50ysgL/BINIF5aj6IftdQ87fd
	 R7T1tN
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+008851bf625629489e75@syzkaller.appspotmail.com,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH] ring-buffer: Reset per-CPU buffer state in ring_buffer_subbuf_order_set()
Date: Mon,  9 Nov 2026 10:55:12 +0800
X-OQ-MSGID: <20261109025512.153242-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6af009ed.4dd4714a.f8d02.000d.GAE@google.com>
References: <6af009ed.4dd4714a.f8d02.000d.GAE@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_subbuf_order_set() replaces every page of a ring buffer
with newly allocated empty pages when the sub-buffer order changes.
However, it does not reset the per-CPU accounting of the discarded
pages. The stale counters (pages_read, pages_touched, pages_lost,
entries, ...) continue to describe pages that no longer exist.

A full waiter (e.g. poll on per_cpu/*/trace_pipe_raw with
buffer_percent set) then causes ring_buffer_nr_dirty_pages() to read
the stale accounting, and the invariant pages_read <= pages_touched -
pages_lost + 1 can be violated, which trips the WARN_ON_ONCE() there:

  WARNING: kernel/trace/ring_buffer.c:866 at ring_buffer_nr_dirty_pages

Since the old pages are gone, the buffer state after swapping in the
new pages is equivalent to a freshly allocated buffer. Replace the
manual head/tail/commit page assignment and the rb_head_page_activate()
call with rb_reset_cpu(), which performs the same page setup and also
resets all per-CPU accounting.

Verified on QEMU (x86_64, v7.4-rc2): enable sched_switch events,
partially consume trace_pipe, set buffer_subbuf_size_kb to 32, then
poll trace_pipe_raw with buffer_percent=50 while writing events. The
unpatched kernel triggers the WARN above, while the patched kernel
does not, and the per-CPU stats report a clean buffer after the order
change.

Fixes: 2808e31ec12e5 ("ring-buffer: Add interface for configuring trace sub buffer size")
Reported-by: syzbot+008851bf625629489e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=008851bf625629489e75
Link: https://lore.kernel.org/linux-trace-kernel/6af009ed.4dd4714a.f8d02.000d.GAE@google.com/
Signed-off-by: Shuai Liu <847807867@qq.com>
---
 kernel/trace/ring_buffer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b9..2726eb8cb3eeb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7548,10 +7548,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		list_del_init(&cpu_buffer->new_pages);
 		cpu_buffer->cnt++;
 
-		cpu_buffer->head_page
-			= list_entry(cpu_buffer->pages, struct buffer_page, list);
-		cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
-
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
@@ -7560,7 +7556,13 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
-		rb_head_page_activate(cpu_buffer);
+		/*
+		 * The installed pages are freshly allocated and empty.
+		 * Reset the stale accounting of the discarded pages,
+		 * which can otherwise trip the WARN_ON_ONCE() in
+		 * ring_buffer_nr_dirty_pages().
+		 */
+		rb_reset_cpu(cpu_buffer);
 
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0

