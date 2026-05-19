Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C184C77CA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185815; cv=none; b=c14JSCSldHrP42jjBfMY63PpvhDneI1ZviDmN92sUZxJBkdcgsFioI+ibE0dJqIsXeE8a6PR8dxvB+5dL5cXwNiRxttZfJ+GKzUJ9JAl4ej9PjoEk34bjpQuubNUjcIN7hqbgR9ee1cVkz6YGbUNnwzTZ0Bid1ZNRqipeCMcZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185815; c=relaxed/simple;
	bh=mLpwP7JVosrq5U1uvrR7w/BkeawFbuswelwbPzZNmsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gvGVgAURTnUinZlTrkZpVFVISCErMczJzzK4fXIpC9E/6IcNeKBlX1MJiOk0Fvulou9kHpgqt62JwgmIYPfEMcw6Ket1nbOw7dqkNLHb3NdGODiUKeVKk5MvzUZDwh63v00R2qGKmV0trUPUpxlt78Ef9Q6FQLjakvkIepxQyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCrGJOXQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCrGJOXQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso4590397a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185808; x=1779790608; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvt4MjoGA0L3/prTXoqHWkNBgnaKme2r46Dy9xiUW1k=;
        b=bCrGJOXQLttU6f0CifUXSjdZ6LogzjUyGjuDGvnGSFPgzaByoPbJqBfb1OIYUV3KOw
         URZGoX7WTHPTlFCxlQXBN6zsiIxTRvPdMIcPsRKTmNqar6RiwJh36mAYMc0OtwesE6X6
         6Idq5f+Zni2aOeJYGeCUzJ58L+/AosmGpPyK7IC26kXxIUuq8dauVJU65ECsOVXygGKg
         hpMpCHlRV3QIzMcpkNev+YTEqdHKeqSC+cHb0Sw/K02PqP4e85eQjU5x7offuXRuaqlX
         VYEYfLUGaStU2cON7Op8ASeitHfxs1B3eySnk2t+Iaam6ftCBbDYN+mRAoUTbQQAxVn3
         Qy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185808; x=1779790608;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvt4MjoGA0L3/prTXoqHWkNBgnaKme2r46Dy9xiUW1k=;
        b=bYvrbN4WMT6p32ZNBVvFTO2u6vedrez3jGNaUqG1unKU8ICtGKtd7E4YAh838XGf46
         9JUV04qceR7uiyVxLvcLmq7Aow3sDuaMsyA3RA4fx5NP6w2Tkm4TjCZS2GusHvF5oavR
         fqC9kGaaaKvRbe0m2NS5bmCc/xk5e6TyomtO9n1Xtkojr/yVi3sl7iuIY0higLBlqb2g
         9dExM+XGHGW/gh02TLUTObn5BZNHNAn3ewv6eGjNJQD14mF9m6r0+bdyCXUBL2ft1DG+
         GITsgVbAMnuACcOfClq+qxXvMKISTEoIL2v83uqsd3XYzkHKToo5suauGgV2sRHrb5jq
         /EpA==
X-Forwarded-Encrypted: i=1; AFNElJ+UABgzCtAk1Ex64eQUWEk5po6IQi7vn36wlHMH8sNvh5TsNtc2N7t3xIStB/8bolP96QoFzN3oiGHoFUDyUX7PFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjHhvkC5ByokOqbNe4YaAwEi+MlbSBhpqPn6+rTgp1PKqyqJe
	yA43rDC0k1PDgOOKwn2kL0TeHzVTT4Qhbc0ysPHcSLDkB2TpL6Ob1m0h6MpU9u9t
