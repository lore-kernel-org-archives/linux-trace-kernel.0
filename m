Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0B405F3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 19:17:19 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7D1B3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40646537450so11924445e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696015035; x=1696619835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pN0zsFl48jOIbMUKHa3f1BUkQARK08SxAyaTSBsfszA=;
        b=WbxINGqifppFE5iW769UOqrvmJciZhPY9ej9OKD117tj0RMh+FCmttaAqfWHC/2AQH
         LZ7GMDDHXQuFrrJIQJoFKqpFIWuCba6ov5KHW3fNpe5d/XN/HkY3jJqLepMJZO6kvWce
         +fkpBsGAvcSqZjDnJyMrbp8Su0sfeYIprcmIJJ2HK/sNuKzZmwBJiGyzdw5c/NMpDcs4
         JecZ4fv7nlM7NxOPzpnGGwkJnJtY88ppy4pGw4sdW94XTcL72qR9RlhFWnnwRHhKeWRU
         l9igWxz2twzvjkkNalH4GVezncFfHF9QmAVMXGhgpdEKGD/C4Ej0MGxRk+r92/Z/lY2F
         cvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015035; x=1696619835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN0zsFl48jOIbMUKHa3f1BUkQARK08SxAyaTSBsfszA=;
        b=TmOrXUW9+7JsiiM1u9UoRk0F12L67OJwSANLs2n8fUiMp4blFauRjEY9ROg8w6DkLT
         76B075rJV9N5kAxuq5YfUCFZT9Eoi/eb0pxAIZl1R+TOJcv8TIP/xTwe1tR+esSgIEQ7
         A0Um1uwB9XEsCbKU+Bpr4xFfFytKeJs+t4HNwJG6ogw0oM8ysY7hGXVBBDKxm7/OYwEJ
         XVcOD63Fcrs7oyVURm47mJBUbjJQD6/D/K39jQ8cufZsM/kieoyIWJSxunzBC341FYCA
         mL1qXOv/NPCksskpoe3A0hB+2upbi+w4XuI/RWySlrktg30S6MUdmiWvvs6aoCKWdWRK
         8LkQ==
X-Gm-Message-State: AOJu0YwMVBNXjQaZAmYu52d2FuP+RL5iG42rqESjVRH+8lypfrtCVrEe
	TEAlyPtDsYLU1YriF4JJZaM+wg==
X-Google-Smtp-Source: AGHT+IH0YcMehB1h6ftRJ2hEtacCgJkDvtR/C6JCIdWe0R++0khQ3Qg0ONbj8p1yjfz6cEAY6Le5Zg==
X-Received: by 2002:a05:600c:3b87:b0:406:513d:738f with SMTP id n7-20020a05600c3b8700b00406513d738fmr4736627wms.2.1696015035387;
        Fri, 29 Sep 2023 12:17:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b00406408dc788sm1995230wmi.44.2023.09.29.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:14 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2] tracing: relax trace_event_eval_update() execution with cond_resched()
Date: Fri, 29 Sep 2023 21:16:37 +0200
Message-Id: <20230929191637.416931-1-cleger@rivosinc.com>
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

Adding a call to cond_resched() in trace_event_eval_update() allows
other tasks to be executed and thus continue working asynchronously
like before without blocking any pending task at boot time.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---

Changes in v2:
 - Use cond_resched() instead of schedule()

 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 91951d038ba4..f49d6ddb6342 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

