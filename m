Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440034;
	b=Vc7SwrLnS5R5te17kb1k9hW5zgp3Y9aEMuPNW6NX/Nc2xu751GkaadpVHBbJXauMOx3i
	 jOTDTQfG7YF/JXQSVES3CEFF+TraI7iVkLRhwe3Ukvp2LsRvDIBMz1A8/3n6lM50IzLhD
	 8sH7jEz0ZEwZc3nMgMhovyj186V/S3l3GqdDrCr17v3e3raxUa1Otmu8zGPN/Ger0VzDK
	 IEGcVZ4M8FOpMJH+BA2Vn9q3i7IMpv08hw47fX/DHgN6ix7tKffTTnI5gGbycmebMA467
	 BPQjeZ+yl+mAEk3epaXQ0NHkVFA/fqFzpfM3EmCPXCsD7+Npv+wptq9KhJnWtRcOu7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Zv+ACCU+gHv1KzeJikhPVLg4kdjDOuVU4kYmmf0PDRA=;
	b=nyNxW8m9GcZJ2n7PBVKvVnMXv4LbhvYpuowZ1P8we9SFSS4WYY6TDCx9HkqaZZr893e0
	 GH6uxZDuzIBvEJhjrvM2Cj+RAKamxVH3MlECgx7EGItZiFA9IHoKNlWrnPq5/m5ni9zxA
	 SXVnclXNHDmcdz/iw2u2FhrgD3zHPYKlm14odIIUnobCHefGsZNkcw3CURknaldo+fvWO
	 17ZjP1pb7aB3GndJUisr2IBuuTvkHo1e0JZExSlHOfwVo6BLwoTMcqL6IbeklzFWR/aSY
	 qde7VlKR2HKT27mIhkVukEh1fAnfaeIkQVw4CjUbRQEHjwoB5nZvmSwfILIbZIheXkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KAowDpbc;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E573606A325
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E573606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KAowDpbc
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1665200f4c2so3488681c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440033; x=1793044833; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zv+ACCU+gHv1KzeJikhPVLg4kdjDOuVU4kYmmf0PDRA=;
        b=KAowDpbcpTatrBpJIhGCj4z2Id1zo8aJJxGTibbWHJgzbWEdn2oLyupjqYXCnZF37j
         N8ybfdP+gFG5I3dUHI1my+uuUBK/Sb4blfOEelSqrlzsmBKIseeRqA1/NODbizJ0PyPa
         5B4eZYpQjrnCkruCdXvS4cfLnnAtgG9PnCiKIiQ3OXdSyTZpb6l3sk6DhBmvrnNyXG7Z
         rl9qiJCbzs/9A70rOtGbWr9S9sBT3Sa/tcf7zbFYnu2r7soK8H33fjAPZk8av8ewZjRH
         gy5EsxslplCJ/QGgm2Poo63NonWdun8yfbLTNSzIG5GYYoeSfWXZ0+pRoyZIepArQlFo
         gbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440033; x=1793044833;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zv+ACCU+gHv1KzeJikhPVLg4kdjDOuVU4kYmmf0PDRA=;
        b=kadElDTru70VYmZ4ywUIwVgCv0ZGbbfj7k8czlhzKt//YinJCZ0T2hn4r9VfeazlN5
         ABVflbz6wsLeMhtLzbCi1MywXpjEAif+a9/VsHmnTKCLk/3DwLyXOg0fVjHO+eFNU2Au
         K1YWUhrKfIVAuM9GdSPx86dWMk1wrdxxvEelFi15m8h/O7NLQs4SBVdXUvx0OQBXZAR3
         hD2/D7+klfcwnI3nabloWzYo0R/MGuUkyluo38edfm/jcgyPmPu2X2qW7VQYmuqHpn4H
         hmmX/+0BhgHtqBm7JJR0UrRop/tl9eCd4k0iYGs2aPqvj1epYlvs1mx99COu4FV86uBz
         s/Wg==
