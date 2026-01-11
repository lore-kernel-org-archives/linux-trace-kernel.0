Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D534887C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142005; cv=none; b=uyxzutbj1DViHmW4f17DgnkfNP/hQqbeRa7FfWM1dVv5aI2+pZFrxWh0+t1HnisVtlYaLU0l/Ft14QoWGFCgbsisJOo6Rn12qSmB8Ox9vhEQSNh6Hb+HV53QsFFfQvIiHkyQiR/FLoViV5dSXBlktVZVsDiaWIfEuV2WlKzTCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142005; c=relaxed/simple;
	bh=wu4vwvYUlSZbkXx73QCR5kFIpzfPtnnuYGIzivlqZBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlQdA1Ug3CSzcMjOHrfyPe0DPpHsU7wMP7KkXfGI/PbDg1G6QHjsIrkIIkZ9532ElR11xn1It1DCu1Q6WPCwmxXf28Imrfye6P/IaVH74k7mDx0vYeWesrSdBMsPCd2/qicCFZK06A5TzuteS1Pyrbpc1TB8xRlxxSnVi3MFFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkzP6S1+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkzP6S1+"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso3491032a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768142003; x=1768746803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7mX67quLUU2oAcz6jQKaJWWaQCHCw9MhxvL7A0RZAY=;
        b=MkzP6S1+KNvFNdkIJnykzRgWUVAC38LU1gZNQEpNH+oGEAO4YY7FxMInL2ilXvePb3
         5XwLhRAZ7+ZCJb19S4W6HuRM8EwtMGcb7zjBC/6VaSJyWlKi4ao2OtvK/4HYgsg/f2dI
         2ruc97hTFiDiJ3CtATkeggC7em+XJgbUBBO/cPFwkPheCBsMmLxDuwRcZNjA1uyQGgLE
         fPl/AMiYCu+GZ+9ng/9v7D6XSMLb3+tqN/FqGZR3lEWSkrJZ1HkCNEDNVtriB5ccgKLs
         jqECn8wh5dE5lVx+ZJYVivHrNdwtLdwUVgxOi93hBKyevVLYsyBevKCmAigkXdFQ+u7F
         cSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142003; x=1768746803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7mX67quLUU2oAcz6jQKaJWWaQCHCw9MhxvL7A0RZAY=;
        b=r9pJqYEgqQerjE1LTTW31AgeSJwKJCrI7rz8yX2DECMs/V1UCdgkRCRvTLiDxJQuXs
         6PF+jjgT5voodHFi6OddYLHCcXalalv4uLnPXeaZhvriTAnfQXAtnGodvJNXzWsrvw5R
         RxLuGFDNCp+sn/OPLlF+iKsLiCrAp2IcYnyy9D22EXid+LXJcknZ3IPU00IYba3r5u7F
         oqkPLjPEOTQJ45u0a04omqqVBFs3DKBrSBAZFe2pmamxY4hu8VEKyxVcVUKN4k/zQK6p
         yvVFrA3qemqExw9ajzr5I/qhA7cq+F8I9HyoHBIB5MoDi+taXSbYuNqVbwntej1YlwC1
         oz/w==
X-Forwarded-Encrypted: i=1; AJvYcCWRNRP5rwgBPkMggV6g0hpBPv44e4L48R+zxclzASqNNRkDV4Q95/D07zcQjk7Z/474TGv26t5/bzovj3UxktaiNyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1xcCyz/JwszQpQFU7BrSY59QG7qOP8iy+Fq+0G41b4qGfaaL
	3kCfx8vfzP0+Cf5Z6j/QhycEYC/TKAEUjZpp14JQSmdJOUkF4hhbDqtc
X-Gm-Gg: AY/fxX5+7qhYEUHlBAwRft98DssT1l+3P+fO5QWKeWBavq4mMWnY/u3st9bKijmkz9a
	tW8Oisw6h1VZGKH1dbuLJAc2HZuGVcXaxocl5Q+c+wZlV6GjjMYRel7O+jv29GvcCLVsSh0fm+Q
	dOHwq8f3xKnh+ijOkI5tQu1r97eJza5a75IZjbqi8XVMI7kHBSpsp8R2mT/YRFay5XWXvayvXc3
	MZGtSYlglxwkCBgp4m/eKUc1D8plv7l7osfDjzBU+aCsHLwBut5Doot3B1NfnrESr5K9KdSa3yT
	IjeaPa0aZv7ZkZlQUG8KKMdVZQObLwQSE64rUvIMa+6eGhTHNeNSTuf+tT5eExfYB63wNAMo8ac
	vog1yr9hpAn0WB3SeLHPYPMEFTNaXClz37MOMh2AcUyY40/53oH1DzzZ+dR+ojhhdIumsTkcyPF
	KsVcSOvLnWPxZbEcxrqHgXTBpHl64=
X-Google-Smtp-Source: AGHT+IHkJBONK1TYj538dCQnMEPD6qv83mOOBLH2ZmpptkP6znaNdErRy28FOLdZw3enEM79SAlsGg==
X-Received: by 2002:a17:902:e552:b0:2a0:cccf:9d24 with SMTP id d9443c01a7336-2a3ee42a2a1mr155193685ad.16.1768142003098;
        Sun, 11 Jan 2026 06:33:23 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm149639395ad.0.2026.01.11.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:33:22 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] function_graph: Fix missing FGRAPH_ENTRY_ARGS() call in print_graph_retval()
Date: Sun, 11 Jan 2026 22:33:18 +0800
Message-Id: <20260111143318.917945-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Call FGRAPH_ENTRY_ARGS(entry) to retrieve the correct arguments pointer
when displaying function parameters in print_graph_retval().

Fixes: f83ac7544fbf ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_functions_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index b1e9c9913309..1de6f1573621 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -901,7 +901,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 		trace_seq_printf(s, "%ps", func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
-			print_function_args(s, entry->args, (unsigned long)func);
+			print_function_args(s, FGRAPH_ENTRY_ARGS(entry), (unsigned long)func);
 			trace_seq_putc(s, ';');
 		} else
 			trace_seq_puts(s, "();");
-- 
2.34.1

