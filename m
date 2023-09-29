Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640D4F124
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:14:31 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689F10C9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:14:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32337a39009so1257466f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695996839; x=1696601639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oAyXAB8Kt0enGgPoo66x41kbTf1AFVvqj5ECchyAUM=;
        b=aSMTqIrFhTn3HiOITEseOFuCDAONUERX6t6TWwOkq756TUc+lGPv+3nICCbvU2nw+f
         OFPGdCOLa2uzlCH7t4Lqf3leqQrUDQfuJsJFBJs5sHGoFULKiJZq3VXxESagRtaShtIO
         bJapw0oJ/a/z1bk3HWQG7YsbJgQjZ/gM/t3iSkXcCCam4TS2OskTN0Oz9mpGvSGnDo0P
         nXyEq7gqsRDBFNRpSWw9oWkbxKnzOigzbETaMNWKnhG/GgWcpBT9SNZnmO/XvbWhv1N4
         xYchjpm8F3QzbqlXYMYnbHPTLNbbCWqpixoT8AYhRUX4HLcBi7CmCnWw+OXybjh1e3pm
         lKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996839; x=1696601639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oAyXAB8Kt0enGgPoo66x41kbTf1AFVvqj5ECchyAUM=;
        b=IlDQT9Vcc4Vi7G7uqB+nS+Gz+TX6v7BJ9nGyRACRH9EuXFhXU3adSMwhfeSTiSxWb5
         INdUGKE9jTM03Vm1d2PVYPt+6Wb4zgQYMtWX2i+5MCDUXDVFYpJpPY1p2LwsYLOGgv8B
         xiXEUlTchl009zaV0efYi91sifIqlVsya3jRbZXtFb5bkfI8rAkm+hEUoYTZx/JxLGNO
         WDNIX54Ao7DUqemYbU5tABnqON+JiOzXjotb/z2eIBCRwren3r7M2vP+RdDMeLhyKKea
         8FeLxssbcF/jxHPhCVml293IHaDr0/LrpWuWGPEgtKddQFVI7MKgYtkAn12YHgHA795y
         yTig==
X-Gm-Message-State: AOJu0Yy/nH3bWiDRZkJG5eSLAKergY0bE+M6j5MCRc5nvPHt8PjmZhAf
	N1kcHnnDssVyKQzelfK/Nbe4YtgQ6f/aMtLFwY9eTQ==
X-Google-Smtp-Source: AGHT+IGFOOh5+LAteol7g3S4FPXeKfzumkk2yywvg0O2Q6EhLZtL2XAFS+ExVx+JnhpGQoOvXLTm3A==
X-Received: by 2002:a5d:5151:0:b0:31a:e54e:c790 with SMTP id u17-20020a5d5151000000b0031ae54ec790mr3671242wrt.6.1695996838175;
        Fri, 29 Sep 2023 07:13:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:4e67:5f1a:c933:c857])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b0031c8a43712asm21606043wru.69.2023.09.29.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH] tracing: relax trace_event_eval_update() execution with schedule()
Date: Fri, 29 Sep 2023 16:13:48 +0200
Message-Id: <20230929141348.248761-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When kernel is compiled without preemption, the eval_map_work_func()
(which calls trace_event_eval_update()) will not be preempted up to its
complete execution. This can actually cause a problem since if another
CPU call stop_machine(), the call will have to wait for the
eval_map_work_func() function to finish executing in the workqueue
before being able to be scheduled. This problem was observe on a SMP
system at boot time, when the CPU calling the initcalls executed
clocksource_done_booting() which in the end calls stop_machine(). We
observed a 1 second delay because one CPU was executing
eval_map_work_func() and was not preempted by the stop_machine() task.

Adding a call to schedule() in trace_event_eval_update() allows to let
other tasks to be executed and thus continue working asynchronously like
before without blocking any pending task at boot time.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 91951d038ba4..dbdf57a081c0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
+		schedule();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

