Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BC49362C;
	Wed, 26 Aug 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709057; cv=none; b=efYzJjP3QHHCCnvCUV7yXgQTJmc1yT5DDrdei6wBS2M6R+osLP8Pt23eE/k8NfpL/cRlWACwLRALzkPJqhaKf4V4dytqkbr09oBzfBNb97y+ps1eTiV1OEpPM1F1YcavhVXFXRHs7qKWiFu5lYesetR68ei6DZbfateyYR3Hv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709057; c=relaxed/simple;
	bh=9FmTLGbwPOSWXwTOimREj523u0JvJkLMeaGZ8fP0afI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxtpE307eCgknmPmP5Ep8FgzDjiPgJluqBqSCXFqpcAeFm4whlK9avUisuvJhxpBci5k7xud3eOcltlqfVdXY8fisFaJSC9LZPRzgrgOfD+EJ40moXm/jlWCbx2cd6er7z5C+vPE1TX4V5tdZSZBgebRkTo+vdascoyvHvDWhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvPByRo5q2E2QBg--.13826S2;
	Wed, 26 Aug 2026 09:50:42 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify
Date: Wed, 26 Aug 2026 09:50:34 +0800
Message-ID: <20260826015034.10755-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPByRo5q2E2QBg--.13826S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Xr18urW8Cr4fuF45Wrg_yoW8AF1fp3
	y3u3sxKr1YyFZ2gF9ruFnrCr17A34xJrWUC3s3A3yYvws8Cr4UJrWjyF9Iqr4xAry0gFW3
	Zrs0yrW8AF45XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14
	v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjfUerWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRILA2qOJHVrAAAAsN

ftrace_direct_init() assigns kthread_run()'s return value to simple_tsk
without an IS_ERR() check. When kthread_run() fails it returns
ERR_PTR(-ENOMEM), but init still returns 0, so the module loads with
simple_tsk holding an error pointer. On unload, ftrace_direct_exit()
then passes that ERR_PTR to kthread_stop(), leading to a
null-pointer-dereference.

Check the return value of kthread_run() with IS_ERR(); on failure,
unregister the ftrace direct call and propagate the error code.

Fixes: ae0cc3b7e7f5 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  - Simplify the code as suggested by Steven Rostedt.---
---
 samples/ftrace/ftrace-direct-modify.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index da3a9f2091f5..246a8b9b22ce 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -320,9 +320,15 @@ static int __init ftrace_direct_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
 	ret = register_ftrace_direct(&direct, my_tramp);
 
-	if (!ret)
-		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
-	return ret;
+	if (ret)
+		return ret;
+	simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+	if (IS_ERR(simple_tsk)) {
+		unregister_ftrace_direct(&direct, my_tramp, true);
+		return PTR_ERR(simple_tsk);
+	}
+
+	return 0;
 }
 
 static void __exit ftrace_direct_exit(void)
-- 
2.43.0

