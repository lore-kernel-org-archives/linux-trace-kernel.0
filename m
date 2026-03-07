Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72E2F7478
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Mar 2026 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853576; cv=none; b=SN6HjRoU7CiBPx2KUlxZxbmx1QznKyJRYkE7gizZ10LjoxPm5ZUR3X1YIECqTCMFwAf4XVvVzi2Z4Hape3HJmX1pfjrtKufGxheQwo0Xccbr8fIW4nqca6BLaZIyV+MUdBYECVw7idOtwrMjpixOGfCVb7troZIVo3LO/+14XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853576; c=relaxed/simple;
	bh=9lkriiYVUgAJAV2ygYKzZB2R1bi3LRMIzoFL2qTmlco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQGok6tQyqsLYWJQ5ABHEIDFGgdEpHe0mnwl4pNWRQ7gg2ID0+RzYRccYwB6xj+MMZpCr9d1K76X++FKRKfDZAzxKAoMEjdtgQn375IkF2fT9+VMeoQxigzb19WNZE+pr6snbt3Luhju1apQoF+HjGIeYbrekiibZ/B04nKE89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Vr4F1Esk; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Vr4F1Esk"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so12002624c88.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1772853575; x=1773458375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6h1s9t7Yp+cySizwvrH6v9eju/k8G5b2pZCpKQCBAQ=;
        b=Vr4F1EskDMopIjmYwE8hxEQcu1mR/eYPTszZJpYniivtLLsqECoAQyPWxjqnAKBFQ2
         xRlNlnp+ovgLV2CZDmdmLYbf5fitvjqH4qqYV37RH59vry2nhAmkvX10ngF83ek/bNzS
         dqpg1QeZfKqpLCd/JovpFKRo3GRnHSig/+hT0dMMKrkSBJGUI1sYG3lKE24cgip7IhDi
         aIokSfBJDtfRh+3bITWit9xL5Ryu76UqJ4kS8cT/dymAyG+THc83sGLPIUBHwGtILxMC
         K0i8e830xF/meYjdoaa33V2BXlKVT5L3LKhIZOBzXZ6FjKzE5+PpGRwmaWav0qi4D9w7
         dH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772853575; x=1773458375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E6h1s9t7Yp+cySizwvrH6v9eju/k8G5b2pZCpKQCBAQ=;
        b=qMsE6rb6vn7TELf3i3yyrukPA6DPw9qU0B80UTpDJM9nwAWFrG2w2OaFk0zAZyZSrZ
         wrSJp13SlUW3LcyH+OGbsr4xDwXSOdBm/Zvkd1UjapyZyFT6XsPFO4GJOWFMfjjLP0lV
         y1MBgpLe1O3MUacKJDS/Y+fkNTSLqhb36dwa0r4R8jQj9Wa21qZLqhUfIm4X3AR5wmXl
         XUfSUfPVIRYcc4UquQXDieS6lduZELQH6HsBGbV6yK0FmxoUtmSetuv2SQZSGBdZOHqz
         kQ0fzJ8P41ZUZWuqUhcomB61Go28TAWecVZHhdGNnSw58PTue59c0erG1syWWwrD+mpP
         Db9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+paR2oaNTP98bykBitcRENySYmdbJ//dHsUPAQ36l9c7yneJkBmzac9P+DpcFw5jZF9p8oBUOyNkCYXq8rNHIMuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5NQfS8bDY3oCeYepBWNwfXpxrhCcpGgTp/Bopj9C79heFAoL
	XAH4MrCNf3kOAXgM2uSKsznqvF1/Id1DDf5QoFaOxzedvgqJL8TZ1tbHa7i4egB0fqo=
X-Gm-Gg: ATEYQzy1KypobM4SFjOqQa41I40QGi/nZZOd30kfcwJqcnBrPn6S4cpn3AxzLCIaXLQ
	7+kONIUnOOZjID7wYFY1vZL+N0ItwUXhp8k2KalofFlrFtWwnZWUN78HB2gelF23eYPEg1e9Ei5
	ulLRfYqM/vwmpgX3XmxFuqUMy+FruHcFFBlnvjb2QvkZWpuawAaQFNF+CgY18Lmc9Wet0qA8ITf
	DjYcP/0lfYKFlvIffKE6HYnuWZCVARFseWOpoK5eiPlERaGBEeuBcz5Cnw4UXNijckty4tl5Xw4
	vNB20X7hW47p/amIrpY/orGTtpDhNIdQfbUXsHgqmsg4Ux27byjmTTrU3/1S1wynETZf1fyhGwu
	3jT5Hjgh3kLs05KODJxQxAr/o6LYS317nFjrQOgBbEL1Z4i/PhBBDdnV1a7nLA2SDG1QvDwdbxY
	DMTmthlDBMtqcZOt43QH8ZKl6LrA==
X-Received: by 2002:a05:7022:4399:b0:128:ce44:be90 with SMTP id a92af1059eb24-128ce44c056mr215530c88.28.1772853573760;
        Fri, 06 Mar 2026 19:19:33 -0800 (PST)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:114e:d080:2a5d:de54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3d423c1sm2402779c88.1.2026.03.06.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:19:33 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G
Date: Fri,  6 Mar 2026 19:19:25 -0800
Message-ID: <bff42a4288aada08bdf74da3f5b67a2c28b761f8.1772852067.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306213730.566b9511@robin>
References: <20260306213730.566b9511@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the sizing logic through tracer_alloc_buffers() uses int
internally, causing unexpected behavior if the user passes a value that
does not fit in an int (on my x86 machine, the result is uselessly tiny
buffers).

Fix by plumbing the parameter's real type (unsigned long) through to the
ring buffer allocation functions, which already use unsigned long.

It has always been possible to create larger ring buffers via the sysfs
interface: this only affects the cmdline parameter.

Fixes: 73c5162aa362 ("tracing: keep ring buffer to minimum size till used")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
Changes in v2:
* Leave scratch_size as an int in allocate_trace_buffer(), undo callee
  changes required after making it unsigned long [Steven]

 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1e7c032a72d2..ebd996f8710e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9350,7 +9350,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 }
 
 static int
-allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
+allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned long size)
 {
 	enum ring_buffer_flags rb_flags;
 	struct trace_scratch *tscratch;
@@ -9405,7 +9405,7 @@ static void free_trace_buffer(struct array_buffer *buf)
 	}
 }
 
-static int allocate_trace_buffers(struct trace_array *tr, int size)
+static int allocate_trace_buffers(struct trace_array *tr, unsigned long size)
 {
 	int ret;
 
@@ -10769,7 +10769,7 @@ __init static void enable_instances(void)
 
 __init static int tracer_alloc_buffers(void)
 {
-	int ring_buf_size;
+	unsigned long ring_buf_size;
 	int ret = -ENOMEM;
 
 
-- 
2.47.3

