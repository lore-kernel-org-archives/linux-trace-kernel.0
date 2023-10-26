Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A83D39F;
	Thu, 26 Oct 2023 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCF0C433C8;
	Thu, 26 Oct 2023 20:33:19 +0000 (UTC)
Date: Thu, 26 Oct 2023 16:33:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Justin Stitt
 <justinstitt@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Yun Zhou
 <yun.zhou@windriver.com>, Jacob Keller <jacob.e.keller@intel.com>, Zhen Lei
 <thunder.leizhen@huawei.com>, linux-trace-kernel@vger.kernel.org, Yosry
 Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Message-ID: <20231026163317.4516369a@gandalf.local.home>
In-Reply-To: <ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
References: <20231026194033.it.702-kees@kernel.org>
	<ZTrJ/5Jrzz5D62hh@smile.fi.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 23:20:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > +#define DECLARE_SEQ_BUF(NAME, SIZE)					\
> > +	char __ ## NAME ## _buffer[SIZE] = "";				\
> > +	struct seq_buf NAME = { .buffer = &__ ## NAME ## _buffer,	\
> > +				.size = SIZE }  
> 
> Hmm... Wouldn't be more readable to have it as
> 
> #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> 	char __ ## NAME ## _buffer[SIZE] = "";		\
> 	struct seq_buf NAME = {				\
> 		.buffer = &__ ## NAME ## _buffer,	\
> 		.size = SIZE,				\
> 	}
> 
> ?

I agree with the above.

> 
> ...
> 
> > +static inline char *seq_buf_str(struct seq_buf *s)
> >  {
> >  	if (WARN_ON(s->size == 0))
> > -		return;
> > +		return "";  
> 
> I'm wondering why it's a problem to have an empty string?

Not sure what you mean? With s->size = 0, s->buffer may not have been
assigned. That shouldn't be the case, but it does make it more robust.

-- Steve


> 
> >  	if (seq_buf_buffer_left(s))
> >  		s->buffer[s->len] = 0;
> >  	else
> >  		s->buffer[s->size - 1] = 0;
> > +
> > +	return s->buffer;
> >  }  
> 

