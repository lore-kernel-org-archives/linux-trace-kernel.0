Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD49480DC0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491841; cv=none; b=ZH4xPTc8kWdlWwCkF/8D6d0WdkWHPAyyPsQzgOOcRSQhYh+/KVVUga2a+j79ByiEcW7B00GGfouiLVMRq+F/TzeUmDL7STZbIJnV235A62/v66HqpOGz+BXAA6uXsFODXN0PELR6ZPwXxlehx42HHMLTmNWqQUodJuxBenH/R3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491841; c=relaxed/simple;
	bh=MBU7CS7WVwYwMOdcet6ICEOaUIj+8mKXQIBdEMW6F8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6gmYEjy2oKnq210nFmSnbPphWb7a05w6lM6MpZEFw4knbndg4Abx+kY1WTgzK5BFyFeE4m/i3Oc480tDPmgci0NVBh6xfkZ99hWa9W2o2FnET2UzI/V1yof1uksQ4d/mDAqM1fpojJqG+k4YJ08jAsXIA1OAiTAX8gLo7bL3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3sGvcpU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3sGvcpU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef1198766so428157f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780491838; x=1781096638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npACNw5GZ77miqur21FanA4v5+vTppUVJOnuElrt9AM=;
        b=S3sGvcpU/jeOsGKM513xHUN2IPbJVouwCe4+ZZppPDYfGFGJSnZbCfImj4OLGXXdlh
         /7fGwZIAVmucyU6kIY9xK0MRpVeefw4qWD734Kpx9P2uCjAM4z4dlgUdMVunipVWwFqE
         fdqV4lFThsgkyvsUiQ6rPlEK77pr4Iap71PsNggEUY81aR0mU67yVocfFtk0VnAOgsdR
         cjlo8SGHBPgquF+2mjy3xjPg3pCkPWdX4TrJf2DpRjAmxgru2UljmmDJseV9ePk57r8K
         DwCfmeldb+PzUhYwGnU5k9RXTKDBbI9yBuZJUkF+ngKcO/evQ/GS4CqwHDFDj8xbAwVt
         Pdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491838; x=1781096638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npACNw5GZ77miqur21FanA4v5+vTppUVJOnuElrt9AM=;
        b=tKMitM5tTK2j2BpHLFpW4elstnzO9bGULen3cR70iDYt0l/+7EK3e+mSZ3gmuvKjgk
         onZvqKVISpw/iVGWyrt1Fr2v1g/ysD+NhmL5MJBoSZmzKWNjCj3F22srX37rubjFgZq2
         NBJHxv34mo/3BloBgQLTbDYRaQ8ejjnFkQWlo4MP+Uf0L6U6BXhCHC61yK0oQRqPsGTT
         srdeerR67XdFdX7EVCX0+VCURNgfc37OWh5iM1q3Gg10iTbV3U8LjVBJjUtNss1x0ivf
         i/w5+NgDRFaWW5FsOuWDu1lJfs6juzh/kNrno7uma8t8qS+ruXxoHBbdCF041uZPVZ3J
         JM9g==
X-Forwarded-Encrypted: i=1; AFNElJ854ChE+yK8Jo6CIm2KXRMxhRvmWztMzN78BbCd3+rI8EKtRHcI7nAmgJCP6BTay1Oi0afmfoZ8BRiCcG2HNqtrL4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrVQQUMhSA/xqUI4Va2L5BREPPdzdLd4QBJmic31WZ7ae08oZ
	GCS22dhEAedf3SqdUJVVPSw0NmZ1U6t1n2rAddUy5bLDJv8VCPyCTTDk
