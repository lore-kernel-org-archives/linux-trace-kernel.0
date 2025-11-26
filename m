Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962331A577;
	Wed, 26 Nov 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149383; cv=none; b=ETcgNPkV0xg4RiUbTpMlQaCG8Sud22m0r4Ms+vQ9DoE4wTVZCAuY/9HQyjWCwBUKFAIUeMKGCINZX8BwcrWqEFYbfB8qKpNF91ZoekqhMJ7BWuKtmiUJSk2tw+Pj7Q93zB8Np9bmf2qMU6fKZQHD3Okxo5ggyNexwMAZZj16Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149383; c=relaxed/simple;
	bh=0xoq5tjYfMPR4AF4PzDf0qfT+wVcOjr0Qat7Og+gRIY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=eXBf0KmCLWWhy3K6LYXxkArAr5lkIv+u62tqfBhNlwowepUvRCH21HYhQLfXJRn06AwG5xWS3mm2cBH5ObGP2i4NRyS7WPNGq/jE22jVSioZ1hGulMI740nDJlEzf/I12PNVE+9VPt5ZhWZL0VPwikOXAJUuL8QLJwIXpYY7QEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGZ5b2lFmz8Xs7F;
	Wed, 26 Nov 2025 17:29:39 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5AQ9TN88099351;
	Wed, 26 Nov 2025 17:29:23 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:29:26 +0800 (CST)
Date: Wed, 26 Nov 2025 17:29:26 +0800 (CST)
X-Zmail-TransId: 2afb6926c87655e-e1a95
X-Mailer: Zmail v1.0
Message-ID: <20251126172926004y3hC8QyU4WFOjBkU_UxLC@zte.com.cn>
In-Reply-To: <20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn>
References: 20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <hu.shengming@zte.com.cn>,
        <zhang.run@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvM10gZmdyYXBoOiBJbml0aWFsaXplIGZ0cmFjZV9vcHMtPnByaXZhdGUgZm9yIGZ1bmN0aW9uIGdyYXBoIG9wcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5AQ9TN88099351
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 26 Nov 2025 17:29:39 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926C883.000/4dGZ5b2lFmz8Xs7F

From: Shengming Hu <hu.shengming@zte.com.cn>

The ftrace_pids_enabled(op) check relies on op->private being properly
initialized, but fgraph_ops's underlying ftrace_ops->private was left
uninitialized. This caused ftrace_pids_enabled() to always return false,
effectively disabling PID filtering for function graph tracing.

Fix this by copying src_ops->private to dst_ops->private in
fgraph_init_ops(), ensuring PID filter state is correctly propagated.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/fgraph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7fb9b169d..f6f25d81a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1016,6 +1016,7 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		mutex_init(&dst_ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&dst_ops->subop_list);
 		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		dst_ops->private = src_ops->private;
 	}
 #endif
 }
-- 
2.25.1