X-Forwarded-Encrypted: i=1; AKwUvByfTqqQL7sumiyOB9fyKbV78B94sZqBrWVvOwx7szNFQiaHdfKemPZA//jIYxHcmECHT9ddA6lR0n83ONxh1flSkVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbeKPSVtRYo85WFTOeurax8P3sEbPRQcltYFy/7Vdqo1W/oiVb
	/OPNHfJEZOHmXnJNY80ZaNWUsOI4N4cG89te+oLTI7lq7Mb01y/abw9Pxjt2CINaH5aBnLejDJB
	qIeQu6TtF9tO5qGxfLz3ouOctyEmcOiEwZg==
X-Received: from dlbts20-n1.prod.google.com ([2002:a05:7022:b054:10b0:15f:5ef4:b896])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:208a:b0:168:fe32:35a with SMTP id a92af1059eb24-18512296a20mr11988623c88.20.1792440032834;
 Mon, 19 Oct 2026 13:00:32 -0700 (PDT)
Date: Mon, 19 Oct 2026 20:00:26 +0000
In-Reply-To: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <9e49a8f68e4e7d25c5a9a73c1926f68e468ef320.1792439751.git.abhishekbapat@google.com>
Subject: [PATCH v3 3/4] alloc_tag: Extend allocinfo_filter to support tracing queries
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the allocinfo filtering mechanism to allow users to filter tags
based on their trace state.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 include/uapi/linux/alloc_tag.h | 8 ++++++--
 mm/alloc_tag.c                 | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_tag.h
index dafcba2f7e2c..a96054ac2237 100644
--- a/include/uapi/linux/alloc_tag.h
+++ b/include/uapi/linux/alloc_tag.h
@@ -38,7 +38,8 @@ struct allocinfo_counter {
 	__u64 bytes;
 	__u64 calls;
 	__u8 accurate;
-	__u8 pad[7];
+	__u8 trace_on;
+	__u8 pad[6];
 } __attribute__((aligned(8)));
 
 struct allocinfo_tag_data {
@@ -54,7 +55,8 @@ enum {
 	ALLOCINFO_FILTER_INACCURATE,
 	ALLOCINFO_FILTER_MIN_SIZE,
 	ALLOCINFO_FILTER_MAX_SIZE,
-	__ALLOCINFO_FILTER_LAST = ALLOCINFO_FILTER_MAX_SIZE
+	ALLOCINFO_FILTER_TRACE_ON,
+	__ALLOCINFO_FILTER_LAST = ALLOCINFO_FILTER_TRACE_ON
 };
 
 #define ALLOCINFO_FILTER_MASK_MODNAME		(1 << ALLOCINFO_FILTER_MODNAME)
@@ -64,6 +66,7 @@ enum {
 #define ALLOCINFO_FILTER_MASK_INACCURATE	(1 << ALLOCINFO_FILTER_INACCURATE)
 #define ALLOCINFO_FILTER_MASK_MIN_SIZE		(1 << ALLOCINFO_FILTER_MIN_SIZE)
 #define ALLOCINFO_FILTER_MASK_MAX_SIZE		(1 << ALLOCINFO_FILTER_MAX_SIZE)
+#define ALLOCINFO_FILTER_MASK_TRACE_ON		(1 << ALLOCINFO_FILTER_TRACE_ON)
 
 #define ALLOCINFO_FILTER_MASKS \
 	((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
@@ -75,6 +78,7 @@ struct allocinfo_filter {
 	__u64 max_size;
 	/* filter criteria only; see allocinfo_counter.accurate for actual accuracy */
 	__u64 inaccurate;
+	__u64 tracing;
 };
 
 struct allocinfo_get_at {
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 9ff9dd04d692..0d4d267c065f 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -250,6 +250,7 @@ static void allocinfo_to_params(struct codetag *ct,
 	data->counter.bytes = counters->bytes;
 	data->counter.calls = counters->calls;
 	data->counter.accurate = !alloc_tag_is_inaccurate(ct_to_alloc_tag(ct));
+	data->counter.trace_on = alloc_tag_is_traced(ct_to_alloc_tag(ct));
 }
 
 /*
@@ -323,6 +324,13 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
 			return false;
 	}
 
+	if (filter->mask & ALLOCINFO_FILTER_MASK_TRACE_ON) {
+		bool tracing = alloc_tag_is_traced(ct_to_alloc_tag(ct));
+
+		if (tracing != !!(filter->tracing))
+			return false;
+	}
+
 	return true;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

