Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE72AF09
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355508; cv=none; b=FkJYpPL/jWy8ZWHRtYiA6ypzv6btTpaI5FhHJSCZrLTjxTTgGTmoWEf4AxLyxrBgejoCSqJwd5J20UyTDN2upOhv3fkE+HdNGdzuqyEj9z+AWxfXbYUz60hENO6VJUk1rr03VKjMc7KbVQcQxS/7vd0t021J7EbGdIOndG9AfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355508; c=relaxed/simple;
	bh=MuPcXyTeuK9viOXgyrToQYwy2Nr83HJ3C85C+B9HiVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixfVhSb1S5PjRzaDGvMEwPQfyj/hL0LLHL44AL0Jy/5sWgZIovRGhkeSNu8Oy84bSYuKqiL3b08dzHPRGEUHUV7XqSC88yNbjIPZi0c2RN4h82yuDlKaKAR+ZPOFwI8aWiQpztW8YbqDKHCA/f5LQyXiXV4T85lPcZQXSgdFFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E88C4CEC5;
	Thu, 26 Sep 2024 12:58:20 +0000 (UTC)
Date: Thu, 26 Sep 2024 08:57:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Li <liwei391@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <xiexiuqi@huawei.com>, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/5] tracing: Fix several deadlock/race issues in
 timerlat and hwlat tracer
Message-ID: <20240926085553.462d3e6b@rorschach.local.home>
In-Reply-To: <20240924094515.3561410-1-liwei391@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Daniel, is unfortunately no longer the maintainer of this code:

  https://lwn.net/Articles/979912/

I'll try to take a look at this next week.

Thanks,

-- Steve


On Tue, 24 Sep 2024 17:45:10 +0800
Wei Li <liwei391@huawei.com> wrote:

> These issues are found in concurrent CPU-hotplug and tracer-toggling
> testing, the test cases are as follows:
> 
> Background: *test_hotplug.sh*
> ```
> #!/bin/sh
> 
> while true
> do
> 	echo 0 > /sys/devices/system/cpu/cpu1/online
> 	echo 1 > /sys/devices/system/cpu/cpu1/online
> done
> ```
> 
> Test 1: *test_timerlat.sh*
> ```
> #!/bin/sh
> 
> while true
> do
> 	echo timerlat > /sys/kernel/debug/tracing/current_tracer
> 	echo nop > /sys/kernel/debug/tracing/current_tracer
> done
> ```
> 
> Test 2: *test_hwlat.sh*
> ```
> #!/bin/sh
> 
> echo per-cpu > /sys/kernel/debug/tracing/hwlat_detector/mode
> while true
> do
> 	echo hwlat > /sys/kernel/debug/tracing/current_tracer
> 	echo nop > /sys/kernel/debug/tracing/current_tracer
> done
> ```
> 
> Wei Li (5):
>   tracing/timerlat: Fix duplicated kthread creation due to CPU
>     online/offline
>   tracing/timerlat: Drop interface_lock in stop_kthread()
>   tracing/timerlat: Fix a race during cpuhp processing
>   tracing/hwlat: Fix a race during cpuhp processing
>   tracing/hwlat: Fix deadlock in cpuhp processing
> 
>  kernel/trace/trace_hwlat.c   |  5 ++++-
>  kernel/trace/trace_osnoise.c | 22 +++++++++++++---------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 

