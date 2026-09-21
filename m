Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392A514773
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026020; cv=none; b=NP5YRzn9aFUQL9c3TPvBsag9ut3612O72eJ9x3AlviWxIJrCvFRCXMGYEcatVOKGHgldxlpYFGQjUG1ibmqTDyyqspwvuzOJWlvrvwgXUHm0ACns3hFp2Z/hIPnen70jN3PZuN0w+WfJj9tNJ5CCrHXJ4AhA8L0AisiDapbYi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026020; c=relaxed/simple;
	bh=JQ/lbKA9YQdgwnnkaFloU/3l/iRjfaxtxV1VWvxRrpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H6WNM17nmAJ4H6zSztsfOEQcWavHuylLfqAYCxnJxNscw3nPHimEm391v3f7IX7tj+ttZsSelbjMctpBdGzVgW6DzwUCjpsZZKjPLjdlttkvWVAmAhlywfveZN6QRiIpXP2mpK4ADD3jcmCq+Q7wtzNHtKXrrEiK8JASBMJSGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xtf/iLOl; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xtf/iLOl"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so46870815ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026018; x=1790630818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thyHfYtRbZkf/h8UY4YJlFOO7BMX5P6p7QG3tm7dEMQ=;
        b=Xtf/iLOlmeigqXAIsJx3Pb/dj9ZcwkdRVvJKJXrJ1wM6fol/vYXuXdAXSiNjagdZj7
         3qvEPSPs8/mVDnjBIaGEQSuOoWHMlOIGkIgYPCsaUD5p9LLiMz77ALDus/27uJ8QdMtf
         grYd6NDo+a0icxOEUgmp38XhCcbjhNpoC8AraZlO+bwc0gpydFeety5iVPp/G9L84+zd
         EqyEryHyvLF4HSWF+1Rj/kkgjP01jYsyFrhJ9K820Abod3T0inouh2GSZqJJrJBfr1HB
         S7hiH9dPQ+fj7CI2d25BJ8TTndazGuUoF6exW2Vt+nzKsCKPYJSaufmrDQmp6Si2ec4n
         h23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026018; x=1790630818;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thyHfYtRbZkf/h8UY4YJlFOO7BMX5P6p7QG3tm7dEMQ=;
        b=ZdIE4YuLcwZtKrJ+oiBHlEOOnACyHuttqR+LCEnNiQ3jGsefax7TNrn61/qvM0Zn23
         S/FGaZroNoyeLjWhsAfL5u8CrRiHG7/C2ZwkeWoKPpwoT1jHF0LRHy/3R9h42jwj4WXl
         95OHikjuVkBW1aHrjepdcIZXd+WIdwE4z0VjZm+0wtI4Hqo2du0jegW6UaLdyTCpA0D7
         wXPx2Qp2fp/oZQ5pjEaWDifAd02Tcgg1WukXT4ize1jvUkS2FxDo+Y8vk+6gGCkFg55N
         k/5b4gILWGtJ99K4W06xCZ/ZRXC+RldelJcjxZc+bqzJN+YPsbredpqo6yT4Y8O//oq3
         WTfA==
X-Forwarded-Encrypted: i=1; AKwUvBy3Wkxpx20gbPx5n0Brmh3iY32gIukJbaWPsbYZ6fridSrFBWULXwG+z0ZXzlUDuQOdW4iFh9u7kd1V25Hc9VLQR7w=@vger.kernel.org
X-Gm-Message-State: AFuF++keCApoAQNxo+LZOumUGfIRtmzJYhvcWVEP+egMrj84wAMz2w7y
	330XaYQGwxTqusj7do4crK5kQKHqoFKoYjbLGkhHR8ndm42e+157V2v3STIuxdIvEGrOZkH4tIN
	cVKj756W7b1dSxgM7iUIJuf8DgIWWv/xuSg==
X-Received: from dybsr41.prod.google.com ([2002:a05:7301:71a9:b0:339:7118:d1b6])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234d:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2ddb1acad2dmr184944625ad.6.1790026018153;
 Mon, 21 Sep 2026 14:26:58 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:26:40 +0000
In-Reply-To: <cover.1790025465.git.abhishekbapat@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <c429b37092a4cb33535965163072a63adf57d8e9.1790025465.git.abhishekbapat@google.com>
Subject: [PATCH 3/4] alloc_tag: extend allocinfo_filter to support tracing queries
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the allocinfo filtering mechanism to allow users to filter tags
based on their trace state.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
---
 include/uapi/linux/alloc_tag.h | 8 ++++++--
 mm/alloc_tag.c                 | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_tag.h
index 069ab8341e87..e65c32afceee 100644
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
index fb179321a2a1..50632b627d92 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -251,6 +251,7 @@ static void allocinfo_to_params(struct codetag *ct,
 	data->counter.bytes = counters->bytes;
 	data->counter.calls = counters->calls;
 	data->counter.accurate = !alloc_tag_is_inaccurate(ct_to_alloc_tag(ct));
+	data->counter.trace_on = alloc_tag_is_traced(ct_to_alloc_tag(ct));
 }
 
 /*
@@ -324,6 +325,13 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
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
2.55.0.1082.g2b9226bbc0-goog

