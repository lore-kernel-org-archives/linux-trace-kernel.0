Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453DA41;
	Fri, 20 Oct 2023 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgtOpclt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE50C433C8;
	Fri, 20 Oct 2023 05:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697778327;
	bh=fkP5kKXCMlyWPz7pz7wvmEyP0oUqwxiPLe8Hc+jGjLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgtOpclt1U1oMhg9MqET8TC6szYa15Al9kd0jIeU8oG5z16svOE3D7r/LYKs31a1n
	 i/VInf/SiAzumSwkkTtpCo/tgjbKO9Z/NeQFBOJkuLNx49NUmQyu8wcBVybT7Q/NyL
	 OhPi6LcRsT0LcsspWDvPP3xXDfTHJYlyLr9Hb6MQ=
Date: Fri, 20 Oct 2023 07:05:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] trace: Move readpos from seq_buf to trace_seq
Message-ID: <2023102012-pretense-agnostic-d377@gregkh>
References: <20231020033545.2587554-1-willy@infradead.org>
 <20231020033545.2587554-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020033545.2587554-2-willy@infradead.org>

On Fri, Oct 20, 2023 at 04:35:45AM +0100, Matthew Wilcox (Oracle) wrote:
> To make seq_buf more lightweight as a string buf, move the readpos member
> from seq_buf to its container, trace_seq.  That puts the responsibility
> of maintaining the readpos entirely in the tracing code.  If some future
> users want to package up the readpos with a seq_buf, we can define a
> new struct then.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
