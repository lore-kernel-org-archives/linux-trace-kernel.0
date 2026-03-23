Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34A3BED2B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281695; cv=none; b=Lhulc3Ge9bCfkpUE4KUE7V5aeYBaleVzkijwIlJ6TrqcUM0+3oY6JuhVmg4rqLdzTmg2cFW4xd321+bsl726rYSUyvXSSv5YW3sEUn2XcJoekd7YufhkjZFPJhZt6rgI6MewffT0o5LY15w8FSve26hg8W96xLtgR1bqd73bQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281695; c=relaxed/simple;
	bh=fyBJF0Rb3ojGG3W0enZR4zW94KIveEVLAnTki7iglOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgm7AXkJFmuFu2ntCH1MZYSRYl9ppg3V8iCaYeH1QgGtiq8hjPgt7a3flT36SmhCB3GO8TgoFJBWKlwRmyV3MNN1tkDjwMiykAPMziodxeBrFIibnFgPy30wAcyuddL/MgR9JCc5JIUxfwOOI7FkdXNgdWuyHnQ6dbOTyWY/Q0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Pnam4xV6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Pnam4xV6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd7284782dso22091985a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281693; x=1774886493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MJV3zFq/rwr+CUp0wh8JYL6rs7Ri2408vNUrLWuymw=;
        b=Pnam4xV6CjXEf/mK5NR+ZGus3/5VLgXXqQaofXV/G1FN+qBfwATWeVMRoBLYXeBGuf
         CP2JeCCGMCOZXqdmda2tnihSorDqrU1S11yeOizpwhAf69RJdf8Gp3doCRoKJZPngJCK
         ZOE7DWBYlaFQ4uS7xCFd6UntkxKhZud9amqiJq0IWdaf/YppFezMkWG9sHq2kpwYoYU7
         Xhmjna5X6AtrcLe5w2PoVhEDNQrjoKbf8YAwyi9CQv2k2vx+GeTlbbC4TI7Jd/wUXWst
         JB77WNC2kvD8SljQ/MJBW0Q1llkjBdkIkC6LByYeueWbfJispTGUtw8X+9ZWyM36ppX4
         zTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281693; x=1774886493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MJV3zFq/rwr+CUp0wh8JYL6rs7Ri2408vNUrLWuymw=;
        b=NmyTaKvwr/ldwd4faMsg8tAVZFWQJ3UWz4RRVnnHg3MEA7wK/b7yqil9z4LObNgnUE
         wWAPAuQFVSdIHkK4jDdHlpPPDXsWGpV7esbxdMUa6Ykpt1QOMQwk+t2hf8zonhkz27ba
         dakNMQAJs9djTheRGd1h7tI/B2Rc1y95mqL27EixUjFRUq2GIfY3JDLI1/tvGOJq4jrK
         ssm74+MPMupQM4kcbWM7EP9bXaikN1Wnu6eoalF57xTZfxg70/DTPXLmQqMd5TXBXGgJ
         UhtM2W9HfPitfvzYtTSeYIUsCTYMw+PPLOktJQlHLqLyae6EdyuT1CAEd3Q1d+K99nuo
         4msQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2DZVcj2xVmoTwWksKBTfocOvwccyI++uhqPLx2L08q7Emxko6pVVYjGcy7VWTFzVsis/Dk145DiN1uBRDwKxhzTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhWRYWxDJBH0A09uPL5NraTjZELh7VImj+9AdG6k35uoEVPfd
	ZuAkKeNrcBiHOVKsFXZxrS5RzP7zelxWbZqgiAn9GLjsDY3LEVzhU2NRj0ohGQNZsGk=
X-Gm-Gg: ATEYQzzXSgODA1ZC4nViy2hwR/xMMtY31bQApoD5FnP51KTXJyhdESkBYPBK8UhVvR0
	FtU+cJZDvfOJitAZh7Xw4V0NWVqL6NU9AAraOwQenq7AxAtLeM6FTQYDhkp3hSbyH7FumHogAkl
	0aWnoseDrwS1ZZYUKVV1OUVIBmgbQkmNph6UeA1z4OFAXTX5iqbrM8oJKKgbaG6ux9bGP6Uwwy+
	vY6MQsYfk0N4w8ADDS3VcAAHtG0jxqB/I3hdRHxA3dgvT3j2JpWxgtg1SGpWFhStIIYmfmu+L7G
	pmPBY9mdLrcYjKVb2Oj8Ov8S8CPsGO46F0yVZjF9bdozsCh4OudlbBx8UYNZN2IM0rlMlRdGi18
	iV6/eomAUp8yNQRigWdbGXy0NLnAKhTuyadN+33YdLC3FpOMbi9pBxNEMqslG6B53E9S95/YAvF
	hXKbrjJd5Pzav6sTzbR67EeUIQww6EJEdPD6T3qXP7YFaFMeGfDbE3miELTwAdDfnsgw==
X-Received: by 2002:a05:620a:f13:b0:8c7:a84:d0e4 with SMTP id af79cd13be357-8cfc7e9d63dmr1972995485a.24.1774281693191;
        Mon, 23 Mar 2026 09:01:33 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:32 -0700 (PDT)
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
Subject: [PATCH v2 14/19] scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:33 -0400
Message-ID: <20260323160052.17528-15-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/ufs/core/ufshcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 899e663fea6e8..b27bde8ea7555 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -422,7 +422,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
 	else
 		header = &lrb->ucd_rsp_ptr->header;
 
-	trace_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
+	trace_call__ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
 }
 
@@ -433,7 +433,7 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_upiu_enabled())
 		return;
 
-	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
+	trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
 			  &rq_rsp->qr, UFS_TSF_OSF);
 }
 
@@ -446,12 +446,12 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	if (str_t == UFS_TM_SEND)
-		trace_ufshcd_upiu(hba, str_t,
+		trace_call__ufshcd_upiu(hba, str_t,
 				  &descp->upiu_req.req_header,
 				  &descp->upiu_req.input_param1,
 				  UFS_TSF_TM_INPUT);
 	else
-		trace_ufshcd_upiu(hba, str_t,
+		trace_call__ufshcd_upiu(hba, str_t,
 				  &descp->upiu_rsp.rsp_header,
 				  &descp->upiu_rsp.output_param1,
 				  UFS_TSF_TM_OUTPUT);
@@ -471,7 +471,7 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(hba, str_t, cmd,
+	trace_call__ufshcd_uic_command(hba, str_t, cmd,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
@@ -523,7 +523,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	} else {
 		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	}
-	trace_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
+	trace_call__ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
 			     transfer_len, intr, lba, opcode, group_id);
 }
 
-- 
2.53.0

