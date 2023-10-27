Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23E8489;
	Fri, 27 Oct 2023 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iq4Hkxr2"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAB129;
	Fri, 27 Oct 2023 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OUqZ/y2xkCm3zQNBC4e312DaqxOklBLq/b59VIOcDu4=; b=Iq4Hkxr2cxVF7xR8/dmC/adcpk
	IBV73W7uKhjhKeObOZ/QazPcu5ZscndEmBah5eSjEEbqWVKJJZ7IF7j72BUVy2yW4OrWg4LaHHvhZ
	XZquUvCykpawQMYkbp2TA28UCGsbRRiAbDl+TFZEBR68vcWrvPWxkTIoSW/tmTGOuC+ofqtlUfUtx
	RwafKRtL199yq5+mVVtFEyAz2GRGkQoWDuWEMoyiySwNlDMHxnYBpr0JBOXrS4vTRXDa5qjIIIhro
	FgelaR5Uom6vH6Ogeepx/N7bqyfG7xrT2J72NvXOgFhvQXJIEtgI4V5C3+OxKHfnTR4exGJ/iO/fG
	U3ETQHzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qwKT6-002zq4-Pb; Fri, 27 Oct 2023 10:53:32 +0000
Date: Fri, 27 Oct 2023 11:53:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <ZTuWrDdLr16Oo6La@casper.infradead.org>
References: <20231026194033.it.702-kees@kernel.org>
 <20231027045451.GA7838@lst.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027045451.GA7838@lst.de>

On Fri, Oct 27, 2023 at 06:54:51AM +0200, Christoph Hellwig wrote:
> > Instead, we can just return s->buffer direction after terminating it
> > in refactored seq_buf_terminate(), now known as seq_buf_str():
> > 
> > 	do_soemthing(seq_buf_str(s));
> 
> Looks good.  Btw, one typical do_something would be printing it,
> so adding a format specifier that's using this helper would also
> probably be very useful.

my hope is to get vsprintf.c completely refactored to use seq_buf
internally, and then printsb(&sb) would actually be a primitive we'd
have insted of printk("%pSB", &sb);

this would btw let us get rid of the entire %pFOO infrastructure.
and make dump_page() far less crap.
