Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC8331A63;
	Thu,  7 May 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141474; cv=none; b=btOyEgaxgHbMgIhaFnAiRzSN7l8itYsgGC4OOgUIbTWBTHeP/ytuTh04C8wM3sou3vV2Ey23fi+i267jwbRpq2nFVQAEB0NXqvmQPjtiW5FPo3tAtn+Pz/+MQtpMyeIGuLBrwqRFAsVXZSG8QB6Wfc+jfJwdKHyd9jwC2nILuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141474; c=relaxed/simple;
	bh=7jZ6xUsPdW/eD1zYxjDxuHzmUqOWbAcmayxu+C7e/wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2RDjTh+EV3VFvyGzgy3VXNN7woLzgR+xTuEiKPlWeSxQhjxDeUTqZPne3HCtvjPTrPeQYsE2BLZFBLMeU7zvxNIw/jcKsxFH3Ibkmnf6jmMI5jXZ3fl1lJ0/4LDvC1UDN/vFj5uE/yIQaDTfYhJrORjk1NDt0zqyhfQz8b7TGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKtp7-00000000bpd-2qUF;
	Thu, 07 May 2026 10:11:09 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] tracing: probes: fix typo in a log message
Date: Thu,  7 May 2026 10:09:08 +0200
Message-ID: <20260507081041.885781-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260507081041.885781-1-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo ("Invalid $-variable") in a log message.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/trace_probe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..df68d40de161 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -509,7 +509,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_RETVAL,		"This function returns 'void' type"),	\
 	C(BAD_STACK_NUM,	"Invalid stack number"),		\
 	C(BAD_ARG_NUM,		"Invalid argument number"),		\
-	C(BAD_VAR,		"Invalid $-valiable specified"),	\
+	C(BAD_VAR,		"Invalid $-variable specified"),	\
 	C(BAD_REG_NAME,		"Invalid register name"),		\
 	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
 	C(BAD_IMM,		"Invalid immediate value"),		\
-- 
2.43.7

