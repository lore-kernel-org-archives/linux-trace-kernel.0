Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9030B533
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853601; cv=none; b=km4+wsg7Xq/VTdsWJdS/fPSIrGWbKhee9QQaeAuhKpl9I+mlisfbi37UjltrwXqirVEZzImfe6P9Lbly/YNgv+bEZnZOYBvznc/OGbLHmyYoPJeF9f6SwWu13w6ngMeCAaYVxPcXcIk5d8RteEpNydlnL2mWStF/9h7p+1fzBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853601; c=relaxed/simple;
	bh=b1kYvevH+ajEE6MrstReQxnYaz40xOpSACY3LJm0wsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxCLeSYOW9Pp7NNyyExMcpR3shAGcUXo24H6lPy9e/sakl/lP/sulqSxgbi3wCH1ssDIzXciYZTEmfq2J39yCzzZvR0vra44QPHQSc2TJ/ZrAIckOLNgJuxwZVo9iK7yqVZqOOFvVn+mipYGcTN+JL/8xsBS8RuCEOGz3aIv754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=dwUUgb6j; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="dwUUgb6j"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-911dfc86901so112221485a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853593; x=1779458393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mF62S8ulVvnT3KPDUypySvJO/oTH9erKA2nq+/SzcdY=;
        b=dwUUgb6j7G5fIIJq340ASR7DPS4HCHS/9tEjVobrQ9gPtTFfC6Qg4QlhcyaxMKT2/4
         EqVOSuhJQyQMEkF47oE7TK/F5DVeSwoUsuJDa+tIWZrpBdjWA2u18NYiP7fzHne2lSH6
         uH6fOuyiS3P+bkh8qLideuNIou0dRiTfsWPnGjqtf38przwyuem+8caGRJ0fsJw9eCyn
         CCowUhEsc0GgsTHDCXWaLj8LFf3Q/NN18lKWfvcXXQ/wR7j2IV/nmercv5oSYqntikXX
         tzrpy98dHNqxn0pCRhc0Dj6B1kpKQtFfnjjmj8o75ZrpXlt1iJeeJw39dQxu4n05LnL0
         iN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853593; x=1779458393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF62S8ulVvnT3KPDUypySvJO/oTH9erKA2nq+/SzcdY=;
        b=Wooy4Ntr5lqTmTak/jD2hxGpOBl9Mq5Xv65GqJ+vkZ4XVxlPKr3rQ9BEN7PwF5D0zG
         XwmevbwXPA6+gseHOOHXiyq5oFZLYzzVPS8RcI91CszkLmKHX9vPvMGJRIMESE4RGIf9
         5l5W8DK/pz12yxDLBV5LPT+/r1jg6kBXf2mXxYU8aRtli38z9y2TTb5k51yzGoI8k+GI
         Tk2oLCPemUDBMG/X0ZP3sZqUTt0VeWLy/4xel1mza8PsIA9SSmGkU2bekEHrel4KEME4
         cfw5S52xIqP0HeB2M1Ly3PQy2Yc79vyr+sIvwfWj8d2o82F1pFxQA8Hoi78y0SGQZIca
         6Vyg==
X-Forwarded-Encrypted: i=1; AFNElJ8B2mB/qpE9g0jKNGPqYRs1xB6ZvbgkOR/zUcFTbitcAltEZ92jOVdkmlUCZGgRUJVrPVq6TvAtS8RlQ9tzEWKGTI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCB1Yy7PjMkZG/pjRAHcEAM3FbhDOiYqC5fPEpAkkZ7NtvVHq7
	b6y77gqSd3s29Of4mfhwjvPjXYN3AFPUUTqAYyOci87vdd2ZwRUrsEZ/xQoJvL99sTs=
X-Gm-Gg: Acq92OHc4n2w6wofokjLgAhQiUfQ2RkbpxisycrFp1YItjVmwdQIVwhuG1RLG6QZ27A
	Ipy+eXTxQSrKNf4vBa+P53m9ckTE+RNlMQ7bnOwxFvIE7Fi6yhfQLmXJChIRgcnxS2zpkGnDTsd
	fegS6J08pq0Szyco9JkKU5Zvsckris/voIvPmwdTSyaM/H9IZ1cT5LNEmCcMb8/IvJYSyhrlQjX
	Ta6kpPVgYYzCFQctrleiOvBCfovIHGJphHHHiQqJpfq1uxYizsr9ZJsqeaCXg//kPBZU0cZWJDt
	zfH+HLCWs5I8x/K55jhrr+Q4T5DUiuu1aHCrEIH0FkrslT72MnSEZwk3b742vMuHXVNQp4ToGTI
	maJg+2LLY/WwNjER2EPs9iZ2qeD7/VR/eWfQzFg/Rl23MatU8EfWCj9wJp+rN20qxtysyWbiUZk
	T8sYcGuZ6iIkHCLGPV0i5crXjv9DZf1Ggsq8/LNgk=
X-Received: by 2002:a05:620a:2685:b0:90f:786c:8949 with SMTP id af79cd13be357-911ceefeb15mr654072685a.41.1778853593204;
        Fri, 15 May 2026 06:59:53 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc8408f1sm550564985a.24.2026.05.15.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:52 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 08/11] scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:46 -0400
Message-ID: <20260515135946.2238888-1-vineeth@bitbyteword.org>
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
 drivers/ufs/core/ufshcd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c3f08957d179..07f3126d2a94 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -421,8 +421,8 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
 	else
 		header = &lrb->ucd_rsp_ptr->header;
 
-	trace_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
-			  UFS_TSF_CDB);
+	trace_call__ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
+			       UFS_TSF_CDB);
 }
 
 static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
@@ -432,8 +432,8 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_upiu_enabled())
 		return;
 
-	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
-			  &rq_rsp->qr, UFS_TSF_OSF);
+	trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
+			       &rq_rsp->qr, UFS_TSF_OSF);
 }
 
 static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
@@ -445,15 +445,15 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	if (str_t == UFS_TM_SEND)
-		trace_ufshcd_upiu(hba, str_t,
-				  &descp->upiu_req.req_header,
-				  &descp->upiu_req.input_param1,
-				  UFS_TSF_TM_INPUT);
+		trace_call__ufshcd_upiu(hba, str_t,
+					&descp->upiu_req.req_header,
+					&descp->upiu_req.input_param1,
+					UFS_TSF_TM_INPUT);
 	else
-		trace_ufshcd_upiu(hba, str_t,
-				  &descp->upiu_rsp.rsp_header,
-				  &descp->upiu_rsp.output_param1,
-				  UFS_TSF_TM_OUTPUT);
+		trace_call__ufshcd_upiu(hba, str_t,
+					&descp->upiu_rsp.rsp_header,
+					&descp->upiu_rsp.output_param1,
+					UFS_TSF_TM_OUTPUT);
 }
 
 static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
@@ -470,10 +470,10 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(hba, str_t, cmd,
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
-				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
+	trace_call__ufshcd_uic_command(hba, str_t, cmd,
+				       ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
+				       ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
+				       ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
 }
 
 static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cmnd *cmd,
@@ -522,8 +522,9 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	} else {
 		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	}
-	trace_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
-			     transfer_len, intr, lba, opcode, group_id);
+	trace_call__ufshcd_command(cmd->device, hba, str_t, tag, doorbell,
+				   hwq_id, transfer_len, intr, lba, opcode,
+				   group_id);
 }
 
 static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
-- 
2.54.0

