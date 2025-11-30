Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840591F4262;
	Sun, 30 Nov 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764483581; cv=none; b=Dszhvg+cSJZf/0jiC2Jv18lAwCduYE2OjC0JAGd1jx0omAwEmAIdGR/kmzxpBwX5k25z1mwgQ6pNjfm17q/5v9E47pYotzXrUSq8AwlbMJ7dgpVr+9xvpVd5cwScemYEA0bH1mcUVaCaKNOFT9cEpXD8iES+jeJx3NDWLKczXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764483581; c=relaxed/simple;
	bh=UdqnPIijC3meOjZBaPEmRHigWIk9kritbc8jd7mfue8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sto7w0jM/xVUGLZKVuaON2rNjmwoT2Uho2pDJV3h1rl3WXdIs8fpJ4jfrEef/dlD3b5vfcmONe/dIWSC97Zdca0I2yy3QEG5YkIpxjSWcokpBNVeAtuo5NIAZ81yPSa+1O4bkEy0qhwXgikfsg0VT9h1ihM6Zv/ySNKigNx2NTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1O+ufe3I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1O+ufe3I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rt2H3+YsV1Ah/Ev8lx7nrZ/yC+yGTNlGyhpvY/Czsfc=; b=1O+ufe3IOodReZZFEuh/XWgceb
	lPyYSG94S/HbBkwa0ugXvuXTGFRNx62ihA4+4zF66T1SH3PtF38wEx79Qcb07iEM8VLJKUwZ2ESdW
	H1VQ0KUJkgmiqv0RGf0GIi4majQmZCE/Rivw2IlQDzuVnY75lsFlgwXeWhqpej3nUOvxnaFfoQGi0
	EqfoGhX/mctk9lM7RulWQ9FJFlM9wo3CqqGyNN9P1hPjiNR8W4RuNrJ7/q1f/BUdAWMpLO9KAXh5+
	sjCwzMBAhznoebLFF6BWLxYgvZCmvFXTdZ5Y/b1USDwWngoDT7I9PYA4w34QtLlQx8ZYUmEtNoLr+
	BoQXh9ag==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPamP-000000025XT-3zu4;
	Sun, 30 Nov 2025 06:19:30 +0000
Message-ID: <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org>
Date: Sat, 29 Nov 2025 22:19:29 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
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
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aStWkK6exUj9YEC1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/25 12:24 PM, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
>> The macro is related to sysfs, but is defined in kernel.h. Move it to
>> the proper header, and unload the generic kernel.h.
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

I don't build allyesconfigs any more (final? linking takes too long).
It builds successfully for arm64 allmodconfig, arm allmodconfig,
i386 allmodconfig, and x86_64 allmodconfig.

And the source files that use VERIFY_OCTAL_PERMISSIONS() all build successfully
(which means that they possibly include <linux/sysfs.h> indirectly, i.e.,
by luck). There aren't many of them, so I checked:

arch/arc/kernel/perf_event.c:	arc_pmu->attr[j].attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444);
INDIRECT
drivers/edac/thunderx_edac.c:	.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		    \
INDIRECT
drivers/media/platform/amphion/vpu_dbg.c:		    VERIFY_OCTAL_PERMISSIONS(0644),
INDIRECT
drivers/soc/aspeed/aspeed-uart-routing.c:	 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },	\
INDIRECT
fs/xfs/xfs_error.c:		 .mode = VERIFY_OCTAL_PERMISSIONS(S_IWUSR | S_IRUGO) },	\
INDIRECT
include/linux/moduleparam.h:	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
INDIRECT

so all of them got lucky. :)

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
-- 
~Randy