X-Gm-Gg: Acq92OGsHqRNXA45Ixrex9Zfy6Hx1hOKKYUt49ed4U16ZsDXm9CLmt0dxyGbUt5sIHL
	dBmIJtQ8OEq7zBRReDQyqHo0QPwMd57UZ4sbzRLXppozpmm6x1/E2qDzW8ephVfqg0Y9qPl0sQW
	T0IEHFME7WNN79CQelXGJDBkeECocUxJlJY+tuLMt7QFEQPfJeo4cN4Nur9SZeAZuQnhANS6Whs
	Rhe98Xef3LIocPRW6eVTRXpeMQ/YJgUyX/9Vz+wAje6YyNxHICEohMYInrvu47C3RCqS2TsiVrQ
	LojIzZRv7iJtKsC1cCWpnxSVaUl352CYp7b4zFEXMnc7ueoI1jtsjBQYZAC7wPGBu1cDvmAuhw2
	rYPfQuRWdJWLKlxSxOzZXGWb46R6+TTYXFrgOdVRnrbK5jXxuV7blv2czOGpsMgH6/GxMBpiZgU
	M5Axr0ZFIg6J90lv4NPVB1yN7vmbwpkjO51CFDkMAtJA==
X-Received: by 2002:a05:6402:556:b0:67e:9e04:31d0 with SMTP id 4fb4d7f45d1cf-683bd779fe2mr6892342a12.23.1779185807853;
        Tue, 19 May 2026 03:16:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:a312:c59b:a180:5a91:2947:87c1:9e0f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b50a34sm6340111a12.7.2026.05.19.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:16:47 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 19 May 2026 12:16:43 +0200
Subject: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIo4DGoC/yXMQQ6DIBBG4auYWUsCGK32KsaFxb86LrBh0JgQ7
 15sl9/ivUSCwBB6FokCDhbefIYpC3LL6GconrLJatvo2nRq2SSaU8UwOvazgp0a3cLVqB6Uo0/
 Am8/fsB/+lv21wsX7Qtf1BZJD2TtyAAAA
X-Change-ID: 20260519-host1x-tracing-e2d608ec5e37
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737;
 i=arturkow2000@gmail.com; h=from:subject:message-id;
 bh=mLpwP7JVosrq5U1uvrR7w/BkeawFbuswelwbPzZNmsM=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQxaPRd/fzY4xUyqerd8QFrf+5NPXP5vtFOp35a5YXu38L
 jrzHadPRykLgxgXg6yYIovZQ6EvPPO83m94ubUTZg4rE8gQBi5OAZjI0UaG/0X/ihNe8/9Y62Lw
 Pu20etwreaPzrkLlJ56kudjsNmsR9GVk2CR09PzF/jdPm5ctyPm5VTDGIi7Zcf0K/xLWms89xz9
 c4AEA
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

Use __assign_str and __get_str as required by tracing subsystem. Fixes
string fields being rejected by the verifier and unreadable from
userspace.

Tested on v6.18.21.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
 include/trace/events/host1x.h | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/host1x.h b/include/trace/events/host1x.h
index 1ba84b738e46..1b6aeb7b177b 100644
--- a/include/trace/events/host1x.h
+++ b/include/trace/events/host1x.h
@@ -21,9 +21,11 @@ struct host1x_bo;
 DECLARE_EVENT_CLASS(host1x,
 	TP_PROTO(const char *name),
 	TP_ARGS(name),
-	TP_STRUCT__entry(__field(const char *, name)),
-	TP_fast_assign(__entry->name = name;),
-	TP_printk("name=%s", __entry->name)
+	TP_STRUCT__entry(__string(name, name)),
+	TP_fast_assign(
+		__assign_str(name);
+	),
+	TP_printk("name=%s", __get_str(name))
 );
 
 DEFINE_EVENT(host1x, host1x_channel_open,
@@ -52,19 +54,19 @@ TRACE_EVENT(host1x_cdma_push,
 	TP_ARGS(name, op1, op2),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(u32, op1)
 		__field(u32, op2)
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->op1 = op1;
 		__entry->op2 = op2;
 	),
 
 	TP_printk("name=%s, op1=%08x, op2=%08x",
-		__entry->name, __entry->op1, __entry->op2)
+		__get_str(name), __entry->op1, __entry->op2)
 );
 
 TRACE_EVENT(host1x_cdma_push_wide,
@@ -73,7 +75,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
 	TP_ARGS(name, op1, op2, op3, op4),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(u32, op1)
 		__field(u32, op2)
 		__field(u32, op3)
@@ -81,7 +83,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->op1 = op1;
 		__entry->op2 = op2;
 		__entry->op3 = op3;
@@ -89,7 +91,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
 	),
 
 	TP_printk("name=%s, op1=%08x, op2=%08x, op3=%08x op4=%08x",
-		__entry->name, __entry->op1, __entry->op2, __entry->op3,
+		__get_str(name), __entry->op1, __entry->op2, __entry->op3,
 		__entry->op4)
 );
 
