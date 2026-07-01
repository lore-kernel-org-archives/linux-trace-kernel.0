Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441648123E;
	Wed,  1 Jul 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909358; cv=none; b=PN1rMz2XWGlnrOd8bOPW7BuHUojvHRQCWo0ejK0ZJhW4zRPLZxmaXkptg7Eqj86KFHm7ppYRgp+31zcNKF/DyGeQBBBcVsZzQkR6DXKtxg4gSHJ7WtTQB0iXXZEJM5jvZ9GS+7qe/HIM6CukO45QStbdL2stPfT61CdjkQaQy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909358; c=relaxed/simple;
	bh=R0ipzrHtpL9cmT69Li/RmN5LsEJBhMPUHcq/AnLj8mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/DAwhFzksuetYPdLc8ykCUKTuOPLI60bRv0dHJIiZQt0ERe5BLX+39nHPR8uYQER9UKJWpZ0VqyaEdKOd+jyY1jzCe0ioCjUBtcDnLk2grvsDr3ZeYQy27F+yGGA177JGxvYBd4zlkq551SHzM4NsPzqTstTVamFeiukrXUwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6168b682754911f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:eb5e5562-78c4-47ad-b065-71750001be0b,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:eb5e5562-78c4-47ad-b065-71750001be0b,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:d8ac4425b7d5eff20ed6be87001237d6,BulkI
	D:2607012035482P0BXQIA,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6168b682754911f1aa26b74ffac11d73-20260701
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1496782800; Wed, 01 Jul 2026 20:35:45 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH 3/6] selftests/ftrace: fix spelling error in poll test comment
Date: Wed,  1 Jul 2026 20:35:17 +0800
Message-Id: <20260701123520.271580-4-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701123520.271580-1-wangyan01@kylinos.cn>
References: <20260701123520.271580-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "happned" -> "happened" in ftrace poll test comment.

Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/ftrace/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
index 53258f7515e7..4da86a20dc85 100644
--- a/tools/testing/selftests/ftrace/poll.c
+++ b/tools/testing/selftests/ftrace/poll.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 	}
 	close(pfd.fd);
 
-	/* If timeout happned (ret == 0), exit code is 1 */
+	/* If timeout happened (ret == 0), exit code is 1 */
 	if (ret == 0)
 		return 1;
 
-- 
2.25.1

