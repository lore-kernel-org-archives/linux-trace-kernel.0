Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7C4582E6;
	Tue, 11 Aug 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470025; cv=none; b=RKJonlWV4eAMqwiobIOOhvOMcEwKtYYmeK8QJq81mi7RU/FqQC+cX5Tp5dZFdtIrjeDT2lxiw9mA/UmIQF4kevtxEu09CT2O3SpglKz7GIWpWX5kHVh27Fy1Z3DpnajlNQJcIuQ8R4G7Wq77wta4pf3EH0Lox9fli1EmkcryQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470025; c=relaxed/simple;
	bh=5WO1d69FUa/JO3hmz0uwkwITlSpYbLB+TK1BGNUtqcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slLUtyju8xz1P5OcjoIICKJt3wsH34scQJGm1pjBiLGGVNF25lMr2E92me6eaDWeoLpXWoVRrzU0o0xgeWI24ToG+l2tluAVLFDff3EZ8tel1swn9wxAj7c/vGmDM1NySbIdmxs6uORrQWVw172Om2a8mYQKz1DHpBbSsSTOpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P25BfwFT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P25BfwFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R6
	SJqoxOBx0meZ+pNh3LMKWPU8/oQ13VLYSFfyvC7dk=; b=P25BfwFTUm5cqVWJyG
	U+SZtzqODPXHNtyyRML7javq+OY1SQQKk98KTVUF94wqQ0ByrKs0qibcsjR/w+Bj
	UP4TWCB1Mx8rF7+YX9lTLAtrIsyUpqhgdDK5XEPu8fU0rDt9EVY1QiwchDwuSc+O
	rm15l434I/uOcPHlNPSLij6xQ=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXHfxUXntq2w9bKw--.23021S2;
	Wed, 12 Aug 2026 01:39:33 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Hui Su <sh_def@163.com>
Subject: [PATCH] tracing: Fix NULL pointer dereference in module event cache removal
Date: Wed, 12 Aug 2026 01:39:03 +0800
Message-ID: <20260811173902.1927376-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com>
References: <6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXHfxUXntq2w9bKw--.23021S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyDArWxWFy5uFWUur4Durg_yoW5Jr4fpr
	Z5GrZxKr4vqF1aqFs29Fy8Xa48G3s3JF9rtwnrGw43ZF98Ar1jqF4IqFy5uFyYyr45Kay2
	ka1YvrW7KryUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEkucZUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhcmhWp7XlcDVQAA34

A module-only event filter such as ":mod:foo" is cached with a NULL
event_mod->match when foo has not been loaded. If a later write tries to
remove a specific match from the same module, remove_cache_mod() passes
the NULL cached match to strcmp(), causing a NULL pointer dereference.

The issue can be reproduced from userspace by keeping one set_event file
descriptor open across both writes:

  mount -t tracefs tracefs /sys/kernel/tracing
  exec 3>/sys/kernel/tracing/set_event
  printf ':mod:trace_events_kunit_missing\n' >&3
  printf '!foo_bar:mod:trace_events_kunit_missing\n' >&3

The descriptor must remain open because reopening set_event with O_TRUNC
calls ftrace_clear_events() and removes the cached module filter before
the second write.

The crash was reproduced on x86_64 QEMU while KUnit workers contended on
the event tracing path:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
   __ftrace_set_clr_event_nolock+0x373/0x4a0
   ftrace_set_clr_event+0xf0/0x180
   ftrace_event_write+0xdf/0x110
   vfs_write+0xf6/0x440
   ksys_write+0x68/0xe0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Check event_mod->match before comparing it, consistent with the existing
NULL checks for the cached system and event fields. The mismatched removal
continues to return -EINVAL; a broad cached module filter is removed with
"!:mod:<module>".

Fixes: b355247df104 ("tracing: Cache \":mod:\" events for modules not loaded yet")
Reported-by: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com/
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c01b10b99f67..032f741ba616 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -945,7 +945,7 @@ static int remove_cache_mod(struct trace_array *tr, const char *mod,
 		if (strcmp(event_mod->module, mod) != 0)
 			continue;
 
-		if (match && strcmp(event_mod->match, match) != 0)
+		if (match && (!event_mod->match || strcmp(event_mod->match, match) != 0))
 			continue;
 
 		if (system &&
-- 
2.54.0