@@ -100,7 +102,7 @@ TRACE_EVENT(host1x_cdma_push_gather,
 	TP_ARGS(name, bo, words, offset, cmdbuf),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(struct host1x_bo *, bo)
 		__field(u32, words)
 		__field(u32, offset)
@@ -114,14 +116,14 @@ TRACE_EVENT(host1x_cdma_push_gather,
 					words * sizeof(u32));
 		}
 		__entry->cmdbuf = cmdbuf;
-		__entry->name = name;
+		__assign_str(name);
 		__entry->bo = bo;
 		__entry->words = words;
 		__entry->offset = offset;
 	),
 
 	TP_printk("name=%s, bo=%p, words=%u, offset=%d, contents=[%s]",
-	  __entry->name, __entry->bo,
+	  __get_str(name), __entry->bo,
 	  __entry->words, __entry->offset,
 	  __print_hex(__get_dynamic_array(cmdbuf),
 		  __entry->cmdbuf ? __entry->words * 4 : 0))
@@ -134,7 +136,7 @@ TRACE_EVENT(host1x_channel_submit,
 	TP_ARGS(name, cmdbufs, relocs, syncpt_id, syncpt_incrs),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(u32, cmdbufs)
 		__field(u32, relocs)
 		__field(u32, syncpt_id)
@@ -142,7 +144,7 @@ TRACE_EVENT(host1x_channel_submit,
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->cmdbufs = cmdbufs;
 		__entry->relocs = relocs;
 		__entry->syncpt_id = syncpt_id;
@@ -151,7 +153,7 @@ TRACE_EVENT(host1x_channel_submit,
 
 	TP_printk("name=%s, cmdbufs=%u, relocs=%u, syncpt_id=%u, "
 		  "syncpt_incrs=%u",
-		  __entry->name, __entry->cmdbufs, __entry->relocs,
+		  __get_str(name), __entry->cmdbufs, __entry->relocs,
 		  __entry->syncpt_id, __entry->syncpt_incrs)
 );
 
@@ -161,19 +163,19 @@ TRACE_EVENT(host1x_channel_submitted,
 	TP_ARGS(name, syncpt_base, syncpt_max),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(u32, syncpt_base)
 		__field(u32, syncpt_max)
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->syncpt_base = syncpt_base;
 		__entry->syncpt_max = syncpt_max;
 	),
 
 	TP_printk("name=%s, syncpt_base=%d, syncpt_max=%d",
-		__entry->name, __entry->syncpt_base, __entry->syncpt_max)
+		__get_str(name), __entry->syncpt_base, __entry->syncpt_max)
 );
 
 TRACE_EVENT(host1x_channel_submit_complete,
@@ -182,19 +184,19 @@ TRACE_EVENT(host1x_channel_submit_complete,
 	TP_ARGS(name, count, thresh),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(int, count)
 		__field(u32, thresh)
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->count = count;
 		__entry->thresh = thresh;
 	),
 
 	TP_printk("name=%s, count=%d, thresh=%d",
-		__entry->name, __entry->count, __entry->thresh)
+		__get_str(name), __entry->count, __entry->thresh)
 );
 
 TRACE_EVENT(host1x_wait_cdma,
@@ -203,16 +205,16 @@ TRACE_EVENT(host1x_wait_cdma,
 	TP_ARGS(name, eventid),
 
 	TP_STRUCT__entry(
-		__field(const char *, name)
+		__string(name, name)
 		__field(u32, eventid)
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->eventid = eventid;
 	),
 
-	TP_printk("name=%s, event=%d", __entry->name, __entry->eventid)
+	TP_printk("name=%s, event=%d", __get_str(name), __entry->eventid)
 );
 
 TRACE_EVENT(host1x_syncpt_load_min,

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-host1x-tracing-e2d608ec5e37

Best regards,
--  
Artur Kowalski <arturkow2000@gmail.com>

