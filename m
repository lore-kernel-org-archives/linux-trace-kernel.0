Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1493EC2E0
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 May 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652281; cv=none; b=Blvf8xqrhl8ui+DSMGNVLGaDTSCBGl63v87dmzGxNZqb3I1xbRXByrUxowcw2keMf1rZdEjkd2NrLH7wgMmvQfYVzsv4J81xXuZhvrF7euaKCrx/sMSO+eX2GWIcxV+UXnjLLsxQfnJQLuHSbj0C9Sv3gO1w9zpnxP+TYuuH0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652281; c=relaxed/simple;
	bh=fHm5Pyi5rYT8KdARR59qs5ux4lfu67iP4VQ5zTLygx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjtz2Uw/cO/FIUq8O45yMXiR/fy6t/LwPDMwqjnpjJ3CbKfAalI8kR5OCtm52054auHyMSn9kHfXMbmiea6AcZxBdgqmVmvaz+IHqWZSDzgQLHg/tfu/FtYmRBsgg+vku3W7pArOxJG7/Os+KkxKX/RMXygjRseanSFT9mGltt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXniiiqu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXniiiqu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1242614a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 May 2026 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777652274; x=1778257074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CO64OyUjm/s1GHWMBBxHpdtkBMmcP5rdEOIfDDfkOlU=;
        b=nXniiiquTxQzEY57CNolpVQY8CzF9eSzzvP/bXGfUiSyYesszRbW8odeB/NDCPurC6
         EuOqzrDBUxIzpthPb/fEaNS61wyxr8lzO1PrN5bK6pwKF9UN4Rf2VYYIqAZaSMYxtKOT
         im9IwZ+Suo89Bsb491njoTXcS7OGxlO4l8D5cWxj8S60O2/SPSm21/Ao7x9caZeCc3jU
         qktkr71uKGfZKu9m5zcsG8ew1kkWL1y31Bga5fBgQCMLMlesA++euJ2FNqGsFt3oPrGE
         UoIjagL9+EE61kUmTK09UMK1q04CI89E7V0JvtEG2e2fa4Pe8wPAl//7Rx7pRx39F0On
         8jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652274; x=1778257074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO64OyUjm/s1GHWMBBxHpdtkBMmcP5rdEOIfDDfkOlU=;
        b=diJKb4ROOsw7wVbUvpcAKwYNyRnjaf8UliRaOkx6M0DPBIBSXNJhqxDiCDwvOf35+4
         w8jkW5G6rXjp5q7tc22mbntk2ujAq50zdo2IoiuEXOOJn09q6I3Crhp2HJ7Tf1s92eFD
         dbZ2GfEFTLpZEVME96nHMTRY+bwg57Fo1s88MlxtQk4P9xbgjttx9+HV7gInNTZcgtNR
         jFoYD4/pSLdGs7jLIPyWiiQVus12VSklyrrM60kmvrqrsv2ckj40jE7mJSuNTKiwUoY4
         dGdyj4QW74Cs6us+76QDaObNLn+9oRNWWZ3/5rwuIpryBuSuGO/sFUM1v6T890N1kklA
         XvNw==
X-Forwarded-Encrypted: i=1; AFNElJ9JeYc6HLLmMvtA/Qd5DqeXL+Iciax2giNC3uf/H2PUC92Hhjb6OXa3NrWakhwG22hyJJ9pzmTWYgDSbrdCMd8L1MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccyMl1gDsHUKIQJ3Uf+uIETwfh3P4/TlX5SIiUPFe4tWZ+koc
	BBLBVGzGbG/34m4yIOpoVamr9L3g7dRkw2bbJBCo54G5YuSklXH9lsgu
X-Gm-Gg: AeBDies5ZBPBm+LOdHO/e5GSwGaXK2hPuagp2t7LriIl98g+xFL2LXlSO1IM0CjD4KX
	IU2VTj2oeK2Stm3KmGsf3HXvFo2cK4t4t31kgqAB3yz1vkn9Kx3Nhs9xvYQSwgHlOhskbwdDiDQ
	6204IAm7BGwxYnXKUjo3+HWgk+4GXUXYZgsGnB+9qLmeTtMA0FVDcCD+5XUKa5jDGS+S5uZegGd
	TSdHeXjxx8w82LcTrEINiX6cxcoxn3pMryKJUFjKdD4/PDPYX12IajSWrw2R1V03yQfv1NeJW9Y
	s3YCI9qt5dUKZs+abEZO0cqH8Y7S4ug5T1dnYxeW3/Aj5psSTRp+xchCXKlcgfZZHVUuUDp6r43
	417IDyEEo3zBmSpkDN27BDLpklQ6pVIAuBD28YAcFFcGrXouVfsCwjG8znLjElknuk6e7PZFanA
	snCReE3LxZxtbCPxikniK63O8qGDG5PCcaKZ7pj1d3
X-Received: by 2002:a17:902:e746:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2b9f1cc33bemr1177405ad.4.1777652273764;
        Fri, 01 May 2026 09:17:53 -0700 (PDT)
Received: from nova ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ee38sm25974855ad.16.2026.05.01.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:17:53 -0700 (PDT)
Date: Sat, 2 May 2026 00:17:50 +0800
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, david.laight.linux@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <afTSLgFwpYW1py36@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
 <20260429134226.49e95e9d@robin>
 <afS7UUAfzgiSzEHv@nova>
 <20260501111939.0536140a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111939.0536140a@gandalf.local.home>

On Fri, May 01, 2026 at 11:19:39AM -0400, Steven Rostedt wrote:
> On Fri, 1 May 2026 22:40:17 +0800
> Qian-Yu Lin <tiffany019230@gmail.com> wrote:
> 
> > I propose using a compound literal in v2, which eliminates the local
> > variable entirely and requires no extra include:
> > 
> > #define trace_printk(fmt, ...)                          \
> > do {                                                    \
> >     if (sizeof((char[])                             \
> >         {__stringify((__VA_ARGS__))}) > 3)      \
> >         do_trace_printk(fmt, ##__VA_ARGS__);    \
> >     else                                            \
> >         trace_puts(fmt);                        \
> > } while (0)
> > 
> > This fully eliminates the shadowing risk without any compile overhead.
> 
> Have you tested to make sure a string with no arguments still produces the
> trace_puts() and one that has arguments calls do_trace_printk()?
> 
> I'm fine with that one if it still works.
> 
> -- Steve

Yes, I verified it with the preprocessor output. I created a minimal
test file:

// kernel/trace/test_trace_printk.c
#include <linux/trace_printk.h>

void test(void) {
    trace_printk("no args\n");
    trace_printk("with arg %d\n", 42);
}

Then ran make kernel/trace/test_trace_printk.i.

The no-args case has sizeof((char[]){"()"}) which is 3, so 3 > 3 is
false and it falls through to trace_bputs/trace_puts.

The args case has sizeof((char[]){"(42)"}) which is 5, so 5 > 3 is
true and it goes to trace_bprintk/trace_printk with the argument
42 correctly passed through.

Qian-Yu
