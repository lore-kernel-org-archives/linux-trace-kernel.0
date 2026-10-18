Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394047208A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322804; cv=pass; b=b77Rlg5jPV9N43yfiKEwN3YXTHgEzORUdl9r6YF1iIPOWKGM7Z1fbUUEjfJj1Aqk8o6NF1VQ3HMYARCFUqB8zUrKmHnv1kz9b/+Qxb7JI6qY6VwUTf80Khl4mi6kOwQ9zJ0lcVZvPNk1EyiS/9hSv73mOwU3GA7CwWiAGi2fGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322804; c=relaxed/simple;
	bh=wuAeFFNq2fdrOzbi1+GSIoTO7DxjWt2Y01i92TMnYGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHkDsgMxniael4GD2prjuajWNUzoqzysn2djDEzvzEB7uXOtVV77zqrqe3/MU8YLhG8jRTlW5tAyEhAMvQ9oD/FVGm9Hhj8DWWDzpVQFOXnk0gbn0UpSZEoHCcSFHK6nkSKpoOCJipg7DjE/m06SWn5afxW0l3uBWzzI30YUks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFxlHW3T; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFxlHW3T"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ac9d666d4eso8327357b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 04:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792322802; cv=none;
        d=google.com; s=arc-20260327;
        b=Hh/f5pNqnz0dfHxRvLim5VYKXBBBpDY+TgevSFLrwdDxfoUmxAj4sXpNgxkvYYr+Ow
         9wuZKbGF6JcwY2yLqucAtN5G2gBlbVAMprgfgkfpfZ0VeuwYrMWkWmPaRf1151iCDItx
         Cgfy36OxX8T19mcCVhmLXZeT+EMUwEZo43axvKtSIfYiPkcP4urcT6M2/mi04W+UeQiW
         v7YBzMebtJ36fpfMx+o2u+XYxDqYDKvugYBy/oDI8RTBpyES6BbKC0LwAYd9PoCbxEzb
         AfM7h4VF7SQmbb92TMcnCkSMmUb1wEGuiTtaW2R0vQor6rZ/XdB+M1CAaF3DWIgUjKbM
         k4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NhzoLDMF9fIYZAWZHTa2hSuGikJ44i2nkFzcvTVosrg=;
        fh=MgGAgkixxKdqmYhABIFkSkzStIxauqtOHrbUukIvxBU=;
        b=da5uvHb0BvIdceA86ATbD0MNBARfx2mxMANcKUb0HzXuqVZ2iLdpYqNrbvecGKVww+
         Kv70eVUkM32saT7Jfr+7A3ILgBUIcExA8fB0QRUf2bqVCJjoeuEf9CNqjyk2CVpTauBZ
         FLGqMV8ISkiIXJIDlr5CbOIV77B/MHt66qWi2OOfu6FAzG94RVAWMQ9UjZfRYX2aUULe
         ugiIFtrGPS7npQ76KV5W0JRoOdqhzV5/cz5vY/VByT2luNeybKEWW/E6y45KwI7Oc+lS
         75n2rlzZj1xmNkGnMvejYt7xYfQIWSq+Ty7xUCIk3NUWDxGQ8lZLliOz+YlhrvWCoR2X
         hiVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792322802; x=1792927602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhzoLDMF9fIYZAWZHTa2hSuGikJ44i2nkFzcvTVosrg=;
        b=iFxlHW3TegqwCeXH0GL2mApRaEGCFmoby46yjmbwQ2gm/9ZjqsNMf9sLawiK302zt0
         szSj7wFeeJHf7+BUnNl1JFKyQHPbayuvQplA92TSyVvXv7LNTQCpHC8x/VsxvCwurCQM
         LFsJ5ztgVCGIA0JYqsNFRLH21iy2uZ7ToVmPq8CPJ3ClIPiCH8PPdVU3Xd7DMFeKexW1
         xUHTyTqATBAfr8qgdNCytW9arplqm1esraXTRFDqoUomPpSYvPgH91F6cKphZ9Ntw1pX
         hy5vYd76zRs6kOI2IrmSkHrvlpbKvNG24cZYIcVnrWvx7TXjmRFL9GWxbTvvX2w2248R
         Ga8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792322802; x=1792927602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhzoLDMF9fIYZAWZHTa2hSuGikJ44i2nkFzcvTVosrg=;
        b=RNVbYys9tL9/EdCAoat7IBi9y7PkXz2VB0N53jdPkpo6RAEzqemOPaFNv0YiiFaUHQ
         lUbrlduw8LxMnQs+IJIyKADghUv9/FoswphXOprlhhFVBBKx04wi05R6hbVxxclBLM6o
         kfpyv+hpJ1sn8DcDocgGpbfoLibU9BZoIIC958dbzxBLq3OE7QOj8ON8nEIDgIhrj2H4
         6v/P2RxJZH3AC7ntrH2b5W/vPLSkBr4o2DoCZDmxcNerD7Q83OxfKE1m9tVxzk2yrM4v
         si+Ba6ajv7ta1kaqbe+RhYgVtpINhSywu3qc0UT7wl929hQcKB7dt+oGttvoBZoyxTmu
         1JoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcofODl68GSQvhkNh4V12gs14wOjiGQAtxYGKh0PXXd6fHkdyce2ThY+z/5kcfyoAg3e5FNuG+MqJfHXIPHg+6CVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8OyrNnCN0AR92uROlHBqNwApekVNDmFKqX0OgLAbP8nCvR9wY
	NR5Zf+BGhj3doQGPOxmhwevKGeft+SvtzdrFh0WBuPWLxpjLNNgFXvXrqhNrwpQoZvqJQBIdz6g
	qH7wnnT1pRqeDgmQkHmMJI+bVhjI1fUA=
