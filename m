Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870169;
	b=THu7HEroA9CqWRZ93FfMoI+BTtP8qodYXBdpl2YuJQKrNZWPIIFCSjfCFJbJwt7rFl33
	 FXSu6swrGq1EaR92I5Se7WbVrXilgGJDiPnYU2yEk2eQcL1GgQSE1HySpUr4H7jFpWCdF
	 5KC5FV/El57rLpvp893zvbQ06AxDNHwzP731XgbVZxJkJRp8c54E3lu9qqiNwkwS08ww/
	 dlzFCz85RA2B/oa8ShOsN5bD3oYrFUBLiJw0RF4T7lHAw/AVhorTtNCxDvk/QDY0Dx0we
	 tD2XLz8Y+32Jtsx9YEGXcCES0aVX/Dl+fPT8lkG/b+9GeMPkp/s/w1MDJe4T8j361Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6m9F/kK+ArXr5VmjxLQQJDoEj3wCb0egZOi1qUsbEAo=;
	b=4teCAA9K3tN7RyYBBsZPzZHUhnNC6fiXlZ6fuZaKzvvFwURQpfr+PfcUg92L/2vDpnOu
	 bi+3u4bDX7fBSu4h9MZBPcMyB5dmh1wmjB+p4c5ShVuirw/IlWtLdKaYt0Nama9G/0wCx
	 5Bp58IPLxywXxNaY36yP3b+l45+LFBG7f2h7/fwCSrn2iZ0pmytv3rSnmfrMx8VWOJ6mh
	 JHCVv2p35R1He1Eb67Ky5VDyEw9gZPddb3BbGOVussECObSS58/Ijz5HbHeNNNGzO+ht0
	 3H/HuaQBnTBJaisVWL7lQvh2y02r1VH90rEydVC1wCAyMR+xivd/0Ntrhtr3Wg0WrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3ZIjZ4T;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDF606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 12:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EDF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3ZIjZ4T
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso12359056c88.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795870168; x=1796474968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6m9F/kK+ArXr5VmjxLQQJDoEj3wCb0egZOi1qUsbEAo=;
        b=A3ZIjZ4T/ZCppyXMMcqSkTfxh5A45EFbq6gUp3Hx3mYXlVHzoes0bQm0jdC+bMsq4Y
         hPGr3IMW5RwSzL4mhAmM+asQXfpZWeAIIp/cPP/G707Wd76uY/7Epu+rHQeIa+qPNvMZ
         iS7AUxuFAiugm0wLz8RqG7h/smO3ZqU1GxxpJIhCEKmneNbuBxZhCA8Wjpc28ayk6sBc
         ZHHOBsWFZL53i6sPe8e4V3Sot449vkeH1x/DRzV9A2wLm7iK+GGiA3KfpuzjsblgfxkS
         N+eUYsAoWLDFj8pEkjmwFdGIPyQD6spOlcqpXtjxgyZkFfjX67+vUrkOccKc8x7DCoeZ
         Wucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795870168; x=1796474968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m9F/kK+ArXr5VmjxLQQJDoEj3wCb0egZOi1qUsbEAo=;
        b=2Guy1soVlcm7+RRUQh0Xif3Yl4KfesAWbTxIyTMGKIjvfsYZTxuvSNSDFp4D80T61u
         1p0estcUo3BKze3oE2zVFxfbKmxvr1j57XZm15WMyVPFVctWVOuicI6qYtyQDOTL6jlz
         WUJ1C2d+3ExTQ7Zuy0QlHTm0BKsZOo/EbCWf/hOtRGZJ4UIb3y+pFThP5jhDt4+PvM7/
         pmAZwWidd/75gyizIzn7te1bvTABxH4SydHTnfeR4ddOaapJmXF4Yf2UwYO29j67jm1F
         oxhigpGI3EaIpdFByTon9f5rAkBkKj6wq1EKX1UqUtE5uOX3+R2Dvjiq8N+oxhwDT8M8
         C0UQ==
X-Forwarded-Encrypted: i=1; AL+hErEhjoRw7gD3oLNdGNPZp7jNs75UCYgEtj52UmY2+ERf8JtqJZax+AlOq3RsddMdcwlNIAxozbJdkEnyKJxn2MMzDJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Px7g9wSHXVuXbFgUjrTF2GqByL+c3a/Erw3t1TMXagxk5+BJx
	4YP7mPoOYESYEOwmG60Bs42/IiePe3hKqFrlLGMfcPA44oMo6JEQ1rgv
