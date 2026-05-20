Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A963B19D9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314453; cv=none; b=rXmRKGDjITvit6boFPrxAedIYuu1hBhZFdcS8TYSclmrmjUxvPUp/cgIqLjr2ITQUzSiT1CdToSgs8kyIJluGBwm0UGM2jGkJkxNNueTGUgAKtq9JWPt5MXtNF+PAKTdTXnnMPhN+TuxSjennuxTSazXyqBxubdZ6DO2dnh6zn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314453; c=relaxed/simple;
	bh=rqkyqnF6DSfTKl1qX0DNlIqqmmtuoFM1SE9u2aybMW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FuyHZMEsqeuKzvd5k2zD6qxRBxd+OBCznLdgZFSM3eCme48GOfcT1iVMwj/bF2pLhhp9kC6Q9EbaFPHzMhLbNlFddVTSAtntJnsXF5gscazeuDI91xGETNaSu/2xEWqvObDlS7o6SaM1jL0TOEQig7NAztv+09tgQxpdJQB0bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfQM55Qn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfQM55Qn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3699cdeec05so2095553a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314449; x=1779919249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4QHtY5cUcmeH3B0UPkdScUguA0W0qbFF3qRp77bUwo=;
        b=FfQM55Qn44st7DQQEOI6haMjbkxd3fykkpP7sn3WEQL9V5Y9DtsbIYIg+kGu7S7KLg
         lskADIoEmfd1SwahveqmukGLQwSe/3KQyO4864JQxiINqndBwR3JWHz2ZglqmdISCyTp
         dJi1kSNYrC20l3OrNcuywgdgzgAwtqWYWlgcdphxeCCCefgQDi9533p2wjmgBkPxZAjC
         pgKbOZo0nDnVqqn9n9iT1CzbA+BQ2UinJAyroo34Dqj16/3qg4j+hpp0WcN6c17JRZeu
         SxVjj2hyTSmAsf9xVJWdax1xaVo7l+FcT60/eh8uGEU6mtYXWo4dtZAN4xCT1AnDKz8Z
         fIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314449; x=1779919249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4QHtY5cUcmeH3B0UPkdScUguA0W0qbFF3qRp77bUwo=;
        b=hAc60N+bbXoHy8+GBf9mzHnME2SJRyzk8ajbdrytIMC+STO7EeuTqthhKhGCC6CyhP
         4KQ2nmFtyvqMmR/AQQWuh2ZqbH4emMxVcCmunlS/rAEBU/Y+TOa4wewPtTB59lgPI1Sk
         GhUmZtOkhXG+8GYRjn4jz66FYlrLKjdxqG69f39+cTZVN30Xvaw58Yt07zGrcQYp/P9f
         sg3kZ66jzXZn7DcNR//Ww20zLvRhumqyoEEklcnKhLM5ktkoegzvGpJWOFp9OXSOmykw
         mc4PjkRWWdDnvnsw4sqCorFDjMQuabMUMIZAbu7E885Xs6czdZO1zrW+JhVBiYP7NuH+
         uleQ==
X-Gm-Message-State: AOJu0Ywd5FZqNAdcauXLE2DFvb0cHuxBNG5eOgCMqYKsxgoP7NlJJ6wu
	zXEKytVMZ0QNa3ozWUe91KZNe+7RxlP9HU5/Lxbi8Lp0Hli+WiXMeKpbfAZOOwLM
X-Gm-Gg: Acq92OHywC9YLqVrLo11zlNUAwZ1CLkFvahveYd5JwokziTLoWq9r2+ux+HLJV6bzu+
	mTHsQxKQ+c9vGU/AWKx+c7gAFPKgJVzO+Se/EnascZqNjxWmZxunF1nhZoLoqcJmCD/cCKHm2B0
	YJF9VsbdcxLm5+WMYsMAvBUhUcuSuRRSYm7am6+Xs8cC1qMLFo4ACe7n3Hl9g2VqUZ+bnsmR1zU
	QUb9mYRvpEshkVOPIBmEmr2MYBiMMDzbyWzMvnEYfOaJSCtkt/S5L7eDb3DDbZsg3EDqIcC0j+q
	NS39u0HBD46v6Y6ijHH6W8njnrFugKIlZb9iaYhJtcjZvWdNVL92EpfTzAE3qU/QMqyTBpmgDa1
	RdXrsihEdAT0a4yI9UPpRKvAEwKakUfLO7e1MjWI1vq6EOXQC7Ed0cs8wTWyTf/f/1EWTXjn1Cd
	0gox3XYNnjYxs43eEmwTSjE2HMfVZdy6r5jTr7VJ25WC3VuRl5O1diRGx90ygMkUJCZYo56kmrj
	ASsqsYshK8B9vwOh69M+8Z0cZJuk8zt9Kh18Vnihg2Gcg==
X-Received: by 2002:a17:90b:5644:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-36a44f0d1d0mr332606a91.1.1779314448276;
        Wed, 20 May 2026 15:00:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3d0d8421sm648868a91.9.2026.05.20.15.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:00:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: [PATCH] ftrace: Use flexible array for hash buckets
Date: Wed, 20 May 2026 15:00:30 -0700
Message-ID: <20260520220030.16887-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store ftrace hash buckets in the ftrace_hash allocation instead of
allocating the bucket array separately.

This keeps the bucket storage tied to the hash lifetime and simplifies
the allocation and cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/ftrace.c | 17 ++---------------
 kernel/trace/trace.h  |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b2611de3f594..25a9dca290dd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1082,10 +1082,7 @@ struct ftrace_func_probe {
  * it all the time. These are in a read only section such that if
  * anyone does try to modify it, it will cause an exception.
  */
-static const struct hlist_head empty_buckets[1];
-static const struct ftrace_hash empty_hash = {
-	.buckets = (struct hlist_head *)empty_buckets,
-};
+static const struct ftrace_hash empty_hash = {};
 #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)
 
 struct ftrace_ops global_ops = {
@@ -1295,7 +1292,6 @@ void free_ftrace_hash(struct ftrace_hash *hash)
 	if (!hash || hash == EMPTY_HASH)
 		return;
 	ftrace_hash_clear(hash);
-	kfree(hash->buckets);
 	kfree(hash);
 }
 
@@ -1333,20 +1329,11 @@ EXPORT_SYMBOL_GPL(ftrace_free_filter);
 struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 {
 	struct ftrace_hash *hash;
-	int size;
 
-	hash = kzalloc_obj(*hash);
+	hash = kzalloc_flex(*hash, buckets, BIT(size_bits));
 	if (!hash)
 		return NULL;
 
-	size = 1 << size_bits;
-	hash->buckets = kzalloc_objs(*hash->buckets, size);
-
-	if (!hash->buckets) {
-		kfree(hash);
-		return NULL;
-	}
-
 	hash->size_bits = size_bits;
 
 	return hash;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..5a3f81f17317 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1000,10 +1000,10 @@ enum {
 
 struct ftrace_hash {
 	unsigned long		size_bits;
-	struct hlist_head	*buckets;
 	unsigned long		count;
 	unsigned long		flags;
 	struct rcu_head		rcu;
+	struct hlist_head	buckets[];
 };
 
 struct ftrace_func_entry *
-- 
2.54.0

