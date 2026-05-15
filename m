Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFA2DEA64
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853608; cv=none; b=fTpOqneZ+/3ufFOQSXr2c9FHmLt8bsv7+yGeSiFW+I11Mu3mYLlrcShenpwZwu3nhc1YlVGSX94i0aYVwKG3mI8AixA7/mfti/OpdnAFHP3v0HuCvtIgIhXcGZdGPKRerZUet4W4lag/arUkBaOhNfxcEzU705yyCV0z6+3LZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853608; c=relaxed/simple;
	bh=Usz/B97VtrR110956ILatJ97eXmS2ovdzWIT8Ytpas4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSsnZJBgmzTwxDcIhfoaYvIpeSr715aAzH7Zh9OqLM9KiZS7JGG5qGr///P3rzzQx/mSZvCUDCE6NcGHYWm2l4ZRj2bO5KVDW4AVKVBBA7CleZXHXfI2qObM2eNG5r3xdut5U3igzzna7LeJNLigriI0tGnFJ9iahDN0sUuRQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=WMaeIiNM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="WMaeIiNM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9118b952e2bso201096385a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853599; x=1779458399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hN6SVRJC1Wye8mJdJNrkkfeZqabayMeuzoTHVMW80R4=;
        b=WMaeIiNM6UOvYj3aifenYcMghXhp9svTYwDyh4r7JIL2K3pqubqElUS0Uczu7YIJld
         Gh2XZwCE/GqywrP15U5/P8VTrMy/I9mKyv3txnGmWAFhENcLh0stbcp0EKTfc4KEGWYP
         Kxyls69ifAExbsneSINAPRyQwVfl4ZhT5LmVCmx/faRlHoup2zcuvVdhW1mMDFKqr7zI
         YD7Dxl5qHpzaVbpX5A6t+ZhzSKx2sZ6UW33fiF8OsVcmzn33L6ykN1y/1fPb/hF9JLAr
         Aqnwh+rKXU6exfROL11ssYOkWRiDva2JMYIpQNr5FPeZOzMIoVFEy0lWC6sRd5smCPfI
         mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853599; x=1779458399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN6SVRJC1Wye8mJdJNrkkfeZqabayMeuzoTHVMW80R4=;
        b=S7X35oPSJ5DJXHm899X0XlzdkcLpLDpAtBT537ev8vqCqFAP2VzopB/bfcEAH5tKBw
         3G3ZWGM7zFoU/C+tm/3lR54W2dTGewkbzjpIgA8sIYiJ95XT+xuFLA2i/8NQIaT7LVTc
         fIVFVuHwSH5dVPZt5ezr/poAlVdq5nAJ8S4oAWgstTS+1HtLjaNi1T4d0YO/VCGt17fV
         D8COBaA+7KYFsYuvdnRvQZ55zAs8rV28bHtNmuImvWVGpOOeCJFmJ+M4Myd8XPUbRBzF
         AXS9FSZHLbguEEaaR6v48pMcdHlru2VXKOqSVco49UzppIqa7B+11EitHLbgyqsyIFA3
         qKgg==
X-Forwarded-Encrypted: i=1; AFNElJ95e/gbVBuCdrBLEM57FNEtTqQhpyAgZFWKIjB1ZZcClosTVGYGiZ9cVua+smCQEeR5Jzm5QzLv08C5kMcTBFaZNkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wmxPA31Bpswga9Uv0+WvQA5Vn4DhoDc7AVwngdX4bZI4tbGH
	/7xxAeTSbsnA3p1dFXhrCk7J7pmwDYCF0iwdZUGTXPMuk85YZfnaa3PsJwXWDJvaylI=
X-Gm-Gg: Acq92OEl6B+HBu9IoYiGXxx29TbNmJzD5kLLS8CHaVIBI/aTZWMzMXgDTRI28vF2Q/k
	7FsxBYlxiZxxdcfkhkAQuu7phicuFgmjXRCRS7a3MP45sZowFIKOicJBPqQOx76VQmvaj50ih7m
	1RaZgVWm0i94DZDqoNyLRO9Iy5tS3+klxE2mpHgG+AXACm3vHFAZJci2T4iLYjyrclWGYrm73UX
	P0mEDAcVSg2+2NBYoRGnoD0Tvshv7bBsNTmRW2xmHNiJ3PZBBPSLiZO8q/BA0TyBvHxx17HH2Tp
	l3ZNcwwEE6TZjwCwVZ33SYcsyhvzrDdRrUM+yg3E3EuZSwtfAzyhKrVwG6edS7xh2KB0jUfCx+R
	Czc8q27QWLCbrM6QXxGKh5mz0p6h9ABXP2ShdtQ6ArnxG1CbIBuOqacPTpREzVWWce7YFMJknUl
	mHA3snbrV1QcXN3f5Py0TedgoKUeFH
X-Received: by 2002:a05:620a:4104:b0:90f:57f9:c934 with SMTP id af79cd13be357-911cc6ae514mr661068185a.23.1778853599283;
        Fri, 15 May 2026 06:59:59 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm543167385a.38.2026.05.15.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:58 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 09/11] net: devlink: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:53 -0400
Message-ID: <20260515135953.2238907-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 net/devlink/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68..d54276dcd62f 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1497,7 +1497,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
 						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
+		trace_call__devlink_trap_report(devlink, skb, &metadata);
 	}
 }
 EXPORT_SYMBOL_GPL(devlink_trap_report);
-- 
2.54.0

