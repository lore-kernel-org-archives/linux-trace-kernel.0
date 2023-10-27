Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17637C9D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P237Peli"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10122CE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:46:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9de3f66e5so17670395ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698421577; x=1699026377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXwiHUF+X9lySsU8pvLVICiNMeHED6d+bcuJHhpa7Ew=;
        b=P237PelidtcWw8WiXDkwPUhlrhdZvIsGVzdAkchjolKTLfuy0roDgRVGXmpTGvtNER
         yO6DAxx7ehFFcsiAZUJWt4Hsii1U/+m9NMfontED91+8zliv9y/7Uul6Ba4IvMWpg+u5
         0w1zrF7mOYMIroDDH+tSMEHYMzGKpaDXTM65Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421577; x=1699026377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXwiHUF+X9lySsU8pvLVICiNMeHED6d+bcuJHhpa7Ew=;
        b=b5HMouqHoZuhsrlV7bA8g2hYa8JD2+tPWLlrLzkXEqpfwzZSDFGaCeo21MjLKh+9aw
         pNvWPkkaTEaMMAnLXwrcE5ZvsRiVgNnq+0agQE0Tw1uzF0MeyR98HL6JiYiQt6eJHGZK
         ewdANSfQ7093McPZArN7ZN6dpZlrUTod7xQ4HZpya9frvqhda/pT3Rskriw2rZdiaGh1
         25ENYTjtIj3u8NCzdM5wp/wYoNd/nBCbmcRZFqN5ry2ErThe+zgrR3WMUrCcYvbbuWww
         4/5JigfC16BDpqGSMN9VZp5gSOH8Jn6s3EkYGFM/UCXAF6FUUtTuI/OOEGOMVho/HrBq
         6YpQ==
X-Gm-Message-State: AOJu0Yw6ej7ww5106jyASI/g9Nje5PZGoWWFHqBFlPXCskKWSQ2oTvWR
	PJzoUKYS531mw4wIEK8dX40KsQ==
X-Google-Smtp-Source: AGHT+IGhmY9j5VDtwlDB7WV8OTyFMND/UgkMHgO5ObwArE+J9934qQxf7biq0pExELauYnurCtkMEw==
X-Received: by 2002:a17:903:2448:b0:1c9:b2c1:13a3 with SMTP id l8-20020a170903244800b001c9b2c113a3mr3650635pls.49.1698421577533;
        Fri, 27 Oct 2023 08:46:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001b8a3e2c241sm1746323plw.14.2023.10.27.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:46:17 -0700 (PDT)
Date: Fri, 27 Oct 2023 08:46:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Message-ID: <202310270845.3D1EB44@keescook>
References: <20231026194033.it.702-kees@kernel.org>
 <20231026154459.1603d750@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026154459.1603d750@gandalf.local.home>

On Thu, Oct 26, 2023 at 03:44:59PM -0400, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 12:40:37 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > @@ -81,16 +88,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
> >   *
> >   * After this function is called, s->buffer is safe to use
> >   * in string operations.
> > + *
> > + * Returns @s->buf after making sure it is terminated.
> >   */
> > -static inline void seq_buf_terminate(struct seq_buf *s)
> > +static inline char *seq_buf_str(struct seq_buf *s)
> 
> Looking at show_buffer() (below), I wonder if this should be:
> 
> static inline const char *seq_buf_str() ?
> 
> I mean, it can be modified, but do we want to allow that?

Yeah, good idea. I've updated this for v3.

-- 
Kees Cook
