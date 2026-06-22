Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968A38331D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144143; cv=none; b=P6rI3ImsOx15FacMG61YHUeFxl03kz7OdEFFpb+tZm3Sn7Rwdj6SKWJaI2mC6ej7ymXOusYqBgEESn1MvxMIe7m/rLrAs743jNBvjgoPV4J+xPZyihO7yWYqlTqt8TqEYd9EJAz3Hyw1QQi6IGNkTa9Q4luVq5bf06VGJqRmUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144143; c=relaxed/simple;
	bh=3j3RWwKIBC5z+lPgcvjTkAH36dzUMFgvLSqCHYRhUjU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSIBLgQYL4UCWGBgfQZHe9Z6OjjgqrrxCC1DKkjpEOBFHw4Yll0gyqHKmk7UmcLly+z7g//4uoqQ6AafR6Qm0wXzww8UkOpOc+E/iKlxUlcL8IEdX/qHHFkI2jXd6+hgWCTVJnuuq/j98A86JLYC23Izfdf2fzKgLJattBUUp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e945KFNK; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e945KFNK"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1397e093f90so871860c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782144141; x=1782748941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=na9mhvql+8puTQ1gJkQUWQ0VcnmXVKlqG48pwQ1mhh0=;
        b=e945KFNK1NFFHjXYlsBVzFEH3XIZjQM5u4bVryIXAX8SU8wYVZ2l+c290ZXVy13eI3
         88eW0VCJcN34EEsEOIR7fzdxMbThIR/kJPVUH2Ap4rkJlz91qhSt7H7qD5mJtIoz0W/z
         JgoT2o8vXTWLnPbIkFm5ppQMwUlV3xOVPtOLWrViahszBfoIrm4jH7oWGz520odFqz/z
         O84pI6ZdZ3gSEep9IQBCYY+iRfmSL+z2XJoHALWDOSGCgJT2D1CYiB/8sTgz0VZLWpIu
         mtnynoZrH4mYVXpng9eF//MFxynZmGOwFugMi4aqIYq51kbipkjsQBPUtQDGkijBmZxg
         zXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144141; x=1782748941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na9mhvql+8puTQ1gJkQUWQ0VcnmXVKlqG48pwQ1mhh0=;
        b=pGnkJI39pmcSe9GZrn8UNV4I6DI824bX+0D9u19qgwElBvsOV7dtqY6W/Zr4M2opvn
         ZGpPA5Peq05jYW8Vxm/KrZiN2kONpCqv2fS25O9Vsu6N09gzA29oIS1BowCJaeHtN4s4
         hO16jHOMO4QOtwtkhb73NoDEBcVHANqnZmqya2RfrgNsTK7bZtq/vzQEkzZM5yNSrY4j
         yCK6Q9bsjTw+KlGKNz3bu/fZ7yS5ZiUfYQuQLS19G/Fe05L2KEw0QiClwUuDMXjTiUY6
         J9eyKtlZ6EWXj4okFXsd8VSeWuhhr+2S7J0QkYlqi1u8IJObPX1SPIoN7Nzuar9q0gIY
         UJ9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ESv6QrW7dzEz/D1RbjnXuZgnz3uoDCVkvod4sJv0GfcGhTgYx9p6vv/3l69+frXN2zzU6VfVca5+YOa3X5OOpMu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3HuhWFVNdmqne7Di3+komgXe0+hUdUWeFyVQlwaQbBpTD2du4
	Cm6eJvXhdl11eruHZsoz+N7VKK6AlPeHD3PxLStSjugOJpIkJE4GgOxx
X-Gm-Gg: AfdE7cmOvSjq067Mp75WO/kv5tSDzKmZywIBmXCqwH9YqYm8c4zJMZFm1sac4ShRIRV
	f1jgaKlXxZ4wqpYxRUX40vUkyHZK+391w3ZqmILMivXLf4U27J95C7m30llhOJ73pgjMiznRaBJ
	f9UOosxNkuZGBH8x60BmzqWHYFwkU3Y1xI+w244AKlumIwi3XkIitDCfF8eccDNfw2EjKNH2o1F
	t8SBrEuUFxcGbmvgq2RKpgK69+VXChQmldX5cXUgUW017Ua8qBeLCumt1t0DmVnpo3oOO9gaoGS
	Y3SGlx0ED6CFKStS2/UQuWKfZFa3FwGax67i1ZDuHj0QKLtZhhBwpObMgzPnR1TIGgKyCy/gAJR
	letJmURu8AO8RHoctjwT5Fl/rj//++avecEEmgboJOvRnpCm7Kgw0Tw/ohL4JILRojPnpCb7BWK
	GRV7srl5Py
X-Received: by 2002:a05:7022:f417:b0:138:6c:478e with SMTP id a92af1059eb24-139a3686f0bmr8660024c88.32.1782144140762;
        Mon, 22 Jun 2026 09:02:20 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add81933sm7891547c88.14.2026.06.22.09.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:02:19 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 12:02:17 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2 1/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
Message-ID: <ajlciSfVixfYG_ln@yury>
References: <20260622130739.375198646@kernel.org>
 <20260622131029.655382134@kernel.org>
 <ajk7fN5v31kCfGVp@yury>
 <20260622112127.5763f5ba@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622112127.5763f5ba@fedora>

On Mon, Jun 22, 2026 at 11:21:27AM -0400, Steven Rostedt wrote:
> On Mon, 22 Jun 2026 09:41:16 -0400
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > On Mon, Jun 22, 2026 at 09:07:40AM -0400, Steven Rostedt wrote:
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > In order to remove the include to trace_printk.h from kernel.h the tracing
> > > control prototypes need to be separated into their own header file as they
> > > are used in other common header files like rcu.h. There's no point in
> > > removing trace_printk.h from kernel.h if it just gets added back to other
> > > common headers.
> > > 
> > > Prototypes are very cheap for the compiler and should not be an issue.
> > > 
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> > 
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> 
> Thanks, I'll add you tag.

Thanks, but can you also comment on trace_dump/ftrace_dump?
