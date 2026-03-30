Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9241CF8B;
	Mon, 30 Mar 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838790; cv=none; b=B+L1xCfF2wwFSVhSamXBnNsCw3iSoTz+A8doZpY/3a8wszFYGynRCMg6TmU/VlGGF/Of5Ot4aGqla2tewDb2TymR/vMkNLFRU8TKFUCrkLDv97g+5zjAgVctaRNFeRxE6Z2CWv+7mG+7QEpB6BH11chBZwECKDta6B8lGb6RdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838790; c=relaxed/simple;
	bh=WgvOXLp4YJ/Yq/eBmDURIRKutrmC9Lb68Yp7gdOKKfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g11u/2iyWNXThBTjLVbwDynj5aW8aO450FmcR4oZ/MssMUkFeYwOLSkfQb9DZjBaUET5+Y+KzX3l7crkpWj6NtB/9FWHDwW/JgnrnGG5jke1Gwo5ViU3Lj57q8TlXrNXQaxH5EmUMQ8iAoOMMQeBLtmKQwmfUTlvZ5XSegshqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowABnC2f748lp9N+XCw--.12529S2;
	Mon, 30 Mar 2026 10:46:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2 1/2] tracing/hist: rebuild full_name on each hist_field_name() call
Date: Mon, 30 Mar 2026 10:46:19 +0800
Message-ID: <20260330024619.38459-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnC2f748lp9N+XCw--.12529S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3tw4DAw4rGr1xGr1xKrg_yoW8AFW5pF
	WrKr909r1UJFW2ga43Zw4rCr95G3s2k34kG3WvkwnYyryYvr1qqFZ8Wr1Uuw1Fvr4rK39I
	qFs8Xry3GF1jqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUTmh7UUU
	UU=
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
v2:
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

