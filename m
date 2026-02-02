Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AB3612D3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030965; cv=none; b=lKpdQcltIzjfmlNSdEXL/kxXQMUa6EWm8JHB4oOaDrgnRlZrLcW2yw51OQ5oWW3wUYwnb2lnWR/DzKcjb6XTInevppUgXQXHRoIr/P3wqOlfPRJ9TyDGfRy6vieMuCSvTk+ScjfOfoQQWYGEIDXhoXlhr4/U0iWulvmynoS1Vok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030965; c=relaxed/simple;
	bh=LvxBOnW3ouZcfU0GKxjFbif5hR8in+4J152Rc6oXRN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shhjXYMgSo9jRk/SzF/+bGb5Jk5pe+c4f0OZ18JysWJ6EWqPHhxqRCv5KZCHGDjjh3pjIFinXC7/iRRlX82svdtgj3F9uMpgUkq5h7XuECPzKJr4a5IKLYIFxHZzLB73ZClcn4jxJlSjtvXtsxtBT3mKFPZ8pCb/8ImHyBwgkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqzYzFVy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqzYzFVy"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so1940495a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030962; x=1770635762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEY3udR46N1rM6wWgHfQmUTR6/57X3FOLc3E5mPN44E=;
        b=lqzYzFVy4CJCzvyJVMNqF0XcPXaa7sz3gSIsKhHUTyNbvCUT+ruLocqacYU1ThELcV
         fiCHdnKlwQpqrPbh91zuPW4uWbJdBoSC7De3sgzxeYpB7soAaLQcAjLm5ObhTADlWbk0
         OkzmXSnRB/hFk4r8DK0lqN1XKMUkLK1ba+yZhea2R8FfDYmRLcNhpSLq6nb4wnrGxst1
         O2HwzfEwQ5XYawChQsXvsIxSzZtViGoCgYiArVfTGT3LqpJcIX8yAoipsD4uv5eX8OrG
         HD9Do15GC8rjrcARAl0gP6OaAIzIlVEEbEEezqzsa+olsn3bXufZl0osnKq0/+IEQ4Cj
         OdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030962; x=1770635762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEY3udR46N1rM6wWgHfQmUTR6/57X3FOLc3E5mPN44E=;
        b=qVDBoke2eX6vUR1y+35hSk3KFGCjzYAnhmzdiVY3sDj1m3P/yLpJdmJokrVPPFcLY6
         6luHJ7RdtOeRIMJHnpy06COehldvkQS41loYsnApV3wdHVbhh6FOQ9RjYT6OE0sRJ77q
         D3J3NjavZkSArryTqPkdDujOomZMtZyrqCYmjk+Trtf2KyJM0SY1koZs4eSqKOhHuKAu
         JD0hKyZbzmfSb09FUuPbtujzWaI+PqF9kh7kJ8eke7UewTdMBEQfV+Tx1MN/NtU1uM04
         c4UtBN+OLwgnokseO82RbrTlmSjQsobkv2CKG//fhd++h4l3yyHzkdGeFSzBcJ8tp7vB
         xU+w==
X-Forwarded-Encrypted: i=1; AJvYcCUrBmW5VGXS7wOlS11o7ouAIr9m1JLGKzKEI8m5mbH1AL/t2v80plG3pRx9/sCAOmUSFeyM3sWcPCosXz1PvdZTBSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCM7SnNySe8RZldBAd07IeQ+Mzz1Nl6K/YlRhJJce3U0LGoUH
	G+zWV1VLCHjWk1Ekw7a1JlrJgKvPc8ruO+l/h7Gi/AB4uMm/B+4r9QML
X-Gm-Gg: AZuq6aJxm4a6SmKUMsFODZWZm+EVPNZNMutn1HpAxHEgduu2m/Vfvj2iKiQDOjHxhq8
	MaJB+cDxMjU382VC98p7iLTPteaf4K9TySCMTZ5sWHdpw/1OkJ1jZ5Sr28Q/5thdJwnHCMLfEcj
	2TOFm8PxegJiQRouBqt9P8QOd7zqcIE4+8s/Sr789/E9pDMBQzbmQa/D1LVT5nX1aFVxHe/sFpL
	Rxk/4JPIYhzEzs+89GllA0BBuEwtgJaXNAYXrfdAujSRYBIPm1HrxoDuuZGFOVRLMNbh6BsB27R
	sXS3O7ZvIzlQdipInQXDpDDsVqR014hRln+HwNqXogI7Lpjaot5UbjL93lDBpS79I+v0PmZfSzk
	rrIip6dFRuw51GBem02KvUtq/lLIfYN0c+z5XFYn4TW2Fp77uybCbPMZYiQup6NKYqzk8AOyCrq
	cqp+earGADLEY6iWjdIxMSFuQASx0=
X-Received: by 2002:a17:90b:5628:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-3543b31a574mr10763716a91.10.1770030961774;
        Mon, 02 Feb 2026 03:16:01 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm14474680a91.14.2026.02.02.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:16:01 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org,
	ast@kernel.org
Cc: mhiramat@kernel.org,
	andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: resolve enum names for function arguments via BTF
Date: Mon,  2 Feb 2026 19:15:48 +0800
Message-Id: <20260202111548.3555306-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202111548.3555306-1-dolinux.peng@gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Use BTF to print symbolic names for enum-type function arguments,
improving trace readability.

Before:
count_memcg_events(memcg=0xffff..., idx=20, count=0x1) {

After:
count_memcg_events(memcg=0xffff..., idx=20 [PGFAULT], count=0x1) {

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_output.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cc2d3306bb60..c395f768c3b8 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -695,12 +695,13 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 {
 	const struct btf_param *param;
 	const struct btf_type *t;
+	const struct btf_enum *enump;
 	const char *param_name;
 	char name[KSYM_NAME_LEN];
 	unsigned long arg;
 	struct btf *btf;
 	s32 tid, nr = 0;
-	int a, p, x;
+	int a, p, x, i;
 	u16 encode;
 
 	trace_seq_printf(s, "(");
@@ -754,6 +755,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
+			for_each_enum(i, t, enump) {
+				if (arg == enump->val) {
+					trace_seq_printf(s, " [%s]",
+							 btf_name_by_offset(btf,
+							 enump->name_off));
+					break;
+				}
+			}
 			break;
 		default:
 			/* This does not handle complex arguments */
-- 
2.34.1

