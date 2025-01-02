Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14761991DD
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jan 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827404; cv=none; b=ITMIMvrYeMdA7NW3MFJvAkNMWLbr0FgnJX5AJwDLSOGcXfEjXMfikN8vaiTwc9GzL4c+z0BCevLDD3VLQ8sZobsf1GqJxuMjl6/jGJQ3M8Tzs+dWuaa5WMrlvL8HciEm3kxb4GC98gbpQ8pNnOVEJl4T9tQhoKqVOmGDEU3hlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827404; c=relaxed/simple;
	bh=CsCpQsXnlZGrwQ6tjkZO+RdYahDklYmcW3p6FeJDbb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCKo9jAGtAEX9covF7WFCcs8BbD4Zm8rgaJu55NMTLnAGcODDc9tJzXNpwid6Li5EMVncVpgTL+PweU0ZrVsQCLnU69sDfhkDQNqqlQ/y7PjxPtTN70/B8JdepoPbEdrcVbRrirIEOQ1euL/csVIE25KLktk/9YsDxQ8V+UhEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UgwoV387; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UgwoV387"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385de9f789cso8538691f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jan 2025 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735827400; x=1736432200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxeQmEUngUXl43U3DOMKAS+5QyXY4hU1UnyuidxxvAQ=;
        b=UgwoV387gy79JK3K50gA8oyGHtGJtfOMeGu+gNTRVEfNKuyEER9qcoLPN6FiNm9AOL
         tkUGB7i0LAztVBJwQPQFGCVMsTtry25uDHuON9xWEt27W1hwfM73jhabh7OB2GBHkFwy
         d1muJCfe1utuODd7UMzZ09ZHnois5B7sUxC7xmsX2ZDt1/Ovw8OYud8uAaphb3y08+24
         lKpRrYs7UOLFVF1nAMPWX8R44Au6hIum15xQh3/4wAQIuiRRX+89lOBUDGBAAMTQmKC4
         VCbIGdvYClxPctomZ+ee3H0jnh2rizcsoxNOvotbC9ndVKlBTItviNSug0ghgG3akR4T
         JtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735827400; x=1736432200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxeQmEUngUXl43U3DOMKAS+5QyXY4hU1UnyuidxxvAQ=;
        b=wUWl5Dp3L3oi/IOBAp2TRkeHgRdzEP6emsH0WcPqNcYLqVjevG8lj2Y/dPD9Pyygqb
         0b8KpDKB35Hz2GzsKTl5bij0toC+REsH8KDMpVJ88il95rDbP4hDp1OBk4ytDmCHiVxi
         UQj8f/AMqVvu4CddYk16d7FUFyV/lByPRrq0iz51VcYQfR+947xUMZab57UXQotgydXw
         ky1DsygGoSiT+v934PLTVhd7DRvZFjjJ6k4B4t3UIjHIJlSMcQGYonQa7PGKkzcNqB+2
         NNdQo2UbXhYeeISGcC/oFlPbi7tsMcIiiysIQyRQt4pa9i1v5xXlRhzufyxxOA9sYBLX
         9I3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW06hkq6mxjqmUpySq9D+RDnXTE9H+rX/mEkOI3bbyfmONGrLwz+PxVGFU29DevAxwvsOnP+KcH9lKSYeiJtlE995E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpCIr0dj1+B40l/m6SrvbTc/HKnOw/FwDWOtAjmZpG3M8iGqS
	85y+S8C7yWlOWsrKVYOmuMl1DhjqmsynrizjKzu8hodTazaEMurg4GmTrOCEJNHUTbVc3+QKHbl
	k
X-Gm-Gg: ASbGncusUdDqOvGK7MxOu6TN97C3kToxxfM5ZGYETjNK2EsKX3ZXTgep94NoYP6PJ7g
	rEttQq8ibAGJRZDzIraZkrSNpXEn6tN/KDTHmKzqYUWu9xyLY3qL1bkJswj/2w9v0EFBtJ2biY+
	G6FbPibwL9NRmBtaN9yLjmU/jAACTPD3tlc8FYariHeeMd8wyeQ6oE0CEftuAE5bvxmOl12Mg8o
	EWaztAh6o9Z0gJJfosPySnWx5FqBKRT+vTkNfuFgWaDArEMcTd3sj07eQ==
X-Google-Smtp-Source: AGHT+IF0uYcL7D50WlyAx8Vt1APUkhyFRpHrc2CY+y2uVGEJR+MiQFexcrXXw0PArWTHsuRdwTdplw==
X-Received: by 2002:a05:6000:1f8c:b0:385:f89a:402e with SMTP id ffacd0b85a97d-38a221f65c9mr41908200f8f.14.1735827399717;
        Thu, 02 Jan 2025 06:16:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm457961115e9.5.2025.01.02.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 06:16:39 -0800 (PST)
Date: Thu, 2 Jan 2025 15:16:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2 06/28] module: Use RCU in find_module_all().
Message-ID: <Z3afxC738frodOTr@pathway.suse.cz>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220174731.514432-7-bigeasy@linutronix.de>

On Fri 2024-12-20 18:41:20, Sebastian Andrzej Siewior wrote:
> The modules list and module::kallsyms can be accessed under RCU
> assumption.
> 
> Remove module_assert_mutex_or_preempt() from find_module_all() so it can
> be used under RCU protection without warnings. Update its callers to use
> RCU protection instead of preempt_disable().
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Joe Lawrence <joe.lawrence@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: live-patching@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/module.h      | 2 +-
>  kernel/livepatch/core.c     | 4 +---
>  kernel/module/kallsyms.c    | 1 +
>  kernel/module/main.c        | 6 ++----
>  kernel/trace/trace_kprobe.c | 9 +++------
>  5 files changed, 8 insertions(+), 14 deletions(-)

I looked primary on the changes in the livepatch code. But the entire
patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
