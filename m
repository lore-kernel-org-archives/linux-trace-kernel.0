Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610A32C92A;
	Mon,  5 Jan 2026 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605411; cv=none; b=hoIJOxy91m05gpH2VFoQcVvygN7pHqOKnEXnU3pF4Ls1OHLwTlzeCY+3A1xoJHrB5cjo7A0XnZgvK74ouie1+icdBcIT6AL1NxYoIWi8zp5JN0TDkwxhfEIPeNWRtSfqJEsTO08l/5ntBQ2cMKRUAPe1zVj4GdGXnohCURkqnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605411; c=relaxed/simple;
	bh=3aeeMp6ak1HerM3cNE27GpqkM0XuOeP2yNlseSEMLac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gaeujwwvh97COrWUnn+jKfVklExBPBQotA2Zq7WrsL0a3gdvXMelz0zISj//zeM7tzGUb57Q1a/9Fv0xdsYtSY5ojv4ol1baIuL5sCO2cw7+dr0B3yZaS4uO8kqPxBa5pRDQovCeXjlHF5Ga6t4vfouFqh5sEKq3jnEUxocu2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPjNB+l0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPjNB+l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767605407; x=1799141407;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3aeeMp6ak1HerM3cNE27GpqkM0XuOeP2yNlseSEMLac=;
  b=hPjNB+l0I8OK6O3P8VgIBF0avKzP+qt3BlP1O1mHnobP8M+kqTUUMfRI
   aJJwIGaJqChAjrAkcUToKGLosN2zMBtyQr9gvynzPSa95DNIsWZxkMyhJ
   IB+L5dmH+viuAdBkjaCITqy3+7y/xoqbdrHl+pkkEetS7o/VZydw6Q6OI
   PYi4Rvd0DOtD+o+UuCap64w8ceBSMxwoHVZnEooiu0h8Gv0zKaRbCsR+a
   HNlzYSY9E9BKw3m4IcFzVebQMqGuUwdK3DL8Oi+TNGQ3j4HPmO46qKZAv
   gpFx78DwuEUF0O8E1cVkxUAtYk0glk4AZXckwET0gTjVut181LU3JecKX
   A==;
X-CSE-ConnectionGUID: L/Vwt71qQ+2jYvMOxwjDtw==
X-CSE-MsgGUID: J0lj3E+CRo+wx+KyeY1tjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="69043959"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="69043959"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 01:30:03 -0800
X-CSE-ConnectionGUID: l5Ti4E8eQMaEq5OK4MdMvw==
X-CSE-MsgGUID: SK370VCUT9avmAy9E63dhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="233043201"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 01:29:55 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Laight
 <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti
 <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
In-Reply-To: <aVkmQ4EGIQgAddZQ@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2> <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <aVkmQ4EGIQgAddZQ@yury>
Date: Mon, 05 Jan 2026 11:29:51 +0200
Message-ID: <254c1096c3b892923dd12b07a8b80291b88c0e9b@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 03 Jan 2026, Yury Norov <yury.norov@gmail.com> wrote:
> On Sat, Jan 03, 2026 at 02:57:58PM +0200, Andy Shevchenko wrote:
>> On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
>> > On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:
>> 
>> ...
>> 
>> > I use trace_printk() all the time for kernel, particularly RCU development.
>> > One of the key usecases I have is dumping traces on panic (with panic on warn
>> > and stop tracing on warn enabled). This is extremely useful since I can add
>> > custom tracing and dump traces when rare conditions occur. I fixed several
>> > bugs with this technique.
>> > 
>> > I also recommend keeping it convenient to use.
>> 
>> Okay, you know C, please share your opinion what header is the best to hold the
>> trace_printk.h to be included.
>
> What if we include it on Makefile level, similarly to how W=1 works?
>
>         make D=1 // trace_printk() is available
>         make D=0 // trace_printk() is not available
>         make     // trace_printk() is not available
>
> Where D stands for debugging.
>
> D=1 may be a default setting if you prefer, but the most important is
> that every compilation unit will have an access to debugging without
> polluting core headers.

You do realize this means recompiling everything when adding D=1 for
debugging?

BR,
Jani.

-- 
Jani Nikula, Intel
