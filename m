Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEE61FCE;
	Fri, 13 Feb 2026 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964185; cv=none; b=RZfv2pUHr+q/kTBBKJD03uDNzIGbksFezDBPOIshXS2Mh/9+BmcfRsNXk1QwCoPHysq8AHE57bbOW3moMVpfyBQqlZO2SG0I7Amip0+VcgQCMpiJWpzsz1sP90qrTuFkD0MuNrg5qkCzkl97HFkgA/Y0W+2aLjQdjx3/Zut3Iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964185; c=relaxed/simple;
	bh=c45EfB/jmLxOw9eh9sgRT7FxDDFwlqHFfn8hQWGR4o4=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=oaBBHDaaEPOtkV/HNYXrVMepurGORerxuKvtcW4oiS/D8a4r8PXXCcQYwtWUJbrEUd7NKQIiAKxLSzYB4jKLZcdR2211FLRAt232ZcNHDK/yP0rNwqEu26XEPsxAkIsU03U2vS3vPTeiwgEi0UhhQI4SPNMndMksNHaOHEA+qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fC2MT44yHz8Xs72;
	Fri, 13 Feb 2026 14:29:41 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 61D6TUq7016651;
	Fri, 13 Feb 2026 14:29:30 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Feb 2026 14:29:32 +0800 (CST)
X-Zmail-TransId: 2afc698ec4cc600-28146
X-Mailer: Zmail v1.0
Message-ID: <20260213142932519cuWSpEXeS4-UnCvNXnK2P@zte.com.cn>
Date: Fri, 13 Feb 2026 14:29:32 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORF0gZnVuY3Rpb25fZ3JhcGg6IHJlc3RvcmUgZGlyZWN0IG1vZGUgd2hlbiBjYWxsYmFja3MgZHJvcCB0byBvbmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 61D6TUq7016651
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Feb 2026 14:29:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 698EC4D5.001/4fC2MT44yHz8Xs72

From: Shengming Hu <hu.shengming@zte.com.cn>

When registering a second fgraph callback, direct path is disabled
and array loop is used instead.
When ftrace_graph_active falls back to one, we try to re-enable direct
mode via ftrace_graph_enable_direct(true, ...).
But ftrace_graph_enable_direct() incorrectly disables the static key
rather than enabling it.
This leaves fgraph_do_direct permanently off after first multi-callback
transition, so direct fast mode is never restored.

Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cc48d16be43e..4df766c690f9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1303,7 +1303,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	static_call_update(fgraph_func, func);
 	static_call_update(fgraph_retfunc, retfunc);
 	if (enable_branch)
-		static_branch_disable(&fgraph_do_direct);
+		static_branch_enable(&fgraph_do_direct);
 }

 static void ftrace_graph_disable_direct(bool disable_branch)
--
2.25.1
