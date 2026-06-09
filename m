Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBE403B14;
	Tue,  9 Jun 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043966; cv=none; b=fdCwWRDkZb/2gZ/bR5tW5U9Gy3Oq5Qd2H0XZiUQ+ul/DP7DMTgCRFDBMtq0aiifBomFrazS3bZgnZ+nv4gifQBky/nAqE/Hv4kdnrGDuU0MAmwy3iluiBy0Z0k0anJxPw+PMK81FM/Zi3S8RrHlsD8ckwi2DDsiw9rsusqkzI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043966; c=relaxed/simple;
	bh=s/nzjGJSaSJNRTXDiT7kkLrqivjeRHgxIQ1CNEPLfgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOZzYcafULR2V94eorsrijLpr7bHn/VB1lLfsD8zdDf1EuTfaKa5oGOwHmU25PO9kroy4E3QTtLha90bOCLUqcngtrjz/YsnM3NJS3IgN4Yyd/GqXjXKQqPohRW9u9r19kAQnUansAxRaDwp18REB+YrLxuO32vrpR8W65Vjv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F1BFF1A066D;
	Tue,  9 Jun 2026 22:16:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3675B8000E;
	Tue,  9 Jun 2026 22:16:18 +0000 (UTC)
Date: Tue, 9 Jun 2026 18:16:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open
 list:TRACING), linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] tracing: reject invalid preemptirq_delay_test CPU
 affinity
Message-ID: <20260609181617.185f1e02@fedora>
In-Reply-To: <20260605004006.2041148-1-sam.moelius@trailofbits.com>
References: <20260605004006.2041148-1-sam.moelius@trailofbits.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kr3mczt6k9ihnn719a545fm966413jzo
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3675B8000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ND+l6re1Ge6hznP2FOoEnZVky/K4/e18=
X-HE-Tag: 1781043378-868130
X-HE-Meta: U2FsdGVkX1/w37o20/yhDzQ/VgFTBWUupiIQOevCWM0wO9cVZcRIuKKNy48RYJeZeHLm5usJ79VXvXTrby0vnqXHPmFpKWrK7hh6AjzBT0W/tehquIW4basCUNLQ3RQCyBazJr3N8jS7wTL0mLlMNqcCpIk8CMqeOAMHjwn2YD9lukt6KYa4OK6nBYKSzQ1hYpPC4FHhrNS9z+liLx1cUtqkxhIwH42pLEi2+HN0eQOg+wdODSBzXMgOnXZ1oWMFMfc6iCMdOU0pU6fJRGUxAOSHZOvnyWZ38GjeoTUBJHmJWP8hUfYwZG16iYtzNk5s/P0aMca1LkHUXg7Qcl1MMN7xDI+EbS5ZoEJUkw/krzwxpI/WDK7VMfVpNwTXgdzmUdKAIO/PDKyY4td2l1VdYnQmJD+b14Xy

On Fri,  5 Jun 2026 00:40:06 +0000
Samuel Moelius <sam.moelius@trailofbits.com> wrote:

> preemptirq_delay_test accepts cpu_affinity as a module parameter and,
> when it is non-negative, writes that CPU directly into a temporary
> cpumask from the worker thread.  Values outside nr_cpu_ids can set a
> bit outside the allocated cpumask before the test reports a normal
> affinity error.
> 
> Validate the requested CPU before starting the worker thread, and
> return -EINVAL for invalid affinity requests.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  kernel/trace/preemptirq_delay_test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index acb0c971a408..0f017799754a 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -14,6 +14,7 @@
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> +#include <linux/cpumask.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
>  #include <linux/completion.h>
> @@ -152,6 +153,15 @@ static int preemptirq_run_test(void)
>  	struct task_struct *task;
>  	char task_name[50];
>  
> +	if (cpu_affinity > -1) {
> +		unsigned int cpu = cpu_affinity;
> +
> +		if (cpu >= nr_cpu_ids || !cpu_possible(cpu)) {
> +			pr_err("cpu_affinity:%d, invalid CPU\n", cpu_affinity);
> +			return -EINVAL;

Just add the check to the preemptirq_delay_run() function where it
tests affinity. Who cares if it created the thread or not. It's just a
test.

-- Steve


> +		}
> +	}
> +
>  	init_completion(&done);
>  
>  	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);

