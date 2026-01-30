Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EE3161A5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769735617; cv=pass; b=cVvaBE0qzXg5Kitq5nJNgqBUPCjSus45Jdm1+AmyXKXAvU3VdAuHD9YdECLzlz0yYWOf5WFGR8Djf5Nxu3+6Zp+N/MKtqyxQbrH22wmalZqQjM9FYfE393a8PP1/U75nNGVpUZjSVfPd/J3VaofKDvfBfn5slMcj8Joewf3/eOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769735617; c=relaxed/simple;
	bh=b4NSn2vBOT3aP1aY/QE8sGCSpUU/VKrWs3PeH5KzW9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFfQ+U/L2zn9wT3V+kjE1zWLHnsyw0m4Xt0vL9/6E5bCrh69QguVStEp8JPkpG3zzriRqX27X7NCA57CLQF77lok2Wc8iXa8B6/dNvch9mSQVfWwt7spdh8jZfxZC3zdq0z+FYiSiSWCFAZ2YvXPEkdrwI9uzGSUoM3vrLzAUI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMdZvRAq; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMdZvRAq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c6727so303056366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 17:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769735613; cv=none;
        d=google.com; s=arc-20240605;
        b=UGXMhB5dCdWhF0E3wFjxNlEY2knVaSy7e4GrThbz9zU45IBKZNTe1totIOIpbKE9JF
         q3JsU7BtW7UkzHy6w7xPjCFcQjVIzfHBJKKqxnCYMKkhHGR3zQJVrn04Sk/VTiWmCY+i
         LDEfFUT3lhaNYnCxu8PhcWTPbOUeVaAe7mwcFUNI00RJPJY9SZtFB4/K2HPOOFVkUWzO
         y5MKmMura3h1+gxUtHuIQ6F/ZlrD3EZolK0yPkoJcwuBF3twLrmsN1A7/DfoJvEXC6FQ
         Wv71FlQzDYK4WgZ+I0sqGqKOy6dAaeclI0d0bBa4ehZiFc4fdQh3dZ3vpEHRBbm9zC9v
         rnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4NSn2vBOT3aP1aY/QE8sGCSpUU/VKrWs3PeH5KzW9k=;
        fh=JuNhN7U5FIw9pWuyzoKv5L+emmfUoGO9i9QqWesyyuA=;
        b=ccGDn/w0UZKpwoY2xWET5Tw1emDorBGLXWJdqDwuBNJvn/SCFe5H8ttdXM9x72Ryqr
         VvdcJgrBgBDhQTpIFteUMATfzsmRz4UwDM/ow8UUHqDy/4lw5vB0/1dD/81RHcF1OT4o
         9q56frSUuVb0/O4l8P33AY1TTsZYay5IQCCju+lWiKwGK8wrUbz5yXIsRxUeS5+SOZci
         aUZCw/E+/MO4VrpyI4iDNtU7TmsLrCSfs16U9vylrSLansbb+X0j6pNoqD8cF8Vgj6Aa
         8wrWr/6JOJDum4naOgncI3An7P30y7y2QT551qZxtUzT3A7pyeErhIMF8ulg/oxz1VkX
         Cnjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769735613; x=1770340413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4NSn2vBOT3aP1aY/QE8sGCSpUU/VKrWs3PeH5KzW9k=;
        b=ZMdZvRAq06ZoHvnIk/BIQMe3Fe5dAohUa75PpW8OOcC2ptRaCl3OjKEm0GnkPg/tpv
         /Yedr7HqpcdB/l1XEhnqOFrnDZoLknUwZczgLmSnBtzfXFKV77vwBLNFluktDZZhoNhy
         xFAs57Vd7FjuDK24sSQqIFRSa5BTL12iOnXeOmf8Z2WJqU2WpTijMPCStp2yB80X0C8y
         c7uStM+kvugcsG054Rv6DfHVqOjwHdK+WBA32S/QSp1RwS58H6akl+wzuQcE2Z9euWIg
         n/fYHxj7lOfLXxow38tp8bYM/EiUDTp9PrWac+lPQoDsaD7HXRVlthnJOF6jXWbE24+T
         WeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769735613; x=1770340413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4NSn2vBOT3aP1aY/QE8sGCSpUU/VKrWs3PeH5KzW9k=;
        b=jIM3V+WpCjmVEiqdDCukEpQMzX64+8oXT8NmmjMhSJCi3hisEIOQ+Bi+5VUOlZBo5O
         ytxGYF0t2x/7F6ijpde9Gv6nivMTprH2BHbvS7E7/iYNP8j9f1bV7FAx/bE+fxNzkycI
         F3m/KVrphPNsxQDrC+qU/ytHGqQ4gZejQ70rVyCjhCofHpVrTDRaQgNoK/hsTD7nwyw4
         aAvGeKdP7w5/LM4ad9dptjWaqKyd/buxGLu4GGzG7PonpgHI99PKMgpujLwKgzMbOwSJ
         nfXd54w+LtgEOvVV1hexqN8kt8nhT3IvW81wTJfETguulDIGmaPBff7DiTajeo6oAFEP
         FH3g==
