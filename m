Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978E157A46;
	Mon, 24 Mar 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844776; cv=none; b=jolXqu6GGkutamD33wUz7MPnwao+XiKzTfbSMF9S6+Gw4M4e6QbA2Hp0CrxcTrlipW735xkqlYsQ71kjAel41+HoIYzsal5qwrIMFu+82om8fBra5DEaNQ7JzzRJh0XtTLf8S5lp37Xz2B/WsZtPlUcpEHH52KQP0VKp8WdCPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844776; c=relaxed/simple;
	bh=sQB6S7wqkulPvI9FHamXXy9Yd0RmyEoWhqQ4Qadl98U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE/eXd7/fnKizoDOWZdEVue2JswKW1cabkJzs13aaz/OhI7IpTnJb/pYw0vHuM1PgNyOHz/Rj9VslE3Ll2TMCoiL8VAQ6ok5Zhb2EQHyZy+0THKzLLg8i/a/YHBn6AH3C75NAOnyKKIj987i3gZGjEjVEIKxzKzyKxL2XUN/SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTW8Pqic; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTW8Pqic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742844775; x=1774380775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sQB6S7wqkulPvI9FHamXXy9Yd0RmyEoWhqQ4Qadl98U=;
  b=hTW8Pqicd5AX+EJrpIM/R4cpa4ldUY4tWOGs4uMZMnIagldSby6qhmFT
   hnqzjI8BeQtoEHKdFvJY0K7h2E4rXvI61QzZ3R3LCnxLNxEsiwuyNdU6R
   ETRRNeYhDZAfFQI2m/XcFPPNDvxDFo9nlz2yeJPmZfytdqdMJkZeMB5Vv
   xGFbYwRKGL/z0T/K73mqxuJv6df1s5RqpGqtToPZIoGwTUYKMt67m2jMD
   Igdzfk3Xtw1rZCmxLi7lDYj3Ja8b38V96idXEUBmf6lPhYS4V0K5qsHgh
   sFPLeB2FE88LArDT3VLiRmLsBN11w5yx0q/yOpo9Axs5BEeouIqscoZeY
   w==;
X-CSE-ConnectionGUID: x4M21kaATna0jYtWugTVtA==
X-CSE-MsgGUID: rl5crQZ0RwCeRIGSn8IMHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43960534"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43960534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 12:32:53 -0700
X-CSE-ConnectionGUID: wNVo1/tCTEGIur4Q2foRzA==
X-CSE-MsgGUID: nle3g7Z2QJWEQQwqLtcB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124923143"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 12:32:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twnXT-00000005Xo9-0OTP;
	Mon, 24 Mar 2025 21:32:47 +0200
Date: Mon, 24 Mar 2025 21:32:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 4/6] vsnprintf: Mark binary printing functions with
 __printf() attribute
Message-ID: <Z-GzXglM4MGgzcgV@smile.fi.intel.com>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
 <20250321144822.324050-5-andriy.shevchenko@linux.intel.com>
 <20250324152012.413380d8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324152012.413380d8@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 03:20:12PM -0400, Steven Rostedt wrote:
> On Fri, 21 Mar 2025 16:40:50 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Binary printf() functions are using printf() type of format, and compiler
> > is not happy about them as is:
> > 
> > lib/vsprintf.c:3130:47: error: function ‘vbin_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > lib/vsprintf.c:3298:33: error: function ‘bstr_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> BTW, I find it disturbing that the compiler is set to "error" on a warning
> that "might be a candidate". What happens if it is not? We have to play
> games to quiet it.
> 
> Adding __printf() attributes to stubs seems to be a case of the compiler
> causing more problems than its worth :-/
> 
> I honestly hate this error on warning because it causes real pain when
> debugging. 

Tell it to Linus :-) since it was him who enabled that default. And since it's
there and defconfigs are also part of the kernel I can't easy remove that, and
TBH I even won't dare doing that.

> There's a lot of times I don't know if the value is long or long
> long, and when I get it wrong, my printk() causes the build to fail. It's
> especially annoying when both long and long long are the same size!
> 
> Fixing theses stupid errors takes a non trivial amount of time away from
> actual debugging.

You (actually me) fix them once, currently CI's typically run with W=1, but
with WERROR=n. Which means that the new code that is not fixed a priori, will
induce the CI red report.

> > Fix the compilation errors by adding __printf() attribute.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


