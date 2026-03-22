Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65F15539A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Mar 2026 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774156728; cv=none; b=mF3B/B0/gSKvdUu1uSycWMIgGGfdXuec/6bYXfpcZhWH9BNhRFTfL8Yvss4k4BwKCztb5/he7xHJqceBzUp9lnS8QhfZRt/aoy8dgzGxzaVVHvjYK5MkCbRa9m02NPOi4kzpV+gM7yeczqUQATTzh5AaOOtQDcT3ynlaYWbejf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774156728; c=relaxed/simple;
	bh=2xaEnwLXi5eOBedz1ZoYUtT9EFWQuAofCjjQbziteGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqE4AyFV5uqEbI5Z2s7fVqz4zcHtlwX0iaXStTTlLh/F6T5KaAYcwf+JEH49G1t34T6fwdyGQijYnQrpI0rQpUtfviSCKphc/quFyqA3HJrP2mnuv8pIE+5SYO8f2atAfXFw/WBBXwyPtGeptqcJS8s4VOAMNF0IdeQ/9zp3I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2nXET5i; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2nXET5i"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35b95e21ccaso1817554a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Mar 2026 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774156726; x=1774761526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ2ydp5DIXGTbamssHDT6ki+K9ebqq0Fzx0VDSRMkzU=;
        b=M2nXET5i6kNiNvNqphgmOjSbm9EbDPiiPXICDQ6Hhfy7aEY5Zv5Xt/8zRXErNZSnTZ
         YRSjdHoxwRHVe+EsvB6q40LkohT/RBoJnWpv0Sfdh6wkDnw3pTatsNhxQHCXMc3CMdcX
         12MvACZSkhhBrDvKadkHeG/VF/G+g+sFlM3j82SdtW7tLaIbkdG+3drueuf/Xx31Nt+p
         hTS59ZodlEt08CKADmW5yd+UtsErc9MZiqLTy08dRxe3O29lOSKrCOdp3Sryr31pCzH1
         N7akmawhMF3V07hopbT4nop+t4msS+bgMh/7sSFV2a7u+UZBIolWkil/Sgd0mNAq/lIr
         w/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774156726; x=1774761526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ2ydp5DIXGTbamssHDT6ki+K9ebqq0Fzx0VDSRMkzU=;
        b=I68Ons/MWmYIJutzYT1F+RxHNLhBQrHNnCsSKNfHUq6BptiRh9Btnq8TaCBDGdJ5KW
         mFzU1h1O86T2CpZ9eUtUj921LbHqop/cwVDlSiPee8wNWiS1WwYva7mbxhXMLS4zeXSu
         rpQ+wF4FPxIeB+X38m1GEtZMEOdSjizy7ketBHfvjXnBl8WINctj0g3GPBWudZ5mVpXo
         doxyEwFi+bwiD8uhjvhxNIMhTICEcQi55Z1m03s9hQEc7D+1SmZXQdAWLQKrAXgv0vGm
         OxWeyo60PRmI3q4ZEdyBJ5bo7pI1hvCnrL9p6ARpddsLsVCtDW1PIxhpShfZfOEN7QaK
         rqRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ee99a0CP+2ZvO4rc0tDrd0A+Jn/i8XBJp3Qx3bSWtg7rQjKjadvtM2dqN6EVIoSX/SGSWtEMlbBprceaNga2rmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwQuZJINr6gs5k+yhatfT1KzxRgeQYI8Zu1Q47TspCf/0ww6X
	BVEF9Fb7clm1vgM7LpQ9pLHUejSyo9oxUEiMF721LBvl43u+1K0SSjKk
X-Gm-Gg: ATEYQzxsNmfOwK+Q61GQpFqP3Ui5yz4XfGAGxG3Mo28HRueegQP+Ew1s9bGx74RNGK8
	Cc/+BaxU3yWMC3A+FwynlOwF1tLrbBu8SuOCL81V7EIBEFSoJ8cUyp/iAQ0ZXkf7KYRpArSCvGY
	kE13ms8t5Ih/hP17J/3NHxxMvCd91CJA3WINw3PUpjQFPqn47x9zFeBIoqOLcglJc78UKk1thOj
	hZalro+tLogeKTV/3gtkJvqmRbtZiqklMMl8ohavVIChWiN9QcnRq/qxcm4zARViRpj9jTJaocc
	fIil03hi8afJlGShbsFpzaDp1x7uEYvMvLPWrPSDPDC3nbbKKj6c5nJsFZRyG5Jf82ngCRrdYKc
	Xr7f6SVSAxLZqb4o4ofzTJKqBYQBoQYmE7aLbmPo5078DAVmbAnht3q3E/Q19txGLwvBale/Je5
	clFa4WwISWN4DcWrGPBxmdi6wwW7mRr6vpZUmSUZWmUYuFBJpRdwDrzM4ai9Qm4Gu6B3AbyxAmb
	hBNwMcMzI3BhboQ/g==
X-Received: by 2002:a17:90b:3c46:b0:359:85b0:4023 with SMTP id 98e67ed59e1d1-35bd282e00dmr5496794a91.16.1774156726184;
        Sat, 21 Mar 2026 22:18:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:37b6:3d88:f486:a8ee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bf2sm5681646a91.11.2026.03.21.22.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 22:18:45 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
Date: Sun, 22 Mar 2026 10:48:38 +0530
Message-ID: <20260322051838.1137822-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_setup() accepts any non-zero buf_size.
If buf_size < sizeof(struct blk_io_trace), relay_reserve()
always returns NULL and all trace events are silently dropped.

Reject such values early with -EINVAL.

Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ed8bc247f231c1a48e21
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..6cc7d83ed1c2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
-	if (!buts.buf_size || !buts.buf_nr)
+	if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
 		return -EINVAL;
 
 	buts2 = (struct blk_user_trace_setup2) {
-- 
2.43.0

