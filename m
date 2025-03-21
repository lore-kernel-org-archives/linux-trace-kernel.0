Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98107D07D;
	Fri, 21 Mar 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566185; cv=none; b=k0lKcu2CeYGrCX4KxcZPHLawZh8fCcvT+Ci+Cfj5/rLy0qe17JwPbdVn3rFCRDgvMxetzmwvaNowkfyePRm36DERXeRN4yMggqO5dQ8wsPJroFydShIG/I7pVum3CbZZvM412MgZ+4kw7Nx/Q5efRdQlFGsGHf1vRy1B6W0QOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566185; c=relaxed/simple;
	bh=rXLtgiTj7zpdZFmLT71irKcz+RLed+8ZliIEnCMqvjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjVwgLzMzafkfLbt18hkJNIbhJC+NUIwzk8dmP/9yheNHiODwSN+sKbEgqyC0FIEDeURkmubOX+Dt5+Wg4Tr6WmAHpeWpcsSY+zJc4dH+ZLnwRkpE5//qqsjHFN0XwP9HZYw6OcKRnfnC7OF+kuJwh7lZ70embVsAsci/U5WNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed2+BfVL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed2+BfVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742566184; x=1774102184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rXLtgiTj7zpdZFmLT71irKcz+RLed+8ZliIEnCMqvjM=;
  b=ed2+BfVLfMHmx4LsArQQT0m63UVOFf9wMuojzXIk6CwStroGeUQuWaCk
   V9Y75+ViBIvKPAZ1kXuc731KH8+EHrjNG2Q0zCWL3L4f2AGlrmNgg1gX8
   JIUUVwQVzKVdiifR+5XdK3p/HLxkwmx42AQFVkjDAajsvIx0SS3vUDNgP
   D4xcVqHxK3GxBzf65TRq6iyMJA6FYDONny1A21h7wZGs7teRT/OgrMP7C
   jRvkekbec7SBn90C9o+EIpiSGuvM42C0TqU3RHpWmoOb1Vf8PkrZn396M
   Zt2xl8zewB9rCeeP/AwR5RfUu0SSr3FC9rzIiLe8gtX20yrn0qSg+FvZ/
   A==;
X-CSE-ConnectionGUID: 0P3lPcJeSQS8mwtUkuX03A==
X-CSE-MsgGUID: rzRbGWosTV+grzf4IhX8ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54828138"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54828138"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:09:42 -0700
X-CSE-ConnectionGUID: 8AGVAOnoR0+H9cUyrPSZ1w==
X-CSE-MsgGUID: tEr5kHjFQJShpwMo9Tvt6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123389463"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:09:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvd43-00000004XBK-3yIn;
	Fri, 21 Mar 2025 16:09:35 +0200
Date: Fri, 21 Mar 2025 16:09:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 3/6] tracing: Mark binary printing functions with
 __printf() attribute
Message-ID: <Z91zH6iXaJiNCxHg@smile.fi.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320180926.4002817-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 08:04:24PM +0200, Andy Shevchenko wrote:
> Binary printing functions are using printf() type of format, and compiler
> is not happy about them as is:
> 
> kernel/trace/trace.c:3292:9: error: function ‘trace_vbprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> kernel/trace/trace_seq.c:182:9: error: function ‘trace_seq_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> Fix the compilation errors by adding __printf() attribute.
> 
> While at it, move existing __printf() attributes from the implementations
> to the declarations.

This also missed removal of one new line and __printf() in the C file.
Will be improved in v2.

-- 
With Best Regards,
Andy Shevchenko


