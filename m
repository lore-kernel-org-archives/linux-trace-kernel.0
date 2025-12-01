Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA291FAC42;
	Mon,  1 Dec 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616833; cv=none; b=fJwsXRB8Z90CqYf0FApOUe2YOLR9AyklDwVQbP8VXahH7JPQ6gIQwruRVaP0+bjq5szNWexFmOPbykJ1lVbaeBx88fvoY/JmUbDJeJ+8/hFZddCq/4kxiuGWbbUkk79o04bsKc0vdA2AVxnN2lqCT6uSol4pZmRoTR3yNhg2f/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616833; c=relaxed/simple;
	bh=aonye0tlAvNGnQxCutJyOBdaip/hewIAkc66JsRr1fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr2ZW0bfm9Tyw471JW+TT5CJ+fOtcJzvYl71bOCub2O0GHzcph6WPtm7+YN+VIaXLnOSR1dMXKp6xClnT6TZ7McH1hwbCPE4TyiAP47Ds1KVi+RJeyvopb991fetLXl4ugx4glFEubAFdyk+I3Z4duiyMFbjciPzV2tDW4tfsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeJBkL54; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeJBkL54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764616831; x=1796152831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aonye0tlAvNGnQxCutJyOBdaip/hewIAkc66JsRr1fE=;
  b=BeJBkL541uy5Jri442uSnWW577ZFN48vgl86nlNZDxpKUCTZwsR0zx6x
   sHYezJclLyHicht3bppuWRdT8LmwFjllQ+xtLyXD0hu1/ZW6nUB0Oaqeq
   82TM5r464GFj/k1yGQUNT6nAMpjY0vsMEPuMTBdlXniH8iU5QMbQf7gsi
   At06g6aTRrRJ5yarnFQ7qb4Tia1qWOTkpPLJBrcYkK7aOrCjXxMTu4avX
   KT0TuU94yuaLvAYD2+KoIZ4wLw217zpybcO3OHPbwaKcqf/VfohHwOQlf
   sj9U71DEi3tazaHA0N8OwRxUBb0uM5S1ORLEJgNtlooVSo9II09Mgu6Gu
   g==;
X-CSE-ConnectionGUID: ljprIbEfRaygbouCn2UCOA==
X-CSE-MsgGUID: SjcaNsB8RnukHeFx5DzR8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77257110"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="77257110"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:20:30 -0800
X-CSE-ConnectionGUID: 4ymANUSGTIiz5hqaTHvpnA==
X-CSE-MsgGUID: 3Rwt4ccUTAa71Ggv8DCsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="193835168"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:20:25 -0800
Date: Mon, 1 Dec 2025 21:20:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aS3qd9FC-9nBGYEP@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <c45058d5-d690-4731-85d1-434971c16f92@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45058d5-d690-4731-85d1-434971c16f92@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 08:01:23PM +0100, Petr Pavlu wrote:
> On 11/29/25 8:53 PM, Yury Norov (NVIDIA) wrote:

...

> > -#include <linux/kernel.h>
> > +#include <linux/sysfs.h>
> 
> If you are removing the kernel.h include from
> include/linux/moduleparam.h, I think it would be good to update the file
> to ensure that all necessary includes are now listed directly.
> 
> The following items are present in moduleparam.h:
> 
> * __UNIQUE_ID(), __used(), __section(), __aligned(), __always_unused()
>   -> linux/compiler.h,
> * THIS_MODULE -> linux/init.h,
> * __stringify() -> linux/stringify.h,
> * u8, s8, u16, ... -> linux/types.h,
> * static_assert() -> linux/build_bug.h,
> * VERIFY_OCTAL_PERMISSIONS() -> linux/sysfs.h,
> * ARRAY_SIZE() -> linux/array_size.h.
> 
> I suggest then updating the includes in include/linux/moduleparam.h to:
> 
> #include <linux/array_size.h>
> #include <linux/build_bug.h>
> #include <linux/compiler.h>
> #include <linux/init.h>
> #include <linux/stringify.h>
> #include <linux/sysfs.h>
> #include <linux/types.h>

Good point. And since we are not adding some top-level ones, this shouldn't
be worse (in terms of potential cyclic dependencies).

-- 
With Best Regards,
Andy Shevchenko


