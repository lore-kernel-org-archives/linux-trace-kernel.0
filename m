Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C8470107;
	Fri, 14 Aug 2026 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717835; cv=none; b=WiD8/5LtIjPMTXlUnKZorWFDQCWCof0Antk+eTp7a4/TE+8wCHXR9nqxczUj9NS0aloiNJBtDDkGGgaQJ3Y0MycKP45ClHglS+tQcsEcNERdk5xfTkF28YzofOzHK4TZhaG3tb5bRdDCHG3V16UXjFIf2jJ9V9hFObef+Hwwvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717835; c=relaxed/simple;
	bh=5frsBJ4ofNUVWEvb9cykYU45R1FfP8DQLDBK2heTa2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhRilRbGlr8gi2YsMsBIfZnlhd8oly7KF3869JVcxKBnUTv/X1wNgkfs6OfCNVweh/bWaRYj8q+4+7zSvnyC6hELK1seuAHOoWzWZHqXstlkGzNh/8TpSnR2kH2LoXb5oD5kgKyDyWmRZoYlD+H2doysmDpXh+ZUzyTk+CbZkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=FLBYDOYa; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="FLBYDOYa"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0B857C015C;
	Fri, 14 Aug 2026 14:30:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 1A13820026;
	Fri, 14 Aug 2026 14:30:27 +0000 (UTC)
Date: Fri, 14 Aug 2026 10:30:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] rtla: Implement more robust nr_cpus handling
Message-ID: <20260814103045.6efc2514@gandalf.local.home>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1A13820026
X-Stat-Signature: zqftm6msrp9xfkeftfz4tdr7j64p4oag
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19tviRlZCrP6gXQLD8Zuy76RJG6F6amaWo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8MKiVB+KOGTG/293PButoISbBLDp1R+GScFM8V97EZI=; b=FLBYDOYaOZ8P2HK3FFIlLwOI96MgT/NeKcLR8KHLfaero6ZovewxgEENsy2o9laYkQ8sTcUcCat/izDYv6UuzuvgBu4kU9c0QjhigY32VxDxMrr+krDbVMouC6qFI0aVk8qQsWWLw5v++5W5ve2w4I50N1AYbB++Qik+SiV5gjw=
X-HE-Tag: 1786717827-117951
X-HE-Meta: U2FsdGVkX18cY0VwCNfLNJKctcBtxn/p70u3l0hKQW1b0JhRgv2dtmDMNLXur92PPN9j20QtjcZT7QfMm6EF7rrddDAtFpuGvdd1aR2GoclZY2dx6o9u2pc4iy88cOW1NNhXhK5DRbKfQVScDxGF6ll3yrEPXjKCaSCTkW8iNOHM9gjaJfsTorpsaGyUWnvSY+V5Pu/7cz7zr9Fe5c+gpZcRvTwIvZ+dGATr1AEuoVq2Mf+t8+gpZIbHVvzTmq9e4WsjRM3vLwtqvWBQqNT9ImTviBuB0nVrwVtrxVM5GrHmzjx+QbHosFyJU9GhB5CR05gYR8xtDiJE1yIhcz3FHbeMdc5RKMDB

On Fri, 14 Aug 2026 15:55:06 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> RTLA is an interface to the kernel osnoise and timerlat tracers, and as
> such, operates on all CPUs seen by the kernel, regardless of any applied
> user space CPU isolation. Currently, it uses libc's get_nprocs_conf()
> function to get the total number of valid (configured) CPUs on the
> system.
> 
> The number reported by the function may vary depending on both the
> libc implementation and the environment. This can cause discrepancies,
> including:
> 
> - RTLA crashing because of out-of-bounds access and/or memory
>   corruption, as a result of reading kernel events with cpu >= nr_cpus
>   and using it to index an nr_cpus-length buffer.
> - nr_cpus mismatching the return value of libbpf_num_possible_cpus(),
>   which is used in the per-CPU map size check, leading RTLA to fail to
>   read BPF data.
> 
> To address both issues, this patchset switches RTLA to unconditionally
> use the CPU count exposed through sysfs
> (/sys/devices/system/cpu/possible) - the same interface through which
> the tracers are accessed. As several places in RTLA assume the CPU count
> correlates with the maximum CPU (pre-existing limitation), the new
> mechanism also rejects possible CPU lists with holes or starting with
> non-zero CPU.
> 
> As a safety measure, trace events are further validated and rejected
> if their cpu field is greater or equal to nr_cpus. nr_cpus is
> additionally validated for equality against osnoise's "all" cpu setting.
> This is done to catch environments where sysfs is virtualized and
> reports a different number of CPUs than the kernel.
> 
> Note: As an alternative approach - reading only the osnoise cpu "all"
> setting and using it for nr_cpus - was considered. While it would make
> patch 3 unnecessary and make RTLA compatible with environments with
> virtualized sysfs, it would require separate handling of userspace and
> kernel CPU number, as nr_cpus is also used to guard -H/--housekeeping
> option argument. That does not appear to me to be worth it just to cover
> for a very rare corner case; if such use case appears in the future, RTLA
> can always be fixed.
> 
> Tomas Glozar (5):
>   rtla: Replace get_nprocs_conf() with sysfs possible cpus
>   rtla: Discard trace entries with cpu >= nr_cpus
>   rtla: Abort on nr_cpus mismatch with tracer
>   rtla/tests: Add unit test for cpu_list_iterate()
>   rtla/tests: Add unit test for get_max_cpu_from_list()
> 
>  tools/tracing/rtla/src/common.c        |  29 +++-
>  tools/tracing/rtla/src/common.h        |   3 +-
>  tools/tracing/rtla/src/osnoise.c       |  70 +++++++++-
>  tools/tracing/rtla/src/osnoise.h       |   2 +
>  tools/tracing/rtla/src/osnoise_hist.c  |   1 +
>  tools/tracing/rtla/src/osnoise_top.c   |   1 +
>  tools/tracing/rtla/src/timerlat_hist.c |   1 +
>  tools/tracing/rtla/src/timerlat_top.c  |   1 +
>  tools/tracing/rtla/src/trace.c         |   7 +
>  tools/tracing/rtla/src/trace.h         |   1 +
>  tools/tracing/rtla/src/utils.c         | 181 +++++++++++++++++++++----
>  tools/tracing/rtla/src/utils.h         |   6 +
>  tools/tracing/rtla/tests/unit/utils.c  |  71 ++++++++++
>  13 files changed, 342 insertions(+), 32 deletions(-)
> 

Note, the merge window will likely open next week (Sunday) (and of course,
I'll be traveling). If you want this in the next release, please send a pull
request today. Otherwise it will likely not be able to go into Linus's tree
until 7.4.

-- Steve

