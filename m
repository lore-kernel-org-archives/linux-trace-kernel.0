Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA814037F;
	Thu, 17 Apr 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901194; cv=none; b=QWC6n9K6jamJnCt5a6AhxjyIoHhnPfFaCxfjFfKe71dYapHcp06j0SjSoPAXa5PpK4axODV0nnXcDD5TMJG2d1/4CSZ7ji82JYkgrNrpAj7bBWI4R2vVZcPym7tts2IljfSnxVEiqHiSrwRDO2r73nOiseMwGiKD1Py/q7+exv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901194; c=relaxed/simple;
	bh=60nlQ13YV+FsAbd90MFcqmmoghPcWG/rWq+3sENGxNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X480xlzOrqQ2bpTizS5Gt/0fgQMo/Qn3JufNOmFdKn1Tn/Mze/hM8s9Phz783gjQ5q1tFvoFI6DhE8wzMicCRTVylXGfXrK5xA0zeidcvCm/jFpHNwJC7wUYxzCYsYx90B0yptglt7OznYDxQMxuOwoPH+r4ywXVK6jsS2tnOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B294CC4CEE4;
	Thu, 17 Apr 2025 14:46:32 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:48:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [linus:master] [tracing]  a3dc2983ca:
 WARNING:suspicious_RCU_usage
Message-ID: <20250417104811.38a4bb88@gandalf.local.home>
In-Reply-To: <202504172239.4a2422e2-lkp@intel.com>
References: <202504172239.4a2422e2-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 22:42:55 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
> 
> commit: a3dc2983ca7b90fd35f978502de6d4664d965cfb ("tracing: fprobe: Cleanup fprobe hash when module unloading")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      834a4a689699090a406d1662b03affa8b155d025]
> [test failed on linux-next/master b425262c07a6a643ebeed91046e161e20b944164]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-r052-20250414
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

There's already a fix for this:

  https://lore.kernel.org/linux-trace-kernel/20250410-fprobe-v1-1-068ef5f41436@debian.org

Masami,

Are you going to pick this up?

-- Steve
