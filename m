Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3410FD;
	Thu, 20 Feb 2025 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021426; cv=none; b=uhPt5v6Zml4gq3t6WuTuy0HDuenTQgl1YFbjSQq+RjRIWLa51U2uHAd+byc6G73ZefYHOW/dR60dWvVPZA7i5f1gT8EiMKEwGLeFy+zDpUXCgAVuqdxMDN6AlPmUNhutTv9DLa5TLzg6ka83dUSV79xXiyECSCq0wCoGwxwMzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021426; c=relaxed/simple;
	bh=9NI2gIBXNK0s7n/ljiTbibviNS/2GH4hHP3zf9R4Wo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbWGOR7Yg0Yn/MwMPnQPptB3cIKpJzCZvsWxnAUtEifwfVgCuntrK1YSLKlID7jOr++I8D4wky73IZ/gjlEp40Shd51cSu4WYiXB3XFmkVYpMXJGiK7/4zFWkjz/gvHfITE5L3rsjTCJNr2pubFmkQddMCJ54NEduNv6l2p2qcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjTWTymR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjTWTymR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22113560c57so7765675ad.2;
        Wed, 19 Feb 2025 19:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740021425; x=1740626225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlnHXFPBKqev4q+6awl68HvHcTKpxS2Uwsz5JCoSit8=;
        b=BjTWTymRb1GDE2W+NuR4aGJval67ro+xppvB2VddeWEvytsUWybzId4xkHaOwWoMFe
         bhWxw5elCiA/Z2Dr1eMvJIzXLgmEZd9FygTML1Y61QWcliWb2/EJXNZULX/kKcMbK4v6
         Oj/G2JMf2Op1GJmpY9jMFrKasGV/V1P/+sf5ROwqRvTkou9ult+0D7I4mWSZG3Fq3lL/
         p85b5yY2oc/rU2XoKxv1F6YWK6lptSP8Ah0N7ltijEp7JtYo8eR3RBEMdQbWtW2G53ep
         DW3I53bszs+Faz2KZtbMcrW4nHS5YyUJNHvyfDVD4fR9o+BymG81FiCwiA6nq9t/bCus
         KV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740021425; x=1740626225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlnHXFPBKqev4q+6awl68HvHcTKpxS2Uwsz5JCoSit8=;
        b=oZISiPJpSPLrMIxhIfhB+Boz6HGwQaYb88VM7K01V9H2Q+orAaSXuCaPcl958X/XSl
         sVhM/z9wPZ/7x26/4BbIQGOnL25Gq9HcKppcVv1T7cwjN6E8T1/Il66EwpvmrfDXdTXx
         1dZpsxlcfZAJDBVdpUhtd8SgwAtWDYzXo16VFb5FuzN81uI7ahlXN8TI2OBGrnZ6DyaQ
         3u29HEBdUclAwn1HMvrFqUl1JxH/jQHf60/VLsDpYLpVWYDlT1ww2KZQ1jKLTQ1QjjNX
         lOopMMOT1AFpXu8jV/UMzHTUe2ZlIZeEHlKTEur+RzSFDkoro9Yg31qTFG/k5FR/4JZr
         bmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ewMxgyHXG8jvcLVFIjurzdtbgR2TNEI3UwK9w405cUzQsIz7/+fH2gRFbADnpAQKFt1jxMNePt7ihPc=@vger.kernel.org, AJvYcCWvfzdIxW7+J91DJ2qCwMpiJU4HyDd3VkROPCaANV/3x0LRO6ZOt4ST5vU1/0JuEFSPak1Uj27NGF/gHthPwf0DGgNt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0l9OPkc8f0pMINo/cdcybneqeqJoptX2++11dsdF+JcHm+HT
	1muWEDA02hSixwHFLf/NFopkgIaYYJxvclK08+P9qyimwZCSVrdhLE/IeqjF
