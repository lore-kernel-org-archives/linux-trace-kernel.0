Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC673CCFAC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327977; cv=none; b=l8Gq9soPAsSUOxX5wKm/vkjnGUVbkE6A9Zjv79V9E00C7Jruxs9ok0ecjvd6/4XYCBPq8lbNLGKawwFdsV5nB/hqB9rOpiYTude+gJ0DteJTAn0OEW+B4+XyYWfgFOIdRJbzIv3pYLos+tlpWcZrVEgKrGtjERVbST22ANgBBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327977; c=relaxed/simple;
	bh=lI0TYnvoKi4pehy9JuDAcQonsQmvRvw06Z/x8psH9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krWfCZ9vZzEJESwX0nDMRnML4qETq+IquOZ0QyfFWts29sMMjFGrBqXhzXKPRmIOyOGWzkWST1tp9g9CnJ6+TQabQcZUIYnzbKRBBoPEbooPG066tO4OCUljH+58R31jiPlwvZcLafXMPG12xdoIt3c+J+eWgXOGuS5cLxTrzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=WaqAXq9X; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="WaqAXq9X"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4be94eeacso1321059a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327975; x=1773932775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIGlZXy6UTg9/KP5MyIS6JK07WUmRvxPK1Y84veyjTg=;
        b=WaqAXq9XH2db1ulZHEymyLCeGplJvhq/hWoJtSDiH/bOsCD3oVie64rz6PPcwStDbW
         c39BLfzOzQnG25qxQHIofYymJ6q23X7fwnzv3Nkij5bT/+WLSeoQwYLNXkThZfMSoEnV
         1bTnCLdsrDvmgcaHxbleehs1+fIU6lcZkAlExhlUU6qQKrKurgkUNJQijTg5nJNghekW
         kcpZKyzV1LnVADWQwYf/Y3c/JbsizUGleXHZ6oSb5kznPKGsseopE2PweqfB7sVUPyCy
         jNMLzAUlUINFtvlMkTPdyd44lHJQ9pwKGVeX9MuXEHMxaoWgfEd6AjigfTxigEJTXgzK
         HNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327975; x=1773932775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YIGlZXy6UTg9/KP5MyIS6JK07WUmRvxPK1Y84veyjTg=;
        b=jx9lQ93MJkToNQAfg5x1r87+pnEblJ+HUwEgv0CG0PkvENkfrWG316Esj9kC6mHjBE
         LuuWBD2jmm4IvN3HBQGbPpttfYkt+bR5d003VBatrYc8Ghk1HNnqrtnplSyzJ6PJv6/W
         L97TS60OiCZfLVh2YiJpdgWEYZV5EAOZoN3WKdJ+jHCCDrAMpE0Pqs69+naI1kkdeW4F
         3zL0zHd9gq33qjTN/S6pAlqATU8GgUPp4AJnQLoc7bb+Q5d7zX5tdZogn9ScHjlTLegb
         Z1VBsrZI5CVyiXyX9lPIbHg/cYGR+ss4lh8yKU4rNonybxvQv5bqIP7y3CTkJVjZSO5D
         fKRw==
X-Forwarded-Encrypted: i=1; AJvYcCXg4TULdfFgxg78EExPBlqEBdIsRFvLNxBmvrdC5efG+5gOxhRDRWipz3kHApM8O5zapYFomIyEOheIJAgyTb8mUb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWVXrvCGR3ATLb+ce6TSdZWmc2D5KxhwBhHTAmt5OoI50ar7k
	BEqSh+Dv7VCDPOSXCioVSMce828eyVtdfCwzwwNSBc+rHQuaOS3a/otk4EK2v8BWVmg=
X-Gm-Gg: ATEYQzy0AuwQJ9+qWCQziXGh/sG6R+C1SdfvfEtGWrHUmK3JrsNinZK18Bdiat5YdYc
	TyClnRb991eYSuCtwsuxl+439pF4EuDwW64ICge7j1cop6bHmydnAWiE/5ze3Q3HxyYpSfpqNBL
	/Ptuxa2U7/oC1RTBeV2s1h5DR423xhfwaQlAAi7vEbffK1q015eATUzeatGWLyDhRRzWIVZxVeZ
	iyeSoWZnQ59AOSOzvvgNMs41doLwfJ0+mF15YkLbUvI0Rc9BCvVrjR3QmCvXVEZ8FRsIHKbNFGW
	sxy1T48/ZDCUQqP7W0hPDV/l3ZOD45BeBT2mzbCaluG3o5PyJtdKKYTSZYqj/lrypJjjbzoddFd
	qnda9WKMxe2KuixdeBWW0EH0TbsmwbT+nfh3kzWE/jeDgGEF4ur/yOlquW4jeEiS3JaO5TXEoOU
	b+TpRdVPGrQRM+VTlyp0s29G8i7ttSd3qpYIOUno8JG1BBexJQR48SCSYA6Tfr3SVlxA==
X-Received: by 2002:a05:6830:449e:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7d76a7c9c32mr4484350a34.28.1773327975307;
        Thu, 12 Mar 2026 08:06:15 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:14 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bean Huo <beanhuo@micron.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 14/15] scsi: ufs: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:09 -0400
Message-ID: <20260312150523.2054552-15-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/ufs/core/ufshcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 899e663fea6e8..923e24e7c9973 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -422,7 +422,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
 	else
 		header = &lrb->ucd_rsp_ptr->header;
 
-	trace_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
+	trace_invoke_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
 }
 
@@ -433,7 +433,7 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_upiu_enabled())
 		return;
 
-	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
+	trace_invoke_ufshcd_upiu(hba, str_t, &rq_rsp->header,
 			  &rq_rsp->qr, UFS_TSF_OSF);
 }
 
@@ -446,12 +446,12 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	if (str_t == UFS_TM_SEND)
-		trace_ufshcd_upiu(hba, str_t,
+		trace_invoke_ufshcd_upiu(hba, str_t,
 				  &descp->upiu_req.req_header,
 				  &descp->upiu_req.input_param1,
 				  UFS_TSF_TM_INPUT);
 	else
-		trace_ufshcd_upiu(hba, str_t,
+		trace_invoke_ufshcd_upiu(hba, str_t,
 				  &descp->upiu_rsp.rsp_header,
 				  &descp->upiu_rsp.output_param1,
 				  UFS_TSF_TM_OUTPUT);
@@ -471,7 +471,7 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(hba, str_t, cmd,
+	trace_invoke_ufshcd_uic_command(hba, str_t, cmd,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
@@ -523,7 +523,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	} else {
 		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	}
-	trace_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
+	trace_invoke_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
 			     transfer_len, intr, lba, opcode, group_id);
 }
 
-- 
2.53.0

