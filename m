Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832EC33C8;
	Sat, 27 Apr 2024 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714186686; cv=none; b=AiJf0vUzx8r4gGbzRNinSnWXk3o+gURVvmhLu2Os8DUR/1uWGPvufdD5gVGUx/Jt2OWawxkfxJzK7VYGN1FH+kGT4UpGYh3A0UJ8j7wqRWi/xDjxv+RBkbRYvXyHMKzYq4FAhk5ZlFoPLIutwONZ0SMs3VJEbb9Eh8wHdsBnxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714186686; c=relaxed/simple;
	bh=xX5D+EAZ5Bpq4vJHf+wbm1BIbRo+WTB8OkrJBGaP538=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqLqGbV4ZDP0XLTNZrprr0AbelLEujfgmmcmDe0lBTYS13rbjymrntPmCisx0FvJ7Rd5ImdavNy/V4zW+372kr9IiM3ZdouTX3XcMlXENEUY4u4IjoHbKykBqPAO0y5zonIsHl8B161ZRhi/2Ib1FOiloFlIrG4WJfmaVrxAsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BoP/sU4R; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BoP/sU4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fy6C0
	g0qKGiiSklD9pwp4zCj85V4AWoPTjeoUY/osls=; b=BoP/sU4RpTOWtH/KEjmBt
	g57CBLUt2c4DSk1iP6y7chyxkX4gbzvdBcw2jXwAjLF0NIkSLIlVXvcgzKDdlwaU
	33NA4UojRde44TqnVE2JThjNWcAEyi497IecKTjSTpMpHy39m6+KwLOI2qwAesMo
	cP+OrcsInxt6mY4YZX+5x0=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3X1CSaSxmFuefBA--.58122S2;
	Sat, 27 Apr 2024 10:57:23 +0800 (CST)
From: lumingyindetect@126.com
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	LuMingYin <lumingyindetect@126.com>
Subject: [PATCH v2] tracing/probes: Fix memory leak in traceprobe_parse_probe_arg_body
Date: Sat, 27 Apr 2024 03:57:20 +0100
Message-Id: <20240427025720.1321211-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1CSaSxmFuefBA--.58122S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1fXr18uFWfJFyfWw17Wrg_yoWDXFcEka
	ykGa4kXr4jkrsrurW3ArsaqrWq9F1rWFy09a17tFZ8J34jkr13W3Z8CasYqrZ5WFyqqr97
	XwnxWr1v9FyrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU017K7UUUUU==
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbiEBzM9mVLbFus-AACs9

From: LuMingYin <lumingyindetect@126.com>

If traceprobe_parse_probe_arg_body() fails to allocate 'parg->fmt', it
jumps to 'out' instead of 'fail' by mistake. In the result, in this
case the 'tmp' buffer is not freed and leaks its memory.

Fix it by jumping to 'fail' in that case.

Fixes: 032330abd08b ("tracing/probes: Cleanup probe argument parser")
Signed-off-by: LuMingYin <lumingyindetect@126.com>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dfe3ee6035ec..42bc0f362226 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		parg->fmt = kmalloc(len, GFP_KERNEL);
 		if (!parg->fmt) {
 			ret = -ENOMEM;
-			goto out;
+			goto fail;
 		}
 		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
 			 parg->count);
-- 
2.25.1

