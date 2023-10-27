Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14DB5229;
	Fri, 27 Oct 2023 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CB192;
	Thu, 26 Oct 2023 21:54:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 59E8967373; Fri, 27 Oct 2023 06:54:51 +0200 (CEST)
Date: Fri, 27 Oct 2023 06:54:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Message-ID: <20231027045451.GA7838@lst.de>
References: <20231026194033.it.702-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026194033.it.702-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 26, 2023 at 12:40:37PM -0700, Kees Cook wrote:
> Solve two ergonomic issues with struct seq_buf;
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

DECLARE_SEQ_BUF_ONSTACK maybe?  But otherwise this looks like a good
concept.

> Instead, we can just return s->buffer direction after terminating it
> in refactored seq_buf_terminate(), now known as seq_buf_str():
> 
> 	do_soemthing(seq_buf_str(s));

Looks good.  Btw, one typical do_something would be printing it,
so adding a format specifier that's using this helper would also
probably be very useful.

