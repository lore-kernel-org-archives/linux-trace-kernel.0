Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077B1DFF0;
	Tue,  4 Nov 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232270; cv=none; b=Flu4tJE2vfa8a2iS0zR8rXSWtNLWEQpVF3lL2R6c6hkTzDawZQPp16QlL9lm4AiQP8PRm4vQmHfeaJ9Cp2litjYVfMjwQLX/cXtm1mlGpajwS3eZ0h3EZlRD9n1hoSO+NRzF0ZvzyDE6nb32dlqmo5GDiUtIg/mE5t5WvpIeYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232270; c=relaxed/simple;
	bh=CINvRsRn/Cl5sObyLZwIhUY3ZoPdcJ6V3VPzduSzFwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvoyqaNihkgFsDW/fVNCRRwwDvGaHUSZIvfmUr5GULz0V5vS41h+PW0Q9z6OLZbbr9nBrFyDANglF9bC/CCwY/dd/bJ+0U5zqTBSypa+jiYfQuTlV5L5TYnsJgJh/xhNu2V4XHWX+EhQvzv1qrOJM5eSaDyEGq7/0xRWN1iMje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c91cece2b93a11f0a38c85956e01ac42-20251104
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8fe78762-560f-4e92-b705-5ed91c0172bb,IP:10,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:8fe78762-560f-4e92-b705-5ed91c0172bb,IP:10,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:1b4c901fb95263d686a28f094659186f,BulkI
	D:251104125739V6UO0J4G,BulkQuantity:0,Recheck:0,SF:10|66|78|102|850,TC:nil
	,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c91cece2b93a11f0a38c85956e01ac42-20251104
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1906036543; Tue, 04 Nov 2025 12:57:38 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] tracing/hist: make err_text array fully const
Date: Tue,  4 Nov 2025 12:55:58 +0800
Message-Id: <20251104045558.1644671-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The err_text array contains string literals that are never modified.
Previously it was declared as:

    static const char *err_text[]

which makes the strings themselves const but allows the pointers
in the array to be changed.

Change it to:

    static const char * const err_text[]

This prevents accidental modification of the array pointers,
fixes checkpatch warnings, and allows the compiler to place the
entire array in the read-only data section (.rodata).

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1d536219b624..3be35ebdaa62 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -80,7 +80,7 @@ enum { ERRORS };
 #undef C
 #define C(a, b)		b
 
-static const char *err_text[] = { ERRORS };
+static const char * const err_text[] = { ERRORS };
 
 struct hist_field;
 
-- 
2.25.1

