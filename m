Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819029;
	b=dTRuFtL2fDqOOm8gmh+vhHJBmX/HlW1Olqf/WgR4fAxjxv7SR4SsyP2KExruFjMndzjC
	 RPNLTVq9Z78vVA43TaPKbVALOD4ToRJzRKepp2wVz/hxhFko428RHp8xifOf4op04Xzv4
	 AmNcj+RdMEWct0DhS/jiVrKvsNWKF62+sciU1bAqCz+qZuD6VSfsfpVz4yhYg1CXuhU+i
	 tuulN1L/MfSEdkQuLbiik41fgkd/WteCHn4/A2acNgp7Hf1JSfzM2JXMyUbDnmvuz9O4W
	 cwvF8tIflTlF0IXn5awmpKZCB4m57IqS09t9wx7xmRENtdrP9PhfPyXj6Lk4OQb4VSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DUcpgfrjS6s9SSnfNEZAg7l7UHGbgZn+gcmgz0ne79Y=;
	b=dVUN9/s/DKS15dA6bwxBk21JL00FBT3CLsF+zG2gFvoNUDOcxS7PqGw47sfCb6mt0Y++
	 0SaAozoBJU54D1GMjT5tjr8KFePK7pSzJqqzzKZxxewl98xF4CUAN60muiA1AKZCrpgcD
	 bN1iuUWNQiN9w67MnTaKaChGX3KCygGDOlBCvMSV1KssaDIRwP4ujoLaK1nhGKW+GVPYV
	 xaCRKQ1J84aGzUwlerTEzBV/7nycuGNC4PIV0BP9qzcU/i2CeWtHYNTU94pi0JuHYMrlx
	 pZAShg9Yg5IBnN96apb33EtzTq4rm6E7O8auhquRS8r07WvTN0GMbR+l3xE/awTNgRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W3qSnieE;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552F606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9552F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W3qSnieE
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3692c5b061bso2608595eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793819028; x=1794423828; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUcpgfrjS6s9SSnfNEZAg7l7UHGbgZn+gcmgz0ne79Y=;
        b=W3qSnieEv3jiJcclT8d/SE0uy8PNypTpF80UBiouOmsInqZ9IsEBjx+E2q2cxbxozM
         E+D2Q9yznKCT6R8XFeit0bZB7mgVUd7TqSn7BYumptuK+yTF5VbyKCFZ2raGc9CQ2PdL
         5EGNw+JuGsg38DUPJ6dO2BpyTLdaybBys3KOdMg203gm1TWLF+lF2QoOE/NxYNAp+6N6
         c6tXQaEm4rUtkuRGyi7ne6hMHHsGOFGDa+thGyUaUsdI1hkf8+pmm/D80lk6n9wylfiV
         CW37GOfaPSw4ID9yqzYt/Jtw8C89NorSON5M29/QRiKJaP4jIozUQn/CNzokqyX9q+5k
         JUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819028; x=1794423828;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUcpgfrjS6s9SSnfNEZAg7l7UHGbgZn+gcmgz0ne79Y=;
        b=b+1gKVHxcOzsRjO6Bu8BELbwUaUxygttGtdPAAXYPlPy1IAr8iKZLPs6t0t4QZ3fhH
         aHlTJE41ApkyyQ9aZo8Vir896GUeJaMOJ2g5ufZ0bFrG7colGE6d2MXWqczovurJk6IS
         w37URXTXdXts/e3pMsFm/CaL0scz4saXtUERfpR8Ep8uO//kdzJDnzopX06624fnL/Ps
         pciWl0AXMHYprIcYD1iXiFZe/Deh8WbgCDsUviwDXaYkQXthjksnIx+gkJWzLLBPZZh7
         CLxg0pqnHm6TgzrTCQCH2uT8c3IChfnb3JMstch1YWXtxwZfkx0oBxxnwnLWlMKx2d07
         5CBw==
