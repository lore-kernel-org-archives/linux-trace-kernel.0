Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD842CAE9;
	Mon, 20 Jul 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557798; cv=none; b=JVTeInLXNQOULvGYEaXdzrizylX6QzRd7VX8PRnlel/vIUe5hC4bgpwsrNF0KjJcw8QVnWiBGplc/SmlVILYlwxT7ef0L4Mg8KmGt5miRYAxJcR6ttS8rniaKXBJgufvqbDhLgDgWYIFZGQLsi8XQ2ULVi0NYc+DlRkcQHn5VdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557798; c=relaxed/simple;
	bh=X61gKfZ16dz/eDfGeWsjCbEbo9rrjhHhVgQrQ3f1zdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IBbCUNrYMkB3bHKWOllML9NXwg1Fb7GwOoLwapyAm5HbOIFt+FTxhyXkxVpudxRGGoUOpB8qF/7ne9cGpfu4CSW1XN57Gmnad1AN/lSEyjcaouPu8DqNU3ra3gx3BsjQlNwMUyyCjKWb76pq+oHnyy4HPipN+LtJnQTPvGSEYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJOupfKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJOupfKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043AC1F000E9;
	Mon, 20 Jul 2026 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557797;
	bh=IBoDz8X8lKlcSxY2Wrt7FDQtjKk9jl7QKKFHHmDBqPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZJOupfKssRpZbOVVDc2bH6py6VCJLbcwIP+8UMIzyWsdaMBIAbq0c2t2O/QVU1RsA
	 RYIqllRmvXRVEAsIiLH/f0x6MRil4ZqMrS3ME7ppJiMuBwjGn9OLJ9iLTLuoqFwyig
	 3hNJsO3riynkME2ftgqTbMgTxUb0p1vSPF6h3hQuJXVQvnYiTR3B2j6bXSQ8Lcsy68
	 4IbvHXNIhIFT88m/3Gn+57HLH3+jHXEI8rYuDzAvBusinEglKXtAYcOzQ/cDYfwymX
	 77VRWdhqs5XEAjxOyRL9mSHIx/fMThTC0ZOs+aydAyp89esG2OIjW4GAzaoHOhCrG8
	 3MDT8Rx+UInzw==
Date: Mon, 20 Jul 2026 23:29:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [linus:master] [selftests/tracing]  c5c413534d:
 kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail
Message-Id: <20260720232952.94b33d59eddb69cf6457ded4@kernel.org>
In-Reply-To: <202607161651.ab0a5bf6-lkp@intel.com>
References: <202607161651.ab0a5bf6-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 22:30:11 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> 
> Hello,
> 
> in fact, we found below two test cases randomly failed upon c5c413534d, while
> keep succeed on parent:
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/group:
>   igk-rpl-d04/kselftests-bpf/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-bpf/gcc-14/ftrace
> 
> 22a78be4123dce81 c5c413534d40eb4c982f1794e62
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :31          52%          16:32    kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail
>            :31          29%           9:32    kselftests-bpf.ftrace.ftracetest-ktap.event_trigger_-_test_poll_wait_on_histogram.fail
> 
> 
> 
> kernel test robot noticed "kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail" on:
> 
> commit: c5c413534d40eb4c982f1794e62813f926aba747 ("selftests/tracing: Have trigger-hist-poll.tc use sched_process_exit")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master 49362394dad7df66c274c867a271394c10ca2bb8]

Hmm, this seems like a scheduler (event) behavior is different from what
the test expected.

Steve, I think we should use another deterministic events.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
