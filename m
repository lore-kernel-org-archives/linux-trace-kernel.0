Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AF1519B4;
	Mon,  1 Dec 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618695; cv=none; b=MvkSqR//RqxEQFeK7zxx2Owa4vf9+XPxdvc7II2KqEW5twFtdpBAoLJDmuSjQWdlWXbm1Dpzy1MbqC4/jHsUT46XgsZpvgEAP7nAlm1DXGfDEjuHV3jaXWQarUB26Z4r9qU+QKcd8hyDopxsX5kWk+x5pDH5dhwNoJ2Ab4Zqt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618695; c=relaxed/simple;
	bh=1bmU8lDqT3DBy4kD1cYksvjAny/xr1K7b3cmRp+wqf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkSFA00ZmKaFu5euhugAjU59vl5ZGlpD5ksqu4fyMHs3cDjr+7LtXOKncaEzVJwwpOqL9XLmI1mIY6UcLtXPDNeY3WPyD6gxtWCb8Qrba6u33AMR0iHhEFCp0t++UyojW7ZDB5LaMIL0GruUH2mHLAKIxRQodCXFd7pvsdx109I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u6oxBj1y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u6oxBj1y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lHFArRupasM7BNvHKiWIXC1PtoLVsBgVkotkW/Jg0vE=; b=u6oxBj1yUwATRFTDdYOpfVGxNH
	nfBDfRZ79bvzO25OH0JEDj5iD7Y9at48ZJQEv59Nh7X1bgBjPn94CfuypMXEszeorwuglgjhz9R5g
	Qp8AeZsMQ0ywDxRmddmVIFtqN8x/QWirQpLfvgvZypbQL3c8dAXHYnDYXfbCPe1MZM4Mrbaev1oxt
	7It7xFoTGWvxes7VfG9HNAKuKaKehi61gs8rAZuYO1dfCjrubFxTo3ty14U1dDdcqQ4BhJg+dr8mR
	qXyDzUkMj+mMe/GgFrPiX2+uqeSRGP3cI+4uD3L5/uLFDuIX4/mTWJN1z1xZtPSw8MmCTQ5/Zx6Er
	hP5oryyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ9vh-00000004TXb-3UWY;
	Mon, 01 Dec 2025 19:51:25 +0000
Message-ID: <fd755bbf-50a8-46f7-bff1-61cc625118a9@infradead.org>
Date: Mon, 1 Dec 2025 11:51:24 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yury Norov <yury.norov@gmail.com>
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
 <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org> <aSyCC7TQoGgTn2rT@yury>
 <aSydSI-h3KZiYBn6@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aSydSI-h3KZiYBn6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/30/25 11:38 AM, Andy Shevchenko wrote:
> On Sun, Nov 30, 2025 at 12:42:35PM -0500, Yury Norov wrote:

>> This series was tested by 0-day and LKP. 0-day runs allyesconfig,
> 
> AFAICS in the below no configuration had been tested against allYESconfig.
> All of them are allNOconfig.
> 
>> as far as I know. It only sends email in case of errors. LKP is OK, find the
>> report below.
> 
>> All but XFS include it via linux/module.h -> linux/moduleparam.h path.
>> XFS has a linkage layer: xfs.h -> xfs_linux.h-> linux/module.h, so
>> it's pretty much the same.
>>
>> I think, module.h inclusion path is OK for this macro and definitely
>> better than kernel.h. Notice, none of them, except for vgpu_dbg,
>> include kernel.h directly.
> 
> Ideally those (especially and in the first place headers) should follow IWYU
> principle and avoid indirect (non-guaranteed) inclusions.

Can you (or anyone) get IWYU (software) to work?
I tried it a few months ago but didn't have the correct magic
incantation for it.
(no specifics at the moment)

-- 
~Randy

