Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF3222587;
	Sun, 30 Nov 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764531895; cv=none; b=EEmKNArWKgxBLz/ph+TUJuNBRMKbEYDy6b5vAK0HxbSguvOXQigf52b8grX/qUUhPgSmaFtsDU8o9NMq3zIx/WbvKpA5HRf6gVeQMU0YdmLT4UHf0MFCXgvDj4N8ih9Mb7YL1UYEVbIWDlZKIx7OpDYSOfNn6yWxZLb87Zn5ZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764531895; c=relaxed/simple;
	bh=YNqCeQ6lG0WyDX4FDnPCP4qQ9zDHcy4L9w8YAwA2us4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Qc7+7ADCVLJGtEfZ8HtgKWWPhh3kx221e0H4PYV4J05W7zWDTKCJ5YFcocSAOxohItvnIS3gJ5FuF3JW9E/3MzY4yKK3AUIdz92LdfWY3/fyj7LFw7g0QeTpisZF/8fjZu7qrND3iV8TKIk8d0JG9Fr4rYa4YzYRJz5Ad80Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVwgXNXq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVwgXNXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764531894; x=1796067894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YNqCeQ6lG0WyDX4FDnPCP4qQ9zDHcy4L9w8YAwA2us4=;
  b=hVwgXNXqZrleV1YAZToRRioGEbRKz2UIXPVaoz1vtBiduei+lFblZhff
   FXCIeJHAx3Ot5ZFdkjkBWY1shNhytFdpHOQZwJs3Z8Aoi8WLVvdDS5BBE
   hBT51PsEjRYbSf+QyTizuemT8tdG3ciS7bHc1Qr4+9ZdmqhliwJoQI+4G
   i6UjGQ7PcKVL2RvC0T6Os1vfOehkNQCwGBAzqcoyIosoiNX+QDpiPaORq
   CQwey9WReWnP0XtLgwab0u0Sr6GJBGHaQ70cygkqPsFgyNZRnSKvxiOGP
   U0mb6ZuaC2Mxka7WvjVPURdJAtIEtsnfKdlWsgFLARQGr/LNGiiXZHcjp
   Q==;
X-CSE-ConnectionGUID: Dbtt9no3QgG9heLgIImBGg==
X-CSE-MsgGUID: HqIJeqAYR7C6ibfI4hDbXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="70324851"
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="70324851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:44:53 -0800
X-CSE-ConnectionGUID: M7QQPtsgQEWqjfkTR2q7ng==
X-CSE-MsgGUID: i/kzFHWaRbKVunckos8Wtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="194684854"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:44:48 -0800
Date: Sun, 30 Nov 2025 21:44:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <aSyertuRRX9Czvyz@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
 <aStX3242e3mo5H05@smile.fi.intel.com>
 <aSyJ83v7EEAPHXeU@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSyJ83v7EEAPHXeU@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 30, 2025 at 01:16:19PM -0500, Yury Norov wrote:
> On Sat, Nov 29, 2025 at 10:30:23PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 29, 2025 at 02:53:02PM -0500, Yury Norov (NVIDIA) wrote:
> > > Tracing is a half of the kernel.h in terms of LOCs, although it's a
> > > self-consistent part. Move it to a separate header.
> > > 
> > > This is a pure move, except for removing a few 'extern's.
> > 
> > Yeah, I also have something similar (but half-baked) locally, the Q I wanted to
> > ask is why a separate header? We have already some of tracing headers. Doesn't
> > suit well?
> 
> Just as said in the commit message - this part is more or less
> self-consistent and debugging-oriented. If someone needs to just
> throw trace_printk() in their driver, they will not have to pull
> all the heavy tracing machinery.

Please, add a summary of this to it. It will be much clearer and based on it
I agree with your judgement.

...

> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/math.h>
> > >  #include <linux/minmax.h>
> > >  #include <linux/typecheck.h>
> > 
> > > +#include <linux/tracing.h>
> > 
> > There is better place for t*.h, i.e. after static_call_types.h.
> 
> They are poorly sorted for seemingly no good reason. I found the first
> t*.h and just put this header next to it. Don't think that placing it
> next to static_call_types.h is any better or worse.

It's better, because the (sparsed) chain of the sorted one is longer.

> > Btw, have you tried to sort alphabetically the bulk in the kernel.h after
> > your series. Does it still build? (Just wondering about state of affairs
> > with the possible cyclic dependencies.)
> 
> I didn't try. Sorting #include's is not the purpose of the series.

I know, I'm _just wondering_.

-- 
With Best Regards,
Andy Shevchenko


