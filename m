Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634242;
	b=Jx/nidxynE4sy5vPKN1it8bmoHLD6rXFktYpFy6Q8lxdrAjY9vjAWFluVSXrYIr0rblX
	 dTex/Mm9G2lBxoz84YK3kxRWucPfEODmLo/mDSpZQ4Awjp4BCE/PwumlMrqaaTs7NzXna
	 g7MlPHwjZdbCqD4L2gLwR+nGIvR7m1lCfA68xCLx+8P68Hgh/jaxwSO3UkzUSLnOiF/vd
	 Xv+PIzaCi1xr9vAx91ZWE0DG6Yyc+5QNL7qEU1QYRGq1loi4AwHVpXU/JQ2K0LcFOhXnw
	 a1S5HBYE1ExxDENUx7ritj+AXyMluRpODR4PZ2XW0veG3diaG9Up8/RjN+u0QDD5V4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
	b=ouYm9OdXRm//G2sKXKcw9/aemfg8vdw5jrHEGQcw23ZtKbluiqdhMVsE/NrIJhKzly0+
	 exdobAFHssTQciGj7k3+3hS0yHqhC/sAVKTc9XZ6obTGPdpD32fc/AEU5aeR6x2oA9v3D
	 FkaDj67nnlbfkXCZ0B8PJOXXLHss5zO3+9PBEl1083nsmi2XJs87UrhewW4rEi2CMimB8
	 toPEViXO3g3b1SRngU0i0qdDzYpG/VjF5X6GXD652rQyHNQKGz/LttbbCwkRZ8VFOqpc5
	 s+utYxeoOeS3OVva53AKx40/4NsgV6Viw0Di6JmFKdthamyFq+iaSLiRzVgC44nt0Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B1606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 118B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so482277a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634241; x=1793239041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=LVXHlWxbt7zTnrfwpRAAKArh0anXhoxyz4LkMwz+U6FjFY5B2RWTV8bC+BeBzModcy
         MK+4H4Ae3Ve+k1MNf0Zf014GvM6J9em3f4qVG+we0Q8zEPfVLgdcaB649f2cQS7nA1XH
         vaosoMUbUzorV4pFiZQNrT1hM//xValQyBYVoQU8m1NDBEK6BIFUexceMPryTDME+2OW
         hpW6xARLpcKaJAY00VViOSCIHdKgEO2VvSCBhgLVvBFgbN1zVf+TeOIHJoBJHkkUbMXZ
         vX7h6qcfbyRFwm9W3KL1J3qhzniEtgZJEwAiSK0p0xosjCrYNJJ2ULGUrUSOtulbnxCy
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634241; x=1793239041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=f1N6yfkoU8cs7wYWEUbYVBk2mlkeH9MCIzMA3ME9g9d/B75F1Or8yIyQzRid6wCsxI
         69GsX6VfXq3rK9AUm9X5NSsWUHUkjSjg2smtsyL8213Bi0P3PQYeRqNuKkELrkXv2vZU
         S/BQAeIYyaFbM/Yk6ra5sUQ6gtzHRuN6QUqwwPskWi3hhbRfw+TS+XQ2bh80hGehmU6f
         pq0wWlTIcdHUMWWwi7chnU0aYH/1kSfZsvMdwbhInEJ/vJaxIBw9/f0bDnB0amUJHYR/
         KbqSwUS8Y7ZwB8MITW2lATwElQe0h4HnlzywpaEV6fh287KSmGqxC8e3+u1De2XkJeZa
         GYbw==
X-Forwarded-Encrypted: i=1; AKwUvBz/T5LS3sJRfw03eFqid599YihGKhO+0quTS5FWkoyfNOPMF4nDL7kOcMB+F1aNHDm8KXre6I6w8jB4iKfrLQWsEyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhPa4WE3nvCQAyBOxi/xb9IzYw36VMXFTKjTEKRs6u9DsQnOCt
	2ptxc0z7PjPl7p3xljCwpU5X+K8cOQ5UQVG5htpfu2i2qrYtP7nNxT9M
X-Gm-Gg: AYBFou27skb5RtQdrrfFPIOyUQiJQuqHu780NPPLdIvIdEVnmToEkCI0lIu/ZkwecJR
	Zi5kBLvKiTfCXbAPXhBXn3yl+LKMnMNAoq75rj+V16/W1S9hXjkEgZ/fbY6UP3uOxCGkg9Lar4b
	watiinSLU4+3eJIHKStkrhHIYcq9pjLSg14WWly7yhJ/JcmUVshUAY/2h0FNVp2CujcsDjr74Fc
	Q21p6keCiB2sTCdVEwtSUA/u5DL86TUSSVnW2yinVJgM/mblU7tN1JQxTUB27LTs34e8FwU6JNF
	zypHpUiezodWa86pqvq5nOFJRG+wxRCgUnP8mvlPXruW0BImFdI9qpubgEYW2JXIJZpf5XZhZeZ
	T+4Vght4URmj3DKh4Fr2UlEG4hIssA1mwh5bboPE869XT6XqSkdbnpk4jb5h4FAbVDZ6SlUGQXi
	sZgy4BJm9zPsS/4k6ZsKSPk0vpHkmGg/ntjxXaZ71kNsOx8NqWHHRydJwgDu9FcNksjvC9g1a8V
	lBFAy/r/IlwKA0zvTOWL0c0j2pIWI2UmjJk4CK3jQNqGWkWJ1aBZzLpPLuz/I/SqnDfu92gHEvb
	fnphQicL/UYxp6sTuscLTrXzqJbhXg1/VonoVdfRys6Ij6t1+Ia9gSxasxw3BMD4+f4SjQnRdJ7
	RLXahmRVymJ3SRlwNg1xMOiH6
X-Received: by 2002:a17:90b:1801:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3ad86c79098mr3189121a91.16.1792634241278;
        Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed70dsm1701803a91.4.2026.10.21.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/9] mm: Bring back mmap_write_trylock()
Date: Thu, 22 Oct 2026 01:57:04 +0000
Message-ID: <20261022015712.1297331-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Commit cf95e337cb63 ("mm: delete mmap_write_trylock() and
vma_try_start_write()") removed it when khugepaged stopped using it.
uprobes and dup_mmap() are going to use it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/mmap_lock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b8a13b8d36a4..e5420b0ce61b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -566,6 +566,18 @@ static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
+static inline bool __must_check mmap_write_trylock(struct mm_struct *mm)
+{
+	bool ret;
+
+	__mmap_lock_trace_start_locking(mm, true);
+	ret = down_write_trylock(&mm->mmap_lock) != 0;
+	if (ret)
+		mm_lock_seqcount_begin(mm);
+	__mmap_lock_trace_acquire_returned(mm, true, ret);
+	return ret;
+}
+
 /*
  * Drop all currently-held per-VMA locks.
  * This is called from the mmap_lock implementation directly before releasing
-- 
2.55.0

