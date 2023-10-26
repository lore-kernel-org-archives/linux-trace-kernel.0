Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD01BDC7;
	Thu, 26 Oct 2023 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420C9C433C7;
	Thu, 26 Oct 2023 17:38:52 +0000 (UTC)
Date: Thu, 26 Oct 2023 13:38:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
 <hch@lst.de>, Justin Stitt <justinstitt@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan
 Corbet <corbet@lwn.net>, Yun Zhou <yun.zhou@windriver.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-trace-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <20231026133850.138d5415@gandalf.local.home>
In-Reply-To: <20231026170722.work.638-kees@kernel.org>
References: <20231026170722.work.638-kees@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 10:07:28 -0700
Kees Cook <keescook@chromium.org> wrote:

> Solve two ergonomic issues with struct seq_buf:

"ergonomic"? Does it cause carpal tunnel? ;-)

> 
> 1) Too much boilerplate is required to initialize:
> 
> 	struct seq_buf s;
> 	char buf[32];
> 
> 	seq_buf_init(s, buf, sizeof(buf));
> 
> Instead, we can build this directly on the stack. Provide
> DECLARE_SEQ_BUF() macro to do this:
> 
> 	DECLARE_SEQ_BUF(s, 32);
> 
> 2) %NUL termination is fragile and requires 2 steps to get a valid
>    C String (and is a layering violation exposing the "internals" of
>    seq_buf):
> 
> 	seq_buf_terminate(s);
> 	do_something(s->buffer);
> 
> Instead, we can just return s->buffer direction after terminating it
> in refactored seq_buf_terminate(), now known as seq_buf_cstr():
> 
> 	do_soemthing(seq_buf_cstr(s));

Do we really need to call it _cstr? Why not just have seq_buf_str() ?

I mean, this is C, do we need to state that in the name too?

BTW, I'm perfectly fine with this change, just the naming I have issues
with.

-- Steve
