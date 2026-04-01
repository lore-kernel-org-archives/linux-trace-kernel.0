Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578333436A;
	Wed,  1 Apr 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042559; cv=none; b=MZBVwQXBdXkXMLXgie4oRj+kI+AH+VRpg8XeAfGOTMENaiCE9iZvFpc3qU8YQP7a7sEvGT9uTaifdQ1ABDdi3RzoQZQtLQL2qU2iT3QH9EQIYsmmwYRy2vWERENaSYFvuGGnXS1FOWs/q87zMNFyqS0PXafy3Wxf2afA63eyHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042559; c=relaxed/simple;
	bh=2b0VHpgisREw7YvR7EsDakXdNmoegGCsMsBXQXMNjhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KB1M+Q19+2AmtIu0xxDiOYUvYcNCc6PTOfgZQSIdRk8oEOCQMA+K0aCDFYPyUiFwMHfGOsi7y4r3siKkNveQ5oEZr2p7tA9BUWkj1JCUUuB+NEFoOrwl+DaBjBFagC+KlXhbXACzqS7KQHzD9cb3YQ54PpJThQGJYvikDQ4VzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAA34m3y_8xpatzbCw--.6665S2;
	Wed, 01 Apr 2026 19:22:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2 1/2] tracing/hist: rebuild full_name on each hist_field_name() call
Date: Wed,  1 Apr 2026 19:22:23 +0800
Message-ID: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA34m3y_8xpatzbCw--.6665S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3tw4DAw4rGr1xGr1xKrg_yoW8CF43pF
	WrKr9I9r1UJFW2g3W3Zw4rCas5G3s3C34kG3WvkwnYyryYvr1DWFZ8Wr1Uuw1FvrWrK39I
	qF4DXry3GF1jqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
qualified variable-reference names, but it currently appends into that
buffer with strcat() without rebuilding it first. As a result, repeated
calls append a new "system.event.field" name onto the previous one,
which can eventually run past the end of full_name.

Build the name with snprintf() on each call and return NULL if the fully
qualified name does not fit in MAX_FILTER_STR_VAL.

Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-pengpeng@iscas.ac.cn/

- rebuild full_name on each call instead of falling back to field->name
- return NULL on overflow as suggested
- split out the snprintf() length check instead of using an inline if

 kernel/trace/trace_events_hist.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..f9c8a4f078ea 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1361,12 +1361,14 @@ static const char *hist_field_name(struct hist_field *field,
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
+			int len;
+
+			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
+				       field->system, field->event_name,
+				       field->name);
+			if (len >= sizeof(full_name))
+				return NULL;
 
-			strcat(full_name, field->system);
-			strcat(full_name, ".");
-			strcat(full_name, field->event_name);
-			strcat(full_name, ".");
-			strcat(full_name, field->name);
 			field_name = full_name;
 		} else
 			field_name = field->name;
-- 
2.50.1 (Apple Git-155)

