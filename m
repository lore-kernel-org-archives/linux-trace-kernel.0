Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D12405F1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Oct 2023 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739ADC433C8;
	Fri, 27 Oct 2023 22:36:43 +0000 (UTC)
Date: Fri, 27 Oct 2023 18:36:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, Mark Brown <broonie@kernel.org>, Zheng Yejian
 <zhengyejian1@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: selftests: user_events: ftrace_test - RIP:
 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
Message-ID: <20231027183640.2529ab68@gandalf.local.home>
In-Reply-To: <20231027192011.GA436-beaub@linux.microsoft.com>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
	<20231027192011.GA436-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 12:20:11 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Fri, Oct 27, 2023 at 05:38:41PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed on x86_64 while running selftests: user_events:
> > ftrace_test running 6.6.0-rc7-next-20231026.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > kselftest: Running tests in user_events
> > TAP version 13
> > 1..4
> > # timeout set to 90
> > # selftests: user_events: ftrace_test
> > [ 2391.606817] general protection fault, probably for non-canonical
> > address 0x6b6b6b6b6b6b8a83: 0000 [#1] PREEMPT SMP PTI
> > [ 2391.617519] CPU: 1 PID: 34662 Comm: ftrace_test Not tainted
> > 6.6.0-rc7-next-20231026 #1
> > [ 2391.625428] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.7 12/07/2021
> > [ 2391.632811] RIP: 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
> > [ 2391.637952] Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
> > 55 31 f6 48 89 e5 41 55 41 54 53 48 89 fb 48 c7 c7 40 8c 61 94 e8 92
> > d3 5a 01 <44> 0f b6 a3 18 1f 00 00 41 80 fc 01 0f 87 c8 dc 4e 01 45 31



> Warning is from this code:
> static void __trace_array_put(struct trace_array *this_tr)
> {
>         WARN_ON(!this_tr->ref);
>         this_tr->ref--;
> }
> 
> It seems like there might be a timing window or an incorrect call to
> trace_array_put() somewhere. Do you think this is related to the eventfs
> work?

No, I think this is was probably introduced by:

  a1f157c7a3bb ("tracing: Expand all ring buffers individually")

Or possibly a mixture of the two changes? But anyway I think I need to look
at this one first.

-- Steve
