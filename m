Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E227082F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300408; cv=none; b=HfKCqvIWh/6dDfT/XsN8X4bJS9c6+yFsol5Q5DdMUKL4pe9koUGyeFUNaSSvlnFu66YYBAUZfKv7rWRn/HBZxD4IDLLjs2yRTkznNRCo84PtaEfTVZHdiB8rco7vaXDLFK83EeYrzLlEuzUu3CBehnhVCw4wjnI6iCn+5N4dOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300408; c=relaxed/simple;
	bh=T4mSzU0CMss2zJgb1n3t5tOEqBgAR6J5GZ1bXEoMNew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3lScPRiIlhyshxRr27+EnjexUhhWfrhk6cvrIpckAZJ8BEnOsSIxZpJooY/IOMYZcugPrb2RVjjoDny1mlo+FqrHXopsOZoz/Vdwg54bcaHvo1zoSWCckP5esVLz8IWpOcUEyF8CRJeJMSRHk2Zq4jJeovlaG3sraAa0m34Shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yhli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3R46tWs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yhli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3R46tWs"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9321b9312so2463691b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Nov 2025 19:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764300406; x=1764905206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPY6J8aGE6D9kMp0fnzHzUqR5pFauYhLSeepNwWlytg=;
        b=a3R46tWsvu29Mdov5yqBaaP3De3on0cK1vB0gdOD6ILpGdw5Fq7BqDNeL7lyhlSgXK
         1/SanCOsQ85FikBuYw3NpKrOOtok7KNNj+NDdASHobkHIaJQM1RcYkq4thKtLNZKoK/6
         Urjp4h2iOEByeoLeJ+/d2XpsYAYQjoJtqDwzZtHfQrHaDuAnKKRvbb3KIHP9iEHEH4nd
         Dn2WslzrXT0u6wF1rrJuHQtc5HS7KseJ2PVJe1vVcMQ49xQwTxv0cun56jNOJTSLIldJ
         6mPZFCcArWMOsx88XLMPcMBCIkgL8AC06FeNWqfkc89zNhbA0nfO+GfmbyM4m33PalOM
         Minw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764300406; x=1764905206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPY6J8aGE6D9kMp0fnzHzUqR5pFauYhLSeepNwWlytg=;
        b=vxoLQFVSewepSHdJX0+E6gOcYO5MgkwMa/b9irPEzPPBnEWX8TOEJaU6MzWun3swmC
         cAIZ1+NdYoKsJDX4SQfSVRG3Bs6t3QUQQI95c9Q8V2Vycyq9ns7YXyCe6R7nB6d2reqd
         N91Ygy7urrWPuttIxVH9RnX8acjgrRnHXLS9B5K471WWGjn89F400M6h86aSUzmyWVc8
         BUt3E8vPJPylkm0RRp9SR65BwBJmTxai4pBiq1XzKWkJ1UtipYa9ahKNWFuA+DskTb+e
         CHGL4Z4Djc/v9TULndZHulmSD4vIUss5Y/+lAPPi6j8ymVhv9DCoH19jiChnfkm91iPw
         dP2w==
X-Forwarded-Encrypted: i=1; AJvYcCW8u0o9bQ9q4gzPxkFiGZgh7IFu3VN5KRnaENkaO1u8JWRFwuhDrcH4Cbp1FvljwYHFSwKPGgvkzp/bmY9esBW/EKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo57rtsNz0w5XJELglmAUgxxG2UOqF9gP/mrA5HrnJKt+HWmK2
	9l0mo4uKGxagSzkxCj0rW9NZyUv5oBklW6j5oXzhrB5W805OGdbwXlxZdRvHF162CyGo0bQzIw=
	=
