Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C611BC57;
	Thu,  4 Jul 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111564; cv=none; b=rzvFE0d27LYCPhrmNEPoC4RPOkckSUfJh9lXk6Gbg5Ih42ybzAj+QIzADvE35I8cBgIcmv7CBzD5bOg0VydkNXYr/nlgsakxbgHHtNcFSCS6WUrEssKPIjZIGr5RccqdlJktt8lkRy3e1THKhZ9z3KunEu0hlVpz33Kbv9c7sL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111564; c=relaxed/simple;
	bh=qDJHiMza4kMB26AZbmpwgiW27bTdimD6C6D0lx7cggc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOOpTVdEESFRMnrySfxePdzpc2cmjiRFYN5ljTVN72rjFC2CwADDene2Vkzy0AA/zMRo0dqaD8ONdoHcW9ohrpTWwHg/T/p5pTmyVHhq9kXtNgYSaGIQP14LMV/5T3vPCwUVuGhxB6yOu60bCcqWMGzjU+99omczeNDVuz6cm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=H6gpPCxs; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="H6gpPCxs"
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:70c6:0:640:97e8:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E7EFD60A69;
	Thu,  4 Jul 2024 19:44:30 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b642::1:38])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id PibgQC0PkuQ0-5gjVnlmA;
	Thu, 04 Jul 2024 19:44:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1720111470;
	bh=Ze3Pe2Z+VMgwAD4BxMVGBEkiIJQR5BwfjJWnEIH7bxU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=H6gpPCxsnVlSkeDDY8MIflDORlj/I8k16PEkklx2tZImo4f9W7kmqVxZM9AGmz3dm
	 cO0EK2+KLL//4EUaKjkwCVCjmV91Xhu+qO5DX37CijsdEeUYb2JMPII89AMOq7+uYV
	 kAvlQbv2hftt3TBx7HN4BjodwjdHgDfZ/sPlV2tE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH] tracing/kprobes: Add missing check for skipping symbol counting logic
Date: Thu,  4 Jul 2024 19:43:36 +0300
Message-Id: <20240704164336.1176281-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b022f0c7e404
("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
it was already done for symbol in __trace_kprobe_create(), but func in
create_local_trace_kprobe() is also valid usage.
Not doing so leads to ENOENT for module_name:symbol_name
constructions passed over perf_event_open().

Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 16383247bdbf..3f4c9195dc0d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1834,7 +1834,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
-	if (func) {
+	if (func && !strchr(func, ':')) {
 		unsigned int count;
 
 		count = number_of_same_symbols(func);
-- 
2.34.1

