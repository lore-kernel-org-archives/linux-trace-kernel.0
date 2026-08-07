Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC644A402
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092870; cv=none; b=mgWsHbfK4bdoZiLmXXOZ1sjPXQGx2x6KFXh00oRL/mpB0jYP7jU8JaGVhPIyvGW4sz7WuFo1Y6ZSQAy4tWLKRu2mXF8GLpUaZDBn8bAPqC9kXZ4DJZMVyaH7U+OWdwFLsCoDASkyqm5wQRcsL82ZVv4+1gOaIdgV0QF0OzpWSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092870; c=relaxed/simple;
	bh=MVnPfXx/IZHxs1y110wkX61dNZB7hmwHU+fPw88N6o4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ipJfYRB2N3k0af2xrexl2jOcWuQnXdO05x1CF1n8ZEFVElMFszOOWmSwTDAJXR7a7/mf4O76IZwxOPhmUfnO8etc/vDpyOFx4/jOSLpJLLvLTG45BJ6De35J92m+XLIe6SFejO1Ppj/rraVogfk0yyPFz7Y54KPDNSg/hMbsU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcMlVjln; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcMlVjln"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso19336695e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786092866; x=1786697666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HUKNBvZU9k1aCGkE/fnPlXOi8c81eiIoIG000yj/YPU=;
        b=ZcMlVjlnHe1UoQfoSyIslc+aD+pvQqgJAAvLzvu0k0M9IOiOkBhVisZ62D26th7e7G
         MXJPA0+rNeAgus1AvKWKwRO+dItllAgCu55zbtXM19/QA9MiXfjH5dRLUdMPBKwqUhfn
         Mtx4X/wyVvyYc4qGqlFQgyYZoKd2ssGxhtet+r76Z3fvZCsOPPgOMenHGjZ19pVAjQSv
         xAGyqdQ750DSo5gt5JI3VGEAueKL5c3I7AZtqICfywMTqI2ugkFy8ccrw5h9wlJqlwxg
         R8YHwrQqi6IsNFSiTQBgiUQZ69etqD8erLnzr9a01ek76CKQPMOLqujk8cJJVzvBKfQp
         WS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092866; x=1786697666;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUKNBvZU9k1aCGkE/fnPlXOi8c81eiIoIG000yj/YPU=;
        b=e5+W6L2Vb2jppU8kdGUIZWlQwK+Wv2wAP8QvZJsRqcX+5oY/4s4hemWMwwf+p23ZV4
         Mb4KslXqgOIZAhJHG5pHFNNQsY9jrVemv47vzqZxWrQCFs0v+UAvx98jTsZFKO+JKFuQ
         IfYG/Nqu0e4xA+2qzsCQjisIhW1qqBBTua42yB3yyV40FijCz6Ryku5vsYIGBb09+Vj0
         Fm4uOeQ7NMEeNArsEbmNauyNrFK6PkehlnNiN+HGKqazpVeqEZSmd1JrKQCYBUArj6g3
         kyBjXDnAFcRi0kOBZIeSqvBATDkL2vJWSUTWZy6fI1zG33U3T862eTA3yX1u7mQSnAxL
         KtXw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7nJMnMbPRwxqYo2edVw988DmEC2XrWkEssgppbcJEQq0v2FB6PlViumstDlMmWBaHwNr9AvIp/3B2cow69zVngTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnJD5g39X9yeUjZHeW2jQ38ZqW8389iUpVg/nvpNCpe/pD0Op
	DO27ZI6CFd8azrJ3ClbFNyuKWelrcjT9FLZQdQC9OmTXOaBhFV2OoSQcUbjXtFGOSrfL7lsQm7g
	z2iLSF7W+DiTKaCyEQaLfuQ==
X-Received: from wmsk20-n2.prod.google.com ([2002:a05:600d:8494:20b0:493:bba5:775a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c4:b0:499:4dca:aa4 with SMTP id 5b1f17b1804b1-4994e70ed73mr283617995e9.4.1786092865804;
 Fri, 07 Aug 2026 01:54:25 -0700 (PDT)
Date: Fri,  7 Aug 2026 09:54:23 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807085423.4175161-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Fix logged instance name on creation failure
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When boot instance creation fails, the kernel incorrectly logs "(null)"
as the instance name because strsep() consumes curr_str entirely during
parsing.

Print the properly parsed name variable instead. And while at it log
the error code.

Fixes: cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 01a5e87af299..26ae682021c8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9726,7 +9726,8 @@ __init static void enable_instances(void)
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
 		if (IS_ERR(tr)) {
-			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
+				PTR_ERR(tr));
 			continue;
 		}
 

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.55.0.654.g21b8a5bc05-goog

