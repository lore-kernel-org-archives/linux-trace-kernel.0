Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673928;
	b=l6xI3mTXH1sBtu1q3GJSxPbTSV72oG6D+qQO2p/Kww+C3XksBUJkHm7uiGKXi/AJh3VR
	 eo/nJed91l7Zq5dtrxfcO9JMg+U44pY+/Uy7ZYII2LP37nr4Kh5m4EWEbttDrhsfY+Z2P
	 1P5TlP+4a/c6d1dg5tBPNVj2wnb4AQMvFPF5ZLHfDuxddTfOU48ueHsgv+l4XZnOiHT7I
	 k8WquemtxVimDM/JYNsCpmwipqHHl9kMSvXK26o9GxZk5PQpA5aa+zUcUOANInLGJGrLm
	 l12SYoDGCZ6zHpu5ITGIFY2TZe5vcMrQz64pA9K1DyjCtwmkM0/arXoJyBQsumN71wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673928;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Ly9vorsoAEZ8Lm7cyUOymIGr8/QAsw9D7wuydh3LtzE=;
	b=j4ZWus4FVPZuq6z/P1issxZlj+mSh/FsIMjqEV1cvmCRPYIkVrNmF4g5zV39S5XIwIsI
	 sw/s9pyrhu10lvOFu/SoudJhtvqugGeqeONE2NyjIlxUg1vQERuvatCJG4eSSLuzbxuK8
	 5oEpp3KWiRxucOlP9cFWZeLJHAKQYRbQk2KidRLpa6dasUWZaItR8b1rKwqHot/h+zZCt
	 OOOaRqopFdWGvv1FyshEVQzwxqA8FYyq8PnlbS1pQk3Gxb60btdhNv/viw4HWHqQLlhlj
	 vEVIB622PGfz/iRaWvWku9nJbCZ5qo4vZCeKT1igKvMkA45Pf4edRXGH1UAPUvcyjDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=ZbtRar3M;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14434606A32F;
	Tue,  3 Nov 2026 02:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14434606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=ZbtRar3M
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a3e;
	Tue, 3 Nov 2026 10:45:24 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.4749000539954371762@stu.pku.edu.cn>
Subject: [PATCH v2 1/2] tracing/user_events: validate dynamic cpumask size
In-Reply-To: <179367391951.8187.1770217673912340635@stu.pku.edu.cn>
References: <179367391951.8187.1770217673912340635@stu.pku.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19f4c0e5b03a2kunm153cdd6b10a861
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGE8aVktOHx4dGktJTB5DTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=ZbtRar3Mnq+giyLUjh4dN94VVFFl0ZTzKHiMflRKaJmbIb+cIDn4mfrb9JuHyjd7HXvOOKv5RnAjIVliEUjLVaoQH9EJ9okNJ6RwmXldz+uY0hovAb51Y+wmCdJqIkqJRJ8zrpVngFcQPsDD38jsdsRXMT68ChhwYuiqlWjJwqI=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=Ly9vorsoAEZ8Lm7cyUOymIGr8/QAsw9D7wuydh3LtzE=;
	h=date:mime-version:subject:message-id:from;

user_event_validate() checks that a dynamic field lies inside the event but
does not verify the minimum size required by its filter type.  A one-byte
dynamic cpumask can therefore reach filter_pred_cpumask(), which consumes
cpumask_size() bytes beyond the event buffer.

KASAN reports:

  BUG: KASAN: slab-use-after-free in filter_match_preds
  Read of size 8
  filter_match_preds
  trace_event_buffer_commit
  user_event_ftrace
  user_events_write_core

Mark dynamic cpumask fields and reject locations shorter than
cpumask_size().

The patched kernel rejects the short event and accepts a full-size control
event without a KASAN report.

Fixes: 2467cda1b5c9 ("user_events: Validate user payloads for size and null termination")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/trace_events_user.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7a..85938b45b7618 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -170,6 +170,7 @@ struct user_event_file_info {
 
 #define VALIDATOR_ENSURE_NULL (1 << 0)
 #define VALIDATOR_REL (1 << 1)
+#define VALIDATOR_CPUMASK BIT(2)
 
 struct user_event_validator {
 	struct list_head	user_event_link;
@@ -1159,6 +1160,9 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	if (strstr(type, "char") != NULL)
 		validator_flags |= VALIDATOR_ENSURE_NULL;
 
+	if (strstr(type, "cpumask_t"))
+		validator_flags |= VALIDATOR_CPUMASK;
+
 	validator = kmalloc_obj(*validator, GFP_KERNEL_ACCOUNT);
 
 	if (!validator) {
@@ -1598,6 +1602,10 @@ static int user_event_validate(struct user_event *user, void *data, int len)
 		offset = loc & 0xffff;
 		size = loc >> 16;
 
+		if (unlikely((validator->flags & VALIDATOR_CPUMASK) &&
+			     size < cpumask_size()))
+			return -EFAULT;
+
 		if (likely(validator->flags & VALIDATOR_REL))
 			pos += offset + sizeof(loc);
 		else
-- 
2.39.5 (Apple Git-154)
