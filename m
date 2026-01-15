Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5E23D2A1;
	Thu, 15 Jan 2026 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444742; cv=none; b=lQHhvx3/U14ahHmv+GGl2KVHOWdKZZjvv0KPMjT+22gzq+8hOVWwUTMFRC8kw+omsw5uK6rpZs8CVcYPWhLqsb5+TKuO2Dct9Lu3hznHiWfRw8QDHSEpHoowM1+pjW5vOlKe57GahyOG3scIuboWH7bTyDHHkliBicleScwL7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444742; c=relaxed/simple;
	bh=AgVdORcAqSdvYdD5ALJVFGE+CLTnXPr/Nqcf9Yh6R2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdPRjOaJTxjYyWLF171m/bpOY2YxOddaHj7Ufz8emZiaSnkfjkwqAfm5thQodQWDVYmS3GAb0V8tQVXpQAYkdbIuroGe/A9ecHafF2ooOp40GLSlXo7w5bWjsrOcl23SVWbCCkFh2mWzgSB25C9PZbrJb/7ptiuXmXynicJwwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PjjyRerh; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PjjyRerh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768444715;
	bh=EvLBWkRb2wgPGI/J+5N2mUeyCwEUFwuQOmixZy4qA7k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PjjyRerhPxYFMPP/1voiFcpJqInwuqdmB7YF2u++d65+Weh/EkZbDNsUinYHGX7kL
	 YxExIKrYg+pmraSkgL4KbA36uAzlpPZ2Cl/ywSJN5fUFHLeL0CNi5Rol0rPcjk5Tqh
	 Pag6lkHxs/DCVfdmDRCYXzEaxk9Sima8FHk9LUEw=
X-QQ-mid: zesmtpip4t1768444698t42c3dbab
X-QQ-Originating-IP: jWEKade8SKFrFLUjTU0ock4mBIoI6XfllYkDNmFnZtI=
Received: from hongao-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 Jan 2026 10:38:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16584296869402968177
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: mhiramat@kernel.org
Cc: hongao@uniontech.com,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] kprobes: retry blocked optprobe in do_free_cleaned_kprobes
Date: Thu, 15 Jan 2026 10:38:03 +0800
Message-ID: <349359900266B25F+20260115023804.3951960-2-hongao@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115023804.3951960-1-hongao@uniontech.com>
References: <20260105135800.1f9f05ab5635e2ab85a2f2bd@kernel.org>
 <20260115023804.3951960-1-hongao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OGRTx1KypL8CTgW6Pl76mYK9RE29tjpyTYRMsY1gOh3/V2i6I2RDm7kj
	Xy46cRtH065cVOePDipS2b5XhFDi8SI43wXSa0TmzaHG3YuXtiBr3hD387zDzFuJ/4aKhyI
	JLmQwSFveVU69DVfJlmxzzDaON0goryxTocbMXYcPjrsW7P2+dT5a0rkyIsAynw6WY7Tf7q
	oHoKYGDoB5OGMEDyg9UEPhQpUPqu3KUxyUky7R3+hu6L1LMPd+OY9cdPIdfm4N+48mck/Ey
	SfkkGP7/oYPqWahr28rVQF3JONpuWZHMuSL4GUdUKQs9VQxxgOmoxC6pqUohPtFvAwkTwhE
	oix+001hkssjcs3NzbrPXx9YhHDXhikajk7RqF1YW90rAzxc/cU/o+9bX1O+GzXAVZv9Jrw
	mssSDYqdESHVJ9clm5oke69p5/NJmmOqQf2Tobk22+bM2szAk6xL7qL+Q4SZEt9zsjRHuol
	+A/16VULEDN/VL2tmXDD8RoCArlkrnUxtZ8KQVlwgexdKtTZEbTYWoVbiPy+leFhru6wECQ
	uHuialf6fJm3gGNqOs9JEFtYM5gd5l9kzTg86ijEdV79G5KLdgZv3VXY+klk8HCNVBbTP1Q
	apruIGFcfU+sywh3pICMJroseiT2i8cRhVwKnvsrBOCVZ7oAIlCMKEXsUXVhoHW/jdy8RhL
	ADNTGYlHe/LCLRHtI7p8TT4yV4mzrWTdn+Pn4HygD+ninivOnRgQyPlgAOs/E0jwAX/1Hnn
	R8TwrGkel46uSzrfpHEY5WwmuZFUwXwsQ8EZycBDfifPNCfCmruUFx9CovzjqtG4J4svPvS
	0Z9TcOEW6GfMr3emHWUTwjtTcRPIAQz8ji7mmBeI5VwOPmMBsfNkheYf0pHyEZvEdAOYr12
	tnv0VEMMudUm3CjxvqdxCRR/t/7kbzieLbpcpLrRtkHWpMpObqVpaH/EJuwxvndfYGo0e2D
	Ahto8hhisRxhpAMtS5jAIKz5NXzgNnmi0oJ2FaquVAGnD0T02ALE2NeicsbVihCN0zhAr5c
	0YZU7tCHgU7pt2GM8SxmeXtuvl/GU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Once the aggrprobe is fully reverted in do_free_cleaned_kprobes(), retry
optimize_kprobe() on that sibling so it can return to OPTIMIZED.

Also remove the stale comment in __disarm_kprobe().

Signed-off-by: hongao <hongao@uniontech.com>
---
 kernel/kprobes.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..1bd84d3b4817 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -516,6 +516,7 @@ static LIST_HEAD(freeing_list);
 
 static void kprobe_optimizer(struct work_struct *work);
 static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
+static void optimize_kprobe(struct kprobe *p);
 #define OPTIMIZE_DELAY 5
 
 /*
@@ -593,6 +594,17 @@ static void do_free_cleaned_kprobes(void)
 			 */
 			continue;
 		}
+
+		/*
+		 * The aggregator was holding back another probe while it sat on the
+		 * unoptimizing/freeing lists.  Now that the aggregator has been fully
+		 * reverted we can safely retry the optimization of that sibling.
+		 */
+
+		struct kprobe *_p = get_optimized_kprobe(op->kp.addr);
+		if (unlikely(_p))
+			optimize_kprobe(_p);
+
 		free_aggr_kprobe(&op->kp);
 	}
 }
@@ -1002,12 +1014,6 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
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
2.50.1

