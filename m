Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049703DCDA7;
	Mon, 31 Aug 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174477; cv=none; b=me0HH46xdCbcB1NL8pO9dXTHQt1kCiwXJ9tx5AZWBK5XckNOOUcoo94dtk+6JeFRONembAw9raUiV77jYMUM+lvKaHW5+7+cf0xn9fwP86cx6Eykc0EGDga6CRGQ3MYL9PYE21w87Jf9tIyb+qwXa+OQGx+IkzyGZkFGWNOZO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174477; c=relaxed/simple;
	bh=tN9/4646I06ZqUiL5tNC7hE5LrKq7+GyA71T0RVzMrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZF9Ml/DHLeXY5UiqT6+SbsOfOJQbPQbXjJ3rew4pLfUSImvAj2+VK+vXC5tunwIQZY4Q5ozcGlrKV7tcdiozdJcJYuRgeInG+uvmI12Stf0ajZ8yWVY96rmJyqafQiUWsn8rPzpYgdB+Xea87y9Nrsp50SvwGdtj0baHm9TTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzmXz8qK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzmXz8qK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E71B1F00A3D;
	Mon, 31 Aug 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788174474;
	bh=lRbc6NoVpSJADo3t9OLS3vSkuIzqaYUV/pG3M+9xllg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CzmXz8qKaFHRiUh4PmRjzoctuzrUHfztr15M5sonT6jxNcuEEZL8hy8B4/AtyDW84
	 Vl5MvJHqcRL+QYbPVCrcgN69Yc+CLf6Xe0X29ld4zBs8m8/D0YAyP5TDTTb2C996MU
	 7ADr4JHYaGjyxq1HUNlZFaqrc+1fHF3FUIUBIfS4=
Date: Mon, 31 Aug 2026 13:07:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026083120-matrix-waffle-7ee7@gregkh>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
 <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>

On Mon, Aug 31, 2026 at 12:51:46PM +0200, Greg Kroah-Hartman wrote:
> Other kernel code might want to call add_taint_module() so pull it out
> and make it global.  If modules are not enabled, this defaults to a call
> to add_taint(), so all is fine.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/module.h | 10 ++++++++++
>  kernel/module/main.c   | 16 +++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0636e0f2728c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -29,6 +29,7 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/dynamic_debug.h>
> +#include <linux/panic.h>
>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module *mod)
>  
>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>  
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok);
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *mod)
>  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>  {
>  }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag,
> +				    enum lockdep_ok, lockdep_ok)

And this line is wrong, ugh.  I gotta go get sashiko running locally...

There will be a v3 in a few days.

greg k-h