X-Gm-Gg: AZFdTZda7gQQfgUNYb3enaraHHH4UYVpgUPbzvEGO0bT/7Kkr+8K2hM0ViCuLpt0ww9
	aXmRV3WjJJSWhqlvnY7iYXiGk+74g/bExKAhfMlh2Gd9qpEMGfbFeUtser80LKN5ulVWPAEONwt
	KBT42AGef+b9SJkk7vhw0yEJHQd6ZmuXSfftGSXmUwY1FPIJeL/rJiPllg7U+875OZjWgM3gw1i
	x4px28j9B1oCLj7H2Douz6zsPRxr1CuZvierq4vbUSxQhrBBcAsBmnk0MeO91JPo3m9zwBym+sm
	p+PaUj8+oHm4OHUDZC14Ms6b9r/lA3NfbO0fBco5rwTJY6EfNVeXyvcv4t8571tT585hm5mSSLJ
	z4Sm3YHhHgeqCNlzA+NGs1PDKke1HQXcnVBlJLzXUU9rA68J4cVTOqqlda537dTEw9oHvMsuhO0
	dbIMFlUSbV5OC7j8KT5sCHEKG53ScqMp9sjHkAY+ZR0WgpxIrpqaEVeCw4OFsn3O6oxSbQjf9qt
	MFmyH2NpLCdNTbHb3TaEdLR3Ml1Ka+svnqxWuhuzm5/+GktQ43tu9TvWVYHy4yzBQoLeQDzpM9t
	zizXe1Kj+QryS6ZXUU1jmRkdjQ6EPxOHkaaAbSU1jkTD+fAtLZDXkOLM0u4bTR84nADbQGWyuGW
	p0hKX0LRgSHdVevXq6uIObi6sbr2/bPkzF2WRMlgbM/48mbA0ejEynw0n
X-Received: by 2002:a05:701b:2604:b0:1b5:49da:b93e with SMTP id a92af1059eb24-1b5568bc648mr26837484c88.26.1795870167859;
        Sat, 28 Nov 2026 04:49:27 -0800 (PST)
Received: from bass-virtual-machine.. ([23.154.84.155])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b59d8c0cafsm10855049c88.7.2026.11.28.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 04:49:27 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gui-Dong Han <hanguidong02@gmail.com>,
	baijiaju1990@gmail.com
Subject: [PATCH] objpool: fix missing acquire when reading slot->last
Date: Sat, 28 Nov 2026 20:49:22 +0800
Message-Id: <20261128124922.3900189-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
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

__objpool_try_add_slot() writes slot->entries[idx] and publishes it with
smp_store_release(&slot->last, tail + 1). __objpool_try_get_slot()
checks slot->last with plain READ_ONCE() before loading
slot->entries[idx].

Because idx is derived from head rather than slot->last, there is no
address dependency to order the entry load after the slot->last checks.
On weakly ordered architectures, the entry load can be reordered after
smp_load_acquire(&slot->head) but before the slot->last checks, reading
a stale entry from the previous ring cycle:

  // Initially: head == last == k, entries[idx] holds old_obj

  CPU 0                         CPU 1
  -----                         -----
  // __objpool_try_add_slot()   // __objpool_try_get_slot()
                                head = smp_load_acquire(&slot->head);
                                // reordered before slot->last checks:
                                obj = READ_ONCE(slot->entries[idx]);
                                  // reads old_obj
  WRITE_ONCE(slot->entries[idx], new_obj);
  smp_store_release(&slot->last, k + 1);
                                while (head != READ_ONCE(slot->last))
                                  // sees k + 1
                                if (READ_ONCE(slot->last) - head - 1
                                    >= pool->nr_objs)
                                  // sees k + 1
                                try_cmpxchg_release(&slot->head,
                                                    &head, k + 1);
                                return obj;

CPU 1 then returns old_obj while new_obj is lost.

Use smp_load_acquire(&slot->last) in the range check to pair with
smp_store_release(&slot->last, ...). The initial loop condition can
remain READ_ONCE().

Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 include/linux/objpool.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index b713a1fe7521..8350302d6e15 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -144,7 +144,8 @@ static inline void *__objpool_try_get_slot(struct objpool_head *pool, int cpu)
 		 * that is equivalent to 'last - head - 1 < nr_objs' as
 		 * 'last' and 'head' are both unsigned int32
 		 */
-		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
+		/* pair with smp_store_release() in __objpool_try_add_slot() */
+		if (smp_load_acquire(&slot->last) - head - 1 >= pool->nr_objs) {
 			head = READ_ONCE(slot->head);
 			continue;
 		}

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.34.1

