Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369529BDA0;
	Wed, 26 Nov 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148398; cv=none; b=BOEIxieke9dWlghuC+QsVPdZsVst2WJ6u79Ex1IcEbWmVmyiQmv7+fYL4UAwOSNY/0iCn1z0B6tte899onCRHRA6Kc81UtZ2+mQrUtV/xeR3oRB8yLY4j+5Gq0c133EZO8JpaNKV8RBFCdD2FDVXHOtFZSGLj4ogZNsfKgGDKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148398; c=relaxed/simple;
	bh=cP4ZsjnNW+7gswNcSqP8+EUAlpn71Ppla3/a+wpLnc0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=WqYikqbxWC5j8wG41H/QVgX3STI4K494mGHxGKwS0lv3Vwo3bjTj6QATsveFzbpbmzII3HDhn5OTyNHrAvuWCR+9Ned5wb2euSBvkoV0xL5X2xMc2H7z+DJmWajxbcCxgfyIuOeyQhHa5DuxILNf/gAdQomLUHuF+o72xSxMcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGYkd5lXYz7VGTv;
	Wed, 26 Nov 2025 17:13:13 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5AQ9Cd7i047548;
	Wed, 26 Nov 2025 17:12:39 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:12:41 +0800 (CST)
Date: Wed, 26 Nov 2025 17:12:41 +0800 (CST)
X-Zmail-TransId: 2afb6926c489da0-c32f6
X-Mailer: Zmail v1.0
Message-ID: <2025112617124190526P0FDsgI-Q6glKqxfuwF@zte.com.cn>
In-Reply-To: <202511261708240123PvauPcd7Xbqx_EDrKkNn@zte.com.cn>
References: 202511261708240123PvauPcd7Xbqx_EDrKkNn@zte.com.cn
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvM10gZmdyYXBoOiBJbml0aWFsaXplIGZ0cmFjZV9vcHMtPnByaXZhdGUgZm9yCgogZnVuY3Rpb24gZ3JhcGggb3Bz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5AQ9Cd7i047548
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 26 Nov 2025 17:13:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926C4A9.002/4dGYkd5lXYz7VGTv

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
