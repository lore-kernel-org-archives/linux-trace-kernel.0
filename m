Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCA3EBF0F;
	Fri, 13 Feb 2026 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950070; cv=none; b=uILBfL3jtKDFqeGk6Bdrh4qfdnmf5jIFP90a7ak4ixgOSLAF5Busl6ovkJBmoTpZoi7iRuwSiz5vwl6BDCuUk7aJn0JDRs/pfjexznAC1h8tlLCSmAB/DaozpnKtBg5pE+Er6fAXcGIr0GWYlcarDc+RvS+Pn1yxftH2kfI0Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950070; c=relaxed/simple;
	bh=Kq7K9wSabBejL9ZQXcFklBy/U83yijD5cStHIWKym/8=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=SwBSCFntj14sIuqVMVbGE7481ZGWTzr2yo6NgxCL8UAkk85I96ostiPybZfRElusg6OUO8dHgHObVTRRcRr9fVTacbK3iVBjA/Q4EFKXWEdq+8N3KuXvil8IHi6ngqreUgIPe2w2mSo/ZKHcy0qXBvCDRlErM3sixtyZ2wJ9vN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fBx831Vbdz5BNS0;
	Fri, 13 Feb 2026 10:34:27 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 61D2YNox019806;
	Fri, 13 Feb 2026 10:34:23 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Feb 2026 10:34:24 +0800 (CST)
X-Zmail-TransId: 2afc698e8db04d7-2a11a
X-Mailer: Zmail v1.0
Message-ID: <202602131034245558BcmEI95X7Sr39QGM8YLl@zte.com.cn>
Date: Fri, 13 Feb 2026 10:34:24 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSBmdW5jdGlvbl9ncmFwaDogcmVzdG9yZSBkaXJlY3QgbW9kZSB3aGVuIGNhbGxiYWNrcyBkcm9wIHRvIG9uZcKg?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 61D2YNox019806
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Feb 2026 10:34:27 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 698E8DB3.000/4fBx831Vbdz5BNS0

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
-       static_branch_disable(&fgraph_do_direct);
+       static_branch_enable(&fgraph_do_direct);
}

static void ftrace_graph_disable_direct(bool disable_branch)
--
2.25.1
