Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93218195B1A;
	Fri,  4 Apr 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793105; cv=none; b=Dwik20jOHpxvXeu+a9kWYpw/ADQ6mRfbPCfvIfBQ5iIyZth+7ZYHuC1LeHi8GyFFCXddZ4XI7yGn0IYfgSOS+PqcbL8dkM84HShFUo3rKqBRS3gAAfQ7InlEbyOYpsW5Ps8H52RtbtyC2qkQVCdzFa5hqnm5T8JmcZ75DOQLWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793105; c=relaxed/simple;
	bh=gUJ7ch+2ljiCT2mj3iJ01ojeBYFA0SgdHk/14Pv5s+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLjNVJ7y6Ts+NHrDMFv+9V3ZEGNLs77jFoeeM99cytAtOeog/vox9Mwlt87yND8MbvThqZZxOw1Oh1GIXaUOmRNQ5ijlMA9zKAXYJmflA8ewg49ocaLH1V3ApfDD+7CuKZRswhE0BvSP2p4lP7tIP0QevcflmYra+p4ykhoBMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxT8NMyM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxT8NMyM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73972a54919so2280166b3a.3;
        Fri, 04 Apr 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743793103; x=1744397903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czT9t7Qp7rdMQKs61CER3dHjC/ShGZ0p9ydFV0RkeNI=;
        b=NxT8NMyMbss3idUcr6xAclO1x+p80TzbXPCTNqHfkn1Xb2s0hanap73TCeFBXAmK89
         3pIRCARK17X/q6ZVIfzibMiY3xiXahAOixBqbOfPvt1/YBHwKMv962mdzGELW4UvTMbj
         5STOzqQYtn5wCTfGI7C8S4KXQBZcoDsyDjFjMd2m+mLuBDhX5QbAIDYY05P8/8AIlN2v
         bYqfZRpgdGOi2WhSF0huUimnxwmKkcvH/tCUtEFVEPGT/3wWdF+OZwRkJ7V4Unloc4v9
         ULuxmonHgENM5eWVyLd2jQK8raPzjH3Rmo2bBBfP02hxkVNOAJOELkTE9ttGatZx70oo
         4zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793103; x=1744397903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czT9t7Qp7rdMQKs61CER3dHjC/ShGZ0p9ydFV0RkeNI=;
        b=rRvAUqCpzEmWTkP7I5qJNL5w8Df+2XfdfKQ0vLEDRwRjzjvSPrWHU1N7LfKgBHL3xC
         n4zM3zD0otoNchB19KyMUM3iJGr+AhRUveMjgfIGC3/eSKAjMNSr51RMDamveFwgt0dt
         lT9HfmmK96+v9+9t1VGGgXvJlO/8ioe7HB9/kjr+eSnxJIE/xENoV2bs6S9LL+GyvELZ
         T5wgAublVfZGcsWwdFT5cbnDQP8sNotIiCNs7UtSRLYB6ccYsat72wGew60kwMl5zv4Q
         8KA7VgfBduGl2cFNgZ+jSa+JKrRwQ2ZNAofKhW4q+SGLk/sQD71cSj8HoaE5cVrKjw6c
         A7qA==
X-Forwarded-Encrypted: i=1; AJvYcCXhKR/xW7VmeW5glgdxM+A6HDu8IAN2bCkL2MA6QdNGtcY2NKpdqEntTH5uf+gUoRa7RNiaDr6Jm5mWYG4=@vger.kernel.org, AJvYcCXmGGEfng8rHcZYL0r0PzTsTtwRWDWTDeJEUoO0AuO1zVmsa+2fGpaYQLEH8LrWfPTHyYF8iHq0TvpmLmw0iuOV5rNl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJXQkDY+jah1J85q0rn3WWqVweo99fK3wlPtF9adn76l0x7vD
	7F7hgdVZHmy1envNdO7ip+S/Yo/JGZiQ1l/yvPpOxSQ6ECstNODpPS4hypnfM3w=
X-Gm-Gg: ASbGnctradwUE+uqI8IMgPeG86AtSEWpxs5SEIctf9mAhQ+HhtrkAwc/fy4u/EToJLI
	Djz1p4nKkezdLafuqG/Qf6S19jiutwTRZCSItg4qLgYhhUjn8t+6nWvHfq99lHBTYxsIl41znIc
	JYB+6TI9yFCE5ZST9OxO/e9zkeAfQ3ve4tb7k6PdqS4FQPHdUr6haGDDDsqzSByla01oMS7ZGBh
	5mbJ1eCAtVyi8ouUCXj1A/9eNNXANkGoEXLJUPYj+de1DOBiEGqF3Y9Jeo3R2kf9TD7N4WRxivR
	0cxsvd8TbXfaMg6sHa3tJLIzED7apceOgEuuAqyPzUQ=
X-Google-Smtp-Source: AGHT+IFxFFy+1QLkfm3L4/1xU7Gcsmyq25Fpn10Kzmuaoo3aua/SdrrSfwlZtKCD91G9hrkEh0M55A==
X-Received: by 2002:a05:6a00:1411:b0:732:5164:3cc with SMTP id d2e1a72fcca58-739e711fcf5mr5187398b3a.19.1743793102688;
        Fri, 04 Apr 2025 11:58:22 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac1:36a0:810::176:64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d17f8sm3879563b3a.10.2025.04.04.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:58:22 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Sat,  5 Apr 2025 00:28:15 +0530
Message-ID: <20250404185816.2990559-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is deprecated for NUL-terminated destination buffers and must
be replaced by strscpy().

See issue: https://github.com/KSPP/linux/issues/90

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 kernel/trace/trace_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..617e59a234da 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -544,7 +544,7 @@ static __init int enable_stacktrace(char *str)
 	int len;
 
 	if ((len = str_has_prefix(str, "_filter=")))
-		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
+		strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
 
 	stack_tracer_enabled = 1;
 	return 1;
-- 
2.47.1

