Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860823ABA0;
	Mon,  1 Dec 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584256; cv=none; b=qxzE/wfb2GrFacoUT9iOBLUK0uCYjKsCw/pfctU66Gyl0+UImJJCZyXfSv9GjXJ6c1VkUS4GhYrIaJ/woQll05hQwHf4GwlqkkxmK/le9yd42QS6ZP4W6yKUL6BNopvsiLZd8+uqENBLcN3NNmKsxaIl3OrwDk/D40CxF4X5TTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584256; c=relaxed/simple;
	bh=vk4qK47QqCj11MZrLEouoNkWUPnCPwYPTCFOGIpX4YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THSlXgGL/7bk8/CFmjsnzhlOnlWsMRjG8RhuGt5U7WZA6USQAEa9nfyS9v4YHjm7XqNyG9Wq/w4IZXWH5CQXfbmutICmvqjyB1yRJtm2V/G2+XX5UHDPOfB/pU4/z7LyMwF0vLfr6Q0yYn8v8qgEEGdE35CxIjFH27Sm/U8SvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=fail (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=rVx7EVvq reason="signature verification failed"; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="rVx7EVvq"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vQ0y3-007bMP-6Y; Mon, 01 Dec 2025 11:17:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=jbAk67wx6puHSPXeeqlcTHdCQkcYEZyZZImVVFFW/R8=; b=rVx7EVvqDnSi1xaDxp6Bdj2a+3
	KJ7QOuAH6TZu0/wCdUh6/pYScotuk1Lz4m6EFcuu0Gkid2efRH/2gpTIhUE9dFtBdaZgDdMeHAUlj
	qE0janpBOcYNnjeNIz5s7V+cIH6wgnePpPLKfU509eo5IPUk/Wkd5eZ5Ifpq6DYhGl+6E5wL0hwok
	xtoE32w4Bb3h6AzTmEuz+vWZA0X7V5nN/SAFBWB77qa3iDnhVROHkpq+A4IRae7CYdhQ8v494/mWB
	R/UEnE2rMRLbxqSvvQfzvGBgaydx+tXBpNhCS9m+/aDGqFAsFdZUtE8Rn4q3B3d/WrPyqB0runynt
	JStWUsDw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vQ0y1-0000TQ-9I; Mon, 01 Dec 2025 11:17:13 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vQ0xr-007CQ5-Pc; Mon, 01 Dec 2025 11:17:03 +0100
Date: Mon, 1 Dec 2025 10:16:58 +0000
From: david laight <david.laight@runbox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <20251201101658.0b5ab68e@pumpkin>
In-Reply-To: <aS0CgnvRfQtam0uU@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
	<20251129195304.204082-4-yury.norov@gmail.com>
	<aStX3242e3mo5H05@smile.fi.intel.com>
	<aSyJ83v7EEAPHXeU@yury>
	<aSyertuRRX9Czvyz@smile.fi.intel.com>
	<20251130230925.376b5377@pumpkin>
	<aS0CgnvRfQtam0uU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Dec 2025 04:50:42 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Nov 30, 2025 at 11:09:25PM +0000, david laight wrote:
> > On Sun, 30 Nov 2025 21:44:46 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> ...
 
> kernel.h elimination (in the form it exists right now) is very fruitful.
> However, you may help with the (say) ioctl.h or whatever you consider
> really fruitful, we all will thank you (no jokes).
> 

This is the first #include path for ioctl.h

In file included from ../include/asm-generic/ioctl.h:5,
                 from ./arch/x86/include/generated/uapi/asm/ioctl.h:1,
                 from ../include/uapi/linux/ioctl.h:5,
                 from ../include/uapi/linux/random.h:12,
                 from ../include/linux/random.h:10,
                 from ../include/linux/nodemask.h:94,
                 from ../include/linux/numa.h:6,
                 from ../include/linux/cpumask.h:17,
                 from ../arch/x86/include/asm/paravirt.h:21,
                 from ../arch/x86/include/asm/irqflags.h:102,
                 from ../include/linux/irqflags.h:18,
                 from ../include/linux/spinlock.h:59,
                 from ../include/linux/swait.h:7,
                 from ../include/linux/completion.h:12,
                 from ../include/linux/crypto.h:15,
                 from ../arch/x86/kernel/asm-offsets.c:9:

Get past that and sched.h => processor.h => cpuid/api.h also
gets you to paravirt.h.
I suspect a lot of headers get pulled in like that.

	David
 
