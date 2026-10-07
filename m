Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409C484881
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412813; cv=none; b=rjyQELjs5KXKUaJ55fBv3dLKlYFIiC4I0IYFMz1h+i8Zj+jdPENlMuPrqGfAPgWAOkCg79dPtiBIXr1RDYKpyuZcTkq7aSSuakjc+oGIsUTzKHe1R8+Kb7yJbsiTU6rdyIQfvWjQDoruDjaOqemSfAac+/JS9e2bjDSaAarSVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412813; c=relaxed/simple;
	bh=/pc0hZL9R1yVk6AaFZtgoK1+ZS2TQMamOVf7NMsOrdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIqRtbc9PXP/Ci/AcfOJpwBiSzgP/a2Ijv4l/u2mxCzlMxvsS2iEMiatk3x1TU5aVltsfyz1dE7GzLcU10eOTJGUUNTLqc+Y6OpvKrN1PI87zsrL9siQW6vz6cn6xh2ixC2QbMP+BZF2MIcPWdKymwhrBm69/trXhtkw3X6GbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqvAYq/f; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqvAYq/f"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438fef603cso5603204c88.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791412811; x=1792017611; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9D5gsWzyCIxnio62hRxNUwEKaT5VZFEdzDbs5uZhd24=;
        b=YqvAYq/frcdNxL75oKv9WDk/WkrhsQdRO9yOqW2rmMwK7gVyMPuF5PUNWQdyFLl9aA
         aeLZ6FGFIBygmnamQbMMjO5PGUAMMlJ+pzg94DT3voAisguThjVsxW/6vaMb79ZMxRiy
         P2fPtD0W83H0So4f4zPTXA2xaU9cUI4/ZjUwgzdUpMLcSAyJn6kv7Ny48F7c3Fpgg1kK
         XdYUx7fIKf5oOu0RmS+2Cg0ND8Sa0n2gEw9oYDDjOIbitedIzPzoDcw3UrUYMi631+7T
         FcgzsMoSWA1CkRAHq2Dj4hoamlIlf4gkPLE7CcDnwBb2ft8ue8rAiYWBb1HkqqCWvKuq
         GnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412811; x=1792017611;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9D5gsWzyCIxnio62hRxNUwEKaT5VZFEdzDbs5uZhd24=;
        b=ZVvsDBSj/lyfie1rMVNM7moMypInynA6m2ilK2m+hS7h1fVdrSNUDE311+t/yrUbKi
         fF6d71ZWgVSk4+7jE5roq7Pt4ynOL5TFhxXhiRUxti94rZH4Q1DfMg+D6Y86mmE3Qs+B
         xc+gDJYlG1B2KcVZsFh1aYrOI4JrvcXr726GKS4nVRzqqanYdbXEl1FtvEsVWOcJiHhe
         wgDo0sCTH0/nV/W5OMZqly4OG0KLp5wbYu14CPlzVnzQhHR1lyh5YDx17f1+BmAK5xtf
         8KesESpPF033j0HtTcHCZCorJslLu1fDUhNMGJeYCO7XrdGxOdnEC3FAyid33Xr/pXFg
         odRQ==
X-Forwarded-Encrypted: i=1; AKwUvBymoXkfY1XF7ZZkrBxqVb/3pCn9PScXdxkDQiXCoAszU17+OtNU7dUxER7+P7EaZAn6Fl9Y+7GXPiNq8Nu+RaZ++Pg=@vger.kernel.org
X-Gm-Message-State: AFuF++mOR1TbqDtVycOfndxVytkzwjW+CRoE1lJvzNFyy4hQZk05q8bc
	2Xkw2ILf5swvIatFp4p/Qve7dbNVBXHsXkWyMCSW/yWk19AB24LKm3MumfEaZKm7xqT+vOjg+F1
	DkNU9a7Zgec6bWoTFBr6akqVJpOywB219Vg==
X-Received: from dldyr16-n2.prod.google.com ([2002:a05:701b:4510:20b0:143:7311:4b88])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f68e:b0:144:c112:5f23 with SMTP id a92af1059eb24-162071f8e9dmr5633509c88.24.1791412810906;
 Wed, 07 Oct 2026 15:40:10 -0700 (PDT)
Date: Wed,  7 Oct 2026 22:40:01 +0000
In-Reply-To: <cover.1791410885.git.abhishekbapat@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
Subject: [PATCH v2 3/4] alloc_tag: Extend allocinfo_filter to support tracing queries
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the allocinfo filtering mechanism to allow users to filter tags
based on their trace state.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
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
index 262f00f2bba9..8e63f347657b 100644
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
2.56.0.385.gd3acb90ef8-goog