X-Gm-Gg: ASbGncshxDZC0iJMm2YL2QXNPBSWknanfbzho8HqG3obzobY4PeeLb74p6ikgFe7psu
	C1rN9Ptd9/8IBKD2QsbXz3rAUJV2XAsZvQxpGaJuwIYwaSwXm+h+owP851jDl9wCm8DDWTOQqMu
	FT+EV+n3/wt70EupXClw82VEZTTBO0p1XnM35PSkvnAz+tD+j5aBpqYTBU7ruWchPaSP5Jr8cZP
	g7wTAkTFRZ55d7vQzMavKJ8sQEKldoYtifEROmsp/ob93H7nJhqLGsthG6j7by3IvZPFXPmoS45
	Zm1zrIO6YnZAuTQL+qfz0h5X3g5Lgh9+jBx+FQ3YO6Im4h+rVEPAL/5lmC5+BP31E3N/Xu4=
X-Google-Smtp-Source: AGHT+IF8YyAOUY9WFATxdYRRmi23UUSUFNHSvUKci7PiPXmGIYN05r2gp0Sz65gUYsf6PONsVp4r4g==
X-Received: by 2002:a17:902:ce0d:b0:215:a179:14ca with SMTP id d9443c01a7336-22103ef5861mr318261255ad.2.1740021424652;
        Wed, 19 Feb 2025 19:17:04 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (1-175-143-196.dynamic-ip.hinet.net. [1.175.143.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm79936015ad.216.2025.02.19.19.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:17:04 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] tracing: Fix memory leak when reading set_event file
Date: Thu, 20 Feb 2025 11:15:28 +0800
Message-Id: <20250220031528.7373-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

kmemleak reports the following memory leak after reading set_event file:

  # cat /sys/kernel/tracing/set_event

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xff110001234449e0 (size 16):
  comm "cat", pid 13645, jiffies 4294981880
  hex dump (first 16 bytes):
    01 00 00 00 00 00 00 00 a8 71 e7 84 ff ff ff ff  .........q......
  backtrace (crc c43abbc):
    __kmalloc_cache_noprof+0x3ca/0x4b0
    s_start+0x72/0x2d0
    seq_read_iter+0x265/0x1080
    seq_read+0x2c9/0x420
    vfs_read+0x166/0xc30
    ksys_read+0xf4/0x1d0
    do_syscall_64+0x79/0x150
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue can be reproduced regardless of whether set_event is empty or
not. Here is an example about the valid content of set_event.

  # cat /sys/kernel/tracing/set_event
  sched:sched_process_fork
  sched:sched_switch
  sched:sched_wakeup
  *:*:mod:trace_events_sample

The root cause is that s_next() returns NULL when nothing is found.
This results in s_stop() attempting to free a NULL pointer because its
parameter is NULL.

Fix the issue by freeing the memory appropriately when s_next() fails
to find anything.

Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
Changelog v2:
 - Per Steven's suggestion: Add a comment to describe why to free memory
   in s_next().
 - Per Steven's suggestion: Change the variable 'p' to 'v' in s_stop()

---
 kernel/trace/trace_events.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4cb275316e51..513de9ceb80e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1591,6 +1591,13 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
 		return iter;
 #endif
 
+	/*
+	 * The iter is allocated in s_start() and passed via the 'v'
+	 * parameter. To stop the iterator, NULL must be returned. But
+	 * the return value is what the 'v' parameter in s_stop() receives
+	 * and frees. Free iter here as it will no longer be used.
+	 */
+	kfree(iter);
 	return NULL;
 }
 
@@ -1667,9 +1674,9 @@ static int s_show(struct seq_file *m, void *v)
 }
 #endif
 
-static void s_stop(struct seq_file *m, void *p)
+static void s_stop(struct seq_file *m, void *v)
 {
-	kfree(p);
+	kfree(v);
 	t_stop(m, NULL);
 }
 
-- 
2.34.1

