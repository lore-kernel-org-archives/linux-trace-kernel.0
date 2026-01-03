Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AC30C61D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767450184; cv=none; b=VZjYVhH8LM6tnSC2WjL5YWsol6WGO+woqwiUfIzKQh3pZe2U/XshIASdCbnsCB4Tg6xKy2QSLHxRN/MvI5H+6WdfHfzQbdte+ATPEIPSYXqA0/+XC71DjSDRkpSt4+5HOghc2aaMffQqvXyD/P/wMzTAVjq+XDawF4xTyoWNpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767450184; c=relaxed/simple;
	bh=ZRSxVMtScwe6h3FIhzi9uAo8xP9iZxypD8mDCI8zPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXywKio4dizHewGnwkz/R/qqkvCJlgs9JYf/pn4526jyIkX06XCTP6ULnL4HDWDN/UT154lg5ovLP4Ejd3iweCViNBUAxqEnZuMVqzr12f0ZftMRkJndNl3Sb72whTaoYXeJ73P7+pbIBPq0jRhmJl7NYf2WcvMmLIvWrku86GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8qV92qz; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8qV92qz"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640c9c85255so12684765d50.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767450181; x=1768054981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWO8OL17OBUAj+kZREKMHrCa17fZaSRz1SGAoiZKS+E=;
        b=f8qV92qzykKHXPln1yAUhfqnTM+AYi49Wx9zSKlfArfXkAuq7EGbH4lROBAMoG/+BH
         Vz+wv2zPvPQv5U47TUMxJIbMGQKdalG1xRbd4ynxYCpzZUVVTK3c+/oxXPgnnPybKX5C
         FdaLzEis0GSDQBxK1bgYYDp/OthOT5kS+Kyw1KP7CAbbEl1I8+GJQClHghQH3WUFWvxy
         94/9UKEI46B6oFvpRBhKSyN0uBc9Ymk7dxotABs6p8OAGqyAorYSZ34ziUoGdUiF2DMj
         WCS5teYx5Xbll0/2gpZ0/vMyackFaDfQA4Gwk6BBcsMj/l5udOYg4HdFAVzq2b/pJLL/
         sunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767450181; x=1768054981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWO8OL17OBUAj+kZREKMHrCa17fZaSRz1SGAoiZKS+E=;
        b=IIOgC91En7uTRSYcaIjUttqK3NeZ7GdoY1Bin4wSEXcJz8aHFjp0LmnY/P5jF47xm6
         HPxfC43sdTu526RedffJMr/DuxZWb6vVDD8wwlskZe4cIcDtmC7TPRbMg9vL3qvwn2bH
         Hyn2g4jBos2Ph7KaO8I9NbyHN0OZDvG2dbSnfaKwOYQXlq0ZmSvKFqr5B0bx+Tf5l1pF
         Z+bvj6MC7NzQIG73j6kHZuvbbYJzu+M3gHFC3Pi+igHybHuE2IQZTWkPEvoTMgtenocw
         c9fyZXcbhHBN89XrdTRpH2rTddW9qvpY4YNlJDWbz5gSPilHvE1JN+udJ+/FSG6SnEhH
         E04g==
X-Forwarded-Encrypted: i=1; AJvYcCUpnKWSalttg9O4VFn2NnuhSFjlvViYvnOp4Hced5bWRFSIb1c6KxhTU2YMhsCGBjcwa5aalOzeNr9qBtPZ841R+4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMAoP+XSgZ3Ub+F2mkhz9n/cx/CkDi0UyPfOB66ck5dbfJ6Hf
	pSl7rrcAyNxESEXwaQ6h/iSP670XanQ7+PDZLitYHDVSmlPvxJsC5a99
X-Gm-Gg: AY/fxX53Q/N7yY6h6Xrq1+RjX7h1BR6gUWsoXaSK5Qh66Fruyr5EGyvg0RfpMIrcQdH
	5Q+SBFYZfE0YBUh18Ci02E7Ciq0HDjeLgOaT48xwzi/LrPCZEg1KOAq8cxo2NGh715BkZhd7xib
	SpOZ9MvYBkz9rz34J4aWNcHEf8Y2eVnMMhFPfOYYRAbRXxQQQWJUkxsMdi9cHIhwY2IaTxR5bk6
	dO6/DigzQ3/S1l6BC77apatszMSjOpms9HMxEAPf+zGq/t+cBXwg9A7am97Wv5thebztAcBq/g7
	QwUnQHVQAJoW4YXoT31bItVxyiS/dmRDw0G/zlzBJYz4R0ECFaZc0XQhMq2g66SoDPejKALMW5r
	Bbd3g1D0tFCh8nn2kML9fGvisV1Q4EJExUZ27Y0nhq2GakdK62PVz9+KfalkVl9hKpaQR+5eomW
	6fOAV/y9A=
X-Google-Smtp-Source: AGHT+IEdPmL19UdV/nj838Gi9cF7n++Nt3CuB8F8HM0/Ed6ihGLC5se2e1S4EasbnPz0/pKisPSC0g==
X-Received: by 2002:a53:cb03:0:b0:63f:a909:d0c6 with SMTP id 956f58d0204a3-6466a8b6552mr25947887d50.68.1767450181408;
        Sat, 03 Jan 2026 06:23:01 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3bbb:b821:6713:e729])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bcee0sm21277519d50.6.2026.01.03.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 06:23:01 -0800 (PST)
Date: Sat, 3 Jan 2026 09:22:59 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVkmQ4EGIQgAddZQ@yury>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVkSVk2L6VH9MYGz@smile.fi.intel.com>

On Sat, Jan 03, 2026 at 02:57:58PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
> > On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:
> 
> ...
> 
> > I use trace_printk() all the time for kernel, particularly RCU development.
> > One of the key usecases I have is dumping traces on panic (with panic on warn
> > and stop tracing on warn enabled). This is extremely useful since I can add
> > custom tracing and dump traces when rare conditions occur. I fixed several
> > bugs with this technique.
> > 
> > I also recommend keeping it convenient to use.
> 
> Okay, you know C, please share your opinion what header is the best to hold the
> trace_printk.h to be included.

What if we include it on Makefile level, similarly to how W=1 works?

        make D=1 // trace_printk() is available
        make D=0 // trace_printk() is not available
        make     // trace_printk() is not available

Where D stands for debugging.

D=1 may be a default setting if you prefer, but the most important is
that every compilation unit will have an access to debugging without
polluting core headers.
