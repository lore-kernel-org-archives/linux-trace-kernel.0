Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9C558B7;
	Thu, 10 Oct 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532717; cv=none; b=uXPe/LrAwdW4kR5gvgEMqpy+Drfnkx9q8qe7CmfMOBpwV7U9MrXODuAKJuWvTWnSBi2SSgOJVP5dHClZ0qinquiLUi/MmLUKorJNyQYZLx2T1W5DedjYKCE0o0oaztasgoZyAZrafDHBSKiK2ia3I6syAC7BmMP87/zl+aiZ5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532717; c=relaxed/simple;
	bh=cotlwAtYcnHpA/YeAouBcmCIIpppbLsNpV5hYeima7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8MUjCnQKwq/Z12Jt3jjNsUj7BgMO2uiEhUBoEhUyVbLvFcNkswmY6zrgPt/ARcKZvePOyL+as4pkE43lfdRMQlM9ZZYnXJpWs6T6Ry1UsZXrm5bl/BwftCBg+YCLN8mVjn8RqGqqF3slidTALqAsbLIyLsKC4Oi5oM4TT2sjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abjz9f0o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abjz9f0o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so4436995ad.1;
        Wed, 09 Oct 2024 20:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532715; x=1729137515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SrF578u0d9xAkj32TSqG9KE1d9KA0G+m1TWYGifgxs=;
        b=abjz9f0orcXajJsU2oLpdlQrpJhV17/vsRyiedgtq3ecAdlvmqifoiPKVZDeOxIy+Q
         EQ54as9NsWmBcYSJsR/srltyAcEVmpfrjjZqUJQg9z+pwrsITWgCCcmDbndBfYyNvKfc
         z7Tlm9NzfW0+QTCcNhLywijTJxx0eHaOtHDHpezAlSDzXzgEawxQCc04CBBxAE99lW+p
         2XT6MLhkICl2k0Fjz00MBwZp4HExmBVj5elNY2DHqEQiHWZU6K3qrVOUyuO+YImUU0OV
         00NAqzjgbX47Ory3BKLraRyQ691Q3mY83K7pTtJH26p3wEPSBPOKSUGB8UL7O96D7A/3
         24mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532715; x=1729137515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SrF578u0d9xAkj32TSqG9KE1d9KA0G+m1TWYGifgxs=;
        b=X9g7Xa5xf8JzyQjyCi9VgR1C1OG8XqURlNTZvjlsll8d8wZpq+v8v+hnPTimeuhoHf
         0bKVyDzNRYyYoZ2KP1SllcF8czFw5cCn9lAuGWBxxGPJ76/rySQ1nCZLgbaPjUALCjmU
         Y2C6LSsup7e3w4NQ3HZrzKtCjzjPV55fphHzSWwU0ecUzC0Ja74eYB0dqId0CDQffGO+
         +733xPMQYgNtnkQRqz3f2K0kPY3Ejv5pFSNOB9/euxAOhdJsbJjixXA01GfWGg46nwo4
         M8h7/GJMb1um3Qoe3ciHlsBQZewACzFG5e7RFuPFAHdSBoViTvGzEbsDI6G/LjVXc75M
         C1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN9xTaj48D4xIuFHF0dFtUdDFspeSoQeOn6zfl0avuOttHZRZr49DTqaCE/nv9Bw1JaB7GmepbCWOBeXX3DFZvzqW6@vger.kernel.org, AJvYcCVd5UciEHZqdAC9cWI9EzQoKiOBkk7uZqdWsKb9mC1uqYB5AYCcPT/nztf6U2+gwT5R1ZRp8DE4W0p8Qn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrM4v6kEIKCJOudsYRkWwgVfA2+MobDYAeFkR2GV7/hpo1mtMv
	U6QBHvSheTbdS4wnsfvPQK05/Q9dfYKDLgd8Fcefp7Fj00twOtYp
X-Google-Smtp-Source: AGHT+IE1YK470ZxwimR3x/Y7dWQuDSA1+kpgWxP4DpxlcXxM146+7Wi9s/wj+oRQU9YOg1LqAICttA==
X-Received: by 2002:a17:902:ec8a:b0:20b:b0c1:712c with SMTP id d9443c01a7336-20c6375a893mr70813875ad.35.1728532715127;
        Wed, 09 Oct 2024 20:58:35 -0700 (PDT)
Received: from ubuntu.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21d3b5sm1665105ad.215.2024.10.09.20.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:58:34 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	zhengyejian@huaweicloud.com,
	sfr@canb.auug.org.au,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] function_graph: no need to invoke the function call_filter_check_discard
Date: Thu, 10 Oct 2024 11:58:26 +0800
Message-Id: <20241010035826.567827-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

The function call_filter_check_discard has been removed in the
commit [1].

[1] https://lore.kernel.org/all/20240911010026.2302849-1-zhengyejian@huaweicloud.com/

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/trace/trace_functions_graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3b210e6bcd70..98f347c049d2 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -148,8 +148,7 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 	entry->graph_ent.func = trace->func;
 	entry->graph_ent.depth = trace->depth;
 	entry->graph_ent.retaddr = retaddr;
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
 }
-- 
2.25.1

