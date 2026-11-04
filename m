Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819029;
	b=cKJhF+IAV2DjQQieNlTR0O0er83WX32kx4R2qxITJSDNoRvQRq/Q7DZxd+zJu7VP8gd6
	 de/1cIFEpcBzdWXK+f86DNbnRXwtrBDxXbJ70FTM/0VffVgv46V4whkNR0tXWseeVi/e9
	 ikNBme6EGvJJTGpJ7zHGGElkX6Y557GdjEBU68VODGmXvo6Ad9l7EEqMxBJbS5FGjde7O
	 ai73+VrPLsKkSVqfyT3bcONaRQmxsDR0OS0SahTgu3T/PvhU26Xj8gYh8XU2U96Kzwmd3
	 4VVCDMz4H4h/0fTnppYigpRvcaAIQfaSC20r+np1OaTI7IEMZ3qsvFt3BwTxD4RKOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=R1wTzVdxrTRC/qBh+6d+SrZjPquJu2n+wXysktuAQQw=;
	b=A4ycanHdMO+zM7GSaSVhd/1DQevELaTUIIoyyRbVgXFc0KfACcWQvcX+OvpacJ03RxV4
	 rYfM+d8eKvcXSP8Rf4QvWP507V1vbzICEqsTP1eYagD6IbR4thh/3QYb4s4+UndqSypvf
	 x1aHlYMDUaTxgivptsrJTahqQzq55ZHXEU1VtR9dq+Bi811QXn6XBuWtyHxuOqCTrT/Q7
	 b7vIIQIhR3/Wjmgk6tL4QeOyaeslIJJKt3NOpbLpvXaYeYdGq6SGSCnYJwIeaStLMOTXu
	 2wzmWAbxiFmjV/Sje23xcediGA+c69BtTY6feOpXEk7BJ2zfFzgqJSr8nf7kFaDk+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="dWK/O2e/";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BD606A328
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4BD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWK/O2e/
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so1842187eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793819029; x=1794423829; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1wTzVdxrTRC/qBh+6d+SrZjPquJu2n+wXysktuAQQw=;
        b=dWK/O2e/82P/RAsHXA6dG631NPInpH1FjQQ4OcoH9CRL/fm3tM9ZEpuY4FED5ziGs0
         kBxD4FuZLOufilZQzq3Lb+ujkuiUpJZyWas0bEm8ZQS0uTLv4vyoh3lT3Mte5+P72nde
         +1HhdVNz4btg+oLY/CxSWwQFFOAFXPSfnFg+/amp+CT85abPXzSsYQetTbKPsqwH8YbM
         VrvtN4LmV6BpHdlRokPPjt/dWTo2bShDTWmEfdYSQebFl2/NXnKhd8Cud3p9o7iw2AgI
         v31HY9ftqTCD5OareFZI1s6hxqBygv5Ho29Z5PURh98n1OsAJtL+HzEQ2/VlBpwSqpsK
         PdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819029; x=1794423829;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1wTzVdxrTRC/qBh+6d+SrZjPquJu2n+wXysktuAQQw=;
        b=I+qZkq0mYM4jTZx8QXkvfNeZ98jvZZCqMtwkb2ENbD3C7bvFzfCmwDOKLfDbr9YZd7
         bN/NQWlEKkt1jgk0ilLl4zwfIAJDaomfsqxR95uoFuiOxMV3DjVt21TJPF2d3YdmTooD
         gnFpSR9/k/Im1vJhe9kSAkkNIgE2HaHBvb7rxD+xvikefyv3pL3anEyofsVWkazsuTkJ
         VrgYv77Rq0q4xOW8JDGnS/NRVX6sELImnlt5hpxp3NQ9E6F7pU3f9ziNC6YWEo4RcF01
         PM3yaVymbQdbY6vIOUkfESX///X+HL3fxy0aRIApwVwM7Xji5uodCQjwv/a1jwQYHYbO
         yPPg==
X-Forwarded-Encrypted: i=1; AKwUvBygafha2NKXWK4wkFLhL3+Yu0wlEhMz5JQ1r+RHJAScmls2flvBuIXlkOTGBvoAG80lF18+r1XIPRe+zIMAksxpWaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j9i4APhnJg1T0uoItC8h3g/wZv4xuz2N3KxQFjlBApMtr4RZ4
	KrHoLhg2+bVh5nDQPgGDZxz02RVad2SOwrS+LeGCN5ckSslaraNpfFXGi//3qtCnqzCC7y43KL8
	sqbY8JDQPX8Zd3h+6V4r+2Wb1tKafu+w9Yg==
X-Received: from dlbsv9.prod.google.com ([2002:a05:7022:3a09:b0:1ab:fb55:f657])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:258f:b0:165:dd90:1f54 with SMTP id a92af1059eb24-1ac5eea0384mr32740055c88.47.1793819028398;
 Wed, 04 Nov 2026 11:03:48 -0800 (PST)
Date: Wed,  4 Nov 2026 19:03:39 +0000
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
Message-ID: <1cb54b7e6ffe2e7a0890815c3072d8a3819b48d9.1793818636.git.abhishekbapat@google.com>
Subject: [PATCH v5 4/5] alloc_tag: Extend allocinfo_filter to support tracing queries
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
index 2fc843bb06bc..ca0779051cf4 100644
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
@@ -64,11 +66,13 @@ enum {
 #define ALLOCINFO_FILTER_MASK_INACCURATE	(1 << ALLOCINFO_FILTER_INACCURATE)
 #define ALLOCINFO_FILTER_MASK_MIN_SIZE		(1 << ALLOCINFO_FILTER_MIN_SIZE)
 #define ALLOCINFO_FILTER_MASK_MAX_SIZE		(1 << ALLOCINFO_FILTER_MAX_SIZE)
+#define ALLOCINFO_FILTER_MASK_TRACE_ON		(1 << ALLOCINFO_FILTER_TRACE_ON)
 
 #define ALLOCINFO_FILTER_MASKS \
 	((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
 
 #define ALLOCINFO_FILTER_FLAG_INACCURATE	(1ULL << 0)
+#define ALLOCINFO_FILTER_FLAG_TRACE_ON		(1ULL << 1)
 
 struct allocinfo_filter {
 	__u64 mask; /* bitmask of the filter fields used */
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 504c1a85050d..e9b70268eacb 100644
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
+		if (tracing != !!(filter->flags & ALLOCINFO_FILTER_FLAG_TRACE_ON))
+			return false;
+	}
+
 	return true;
 }
 
-- 
2.56.0.506.g506a7eabc5-goog

