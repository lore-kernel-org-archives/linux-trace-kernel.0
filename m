Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5183911A8;
	Tue, 25 Aug 2026 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650494; cv=none; b=TaqkN4wsO/qq5YCFwL89o62u1JpFULC9hTQgaajupmkk+EUvlAz2OAIOxjVzAU6eCPB0RfcpFirW5PiI7uj4PlOjs5CavpQPRfP875P98VAEUHhM/2uFYJqra061VY3NJFLtNtzETosOp3Yyfs44AbKmv0KO4PGyZWqmmGSqqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650494; c=relaxed/simple;
	bh=MYYAtIKcEDrWA8i/EN1vxPSf/AmntErOIHt32HAZyRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCZJtbA6eyR0Z7qxM46EsBHkNUWrQpL7mcu60JYmnJR0+b3MY+YEWV9uvnsrOgvVy+byQBOTWojKb1QUX5tnPrDl2Lj3LF72CCKyNyE3VF7EbfUZUYUbrht3MkSGlDb1n4e0xzG+panNZJW5quOWV/5mW/NrQXLOQPqvn0dQyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3vTu2YY1q4X46Bg--.38100S2;
	Tue, 25 Aug 2026 17:34:46 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH 2/2] samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify
Date: Tue, 25 Aug 2026 17:34:41 +0800
Message-ID: <20260825093441.7394-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vTu2YY1q4X46Bg--.38100S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Xr18urW8Cr4fuF45Wrg_yoW8Xr1kp3
	ya93sxWryFyFZ7KF97uFnxCr17A34UJrWUCas3A3y5Zws8Cr4UJrW2yF9Iqr4xAryFyrW3
	Zrs0yrZ5JF45XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOWrWUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2qNIA79awAAsa

ftrace_direct_init() assigns kthread_run()'s return value to simple_tsk
without an IS_ERR() check. When kthread_run() fails it returns
ERR_PTR(-ENOMEM), but init still returns 0, so the module loads with
simple_tsk holding an error pointer. On unload, ftrace_direct_exit()
then passes that ERR_PTR to kthread_stop(), leading to a
null-pointer-dereference.

Check the return value of kthread_run() with IS_ERR(); on failure,
unregister the ftrace direct call and propagate the error code.

Fixes: ae0cc3b7e7f5 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 samples/ftrace/ftrace-direct-modify.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index da3a9f2091f5..2795ea12cdf9 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -320,8 +320,13 @@ static int __init ftrace_direct_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
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

