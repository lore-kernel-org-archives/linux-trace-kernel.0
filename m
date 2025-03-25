Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53825F989
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925179; cv=none; b=nLwI11XGhcxcQ2xlx8GOROFrP4sExUdH6Fj3naR4HRtIq925R3G7TtVk906+oFq8FLr6h5Jn+f+mfvnGsaCkv6RpCUQlWK5hhWnq5J5aJBRCGMxIxx5VXy7kK/GRaUmXlXoMEuZIrmqgURBrJsj6rceJkGZYWAu74Sqwd9xvSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925179; c=relaxed/simple;
	bh=Ds55yK1VTXFGjbV6tDh+5MZJn0JPpo0MF9c64SRxK18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D33hmMV2NgOGq/o/XE8XH0M7Je5M5us9F/n5YBSvi7jq0RFbBRGDvAQ3CKTk9v5hzcXaW/YRe6+UMGmPyGrbU1/ko2gU4UGlmvNWj2LyF4OVtsUn896DBSZ6//JvqZOSFt0K+lEmX5eTylCJVfo9jWPJVC53bqe9VFqB7TxajBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=iEwx2LlM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iEwx2LlM"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549644ae382so7381700e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742925175; x=1743529975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5qGiZNJ+wqsnahxHBAHP6S4ULA+IXTS1S3S0dj1/UI=;
        b=iEwx2LlMFLLd10qD9s3uU0KKiNadpXrijnTVFRwiPb+pOwbmfqLwEm1YWUGLewQpo7
         RbwVMIDXWsuLT3Orw32Z4b+yTvpz3sF5pUdYddulJFfXyjKeF6yYM8s1Watt/c4b7Cwm
         BfadB1HfsAPEQ00CSsauCVqRZrHOyCcrDzfb4b4IrvrVvVwKgXw3VLVsqb+m0Y3MtN8s
         ZXmwoQ4ABuKEKgEC5+7GCrfGrhRim+mBzERMHlQQMnBdgwnbVv9+08AgRsAFDPd9rXMX
         oGb/y1r8ehjvvgwaxutNvdPqn3bHSmCTJHa5iJZchpRBA+XArGVOTqgmWYMQG1KMdZe5
         sz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925175; x=1743529975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5qGiZNJ+wqsnahxHBAHP6S4ULA+IXTS1S3S0dj1/UI=;
        b=vH2aLfVxK6gVtzmrGa6Sa/47rJ6jm2QLze2uvGdWd2PpGxQlr6FM0W83eoPSXaecsP
         ulbeTgARKQRjuuNCtm+NJdKmoinVBq1f++uOQdWHZ30pDZXtXK7c+EfZrYqQqwLmCtcN
         GppImnA/OvCysEaQP9mxUp0bcASEHIakGPf/tqUQ0fbwkquYYdeY3e5dSLDYuFLPP7EK
         yNOwvtd7wmmc8ZEAtFXwkLX2x81YlMryfGcuQ/XilHGRonXS0OHtJgRlmHocZkx0Z51J
         ePp4Ksze2qy2Bi3Idfc9eoQnZCVE0BiX0V6noOY1SGyO2IiD1km591usM/Prv/jJdgY9
         IN/Q==
X-Gm-Message-State: AOJu0YwP0CICZM0djnRq9yRiZJe3ydvccoec4lounL8oCZMo0B+Oq230
	FeCCbkLDKRxR/yFJFIM+5cmP/hqtJt8BAr/l/bYUCebeXHWWn/PvZ5KWuirCV2Fjr2tgqv+AFuj
	gsCNBmb9ooIGH/WrowAmU/hIf8B+uriHTAE6D
X-Gm-Gg: ASbGnct/HEJi/k78MiqKBKx0CqUuMdoOu/bvyNEn2V4v3a0KRnxMW0OKzTMyooRTiGa
	1k9bmMC4XOncdwBl97TwCAR6bny4IHSCaXqALTaui5KNfsHhIYQXlO9uyUxtkcYMJJX2v4eG88U
	f2PnZMS1WBLRWZu690K1vMoVhv
X-Google-Smtp-Source: AGHT+IHnxTxbard7L2E4A1MdUzDGceuvoAE7HUbGpyAmfSSSUGXzLtkWoBf8f5T9wGiBXQMqcI5MGiqz90cJkN9fKUc=
X-Received: by 2002:a05:6512:1105:b0:549:7145:5d28 with SMTP id
 2adb3069b0e04-54ad6492e6dmr4906249e87.25.1742925175150; Tue, 25 Mar 2025
 10:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home> <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
 <2025032424-custard-volley-bbb6@gregkh> <20250324150703.69665622@gandalf.local.home>
 <2025032548-happily-saxophone-4079@gregkh> <20250325081551.270947fe@gandalf.local.home>
In-Reply-To: <20250325081551.270947fe@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 25 Mar 2025 12:52:43 -0500
X-Gm-Features: AQ5f1JrnFyRlJUbdmoFqCd6MYOU8pYdmBXPs0mHb_03zHGqi6jH3ax6uP7lVdtg
Message-ID: <CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org
Cc: linux-trace-kernel@vger.kernel.org, Kevin Mitchell <kevmitch@arista.com>, 
	Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 05:15:10 -0700 (PDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> How important is it for you to build 64 bit kernels
> on 32 bit machines?

Yeah I don't disagree at all, it is a fairly idiosyncratic thing to
do. There are some historical and business justifications for still
building 32-bit in the first place, but until we deduplicate the
kernel build, we will continue to have this issue.

> One solution may be to simply disable
> mcount sorting at build time when it is detected that the host is 32 bit
> and the target is 64 bit.

We are currently doing this. I imagine the performance difference is
trivial but if we can sort at build time, we might as well. I have a
fairly simple alternate solution that isn't backporting all of those
patches. The core idea is to introduce another macro, parse_addr, that
is defined as

 # define parse_addr(buf) strtoull(buf, NULL, 16)

when SORTTABLE_64 is defined and

 # define parse_addr(buf) strtoul(buf, NULL, 16)

when it isn't. Seems like a fair thing to do considering unsigned long
long is guaranteed to be at least 64-bit and unsigned long is
guaranteed to be at least 32-bit. I can post the patch in a stable-
thread.

Sahil

On Tue, Mar 25, 2025 at 7:15=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Mar 2025 07:58:36 -0400
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > It's up to the maintainer of the subsytem as to what they wish to see
> > happen.  I will always defer to them as they are the ones that have to
> > deal with emails from users :)
>
> Thanks Greg for the reply.
>
> Now bringing the question to Sahil.
>
> This looks to be broken in 5.17 (when the mcount sorting was added). And
> you are now using 6.12. How important is it for you to build 64 bit kerne=
ls
> on 32 bit machines?
>
> Nobody noticed this for a long time. One solution may be to simply disabl=
e
> mcount sorting at build time when it is detected that the host is 32 bit
> and the target is 64 bit. I don't know how easy it is to detect that at
> build time, as it needs to unset a kernel CONFIG option. Perhaps Kconfig
> can detect that?
>
> -- Steve
