Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DD1FAC5C;
	Tue,  4 Feb 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707611; cv=none; b=WBQbZ1Ta45NuYvFH10341HYmN8e+aatCiQcF2GiL68/LvYD+IAOTRm6XuiWH0n4lvFiGF7NBMJg0fuO61aizG63kYfpA8ymN7e1POq7BfThZJlOLIOBCkoII2yuTIJboFqUTA6n/JaU7o2ATuvyYP8793aoKKu2IO5z3cYCu3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707611; c=relaxed/simple;
	bh=amgd8P6BHqREgQt9gXdFnKY9NXQU5F/KhHTeB8hYYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQyVtn4lA0hkheX4+oUa0yU8+7l7XhE9evRAfZORv35AWRVUPposUGCFGfqKxFoDrnOuSi7vhCXYJlYHwKNo8Sw9gjty3JD/PElVnsnrzn4pBEcHVXE1ZbPz5L1vkJNn6l7BEaQOczYc8TBbRFrpUptJU5waLpGmXHS92bS15BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04BBC4CEDF;
	Tue,  4 Feb 2025 22:20:09 +0000 (UTC)
Date: Tue, 4 Feb 2025 17:20:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang <wenyang@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in
 function_stat_show()
Message-ID: <20250204172045.3a5d8d01@gandalf.local.home>
In-Reply-To: <20250204074301.1427497-1-kniv@yandex-team.ru>
References: <20250203100603.5c00df0f@gandalf.local.home>
	<20250204074301.1427497-1-kniv@yandex-team.ru>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 10:43:02 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> Thank you for the review!
> 
> `counter > rec->counter` check does not protect us from overflows,
> so this could mislead especially with the comment included.

Ah you're right, as there's a big multiplication there.

> 
> I think we should either eliminate overflows or only protect from zero
> division. To prevent overflows it is wise to split the division into
> three and forget about it. But in 32-bit case overflows will still occur.
> 
> As for zero division protection, maybe this variant even more concise?
> 
> #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 	seq_puts(m, "    ");
> 
> 	stddev = 0;
> 	unsigned long denom = rec->counter * (rec->counter - 1) * 1000;

Actually, if the denom overflows, then this is bogus anyway. We should stop
calculating if it overflows. That would be if:

  rec->counter * (rec->counter - 1) * 1000 >= 2^32 or >= 2^64

depending on the architecture. So we can calculate what value rec->counter
has to be for that to happen. Using the quadratic equation (haven't used
this since college!), we can figure that out.

  x = rec->counter

  x * (x - 1) * 1000 = (2^32 - 1) // use minus 1 just to be sure
  x * (x - 1) = (2^32 - 1) / 1000
  x^2 - x = (2^32 - 1) / 1000
  x^2 - x - (2^32 - 1) / 1000 = 0

 x = (-b +/- sqrt(b^2 - 4ac)) / 2a

 a = 1
 b = -1
 c = -(2^32 - 1) / 1000 = -4294967.295

 x = (-1 +/- sqrt((-1)^2 - 4 * -4294967.295)) / 2

 x = 2071.930 for 32bit

For 64bit we have

 c = -(2^64 - 1) / 1000 = -18446744073709551.615

That makes

  x = 135818790.812

We should stop calculating stddev when rec->counter > 2071 on 32 bit
and > 135818790 on 64 bit!

Feel free to check my math.

The below patch should fix this.

-- Steve


> 	if (denom) {
> 		stddev = rec->counter * rec->time_squared -
> 			 rec->time * rec->time;
> 		stddev = div64_ul(stddev, denom);
> 	}
> 
> 	trace_seq_init(&s);
> 	trace_print_graph_duration(rec->time, &s);
> 

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2e113f8b13a2..ae90443f32af 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -419,10 +419,42 @@ struct ftrace_profile {
 	unsigned long			counter;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned long long		time;
+	unsigned long long		stddev_time;
 	unsigned long long		time_squared;
 #endif
 };
 
+/*
+ * The calculation for stddev will overflow when the counter
+ * algorithm overflows the long size:
+ *
+ * rec->counter * (rec->counter - 1) * 1000 >= 2^BITS_PER_LONG
+ *
+ * Using the quadratic equation: x = (-b +/- sqrt(b^2 - 4ac)) / 2a
+ * we can figure out what the max rec->counter is before it
+ * overflows.
+ *
+ * x = rec->counter
+ * x * (x - 1) * 1000 = 2^BITS_PER_LONG - 1 // -1 for rounding
+ * x * (x - 1) = (2^BITS_PER_LONG - 1) / 1000
+ * x^2 - x = (2^BITS_PER_LONG - 1) / 1000
+ * x^2 - x - (2^BITS_PER_LONG - 1) / 1000 = 0
+ *
+ * a = 1
+ * b = -1
+ * c = -(2^BITS_PER_LONG - 1) / 1000
+ *
+ * x = (1 +/- sqrt(1 - 4 * -(2^BITS_PER_LONG - 1) / 1000)) / 2
+ *
+ * For 32bit that is: x = 2072.930 (or 2072)
+ * For 64bit that is: x = 135818791.812 (or 135818791)
+ */
+#ifdef CONFIG_64BIT
+# define MAX_STDDEV_COUNTER	135818791
+#else
+# define MAX_STDDEV_COUNTER	2072
+#endif
+
 struct ftrace_profile_page {
 	struct ftrace_profile_page	*next;
 	unsigned long			index;
@@ -566,12 +598,16 @@ static int function_stat_show(struct seq_file *m, void *v)
 	if (rec->counter <= 1)
 		stddev = 0;
 	else {
+		unsigned long counter;
+
+		counter = rec->counter < MAX_STDDEV_COUNTER ? rec->counter :
+			MAX_STDDEV_COUNTER - 1;
 		/*
 		 * Apply Welford's method:
 		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
 		 */
-		stddev = rec->counter * rec->time_squared -
-			 rec->time * rec->time;
+		stddev = counter * rec->time_squared -
+			 rec->stddev_time * rec->stddev_time;
 
 		/*
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
@@ -894,7 +930,19 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	rec = ftrace_find_profiled_func(stat, trace->func);
 	if (rec) {
 		rec->time += calltime;
-		rec->time_squared += calltime * calltime;
+		/*
+		 * This is used to calculate stddev, but the calculation
+		 * uses Apply Welford's method that will multiply
+		 * rec->counter * (rec->counter - 1) and also divide from
+		 * that. The calculation will be bogus if that value overflows
+		 * the long size it is stored in. Stop the calculation
+		 * when the counter hits the point it will overflow.
+		 * The stddev shouldn't change much after that anyway.
+		 */
+		if (rec->counter < MAX_STDDEV_COUNTER) {
+			rec->stddev_time = rec->time;
+			rec->time_squared += calltime * calltime;
+		}
 	}
 
  out:
