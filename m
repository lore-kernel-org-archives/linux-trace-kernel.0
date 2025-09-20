Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96F27FB25
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758406672; cv=none; b=QDTAuVZNx4iKhKA8AciWfhO8ys/IakJmcly6pLF2PHJfC18EPbkg481GneCN771pttDtTHrIa+8jjb7p9YyYIozQUbHryvdbDA6c0auwWMwOyzLDMFJHqVJVSEt8ZbeNAtpA+IPOASIqE+6KSDI2jQU+Hy+0sjzKN4C3jntIstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758406672; c=relaxed/simple;
	bh=96dxx70d/BFqImcMeVoXOM+8YDlRuIcpQzt1VmBfil0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZQirGpnRXGAUBZwEpD5+1eE5o41iiUlcqY9CAL6YClE5CFvvOthtdgYVORyQE4mABwL47Asq9ZRyPuW4aU9rEopKW0zunzbJaSaCy88ne7uFU9M0Ge+XJvZ3zXKgxNgXdes7b2jW11h26PjVgvFTSnWePpkX77/uvDyjIx3ePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsKS8oV0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsKS8oV0"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so458888766b.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758406669; x=1759011469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HgtdynmY0igjvNZnpu91IhlMXMmcHk6gD8131LsDf8=;
        b=TsKS8oV0Ec0JLnc+mKCN31OZwyskRpLNrWsMigl1/dOchWeXQssOd/lTV4qyybo6s1
         JsqpSWMGeSJcsO+VYB9ZWS7kuT7UpSLnyCJEwMDbp8gjgvmq8Xq/9EM0ZtS7pbpT/4Sp
         AFSmjvITqXq803uTKWjAMela4Vpt8rWFBSLfEMmIG+7Cm4lx5QW7g6j5Rxb+Vi+bKbqJ
         bnPWZpRnR6OjzM6SkJ1VnYTpVwstiNe+G7vR2cii07FYmvv7IPN+FAl138+pLVXb1u6T
         OyKkY5uGxnElZy6Ht6eBZOCYr5m8bIHai4bXZq1WcdlFkT81xM8nWAIXwOR3SMua7NHo
         zZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758406669; x=1759011469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HgtdynmY0igjvNZnpu91IhlMXMmcHk6gD8131LsDf8=;
        b=NHKgLUP4HTKPeZ5o0haHU3RT5k8IR0emCHl7qduY9pBh8eyR+uNZ3B4asnx3+i4cuW
         Hq0FYHW0mUcNWuem7S3BIRrTH8KztNwX0hiNQNRajBOio/cJq2BInC62UBBiB1+h0yEc
         TEiQ9+AKGC0Y7SPBaf6HoELdBjz1lh2FbvB9vPmz/j+Xn0zjzwS+gV1H+n6qqEFKmAy9
         23r4pvmnX9lozK7+7SQhmhEB9bermGoM66dmZxp01zxCpRmeOnRdNF9C4Iw6NYkqFpKP
         eWZafhIpBSjqA16PDChcg9QW53y+UvDj4CAtEP4iCb/BvDv+NJyILamjSyAKzHLLu54K
         LEgg==
X-Forwarded-Encrypted: i=1; AJvYcCUosvl8XVkuRFNXNQz1HSKAFLuLHTb7gZ+y8HktNLDkBaYVE85EJbZiHOi3SZ+9bjyv+YvUBrOh6Gn9U2FG1PcNsI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrhKY8wsPWs7uFhF9Hjtxqyj/IdqMUeee5EJdxJhPjmFfYP+q
	c/W3InKRL5qaxVW1wom1ana8zt+hsX41FoQF6MVCNo26fHnbZaJwZx0V
X-Gm-Gg: ASbGncundaPGbblwquxpL6dAc25fgMaWHbZoYg4E3mV/SNtg3JrrkksmFZ3Tds0jtJZ
	M03ok0nGRK1DiL/bxu9pIoS2Lxh6u1NxQsFzN/WRZy+lRnpj4VyBdLElN9ztRw4dY9olUu4NKuF
	cOTAvppLK9SBpTYQrzGiNKnVUHNLSfpOjBjbc+nDZGlNfk2VL5dQtbuef23zt3RA8168PwOo85k
	E1OS7+TGmafHKI9duR2+e+NfU0SS1tCpikyfmeIMuWPom7B/rPy0HslpRElxQI8a3FWzDDcAXSY
	arOx7syU9YbZihFe2pof3Y5pkUIMRqDTV9hynxQ/gpU0U8kmY2boJS7/QrEcWf75fZaIS/hSeza
	egcU1Q/z5jflrVu44So8J1vBtlu+exVz4lBFCXIiCEjk=
X-Google-Smtp-Source: AGHT+IHuYXbv1MwgeFhgGHEnoMk2vC63tOuKqEj+eah5xHgaTZ82uYXktvX8jVWZFLF7LGFrAO/urA==
X-Received: by 2002:a17:907:7245:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b24ef58d811mr815980866b.17.1758406668905;
        Sat, 20 Sep 2025 15:17:48 -0700 (PDT)
Received: from krava (37-188-197-68.red.o2.cz. [37.188.197.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2864cd8376sm218759666b.80.2025.09.20.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:17:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 21 Sep 2025 00:17:42 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Will Deacon <will@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-ID: <aM8oBvEJoR56w2Dk@krava>
References: <20250919071902.554223-1-yangfeng59949@163.com>
 <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>

On Fri, Sep 19, 2025 at 07:56:20PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> >
> > For example:
> > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > index 9e1ca8e34913..844fa88cdc4c 100644
> > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> >  __u64 kretprobe_test7_result = 0;
> >  __u64 kretprobe_test8_result = 0;
> >
> > +typedef __u64 stack_trace_t[2];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +       __uint(max_entries, 1024);
> > +       __type(key, __u32);
> > +       __type(value, stack_trace_t);
> > +} stacks SEC(".maps");
> > +
> >  static void kprobe_multi_check(void *ctx, bool is_return)
> >  {
> >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> >  SEC("kprobe.multi")
> >  int test_kprobe_manual(struct pt_regs *ctx)
> >  {
> > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> 
> ftrace_partial_regs() supposed to work on x86 and arm64,
> but since multi-kprobe is the only user...
> I suspect the arm64 implementation wasn't really tested.
> Or maybe there is some other issue.
> 
> Masami, Jiri,
> thoughts?

hi,
I did quick test for kprobe multi and I can reproduce the issue
on arm64 with ci:
  https://github.com/kernel-patches/bpf/pull/9809

but can't really tell what's missing on arm side.. cc-ing Will

thanks,
jirka
