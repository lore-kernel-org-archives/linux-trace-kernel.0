Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCB3B4EA2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718328; cv=pass; b=rC1R5W5EvLb+P/4tjjDc4VPy9AzTGLTjeH4UvyHQEjt0IBZJXNUJaBB1l/RRwbvcNyRL87NobWmNOkj0I4Fj3VfIgkjrw4WWTJeybHg9/PeB6i5/m2gvkNvNrT6MJ47JJNaB/XVETeVd+6xuppewQNpWv3augsmT6wvi/ANW8l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718328; c=relaxed/simple;
	bh=GiCC4yWZSZ7UIG2TMvBSXnbbYHY4f/eC33dIeVrWUvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcmZaCqQmJEWdA5WRnYxU0cMw2WfQVWc6of+fTOelnE3GW9Xq38jd02ZDjSqLF/b2iceEjWKna7mIjOqXvpgzXgsuOMetbK4LIv1un2mUaustpVGbkzPjMORmkA5tP9QXwhWrlh/C/3LrUEaNE6DVsU8mmsvq6rMdoXAAqycljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqrQdBH8; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqrQdBH8"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1204847a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 14:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718326; cv=none;
        d=google.com; s=arc-20260327;
        b=VXcmdj3WeFErYc4FO93uYfpoZ8FJyb0Lln7o1e+PbwaqT1QoM/cG01qYK9T40NF43A
         rl7RlKEm/RP7iweXKs5U97xp/FGyZ5EggtHo6AcViADHx/p6YPaQuuHOwPRS3JrpyN0z
         HhR+Qhsa3pX43rtIVfWfFLIYNgwKq4TeR18SbGm7VGhBqJEURL5bAji6qoD2SUnCRAca
         e4TUDRKi5GKgVYoEpwkxLWLX1JEVEOvvsBFWCF2VccLJhCOABFAJBBjN7kso92jAo7xW
         JXDJyFfJfHHFz5ri7y/eJhbCGFUNhYuyEdpSB1lNAZD+TnMdwCCA1EV2KvAjsaXTzYQb
         E4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        fh=j77c8cTmlSL8cvAde0M4C7uceddKbg1pYosH/oe0Kcs=;
        b=EdN+CTUH0y467PNwzG8Udzv5TMW4BW12x7IFkygrEGbRBdGNk1RBN6gJe5+gsWdjeg
         nrQ8KqhAr1UnxFNF5lrcHSFoLP67yGfvVvXiVBHzuD67PoogJ+1SRgyEposR6lxllfmh
         R8GRlwmpZkEWVcb5FSZCJV/gSQiP3d5r5+1pDS8j09iI8NVDF9P8GqhOAT3xNr3znfSF
         JYixZdZe6CLu/AOtMX/Sw8SQf0T2G1GH3it8+A7ltBRDKwtNV/5Kcf8nkJIlRxILgZwf
         BmmlWFpEBKPCebnK7i3gT0iz+sUcNikEGWFRQEuyYJyf1y3a0FCaqFZRw98iwECx3U9Y
         vvzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718326; x=1784323126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        b=mqrQdBH89c/VnqkFLjDDp+hjeSfDbbRndG8GXS8yivRqx2c+b0P56ctLheAWefET2I
         hU9Q/hv8dFm99Uhu8ILnxyJS/f9VzS/Mm63U/5MW/xCqmVUxlqhXCCsVKIzY1K+1q23l
         5Y0+RsbwgNSLkyl3wcqXEuTz/5FpTrRyjUGXBEyfT3dYGDvQ9WLyYDeq/jdT3QWAHhpi
         AdH9lBbSeRMgSaTc3NjyjYrX2VcSrcMFT5g709waVgmT36h5dIA+C+piW8ojtsDjEsar
         ARsJZut2unklXGixslG3Q/Lqu2JshXqjLQzTOoVC9h+S2I/HhnVLU174y/wArpBu94YO
         Zb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718326; x=1784323126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgJ1gfbiLnrPYiVKgfk5rYd29jlG0/PTDNNdbkrgtPk=;
        b=bipXlngqnUiorw8ueQ+rdRzwzqyeYanEGpewSG3gfzNiO96ZypXB4vHxEj+oM9n9iZ
         +dw3/2zxdJWvszyqlRzl4CeDz79UFGCYpQh8okry/OkDUsk29+BmeP0wKg9zT4J2yWIv
         dxplI+KeFZF6EEoFuCVxGQ85IgtwnwAcHrkpdH63ddzUERPtiT4HIBabYN0wh06TLVTr
         fAQlyclFBXfpbEyzB4CPYUJ+cSlimiBLBj/P91x3WwoeDNqiY6pNaptNsl8ukzaDHRYb
         6c1IGhVKpDcUdHzkWDz5i4XXX2621TKHvJXD0FQl7dIwN9AcOvBO2JV1UTarvMC4Z464
         D2lQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDY9daaUxaIVGu7RU4/C2SwI/iZUkLoPr61yA83ttFp9TfNPvOLPvxB6Xga9JPZuK9ovMJl8a9p67JRUlVAEidq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBFHDLbXrca/R8skv0bnPZhyCu37eem1g/SZjmYiCjest9wGT
	i6BbFx2JL2kyQ8gSNtiQjyC2NbMNmCI2ZTrYFjstdHPi6DKqxZxGWGce7PruBJIEiz4SiBSYUJt
	wj05/aJFmJGM0dHPIngB83xy7eqSrcVo=
