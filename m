Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468D3321AB;
	Mon,  1 Dec 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764603460; cv=none; b=kg1hzpHkr71SLGjVP2P5nKZ0ThBuGZYbFT7EcHSAA9fy03ytuKTTjkLXXJA7uQ5MQhIU7CM9iTxjeRsGK3EDpDMv3O3lP2tC1OFnFf/EKTrr+dlOhuF5VUzO1ntf1cB4XmZ61byhBMfX2O65OyPyHiiS0V7qCQlsiJyTzgz/p2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764603460; c=relaxed/simple;
	bh=MeU4jNo4ernEmKrA7RaGnmNcq5s8KiPFvWMXT/71V+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+sbYPhjOvE2NbW7ioBG0KuH3Ur3peghlIRxEFZGiK3inJXbBfHrvNZib03g3+wRMmcQhDM3ZINfH04FnzVOUoiza8uKE7j4F2HtcdOCYVuhlrj0dlv/wDzN7cevL/DXBzXvnbh+zLjLBa3iib1iOruq5K9718wxotqSftkiqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nONQSmY5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nONQSmY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764603459; x=1796139459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MeU4jNo4ernEmKrA7RaGnmNcq5s8KiPFvWMXT/71V+g=;
  b=nONQSmY5ZPZA93vDo11oGgIkT4hjPcZ3imkHh7+AZWr91OSJuKz7aDMe
   i92BdW11gD4tQwtpMxQTAWjkANWaJwRSwLYrBB9y07X25ZjtbvA+vN+40
   Gd/yU/4J9a51KjjhCztyDzEgnnLe/MIU3TWbJdWGcJHnZQb3WKwuSOGB6
   JkdYVYgS0vfRkBis5SbU1P8bw1Pxpc4f6CKYn45vlUnFhQfVnGcDK51i8
   cq5TigbypCOC2683tQjfetBTJMC3GCZlTyq2mIAmrrhx6RMQgWSnen4xH
   FXSMJFZTRHokDDGZRUXGEZpn28781jmxql0G9o3+/LKXXsCsQCP6RY9QE
   Q==;
X-CSE-ConnectionGUID: viKa686eRDqktfalRPgL2Q==
X-CSE-MsgGUID: d1ctbVyoTQKQiFTg9wNd4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="76865942"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="76865942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:37:38 -0800
X-CSE-ConnectionGUID: bwEh+8eUQO2uePvE/vXKxw==
X-CSE-MsgGUID: I7ELKOFwQYmhEDN2bjD6bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="193225939"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:37:33 -0800
Date: Mon, 1 Dec 2025 17:37:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: david laight <david.laight@runbox.com>
Cc: Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <aS22Oyx5XgAmouqZ@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
 <aStX3242e3mo5H05@smile.fi.intel.com>
 <aSyJ83v7EEAPHXeU@yury>
 <aSyertuRRX9Czvyz@smile.fi.intel.com>
 <20251130230925.376b5377@pumpkin>
 <aS0CgnvRfQtam0uU@smile.fi.intel.com>
 <20251201101658.0b5ab68e@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201101658.0b5ab68e@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 10:16:58AM +0000, david laight wrote:
> On Mon, 1 Dec 2025 04:50:42 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Nov 30, 2025 at 11:09:25PM +0000, david laight wrote:
> > > On Sun, 30 Nov 2025 21:44:46 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  

...

> > kernel.h elimination (in the form it exists right now) is very fruitful.
> > However, you may help with the (say) ioctl.h or whatever you consider
> > really fruitful, we all will thank you (no jokes).
> > 
> 
> This is the first #include path for ioctl.h
> 
> In file included from ../include/asm-generic/ioctl.h:5,
>                  from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
>                  from ../include/uapi/linux/ioctl.h:5,
>                  from ../include/uapi/linux/random.h:12,
>                  from ../include/linux/random.h:10,
>                  from ../include/linux/nodemask.h:94,
>                  from ../include/linux/numa.h:6,
>                  from ../include/linux/cpumask.h:17,
>                  from ../arch/x86/include/asm/paravirt.h:21,
>                  from ../arch/x86/include/asm/irqflags.h:102,
>                  from ../include/linux/irqflags.h:18,
>                  from ../include/linux/spinlock.h:59,
>                  from ../include/linux/swait.h:7,
>                  from ../include/linux/completion.h:12,
>                  from ../include/linux/crypto.h:15,
>                  from ../arch/x86/kernel/asm-offsets.c:9:
> 
> Get past that and sched.h => processor.h => cpuid/api.h also
> gets you to paravirt.h.
> I suspect a lot of headers get pulled in like that.

And several headers like ioctl.h that is "pull half of everything".
device.h, for example.

So, you can start untangling them piece by piece.
Not sure how [1] is actual right now, but I believe plenty of those
can still be used.

[1]: https://lwn.net/ml/linux-kernel/YdIfz+LMewetSaEB@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


