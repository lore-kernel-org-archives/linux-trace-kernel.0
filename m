Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A14E8DF2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452279; cv=pass; b=Rp0Z8L58046ZASUVe9Rr1tcbkxPK03zpvZ+y1oSf/xJzUuZrsKV9mOukZ3nNYa1gl0DeZ0AdIIfy2a80r3ITu5ajkC8GM3aJOYE0Bpgx25Af2HrXW/iHnDJeM73C8OKzETUVhBg/+TH3AY6P7VqJ82IIP0zp9yIba0G+//ZDXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452279; c=relaxed/simple;
	bh=UiSU5I5JUmLO87TdZDzVLLhzpKhCRaf7JoRdchd2ySc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKrEHBiDeF/r5JTrRIFNwytxFfhzNIbLJb9PjKkxgy/V4o4GcsJmWMo2JCQ5snp/bjOrnIHroqVFB/B83YMFIFeJcF6k+Soj4UvJlNOlfZ/8NE5CPtjzvBysg5JzRb6JAXhOJd/g1xgJ1rcf8UIqASwb86Fn3aopApiC1RpO9p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHtdQoBL; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHtdQoBL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so96844a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 09:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788452277; cv=none;
        d=google.com; s=arc-20260327;
        b=n96hrMMhUBN40ZPITV1AVlHhn70ddxpMCc/Uas7i2dcjlQauFj9xk1qVgM5yY8uODM
         /HwfjLOl7G84UEtFtiFw38SewD1BkbHmaWNuQ3PXPbPiSJEFRBaW+aMrdwCRFv0OfbRN
         3nf7gXSBjgpFrnaJlkhr7kX51kso4827idRK+gVdHN67wK8YqoQATCBuHRal+jAmjSJ8
         LmDvOOgefyLtiTpGZ+ZS8nNGTJr+Vmr1UJrFQKunNb9+MPzlfTa9rIdJBnAkzWhFgLjw
         mD1GZ7MSpjmMT9iC1mVIUXJ1dyK1zL8B1JGAexUYRh76r7Cc/xz69jR5QJmrPwytZ/qi
         vvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JMQg6yMd/MUyHk+pK+efm+9Svxwg7umvKha59T7EEwQ=;
        fh=uCRk1cjdrrGcnej9l1N5yIzns2icHW9eXPUbNcOao3U=;
        b=FYNb12DzTiB70IyZySWxw/RJtkZOflraVyQDY6yLPaXlPhjU3NEObiZy5aauGSLb0/
         byDQ+PA9CCcaZVfKL4/gECvUET5AP+3vyQYhv8yrqiBRvT06eKOjDy2pWnXa+xLPwKVE
         /7G82NKGL3zOnYm3jVJKy4DfrFCSJh35gBmHiI0C+yKRVHetjPXhR0Ec7NeoVl0Ihigt
         lxGOvkqZX0gF1X68x7XU1BKEMNL8q1b+M2brRsIMfpIImb1RoDEeL8SnQQAqCNSSqvZ2
         jPPJzkkAJCnGlIjBEN7t19W4I8AepNqzbRo76iWhKXhcHZ1w+q5ZwtNBvrqV1Khr250O
         cT1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452277; x=1789057077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JMQg6yMd/MUyHk+pK+efm+9Svxwg7umvKha59T7EEwQ=;
        b=hHtdQoBL/5ZRhiiVCvVooRjhEfRUUKvDCk0DR1ecVily/FYx5Na0zYjMTKZoxCU08J
         QkSHg2aB3AHOfSiPGA6auZprijILQabdtz2MnRAraPA2UCck34/SoGZMaADJ4Q1EmraS
         U/uGA7WTckFzfrOLAb8Cqpljd7rBAk2LP0GKIuzTr9jKPnIOhT+LkHLEG4YzIBGhRQLf
         378rZ+jSC5rNJ9W5hQEEyU3wdQGhsjCbQ0aNYGAbb89eok6b2SGcWhA4KfS2R/l+tLaZ
         7Is8jbeCcn8ml97Xi7okYEpSAhMTDEUxLzyQpM6igww81bdD0DJsxfQOzPjzn884OQdG
         LTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452277; x=1789057077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMQg6yMd/MUyHk+pK+efm+9Svxwg7umvKha59T7EEwQ=;
        b=fSjH7ca9SJYEA/NoZkT6TZ2DvvKyy+ZscqWBtNiRdl8CbvoPj+CZZ4xdnZyGRDtecy
         U/xYH5hunN9ppVg8DFGx3BOwKyMUjB1UQgqJoHnbGE/DVIB3MGFdK28phqg95wOZI4w3
         lW+cU0J4MfDB/Xu0/powcpP7BfInyJFP5IwvIYg940XoIv6Jz0by0jFD3NB74d9PkH6K
         R+ZMI7SXHzfNHmHJmFhU3NeMWSMAph4FZoKpI0ht/D7toXEs0qdV649A3OpGq67U4npT
         Uj1udcn0RrpwU7UGpMIm3R8t1tMNj//RJ318SeBzW4FY0M4tG79O0TjHO96YQ+tgXjh3
         mepg==
X-Forwarded-Encrypted: i=1; AKwUvBy4Pzx4vdrizLI2mKhkD0ilBMV6YRI52K6lcscwAhlX/PM9dEtSykd8G6gJrDCAhiSE/RZcbI30g5kgbfC/rlqYamY=@vger.kernel.org
X-Gm-Message-State: AFuF++k1PAUKDmyIMd35fK49u6JzTCapOpCxigWOwaWAqoZyrgYoc5nY
	MBdWswsMvvSTOZBUTbmXYcFlznIXkMVfx8EheubLMaLcuCUC1zzKSspSJaK7jYeeB602ejNIYg+
	sHYfNfhkRuXTuNzS4NBXdlbOEkUaYqhE=
X-Gm-Gg: AYBFou2s/mhgEl6P4RgzzPjRaaEwH3/caVHEkWww+DDlI9+qLGuzEoitbrJ35ba0Op3
	OfqyDP5xY59ZqxYnshWDHTdN1/pfGaYdEhygAOuXCV4cT3f2xStePrzDTsroxnja5sIrKHSu2Js
	P3ILGUarGr88+wtKGkRMPVmJK4XSqgP1kAQA0idopaXeypBb4mT8hVjZVoGJy8s9F0i7PC9LNWG
	LDfQO5EUGJ90tUBmqQK4aHumT8Dsz5fs0aFuwg6ykUAxLBslSyZG+ehRDqE84zSnXyNcXYthWBg
	kqqU+auXzpew1hmpfLq0ojrTJLS+3YpwKSAZllPFJ6o1gQ==
X-Received: by 2002:a17:90b:2f0b:b0:398:9c00:29ed with SMTP id
 98e67ed59e1d1-39aee1f5fc2mr21806714a91.21.1788452276498; Thu, 03 Sep 2026
 09:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
 <20260901135715.4812fde9@gandalf.local.home> <f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
 <20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
In-Reply-To: <20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 4 Sep 2026 00:17:30 +0800
X-Gm-Features: AcwNN1W6aLBj3SzjJ2sxEu1gH5s3mgGPWuUq6oQ8j1K9R96JYww76XDPhFhrJRs
Message-ID: <CAErzpmvoN5viidq1kHyYkP8cAfd4C4mAJg3R_SV0pB1O11euYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, dolinux.peng@gmai.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:55=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 2 Sep 2026 11:25:29 +0800
> Peng Donglin <dolinux.peng@gmail.com> wrote:
>
> > >>    - Do not print a return value for functions with a void return ty=
pe.
> > >>    - Trim integer, enum, struct, and union values to the available r=
eturn
> > >>      value width when the BTF type provides suitable size informatio=
n.
> > >>    - Format integer, enum, and boolean values according to their BTF
> > >>      encoding.
> > >>    - Mark values as "(trunc)" when the return type is wider than the
> > >>      value captured by the function graph tracer.
> > >
> > > Hmm, I really don't like the "(trunc)" If it's the real return type, =
then
> > > it should just print what the real size is. No need to state it was t=
runcated.
> >
> > Thanks, I agree. We can remove the "(trunc)" suffix and print the actua=
l
> > type information instead, for example:
> >
> >      ret=3D0x5[struct:0x10]
> >
> > This would indicate that the return type is a struct with a size of 0x1=
0
> > bytes.
>
> Hmm, shouldn't both the actually applied size and the true size be displa=
yed?
> e.g.
>
> ret=3D0x5 (in 8 bytes, true size: 16 bytes)

Thanks, this is a good suggestion. To keep the trace concise, would this wo=
rk?

  ret=3D0x5 (8/16B)

The suffix shows captured size and true BTF size, only when they differ.
WDYT?

>
> Thank you,
>
> >
> > Would this be acceptable?
> >
> > >
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
