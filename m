Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18022B59A;
	Wed,  5 Feb 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752162; cv=none; b=mxNJppqwqMQrsEb5KTJ9iZYxVjQILnTYDCvZLX6pJLwU5ZYjZX2rP58/iB4Z3xsklkCspnrGt4LBBygs5kpp0DDTAeFxw02Je/0G5rlydHas8Fgc3llQYf3PkjV3XMjxkbW750ri9On9By+GMpti8lP6NxZDSCNY9Eh2mnRvNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752162; c=relaxed/simple;
	bh=LRquYjF41Qs3ozkMj7DtLWEVyZ1h1D3hkjDaHZat6z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTBrAmmUv39RqIn0VigqNa4z8nQufo5h7gg5WgSJ96Dc+XzU8/mm8f9PXoqGq6DP4cxKI5Hvag1+KZnrHCYxoDnbBO1SPhFCJaAyjkCwD69SJt1rBrg4NMaTZPK7YCKoKkoKgJO2mInVEXACTK9UNVQ0aqH3WQFJyGVhBVaq68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=cnZHsYa/; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cnZHsYa/"
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 19A0360B8B;
	Wed,  5 Feb 2025 13:40:33 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:5::1:34])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id TdiCnH3Ij4Y0-luTAzeim;
	Wed, 05 Feb 2025 13:40:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738752032;
	bh=Pt9TK34WEMC8Wuyn6NT+uWaQA66Oaj1A7lok/fuTYG8=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=cnZHsYa/t5/roPh+OSek1SW2AuObAcdSlzeHzwt6tpYnkMSmzfXsCcCbGGWeDmVzd
	 ttoiFQuvyM/lpN7Pp+Px0/7aqroqQVSvkvgo7Sxon7jUPYsYZ/PNoWwe20BM7mzCq9
	 D06U+B5CiXzEFXUJ8CQV4KerWlXThoKEJp16oKvc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Wen Yang <wenyang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kniv@yandex-team.ru
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in function_stat_show()
Date: Wed,  5 Feb 2025 13:39:29 +0300
Message-Id: <20250205103929.1538065-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204194820.7ef50d96@gandalf.local.home>
References: <20250204194820.7ef50d96@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Your approach should prevent both zero division and overflow in the
denominator. We also should consider that the numerator

> stddev = counter * rec->time_squared - rec->stddev_time * rec->stddev_time;

may overflow too. Suppose 1000 ns per call case. On each function execution
time_squared would get additional 10^6. So for 32-bit and
MAX_STDDEV_COUNTER = 2072 we would have
counter * rec->time_squared = 2071 * (2071 * 10^6) = 4289041000000,
a 42-bit number.

It looks like overflow prevention here is not viable with macro constants,
since function execution time is dynamic in nature.

My suggestion is to rewrite formula such as we perform division earlier
and avoid overflow checks as much as possible. Note that doing divisions
earlier may result in precision loss, but I think that is acceptable since
rec->time is nanoseconds precision. Also this allows us to not care about
counter overflow at all, because expression rec->time * rec->time will always
overflow earlier than both counter and rec->time_square_sum. Renamed
time_squared into time_square_sum just to clarify.

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 728ecda6e8d4..91e7185dd5de 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -419,7 +419,8 @@ struct ftrace_profile {
 	unsigned long			counter;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned long long		time;
-	unsigned long long		time_squared;
+	unsigned long long		time_square_sum;
+	unsigned long long		saved_stddev;
 #endif
 };
 
@@ -560,22 +561,24 @@ static int function_stat_show(struct seq_file *m, void *v)
 	seq_puts(m, "    ");
 
 	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
+	if (rec->counter <= 1 || !rec->time)
 		stddev = 0;
+	else if (div64_ul(rec->time * rec->time, rec->time) != rec->time)
+		stddev = rec->saved_stddev;
 	else {
 		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+		 * A formula for calculating the variance is:
+		 * s^2 = (\Sum (x_i)^2 - (\Sum x_i)^2 / n) / (n - 1)
 		 */
-		stddev = rec->counter * rec->time_squared -
-			 rec->time * rec->time;
-
+		stddev = rec->time_square_sum -
+			 div64_ul(rec->time * rec->time, rec->counter);
+		stddev = div64_ul(stddev, rec->counter - 1);
 		/*
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, 1000);
+		rec->saved_stddev = stddev;
 	}
 
 	trace_seq_init(&s);
@@ -888,7 +891,7 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	rec = ftrace_find_profiled_func(stat, trace->func);
 	if (rec) {
 		rec->time += calltime;
-		rec->time_squared += calltime * calltime;
+		rec->time_square_sum += calltime * calltime;
 	}
 }

