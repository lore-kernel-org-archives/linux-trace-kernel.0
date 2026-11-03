Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673934;
	b=0k3n+sPDBDf7lVsa52KWjJFuF/4sTgKGI62jG4DOYbpBOyFl2iFldScQjFwoUZ/pn0QQ
	 uwiylD4NEEMpd+XY/2YULTLFvhgyPcYQF04T3ADFo1bHif1UOyHVA3z0fIZPArUDYY5Hp
	 pZiDu+dZKDH2pQY4Lzv7EjRs7PikHt0ANNQdvxTCarJt60/ZsDtOufayrDrQw50TkKmub
	 EofnNTLUV5O37/UgMBUiUb5vkc9nua7rQbbS+DSx+m+8Aa1SagOEuC/gd6aGPmw802amo
	 PO+uUXdizuebJpaZMZdBvWfQXev6qGm9FcLvT6ipFr3MLilsf3ZXDExN9A3CMryZVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673934;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=+zPkZYhf8I5YDOQlro5MWsg827UE/O2zX0lyYambHfE=;
	b=s8/ceuBJqdEnoz6ahww0OE/OBdo5/LJ0IAL2j5TfdYQVY8rDJBT+02s4LI/CaxTP4smZ
	 uM87TpraZSFshwqZTeyLZLWJR58VnFxfwpoaWOQqWaMyNfIjFlRKoaSZoHUwWfj4uidnH
	 MNmcUQ/LcOs+Z/X7NjD8os/0ASUrYzsjimvipdDAGq1H6cV5MH+fk0NldvvkxlueMbJCR
	 KboyynK3INZEIYNciNLgzkkl2gLbU+1JFknOfdYFIOGnY4jxTT6eENKnCnI417h2yRpAZ
	 Zwy2ZJ+K0Vkn4S2MAWD6NzjZ5RwhCOnCOXKjTnHsK1fYbEumFaTscLpPjJiVPejJhLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=MpxhIAAP;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4C606A33A;
	Tue,  3 Nov 2026 02:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EB4C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=MpxhIAAP
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a40;
	Tue, 3 Nov 2026 10:45:24 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.3972850166052361363@stu.pku.edu.cn>
Subject: [PATCH v2 2/2] tracing/user_events: reject overflowing field offsets
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
X-HM-Tid: 0aa19f4c10e303a2kunm153cdd6b10a863
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSE1OVklISEJCS0pLGh5KTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=MpxhIAAPPye3I7+bilO1dGjODztgEe3IyL4yTxG2CL5/BKg5xo3OTRL/PqnAxBmQe1gTP7CM5Rl1CywHNX5Zf40IX0HIaegM2KplWEn1oXCTb1oiitFMi2M7tWAzond8cDSK+cAhTg5LiIMp8S6yx3ri/2z3suHB0sfcaEX/Jgc=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=+zPkZYhf8I5YDOQlro5MWsg827UE/O2zX0lyYambHfE=;
	h=date:mime-version:subject:message-id:from;

user_event_parse_field() accepts large structure sizes but accumulates
field offsets in a u32 before storing them in signed int fields.  A
declaration can wrap the recorded minimum event size while a fixed-width
field retains an offset outside the accepted record.  A short write is
then accepted and a field filter reads beyond the event buffer.

KASAN reports:

  BUG: KASAN: slab-use-after-free in filter_match_preds
  Read of size 8
  filter_match_preds
  trace_event_buffer_commit
  user_event_ftrace
  user_events_write_core

Parse an explicit structure size into a u32, reject values greater than
INT_MAX before converting them to int, and use checked addition for the
resulting field offset.  This prevents both signed conversion and offset
overflow from bypassing the downstream bounds checks.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/trace_events_user.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 85938b45b7618..04eef4865490b 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1207,6 +1207,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
 {
 	char *part, *type, *name;
 	u32 depth = 0, saved_offset = *offset;
+	u32 new_offset, struct_size;
 	int len, size = -EINVAL;
 	bool is_struct = false;
 
@@ -1267,8 +1268,11 @@ static int user_event_parse_field(char *field, struct user_event *user,
 			if (!is_struct)
 				return -EINVAL;
 
-			if (kstrtou32(part, 10, &size))
+			if (kstrtou32(part, 10, &struct_size))
 				return -EINVAL;
+			if (struct_size > INT_MAX)
+				return -E2BIG;
+			size = struct_size;
 			break;
 		default:
 			return -EINVAL;
@@ -1287,7 +1291,11 @@ static int user_event_parse_field(char *field, struct user_event *user,
 	if (size < 0)
 		return size;
 
-	*offset = saved_offset + size;
+	if (check_add_overflow(saved_offset, (u32)size, &new_offset) ||
+	    new_offset > INT_MAX)
+		return -E2BIG;
+
+	*offset = new_offset;
 
 	return user_event_add_field(user, type, name, saved_offset, size,
 				    type[0] != 'u', FILTER_OTHER);
-- 
2.39.5 (Apple Git-154)
