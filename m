Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793432156;
	b=SPIb14q6L1D8sPTxTtK+gLajJA0BUlf2SR6COunp+v2l9Bh80IcD9RTvS2pv4mvr32ID
	 yPqbN/h9VDkcD27F67kU3XFsfS3jCD31gr2dSr2Rwt7iXfqsqzUbKRZEoMYK1U5sDTKn4
	 pSYY68qA+lnIjGjcRbFrXvBTkpXO9I910pDEGe42Uv6SCIC5unOEAEosU+fs02Lw+hg7i
	 fXRkH7jIpmTJIuglY/Li1e1ho8Wk2CLSq/vCUcvYZf1V86LdcoRAne5MZwqsiOcEk2mud
	 +rxn3Dzn70McHoHPuFcO0B1QDm6PRVsWDQ/REwdJgwPzUOM45iyfUaSPCU3N4Z778tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793432156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
	b=hYY/1HT8BtMDamS8/02y1dzpccgr6wXKIV4Q4dBzj7m4IHlaPNsrAFxDvi7KDsylK0bQ
	 ApRrhabmBza3Atn8LxvKoYKNec0bJ1olLAZLpXRY7BKzgispAs4kloi0umD6qt/0yzOys
	 04y9ZMXvoZwWCcKFHHsUMe5nlW5mgeXRwgl8g7XQBugIh9KSDs389OpJRnv4XF/eEpUUh
	 OmrJM1n8k+358j45kXuvCO2zqCEa3dcUNsFzqXZ0Lv9b1Acqh/nTQgyngccCzXaAxAT8p
	 qTHblda87k2Ifhv68IDiR5Kz5D6oxU+ouYr3b8KO/DLMQ4AbL+Ll6K1gPcW1CTpzVbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvKOnNCy;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C58606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 07:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C58606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvKOnNCy
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so618773a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793432155; x=1794036955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
        b=SvKOnNCyFstvcC9D57o0R6N7UChcOOFDDSKBMGmzKSZMYaWEPLwhthA5qCBMuRT0hs
         8Q9hOT4Vxx95cknrInA1Z8kNyA2UmISo9OONbtK1JgolMNARnBRcW8KRIhfpPshYU0ms
         TXaM027a6jBuHZkG1Qga9X1F20DTFfOBBGqZayDyosLbvChxAb4SSCMVICfaK1Jf/+Q0
         SrCerN8m4BR3FpbeCuWLupxdTjru7XTAwV1yTWkVg02f2gQVcEDEHtTTLu8zaBtSNrwD
         CVDq/LM6McTGL8FuxPP18t37Wb0QqkTj5uVCiVxw4QIJRi5Ey5nGHtq+hrWDUbYFC+O1
         Wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793432155; x=1794036955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
        b=eW+Quu7LI2ij0f8WA4PFqt8hiQ8JA3ZnKvP7CZGmsXLyEGv0rh+Z+vUu/Y+D3xumpL
         rDhA/Fh/Ku5gSbI62PvIPzq/ocwnQrdMljxGgrSyGPkwXFYHapqDJVEEMK4ScPoc2kod
         Em98ajeSu4TSSXn5H1LeLxCExVCbZI7rXCkyi9aL7V3AY9VRw+IYYJRHIyOUV4XgcSIJ
         eFk7Z/4/mQb6LxH5idYUAxxQqc5rSCmcmj+104pdObq3KNvwuyWyq7XQT0tEg7ZbuZ40
         LDf75kW9heaRa2Cd6JkMNk9joL7Ve3CDU+ycFPyLo9Nn4GHUoS2arTSPAdUt9984Y0QL
         6sog==
X-Forwarded-Encrypted: i=1; AKwUvBxyH6mtQ2kFE/3u5PjO9Z9vv40+n+uDBY9kaNxRP+53QwsBO52dMkATnK5sNE4yW5Fz3txwduCrfDcLh/5hq1ibEsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFsTOZAYOIAm3Q0H6kRoKPrg+hHca4Qg6oi/5VsqKSkpAX8Uer
	zIKK4wj7q6T8fwoGzRNqIY4OYs6WJtB7KDL97W1XpRDcq/ZVzpppCTFlUy4CidmdCtA=
