Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1F262FD3;
	Sat, 29 Nov 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764448444; cv=none; b=tEaiwcDyONzKQTu/4Tdrb8qptSoPF/t6OqeTgbGs68irUXAPki1GWpIZekM1+T/33byaNbTae30lTTjVdkVlPjU9wYaQebKsd/7WhX+5jrgJXq6jn4wcZMWe4ajpmFkpd17h7fk/Lbng9mDOhb2r21axbXkHlz5JeaOGWtcHmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764448444; c=relaxed/simple;
	bh=kU1QuoIkQDS8CxvKL6NvEr+zykBqz2/Z+pCc/nSb8Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBFisR/pWZciUcc94CbwdMuK7HWt1eprfYuV0mSjq6lp3TaANpJcmod5ZpTOK+G/VTqXxiqmjeYXgWic5jE0uaC7LO+aXD2Ss+j4wSaGZmTzpj8vOoOlHEpI2rXkUXii/hNIezarQVzZSZ71enr5S6OJNY1h2Ndep901JAabVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkEIDh+4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkEIDh+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764448443; x=1795984443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kU1QuoIkQDS8CxvKL6NvEr+zykBqz2/Z+pCc/nSb8Wk=;
  b=MkEIDh+4wAACGYDI08B0L5o6zVHrTDIPUo0O5Rmxv98i9pnJNeE3JgHY
   +pXBP6kC0rTv8PU98WLyP2m7d+5JHxo2I8348Y/Ec/YS3AEp97pughO9v
   6CD6GPMQNdbegwg+NjP7homYWEHcAQnPpCCzONe44FBobHTbXJXGWFmpJ
   sObuFLkbGYSrdG0XYdOj7eeofaLWRANbdJEhprE95HsdcfFVRkz9UelYh
   cgC6lBp13zBUVq7I5l/RyUu/7BlPxF3eKTA/sdY9DjpI4FX0v2eEJf42k
   XZzecJaIIlGe/2xNf8imhQW55F0uXFBSJl031anbPGUhCm3w11l7NgHr1
   w==;
X-CSE-ConnectionGUID: FcDV5SoYR8+rFuwgitAe6Q==
X-CSE-MsgGUID: wDp5QHB1S02/cVeeYTKLag==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="77062510"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="77062510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:34:02 -0800
X-CSE-ConnectionGUID: pTPPe07hSIajirdMDWsVVQ==
X-CSE-MsgGUID: IGjX9ZOMShyrrAa+vUUvbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="193503327"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:33:57 -0800
Date: Sat, 29 Nov 2025 22:33:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
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
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aStYs-LDKbJe6zvW@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStWkK6exUj9YEC1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 10:24:55PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > the proper header, and unload the generic kernel.h.
> 
> Tough guy :-)
> I hope it builds well in your case.
> 
> FWIW,
> https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> 
> Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Actually, one thing should be fixed, i.e.
Documentation/filesystems/sysfs.rst:123:Note as stated in include/linux/kernel.h "OTHER_WRITABLE? ...

-- 
With Best Regards,
Andy Shevchenko