X-Gm-Gg: Acq92OG0688rtRFi3SAbQSQw7OOf1LI1u7ZaCd+tX5anuqAsHKzv3s7kmcZQju1CsBT
	WjSwmk9+yvzW//KaShkSk3hYM71KNAsrI+HC69J3vOon3p9ZRA833edt0aeL09CeTUfHIb+Lln0
	g8j9G1pYMIqtCbCuLtRplBxepjHltqC1ohL/16Hjg5KWj4JaDRXklQIoyhEEvY5dvdw9ZPiXPFY
	Xk1LFsnnII7cpLU0pePqSbwtnuLedhbDdb79w6xLjgcUU/ZVLIir07Rlrfnn7EecbYZ01jTt99R
	ze3q/k7VeFjcC5iSYTIoMJ4KGH5HSfNpnGz0QGGoT3OLbR9FUNuR1P2WZiZBZxI6dQoR91Javyt
	Xp5lMtwysIZ3wU62W7Cvk3umsQE7+CKCwyXpG2CcqaQi7oaAmASH5VktSY9LQvPSbxuvd/pGA5b
	bqRYEqzuu+h2lC7LaP2q3LHO3pFOogBG+/ghs6H4DfEVxgk+HVpaaAL+oel6wf5+4zEZ9GEf4=
X-Received: by 2002:a5d:5f8c:0:b0:460:133f:2a4e with SMTP id ffacd0b85a97d-460212df7e6mr4465185f8f.13.1780491837758;
        Wed, 03 Jun 2026 06:03:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm7576265f8f.37.2026.06.03.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:03:56 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:03:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>, "Arend van
 Spriel" <arend.vanspriel@broadcom.com>, "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute
 warning
Message-ID: <20260603140354.6744499b@pumpkin>
In-Reply-To: <aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
References: <20260602150904.2258624-1-arnd@kernel.org>
	<ah8n-Nk305S5hRwN@ashevche-desk.local>
	<WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
	<35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
	<875x40hz7k.fsf@prevas.dk>
	<aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jun 2026 10:41:18 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Jun 3, 2026, at 09:15, Rasmus Villemoes wrote:
> > On Tue, Jun 02 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:  
> >> On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:  
> >>> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:  
> >
> > May I suggest a different approach, that avoids having that extra
> > function emitted (which presumably compiles to a single jump
> > instruction, but still, with retpoline and CFI and all that it all adds
> > up): Keep the declaration of __vsnprintf() in the header without the
> > __print() attribute, but then do
> >
> > int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args) 
> >    __alias(vsnprintf);
> >
> > in vsprintf.c. Aside from reusing the same entry point, I could well
> > imagine a compiler some day complaining about seeing the printf
> > attribute applied in a local extra declaration but not having it in the
> > header file.
> >
> > Presumably it will need its own EXPORT_SYMBOL if any of the intended
> > users are modular, and it certainly still needs a comment.  
> 
> I had tried that earlier but given up because the attributes have to
> match exactly.
> 
> This definition works with all currently supported versions of gcc,
> but may have to change when the there is a new version that adds
> even more attributes:
> 
> int
> __printf(3, 0)
> __attribute__((nothrow))
> __attribute__((nonnull(1)))
> __vsnprintf(char *__restrict buf, size_t size,
>             const char * __restrict fmt_str, va_list args)
>                __alias(vsnprintf);
> 
> We'd probably want to also add __nothrow and __nonnull macros
> in linux/compiler-attributes.h if we do this.
> 
> For reference, see below for the alternative idea I had
> that avoids adding the __vsnprintf() alias altogether by
> passing down the va_format using "%pV".
> 
> I don't think I actually got this one right in the end
> since I only build-tested it, but I expect it could be done
> if someone is able to test and fix all the corner cases
> properly.
> 
>        Arnd
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 4715330c7b6b..8e44fc3e60b0 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -956,14 +956,11 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
>   * gcc warns that you can not use a va_list in an inlined
>   * function. But lets me make it into a macro :-/
>   */
> -#define __trace_event_vstr_len(fmt, va)			\
> +#define __trace_event_vstr_len(vf)			\
>  ({							\
> -	va_list __ap;					\
>  	int __ret;					\
>  							\
> -	va_copy(__ap, *(va));				\
> -	__ret = __vsnprintf(NULL, 0, fmt, __ap) + 1;	\
> -	va_end(__ap);					\
> +	__ret = snprintf(NULL, 0, "%pV", vf) + 1;	\

This adds an extra snprintf call - non-trivial and more stack.
Can't you just use the old code with vf->fmt and vf->ap ?

And does the %pV" include the va_copy()?
It isn't normally needed.
Any scheme for avoiding doing the printf processing twice
is likely to be a gain.

-- David

