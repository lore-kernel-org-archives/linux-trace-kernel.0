Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778914286;
	Tue, 22 Apr 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321436; cv=none; b=AVvA05IA5HMjhOD+cw2KkCTRHtDMXSfMq5bBLCFVyMn5PgJA6Tp0N3Xr+we0/nQ2Z0t+TwYUhqO4D35NV/40uvB9I87lHsqG/ItGgKmbXxSqMqvR7Wb3Oeht/TngR/crTBu1iFD2lh6tOi0AztUPEoFycvNWjkLr9YouUFQAdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321436; c=relaxed/simple;
	bh=tHyGqFgFIRSmPIdYIXX9Tdm26dq4AIs524gvT44qx0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pu4xfbKR+ArDFf+X7sUPCKj8XLZi0VB4EwnVmqIAtHnrgtmne4jWKnRZS7XBEH5e8kGdwHzXC1DHv52hUbap2ELpoRdrOAHMVE+ZwfWhfZIVzv1VGcBFhFK1TC9sktXVdjENExpZ/r1yurxgAs3hN/i1k/gTw1nI/yKC3J0ZVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx+vgboN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx+vgboN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-aee773df955so4781603a12.1;
        Tue, 22 Apr 2025 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745321433; x=1745926233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+L2qPkaVtKmg+5Sr07ERpwO0sC7ZPDgfr98i4bh2UU8=;
        b=Qx+vgboNAcPYOChoqttavAkxPur+lDuwv4j0iKFhMI//AFXY15H97gcFQgTqQFGX3E
         aubZAyvei2N0DnIVLAjcFklrmUVPznojb8npWOhSgr9rwokqM1am/sTB3fpYrQYP/0n1
         uJRiu0enwdfQgErM/Pri8sRv+iE2BJNFA4rlS4ogVG4V1JeTuERf+CyHp5xL9jsnVHvu
         sRloNlla4jt85D/PT7QoMvmB1YDmnlCgP8YjtcsuKEMxRi61wwIL6CkrCaMLpkukxKa1
         aUdFNIxDoAjSjLb9IWlo31azYluxKbTsYs9fxAvLFc2QJ3l2g7grzA9P+2xURb3lQzBA
         9NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321433; x=1745926233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L2qPkaVtKmg+5Sr07ERpwO0sC7ZPDgfr98i4bh2UU8=;
        b=SkrMMseHX3DHnt2hAdxJqD4ejErFcXrt3LSSLYhs3VWMKPrP7L0/6Tqor6WJAQRfpS
         015gyaXJOSDHpV69vrUhEnWjNlPCNfFwbz3+HcWy1CP5+/0F5AJSgs9fsHWlLnGOXZff
         n4Ds0lqZOk7Y0ac794LGF6GF+uMtfXKMQjGIVTA7B4iEUEjLDiL4Zf3Folm2C/9eSKky
         WgkXRe0cxVIfU9hnrdZuOdx0vPqVTRPZ0p7j1LrZXjUD7RhUSRfknjr1OeeP2klw6h5j
         8F1ztLwkXZu3vwh+xeAECPwSS6yGa/4dUpcITDbZ+ke2JBnYmIj3AVLLIYVN0b8Vaxju
         taBw==
X-Forwarded-Encrypted: i=1; AJvYcCUF8CnVoMDXGAqLepoBwLR0kdawkL70Nz+zU/A99OGtuZvIjoR+vgtg/fE0X5KcQaWvmshRh2S08MwPfkuMP1H3U64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BSptkbPg4qUFyWXYRTBW+XrwoSGvUeW0lBMTuSFnaQsSFF7R
	hYGPsmpd3AeeECX2dHVLAbKqV8amEPKKSMod1fObPpUFx3GFgFk+5i4QHqHB
X-Gm-Gg: ASbGncsKHf4KETkMKA30841Mhklej/2aFL3of+NS0KQGoCQVm4LOsVVXxsjz3FF2nT0
	+f6oYRq5B6WrpyjNAiO9xQyWW4JvY0f0MCnbUvKxXsAO6HsXxqDuBqH6a7D7G4J4+5fq4DuRVwk
	U+tpbNF2vURhPAZOfJ7M0NXOhgquryvcYFNMLd7nHWVR6XFu4k0ZK4Ktu9xPiAx6eOpv3C4rOTR
	HUuIMS4lkV7XsYV+0ho/SQFF1/YbVkowgXF8b4l3MYQhbXQxOa6Tq1ikSE5kGDf+caJdnGvzDyT
	WZJOwPmxktIfHR80VoBJ3kMX64YqdT0pUKgEM2XBAAqaS5cs98X+aNaDYFlf3BUkj1aZ8A==
X-Google-Smtp-Source: AGHT+IGhW6YCQNNrILjH/FlTivBOfED1cUX+pwJTIME5x5vp4B6s23wwgnLKbICIDgnbOZxB3O2Xjw==
X-Received: by 2002:a17:903:2a8f:b0:216:271d:e06c with SMTP id d9443c01a7336-22c53e19dcdmr192531395ad.4.1745321433177;
        Tue, 22 Apr 2025 04:30:33 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdd0a8sm82506825ad.50.2025.04.22.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:30:32 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] tracing: fix oob write in trace_seq_to_buffer()
Date: Tue, 22 Apr 2025 20:30:25 +0900
Message-ID: <20250422113026.13308-1-aha310510@gmail.com>
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
v3: Change coding style
---
 kernel/trace/trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..6d52dc108f00 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6821,13 +6821,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		/* Copy the data into the page, so we can start over. */
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
-					  trace_seq_used(&iter->seq));
+					  min((size_t)trace_seq_used(&iter->seq),
+						  PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
 		}
 		spd.partial[i].offset = 0;
-		spd.partial[i].len = trace_seq_used(&iter->seq);
+		spd.partial[i].len = ret;
 
 		trace_seq_init(&iter->seq);
 	}
--
