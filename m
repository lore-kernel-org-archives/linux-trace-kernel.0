Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F893D9DB1;
	Tue, 25 Aug 2026 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650489; cv=none; b=Wqzw6vf97q0miGyeiSKBD8qQ8U0GmMjZX0CTfmdCzRMlHBEbV89y+MkkAXeHUi8ubusF6Yy23cVcPebGv85LlT0nOQOaiRY38mCeYE5Ct6pDgzd6HzP7LgcgwIdFi0uqj2Ahs/oxYsUWIJv2F5HsNcwfe4fSk03Pmhc5qoBqIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650489; c=relaxed/simple;
	bh=UDYJRsAPl5fjz/VtHwbbxQfIjdEnUJVUfvLAT5IwNgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6HUMLZWv768YZagQKKxzPVLIQ9GqxEfmSvnh5Um7TJjh6U6LSedjj7M6Qw2n+OGqvgqcAUAvT8gdW51abbYVxyvPKzlNaxvgYgR/GooWZKeKJCSzhBv6f9toRZqDLtBLdL8oL9EqErpM9nCm9GpgUkgN8p95HX+uq6hRMkKgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3vTuuYY1qbn46Bg--.38096S2;
	Tue, 25 Aug 2026 17:34:39 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH 1/2] samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify
Date: Tue, 25 Aug 2026 17:34:21 +0800
Message-ID: <20260825093421.7377-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vTuuYY1qbn46Bg--.38096S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Xr18urW8Cr4fCw43GFg_yoW8Gw45p3
	y7u3sxGr1rAFZ7KF9ruFyDCr17A347JrWUCas5A390vwnxurWUXryjyasIgF4xArWrtrW7
	Zr4qyrWkJF45XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXeOJUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIKA2qNI67uqwAAsj

ftrace_direct_multi_init() assigns kthread_run()'s return value to
simple_tsk without an IS_ERR() check. When kthread_run() fails it
returns ERR_PTR(-ENOMEM), but init still returns 0, so the module loads
with simple_tsk holding an error pointer. On unload,
ftrace_direct_multi_exit() then passes that ERR_PTR to kthread_stop(),
leading to a null-pointer-dereference.

Check the return value of kthread_run() with IS_ERR(); on failure,
unregister the ftrace direct call and propagate the error code.

Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 samples/ftrace/ftrace-direct-multi-modify.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 8f7986d698d8..f339131654c7 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -364,8 +364,13 @@ static int __init ftrace_direct_multi_init(void)
 
 	ret = register_ftrace_direct(&direct, my_tramp);
 
-	if (!ret)
+	if (!ret) {
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+		if (IS_ERR(simple_tsk)) {
+			unregister_ftrace_direct(&direct, my_tramp, true);
+			ret = PTR_ERR(simple_tsk);
+		}
+	}
 	return ret;
 }
 
-- 
2.43.0

