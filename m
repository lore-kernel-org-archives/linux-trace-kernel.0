Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FD25A642
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912043; cv=none; b=ZZClESGx7Y85iRjBdTS7ki+UB9wQzVOik7KNVHlViU04P4LhJNivYJ9AxFU0sv5hpJFLv/K8aTkvodAlicbdY2x1cRWO80zbirg8svbnZFAvFoBGWAXZ35gv5FC6q/b7uKLddP6T1XSgZxGaAyKJbR4gXyXzg+ZfXXSUajc/gHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912043; c=relaxed/simple;
	bh=PeleRCI1tFNNxaPIuI0GF858veDooX/xdZs9lZH6SL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f00WpVGET/cVS1/S8UMySwzCMOq7oN/0M77WYbnZT6BFY4F5cybzhvlW1lzpG5SqbEwO7Mr0NtVrAFOov8QrLKHwqMR9sCrrrR8uWfgS045UdKpLgUCE2+JXHv7v7m0cSuanpGLJmubV71RQuvNwHAePBk2vaSn+xc3JrsrVJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3JSQKT9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3JSQKT9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b714b1290aeso59379366b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762912040; x=1763516840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEHtgraZ/fUKbUQZ9mWiNPDz97IMk8fjQF9QtcfzT2E=;
        b=Y3JSQKT9abdGAxImroDAwFpogGiJAkJhtLtKZzBUwJsdY/w5pTK6v4jg+gfdgfDdF1
         IypTA68PE4ZvpGnOHzQ0LJcmStDL2cvuov6XD7O54+lRS5/uBcIO5WLPm6Z/xopXJO6T
         CpJGuvPFvrfEShNMNFVUjxq5oOhWQGRcuAwVa8rV6XOky3WwJJzAb+ZmzGBAoHeA2iy9
         pDfBG+cS3Ue9YB0ejA83NWHrqomEpThb3N51aF7jfg8QILua2hSSye5gAnRcISJBvPQS
         aSBe+1oTwsx89gzLK4najtHsmPpy4xJ4hVZC2JBcgLnd+g3rqZG/ZKEN7TVAl27jhbE8
         bcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762912040; x=1763516840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEHtgraZ/fUKbUQZ9mWiNPDz97IMk8fjQF9QtcfzT2E=;
        b=Ftlg+84aRM40AuZEXQc+JCPO17YrgtuVydkPiJ0qvlTtO2t6VnnNJumoRFP/G9AJvC
         iLW9aERn6Nz26pAcGRd7036SIELKeJjbIwEBvYYW0YnN6tI3DN9NNVmdFSXKP+/Qf6xx
         teg4y8p/ufmgnF5DTGAiRo6q6on5ec8GjgiI3U8a6tLUUb1K3OCrJrTpdYDuVTiYUf19
         10m/khJAsYCYIQNufX9v0GxtAGHQFF/OsbtpsU0fm/XkNFmyf/ObEbkg7KkhhTLE2DGP
         zNG1DbbB7BEJ7LO+rVWIBOjlX8C5i6cngVHPv4pT5J12BuJLIKZFMHfKh57UQsPiIn4q
         2uyg==
X-Gm-Message-State: AOJu0YzwZSd+pZvFdZ/1oUt5FUToQ8lRO38vEfcTJ0tQv75+mzSN8gOS
	bHUZh+FzZFlAPkwIQoMLXCha9i2ekLNaty0qzVHpes6amPPc5g39XJRZhyrjL0zoHXu9OruYNsY
	wAHNpb85IzrT3MNWpJ11gQm9EJ55nPWk=
X-Gm-Gg: ASbGncsisVLzcrHN87TvHD6UgymyHebNv5w4YAXD9zE/IW0CrtqWMCrdRK3xQ0yBXgG
	KAkNdIh3yZcr7T8pQ+Ab5RgybmNe8q/pHosZhjFA6VD+KqPxZRnrtIfGe9MStlMziLbmQAgPqMK
	OF2UmljWi3/QWCqI5pbr4ck+zIOf6kJmnNzrZyU4QmnNoG8swFHPzjn/ERsI50FRnZlpxkg9c/F
	2ODD2BGscrURlqOwDSbAcm0J3DF7LKoypYz61dUF60lhWnWcRcUGXyn5qSaxw==
X-Google-Smtp-Source: AGHT+IEbQYPQDxMuWZR/m6mBn2rA3S8EO24KpUvcKbJi7yEkJIuo7KqOEOFCzz3oidVBkuth9XGIBkvwDMcWa6zpj0c=
X-Received: by 2002:a17:907:2d06:b0:b72:a40e:d10 with SMTP id
 a640c23a62f3a-b7331a6b9e5mr122140566b.40.1762912039696; Tue, 11 Nov 2025
 17:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111135432.2143993-1-dolinux.peng@gmail.com> <20251111183703.0045ca23@gandalf.local.home>
In-Reply-To: <20251111183703.0045ca23@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 09:47:08 +0800
X-Gm-Features: AWmQ_bltpbEdw1Y8807ORXe8b9Zx-V5004sVJJmbh_N3pO_4_8oZMUaVYo7n1cw
Message-ID: <CAErzpmtdJP8MK9kmoi5BSzpUuJzsZ3+AxWV-jKGC8gPxbMTd4w@mail.gmail.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Nov 2025 21:54:32 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > +     /* Store the retaddr in args[0] */
> > +     if (type =3D=3D TRACE_GRAPH_RETADDR_ENT)
> > +             entry->args[i++] =3D retaddr;
> > +
> >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > -     if (fregs) {
> > -             for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > -                     entry->args[i] =3D ftrace_regs_get_argument(fregs=
, i);
> > +     if (store_args) {
> > +             while (i < nr_args) {
>
> Nit, this could stay as a for loop. You just don't initialize the 'i':

Thanks, I will fix it in v3.

>
>                 for (; i < nr_args; i++) {
>
> > +                     entry->args[i] =3D ftrace_regs_get_argument(fregs=
,
> > +                                             i - (type =3D=3D TRACE_GR=
APH_RETADDR_ENT ? 1 : 0));
> > +                     i++;
>
> Then you don't need the "i++" here.
>
> -- Steve
>
> > +             }
> >       }
