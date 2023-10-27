Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073668489;
	Fri, 27 Oct 2023 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gla8Ilgr"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4FC18A;
	Fri, 27 Oct 2023 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZP5aSdt++PfYBmmXR7K0cUYLNkK40CzBkOiwfwjBGMU=; b=Gla8Ilgri2R/a3Tls4SvnHYOiG
	DzVhJ/dOhJFnVlcfZcoAMa4hR8UIv0lOY44zzjRvmjpBKNBx02s/+lEZ/WUdX6maSCnIQ7og+KGEq
	XK79QIlVHoH5lmU3ujrun4sQOTe55xHj8AYv5J5cnnXZThRnPQpno/McORFnbYm3QHmHprxPpTesl
	W8Cc41HrK+w6lbaSiOf4GeQ4ljY6kWAs73EpCFYEc7doYygVpdOUcAbl9Ya2dTM9cUCJKXwkmvKhY
	U+/JuoiCS4m1QCwCnpznISxaDsT0sf3LXTLvKgE7EmVzqopSg8L6w+6Va2yDrfJR6y30X9qorb5Th
	RmWQ0dhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qwKJ7-002xG8-VC; Fri, 27 Oct 2023 10:43:14 +0000
Date: Fri, 27 Oct 2023 11:43:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Yun Zhou <yun.zhou@windriver.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	linux-trace-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <ZTuUQZSrjhXnEaT/@casper.infradead.org>
References: <20231026170722.work.638-kees@kernel.org>
 <20231026133850.138d5415@gandalf.local.home>
 <202310261050.A621A7F121@keescook>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310261050.A621A7F121@keescook>

On Thu, Oct 26, 2023 at 10:54:26AM -0700, Kees Cook wrote:
> > > 	do_soemthing(seq_buf_cstr(s));
> > 
> > Do we really need to call it _cstr? Why not just have seq_buf_str() ?
> > 
> > I mean, this is C, do we need to state that in the name too?
> 
> I'm fine either way. I did that just to make the distinction between our
> length-managed string of characters interface (seq_buf), and the
> %NUL-terminated string of characters (traditionally called "C String" in
> other languages). And it was still shorter than "seq_buf_terminate(s);
> s->buffer" ;)

'cstr' might be short for 'counted string' ...
