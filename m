Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36810E6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHKNtHtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695D5C433C8;
	Wed, 22 Nov 2023 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700612511;
	bh=BnR6X0Q7DGCHjbTUHgy48LejflGPA3huJww1dkcGm00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHKNtHtlPHMzRl0iipUo/yapcMhQIgayRS7gwnH7wuM5zycq6qRzObamt2Odoe8t7
	 ioH7qeQarX05jXIPuCNGoF+7gHT6Gc2L6kFTYT9Y29FiK7q5WSCe6tYQkBGDbg9Xml
	 Lt0aoWO2g0V/XDbGRYXYNHBtXI/0VFXTz3ay77ehDbZnGDt4Bn+xx9+EnOikM1mX+M
	 fD2nA8aojhoU1HFOhu88DQq5IWqcpXz/vuRrZ2Fj6yjkrRkldU5RQega0aYkoS/6WB
	 gsfoDwUEBS24mAqfs/FTkqY1fIngRehKYOORM26uLO9iInx5ZE3PF6smLhCunP7/nZ
	 /8eqERFA7SVMw==
Date: Wed, 22 Nov 2023 09:21:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: tomer samara <tomer.samara@morphisec.com>
Cc: "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: Sleepable kprobes
Message-Id: <20231122092146.4416e5350e3701a812147373@kernel.org>
In-Reply-To: <VI1PR10MB2157FAE5EB3BC27824B4529F83B0A@VI1PR10MB2157.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB21574FD4B09A4EB8171F10B683ABA@VI1PR10MB2157.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR10MB2157FAE5EB3BC27824B4529F83B0A@VI1PR10MB2157.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(Cc: linux-trace-kernel@vger.kernel.org)
Hello Tomer,

Sorry, last weeks I was busy for LPC23.

As far as I can see (and IIUC), this hacks the ftrace's fentry to just
call the probe? (BTW, that is very x86 specific feature.)

In that case, unlike the kprobe, it does not probe the function body
thus it is not kprobes, and it can not work with ftrace and fgraph.

Moreover, since the probe is not called from fixed point, the probed
function can be called under non-preemptive section. Thus it is not
generically able to sleep.

If you need to do I/O inside the kernel, you need to do it carefully.
I recommend you to use deferred work (workqueu or different threads)
to do I/O asynchronously. That will be safer and generic way.
And also, new feature needs to co-exist with the feature already
exists in maintenanceable way. I meant using ftrace fentry directly
is not recommended because it breaks ftrace.

Anyway, what you need to do is starting discussion on the mailing list
instead of pushing your change. 'Why' I/O in the probe is needed inside
probe callback, and propose your solution. (My suggestion is above, but
maybe other people have other opinions.)

Thank you,


On Thu, 16 Nov 2023 05:38:57 +0000
tomer samara <tomer.samara@morphisec.com> wrote:

> Hi,
> Just bumping up this message in case got lost,
> 
> Thanks,
> Tomer
> 
> 
> ________________________________
> From: tomer samara <tomer.samara@morphisec.com>
> Sent: Sunday, November 5, 2023 5:42 PM
> To: naveen.n.rao@linux.ibm.com <naveen.n.rao@linux.ibm.com>; anil.s.keshavamurthy@intel.com <anil.s.keshavamurthy@intel.com>; davem@davemloft.net <davem@davemloft.net>; mhiramat@kernel.org <mhiramat@kernel.org>
> Subject: Sleepable kprobes
> 
> Hi,
> 
> My name is Tomer and in the last few weeks I worked on a side project that will create a sleepable kprobes.
> As you know kprobes is using PERCPU variables and can’t schedule or sleep.
> The motivation behind this is to allow the user to preform operation like I/O operations, put the task in sleep so it will be inspected in user-mode with easier tools or just call kmalloc without GFP_NOWAIT.
> 
> The code is very similar to parts kprobe itself since the idea is the same.
> You can see the full code here: https://github.com/Tsn0w/frogprobe
> The core logic is under src/frogprobe.c while other are just helpers.
> If you think this can be a good change to the current kprobe or as a different subsystem, what can I push this? (beside support more archs, support LKM symbols, blacklist symbols, …).
> 
> Thanks for your time and looking forward to your reply,
> Tomer Samara,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
