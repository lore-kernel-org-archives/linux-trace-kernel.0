Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634249;
	b=wI8/U5s+d1tLBf5gtK0LSVHU2olbfkJ+EgThgXkCrTfIP4amSqYMIJDtPH55F/oO7ueg
	 TkkmcyTM6VRvxj0BvqhegaAGSABqJERAhSZ7yEBhXuD4SzTw48zkV5jqKAlZmtgnN7+Kh
	 w/IXvGSXg95Xk/VFmkvVtB4fxGiwTHkK/C4IO/dS5t8yzYsYdEHNjD2BfvWCcGB48n83M
	 LC4UYyWomf69v1wn2mujd1IXD3w/W48T5ds8I7Ysc9sSOHU5ImNM5mDdylqTtXT454KWo
	 B5r3/YSQsBHsAqWGF5VSn4r6XH9caY79v6biDIY9NZ8F2c89+clZqOOObymwUWldkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
	b=Yq0N7jJNSGjkFXu8PQkVipWX21lStzXS8J8RpPl+oQKH+Bl1ycUeMpy+iKk1g6eqXWRh
	 760n/29Lxf8i9T6BPzPI526fIUYWMAjgvysz2yBlloagSkBvkjGTs3VghgJJsBffBbTSa
	 7kIoIH7qNy+MP/4mzCbkKspoeZr8XeeGVAXXVSKgTbR7v1EH5kb+NnubeH2Y83Q4J4HK8
	 s2Gmk1rLMHVaCvt96Szh/UZdfEm1peWQLJTiVoMJZY92zw4TNH6hV9MIAarcrzdfgRTNn
	 OwZbRp0cb2FSrKiGgOMSNFzZ8f2/Hy4+NtfPH0h55MyTwpXpoMe0xnwOfyjGX0/Pczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F8C606A327
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F8C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hz7IhKS8
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9995ce866so10258875ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634248; x=1793239048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=hz7IhKS8JnGZgEIexGY3I/4re8TbOOzx4dsaeiqtAUO3Mlg2//pA7KdBy10wHrc/WE
         oQkv3BwN0H+jxhBBiDVnqP7ZwfcFe/Dxi8cDyAm0+6qK3rEA+Rcl2yt2on5K7RkFfAd1
         JjfV/kqtvP3+GekJ86lvyfLCOfqfl6iFx3ByUKBSkZqqEkHrve8O51W3bDBcuvkErXuh
         /WNVdOyxsOBwIwnKzPKYLibS8H+/yd9dtsUyWlLO/PUUQdtPF++7YKthKoC6GJwUm/GS
         Qwb9Ec4xTK+9kEgeBXfzU4KRlJJ0yqpphEfA5EmlI19T+diFkzHeCGq7ZMN2TI0CTJry
         Z0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634248; x=1793239048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/p+8Vl7+8PhXJMc34NF0xrQaeakIDsKG9S8+b35h8GU=;
        b=m5uA2Y9ANQn4bECOmHkhrcSbbhRj9aNk+XFhU6g+4XLmFULKfq7hIIqwtqnxyH3is8
         pV4Q6mDvZoUJG1lnk830ounT+xJ/qocirA42AiHOFS8Tu2yvkDo/IRYPA1D5+go8w9Dd
         wRUwhRQzQQB/YGj9YrEiKpBuUNkXZA5eo9CXEvfiwKf/iUy0Le1NL7/MbF84prqbepPN
         jYvjoMxKOIEx3q+uQYU2NLZPcXblIObHvXOPu7KcXEQ4koH/zqz3zBsaCrkocC0fIOeT
         RCq7uGZuU8WBpE8Q4Lq3YZBLDCsGK9hD558dZBzfY7EH8RlYf4xJqd0o4ZCAkS/l/BvV
         envw==
X-Forwarded-Encrypted: i=1; AKwUvBwrcecGO8jpCMmpk3HdV64wqoEyMUK0ZgjUlTzFiViI0XiBfWZxA/upjjeeBiNQOoAAgKr4sMdJogrqreE2U6TQPhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvcZS6TL87fqaWhl/5ROghlRRdpuUXqqvyCqbXRLqOGX51ANPm
	HFVPP7Djtae+gk/7LypLxEJdpk9z462ZSN1jOfeZ+7EvOqdeHtckARK7
X-Gm-Gg: AYBFou3hpIfymqZyvx7kAZ0Kp9LxxkmPBrJ06MSrF/YHtHb+KCflrEDkh2PWcHD7SAf
	GKN0Kq3Xrlw09gu79DUPIqX109dcDivsd8d4GqcIsSW+HUHCmtd12Vso9hEmiUUnuVWvUCiCs3I
	+sG9lg4lsGk31pLlKOJ21QBHxAaDJ7ccEd0FeIPdXsCMXSNsQi1npK4LMj059/q2zC0nZ7JynKM
	B5a3fI+w1uQ3maQKeEzczJK7QV7fb/IKJ07aluWakzhF9571/f3jARAYRK2ty/Y2JyztD2B9XfT
	kwPfzVYG325us1TL6R4atVXHbLf1+GDIYAgy0GjTJeaD96nuY6rXfg+o5vXrUFbVYg2q9+KZZV6
	/43m2T9y9NbJoCvK+Hx0KTbWXnNijOF4+ag0FrIbqsOHAWIXi8S2Qg5ibKiS/e7OoYqM1KgOP2e
	r8MwIjxAqHL+0GW6AwXJbnvanevvsIZvgMJhLJ1+GNUw7yaxo4hWJP5BYNGzSiTff7V7Q/1wy0W
	ncjCqbVVdlK45WHgEc/iQXujLJaXq7JDA37WeVOJCYgXWocq+zHCrOyAhUovrrp0buuxZqvy4Z0
	5cqBigC+RhbNfbQ6Q42CUeoEiPddQtmtR2SNmHRYujZZkPr4ZowK5wn4hAkY3X4HD3NSzz5euCQ
	9q+hSFMOPYA4Wd14BCIHR064t
X-Received: by 2002:a17:902:da8e:b0:2e9:5829:9b41 with SMTP id d9443c01a7336-2ea43e20647mr33495795ad.37.1792634248345;
        Wed, 21 Oct 2026 18:57:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4addfbsm16725685ad.74.2026.10.21.18.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:27 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/9] uprobes: Don't run exit_mmap() under dup_mmap_sem
Date: Thu, 22 Oct 2026 01:57:05 +0000
Message-ID: <20261022015712.1297331-3-alexei.starovoitov@gmail.com>
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

build_map_info() takes mm_users of every mm that maps the file and
register_for_each_vma() drops it after the visit. When the process has
exited meanwhile it's the last mmput(), and exit_mmap() of a large mm runs
with dup_mmap_sem held for writing. Every fork() in the system waits for
it. Use mmput_async().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/events/uprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..6792004be6fa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1250,7 +1250,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 
 	prev = curr;
 	while (curr) {
-		mmput(curr->mm);
+		mmput_async(curr->mm);
 		curr = curr->next;
 	}
 
@@ -1324,7 +1324,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
  unlock:
 		mmap_write_unlock(mm);
  free:
-		mmput(mm);
+		/* exit_mmap() of the last user must not run under dup_mmap_sem */
+		mmput_async(mm);
 		info = free_map_info(info);
 	}
  out:
-- 
2.55.0

