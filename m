Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FD3AC35
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aywc3mCW"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A71AE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:35:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1caa7597af9so10217055ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698348945; x=1698953745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQC4A/sL4XoeDc7l3OjE8DP+73M4y+QZaaN7R7Z8PCQ=;
        b=Aywc3mCW9NW0AMC6WgUz95gu5oOfmutaPs4DHPoAfIJnUt8e5xK8aZiSjbq4BjtS6m
         Um4z9WCPAd2qYuDxuI0/pEzpzvshgTjURFCl8x36stzu2DhXmFDBWrhA5yaUN5Zr8sgm
         JBOEWHij/NraEObIV6BWKo1s9FbKUF5+nn/qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348945; x=1698953745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQC4A/sL4XoeDc7l3OjE8DP+73M4y+QZaaN7R7Z8PCQ=;
        b=cEUsURr8SBXTfXKt44ryram2ZHvwHzk1iWoAeojwXhG7afK+u17jsp2cirzWK9BSGL
         i+CAhgboA7XDmTyH2F7fjBZB+PQneJxNORHKQK8YEhkWuT9uu0uarv/O9JIwRkYibKIY
         ZntP13Pe4gUXrxN/YjuLz9CoB9jd4MFJr20d+H1aGXmlKqcJw/XXVx3tT2n2mTvn7KA1
         IhGZUSUPJ08+GdZIqYW8ITdqMqErqiAeR/zm5uaFgJPc9StUtZ15MVnSEb0wfl55EFkO
         bj9rBlmvYcaBN/i+7pt1h7QVfhM5BijPc5ABYmAOWwH8Hn8QmZO1eY78aIqy6OAxjlvf
         jg+Q==
X-Gm-Message-State: AOJu0YwnK7K1S4kYiBlYz/ok3zj6sp+kKnJrkZ4kceAAeAoSNYBMaxKo
	6ke1miJB0U2GdMyVpeVtb7Foug==
X-Google-Smtp-Source: AGHT+IF5LDmYM98HgrrDpR0APpEt3rwu9iztxBirzFeXmCAP46nFRKhSnMjIOUGuff1tVeQB7T13qQ==
X-Received: by 2002:a17:903:1105:b0:1c9:faef:5765 with SMTP id n5-20020a170903110500b001c9faef5765mr603014plh.5.1698348944845;
        Thu, 26 Oct 2023 12:35:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b9d95945afsm46208plj.155.2023.10.26.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:35:44 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:35:43 -0700
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
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <202310261233.716843B8@keescook>
References: <20231026170722.work.638-kees@kernel.org>
 <20231026133850.138d5415@gandalf.local.home>
 <202310261050.A621A7F121@keescook>
 <20231026140247.3a3c68e4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140247.3a3c68e4@gandalf.local.home>

On Thu, Oct 26, 2023 at 02:02:47PM -0400, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 10:54:26 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > Do we really need to call it _cstr? Why not just have seq_buf_str() ?
> > > 
> > > I mean, this is C, do we need to state that in the name too?  
> > 
> > I'm fine either way. I did that just to make the distinction between our
> > length-managed string of characters interface (seq_buf), and the
> > %NUL-terminated string of characters (traditionally called "C String" in
> > other languages). And it was still shorter than "seq_buf_terminate(s);
> > s->buffer" ;)
> 
> Do you believe that people might get confused with it as seq_buf_str()?
> 
> Can you envision that we would want a seq_buf_str() and seq_buf_cstr() that
> do something different?

No, I see your point. Like I said, I don't care either way. I was just
explaining why I did it that way. "string" means a lot of things to
different people. "C String" is unambiguous, and I try to be unambiguous
whenever possible. :)

I'll send a v2 as seq_buf_str()...

-- 
Kees Cook