X-Gm-Gg: AYBFou0weVTNCcXju/n6jhJVqes+FWYrwvK1RnVi3g4vNfGYG5IcqdgPkkjEihuu7Cs
	SLaQidiwEuGNv2vWDUl9DkahqFmGtWvFtyPMK6SoGJOCAA9B5+tYyADTkN/OzhZ/OUK8BDJFGEA
	TSTf5v9hYSe5swb83bR5k1qrlpbKxXfSkAHbs5nWzssdQ1cDJTEXTCp5pZEaZlL6paO/a3L9qJT
	/42jDKMalbO/nPUKsS461d0pRqUMxEKBSsGJ4BJi8gKDxJ3mfYwlDKdYtJ1cd+Nhtfr6DbNZMzR
	J8Z/8n8AHE/Q1LL54elUxZOjHUUe0P7ZScaYfYo8CDTlXupHNsgBMOQwLAUAGC1XVg==
X-Received: by 2002:a05:690c:61c4:b0:8ab:43f7:f058 with SMTP id
 00721157ae682-8b0f220ed99mr12799007b3.107.1792322802028; Sun, 18 Oct 2026
 04:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail.com>
 <20261016103846.73ff2980@gandalf.local.home> <CALsPMBMeXHd1TN89bHCtS3G0M8MFiimf8w=qKayxuYCad8v_Gw@mail.gmail.com>
In-Reply-To: <CALsPMBMeXHd1TN89bHCtS3G0M8MFiimf8w=qKayxuYCad8v_Gw@mail.gmail.com>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 18 Oct 2026 13:26:31 +0200
X-Gm-Features: AclHuK_Bu-XBvleBAPZGj2NXrLZoPlWgyD8jpOn4PYJbzTp9oCFNZXr4st981AQ
Message-ID: <CALsPMBN6dii8mQNf=fxwBhcBGvs_Xr+7_fr=F3GTtp5Rwi8xGQ@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: mm: Trace TLB flush requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 4:03=E2=80=AFPM Roman Storozhenko
<romeusmeister@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 4:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> >
> > [
> >   I realized I replied to v2 and not v4 as the thread of v2 pushed that=
 to
> >   the top. I'll repeat my statement here too.
> > ]
> >
> > On Thu, 15 Oct 2026 19:32:34 +0200
> > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
> >
> > > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/=
riscv_tlb.h
> >
> > Please do not put architecture specific events in include/trace.
> >
> > They belong in the architecture.
> >
> > See the example code in samples/trace_events/trace-events-sample.[ch]
> > as well as the Makefile there on how to put trace events in directories
> > outside of include/trace/
> >
> > Thanks,
> >
> > -- Steve
> >
>
> Hi Steve,
>
> Thanks for the review.
>
> I've moved the trace event definition to
> arch/riscv/include/asm/riscv_tlb.h in v5, following the existing
> RISC-V tracepoint convention.
>
> The updated patch is available here:
> https://lore.kernel.org/linux-riscv/20261017-tlb_tracepoint-v5-1-256fb539=
3a7f@gmail.com/
>
> Thanks for pointing this out.

Hi Steve,

A quick update: I've posted v6 with an additional fix for
the alignment of the dynamically stored CPU mask.

The trace event definition remains under
arch/riscv/include/asm/riscv_tlb.h, as in v5.

The updated patch is available here:

https://lore.kernel.org/linux-riscv/20261018-tlb_tracepoint-v6-1-1447642787=
0f@gmail.com/T/#u

> --
> Kind regards,
> Roman 'Hedin' Storozhenko

--=20
Kind regards,
Roman 'Hedin' Storozhenko
