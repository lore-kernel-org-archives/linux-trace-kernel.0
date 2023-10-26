Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE53B2A3;
	Thu, 26 Oct 2023 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F21C433C8;
	Thu, 26 Oct 2023 19:37:58 +0000 (UTC)
Date: Thu, 26 Oct 2023 15:37:57 -0400
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
Message-ID: <20231026153757.425a61a1@gandalf.local.home>
In-Reply-To: <202310261233.716843B8@keescook>
References: <20231026170722.work.638-kees@kernel.org>
	<20231026133850.138d5415@gandalf.local.home>
	<202310261050.A621A7F121@keescook>
	<20231026140247.3a3c68e4@gandalf.local.home>
	<202310261233.716843B8@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 12:35:43 -0700
Kees Cook <keescook@chromium.org> wrote:

> I'll send a v2 as seq_buf_str()...

Thanks.

-- Steve
