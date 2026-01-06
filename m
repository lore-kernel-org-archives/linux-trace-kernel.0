Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA6EADC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665201; cv=none; b=YPd1nwYAyex+s/yag9ibCHYNgzWxCKE9XqW3AvP0p5Fe0pg95wEMe0w3wprPjHgWHHQqUTum/RJd9BU0HAjTS9V0QUeqrR7rCD6EprG4FVSW23b+jjjY+s7A0vAeqDG0fsT86FMaqNktqw/xLfjF1ZIFMVIaHaYaRgAwf52a78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665201; c=relaxed/simple;
	bh=QEbYplCVttrTtBYcJLlm+VKM8wXQFuG1VSUfXM16bd8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FjY5QqYYbQNw4XN4+rvCoqVnQfhlgUvRU/h/wsHCD5ZjTmF4S1hWzS7B7Hw+OAD0iOR8gwLKE8R9sc1wULXN+a8gjJSDg5gj2nzxMmM1uZZkHLwQIcfI2n6h7q8AVAY3FmUu1y5Uea9f3cjFsSw5fJoiV7uAS+PWfpjX/lV3fME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CHY+rQUx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CHY+rQUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0DBC116D0;
	Tue,  6 Jan 2026 02:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767665201;
	bh=QEbYplCVttrTtBYcJLlm+VKM8wXQFuG1VSUfXM16bd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHY+rQUxltiMZhvB3+dF6jriEi0UEq0CJDi81YM7Pdew8aNUkIkpow81t3QhGtZtF
	 FjesyL4jecXI3kHoDPjzfs1fxdjTEIncSnfcEpuFH3qh0Zp05vUJp6f/7ot7Y7wcWh
	 wKmGxHVqpQWXbD4hPrN6iBDCF/c/ESAKAPNiiVnI=
Date: Mon, 5 Jan 2026 18:06:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/2] mm: vmscan: add PID and cgroup ID to vmscan
 tracepoints
Message-Id: <20260105180640.2072c151c9f1f56458cb2dd2@linux-foundation.org>
In-Reply-To: <20260105160423.23708-1-tballasi@linux.microsoft.com>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-1-tballasi@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 08:04:21 -0800 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> Changes in v3:
> - Swapped multiple field entries to prevent a hole in the ring buffer
> - Replaced in_task() with __event_in_irq
> - Replaced mem_cgroup_id(memcg) with cgroup_id(memcg->css.cgroup)
> - Rebased the tree to latest 6.18

x86_64 allmodconfig;


In file included from ./include/trace/define_trace.h:132,
                 from ./include/trace/events/vmscan.h:569,
                 from mm/vmscan.c:73:
./include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_direct_reclaim_begin_template':
./include/trace/events/vmscan.h:140:17: error: implicit declaration of function '__event_in_irq' [-Wimplicit-function-declaration]
  140 | +               __event_in_irq() ? "(in-irq)" : "")
      |                 ^~~~~~~~~~~~~~
./include/trace/trace_events.h:219:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
  219 |         trace_event_printf(iter, print);                                \
      |                                  ^~~~~
./include/trace/events/vmscan.h:135:9: note: in expansion of macro 'TP_printk'
  135 |         TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%u %s",
      |         ^~~~~~~~~
make[3]: *** [scripts/Makefile.build:287: mm/vmscan.o] Error 1
make[2]: *** [scripts/Makefile.build:556: mm] Error 2
make[1]: *** [/usr/src/25/Makefile:2054: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

