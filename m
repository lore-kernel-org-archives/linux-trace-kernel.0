Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC12E974D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582934; cv=none; b=rFyZmk8/fjKfdw7gwI1M6RFeooqXT/AXFP8H/Xum2HIY1ROUHeFttQNTqRYNbbqGVFJzGjO8OovV5cYH8KTwb6zm5or/7TT266qDYBlZ+FYM2AHj3fVvH57CNbbF8zqloF0NPbqPDy1v4uns4T3aJNWEPRipOLVB/XcIgsCGa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582934; c=relaxed/simple;
	bh=Mp45r/jPvlcSK1qOY/C6zGtqlIBnj4wTsZ61ct0+uOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gUrumah7AOo6cxmPJ8y6Juh98mU4M2JFG77am9zNLWXPulCX6J+2ED1Hk9gql9Lxj2CWvsHA+ZjRxuec42Al2hzKcPNpy573soe7yV7Zd581Zmp7hBnAyfotu7Bc9fF7caqHoyUZTCsEpvzz4PVC2RHxEbFZAg58Ws4A8Ny3TMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kuDsArSR; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kuDsArSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757582886;
	bh=dWJ89d+fbqodxcYgOc8AAmBvCGBM2BthaHohj6VQREE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=kuDsArSRjnoHmH3I6wppKsmYH+ioxzQOJpOgv9uS1snjmMVzm6h4yC70/Ot61fD1K
	 T/EpFJSzZMMhClSthD9zfrhVXRk7C/OpkoUnAuppmSnmNNTXwELbZMaTsB7GDea7RJ
	 sxHmj1EsAUbXUAgNZ/p8ssWJU/VTt7NmOQ1VKdk0=
X-QQ-mid: esmtpsz19t1757582880tccd0eca6
X-QQ-Originating-IP: YWz2jP++ugeINqtVwMlJfbS44o3SqEpWTYecD7DXEkE=
Received: from LT-ZUANGQIUBIN.dc.com ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 17:27:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17811081378449642341
From: zhuangqiubin@linux.spacemit.com
To: mark.zhuang@spacemit.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove bouncing kprobes maintainer
Date: Thu, 11 Sep 2025 17:27:57 +0800
Message-Id: <20250911092757.2423-1-zhuangqiubin@linux.spacemit.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: M0/UNHhZ6hMGn5xDOs3VIJCkkaWevIUTz4mWjJ4HFS9+RMDO7tfUV5kQ
	Jn7igD/cJvjEQ7LH9cXHsYEBdWUpJSaCyNrx3qDm4+c7zAChxNuQWWXGsrNhMo/WQWLHxoS
	RxudW0TOs5zEy1nyd7PuviacuZSiPZW4dWDACRjm2MRODZHlVu3UU05ZhUmzyitIxejWxRY
	wJPLTVlGTAWzc2D9VzMdrPQ0nnHe1yE+duBOLx4bHE6brpzfPqNTRPtj8rjyIs0LJcBqZfK
	KQOLCG/D7p/LZ79Mk+jNwQnhUtlXlLs2+pEVaD/e2kTAzhBDRgOpd4Nej38j1G53OJuCSK6
	ss9Jidxf4r+isWIdJwOD7mLutsbNc5xrKniGu1LwJ318G6APzc0TgNOaN3CuaOIcJfM1KgF
	TIgM6iPQMf1eqC1BDOTFIdgv0gORVfd1wG3ZB6E1IKbn74+OUt4x0P6sts8FZtBsgR+lqAU
	1RpqyNtP+tvOeEnULIQEFAbGV3+IXsBz7mkHmQJwsq12hobEjHNwY07bpNz2YHZPlT+mVWn
	rGCCe+xrO1UfQbuiNAYqvLU3U/EB4j34KKJEJAd8ZT+U1NAvvZRKSegVpiQIYJtNVnC5QZw
	OsA5xcUXN0dQ77UTFYOXoRXXE9TIBsc5nKVrwpXPI+cd6rqtHtbSrY95qpUiLhBOAlBgvMc
	ZgVb47Vxy8q33h8rVNJQl+IGgSKqK4TWN5qyyCLxTcj1gQyEjYrO8Uvk4NDZ077CWaZy661
	EmJEuV5dMBl91XYaajVX7VldupVbtug5GKHIcCrfRfyGpm+xTCFSIs60BHRlecwb1G2xHQ8
	poLTDymy1Ag+nAQw0jasgqIADDRA5TlozIIRW4TDW/OSPCdIm4wu9uIP1eHeAHpKwRGGdVC
	2rDSz0yXUSZUPiG/iEd8HxWgJzBbCsDshzbX8s/O1rpWsaNnGEgQReEPEu1t/2GrDGkkomd
	Ssj2d4RV2BHQPLi8OiRd/Z2g21J4g+jvsuZK8Eex2mRV7AeonoGMrutkeE0SQdKP6f/vKHI
	bgGU8HiA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

From: Dave Hansen <dave.hansen@linux.intel.com>

The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
That address is bouncing. Remove it.

This still leaves three other listed maintainers.

Link: https://lore.kernel.org/all/20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com/

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..a2bc2bb91970 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13686,7 +13686,6 @@ F:	scripts/Makefile.kmsan
 
 KPROBES
 M:	Naveen N Rao <naveen@kernel.org>
-M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.34.1