X-Forwarded-Encrypted: i=1; AJvYcCVE79sxgU3QoQxEFN7xGAPpaDPhLRFHCzLJv/BtGvFLSLwqRg6tACRyRiiK19ayfBa3mc7C+BY6Q2A92T4Qz+RCFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpuPwa/R+3kftcn3VnaqMz5CXdDUYEf8mqpLaLfhEY4qor04D
	twMgqQsP3USg1UbRhjwdBpHBkRSoCY7T1QLzuOcnR2xh9TNtkdXiUnGQm9eL2zJh2aGqkW8XohV
	qLF2lpzIab+MXLHLvwuYAqJgnVW7XuCk=
X-Gm-Gg: AZuq6aIu40An9I0YCYYVxs0MPARplk9p0dagQsRQuPQa7jH55eddXXPqyTOyr12OMTH
	ZEMn+pl4+hgd6v0hl8pTmSB3UHvmuPIP/dQh11b64xIaTiGdKOAh9ilS0Drl8b54VTE8vGAzpUu
	OKFkEqhadyT/+qVtf7DYo+Kg/n4mJrXIQFNqXkaSHvs3aBTFnlSWk2VgzgxYcVUQHYmSsEJnx+8
	kXVDbMezUh+LUhew3OBmnAU+71oxpj8fjrWCiJI6VaeglpQM41YOLic4rgEnpq0bsZzfbfsvOGc
	AIwrPdk=
X-Received: by 2002:a17:907:3d87:b0:b79:eba9:83b4 with SMTP id
 a640c23a62f3a-b8dff1f37bdmr66386566b.6.1769735612785; Thu, 29 Jan 2026
 17:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112021601.1300479-1-dolinux.peng@gmail.com> <20260123121858.0f7c3e98@gandalf.local.home>
In-Reply-To: <20260123121858.0f7c3e98@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 30 Jan 2026 09:13:21 +0800
X-Gm-Features: AZwV_QjNrYoJpHC_wtNfHgrvcDbGpQTULjpBKhHvI2LNtnopCDIJTBvrG8AM8Qs
Message-ID: <CAErzpmtHCE=o0Gv3iTMaShtvNep0NTKLenE0nvWv+sz6s=NWFQ@mail.gmail.com>
Subject: Re: [PATCH v2] function_graph: Fix args pointer mismatch in print_graph_retval()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 1:18=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 12 Jan 2026 10:16:01 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > When funcgraph-args and funcgraph-retaddr are both enabled, many kernel
> > functions display invalid parameters in trace logs[1].
> >
> > The issue occurs because print_graph_retval() passes a mismatched args
> > pointer to print_function_args(). Fix this by retrieving the correct
> > args pointer using the FGRAPH_ENTRY_ARGS() macro.
> >
> > [1] https://gitee.com/pengdonglin137/funcgraph_visualization/raw/master=
/samples/error_args.png
>
> Please do not provide links to images. This stays in the git logs for the
> lifetime of the Linux kernel. Images like this will likely not live as lo=
ng
> and the link becomes wasted space in the git history.

Thanks for pointing this out.

>
> Either do a cut and paste of the bad output, or don't include it at all.

Thanks.

>
> -- Steve
>
>
> > Fixes: f83ac7544fbf ("function_graph: Enable funcgraph-args and funcgra=
ph-retaddr to work simultaneously")
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
