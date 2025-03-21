Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A541198E8C;
	Fri, 21 Mar 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566626; cv=none; b=qrAN3vJtNPCUwaqZAc1LBpm//G5u2c2bNI93ceQkq7w2RnF4kZv/833Me42HxYdjvj/dlo881TQlZQjXcMEQFoIXaN1yfn84ll7B8w1CZJQEn8tTpSromInpaqMZgvzrlvrw/kJRIhnlI2LCSjH4srZE3EUcncVV42elwqNv0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566626; c=relaxed/simple;
	bh=rfxQZ12VRvZhdpuDOEdyntZXq2wHJ2FkqU+shH7sIiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9izSEPUP6CPEduH72j9f2sZfdsvISc5v2x9Asq4NSscY+6d09NGZmnMK4PN8VP+h/ANDBXK7x3QMSJi4T78XbXzEZQtBKPKacXoRqfx+Z1FYj8bTRxgNjC27bW3Y7hFSggvSjoZp+G11t/NGe1BhOyRzaEl1zi2RvIYKBnELk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZa4ZUbs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZa4ZUbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742566625; x=1774102625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rfxQZ12VRvZhdpuDOEdyntZXq2wHJ2FkqU+shH7sIiQ=;
  b=DZa4ZUbs+ZoOHd2/6xlYhH0KexMzRbju/cNZbDgZXJ1xn+dzztWbeAN3
   dIB4ANkvh+FyNUgbrRmg3+HCjL8sDoq2qAHONBDQu0CofsRGBTOsOUfdL
   fBMTPHieQSl7jApVaePIGVfdRNICK8euSAxSyi8QWl12CdjG6NVqEE+Ev
   V0ftoVacAPpSPxkz4E/mxvqDl2Y4iElG1U6v6CUIE82FNaMfxhL1dNRFP
   ugccU0XeHdjBnGnNlwTKr7ESfMOo9RCu2CbrwFJH2IiK6z5hZHKK4zI5K
   D20CmR3/evIvf13ZHtKkYFXLUWz1I9F7U6sHYGC/X9MD0lAariDz0umBA
   w==;
X-CSE-ConnectionGUID: HvBSnUAkSMiEQGUEd6NiNw==
X-CSE-MsgGUID: N+LcY0qAQqCXp7kryka7bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="42997958"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="42997958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:17:04 -0700
X-CSE-ConnectionGUID: xIq/6NPoSYCfSUIs7XLQKw==
X-CSE-MsgGUID: k7rGACY/QFugt68sEzF9Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128634465"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:17:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvdBB-00000004XGa-38n0;
	Fri, 21 Mar 2025 16:16:57 +0200
Date: Fri, 21 Mar 2025 16:16:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Petr Mladek <pmladek@suse.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 6/6] vsnprintf: Mark va_format() with __printf()
 attribute
Message-ID: <Z9102aHbXlVS50Cq@smile.fi.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-7-andriy.shevchenko@linux.intel.com>
 <87iko2ear3.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iko2ear3.fsf@prevas.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 03:09:20PM +0100, Rasmus Villemoes wrote:
> On Thu, Mar 20 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> I'm sorry, but this is broken in so many ways I don't know where to
> start.

You shouldn't be sorry, my guts feeling was on the same page, I was sending it
with the expectation that someone will direct me, so thank you!

(And that's why there is a paragraph about this rather hackish patch)

> The format string that va_format actually passes on is va_fmt->fmt, and
> that is _not_ at all the same thing as va_fmt cast to (const char*),
> even if ->fmt is the first member, so the static_assert doesn't do what
> you think it does. So of course the ptr variable (which is (void*)) can
> be passed as a (const char*) argument just as well as it can be passed
> as a (struct va_format *) argument, and sure, the callee can take that
> arbitrary pointer and cast to the real type of that argument. But it
> seems you did that only to have _some_ random const char* parameter to
> attach that __printf attribute to.

True, and again, I felt that what I'm doing here is all not right.

> So, since the format string that va_format() passes to vsnprintf() is
> not one of va_format()'s own parameters, there is no parameter to attach
> that __printf() attribute to. So I actually consider this somewhat of a
> gcc bug. But can't we just silence that false positive with the tool
> that gcc provides for this very purpose:
> 
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> static char *va_format(char *buf, char *end, struct va_format *va_fmt,
> ...
> }
> #pragma GCC diagnostic pop
> 
> with whatever added sauce to also make it work for clang.

clang doesn't produce this warning to me. But I will check again.

> Then you don't need to annotate pointer(),

Sure, I also felt that that one is hack to satisfy a broken tool.

> and then you don't need to annotate the BINARY_PRINTF users of pointer(),
> though I think those two do make sense.

I prefer to have them marked as they really like printf():s.

Thanks for the suggestion, I will experiment and send the result in v2.

-- 
With Best Regards,
Andy Shevchenko