X-Forwarded-Encrypted: i=1; AKwUvBw0VEw4IMvl2T0Soris/a6yzYbQrtf+7VNTpIFQE/aukkz+d/Ee0rAJNrlW8NiGNVo1Sq6zhF2GWjbbHkbZu6gg1HU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vkGAKJhgl6dTM1AFufcYrwFlZUu2tn8LOX/Kj4BRqeNhoDwHF
	MRus8XrMrkxIfGS2u6mSWSRp5AxZ1FTl5NCiyrHAiUrRc5eLVpo9yH+5/X0/081Yc4ol5tALv2h
	4Wy+/CXPoFP5x3hV+hrmhJZDspc06RfyqBw==
X-Received: from dybgl9.prod.google.com ([2002:a05:7300:e009:b0:36a:c06:2852])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3d17:b0:36c:9af3:22f3 with SMTP id 5a478bee46e88-36c9af33136mr9263147eec.37.1793819025727;
 Wed, 04 Nov 2026 11:03:45 -0800 (PST)
Date: Wed,  4 Nov 2026 19:03:38 +0000
In-Reply-To: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <64ce5ba6eedf0950c22d1416b794e83afbab8ea8.1793818636.git.abhishekbapat@google.com>
Subject: [PATCH v5 3/5] alloc_tag: Add a flags field to allocinfo_filter
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

struct allocinfo_filter uses a whole __u64 to hold the single boolean
used by the accuracy filter. Adding another boolean criterion the same
way would grow struct allocinfo_get_at, which changes the
ALLOCINFO_IOC_GET_AT ioctl number and breaks the UAPI.

Add a `flags` field that shares storage with `inaccurate` through an
anonymous union, and use bit 0, ALLOCINFO_FILTER_FLAG_INACCURATE, for
the accuracy criterion. New boolean criteria can take the remaining
bits without changing the struct layout.

Keeping `inaccurate` in the union means userspace built against the
older API still compiles, and the values 0 and 1 keep their meaning.
Previously any non-zero value selected inaccurate tags; now only bit 0
is checked, so a value such as 2 selects accurate tags instead.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
---
 include/uapi/linux/alloc_tag.h | 16 ++++++++++++++--
 mm/alloc_tag.c                 |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_tag.h
index dafcba2f7e2c..2fc843bb06bc 100644
--- a/include/uapi/linux/alloc_tag.h
+++ b/include/uapi/linux/alloc_tag.h
@@ -68,13 +68,25 @@ enum {
 #define ALLOCINFO_FILTER_MASKS \
 	((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
 
+#define ALLOCINFO_FILTER_FLAG_INACCURATE	(1ULL << 0)
+
 struct allocinfo_filter {
 	__u64 mask; /* bitmask of the filter fields used */
 	struct allocinfo_tag fields;
 	__u64 min_size;
 	__u64 max_size;
-	/* filter criteria only; see allocinfo_counter.accurate for actual accuracy */
-	__u64 inaccurate;
+	/*
+	 * Filter criteria only; see allocinfo_counter for the actual state.
+	 * Set ALLOCINFO_FILTER_FLAG_* bits in flags for the criteria selected
+	 * in mask. inaccurate is kept as an alias of flags so that userspace
+	 * built against the older API still compiles. Note that only
+	 * ALLOCINFO_FILTER_FLAG_INACCURATE is checked, so a non-zero value
+	 * with bit 0 clear no longer selects inaccurate tags.
+	 */
+	union {
+		__u64 inaccurate;
+		__u64 flags;
+	};
 };
 
 struct allocinfo_get_at {
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 9ff9dd04d692..504c1a85050d 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -306,7 +306,7 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
 
 	if (filter->mask & ALLOCINFO_FILTER_MASK_INACCURATE) {
 		inaccurate = alloc_tag_is_inaccurate(ct_to_alloc_tag(ct));
-		if (inaccurate != !!(filter->inaccurate))
+		if (inaccurate != !!(filter->flags & ALLOCINFO_FILTER_FLAG_INACCURATE))
 			return false;
 	}
 
-- 
2.56.0.506.g506a7eabc5-goog

