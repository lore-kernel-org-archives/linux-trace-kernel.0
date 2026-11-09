Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215558;
	b=IaHfs6G/bJdqfBw75pW6Me9PFNDmRi9A6yiea0TlIVKeaUcUpxtoCeXLkrzaJlVjzZli
	 krBsMXdSGydJulT1WTAQ9BcTKm40qr6sy5QRtnle3PcJTv7DGlf1CTHyanxcIztffK4d8
	 hrxxO681swEw7FEMvEgcvpuX31KyBpQvH+2wBs6vogH0edsrrP8Ch+2KlFyyCZDG71wz6
	 2QTQWjJXbLyc6XmvBu1k655t6yzJ0rF2OPD9445SVe4I+Cr0/gRXEQiHK0UxsGgE6hk+O
	 d4FsrWU+8H83RNBFy/DWK39LYTP+KKRM5CaP7a7yjUAlWNLolITJ3kSFNUcQQniSJ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215558;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SCvXMsDg9UNfRJ3IbJ5geqOMg/Tb5+bzgdLYDGqXhJs=;
	b=arC1f+fwAPScyBMGiuWFrkvC9ZQ40vKDhzul3I4l6+rmzQwtTQnrMs+3hIU4Qk6Vozpy
	 tOeZX28myLmnJtEYwAHii7Z+4nnCyCeCTW2xlg9byoLr5FAIR3K3cAsgqnLuygYQ86q5M
	 8XXmGanGZgz1Fi+jQw+63f0xvgqhQeqnMoAJEV8lr3VzD41zgZHBeyjL4cLp99YCifI4A
	 S7IrKn8mq6DfEXkYACJx8hX/Kc6hqJicJYoS4+Zf5H6jbNk9zuFLOvVQBDFsuy6bgqR/i
	 t9xIiAkKs4Zi/LbDKpZIGgmCaFknIEPfG0UM/lS3+hDPmk1nScFmkAmBdvNKXQuO69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HMrqFvMC;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4772606A31C;
	Mon,  9 Nov 2026 09:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4772606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HMrqFvMC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794215545; bh=SCvXMsDg9UNfRJ3IbJ5geqOMg/Tb5+bzgdLYDGqXhJs=;
	h=From:To:Cc:Subject:Date;
	b=HMrqFvMCyfbTLWoLONUHM06pYJ6Ht0ao05S7tOGdLUEvANGuguh1+Hr0+OMfTLlgY
	 QsiLUYKBnw7WrMovxwgkYapyVhuUtcrgDLsy6dZPUPU63F+aSm5eWQiULHonHBiBey
	 bn5CPW/V1N0Vwq0B8o1RB6Lgs2rowazEorosxOl8=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3168D8C7; Mon, 09 Nov 2026 17:12:22 +0800
X-QQ-mid: xmsmtpt1794215542tlhkaodfi
Message-ID: <tencent_CEA7FC52933C6E9D98CB44A9FBB9F40D0B06@qq.com>
X-QQ-XMAILINFO: OV1Zg0ZxpCRs8rM4l+kYyWhdHPfks5H0Hipq15lPHJX6KmBtpp4q+AnL0DkFW8
	 YWnOJFG/xR5n4tSk+35y8OvtnpxCsko1Cdo4jdtQ8PPLo83BPX+4ZE/2fooqUsRHkusl2cD8s90y
	 2abk0/fWa1k8X4V1xZsxvu17vFs71kfrVMKLupBuyFHPG/BJ6k17Dy+hbo1uiCF2uMhB4pQ1PlXv
	 xUFG1d6rxc+LhXipyqdNiOGXoYWE89zKbMtYjtFDlCucOwBOxU85+S8JkDB3lAOqXTWGOolEI3Jw
	 X5MFGJz33nKs4RwZkm3NMoa+i27eRuphnwChbenhzr+m/xQwZwoJcvEL1Hydxr+lrfbZAf+fag6p
	 fOD3LKXmsjPIHvlWJqy5wUm9We8ewbSPKWPDEV3hiDX6dEqh9msrANy0wS0P85Bv/Qnsuo3N4iNs
	 ptNWWptMpKb0ENrOjKoMIutmlid4Y5UaNX0ey0jJGyXPACpMCTEFJMmHFOVMgaLLuO2DXpRRLSO6
	 ihpgpz11vemONuUlnvvtectaNKXHFQW3da4mMMqIBKGQfgd4izHIKuLtwx8Mnan3UenFtnHuhlWp
	 f4A4i08nLUFhvAThQGa06SXba7WvpHWmKUPLP3wU0C9jLQqzGJ6ZidNOZdH1KcP02MxGKvsKtcoa
	 hH6/sCxyh6CAwpptnm8W+RMGK4fTHV0L4/hHHFikyMPGm/5LmG/dlKe1gJ+Jvx2tLs0+q/t55403
	 7pKS8Ub4pZHo5YjCw3srXb5ao3YiaNu/6AbQbWnVjrqw9tZ6u4Opil/eMnfwzf7Has16aZNoEdcJ
	 bs8jXxb+ojo3ngc+Yt7GWqxzaYHAn2rBHNWarjx5cGcdDvpVU2IKQu3GfRSmUTOs2bz06asu1UAz
	 HSU6fki0YfdrrWTw06FWIqh1aj971iEg/LD6a9W6jb8qj9B//Yhzxke2kGQQ7MLOzf/11Zz0s1zC
	 vz77WLtKEw00OGErm94ZjGbZmFO+fKFKRuAEFzs7LIIeaGzIraJ3WSfC+NFS/7iIEpYdzN1lTB5G
	 0gxGpk3e13ABYCekn9B+e9n1XWaB78spJ49ecI22emGptIWhE3Xncq81J+yFnaMpVIVqfHLKoLGb
	 DF7DQ1w/0x3ujevGF8kuHvLD7SpH9SMdNHC/2w5zI4O0xvoZKAF6CJ6dcxYTna+3YBLS8P
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
Subject: [PATCH v3] ring-buffer: Reset per-CPU buffer state in ring_buffer_subbuf_order_set()
Date: Mon,  9 Nov 2026 17:12:22 +0800
X-OQ-MSGID: <20261109091222.266391-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
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
    8e7b58c27b3c, not 2808e31ec12e5 which only added the interface stub
    (Sashiko)

Changes in v3:
  - Drop unnecessary comment above rb_reset_cpu() (Vincent Donnefort)

 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b9..4437b8b926c11 100644
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
 
@@ -7560,7 +7556,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
-		rb_head_page_activate(cpu_buffer);
+		rb_reset_cpu(cpu_buffer);
 
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0

