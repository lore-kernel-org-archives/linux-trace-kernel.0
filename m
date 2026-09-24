Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190E49BD92
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261915; cv=none; b=GGymZhuOSaElLGpYOgDyb83hOHbENFl7N5WgGEVbDzqqunQvHXF7/ns4NvzWDTpuASkyD702HzoXnPFVRATITliqk6OHQ4hCiCQqlONM+Md5QD/Xm8Ngyp1o1GNviZjxigKIViqvstomeCzkljJ9D1fsn50MMlqRk9F9J6vI66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261915; c=relaxed/simple;
	bh=w1cqUyc/Ize4PtxGR8ncKrrTkut9WX1VnYvd2cwe5OE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YqGdTsz0ooy4t414/fwiIL/sKdwrrcv0Y458as4bUJ8cFvgDXio/4l9AlVShkUXRKA+Vc0P8rLO8HK5EHCPvx4qdwnO/jrM9hQULsLQ7zTQpkzQEAGtWFQkVq3FeB9qBuGaw8afcstCDmQtiHOXa323DFF6TifPOA3JEM6mvgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FApVzSf2; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FApVzSf2"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so25404205e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261908; x=1790866708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/4Lk189uH8ybB/G/PRCaP8BERsbtAT8+BPaWTHQHns=;
        b=FApVzSf2BW279I+jATByGUptkqcd9qo12XJOi99MmMgJPH934cqnyO20E3WAKt63J4
         Yq1Aj2Z55zn5nxsw5S1E0aERm2aUruCPm9/m7BS9+6PdC7c7XdW7sCbpFJWzm/K+Anaq
         yJcOSQjPNczGEDviqSNoUzg6mHwYoQZniKqKyiekS5oYwGYg6Bhl2oaK5WImBOZaehmS
         4k7Bf7vGx4f2FB3a0mFmMtJLJk6IcbBHKs+6w/tPGXOOMAI29Fa2Thzansk4MckQ9n9E
         CnrQA5Ewt6BYuozj5ccvSUhp2/sAm1wbx5tRwfZe3mLAAW2jzJJ0HWF5F94nET3zEIYH
         4WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261908; x=1790866708;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/4Lk189uH8ybB/G/PRCaP8BERsbtAT8+BPaWTHQHns=;
        b=dHfq6z2R/RzZYXGxzhaEJuIl2Ij5kNrlRfNMRt2ZgDjdutZdnG8NFcvXGnYcv6h1Va
         48dFXpVY/jjDy2FFDiyrQSXLUPawlj8q1W9cg+lGNrqux3w6xn7gdfn4IAo8JUfSOuJB
         xMvbBUuRXxsNOBVgFgk1SChyQBu9YnFeTggNRsLksydf47vyR4WLaxuYeUV5QGFSZmK/
         s7JNCRybKS198PigsRA5/5n7XfbtOPkfhVllyUJ5ZsTrk7EXdWWGe8IqAyGzkep+jRzc
         g/YouStGQQLuMcfI0lE9WzMJ0Do2qvf21TM09GqLUkFHwNQlxasODBoOhaVQCGcaFDaJ
         fb+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzb8YyLcGePHbAAyUgrbV5Ac4s45JZPvJgSXR020KO0Bb6RsK0RGvrSUeYylVG974MPN/fY9v54cp3MqJWT8nbAkOo=@vger.kernel.org
X-Gm-Message-State: AFuF++n+8Ra33etb1kvEtqZe2+UaQM36vGp7vVlX+zZDnLzIFuFv7qgQ
	LM5QgWXjmMy0udtuLpgFTWCUvuqaIcV1SUiHMRwAd26xHHJ0PuTi6QEkRcEN9nHCgfNa5mnUp3i
	elc1VRqq+vzKZfYMIzfR6Uw==
X-Received: from wmpg33.prod.google.com ([2002:a05:600c:4ca1:b0:49d:f06:1f0b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d99:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49fe7b739f4mr38613285e9.15.1790261908146;
 Thu, 24 Sep 2026 07:58:28 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:38 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-5-vdonnefort@google.com>
Subject: [PATCH v7 04/20] tracing/remotes: Initialise pos in trace_start()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When *pos is 0, trace_start() passes a dummy local variable i to
trace_next() to fetch the first entry without modifying *pos. In that
branch, i was left uninitialized.

While i is discarded and causes no functional issues, initialise i and
keep static analysers happy.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index ae22d13308a5..aa76845a630a 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -748,12 +748,12 @@ static void *trace_start(struct seq_file *m, loff_t *pos)
 
 	trace_remote_iter_read_start(iter);
 
+	i = iter->pos;
 	if (!*pos) {
 		iter->pos = -1;
 		return trace_next(m, NULL, &i);
 	}
 
-	i = iter->pos;
 	while (i < *pos) {
 		iter = trace_next(m, NULL, &i);
 		if (!iter)
-- 
2.56.0.rc1.310.g51773c2048-goog

