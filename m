Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB00238C33;
	Mon,  5 Jan 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637869; cv=none; b=n3u97huniznofGjQKOw60Bqz1JPPGOqvNiJGUHahAZZfR2Fjy2GgwpFblz5DwijGDn4NuN55s4Y2cpoEavS1jIVhTY50ngWq0qieTy90RboLyvX0AeAYG1sMoJDINWusXCd+ZChkiX0z4yHR+A8YswCw1eWzaE+OfwKvsZeU5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637869; c=relaxed/simple;
	bh=ktHXCzPHJgY7XQIgZS1cpiTgqKNmo93Rr7YlINKPrMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+lJrv3st4EjBxXBAE32ORNRLw2Zawc5vsA7zKRMsudRJhS7n8KvOJrSefMFm4fX2GB9S18Ye4mhhTTSh1dbECB0qX2xFqd0hi+NFCkjMv0sx4cWYXBa9kSY3LC+SfyOjL4QfRIAIFfWGryC7yWF1F6KUHaPja7srzkiQCNO67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHSBsAKC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHSBsAKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767637868; x=1799173868;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ktHXCzPHJgY7XQIgZS1cpiTgqKNmo93Rr7YlINKPrMk=;
  b=VHSBsAKCWsTchRQ5kii4WWYah2RcOU73lT2miX5uPEdUfK6QssJhHMVy
   w9cov7H9n/SkKiZxxSoaTkSQIQIGh9RMZpyymVsGs6Vt1I8/oCGG5/Dbn
   JMWYi8PYOwnS5Vjs9LgKHzd/x0tyFQ893ZdE+z3YTJNlBBpWHyH9ehEcG
   248oOns7KKHtxGoeYjH7x99jN3WC3IfTmAbFdYgQ1VXTC0Wu66GLTuBf/
   yTYW1HMTGVbJ+gZyfvmrm8i4HHRD1lskaMvcQ9PYz62vhJEb/AN/OgUKR
   yzMB/l9hRJSz8wK+NKm+FVCivtdtYPhQrSdzWIE5w+6RcD3+m0HzzPbxo
   g==;
X-CSE-ConnectionGUID: QrjLEm3tQRK7q/8U/HCnBw==
X-CSE-MsgGUID: 8iNZM7uHQxau2g1N7XYLQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69165762"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69165762"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:31:05 -0800
X-CSE-ConnectionGUID: xQbfnGbcRSiQ1JYrgkaMhw==
X-CSE-MsgGUID: vHKsorAGSpqZSH/ARbKQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207347253"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.3])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:30:57 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew
 Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, David Laight <david.laight@runbox.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
In-Reply-To: <aVvoe5fQN3EUtEAJ@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2> <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <aVkmQ4EGIQgAddZQ@yury>
 <254c1096c3b892923dd12b07a8b80291b88c0e9b@intel.com>
 <aVvoe5fQN3EUtEAJ@yury>
Date: Mon, 05 Jan 2026 20:30:54 +0200
Message-ID: <7df7c705c02cae6d609a3bc5f153082cf0658a60@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 05 Jan 2026, Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Jan 05, 2026 at 11:29:51AM +0200, Jani Nikula wrote:
>> On Sat, 03 Jan 2026, Yury Norov <yury.norov@gmail.com> wrote:
>> > On Sat, Jan 03, 2026 at 02:57:58PM +0200, Andy Shevchenko wrote:
>> >> On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
>> >> > On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:
>> >> 
>> >> ...
>> >> 
>> >> > I use trace_printk() all the time for kernel, particularly RCU development.
>> >> > One of the key usecases I have is dumping traces on panic (with panic on warn
>> >> > and stop tracing on warn enabled). This is extremely useful since I can add
>> >> > custom tracing and dump traces when rare conditions occur. I fixed several
>> >> > bugs with this technique.
>> >> > 
>> >> > I also recommend keeping it convenient to use.
>> >> 
>> >> Okay, you know C, please share your opinion what header is the best to hold the
>> >> trace_printk.h to be included.
>> >
>> > What if we include it on Makefile level, similarly to how W=1 works?
>> >
>> >         make D=1 // trace_printk() is available
>> >         make D=0 // trace_printk() is not available
>> >         make     // trace_printk() is not available
>> >
>> > Where D stands for debugging.
>> >
>> > D=1 may be a default setting if you prefer, but the most important is
>> > that every compilation unit will have an access to debugging without
>> > polluting core headers.
>> 
>> You do realize this means recompiling everything when adding D=1 for
>> debugging?
>
> Yes sir I do.
>
> It would be as simple (or hard) as building another arch:
>
>         make O=../build/linux-arm64
>         make O=../build/linux-x86_64
>         make D=1 W=1 O=../build/linux-x86_64-dev
>
> If you're both developer and CI engineer in your company, you're likely
> already doing something like that. If you're CI-only, there're no
> changes for you. If you're a developer - yeah, you'd have to learn a
> new flag.

Learn a new flag?

What I'm saying is, if you're doing regular builds as a developer, and
*then* realize you need trace_printk(), doing your suggested 'make D=1'
rebuilds *everything*. Not exactly something you want in the middle of
your development flow.

I'd *rather* manually add that #include where needed, and rebuild just
those files. I don't even feel very strongly about the whole thing,
other than the D=1 being the worst suggestion so far in the thread.


BR,
Jani.

>
> The real problem of course is the status inflation. The fact that
> defconfig enables CONFIG_EXPERT and CONFIG_DEBUG_KERNEL implies that
> every random person who is able to do:
>
>         git clone && make && sudo make install
>
> now assumed an expert kernel user and active developer. It is not
> correct, and it leads to bloating kernel with dev-only features.
>
> What we discuss here is a new marker for those real experts and
> developers, I think. (In an hope that it will inflate not very fast.)
>
> Thanks,
> Yury

-- 
Jani Nikula, Intel
