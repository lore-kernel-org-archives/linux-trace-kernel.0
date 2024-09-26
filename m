Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D41D5AB1;
	Thu, 26 Sep 2024 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331350; cv=none; b=CGXMqNuASmlRTpkMdia1I1dtD8+Y+GwnMT+RLfWniqMYn+aTo6jhadC+tuX8qO2T7rALLSeueDhTxM68LtkTTVxKs9D291tGYDXxsGwSHjm0cewI+ch1OgMI9BlJT1iFKGa+TyRAiNdl7Ss8IXmfMswUGmxMuAQJRNlFnrlsUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331350; c=relaxed/simple;
	bh=m+HyFMzlEj5Op01nvjdqUC9n4R25/INTajoDkOy1JiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7oRsBcBaLKpMmyD+tysdFUmBMn3Dgc1Pfys8reo5+i4TkkGHGHm4TvZkiI9qtA3Dms7dfUrO6As2oeAvvtBfulU91/mo5FHfcHIRrXk67YTj+CqLWcCies9DWY8RvFIWEPrW5FrDHyOxTICEV58OaxZRMdu1k2/f0zjcHKrul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaQUaJiz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaQUaJiz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so4397525ad.2;
        Wed, 25 Sep 2024 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727331348; x=1727936148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FbqXgEe+SvTfiFifD6C5YX3wgD33T4z+C6CH2QuFow=;
        b=WaQUaJizzmwfGzkcB8/sCGwwZkMPoXskJrwsGE0crlhNKn5PyZPtP0s3TI9zsqZ+YG
         SZrL4XleemEPjSy/eBleFUaq+ZLRLHp5/t5KYk7Bcs5LArDkw3++jlQO5tI2OGg1sZ50
         Wv26phInsOgaLlZ/KhjdssygGXGE5EWEMe9vY9Bi08MnksNxFVTg62jDEAWQDM4TRlFg
         YIs/CSG++758IviQmTCrUvoxOAZOWHKHY/axS0GgHOtae4biVEXGpKBJZDJXuJSgvIM4
         lL69tPGFioQO7+Dy1/tVg0VZ+ut4Fsvn/pcvh69TuzZXCRW39TJO2JH2PULUH/wvy+R4
         dPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727331348; x=1727936148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FbqXgEe+SvTfiFifD6C5YX3wgD33T4z+C6CH2QuFow=;
        b=FTAe7ho3kxZLjC2Pe8Xr6tWX3PXlx14nh/aHqzei/YAnQkhNN03G6oELecUY5EkzzI
         VCII/0tS9LODYb7O5CzdOnb6IqTIDLr5IUsfu8ftQXt96KStKNEH23jzM6K78QjCNkU9
         953tOpO8vsaulGzxQvyMzWftsfS1olSF/iXzZjx7Xjbb5KQwOnkSS/tvpBWruvMMbt5M
         MIRYeg1jL75wdE7pRCWcxNALSRVdbdeB5lu2nV7Ht9x03CjnajmPRIjj3Ia29BJLfw6w
         AzTgYJlIYa7MKVvvCO73+jGz2D9cp733XZI6EnL0t/Dd0fEwi5EBJFO2jZBV07efWRHT
         b53w==
X-Forwarded-Encrypted: i=1; AJvYcCVOie/A/3gTqhCjikINBL95JIBZCT/E8GvrzXGeAKpdSyAP3H+yyYTTpTVTc93/5yJONm4clifIuBiC1UKhNZ6RlcE5@vger.kernel.org, AJvYcCXGPGMWY6yuhfNivFFuPQ2XkF0QgqSu0fNRM27ZgxsDB8T1W9KoygmWMiUKYF4dYPv7SbrzpJ8Mnsaviwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZjgeb750kVvLHt00MrRcKtQlyosCq4DkP4KVMeRlfyaUp7+K
	8SRg4NgBzlrlcf2vceyI7ao1RV+LtN1AHwxfYEUHvQ9t2Q1A7lM9
X-Google-Smtp-Source: AGHT+IG1deFc7xmIgnl29SkGt8TISnCecgUGJqk90q9EKUfCQEgL++bHCSTAskWv9/p+5knrW7gx0Q==
X-Received: by 2002:a17:902:ec89:b0:205:968b:31cf with SMTP id d9443c01a7336-20afc4bb564mr78213455ad.33.1727331348514;
        Wed, 25 Sep 2024 23:15:48 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b0f80e5b5sm11996245ad.261.2024.09.25.23.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:15:48 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Hide a extra entry in stack trace
Date: Thu, 26 Sep 2024 15:13:07 +0900
Message-ID: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).

    [003] .....   110.171589: vfs_write <-__x64_sys_write
    [003] .....   110.171600: <stack trace>
 => XXXXXXXXX (Wrong function name)
 => vfs_write
 => __x64_sys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

To resolve this, increment skip in __ftrace_trace_stack().
The reason why skip is incremented in __ftrace_trace_stack()
is because __ftrace_trace_stack() in stack trace is the only function
that wasn't skipped from anywhere.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3b2c7dfadef..0f2e255f563c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2916,10 +2916,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	 * Add one, for this function and the call to save_stack_trace()
 	 * If regs is set, then these functions will not be in the way.
 	 */
-#ifndef CONFIG_UNWINDER_ORC
-	if (!regs)
+	if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
 		skip++;
-#endif
 
 	preempt_disable_notrace();
 
-- 
2.46.1

