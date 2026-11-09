Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193626;
	b=q1oVfFy09jZvfezjS85BG12cB6YZPQWSyP63Pd7HYjXqzZWgBTbB49m4Cd6Vx8M6GVaS
	 Z6h7Y5a/7JbHaqF8jXGvrN6WgKlh6gvytvHlDGTk3Is0VcgoHa2QrNudWbF/I3JgKaF2N
	 YtD03mX2swSD1EtjqCSYdGKl7Tr+UQbupC+Uzw+ewOEHD2qAe2paIspgOWItN3U9mqWEp
	 L8a8fJPatmFt2Fsxx74nPKb4Xsa5pUbs6virSRfzicpDcB6vfhPYhJy1gadfF918gaXG9
	 CQuabABc7KTT3OuaUdzA8Herbqh1ertml+Bc/VhRy6d2qPxwOmE5z08pANgOfmbbxtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193626;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+8OE+2o4zmB6uQB07WmdFdMOzioI3XmtqUaFc1/X3bg=;
	b=An+sRMN7Vo3xG4drGRhJ3UwgDmew9s8fzAyZzBX/Qetmaudjw78FXlu7XoBeFKYiKxzz
	 ZYIqVj6g47++Lzz2hOmWH03ZIp/sMExeCRoqAzPb+uxesZXteX/QJqfQWsQ8KtgSsqiUR
	 KLrczQ66ez4GKSl0nx9HVy+jmiHzaXIUq/v5D91mzsN743NewcYGwlehapEQcd2R4KIEo
	 ipPYI7BpKNuGyj+SUGfWSaPckUERn+RLS/DTc1TfkI6QNB18xL5LGeP0oS0MsuKFuI1IY
	 WRHYrcomTlSsHkkajoOqNjTtjkMoREY101/H2bWlHC0aqdMeaX/vDrNAcPSQBgDqfKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="ZYQy/uga";
	arc=none smtp.remote-ip=203.205.221.233
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F94606A320;
	Mon,  9 Nov 2026 03:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZYQy/uga
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794193616; bh=+8OE+2o4zmB6uQB07WmdFdMOzioI3XmtqUaFc1/X3bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYQy/ugar9zJkI2NVO04qOfKc+liyAIrRUfr08VG3OxhrOuPiIgCBhuaaug1jWiLx
	 wmxWyeZyj4Tth1HcK9d4NiYYaKo66JLPClOlftNsXGhfc0VacWmrl12vrFJnUBk3yt
	 /vrlFAL0KFWOD4Dmubskb5lesOcWjeRnyOayGfJE=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 1B5B36AF; Mon, 09 Nov 2026 11:06:53 +0800
X-QQ-mid: xmsmtpt1794193613te2f741e9
Message-ID: <tencent_0A65695A966979B026705C7531C809277707@qq.com>
X-QQ-XMAILINFO: OQac6g2KrvnWS+DndPw3VOlFuGydcieW/MNt6Eefm8wjLa9JdBuIR4fq7U3wYZ
	 Q+fcwRvxSbYFFX8QkwhM0wtZWAHkcf5CdHJ2zTjG6mXZQKTVC8rm8kc6l3Zlhxm7HE4drsyttln1
	 GjfHJ+518s2feB2dVwkaLcbC2abXD34l00IPd/3OAntmnjmuw30RUbU5oBhE/Tn0lkbDPkTgssZV
	 kqB9SpmTBaHqCuK82d14dCy0CUGfNtb+2fspYQLf54XshU/DVAam3OLdcBxyePV7XsgKUsP9MuLv
	 Ji7S6t8oZFlqWjxCQQQOCmeUUO7PoGwbzZL/ZkRauDyNo5A0T3OkcCZbXfZq/PzaTn9LgP29oKsa
	 lL1SNx37FGvhUV43en5Mf0gjhhBnztQze6jeKN8kOEoRchsJ4YJB158HQDcB5HzSgNcnkMduRg+m
	 7flR8M74i9SsYBfxthMWS4qfVeSI0VnybtF4/OkYQtIXlTWEL2h1Oj7D9X6UJX20sm5jc+nD7Awv
	 Ev1punxzWBIEIZgw8l6jRdvg9TYu/NoCvXoldShhmL3ON1hEZWE75TVbDPeZ2uWW86O63GaW5Gru
	 pqlZzNGveHzbac+7wXyCTgnBUsF1Mtpbvj6l7urGfBVG/DusBxYNLv0htLOuCyFEomCRFp/FDxhO
	 D6FpF8yDYOZG6QluayL2As2MlF+3lMPMyZcCwKT0NbbemaTrc5tAE6nPrgeAweAhlUpBOvAjVNpf
	 1nK74vk4heuisbVQCDG2LA+58fdIPN4ZsU9d7YmtaGIwmc92CzkQyLvAHZYLAm0iuL6tgUZgnGNt
	 n6CThQBH8/b9W1xEBDgn4lhVpZpjjVI5RVpUygt1HozNN9p8yRtuCT43vfypAI60vKlYphLkxqHV
	 qPh5MZtXCoUt3Gew3RVRO09FvurZSnKVejvcjv+AEm4o4Wrg920bLMWSdUxyGEV9Zu3rSqLuNJci
	 hH9B8lYOX+Yc/hd8+LQoT1kq69dQeSJ4/dk6mslvEOZzFm+Bg+V5U32+GXcKO9dxBZCccSl0p3/X
	 XQZcNMHFhlsTQgFK/0yIcMhYPQO5EzRVYlVLQqsbion8iDKI0Q00cwXRu5kGmdNY/C51ZhYzncZ/
	 zRSWbZBCJpH4NoODs=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+008851bf625629489e75@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v2] ring-buffer: Reset per-CPU buffer state in ring_buffer_subbuf_order_set()
Date: Mon,  9 Nov 2026 11:06:53 +0800
X-OQ-MSGID: <20261109030653.159638-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-204360@kernel.org>
References: <sashiko-outbox-204360@kernel.org>
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

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Reported-by: syzbot+008851bf625629489e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=008851bf625629489e75
Link: https://lore.kernel.org/linux-trace-kernel/6af009ed.4dd4714a.f8d02.000d.GAE@google.com/
Signed-off-by: Shuai Liu <847807867@qq.com>
---

Changes in v2:
  - Fix the Fixes tag: the stale per-CPU accounting was introduced by
    8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing
    their allocation order"), not 2808e31ec12e5 which only added the
    interface stub (Sashiko)

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