X-Google-Smtp-Source: AGHT+IGxBRbLNbmGL9n+2+vakJDui9W8IGhhE6rqBqDp7pBn826yD5OZcwJeoxjTNFqns6+vEB0c1zEf
X-Received: from pfbmb15.prod.google.com ([2002:a05:6a00:760f:b0:7ae:a150:ac8])
 (user=yhli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1895:b0:7b9:a3c8:8c3a
 with SMTP id d2e1a72fcca58-7c58beb75bfmr28179433b3a.7.1764300406497; Thu, 27
 Nov 2025 19:26:46 -0800 (PST)
Date: Fri, 28 Nov 2025 11:23:57 +0800
In-Reply-To: <no>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <no>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251128032509.825003-1-yhli@google.com>
Subject: [PATCH v2] f2fs: optimize trace_f2fs_write_checkpoint with enums
From: YH Lin <yhli@google.com>
To: yes@google.com
Cc: YH Lin <yhli@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch optimizes the tracepoint by replacing these hardcoded strings
with a new enumeration f2fs_cp_phase.

1.Defines enum f2fs_cp_phase with values for each checkpoint phase.
2.Updates trace_f2fs_write_checkpoint to accept a u16 phase argument
instead of a string pointer.
3.Uses __print_symbolic in TP_printk to convert the enum values
back to their corresponding strings for human-readable trace output.

This change reduces the storage overhead for each trace event
by replacing a variable-length string with a 2-byte integer,
while maintaining the same readable output in ftrace.

Signed-off-by: YH Lin <yhli@google.com>
V2:
- Relocate enum f2fs_cp_phase from include/trace/events/f2fs.h to fs/f2fs/f2fs.h,
  as requested by Chao Yu for better structure cleanup.
---
 fs/f2fs/checkpoint.c        |  6 +++---
 fs/f2fs/f2fs.h              |  6 ++++++
 include/trace/events/f2fs.h | 19 ++++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bbe07e3a6c75..b04f82fdd143 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1673,7 +1673,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		goto out;
 	}
 
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_START_BLOCK_OPS);
 
 	err = block_operations(sbi);
 	if (err)
@@ -1681,7 +1681,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	stat_cp_time(cpc, CP_TIME_OP_LOCK);
 
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_FINISH_BLOCK_OPS);
 
 	f2fs_flush_merged_writes(sbi);
 
@@ -1747,7 +1747,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* update CP_TIME to trigger checkpoint periodically */
 	f2fs_update_time(sbi, CP_TIME);
-	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
+	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_FINISH_CHECKPOINT);
 out:
 	if (cpc->reason != CP_RESIZE)
 		f2fs_up_write(&sbi->cp_global_sem);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6f509d88c596..a995103af735 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -313,6 +313,12 @@ struct cp_control {
 	struct cp_stats stats;
 };
 
+enum f2fs_cp_phase {
+	CP_PHASE_START_BLOCK_OPS,
+	CP_PHASE_FINISH_BLOCK_OPS,
+	CP_PHASE_FINISH_CHECKPOINT,
+};
+
 /*
  * indicate meta/data type
  */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e00611ead024..df4017dcc701 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -50,6 +50,9 @@ TRACE_DEFINE_ENUM(CP_PAUSE);
 TRACE_DEFINE_ENUM(CP_RESIZE);
 TRACE_DEFINE_ENUM(EX_READ);
 TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
+TRACE_DEFINE_ENUM(CP_PHASE_START_BLOCK_OPS);
+TRACE_DEFINE_ENUM(CP_PHASE_FINISH_BLOCK_OPS);
+TRACE_DEFINE_ENUM(CP_PHASE_FINISH_CHECKPOINT);
 
 #define show_block_type(type)						\
 	__print_symbolic(type,						\
@@ -175,6 +178,12 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 #define S_ALL_PERM	(S_ISUID | S_ISGID | S_ISVTX |	\
 			S_IRWXU | S_IRWXG | S_IRWXO)
 
+#define show_cp_phase(phase)					\
+	__print_symbolic(phase,						\
+		{ CP_PHASE_START_BLOCK_OPS,		"start block_ops" },			\
+		{ CP_PHASE_FINISH_BLOCK_OPS,	"finish block_ops" },			\
+		{ CP_PHASE_FINISH_CHECKPOINT,	"finish checkpoint" })
+
 struct f2fs_sb_info;
 struct f2fs_io_info;
 struct extent_info;
@@ -1573,26 +1582,26 @@ TRACE_EVENT(f2fs_readpages,
 
 TRACE_EVENT(f2fs_write_checkpoint,
 
-	TP_PROTO(struct super_block *sb, int reason, const char *msg),
+	TP_PROTO(struct super_block *sb, int reason, u16 phase),
 
-	TP_ARGS(sb, reason, msg),
+	TP_ARGS(sb, reason, phase),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(int,	reason)
-		__string(dest_msg, msg)
+		__field(u16, phase)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
 		__entry->reason		= reason;
-		__assign_str(dest_msg);
+		__entry->phase		= phase;
 	),
 
 	TP_printk("dev = (%d,%d), checkpoint for %s, state = %s",
 		show_dev(__entry->dev),
 		show_cpreason(__entry->reason),
-		__get_str(dest_msg))
+		show_cp_phase(__entry->phase))
 );
 
 DECLARE_EVENT_CLASS(f2fs_discard,
-- 
2.52.0.487.g5c8c507ade-goog