X-Gm-Gg: AYBFou1CFnudyI3w1HtO9RlnR6V80G5wXVRsuA0xHU501Cv8PhoHi6jI6ysfbR5Qmph
	CyEhqHJjX1gZT3RESGLqh/m0c+M149NGr+d0EeGax7At4oAuw138+1mcBUXkxkD/zZ9MuYwRbtL
	bid2nYuYok8j2il3J2rWKDL9SzyjoV9uEMTcS31hPZCGz9Srtqc4+jUYmu7nVkwHMjAD712FcQt
	pVn7FFZKsfhfBd57b5As61wkXkcYdLRrnMqBb9it56dyuzJzIHHm9ZMcqU5xLYbpHx6Mx8nw941
	RjKMhseGOBVUbRc/YNog1lRZUxq+lCL96PdmMx1aB6bH9sUUHCK43BnrBw1j0PegoAVIUVgg0+G
	otoDmu3NY+SzxYipyzsf/B07ktvC6d8kZd2tde1KcJ2uAVvjyGlWEieZ3ezj4aQTw2JlKEbWjuG
	98A6tAwgR7v20Ndn3n2O6xiFH3KHZMwe2dUz+1pzwK6X6q4U0W8LyA9xOKaU5Qt1tRw3shVXzme
	Szh+GIX4wRtD7qQ/Ls8Pc281Vk08SMPqDcpuf0QWjJLz0p1VkqVDWxJnqVnBJVMlBh10XWYcpQZ
	puh7idZO6kwWnGq27+UwytXC2a/Y
X-Received: by 2002:a17:90b:3f84:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3ae897a5c4amr3793495a91.41.1793432155390;
        Sat, 31 Oct 2026 00:35:55 -0700 (PDT)
Received: from localhost ([121.128.153.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm6942497a91.9.2026.10.31.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:35:55 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Keep copying markers when one instance is stopped
Date: Sat, 31 Oct 2026 16:35:45 +0900
Message-ID: <20261031073549.2991066-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When several instances enable copy_trace_marker, stopping one instance
can prevent the remaining buffers from receiving markers.

Continue copying text and raw markers even if one copy fails, and
return the last error after trying all buffers.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
The current code stops at the first error without trying the remaining
buffers. This patch tries all buffers even if a write fails, and returns
the last error.

Returning either the first or last error cannot report all failures.
I chose the last error to keep the code simple. Per-buffer error
reporting is outside the scope of this patch.

Please let me know if you prefer a different error return policy.

Tested on x86_64 QEMU:
- Setup: Enable copy_trace_marker in multiple instances and set
  tracing_on=0 in one instance before a live buffer in the copy order.
- Before: No markers in live buffers after the stopped instance;
  write() returns an error.
- After: Markers in all live buffers; write() returns an error.
- Existing text/raw marker and instance selftests: 6 PASS.

 kernel/trace/trace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..bddcb35835be 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6316,6 +6316,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
+	ssize_t error = 0;
 	unsigned long ip;
 	char *buf;
 
@@ -6346,14 +6347,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_marker_to_buffer(tr, buf, cnt, ip);
-			if (written < 0)
-				break;
+			error = written < 0 ? written : error;
 		}
 	} else {
 		written = write_marker_to_buffer(tr, buf, cnt, ip);
 	}
 
-	return written;
+	return error ? error : written;
 }
 
 static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
@@ -6397,6 +6397,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
+	ssize_t error = 0;
 	char *buf;
 
 	if (unlikely(tracing_disabled))
@@ -6425,14 +6426,13 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_raw_marker_to_buffer(tr, buf, cnt);
-			if (written < 0)
-				break;
+			error = written < 0 ? written : error;
 		}
 	} else {
 		written = write_raw_marker_to_buffer(tr, buf, cnt);
 	}
 
-	return written;
+	return error ? error : written;
 }
 
 static int tracing_mark_open(struct inode *inode, struct file *filp)

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

