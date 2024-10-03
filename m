Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB4BA41;
	Thu,  3 Oct 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983561; cv=none; b=JPyHaowmkRG7wL5bKO3IwnwW5WBQa1UL1lrdGbRdy6D4TWsR1k/F/ZCFzK94ArL+/o0CfM/ZHZsQM+QBYDCWDAQzYVIpwiHcOBz6sqYHvcJ4ZGbWiFICYK0FLbsCFMFbwPA7HRFa4pEtumwtK9u4Z/ADG0xobIfUQF1oR8NMBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983561; c=relaxed/simple;
	bh=O8dX0nNjihxeUHEv4jagn6dcZruVuvtbTDZtrab0Zrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oztlI8Bn6AHeE0X471d0G0Aot9R/+KhzMs0uTWTdr0CDzHt0ZoDEcbJ5TOYEIX+rbL+I/T8COd+SrMoQJkIBCx0socO/ia31wFp/GGmaw4k9dRokmfk728BazFQ5TGpPjv/tXqbaaMRRcy0cwvkqctI+aV+uYWWwbQGeQ8RJU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SemZVDVR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SemZVDVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727983560; x=1759519560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8dX0nNjihxeUHEv4jagn6dcZruVuvtbTDZtrab0Zrk=;
  b=SemZVDVR8ili4FfC3Gao9LQ9GHzypHYNtJ0h0LZ7xbHy5ZrezK4uiNf3
   /DEeOQz0abosMpXT3xGX1CYOlGpyeqgF6sEBX28Stt6LH+raR4560NeYO
   HqHgLTZkERNTn5wacGaf8J/cmtDEPAOgs9lB8h7vBHzkVoiqImSuF3FUA
   XuvxXeaRyoIbagNAjasaC2Si17C9N48XXY3hZ2XXdnHOVaETgEFC1fkaA
   +3gRTgFLLvXXcoblhRWofnCotjFUTPBAfOtGByEOsF5aLc0V3gfWM1/MY
   0NmnvYNOz3n0anXVwFUxalndVUp00FHgvRnBCTUC205IdnGhug7KAV2JR
   w==;
X-CSE-ConnectionGUID: d2A3C92wS4qU2frtiO0USw==
X-CSE-MsgGUID: 56nmABOcQCKTxKTDTaV7lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27082453"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27082453"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:25:59 -0700
X-CSE-ConnectionGUID: +PxXlB/lSM+mKvaTsQRosg==
X-CSE-MsgGUID: 2n6BlCxcR3Sh1JrAC0VSLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79215312"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.145])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:25:59 -0700
Date: Thu, 3 Oct 2024 12:25:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix trace_check_vprintf() when tp_printk is used
Message-ID: <Zv7vxSu9gAhuA0ws@aschofie-mobl2.lan>
References: <20241003104925.4e1b1fd9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003104925.4e1b1fd9@gandalf.local.home>

On Thu, Oct 03, 2024 at 10:49:25AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the tp_printk kernel command line is used, the trace events go
> directly to printk(). It is still checked via the trace_check_vprintf()
> function to make sure the pointers of the trace event are legit.
> 
> The addition of reading buffers from previous boots required adding a
> delta between the addresses of the previous boot and the current boot so
> that the pointers in the old buffer can still be used. But this required
> adding a trace_array pointer to acquire the delta offsets.
> 
> The tp_printk code does not provide a trace_array (tr) pointer, so when
> the offsets were examined, a NULL pointer dereference happened and the
> kernel crashed.
> 
> If the trace_array does not exist, just default the delta offsets to zero,
> as that also means the trace event is not being read from a previous boot.
> 
> Link: https://lore.kernel.org/all/Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan/
> 

Thanks Steve!

Tested-by: Alison Schofield <alison.schofield@intel.com>


> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Fixes: 07714b4bb3f98 ("tracing: Handle old buffer mappings for event strings and functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
>
snip
