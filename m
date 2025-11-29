Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27956310650;
	Sat, 29 Nov 2025 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764448564; cv=none; b=mhFPWXh6LIgRvyE1ovEB+6Tp8OWcEsTTCvQrt3AmaySxmlP4DZinZPvAoV/c4P33lj6zzX7n5LdxSVtwERvWz0ewuWDvABB1Xb8iAb/ebfq+xKglxJpyhsBdrjgMioNSe1bPbmDYjGhBfeP5opp8NuE4vP/kIQgW4SFU4TzfzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764448564; c=relaxed/simple;
	bh=GKcls+b2Pk0UQ8XKL9EpO0xpIMNQ/Upx95LLgZbVEg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlZ1k+SCcAaARPTG/4Ao8TuQ3KQVO8EBOx/gtz+BrTRVklJESG9ZkbbBrgmk+99N0yaiTJIrquf5D27XQEz5a721DWlU25pfTwrjzidkjYRUFHD1zT5mjM0P29Jd0LftpzOmEgEYCIS/5+P81YsATppn/WCOW2o+NS+b3ptU6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFTBoZNT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFTBoZNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764448562; x=1795984562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKcls+b2Pk0UQ8XKL9EpO0xpIMNQ/Upx95LLgZbVEg0=;
  b=RFTBoZNTp1j4em+LXtDAlSzGDuIUqq36Pt+9tmPYKhPYOf4C/F2DXtXk
   if+VFdfb/12L8ZrRr41wUCPl3ZjYgCuaCCm8msGuPxrsFPTVDHfvjYC32
   qBuIk5U41x6sLtiWoQgjR4toAxh3V5s9/lzB5DNPwNuBCpk6nE2nRuGHH
   G5elKiuMCzN8A7GCxkfL4r1SeYvt+9ClJSQk2VxY7RjVdmXd9cnrLJtVS
   jDNkl8diq/tKn5crPuznIWqnE68LJ7X2Qwsna0TpwPu6z8THP83Z4Ff2u
   pS35qwuTeuYPTpw2o6egljfNYcDNV9G+rIKMeW6Tc5dyt6AR/j/zY7Zad
   A==;
X-CSE-ConnectionGUID: /57g4hd7QoO7n/RUCcBe3w==
X-CSE-MsgGUID: y5gPA7DCTne6EdJrqulEpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="70293433"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="70293433"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:36:01 -0800
X-CSE-ConnectionGUID: HJ0KX4FoRLOWivyefKYF5Q==
X-CSE-MsgGUID: MIDexseXT/29jhP0VccDsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="198043677"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:35:56 -0800
Date: Sat, 29 Nov 2025 22:35:54 +0200
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
Message-ID: <aStZKktOEWliXWT1@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <aStYs-LDKbJe6zvW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStYs-LDKbJe6zvW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 10:34:02PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 10:24:55PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > > the proper header, and unload the generic kernel.h.
> > 
> > Tough guy :-)
> > I hope it builds well in your case.
> > 
> > FWIW,
> > https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> > https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> > https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> > 
> > Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Actually, one thing should be fixed, i.e.
> Documentation/filesystems/sysfs.rst:123:Note as stated in include/linux/kernel.h "OTHER_WRITABLE? ...

And just in case, look into
https://lore.kernel.org/r/20251126214709.2322314-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko


