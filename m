Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D670315D2F;
	Fri,  5 Sep 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098960; cv=none; b=cjSDJOBOZAYSt0ZaJsKA9/FzsgtE90iOwTE/VnYmxO6mu04smLaVTvIFFGCQBxDmSj4TmftonspV9lt0U4ZtreQIV25P+FDhKBCdEE2AfSeV4BFCoLkF1/zZUYd4Om9uPib1Khg711nJMsB6T+vgRwHIeMFTvO0zCSnrDtrISxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098960; c=relaxed/simple;
	bh=inn+LM1euTlBUCjjKcekCXu5MqBHIYo0AF8nd+FvxYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9E9p/otliiGME40f+9i3eftTdu5CVATCMdwFNpSIsrPmqmdmHx0f25kv6w/47qdlJh9QvIi//pq39d3W0jvE+5bG7H2OnkhGnec653aUjw0oX4yDmcmio06KSvkO7QFduUmpXiSpbgcODTPWeEyzUmExSCUyDpdMemREnPnf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A030F8553A;
	Fri,  5 Sep 2025 19:02:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 690EC2F;
	Fri,  5 Sep 2025 19:02:33 +0000 (UTC)
Date: Fri, 5 Sep 2025 15:03:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <pulehui@huawei.com>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <20250905150312.02bef848@gandalf.local.home>
In-Reply-To: <202509022339.ae20a8bb-lkp@intel.com>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
	<202509022339.ae20a8bb-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fp7b85k5qcpq4anpcjpxr8my7o551qc7
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 690EC2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+O28D3CNqDpVKcdSNR8RFv6cBn/u7Rbjk=
X-HE-Tag: 1757098953-92415
X-HE-Meta: U2FsdGVkX183QeJHiEM8HOrVIQzGnHSyEwnApWpx4UiXzv9MFLN1geT7TGmmCv8TWDJozbM4I60QTGANccZW7Iky4w/Ek4+sVjC/w0bS35eNKaK17IXCQGmdSg3HeGaiuf3IWfGl8uM3Ki4J8QmLCArFJFDekIpmFSJDxb1+o938xrIhKKF8L+yWyRORyz+GJaBo63TrH3qYU7INRjkDcJLGZhbTmm/k0LAmQKAl10QP+6Fip5yaT6dykyg41wiscKZG56WbqQYeVgKMYmUT8DMATENWe16FUo/rdOmukj5lOUm8TCR7+PU2PNIRpbk8Kd5Bju8l5PWKqvYF5JqK3iNHpRT8AC9StybsWln+ZC5e7gUCkAYIwlk1kab0ioprZ9lSIWuWJ/kiBbXBheXFnByG3Xff94B0

On Tue, 2 Sep 2025 23:09:53 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> commit: cebdd2c9a622becc41349f32ace1795d750beda8 ("[PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write")
> url: https://github.com/intel-lab-lkp/linux/commits/Pu-Lehui/tracing-Fix-missing-errno-when-zero-parser-idx-in-trace_pid_write/20250821-151736
> base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
> patch link: https://lore.kernel.org/all/20250821071721.3609109-1-pulehui@huaweicloud.com/
> patch subject: [PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: gcc
> 	group: group-01

This is why I hate LKP. It's huge, complex, and I never can get it working.

I did the following:

 # lkp split-job jobs/perf-sanity-tests.yaml
 # lkp install -f ./perf-sanity-tests-defaults.yaml

[ had to fix python up a little because it wanted python3.9 where I had 3.13 ]

 # lkp run ./perf-sanity-tests-defaults.yaml
/work/git/lkp-tests.git/programs/perf-sanity-tests/run: 7: .: cannot open /work/git/lkp-tests.git/lib/tests/perf_test.sh: No such file
kill 37975 vmstat --timestamp -n 10 
kill 37973 dmesg --follow --decode 
wait for background processes: 37978 meminfo


I have no idea where this "perf_test.sh" is supposed to come from, and why
it doesn't exist :-p


-- Steve
