Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C5258CF9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619210; cv=none; b=YhpP8kGmCoFhPpLCbxDRWcYeYY2EfNf6Yc1kXwMgb1+tSTyKiZ8/Qa+VraSJpG+a/tHv76Rxo0QBwMuZeypzYoviCTjWwu5bGNmH31I/cmHQegnpoIdTLP2/aCFywJNQgleAhNl/j9SfUXSmR2ASuuxx8VaS87rrKD7vguG5w+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619210; c=relaxed/simple;
	bh=CFGQIdYFoGZnnU6HvNyb+l/ee08KR/O3dY2p3tvi2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJuy1nZNmCi5zm0CHf54BRDBWh8koexrpsUoFjdWBaSIKYplSi8JcSNS5UWfvzO6LW3xIacAnFoRV4hrDy9as5gogy8TMvlH5XSCq+WiEc4sECkEmvKQPZtDd4kSeTzeFUfsGCLlwGCmwZDA4Pj9PmgrzYHrMA3qybrpN4YcST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW4FKGuP; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW4FKGuP"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77f3405c38aso1821642b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619206; x=1759224006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=SW4FKGuPfURhChAQQBLyYIK+tcDYGYl0M6QbnAaZRjGcN3zq9TkEDQp6joJ56Mtjf/
         S+PZqpilRK6bDAR7Mf5UD7MBfa0rhwQG4aajfvyRUypK2pMSZhtiyNhOxEigI3WvhUF0
         sQe25yX+gG0jK3G90K0OMZz9A6oICn2tvXaDczPSVL5yXfgLI9FfK9Z6jiTe0lWEa/Er
         rY6yxP2GBqWE9yol6GNiprdCpVHqKwFal9wrZqnY0Zd1b6OckGGEGmUWla5AXbch/XwG
         srs1zWsPDozhYjg50BWMVlg59vREJc9wKtEZW7s//A7l3oZkdfVDBGoynVhaawrXTWFG
         SloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619206; x=1759224006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=MZjwQKKC9Iajo2JjkLKF50dX10lKy9EnHBDFN1T2dPTSawvEbVfZ2062jAvprThP37
         0Vwi5y7WIAUORN+aOpjeCgNw7yvlHLo+AYXN8pnnKg/GECR/xQVweUMgPKxflNLE0GD/
         SskdK+FHTnFEqk2Shk16Ty17b0ScDE6Acew0cespzP9Y5XtiJb237QcaShHUQRj4Wa5b
         j8zmKvajPr+390IfD7eVrA06TIkeTjZIG3mgsvSg4oT6fSUoTY6Q/1jCizr+sqWKZ9SL
         HRczlAf5SCSflprpr0fufnyL/yq3GfOVdd3wKLl63egc1oTc1u4AYMilArQi0b4wg3Nb
         Me+g==
X-Forwarded-Encrypted: i=1; AJvYcCVaj0J9RBcINcesEO1DL23Ot1PimTbBa3Fiy1PgctGuIuM6w3afzKwRvAal+lPCIHn3QdYMqem5LblbSPHvUThBLGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTvB25E3hNNnYVj1gBC6ZZsP4kSsFelKycrKUQuOFa8Y3ckqH
	JApWFaCc0Ew8nC3RbQHos9/F36e3xyLMCpbL6qdqi89bzOT2csUAvZ3g
X-Gm-Gg: ASbGncslZ2EXznbvsJmmLDJ1wa/FSftpc/P9DaoQypbwLKf2ckkn0LHeSz+8Qyg0TZz
	VuQxTlyILeA0h44n3FkNHcMhOGTlA87gtF/H+bhbJxH9v3xDJ0raoythTMSemPUSFCeNV0xbfs7
	SbeT6XG7XOm+/m61QRvIjmXevTtkf96+LHxGAVtltJRJoNLtglXy4JDFWiRcKGl/8YOpALY++BB
	xxIWrmNSWzLXUq5Vvic6qh+ZVpr4CW08AiFxgd2UnvpUWrKN2u6CJD/ts7FZ6ZiMGBGV8uBJVEf
	dIWYspeSsDyPAWo55bxSoXBNyo1giyRdox5TLgGtKd4ujF9pY2JAdA3sN9xU8BS+Rowv3Qy4250
	lk7y8gKXs+B0yYJ8F4HI=
X-Google-Smtp-Source: AGHT+IGN+oSAolzbRO4iqlc6th7lLVX5x7Ige0JdxEZG8Rmzq2x+xKdBh/O3pTSpSmY3qaBwUhTWFw==
X-Received: by 2002:a05:6a20:a11a:b0:263:af5:f1c0 with SMTP id adf61e73a8af0-2cfe2a5d75cmr2793346637.15.1758619206429;
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm14114941b3a.82.2025.09.23.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to fprobe_fgraph_entry
Date: Tue, 23 Sep 2025 17:20:00 +0800
Message-ID: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fprobe_entry() is used by fgraph_ops, so rename it to
fprobe_fgraph_entry to be more distinctive.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6a205903b1ed..1785fba367c9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
-- 
2.51.0

