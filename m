Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC555892
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315978; cv=none; b=Ny309Z9nfMAcqaQ0UKbTNyFCd4zvN5MuCJeqHAjCkKEmGbWy7ghsROgr17x3Y4s3x2XWjfCN39VqtONd5JmvELdbZgcgK0LSWEtFNxr9F5Zy4E7EbHURgeldm709XJAqkZh8TSLXQKBxr7OMrWq9nu4zN6JOByiagbh2qdMgCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315978; c=relaxed/simple;
	bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1yqjngLmUHRbwGRpTyZecmZv72tRU71JdIl7R99pC/pxzccYuOFbVopjRCx3i51sU9+mEgZqrgyr+lDSagZiw83RQpzdb10x8UP7hHwqU2hQsPBK/6yHRiiEXngsVmcZ6uE0RnsrlOzP6fvyVNdOXFBqHt/zaaJybd//kC9msY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KBsYLmWy; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KBsYLmWy"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso551707276.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724315975; x=1724920775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
        b=KBsYLmWyPPJjuWUaNw54kAt+goQW1oeOmfmo7eJetFqB4Lbg5noQpwtRtTfDtyMrvL
         WG4+2LHplXvfaZWLd1XmAtbvwE6GzFVZSahbi3DhEPv96w/NgnyocbRuNt6TKmORa/YJ
         NMXQZ55okoQVP3XIG/dybb/rvBS99BE2ChoqDK/LyoP+GeBtYk21oTJLB4Yl47yU8S52
         YeqJKj6t7GWRUDAQd0fMzmkd7QXWY+9Zqn2go6oDU5upNYUQxaeVHLVnlC8lSrJWCQMy
         3vOORWEC53FS/UVO/yURQ636UjzFsn4HtKDZsNI6WTXATbv38v1h1pj8J3x7smig4+ij
         qngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315975; x=1724920775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
        b=JvN0LUCCL47XemgTogBD7WFXL3Zwx/HSK5RVaIzAaeot6RaYP+kafqG/+HZ/m42YAi
         66FlHv6IRFg9eOAURm175R2RuOLj1i7Cmbbb4ICarKGgtu7fi/GGkX37iL6yYiVk5Ofz
         OrZw+h6Mo7K9gmWhZNoHiIyIEt2bzPvxGsLedUho6ufW46Uo2al2v0PnrvLWLBgTpupl
         rJvmhsNbeCEbRJcVohNDJy0nyKorFZCskJVDahbEraU48w9YiOOiLdM8sPeBcbQdSk7G
         CM7R9z3KEtx3CqXr/dMDTkQM/PGl0FbdKyKwEiEUDHw0GL2g9rQUM26x4hEczuyoyNbS
         SKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWT+POOEAmlTYqNQoFAD+s50jkPXxXupPA5bIy4Z1KM95R1Jr9tsh0apHWGAJ5cKfl7yOOB3+xe0QBv0Q4pcKZ6ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oPDOsmBZC01SD1JNs6k7fYl+K8KORsy5SgkuTuNWsx+0mjdP
	kUnZqIH7XDWdpQYcUOa279OR9mRIazOfgedgE3fMDD8ha3PUHt/0F40d9jNLw6TAgdbNZrdkwBu
	m4pqK/isPLzGE60Z3090RE9+P02h8ZR7sqUcrOA==
X-Google-Smtp-Source: AGHT+IHkFdJeVV+WqzmMGZrvSF/bGpFOy2vIodVP1TRyAky2+0nTxS+aXkYfl2LkMvbDx6kyhrF2nGcG5PB1NQylZEg=
X-Received: by 2002:a05:6902:2607:b0:e13:c8e7:5bcb with SMTP id
 3f1490d57ef6-e1665555b3emr6002370276.53.1724315974761; Thu, 22 Aug 2024
 01:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-1-1e5f4cb1f049@sifive.com> <877cckadci.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <877cckadci.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 22 Aug 2024 16:39:23 +0800
Message-ID: <CABgGipV9R_=Sy1uJ3YMXzm3S9W=yHWxRD1J=drFaw8-Jesym0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] riscv: ftrace: support fastcc in Clang for WITH_ARGS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Evgenii Shatokhin <e.shatokhin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Andy Chiu <andy.chiu@sifive.com> writes:
>
> > Some caller-saved registers which are not defined as function arguments
> > in the ABI can still be passed as arguments when the kernel is compiled
> > with Clang. As a result, we must save and restore those registers to
> > prevent ftrace from clobbering them.
> >
> > - [1]: https://reviews.llvm.org/D68559
> >
> > Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a=
9199c45b1@yadro.com/
> > Acked-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>
> Shouldn't this be a separate fix? Still reading the details, but it
> smells like something what should be disabled when building w/ LLVM, no?

Yes, this is a fix. My intention was indicating the dependency. So
people won't hit into trouble testing it. I can send it in a separate
series.

Thanks,
Andy
