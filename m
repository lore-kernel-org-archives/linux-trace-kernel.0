Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFD2F39CE;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763782; cv=pass; b=k+/Vnb5+uKqX2LYLpFVHLR1aTjCBfWx580GDpOdwN5WjzkRPfRC/Ba17vlFNyyIAtdvMnHKjNZp0RYnArnk0cWhqrISeFSdvrmx68dTGZ/RME0rXPJduSYPSNMyrb3EZnfiJH9LYgugd9slW9PswOSyAImOe+apgCP4GFaidNS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763782; c=relaxed/simple;
	bh=DUCDFOLJ57qkCNI68sXQsO7UVxK28h+iRY+VtUQMUrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFjrL8HTsoajAashZ9+I0DjYzQYcDB+bW44NRMmNqottemP0f9K2nYQ8jP4DSaKYJSnU2iqqHTFVxikyWY1+oXAdN+SGBDgN9wMbs+8F0f1eyD1jbqppzhMb8gqxvNZeAeMq2IA8PC24MMqgcO1NvFGN8lWWhc9vyye3MdasLTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=cHd7JeN7; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="cHd7JeN7"
ARC-Seal: i=1; a=rsa-sha256; t=1773763766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DLJ8SbBrfeT9NAgbgxEQP4/9I9BmftnFk7wxkF6QwQQ0RmJNeiZqwkNVW2lzSGxznmQbdkMcv1C3/y4K8V+h0m4Is+Xf1mdspz6/yOQKHCI9aHLDu4WTwnSztBP4tgjbkecuLMYMlIuCXbWe9pXNwJ2E3z71LWOfx2q7f46Xi5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rp+wuVlETQfmLgKmv7tEFfJBknrCQ1YXaGdK0CbMPg4=; 
	b=YLlxZvXW41MqJmYr8gwVFZYE832QMX1rGMnDpmX0KJVV4lv5Uv0VWxbpb1lb8fAqV6JeKJvvN0dIyvl54t3JkHeMeOuXORMaKfnrXoktrlDl/65ibXz6KkQnL444JKHQwBTXbeL9rajL+12LEW1tDTfTraa1CMh4+/y/s7DysSw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763766;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=rp+wuVlETQfmLgKmv7tEFfJBknrCQ1YXaGdK0CbMPg4=;
	b=cHd7JeN7juSuUp17FplRsCsEKSAA84d+vayNymfT2L1ZdIQleeb2mJHmRBwMCVy1
	65yXXtBghdmsd8AheHT99LZLOZJLlGtHhtRu1sgtolMH8A6VrR9S8zeyTz6QlUEYCAY
	sfjI0aKl+jOilTjMUI7NL/FN0r9KJctAyBXVD6VM=
Received: by mx.zoho.eu with SMTPS id 177376376451425.03107281800885;
	Tue, 17 Mar 2026 17:09:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 13/15] lib/bootconfig: use signed type for offset in xbc_init_node()
Date: Tue, 17 Mar 2026 16:09:14 +0000
Message-Id: <20260317160916.33576-14-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:415:32: warning: conversion to 'long unsigned int'
  from 'long int' may change the sign of the result [-Wsign-conversion]

Pointer subtraction yields ptrdiff_t (signed), which was stored in
unsigned long.  The original unsigned type implicitly caught a negative
offset (data < xbc_data) because the wrapped value would exceed
XBC_DATA_MAX.  Make this intent explicit by using a signed long and
adding an offset < 0 check to the WARN_ON condition.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 3c5b6ad32a54..119c3d429c1f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -412,9 +412,9 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
-	unsigned long offset = data - xbc_data;
+	long offset = data - xbc_data;
 
-	if (WARN_ON(offset >= XBC_DATA_MAX))
+	if (WARN_ON(offset < 0 || offset >= XBC_DATA_MAX))
 		return -EINVAL;
 
 	node->data = (uint16_t)offset | flag;
-- 
2.34.1

