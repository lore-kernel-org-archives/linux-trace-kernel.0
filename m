Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0662472BA;
	Mon, 27 Oct 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570399; cv=none; b=Qd1oa+NQOVc4GHrQpR5Xxqp+RZ2afWbCe0iA6mSXrzSYHhCnGhAtrCx7mAc0YvSGezdXXaSGroN+lDNxkGeavoI8babTdFlXOuVwqPa97Hr5bZ3PMyViNIIRomcWUxVWBIvs4cha0zOCQNiW+dxl4EJ11Q80VEZLVxGguFrx3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570399; c=relaxed/simple;
	bh=1Ri9tuaEYe1o+uXAbO+nneWbFihzlLd5zFi/vArGwI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMN5oKXZit9z0sNJiJo9HQ26F2+Y4xcxQvtHavYQPqXMxEnJ4iHcQ4WSZMo5c3BxSwqw2BsqXQKzH5yde5XRKM246ZvmXXd/CMThYqXd1Ba2d5pmHfEOEXLfGdN5UvZWu9fc8bIBMLUrKX8pjBFvvf3490O0LaYdj5XHE0GM4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Xde0PFN1; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Xde0PFN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761570359;
	bh=B5duYsCPkK8oa0cCny8J8MEAD0ZkSluVzWoA9pUDJxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Xde0PFN1oI0O5ydpP0ZoRG2NJQQPtV7XkdZAk+3rINQknGQVRSr0oKtCn9zWTDSvF
	 hXPzLAy450RMr3MekFvhANVwOk8eXN6VibBwJPzbdGZc8XGK67mmHVMx8VHs/Sj0/d
	 TtNnpKTl8UuJ1H7fHTh577t9lXlTq2vudg9OJzbU=
X-QQ-mid: zesmtpip2t1761570342t3c4c53a4
X-QQ-Originating-IP: xn+d9YI6i5s0mfuGNgC+mIwtyxvbwxeqAS1waYQObro=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 21:05:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 107945356980905378
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>
Subject: [PATCH] kprobes: retry pending optprobe after freeing blocker
Date: Mon, 27 Oct 2025 21:05:35 +0800
Message-ID: <2B0BC73E9D190B7B+20251027130535.2296913-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NmbAG95z1FKVx867xqkdOP/zfVLXiVqAIR6jWlyNgLxupKVnpGBDY5Et
	ZGV0+fuKvjFgABzRLwLGvJHZ+suOjM20gV75AZQhmCGeOWN+pmxAAXr4RjMRbE0pmWhvVAj
	mUryJuPlLyoeOtjOsQU2dbwrPqWmxnDnNlJB+/tz5KT/LIeC9oGoBLoDKiTJPy1qpmpaxvF
	lY9QM1nBohsi7EMCKdXS7/bbd+oKm63+NlrM+xFLeJxjLQYCfnciFAv/QBgVau9CfXrMXLl
	vb291CBq3wynQEG5ii8wRBTZ6vSSkd7AKrBCgmuqOxbRzNVeP5nqhEdHF/y6j/etkc2BCOX
	iwKss1dYDx50fsK91SCte4pxsknzKWp4AgBgR3V1beiaBMydegvcoO6NkRy0dYcb7gKGAgA
	iEEh6sx/epiWBvb/SsAW/YGb8s3aWlBzJ/SZKoAw4SWiXcyi6RMxdylsD6NBhJwYmuIzN1l
	hhzXAEvIMqnsecWSGmp50RhNRmeQkqfdv/D9h/6XOTMN7K7lmGW5AvO9M0VMtx1lGAz1GV8
	R8Jfsyzuv7vY+7KMNzb5SUrXKzn56HO60S+fJ1OUbAm7e8FjBZ/omvfEILog8z71VVi5RFJ
	dj76ShMpgLj/pIlBDmS9akPZyiIXlOrPRl7kDLVqY8LAqQ7cI5UZEvBIejI9d8vVJHpkmKo
	l+KI6f+mmYAM74OQ4kinn+CmcgamQYVSZkn3VlRat8FTagtKlcOV3E+esDOSkpBGGb4KS4/
	jota5V4ysJX3+3jTcSNIcRPjoNBAL3drpnS+SFVF3VF1VuPFBo6aTfNBJA+uqynDD8zM9kn
	ijrTyLdALOunzykeOQeQd7Kf7+b2taa9eHS32r/KO8CHS12A+sIE8R/JTsSi7oF7CyrOsn/
	wrvopcoREYCENHWYwboKDYUOg+rPPbv7v29JGosBDR/y5P++ujBtKMdI2VCvfCKgtjF2pkB
	BU60EqH0oD3fvpZzaxwomrh+qpNyQj2irl+w0xeThZTkH1BnCValc6iJwZQnlwPp3crk+lJ
	lRo+/nstUcMc/FS6+A54YJsSjBgrW0Tl32CIn7wcNzbPdTjtlK7qQj7Ek4nkvwo5BqlTEEx
	AktnDou/wTnV6decFaiSzzU5Ym34EcIWi36REI5NZj9
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

The freeing_list cleanup now retries optimizing any sibling probe that was
deferred while this aggregator was being torn down.  Track the pending
address in struct optimized_kprobe so __disarm_kprobe() can defer the
retry until kprobe_optimizer() finishes disarming.

Signed-off-by: hongao <hongao@uniontech.com>

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c4f3bb24..33d65b008 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -338,6 +338,7 @@ DEFINE_INSN_CACHE_OPS(insn);
 struct optimized_kprobe {
 	struct kprobe kp;
 	struct list_head list;	/* list for optimizing queue */
+	kprobe_opcode_t *pending_reopt_addr;	/* addr that should trigger re-optimization */
 	struct arch_optimized_insn optinsn;
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da59c68df..0976ab57d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -514,6 +514,7 @@ static LIST_HEAD(freeing_list);
 
 static void kprobe_optimizer(struct work_struct *work);
 static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
+static void optimize_kprobe(struct kprobe *p);
 #define OPTIMIZE_DELAY 5
 
 /*
@@ -591,6 +592,20 @@ static void do_free_cleaned_kprobes(void)
 			 */
 			continue;
 		}
+		if (op->pending_reopt_addr) {
+			struct kprobe *blocked;
+
+			/*
+			 * The aggregator was holding back another probe while it sat on the
+			 * unoptimizing/freeing lists.  Now that the aggregator has been fully
+			 * reverted we can safely retry the optimization of that sibling.
+			 */
+
+			blocked = get_optimized_kprobe(op->pending_reopt_addr);
+			if (unlikely(blocked))
+				optimize_kprobe(blocked);
+		}
+
 		free_aggr_kprobe(&op->kp);
 	}
 }
@@ -1009,13 +1024,13 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 		_p = get_optimized_kprobe(p->addr);
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
+	} else if (reopt && kprobe_aggrprobe(p)) {
+		struct optimized_kprobe *op =
+			container_of(p, struct optimized_kprobe, kp);
+
+		/* Defer the re-optimization until the worker finishes disarming. */
+		op->pending_reopt_addr = p->addr;
 	}
-	/*
-	 * TODO: Since unoptimization and real disarming will be done by
-	 * the worker thread, we can not check whether another probe are
-	 * unoptimized because of this probe here. It should be re-optimized
-	 * by the worker thread.
-	 */
 }
 
 #else /* !CONFIG_OPTPROBES */
-- 
2.47.2