X-Gm-Gg: AfdE7clvb2wCcMIcXk/GjZIGsRASNYr+NsUbI3c1bbQS8ck7SPDujDEItYjKRk4gUf9
	nkVsIxtLkTnpHDjx3icwz78pwrna2HDgvk7EPWseKNonhzfH5iaccg1mVfwedy5M7Fn9WA+4ulc
	RkXrknGOAfWYRI2IDx5xGQyvQlj69ZoGxoCWBvJc2lyvIA8z4SaHQuZUy8SxY/eevAjMVcwQWlR
	yR345MdqsKedg3owoqDkbbT2B90dXBypTW/IRU9M5DrH0WuYprHocryhP0xPYSxWM+izI+J/li8
	N4py660oOm2eMfaDjcKlZvtJ6JTmUmG+fZ/Rgu73PH6+p9hkFG1mxg==
X-Received: by 2002:a05:6a21:9187:b0:3bf:a698:ce40 with SMTP id
 adf61e73a8af0-3c1108c1b22mr596690637.58.1783718326320; Fri, 10 Jul 2026
 14:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com> <20260707120046.31573548@gandalf.local.home>
In-Reply-To: <20260707120046.31573548@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:18:32 -0700
X-Gm-Features: AVVi8CfrRzjVYUtzteFA-fYu5IC19YXoUvmg6lzUqxBqnajl5GV1bbXCnexW1M0
Message-ID: <CAEf4BzYDZKiRg689VZL==ZNetTgdC2a5-6DHrhU7f4afXKxE2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 9:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 18 May 2026 08:23:14 -0700
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> > BPF and other consumers that want to attach to or decode a generic
> > tracepoint need three pieces of BTF information for it:
> >
> >   - the BTF of the object that owns the tracepoint's types
> >   - the FUNC_PROTO describing the tracepoint arguments (with names),
> >     consumed by raw_tp / tp_btf BPF programs
> >   - the STRUCT id of trace_event_raw_<call>, the ring-buffer record
> >     consumed by classic BPF_PROG_TYPE_TRACEPOINT programs
> >
> > Today none of this is easily discoverable from userspace. The kernel
> > knows the ids - resolve_btfids fills them in at link time - but
> > consumers have to search them by the naming convention
> > ("__bpf_trace_<name>", "trace_event_raw_<name>"), walking BTF for
> > every tracepoint.
>
> I'll pull this in even though it adds 100K to the kernel:

Great news, thank you, Steven!

>
>    text    data     bss     dec     hex filename
> 40506047        15709518        16661184        72876749        45802cd /=
tmp/vmlinux.new
> 40499064        15615294        16661184        72775542        4567776 /=
tmp/vmlinux.old
>
> -- Steve
