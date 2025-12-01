Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A131A049
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599918; cv=none; b=iNH4aHivk7dgYkD0/lKsxegAbFXmW2qhp1+9A2tOVXkfOWfHdWP6KWQBahAESxsYg7wc/1OloW3/QN91pVmzQAyoZViT3EdaWdjk9Y/pqcORml8MxzF9IQ+eHLDbOGZUM4nLWDj2Dcr4K+YCz+5m9G4BdIsqErQMJMZd1CukkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599918; c=relaxed/simple;
	bh=HDJieKVU1OPAPmWICR7jITnRxxHe+vYqQPrTd5IfbEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoReYaJjeSANp/GOd+TyhjFIJ/Y11FD+lfewmIu9w7xrll3UUMy9DsRDeqRp4DU2rxCDaPbxZ1qhsmTq+/HuHgw95FSyT2uunSd/pM3E8lRG5U76eKm6NJX2++eeg18nrgJabpTDYfO/Zmohm6Va3udUkE/BcA6oNspKkwyLSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS1Yp/Jz; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS1Yp/Jz"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-641e4744e59so4273213d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599916; x=1765204716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=GS1Yp/Jzhz5JCvYq7FdQms2sl/KVTBHemdR6laLuVDo2q40I9i3C9SUitNA39Gy9dL
         hlP2X+iAht1JWbydeeZltXELRfp1+cIt3NibrG13aF1VtKw6hPAZl2yMRQbVWFLgQJE4
         NGtJl2u7LMf2eorIYqcm9RpCUH5PX7bev/xKzWFngU9wGw0MtBpFKgXm54e7OSo8B3Z0
         lJWFB6PC/6wzf0CGO+Qxv7URIrUYLxgLuSfQHZ+rI2357Wbuku9WmD7f9KBVkyv+oOSI
         DhLPNJOXgWQg9Sq6Z9HsMcbuS7DXV9bwzHo8M4/6h3gpe/6Svu8PCFZd/D72OdozVS5O
         l/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599916; x=1765204716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=nDFz0UA5v3xuYn47zvmSY0iym3kOCtElYlhKGAIbZddxBW9+uU2hOqhVGySfFOOwXS
         PtdLbsmYIKfwQXRqPIuOZIjSvnOPdpMUxg4BVeo0S/TuTMt05xOVDPT0FuwlktOa0UBG
         9CTmF1AxcRkIni7EGY35EYXa0JWylNPYmV7PLHGfxKDoBCgmrwa07fNJ+ylHmTXvCjNj
         DAvpkTeYGe62Zr1BWxYWPlu+byfporxr8S7xTn3d7GtQmkAI8G19Ok5XxDa0l9Oo1HDt
         4zg7cYLJLB1lpyoT3X7YKlueIoRWC2QqgS8ubveYm+sP7uZ34dAnFQtUZhtsWySmwV9Q
         aJSA==
X-Forwarded-Encrypted: i=1; AJvYcCXr/No+jBfZQ4Hclu7A4UIjXe1MaTacobQ5FHICh4K3a60oiqin7J4/b/7mva3sS3Yq9OP2xiECb/JhJ4Dv1XBsUys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyST1ZgeZedg30t/PpbHSA9ODk4mz6NsdfByTddAGVeCbu++tqN
	ugEOlsDPR9FDCK5MTsR7lJCxF9b+xZozfcn10+Ux0jc+s+wfy/9STho2
X-Gm-Gg: ASbGncs7C6uFKemZlAshhxIZxOqABsEw4s7eUIvbWt/WXrYkPzB0v6w90HtiNwQBDe9
	0w8eNm6Ja7XnrvbCfZzeocO4TFd3ViRGUk8+syREIbM8E1yEXBPX/ZVNET1YVLVc0euLhWoZ76R
	W4YtSCQinEofaRp7FiaB3T77xM7Xcmx/Q0DLVqxEilYl5jEPi5UfLDPfvlZ8dCnwj6TrksUiySy
	dnr5JA2nJRCWwDz2HFJxXhCxq2rQ+MAekXnW2NimSGe7lTi6MJMCEegESZ9z/wNf8IMrMtryxcp
	khAAq10/cohaVykdnEdN7wDCYZZu872OwB2U/BvEgcHlLUsnokpZR6xEDisSVx7wtbqRiZMc1La
	u0urfxZAcVrqIspeGJIDkvqRc9flqYZM7AYhzCISn1JYkIgLqqr3WWWzR8BGz025ZlzYKd7v8c4
	4ySmVyOLIdL/VKR3iiTOpyumzGvkQ9UhBj8no/ydlB9lXRlxqRKHI=
X-Google-Smtp-Source: AGHT+IGcQ9jCsPCNuCGcwtyK2voFJsZm0s38+03mKZJ/R8oA5ommDWOal1w4eF2QNct+gCkN7wdkhw==
X-Received: by 2002:a53:acd6:0:20b0:641:73e:c50b with SMTP id 956f58d0204a3-64302ab7be9mr24371456d50.47.1764599915963;
        Mon, 01 Dec 2025 06:38:35 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c078297sm4889911d50.9.2025.12.01.06.38.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 06:38:35 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Mon,  1 Dec 2025 22:38:12 +0800
Message-ID: <20251201143813.5212-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0

