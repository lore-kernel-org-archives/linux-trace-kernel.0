Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31B38F656
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328422; cv=none; b=ksyklenHiUSso1uEJxdQaVoARqk7MOgMpKS8OHf13nw1EWXuxOXLXqhwsKnF0hvg1TmF0oPGes0efRFK+/fyMEod1+YCQeyQrdnS8y/WipxPrQCaBfxytwjblnSuCK/xO/7pdi5s5UXxHtwC5CgoLbqv72SXX9oaIVX6obnGTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328422; c=relaxed/simple;
	bh=yDvw9QNheyxgTewP6EIyWz0N0bCZCdxouabsXc5gj0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaOGV9V4m3APTecogbOkI5LE36BAbgiF3+laKiHOR17sqsCS0wRiA0gkvnsQKYQki438CD9tkUTFAqrdyi3yWaJnII5f3wxDW9jF70DWDOQP4uZu1/Q72xlrWrit7Gin9THbJDZDci3X9LDsN4pwqCtYlXmHSwtaemamk6pyWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stzFhVSc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stzFhVSc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaf43014d0so46881845ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776328421; x=1776933221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfpO2hGCwjyFr8u8B5sPRFUHsnHMuKJAwc/frKEr0SU=;
        b=stzFhVScM1TFg0JHM6vEmeNOTa/NZn4CKCEZoLgOJ++CTRd+7FMLBpB+eP2Wywc+ad
         Rsb/gUEODiskyGTxIoU5pAac+pFDL7rd90r4Ih7G2z+nP5Fba/pdxK5pdc8/8Y2erzpb
         Rvtdu6HtlUf1lkkBbGBAh3XNMUQVlb0o4xvfHyuZUSDUGlWV6LzbU9PHbtUdYRWwbbLa
         dlqZO6Lm0bBK7RfFyUMG/ikhRyuH4LI8hvggMRIWBZPDxxhm57PTH96eGrGRCF8Uga+0
         LOR/lHdLbAMDD8JZvdIx1aWy2zx2Xera/3iFjFElkwHXNVLvPv3WQZfueu3EIr6PvyJN
         aTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328421; x=1776933221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfpO2hGCwjyFr8u8B5sPRFUHsnHMuKJAwc/frKEr0SU=;
        b=o8htgVUKGNus0fj4d+ZqXUsta21w0TM+nE4mNA+RO6i/KbJvsKiy2XjoX6Y/cmZ0eH
         vLs8QHegabEjW1fngvLTp/sdIYf83BIfGRcGAg/jXxR2matLz62MOQk6rfzBPMPF6oD5
         wsNmYwNynIk2cRHLgOn1ejoDeuxCblYYTi03lJjSVHHoe8FSRWT2S64V5KvneZ2QzxFs
         S4C2p6GfRJTELhz135TEsbZjzhKJ+xq8DWFfl69r51RL9eXO1Jb7A+7e0fKVSy2WJHSc
         A+Goh2JLxuqKC7U+Gec6Y/P7GS8JdZehirbXC4igc+4Fi3OO6XDoq4qezdn3N1sqI9JE
         +uNA==
X-Forwarded-Encrypted: i=1; AFNElJ+jKg7tbP0wO8RMJsUt4J1cRC0wie9nlDRSJz/oxrtTX6SFKArAFz3+smaSG4IT8WTfzTbA7Dy8rtOSFcrkYHTZEPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiRxLr88lXqmqsDrNzNXITk+08nf3zMtULseWorNEfuChQaks
	wTQNn5+rHUWN6YHoomdBhPcK+9mOyHvXK6uOc0Q1zbeFjAD9z9Tu7LAI
X-Gm-Gg: AeBDieuYlFzI6bDuOHJcKxmby7+kBI2QTEb2/jzNX+VZHEiMx2FTBCL6zEqINKcdnxr
	SAD2r0obgPMaTk9JbSxYpqhCc7gLu78OzRxXsyJFD2A+qg/kyMUxvgr92mjN5EVg39Kd7v/WGbp
	PZCA6X3mkJ2h5tNDxrl+2joUmmN3MpuHDwvP4REYgGpxJB2mv0iXt7vZDbYlblm3po0uNNcD/rb
	fNKTHiSwUZ+/h17UdnfUQzqU6/N8lqCwL1yz41r31X/q/4Nw6uz8AmiV2L6Rt6i1P6yCbpETjBE
	1YjrFPP/GkVdEgpu69xcwRaS41QUHynqAhhPxVbT89mQvm4UCvotdSYw4z0V6xnsJKjkaPMBpjf
	M6ekjbelFqW05Suj2m46C7L/jBMSVVLiZ9vLQvGkOs6AY4fqoG/gdqEmjxvOv2vRsCrOXsXaaRK
	re96hl+qOhoPmOMootbZk13WVwpfUWH71T
X-Received: by 2002:a17:902:db0f:b0:2aa:d67b:ef96 with SMTP id d9443c01a7336-2b2d5a5c0f4mr271666615ad.31.1776328420531;
        Thu, 16 Apr 2026 01:33:40 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478292053sm58391365ad.56.2026.04.16.01.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:33:39 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH] ftrace: fix use-after-free of mod->name in function_stat_show()
Date: Thu, 16 Apr 2026 16:33:35 +0800
Message-Id: <20260416083335.920555-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Gao <gaoxiang17@xiaomi.com>

function_stat_show() uses guard(rcu)() inside the else block to hold
the RCU read lock while calling __module_text_address() and accessing
mod->name. However, guard(rcu)() ties the RCU read lock lifetime to
the scope of the else block. The original code stores mod->name into
refsymbol and uses it in snprintf() after the else block exits,
at which point the RCU read lock has already been released. If the
module is concurrently unloaded, mod->name is freed, causing a
use-after-free.

Fix by moving the snprintf() call into each branch of the if/else,
so that mod->name is only accessed while the RCU read lock is held.
refsymbol now points to the local str buffer (which already contains
the formatted string) rather than to mod->name, and is only used
afterwards as a non-NULL indicator to skip the kallsyms_lookup()
fallback.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 kernel/trace/ftrace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 413310912609..6217b363203c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -559,21 +559,23 @@ static int function_stat_show(struct seq_file *m, void *v)
 		unsigned long offset;
 
 		if (core_kernel_text(rec->ip)) {
-			refsymbol = "_text";
 			offset = rec->ip - (unsigned long)_text;
+			snprintf(str, sizeof(str), "  %s+%#lx",
+				 "_text", offset);
+			refsymbol = str;
 		} else {
 			struct module *mod;
 
 			guard(rcu)();
 			mod = __module_text_address(rec->ip);
 			if (mod) {
-				refsymbol = mod->name;
 				/* Calculate offset from module's text entry address. */
 				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
+				snprintf(str, sizeof(str), "  %s+%#lx",
+					 mod->name, offset);
+				refsymbol = str;
 			}
 		}
-		if (refsymbol)
-			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);
 	}
 	if (!refsymbol)
 		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
-- 
2.34.1

