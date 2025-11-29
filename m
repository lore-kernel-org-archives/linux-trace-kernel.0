Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310118C33;
	Sat, 29 Nov 2025 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764459666; cv=none; b=s9zycH05U1IlTUABVpJq4nzbOoCmJoGDKDouH1wSjqGKUlwKjOZtWR/a/WN+vPPnmIvm/y7DLFdeXMlEH0g12H/cxwwLXBQ06JzG3whKkZq+XtaryfwOqwx4z494DYDLa5DKqwraNCLS5hrHx0Gii4LB/AsV0ftgvvNHLQ3qUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764459666; c=relaxed/simple;
	bh=1Yx6xH1VU9c4dOxKKfS19x8ISiXdwwHDK/Bvjj8xOeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqO4RuLHGHk0XX85E5EdyDT9VknT4QNPRsGEBJq8E/2wwWu+6Nff3tgANV855yj2z5UI8fmzkIPS2JuFmtsN4ZaaRCLsJO8N7zob3n5LoJ0c8tKjIWmYKtmNid5C1zgvalxPfS/vJuinNiEhUo0+YUdt5xVpEKEcRBK7l324hrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSXtdplp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSXtdplp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hh84OO8GDGioMHVuU15qRxGnztTlPm7zWtk9ta/Y+Yo=; b=pSXtdplp3ng8Hcy3TODJbEoRcL
	I1rX0aVrIOwQD+ozA0c+p2Y9AZHC1zUcE/ZGTmkilBoLVOoz3u9LYFUhb+0BKIBgNMicgNMpFumBF
	2p9Ojxkcay4snVxTypgXSvqtzQuPN77LsKMTgkrOcd9jUJ2f0U+Gj5ZQHRbloEIJia2dMUOOVDntq
	eA9lVjnVjlfFj01/jzU1WmIS/yo1E/JOg+JkHRDVJGukINIsGxmRfK3cS0l42BOoYex3l9sxP5PTT
	LNRrfJ148moI7dxPKeq/I7ftykxMyQWD0Efo11DThw8lBagWofKWnB+B1rVmXTJlqC8ium7lGm5Va
	zUMmFdpQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPUYc-00000001sCH-3mX3;
	Sat, 29 Nov 2025 23:40:50 +0000
Message-ID: <d88fe23b-dbe2-4084-80b6-52c79a6d94e1@infradead.org>
Date: Sat, 29 Nov 2025 15:40:49 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <aStYXphpN84Nr8LZ@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aStYXphpN84Nr8LZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/25 12:32 PM, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:00PM -0500, Yury Norov (NVIDIA) wrote:
>> The macro is only used by i915. Move it to a local header and drop from
>> the kernel.h.
> 
> Agree, if one wants to reinstate it, there should be better place for it
> (something related to kasan?).

or <linux/poison.h>

> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
