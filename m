Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E701C8632
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656965; cv=none; b=fF3cl7jjRRV7YbKzowkapMKv7OTX4mmW1fILsPqnpwGSEqindIhNzKhCCb8OZiie48O0DFP8TCQtKc/CrFURin/iDkf/0Mk0PCi6E5wGjhbav0T3GRCB690zXtWONeEReHeZ8Z/D8eWk6nLCoKycFXhU9VDnyXJQT2aV57wtAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656965; c=relaxed/simple;
	bh=Vsu5Xaf2CfmWYXrEWUU8kTg6xy3/CnahfubB8AomyEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhrBAjs2T93AmsjmBECXWdK/UXDfK3TK+z5EpKjt3oxbk/Zi3/XnAcwSPmRQQ5NVDv1aI3sWR1tLGLyZRfTUAnHzLhW9WjrvXx6KD6G2cGLM1IqawqxDtH+TJYe6WbUmyR92v5pKe1DJKYub4fwViKrKR/VPKuaYiaat2eObowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLMetV01; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLMetV01"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749656960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkpbyMsiJRwWnx6iOR+RLlbhyzNlbJ3e38I3A+4NmfI=;
	b=BLMetV01lS4FXWjpoxALr+a7Mi0irlvKqYcAZBywjBIwgNGKzGMwf6SP0SwobrqhyTbR8H
	NQ/nTgeRdr9+LbZ4t/A+vxRUTO28kF4R6uvFYTrAwmTj5i/qgFhOAX9bHiICSohUcwmfK3
	WvRPHYKGvp0Puq6S/5gBm2Q5AFHG7m4=
From: Tao Chen <chen.dylane@linux.dev>
To: kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
Date: Wed, 11 Jun 2025 23:48:58 +0800
Message-ID: <20250611154859.259682-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bpf_d_path() function may fail. If it does,
clear the user buf, like bpf_probe_read etc.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0998cbbb963..bb1003cb271 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -916,11 +916,14 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 	 * potentially broken verifier.
 	 */
 	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
-	if (len < 0)
+	if (len < 0) {
+		memset(buf, 0, sz);
 		return len;
+	}
 
 	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
+		memset(buf, 0, sz);
 		len = PTR_ERR(p);
 	} else {
 		len = buf + sz - p;
-- 
2.48.1

