Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F841F4181;
	Wed,  3 Dec 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764747672; cv=none; b=q8i23p7OUvbImF+j+DnT129b69GS6NeGxyZtUqtDOLMFHteuaPycOD4PHm/XKTl/v4IY6vSTjDOwh73hImiShvqqn5OOv0WDo93jeE27NevKI2FRXUL+Q1uK05RMQ/rvc4UgenWT/f3cZw8NE29T/+oaNHw/pr4VgZYdsIcHRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764747672; c=relaxed/simple;
	bh=MUotNHdZvHfpLJp7wYS966EzQOmH3nsQfIzCutAez2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWBs2gjJXwdwHMIpjU/VNle806PRVXTqWgIXCnNSIMSOfk5mHK9J2XQDa7vnu/IyWHCefLBL8i97OMwRqKne7OIMybr5J6y06MhL/xj8mw+ASmNYdlnYGUrI0WPfYNWL8MvcajCxM1wwHpo4Uary4gUCwgvvrJkjlGsI9HBb+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cF9q30JS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cF9q30JS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764747670; x=1796283670;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MUotNHdZvHfpLJp7wYS966EzQOmH3nsQfIzCutAez2E=;
  b=cF9q30JS4Rb1UotS27UlInrKtA9oYVLjLPbolDXRg09yrndWEln5LQ8r
   Vg85gpjNJ+2NDzsXiYmnt5vVyaR4Msh+UwKwvQa6ha5gv0sMgCUGAcEAy
   ikqCGiqom5O1OJamA/+pm/we6fbMeBRh0I0unxTDUhEQzvsx7sDg2SZG2
   gpUZVXlYluZ3DZLNIxo4+ZLaeX/7XUAZBzfX4dWps81hVl/m5RidyXnC8
   9/9pOQFRsEUCdMdfL+YwXneYdOiTu6AlXNzIi03ey5KTSII5xlKfGiz/b
   qDn9ZRc4slKsnhdxopkT70ccz9BTJagK9SgJbSR9OF7rxvQcDUrtq+ebG
   Q==;
X-CSE-ConnectionGUID: lgdvQJtsTI+h/v9j9aaqcQ==
X-CSE-MsgGUID: 7/xlFUElSDyRL21Tg4a+Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66692588"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="66692588"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 23:41:08 -0800
X-CSE-ConnectionGUID: HHV6KETJT6+EV5w0j5UZpA==
X-CSE-MsgGUID: w/IK4FJjTC+v44lCVSxgpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="231945676"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.211])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 23:41:01 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
In-Reply-To: <aS9XpaiGXn2upVKB@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>
 <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>
 <aS9XpaiGXn2upVKB@yury>
Date: Wed, 03 Dec 2025 09:40:58 +0200
Message-ID: <e049b13451395843971de33b2fbd9058eb351850@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 02 Dec 2025, Yury Norov <yury.norov@gmail.com> wrote:
> On Tue, Dec 02, 2025 at 09:58:19PM +0100, Andi Shyti wrote:
>> Hi Jani,
>> 
>> On Mon, Dec 01, 2025 at 09:46:47AM +0200, Jani Nikula wrote:
>> > On Sat, 29 Nov 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
>> > > The macro is only used by i915. Move it to a local header and drop from
>> > > the kernel.h.
>> > >
>> > > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> > > ---
>> > >  drivers/gpu/drm/i915/i915_utils.h | 2 ++
>> > >  include/linux/kernel.h            | 2 --
>> > >  2 files changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
>> > > index a0c892e4c40d..6c197e968305 100644
>> > > --- a/drivers/gpu/drm/i915/i915_utils.h
>> > > +++ b/drivers/gpu/drm/i915/i915_utils.h
>> > 
>> > i915_utils.h is on a diet itself. STACK_MAGIC is only used in selftests,
>> > please put this in i915_selftest.h.
>> > 
>> > I guess also need to include that from gt/selftest_ring_submission.c,
>> > the only one that uses STACK_MAGIC but doesn't include i915_selftest.h.
>> 
>> Doing this cleanups is a bit out of the scope of this patch.
>> Given that the patch itself has quite a good consensus, let move
>> it forward and I can take care of the i915 cleanup once it gets
>> merged.
>
> I'm already testing it in my tree:
>
> https://github.com/norov/linux/tree/sm1
>
> If everything is fine, I'll submit v2 with this change, otherwise will
> schedule it for future improvements.

I had a look,

Acked-by: Jani Nikula <jani.nikula@intel.com>



-- 
Jani Nikula, Intel
