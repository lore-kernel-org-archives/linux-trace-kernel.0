Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3FF84039;
	Mon, 21 Apr 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249342; cv=none; b=p/RhNf+y6X4we9RthDdfQWcVZLg8sI5gjb1aFROc5VdYu3mkqfX3pZcjQX2SOHBW7d1zwCov6J9kK4KAIU0/O/D1mXfvykWIce5mL9DTJnowctBhVzKoODepnVp7KmEkKpq3JnJcaL1/WN1lRxpobEtK9LoIM3Afs26Y6/MlvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249342; c=relaxed/simple;
	bh=gWmOBPOo2zueNcEpa7UJqglLUyLsvM7ZIkr/HpJr9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAnz1CiEuUEsruqltRO1PBrTFqc3K1qrAOnNhBQWUFHKW33sArNld3Og8zVweDhLON/lqvUXTLs/cKD3v1GSWUjAeOB5aoEI4vIhWXLsHo4u1einxuuxdzHcnO9Zd3OAbf7DsQMwFYrz5eQhOAteZ/mhYDL8m2BGv+PThdwrOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlGAxv0f; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlGAxv0f"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af9a6b3da82so2644493a12.0;
        Mon, 21 Apr 2025 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745249340; x=1745854140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM5dYyAOgy8S+RMhi1rxHsnZsFnWYYsEB+eaQt70TTE=;
        b=QlGAxv0fsQ7O/hheFXW+PjmME9DyfBheVMM1iH+PMG0rpDY93DFkindiWJtiqIZ5cY
         5zLQr9qWUVk66VxlkhKX6EtrugYf44UJ/IzMEsUmkQTjEmf3+hEvwJdeB1y2z0Qaf0qS
         TLOt4rDwQuQKyhZkYaa4QLZ4Erwv/YY5/3V7Y1pLvNZpenSWr3DO6eJu6dlqdGU15yPb
         aY/XZzlLk92NrC5VsELb0OdIwERYwfQLzOycg7crkdF3sKwylJZProgUvCRqPg+mon2C
         iQt7U8kEd/V2Dh4JoeSNQJRa4FknGqiOiVt0PMMHD+tGhZte/Sx748owygeot78z/yYd
         jfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745249340; x=1745854140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM5dYyAOgy8S+RMhi1rxHsnZsFnWYYsEB+eaQt70TTE=;
        b=QQlCg1UGhIZFQ8RcqzqcfWRZ8GKhL55niFxctNwylCqXX6rPKqBqAz38kLuzmIoC4K
         JmdlW5fCNubKuO5LlQxgzY4xs7lYvktToNGvgmMshBxwJdbTW11q5FX8ecn94hmV/2fX
         MBAL8sBz7FmCIvUGShHH5fIvzL7oIND+iZFL62HRUvJIVq0L2ccXxBRH4H2qBJcw2w+2
         BIo3wSpjlic7pXxl3kdqt4gGewcxCjEZ+gGy/aAdWp90u9QbH2XtMdXc0Rj5gmSE0PAB
         QJPLjKBqQxcfe50UbA0091e3LV7uxcUxlab5HxIZTAeoxPDiFPe/uOEIXDdovhn8NUZu
         UONw==
X-Forwarded-Encrypted: i=1; AJvYcCUCyApUC2QGiV9TCDHbG8k4B3XYNFh9+0l8dq8MyDcbflNA9LfGkKJTIkG1qmNv4k7SdxEKWtCfK0oJtypf3cilxmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeY1b/Nlq3wIpxV+7h1ywk+GEJQawBR9FzWJqFTb1/+PKyDo3
	QufsooFbdQWTGCEW+SqMgdI77V+yKqevNVhv3ARGucD2pEYNvEZK
X-Gm-Gg: ASbGncsjQ5Hz4BztNWhjUE9amwZsyiGk3j25ZcXvZUxw0us1ObTfaEFuRxYMo9RUHcy
	7pmrUg/8owGkdxKS3phkp4Q2WB7wN8vNgv5Iqdr5vS9gdWg0iCxUjFfqxPrLrASJPKF2IexQjiL
	d9fAVciEB5hZy/vn6aQ23Zbb96F4pkrMEyx+B7P62QL0XpxBxLyaPx5mhTVFscMdFsbJXt2UX45
	gHiSuhMDSqVO6tSc9CZwfcUB8ePBteNhVkHXWlgXt3ftDtahJt85h6PQEkdmBza4+Ol8AKof1OQ
	DxAiEU1wTFkVqvEjnpglb/vODawM6B8H5Ei4pIA+Z2RiTJ8ot3msDvgWKvZeaFrbUGN7kA==
X-Google-Smtp-Source: AGHT+IHmGByiCe2LYq52FgEznw/4tloudmob39dwhDNKp7veB9JX0OiLb04HpEEfdP3ND5Q3TdKq9Q==
X-Received: by 2002:a17:90b:574e:b0:2ff:6e72:b8e2 with SMTP id 98e67ed59e1d1-3087bbc936cmr15724905a91.31.1745249339795;
        Mon, 21 Apr 2025 08:28:59 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e04a94bsm7640379a91.40.2025.04.21.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:28:59 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] tracing: fix oob write in trace_seq_to_buffer()
Date: Tue, 22 Apr 2025 00:28:50 +0900
Message-ID: <20250421152850.15387-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported this bug:
==================================================================
BUG: KASAN: slab-out-of-bounds in trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
BUG: KASAN: slab-out-of-bounds in tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
Write of size 4507 at addr ffff888032b6b000 by task syz.2.320/7260

CPU: 1 UID: 0 PID: 7260 Comm: syz.2.320 Not tainted 6.15.0-rc1-syzkaller-00301-g3bde70a2c827 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
 tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
 ....
==================================================================

It has been reported that trace_seq_to_buffer() tries to copy more data
than PAGE_SIZE to buf. Therefore, to prevent this, we should use the
smaller of trace_seq_used(&iter->seq) and PAGE_SIZE as an argument.

Reported-by: syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com
Fixes: 3c56819b14b0 ("tracing: splice support for tracing_pipe")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Corrected the correct location as suggested by the maintainer
---
 kernel/trace/trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..170c31da61e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6784,7 +6784,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	};
 	ssize_t ret;
 	size_t rem;
-	unsigned int i;
+	unsigned int i, copy_len;
 
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
@@ -6818,16 +6818,18 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 
 		rem = tracing_fill_pipe_page(rem, iter);
 
+		copy_len = trace_seq_used(&iter->seq);
+
 		/* Copy the data into the page, so we can start over. */
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
-					  trace_seq_used(&iter->seq));
+					  min(copy_len, PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
 		}
 		spd.partial[i].offset = 0;
-		spd.partial[i].len = trace_seq_used(&iter->seq);
+		spd.partial[i].len = min(copy_len, PAGE_SIZE);
 
 		trace_seq_init(&iter->seq);
 	}
--
