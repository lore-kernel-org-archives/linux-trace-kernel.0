Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690711;
	b=ioYphSYA0YaW1yCX+R7CCpChjpMmn1rRaSwmrP3NGyGL+Dl4QqxKBIl4bRdIoi6g+OL/
	 GttQ1+cB7ernKRO5qkr3FNWMX5oHa3iBnc1Ek/xrpNCMaW6wh6BgikCMUqu+PksS2CHOn
	 +wZQyFiSZngEpvyjo+XCHCQNaqwT9UwPHcnDv0aM8LsBAXoLjLv/TF3tV5RUffVoPgObf
	 rxK8ZofBZC6Zj0Vb+2QSiVC7h+ZUv1212zV2u1MiwnoZGvpPZWeX4a5XFAnyYrd8K7iaP
	 dTDOKADw1nYTn115zGFjZwBDTcOloERdaDQBY+KPopcIIOIueAKeyqusPAKPE65G0sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9N5nOe+oo4V6R+TK+YKdXm540y3qbeMY86DYHWBNfzc=;
	b=gFuaE0n2CYRR6KqFjDJeMZwK2U3YriEJdfdO3ZF52rm7fk4UUsiyLypBtgHh4L3ElVIl
	 w/kBYKpIzkhDEAiprOAT1XTo/M/UNbP8IcpaEpUoYfpJ9kScZIVF0hKJyWgz6b/bhTpNI
	 SrepF5uckFHjvD6ufdbEPvhYTK/bW/QMgBkUVSkngWsV2oUs/eOpdy9RjQ/K984vT4jCa
	 pnLs3L/3HSH1tBVI1dH881j5XjD+jXY+lQb6RftwC4TKSo8xmOUaZRXEK4hjorsfub5i+
	 fjkRtfQodDI8so15Z+EQZpwj3IHYVa/eMwRTikNka6+B9EyM35LDxV5Xw55+rOqdRPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BB+koyOo;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2981606A33D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2981606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BB+koyOo
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso16553c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792690710; x=1793295510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N5nOe+oo4V6R+TK+YKdXm540y3qbeMY86DYHWBNfzc=;
        b=BB+koyOoRPY/VH0OhYzExBKZka7MjvHJ/ZXWJddSqhS/B+wL3ncPTfIIo6ak37BqC4
         JvjJ6M7jr/2SeV90CX3t2WOFXppLb3yDW5HjVTWEA1yblMMHRIjwNccfEOeBAJPQFa/E
         LnNoH8AyW7cUJJgb6VQZtxkVzX6g4D72Fypux78qrgTrYo/mIuQ4SP368Y9ITaV0o9PI
         6IsvZ++qXgWPFajxUekQmgZO6lFfn3Ar4t40YFyWF6fh+l4NGp+Axv+67hm5K0xT57WD
         V7piQb47iE6wlGd0Wq5e9KdvCbf7MuOZ/bgLJ1COGAS02DFGkp4lZ7mTqGxoBEytq7Tz
         iPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690710; x=1793295510;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9N5nOe+oo4V6R+TK+YKdXm540y3qbeMY86DYHWBNfzc=;
        b=ABaBSqk7OYKOzvPnzTYATjl9fGMjCp9KMJwq1ChcSbuM7RcOcwFgN0THRlbFad1OSI
         TQKlmDTjPDNJ5SR71+tiHF0EHxzRrKSpnfHJkgKoJPtNx1xgoEUjcVVZtcmNkSVDoaE2
         3YsBXJBZvjWRyMg3AUb679KKb/Ul+O8Aq/UO653yx2fVQXdL62zdOkGSBQLGwPSLPzap
         AZuoLyUhGmTqPFCE3UkyFwH6FpoM9ADY8uRHw6ufVK0YFwTKDd3DRtPp7msQJSrbJdEc
         wrvXGD3F9LpFIsB4QFmRHBcfFpvUY6PNdOh/bx1MTOiu9SsF5LvmMTJkjmh6x9pXawyw
         2fyg==
X-Forwarded-Encrypted: i=1; AKwUvBxJhpeB6n/V8CebiOdNR05Blk9NguYmixCCYotbYMkw27J2XnTDVlgZ7FB0iOeRK8sE0NKTomN5BKKoqkZHCszugSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwVx939c9B4jwGjsaQiKa97ZamOM8ASZXz1HExjGfEZed+4wz4
	95MgT6ciH5v9gIA88j4oBiAhq24fEBJE5H6R0c9oSON1Yly0812QQ5BIXvi7Mfz5YqoDqe+IF83
	3i4z2Ykr7SIyAYf2q8BN5qrDu0xz8qT3dAg==
X-Received: from dldz19-n2.prod.google.com ([2002:a05:701b:4193:20b0:163:a42e:b837])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7f14:b0:151:6e80:ba7e with SMTP id a92af1059eb24-1909fc7c7e7mr6852867c88.4.1792690709680;
 Thu, 22 Oct 2026 10:38:29 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:38:22 +0000
In-Reply-To: <cover.1792690544.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792690544.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <f577c773058265f0eb7fe2c10fb6aa4003445a00.1792690544.git.abhishekbapat@google.com>
Subject: [PATCH v4 3/4] alloc_tag: Extend allocinfo_filter to support tracing queries
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
Acked-by: Hao Ge <hao.ge@linux.dev>
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
2.56.0.257.gf7497c7d27-goog

