Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508390;
	b=m+7N/KuErAuLcjN9jaTtr2khuqPQyfcvOfNYFBiDTUlqKbjYM+75+Sb6qIB7FbWHhSx4
	 pRhhy9QAS9fguRNAx/h2qK3sB4FuhBh5cUHhhNvF9V1zsHO9kG+gp+iBlsIEj7jvDlx1d
	 UifGpcWo8AgSxllhVJol881y6DrJrw12vXhb7UBpMVgsv4j6YTjimnDVp9LWDLGilPZ3B
	 iOnvAgpGMJqbcvQMnHfN3jp2AMIYb9uDy5rA8oS5YPJ1NgJ21Z4dEp03mslp48toCF8Fu
	 GSGdMHyy0MjRD94ELMM0ZHYoXazBH+iXjeeu0mq3D1EwDM2mc60xXxXcmF19y7neFlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
	b=Yo3DJ2PUXQO6Wy/tElvE9cFcdxmFszBdv2/3ydq6zaAj4QvMeTRYFmqvyEWNWxbwmYv4
	 YmV/w7RQ4yO4zF0zNSr30vbhA82oDluhy5jTe37+boY/YXRZszruUzFObAxFxmQ8I5haJ
	 woZLW5ZP3akl2Hw4Xlbq1ur61xx90/vwO+Uymcm68XIxofifSEWiRCocbgI7FdAjaAHxN
	 Y9Zi04NrS1XcCMjeBAazBXrl8VAwIAMY6+slL9aKXT2MAreZcwcWZyNammMDzE/1M6snX
	 s6qCtusFTnUUldiHu35vSA4HOoLH7fNNhsB1o7NLsxMMTJiHq4uAM76tTBIiycSxWWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+hCYSRp;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BA606A8BB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898BA606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+hCYSRp
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50933bdf4bso31443566b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508389; x=1795113189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
        b=L+hCYSRpqtbZvvzfTPM51bNUhMq2BbuykAG5oFAhxSmlmrzcY9wgwVFlr9REQwSZ3x
         wFQ6aD5XkVDSlS/t58e2UDg4YJLULKoeISY6s48Uc8/WoP71bu8tnqwwhKrweZaLpmyV
         dIFkAlIIk/2ibebZ6Clb/IQ1VW9uBuNzs3oRGC3Cy/4rIjM8ybiqZ+dPvrCsX7ObOkTu
         3yV5Ycwm05puJ4S++T/NemezOeH+JiHw7TmJPBFnw7JNh6J4/wpJgrdWY4J5FQsB6Gkq
         ctxI8c7X7ypxK7cTPvieH4Y2A3rpTI2NqPrPISkBK53e2xSFbKFOl1D6Pa39J3FtUw6v
         egfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508389; x=1795113189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
        b=wI0PmmwuidbfvECK6JuXaidjBdloYwNNmmOBpR0opMvhGsC9wVuR4Gg6ZAAggS4tQu
         uUGTPJJkZEqCkHAj4+UUyVI83iQIXxbiWg9U80gfzXYsY24Cff3Vj7Aq03rkDI2zUkBq
         7r5FMLh9L0g1QE6pxdckc2fIefd4hSeVPNlNblr2Qg7e30u1PC5BVEPsCx1ugeWiiRcp
         jj57juZS5GY0pnUk4LszA47YkTOaDh7BEQw/nuDhi87eztd3X1TZ2fKmhq5irLYqxInn
         oAFyt9M9oVVfgqyWFx3g5CKkotpmWoPPv/l1PeofQBUE4kWhwj7cacUELEw00+CfD/0L
         6yQw==
X-Forwarded-Encrypted: i=1; AL+hErGeRrwWzFml9r/dTBuCcix3ZwxaPr4KG5S2/GJvgzHlW9/0bmgu71hDkYV4bPO8jDmrKplA1VK6iS0QkvMHSraK7OE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zac6FPmtsFZO4mP5TA5+EDC3dM+vbX+WlEO0Dr8XpgQj7zbBk
	F5QBZHA6s3jdaTiS5Z+nWTPYWrpwdRPlxCrR4wHNE4VQr+AI6E1+15FB
X-Gm-Gg: AYBFou1+5HyOtf+v1JVsEtH/NFJY8nW0oPMjJZMmjGM1zV9VEoGSd/9RY8uZ6Nbrla6
	o8vcLf2uKkoByFJcF6ubke49wFB7zBWEmfZIGAK5yf8e9/wA0Z9wE0+rVvWLvOL68nUPwIPyJcl
	OhCg8ysuJr4vAtPbU13/IwMYEkVC/XVfIO17f0VMMePaUjPKf0g155PbMdAFidGpLuvv8raakhd
	FVnpphj7c28D5mnXkB7JvX0OmaKQsIl2fY8e0ClfXmmBmjzynJY9w2ymjzdUb3CQXtZJgHmwVlx
	LTqsVhVRyUcEdRs96XuH+glB8NqcVyF+57VqX55efZhqsQdS0P6hoasV+CvcPbrlC+1UsTphDUc
	+ZOFHdenCYBZqH8ulhUC3c59uWh4XabI60gfMYBe+pilZ9WYEoy/023TiX/IApD9jdjAJ6eqVgc
	WuX+wPrr79FE2VAeEZJztebHl3u5fK2PoB8MXhzaJGby0qy6/8zKXh39MkhW0OcXR1jHd1jeR87
	P1Lzw7X3Z77W7+XF34gA9Ijgq6uHjKjghmlpHjoj6j5/d77uS6zQZGqXGyEospH3lC+vfyuqoI0
	DtzJj8VlYvLBVZqyvYSt1XOkyHFu+JLcOadW+A==
X-Received: by 2002:a17:907:c0f:b0:c2e:2275:1168 with SMTP id a640c23a62f3a-c507c3fd35fmr333753066b.19.1794508388705;
        Thu, 12 Nov 2026 10:33:08 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b2369asm6139766b.25.2026.11.12.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:03 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <avYGX1UpGlvbvHO5@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112090734.GH2668804@noisy.programming.kicks-ass.net>
 <20261112101108.GE2669272@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112101108.GE2669272@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 11:11:08AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 10:07:34AM +0100, Peter Zijlstra wrote:
> > Looking at this in a little more detail; I'm confused. 
> > 
> > You're literally adding an index, so that you can find the
> > static_call_size, while all you really need is static_call_addr().
> 
> /size/site/ obviously :-)
> 
> > That is, you could have just created an array of relocated site->addr
> > and sorted that, that would safe you a ton of indirection all around.
> > 
> > That is:
> > 
> > 	index->entries[i] = (long)static_call_addr(start + i) - (long)&index->entries[i];
> 
> Should be:
> 
>  	index->entries[i] = (long)static_call_addr(start + i) - (long)index->entries;
> 
> They have to all be relative to one location in order for sorting to
> make sense.
> 
> > That will make your lookup take at least half the amount of loads.

hum, but we still need the site’s init flag for static_call_is_init

I could store site pointer directly instead of the index and see how
much faster it is


> > 
> > 
> > Also, you really should support modules, there is no point being fast
> > until you load a module.

I had that, but decided to remove it because my follow up changes
did not support modules as well.. I will include it

jirka
