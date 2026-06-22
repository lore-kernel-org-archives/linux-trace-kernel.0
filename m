Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756039C621
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121838; cv=none; b=ALUTQTmTppuofl0A+qXkWlK7224kxYMeoeTDRZEUEIhcK5ZcEljT7oZqndYm4nvcTGq9ssmGKirooRoO9AvMlMCILyQk0i0yAlwFcngkZrQfxSlm9R2OEQNRBgkKxexMx3xqdzzdjlID00c85ehQMBpjibNznYQlSDV6skP+ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121838; c=relaxed/simple;
	bh=LcXFBjy0Musq3rs9odypp8XIbScOuRnpbQGZpnLXeYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iX5O+RZsHvKOlQMug5QfUYAKuZQFSbsucLB5NOyHjCzCDZDaYzJgxwjaLDiT1hJynEneADKBpc4VDvZycNYdrZP0mpzcMLeTg/nc18hmMk1045rScKk5JrMBto6wY+T6VDrYjXdAhnhZJ6ObLljrcUamPG+1AQhav7nrhE8pBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqRwRKql; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqRwRKql"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso3627116a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782121837; x=1782726637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htWvtKaxua89M7k0hTBaygLPKjJzXT76M5Ou0Pu7mmM=;
        b=fqRwRKqlggMNIlAU9JzxhpkDirMtuWxLMKbSwfcFUIb80suyJ/nyFJ3i5f+S9V+9Ok
         79q5LfFap707ctQ0+4o8XTzuUTaQHTCcel/0UwnfMtjBsrHXak/8g648Vi5DVT3az4L3
         VjaCpJY2eCLcF3wn3RL6bmpXTi6J+zdzBnXadtTFMwIzJbyNQyx6IWsY9UnbgI3/p15A
         URKQa23MGy/QuqNN7nxVEuqjMMcjnQzjzez4lAxWfYgMrjefCnFgBds1iP1mllPYLOBB
         AUWhrq7PKYqqkFDSMUliytInLkDyhaBipaOEtOO6tomsmOQRiTctLRbdXJBBEhK6LcmC
         KFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782121837; x=1782726637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htWvtKaxua89M7k0hTBaygLPKjJzXT76M5Ou0Pu7mmM=;
        b=Ku78IPbSgtUePHR8pIznYFoPoiis9T/JSPIhF3MEURR93DOjzQy3reaO9TGswzuuGv
         13Ibse3+v3GA9czpvrDpoOW/IHL5fixiShHRoCcQqGqm/5XEhYUGhei6mGyBqCUHNmCh
         JRpemuYKPFpTtKdjcrNaQBouJ64oOWeXLOevWtX8/GFranYTZm5jHKHVZb5P41jZai37
         5+vcU0uXiaEZOas2brMVodVhzEFTRCQbmmUOT4tJgE3sFC7Nd3xO8yxTy50gUdBdTkDd
         Tg6zsatxGG4aQdbqjK6AUHqqPPL8QUj/20EnDPgxV12VE7IdONi02LyoxDR0wjSOuC9u
         N2fg==
X-Forwarded-Encrypted: i=1; AHgh+RppifDw04HI2avIWaQxuEbKC4k9zGxBcA7/dd9EsKa0IPKGfGTqBl4PC85WfTXO9TOQI794UuFsbiqhirwb1VhMlvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1kE2ZaLFCAWLunkBXndBmPVzw/9hkeeswnCmaF/LEgR7+UCf
	TH4FqDOFIFNfRzkOXrzwW82C/qCQlOrOFHffyL39nKmMxbMIgcAJ7Jfd
X-Gm-Gg: AfdE7cnn0JH03S/n55rJIZbirk8QBgpSYFKiQaVGCS5ZHOGT5oazBnp6HF0Mhkc1xqC
	WHAJNYdLO0dw3X1j2ZXE5jDs/1jznr6vGf38JuRfZVg/PiNHRwBdbcCmqws/pftELyCh4ZHylW5
	DX69s8HXKzTNYKWmTpY4EeIKFdZaW93uWRQK+plRKv0Evz7rbAtp4x/M8fxg3Th8QM7HV8y/fvL
	DQMSTbiRkZ/t+PwfnqK45ZmiNRy1ugSqPUJOzui69wcaZA7GHqakp0E84bsWgCyYO4n4UXVuEay
	lkvM3lBqBWaPYvpddWJsgsnFP0tEmMXlyvp8WHqLaoarBLoYfM9pgaCvlzt/X47JCp/VpdhObtQ
	fU6qw2mpdeZPK2W7mz25nIEkl27HTEOZdydOJJQ+729thGBrXKCJV+GE1vXjHd1gexHFaUoOGnA
	oNTXVQJ2w592xVzVHzs6Ovm2TmoLs=
X-Received: by 2002:a17:90b:1806:b0:36b:8873:d96d with SMTP id 98e67ed59e1d1-37d1e86f26bmr12687817a91.11.1782121836852;
        Mon, 22 Jun 2026 02:50:36 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:d9:863a:ce08:349e:af46:efee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4eede23esm6512438a91.2.2026.06.22.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:50:36 -0700 (PDT)
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	woradorn.laon@gmail.com
Subject: [PATCH v2] tracing: Use seq_buf for string concatenation
Date: Mon, 22 Jun 2026 16:46:23 +0700
Message-ID: <20260622094623.18469-1-woradorn.laon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the strlcat API[1],
replace the string concatenation logic with a struct seq_buf,
which tracks the current position and the remaining space internally.

Use seq_buf_str() to NUL-terminate before passing to early_enable_events().

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
---
v1 -> v2: Fixed WARN_ON when booting with empty trace_event.

v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com

 kernel/trace/trace_events.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..1be62a46e49a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/seq_buf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -4500,14 +4501,20 @@ static void __add_event_to_tracers(struct trace_event_call *call)
 extern struct trace_event_call *__start_ftrace_events[];
 extern struct trace_event_call *__stop_ftrace_events[];
 
-static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
+static struct seq_buf bootup_event_buf __initdata = {
+	.buffer = (char[COMMAND_LINE_SIZE]) {},
+	.size = COMMAND_LINE_SIZE,
+};
 
 static __init int setup_trace_event(char *str)
 {
-	if (bootup_event_buf[0] != '\0')
-		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+	if (seq_buf_used(&bootup_event_buf) > 0)
+		seq_buf_puts(&bootup_event_buf, ",");
+
+	seq_buf_puts(&bootup_event_buf, str);
 
-	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	if (seq_buf_has_overflowed(&bootup_event_buf))
+		return -ENOMEM;
 
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
@@ -4766,7 +4773,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, bootup_event_buf, false);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), false);
 
 	trace_printk_start_comm();
 
@@ -4794,7 +4801,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, bootup_event_buf, true);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_buf), true);
 
 	return 0;
 }
-- 
2.43.0

