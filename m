Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534162;
	b=zLi7X+v5mRIq8d7j0BepWWuSPHkPfqHhAp9FwrSf+ph3yK0UJoRvdx/iJp2A4+YeFndb
	 dO47ziIRKlbBbo5rKAjrhxQms2WNLBngGResoy5oGnQsNhb9OuFmvx1/fU3HjvKTh6XjA
	 LfF/lHP6435/Md2y0j0531tCK/bVgckOL4a2WVfIQWnBTATbDVeaJ9nbWqqJiioHkDMlZ
	 IxmT4myQLIOOZNOyCDoujk31dSLg7C44SiNChsL1nb6/uilUo7kpkulwVQSDQioXPa8BQ
	 1J0my4vzea+14NIqY/FXgvJ4tSHKvziBbGC2/ZViZWZwpDlNio0VTaiOrhBWlQ19S2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EN5PyVV3ehJxWtE39x1XJbDDj8oLnBoapk60Rvm55Z4=;
	b=0eMYyeEUOBBxhv3j/ULSK0h/RGZHMOgPv/TPlbXMYKIxijLBHiOdy5AYnue9M3EKjx1E
	 vOVmdi2ibAH0o+j1no0f6Oc/Vw8dnqs6eUvXjoz859nt5MUyl+kC5622kkHFlRIbjc4Vs
	 oSR3Ms3Q1mCg4Ofhycsb0mce5cbqtrY0le20KcoYVFU3TuA/uFIukeTqdi7Sc0BXliBro
	 MO/p99HWgQUu7oC5UcsA9STjWs9QubmANQ9RT2v3tTcIi5QRp66qcsmp2w5plCcbo1wjw
	 bDDYgERkmOagY7Rs/TJgyLFrzfjFMePcBO9lKa+8Z9AK65GxE1AtnXXLq3fpOQ9gnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=efp2P1Rs;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF2606A680
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BF2606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=efp2P1Rs
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-49d70f45b22so2707947f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534160; x=1796138960; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EN5PyVV3ehJxWtE39x1XJbDDj8oLnBoapk60Rvm55Z4=;
        b=efp2P1RseTJXbIkPAe5p75XdnvjWOOAEnyjt9kGQcVi1q0JSOkCGH5+tLS5i6l0m0S
         KllQqcJQVOouCoNdK/cxLK9GqACHce9vNg/pQKNFzlAmEajOBX+cLQmxdO4NFkn3/i0J
         VKLZog0G7eo+EA/XTiPmW2PgxsjelJCNWRHCfNKPhJCCKGHpNW/ETnRdJxoPyL3MfsxN
         Psh9x2vTVAO5uxF6DT8yFVdaQ0j8ZRHxlhQlhwatPoFOED5gQkAyyTkXfC9GNvB/+Ldj
         ffBv9VIrwCxcb89n6Pkh7MKwnCPuAmZbiXYCg7abSMHcjcjebWmfLsWcGJucSkUEhPUS
         9HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534160; x=1796138960;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EN5PyVV3ehJxWtE39x1XJbDDj8oLnBoapk60Rvm55Z4=;
        b=0sshrekk+Q3q/qlSYnXq7Ae4xAdIr3ZEG8a1qnZhC/Q2xR/3nvD7zk4hhvONLny6cB
         sVjFtIjUvL+u8hSOYMNaLPxhyqF7h8Yj0AZR7yrvcqyhKRq+ajXyTI+rpK3GhcmY+mL9
         JLRLbaAMiXCn8MiaeqPv1gy8tj0yv2rdNP7xNc3EaJrPhg0pvm7+X/ntd4cTZkjMfoxB
         3wfO0Xg/kSfS5plZ0T2IVLwm7Vj7T9lGxPOTYVd3+yU+ulgi4P/HMTH7B+ydlNNTKjOd
         wF7+g7OcDZGBRzbcdNi+O1V1KNnYQCllbRPmzMzYjn1Jn+IgkTLyHnJOoeuZs8UTkTeP
         Cydg==
X-Forwarded-Encrypted: i=1; AL+hErENT1XBlWt6gXFQfQodTSzgIYRvRiFBErTls4rUH/AvGIlpoItjF6bQFAABb/m0LYW5Ug1SZ94z1z+Ra9BGYsY0Ujk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GD+5ibJ+RvK7JC61d1kuWSFy60gKJhvQEW0c9KPxiCuW5ey3o
	tWxdB+SO0nkfSOXQgVn92BBR5GrWcg+RBppmnwSM1Xc0POIZD1Xh6xlzct/L4fSQMGGglijG7/o
	4F90cUmJ4iriUzuaUl9X+ww==
X-Received: from wrnw9.prod.google.com ([2002:adf:ec49:0:b0:4b7:fd6a:1010])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4617:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-4abb18cbe2cmr29323905f8f.27.1795534160072;
 Tue, 24 Nov 2026 07:29:20 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:28 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-5-vdonnefort@google.com>
Subject: [PATCH v9 04/21] tracing/remotes: Initialise pos in trace_start()
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
index bd1b26cd981a..6e514e78392f 100644
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
2.56.1.809.ga0b61035b5-goog

