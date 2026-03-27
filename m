Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B03DA7CE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602924; cv=none; b=ZQ94fzFPaDixYoDRNV8DJbYnE+geKVe46dx1f9j1fSSV3SSkMs3qUOGSdY6pucDJKhFpOHg6KLnV2FAQQT2Br5+ZASVqmBptwLLrYlz+vNlz47ZhDYYtvKGhJQZKPZSFMrFPm2kFjB79tFUhqkyMpxd+1TofQamxmaMVheAkHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602924; c=relaxed/simple;
	bh=yIsyHXyRCryuRuOcOXaPz/ctpDnD6BiebwbWh9U77Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccGRG216yJSL/G5SriG1gUrK7x7O1sUZlk664XSL6+ey3esGNRUGMOQC7uwA2XgLrZ+GWHeee/h7k5mSpCqfRzrE6nbCS/7rlmD4Vt9hSDev3Tg/8PWqGXRpChMXwk7H+wH89P9idz377MVjTir+gtjRrOdPH0Txrm56AzKZD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VLqWbUV6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VLqWbUV6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so2186724f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774602920; x=1775207720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdNRKYDuFQQDug+hfuOfBMl8q0HCBO0fxPZCsqPcCxg=;
        b=VLqWbUV6xtrQB+VR3bXxCQ6K4/uOjT+zKGLtWIQNTgFDidoBt0LwdEApXRoh4TKERK
         1/IS86fnyiUwaRaFqtWwRlEe+43P5TUhINojkso4TP706soNn8lAetRHu0vIwmyoIEkJ
         StT8xQ9bfML4t9hLpN7sFXzKOHVMd2fxAIxBL/2TVCIPdr3EU/OtwcIj+/FIbUSzRQK9
         HTyNU3yzK1l7NiFRM+0JRASaglwVNLsdW6/TjpfZiwJX3s1w2iRpd7EUoT/bt4KykVUe
         2UzMFk5KoJCOkuaS3QBfY81+0pet4+XgyxPZfJZD72Av2CVP5ytr7x/DaaclCGq9fpj+
         /z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602920; x=1775207720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdNRKYDuFQQDug+hfuOfBMl8q0HCBO0fxPZCsqPcCxg=;
        b=Pzb2Ox7LCbRXGFxQ/JRprksdTFFRXe+j+N1MkLr3RYcj1dLGjfGoAXq7FgxnUrq8Up
         jqhtYZrrIjSfOL+v5UoJCeyA8lG4JCSRAnYp+VmTvuVupqh4+mg/bnybsQKTOpB/3cJA
         +gIgnPrsM8jxEIGIJYyFiI6G9O7/8daYObwyBo+Bj+cXygdhrdBMw3naS+N5a7Aju8Bd
         dBIL5cV74lLWrZpGs14VTn6F15/IRyoflekVU4iN4a7Kjtsp1NtztB5LtLS8gDLCiQqN
         KnBwVtMu1uhRzAInCi5FrJvgLor2vpYdM+TOFZ4VHPegDc62GhUd1JrfhTx6qgq8AIHZ
         c3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWVoGK2nLcBXlSe4QX9U9Wdfl7ZHT0odv+AYf87mhaEsTb44JogKGTwTHIh9LntyIEq4D6j1ECYiIAvTZeIcUUac2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgkYC5SM66mH/RBNJvtSFG6EU6PuKI30xcGkSYktN7EIFS3A5
	yWGFYZS/CrbytT32c5kqJw2msJTsoRbz3uIFlZ7HCBcZQQONTCyBsI2jeHylxhKU1W5cTzWpcem
	la7W8
X-Gm-Gg: ATEYQzxjMwOsVzAjO1DRLH9SK7r+EbKdfGZBbhJgEQNZNvFS6wBGBLN0iTCuOReLI02
	wTjRWmz0J2GPD4OlUf30W+5CD1JLWP08RXUuBmpxsBZeSblhcBP2pHhupREv3ZyhlRZbt1rDg/n
	6A7cwfXts5cSyqRUF63RRlcNM43XYE1k2pJiRoVG0X7pDk8DF8hj8RHe+HDVagUqp7yPG+Fk8RO
	AYKtGrM/YlZv2BgoD6YbsDnL957qts1m+nmlUUOW7pn+pjXtZ148pi1S1LGquaaffSR1JnUjuwi
	4u/tY5FdAxiwumoEor5/9gfOYT4/5HjnYzFcTLJo2P2uEak4krb4DCcLuYl2MPf45Qzrr0uSzzp
	tPR7D+rwO0E5cD5y2G6YDCg+ftXrd0iEuOBLCdI/X0cMDESMF172HMgcmbCts5apP69kh3tKD6Z
	lfmkDeK+5s0kAzcH4C+sGs/BrXbw==
X-Received: by 2002:a05:6000:24c6:b0:439:c1a7:9dee with SMTP id ffacd0b85a97d-43b9793753dmr8304327f8f.0.1774602919658;
        Fri, 27 Mar 2026 02:15:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2bdsm14652097f8f.21.2026.03.27.02.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:15:19 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:15:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: david.laight.linux@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] tracing: Remove spurious default precision from
 show_event_trigger/filter formats
Message-ID: <acZKpXQDTEPCU813@pathway.suse.cz>
References: <20260326201824.3919-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326201824.3919-1-david.laight.linux@gmail.com>

On Thu 2026-03-26 20:18:24, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Change 2d8b7f9bf8e6e ("tracing: Have show_event_trigger/filter format a bit more in columns")
> added space padding to align the output.
> However it used ("%*.s", len, "") which requests the default precision.
> It doesn't matter here whether the userspace default (0) or kernel
> default (no precision) is used, but the format should be "%*s".
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Makes sense. It does not change the output because it printed
an empty string "" so the precision did not matter.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
