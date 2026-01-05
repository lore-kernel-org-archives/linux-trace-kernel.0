Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122F20299B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636455; cv=none; b=qE/v3I/OxKnQ5S6JSZPne/MT08X+3URqGfmj1xWVFa2u6EFy66y+QT+Kw3hq8cUETrlCLJGR55oRVdFtdcAw1GegJ39AAe6VauWB1DvjPPJ6/xXskNXed1OWmhGQLgkyJwAPqBqyrG0DndPHOtQYM/mV+/uDY3ao4ttCrHUB6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636455; c=relaxed/simple;
	bh=xN/1Y2imSakEK2lDSZcBhgYB7FSZM1ffg6Nf3YT7Z+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLgHhCfZ8o2BoeCUxuL6M/grLi+5k4FRSwFlQ0Sv/qOLNnPu+EViqAN7dr0264ICY4Nw2fcjHzYLoZCoGCZWuEZoKLEDf1q6p7J7QMcuIf0c5O/lMJrktpgHNU40I2JrFpEzNRA97Y0NTImU9eF64HYzoIaLc7eo9dS3cOzFwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ2G34PT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ2G34PT"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fb5764382so2846937b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Jan 2026 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636453; x=1768241253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5/uW9/0KwBsgtvUptXheatwXpOA/HjQmX9wHy8TmRk=;
        b=nJ2G34PT8d2ZUg5NUhI2HmtRSAKxk+1R431kxJ9iawAS4AnLbEAMcnVqcyfw0s6YNF
         o9QDsDxa09AaeqWfgA4GXbqOtwY9N5DnNFyWpdom9Hy/UWbyRe6go6gcxQRpXSlLLthH
         v9zCEZbqGbu1Hwfsy66b+SOLQi1v9hcSWhk43zhL/VYr1ZGrkp7g7HX8nNcNFJZuXrjv
         KeeQlC4rmnq+eIQgoSMBe+I0hajXF+fXRzuAf1vCFNJYenJSMaIG4V6s/TE1KONol1vU
         4oZdwwGX6vl0fmxbnGIgMIS5KRyUfzKx2YEtbWLLU8FU8TN4BWh3eCYDEI1oh8q4LTfP
         3uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636453; x=1768241253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5/uW9/0KwBsgtvUptXheatwXpOA/HjQmX9wHy8TmRk=;
        b=e4BA3/gXkUiXLE/FucIxp3Riz9YAvcM2k8xK9dIkYNesbuESZyBsJr0J8/VIguWHow
         vHfBDJVdo//BA5nxQ2ue4GMW4G1jcjRlt+StBLzCF6IUg62Ccg0xC/5s/CPgPrObDwuF
         8NkMp6DJnE0H0HusuFZyd/utLBct6ttzPJ+CC1v3TGAZO1Rjf4gbm7bFon4dsSj0zxGL
         /DDN2cdMFHE7se9022AxRFad9gd6Xylx1CYM8oMXo/T0oALimfzXf5xhMpaitsGH3R5w
         iBwM/4nlk6OXc/KMsgMDyry6oFR19ya77CxXH6zfqj3onWE3otCUPq2TGpUw3szdcgFB
         wHNw==
X-Forwarded-Encrypted: i=1; AJvYcCU1khfbDFT7hOZ20B21xREEqREtoPXBA3G/DoyLdNyDK9VmLEirv6U1VXmBBvvRwmJQ6Bht3OzO7VEXZK6Q3+3gdck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMtLAhrOPFjdftOhlBnO+3VtUm2lRVgH0JRaJQVhb0bLlxD2S
	2LC9OSA6knKXERnDMzkJ1Bqgd3mGHQedT5QXU+u2wwzni+WV0EEUeFV1
X-Gm-Gg: AY/fxX6IE+TwlAqRwEXnAOnnXzPC/RvMZ/0dVhrLheoofGCRTc/4c6dpJ6o8tSnarFv
	F8RupMl77rW1PgJBgUawkygrBBbVoVF7uQcF3FJkx4GzoFhKQ4E2T9g1uV8BIWcOGlbAlec/vcq
	6N5iq0jsKwBz1JXzmbJmdmCE1RD2wNCh6DeVmZ3J93KcY9XCcGfdhMp1aHce8uxgOY1K8eB8+XQ
	kvjEYwC61PYl8d2dR8z4Yyf57Weg6coEHBnyvzF94znWkxcfiJ6ifgKfBeKKMtWXsVCfsfCSiPz
	Ecv1Mt84nHQX8BwwmUOhNispRIO/lY02LgX8/JKbEnPAlAavPhLo8sF1GEMsrRm9N8jh0MLqFhQ
	xLktu1h9zHyeVWX+lZuIJQPnkQs1F1xz7I8c2cxwbuuqKSBKM/8ZUXPTdieMGq1ixxfvyM3byhj
	65JJhF5n0=
X-Google-Smtp-Source: AGHT+IESx6I8tg0gbPIh4EuMQXlx4iATZY/+u860W1pgMc/DuCthIaOeJmHqd9Ob5cc2d8ol9SaLZQ==
X-Received: by 2002:a05:690c:30f:b0:78d:6a71:76c5 with SMTP id 00721157ae682-790a8a8fd73mr3709847b3.10.1767636452758;
        Mon, 05 Jan 2026 10:07:32 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:830c:9f83:df41:3e7d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87e1895sm1457087b3.18.2026.01.05.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:07:32 -0800 (PST)
Date: Mon, 5 Jan 2026 13:07:31 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Vivi Rodrigo <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVv946dXQfOifz5O@yury>
References: <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
 <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
 <20260105113902.6bdfcfa8@gandalf.local.home>
 <aVv8vwtGFhssitxG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVv8vwtGFhssitxG@smile.fi.intel.com>

On Mon, Jan 05, 2026 at 08:02:39PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 05, 2026 at 11:39:02AM -0500, Steven Rostedt wrote:
> > On Sun, 4 Jan 2026 02:20:55 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > > I do not think it is necessary to move it.  
> > > 
> > > I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
> > > should be included before use, otherwise compiler won't see it. Which header do
> > > you want to include to have this API being provided? Note, it's really bad
> > > situation right now with the header to be included implicitly via non-obvious
> > > or obscure path. The discussion moved as far as I see it towards the finding a
> > > good place for the trace_printk.h.
> > 
> > It's not a normal API. It's for debugging the kernel. Thus it should be
> > available everywhere without having to add a header. Hence, the best place
> > to include trace_printk.h, is in kernel.h.
> 
> With the above it sounds like you rather want to see it being included as
> kconfig.h (to every single file). But I disagree on that approach, why do
> we need this header to pollute every file even if I do not debug the thing?
> 
> But since the current state is kernel.h, the status quo is to keep it there
> for now.
> 
> > I'm thinking that my proposed config option is the best solution now. For
> > those that do not care about debugging the kernel, you enable the
> > "HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
> > everyone else, it will not slow down their workflow when they need to debug
> > code.
> 
> Maybe, to keep a status quo.

+1

> Seems for now the compromise is to have it split and be included back to
> kernel.h and later we can decide if the option or other variants can give a
> better granularity for people who are not lazy to remember and add a header if
> they need to debug stuff.
> 
> Yury, I think in v5 you need to drop this patch, otherwise we won't move further.

Not sure we need v5 because the only change is dropping the last patch
in the series. But if you prefer - I can send v5.


