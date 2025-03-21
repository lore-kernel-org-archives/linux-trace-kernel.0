Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537E139579;
	Fri, 21 Mar 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565173; cv=none; b=OtWZmcumXCIywIwCdeAq/20MZ/Zhc5hWxxHj6/zcH7IV5GaGPG1KTnBcojJ/3WMgcr9FVGTOq0/u6FESHDq+EPIJLT3X9A/Qkb6Idp8lRvrLDPOoPZKxd6z59QWgHHU5DuyhoAn5iBsKQdwhZUiGSlGmq9b3wBwtD12/6SPGOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565173; c=relaxed/simple;
	bh=7uwt+WRbg935B8HV4GfKPn0KXksrxwoSlHa/0gv941k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPnPGcr7t+lIN4RpybDJswdF4P4lkU/fb/ETRYiv4ZgYuK4QY/Sv/wzAu5UiH1MFoJJ84q45MjCvA6XI6bwFqAuRzBd3IZ1mYpVRY3LBvHlooVpUy3hyYGQhX5TzH8KPjvasTgqA+Zz6ovzBXkO/SIHI1p1DHNLu9WoldcFEf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN6nhnxd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN6nhnxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742565172; x=1774101172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7uwt+WRbg935B8HV4GfKPn0KXksrxwoSlHa/0gv941k=;
  b=XN6nhnxd1ICS2tM5CZg6L1L7eoRQiWZbvw5HDw4oTss8OyhlewA9xJFG
   T6cMDOECioArkmrfKeC2xy1/jRg/Is2HPguZ7f55e4z1qeLdVo1QeLm9p
   mS0jPJ4o2SPs0EIKpW072Gi6m8Xq6FDaGchVeY2wbWlTf+ZspcCucE60U
   rz995Z0BmKl3f+74g5VhkwWfa5PDDpTsnWC4JjFgmU4/mj4biFfnegPK7
   bS3yjmf0zNK1UhFvDNmq4kObTNoOpaS3dh+zaR7ltLr0urCMqv/oelLJs
   4A/qqyVaJvAapkM04pWeZgcrN/34R8G51O46ZoK1BFdnFz06aCSzop4fb
   A==;
X-CSE-ConnectionGUID: knTl2GwVTi67LU87KcxVYg==
X-CSE-MsgGUID: dPQzj/vkQlS+Jmzqzk+MhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="42996178"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="42996178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:52:51 -0700
X-CSE-ConnectionGUID: zC0VwK/QSKWYHwx+Cz3ZJg==
X-CSE-MsgGUID: FOXq9rRET4+y7Yrkwycv4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="154294641"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:52:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvcnj-00000004Ww4-42Fd;
	Fri, 21 Mar 2025 15:52:43 +0200
Date: Fri, 21 Mar 2025 15:52:43 +0200
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
Subject: Re: [PATCH v1 5/6] vsnprintf: Mark pointer() with __printf()
 attribute
Message-ID: <Z91vK_6B2T0uA-r6@smile.fi.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-6-andriy.shevchenko@linux.intel.com>
 <87msdeebyh.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msdeebyh.fsf@prevas.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 02:43:18PM +0100, Rasmus Villemoes wrote:
> On Thu, Mar 20 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > pointer() is using printf() type of format, and GCC compiler
> > (Debian 14.2.0-17) is not happy about this:
> >
> > lib/vsprintf.c:2466:17: error: function ‘pointer’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >
> > Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
> > by adding __printf() attribute.
> >
> 
> I had quite a bit of trouble reproducing, until I realized I had to
> apply your patches in reverse order, because adding the attribute to one
> function will then "taint" its callers.

Exactly, that's why cover letter has "strict order" mention.

> So this one seems to be self-inflicted pain by the annotation of
> va_format (which is completely broken, I'll reply separately to that
> one). This doesn't solve the false warning for va_format(), but how
> about we at least do
> 
>  static char *va_format(char *buf, char *end, struct va_format *va_fmt,
> -                      struct printf_spec spec, const char *fmt)
> +                      struct printf_spec spec)
>  {
> 
>         case 'V':
> -               return va_format(buf, end, ptr, spec, fmt);
> +               return va_format(buf, end, ptr, spec);
>         case 'K':
> 
> because va_format() doesn't use that fmt argument at all.

Yes, I was thinking about this. I'll do it in a separate patch in v2.

-- 
With Best Regards,
Andy Shevchenko


