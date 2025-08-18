Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CA31E0F6;
	Mon, 18 Aug 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520121; cv=none; b=VP4wiunLfxAKJzoXreXtK3UCWjmnOfK3Xw0p+cb0itUgCnEsruIzkZT11vtvmU/LrbgsrKeP5qxSlY2W0wRGcy3GE7D2JlfeM+zXl0hM9+YNYlJ1rxt0U2tWyx1P+ySsRwy83TKIHTExq+CxIU7O3n0cE8BJL5JLuPlIEauLKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520121; c=relaxed/simple;
	bh=LTOMLtadUDGH1rCOcIIS3Y+FOaYNaAhFM3VxEtPitv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfEomdH2/pgvfk/kibo9Ki6RfFw6azM/73HIc/TScUHw6nJw5RvYWNnopXXkugsyUfIKTZ8QwDf6pMVdHyl9tqyOVCX+PEqK4zZ7KV3mv5Daex6xmutkuTEWmhtjOhAjAb0AOmPv3d4hSmdfLtbXg2JlicWEGBor/0gOUSJHlxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXxJerW2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXxJerW2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244580536efso27498085ad.1;
        Mon, 18 Aug 2025 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520119; x=1756124919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJOiI8uKFg1PMlS5jfewmtMLkNj4AhWzyI4e+6eTJxM=;
        b=YXxJerW2MYTbgCSASFM4gz8wDJ+k82JuAZKMM/F+Iy9Lc/OOnvnPyk5Q65Kn4UGKeM
         +RRfPCVmXNBVUTlejLcbVWRDrwXBwyarYvJcmxFTdjgQtBxiS5qhnOZO1dPR8OATCwpp
         qkbHWV3cFj6XYc20DzXp86fEhHowD+Lu8HjIc42nzAMpAV6/VsUGxLpUsVL9HOM22B+8
         7tHYUqMSMeB9Wk1jvchCqRy9tSwirrn/IKrE0C4IBwOiFrP5SogpuRQ2eexT+JU+m+dh
         IvCbrFh0va57BWfzRELb8GUiFaonm6OVVBmSQp7ey6+URuBUP58+svmqvA6vcksMnrIT
         K+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520119; x=1756124919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJOiI8uKFg1PMlS5jfewmtMLkNj4AhWzyI4e+6eTJxM=;
        b=EVQcq54XaPseltNHezKK6uHUFG98huuTk6K/oA21FktEDK0ryzXhvYLiB2j/dqk0BJ
         VX6wgErWuZ2v/4lXJffp6i7c4gWdsIi99MY6JW8YAiDkPIwIh9w0YTWwcgcR/NBs2Sir
         vk3qb8BhPgkZIR2wpry+pCWcmODdo0MscRAP5/5VKD0qzYlm99Q0U+wJEaprNtuhadWV
         mxdy12qH1rsWfi84mvV+bb5iujEpf01ucFVWcVSv4zUK2T84nPJS4plTrCm7yqJXrqRQ
         mVBiHAIxv7OlCYs/ZJeCWuS2InhwrLwewderfO/6S1GzyFAWOYU8qF+eCMB23278AJ8y
         5MRA==
X-Forwarded-Encrypted: i=1; AJvYcCU5myFlG0iQmQa6AHJSAtGXJBlQBLAzRHHE9yi+//dpk8l1qaLKI0Qx26Cls4SsZvXIuaVZRpTvWO3BZB6G2nVpbWg+@vger.kernel.org, AJvYcCVeeFThOSrzhNCy4+Nrp4AN9/ZshXwQ3OvcyMIuxir06RC3sgIZk9ZTEPneFnDvAOfqjAVmgw9kfjicuOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfD1Ya+B0g8jHClG3RO6LK4T4vs3A9ypuZPseIeHaD9riC7g5
	xIG1S/JHltdAkjoeIujvgm8aF/iXOFnNjhd9W9b+MX3zshwtal8owWpd
X-Gm-Gg: ASbGncsp/ng1y/08PBB/dQhaB0yIQAdXf0G3AzM3XwxV08KOhBcx5ZQC/702j+AoJZW
	nszrzAuCGuDo8CpXCDIHulGL5bBMZrFyVvM9H6sa8VHeuqTX8LXHvcE3oTX8v2CC0b25oNfYHjT
	kP5QXXcYCIt9uJPVl+4eUzQar9I8O24yQYl2l+tfllfXoTCSnQFZrX42XOIzRoFbYvdFg3b36iv
	nd2HE0KDcHtXjx2yRb8B2zK/DAHUnEH9jQSh2h5k/O2K9SnYF7ZhVe98Bztio/3GfD4xTSZO7vf
	QYM2L4jrKqySTF5pTPZn3d15CFmVsDKXf8vmyPwzSW39Le5dGWTa9d27sUW/1NUSNfXxSohYFLx
	LbaJNgok55LVkvH6442mz3ZQHYFGCPJbc+g==
X-Google-Smtp-Source: AGHT+IF3xgcSOR7IQl6nyKuyM5+bsTV1yJleECFH4ZQXynkLUSFqvUWCjb4R/DqrQcfTlrIQi3kEfA==
X-Received: by 2002:a17:903:1746:b0:244:9913:2fe2 with SMTP id d9443c01a7336-244991333d5mr7043885ad.27.1755520118609;
        Mon, 18 Aug 2025 05:28:38 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:38 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 09/13] mm/kstackwatch: Add architecture support validation
Date: Mon, 18 Aug 2025 20:26:14 +0800
Message-ID: <20250818122720.434981-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-9-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
 <20250818122720.434981-9-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add architecture compatibility checking during module initialization
to ensure kstackwatch operates only on supported platforms.

Currently supported architectures:
- x86_64: Full hardware breakpoint support with arch_reinstall_hw_breakpoint()

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index b6366808e891..9f01e0222210 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -189,8 +189,31 @@ static const struct proc_ops kstackwatch_proc_ops = {
 	.proc_release = single_release,
 };
 
+static int is_ksw_supported(void)
+{
+	static const char *const supported_archs[] = { "x86_64", NULL };
+
+	const char *current_arch = utsname()->machine;
+	int i;
+
+	for (i = 0; supported_archs[i] != NULL; i++) {
+		if (strcmp(current_arch, supported_archs[i]) == 0) {
+			pr_info("KSW: Architecture %s supports hardware breakpoints\n",
+				current_arch);
+			return 1;
+		}
+	}
+
+	pr_warn("KSW: Architecture %s may not support hardware breakpoints\n",
+		current_arch);
+	return 1;
+}
+
 static int __init kstackwatch_init(void)
 {
+	if (!is_ksw_supported())
+		return -EOPNOTSUPP;
+
 	ksw_config = kmalloc(sizeof(*ksw_config), GFP_KERNEL);
 	if (!ksw_config)
 		return -ENOMEM;
-- 
2.43.0

