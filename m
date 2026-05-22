Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FE36728D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475875; cv=pass; b=G+aNZ5JiJaOBLrX3UmKE+vQp4R9NWHVKaZ8kAuC885AtYqcxsuNosOoiwhWiSNO+b68TPwxuFEWwzJGZ8nZlztMYJUol8+mYR7btgtVCWA110jtxJKA9ul86bOlssSD65PAEmOB91dJDm/pcxNwWVUSMHUSrvYo30KGqcTJd0ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475875; c=relaxed/simple;
	bh=JaBGoCYwezsnixmOukVsH8GgD/tq9XpRuZEs8+Wy6SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5IcZAfgKYo2kgAcBXOEa7njcfR1ChnJNMzLydFoutOcohjCLR02kTVhc5EKJNTK76NxOh/lWxsi0EshdCPINqlJp1NE1qjVpA4G7ZoLIdfMGmIGvY9Q6bzEDsQK4Okc3TNBxSuGmLQ/T5RID6AvKmRWNTAEnKzA08e31kwLvn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWDbvOch; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWDbvOch"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-369002b26f4so4376943a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475873; cv=none;
        d=google.com; s=arc-20240605;
        b=QR0POZxLMNWujZQUz23IHNjls0ZAEIvRidYs/5VLx4MtMQtbae+xB5DfBjxWHe2KDy
         fbimUqg0JRzymmtwmYFkE+XmqIsslEJjj/DKF/tG5WMq+o6wXrNxlCdgkl1j5KXUIH2Q
         TsYK0I8mRcDUd8yuJrKXS1z/dYv2knn3/BLF32Ar5A12jSPSeeP8EZZWzFOQ1G8Aafl8
         hBfAPY9iHBual9VHEnYAw7GiryNHVu43xmA6Xyk1pE5afnWRyo9vGNYa/CuyBJxExaz6
         p9Bk6yRputd2Wk3LzgcBLM+zsrXGVonpT1RYBS8mpHtt+gqoYN7KGGZ93hkyWtX9YCva
         YKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        fh=CKWoPWpGEQz+iRG/47/uV5wwhNvm8r09nc881qUs+go=;
        b=cXWq/Fe2uPas1h6V5Pse60qFGIbIcnnXeLT/5LXuJIQlGPx6gmbgptj+ZDdsmnsYBg
         sBILlCjp1oC+0egDdQpBhWksf4WqfVlRx9VhN6WQYGIHbUNgtA+TupAFaGHjZDdXh5lv
         2NIZ6gjUD4PyVffJ8FKAFdsfpgtD8Gs/odU6uqQv23NnTWE4mdZwRV5XLF2shP3Cb5tz
         saytgdPAgnfZG2qRRl0CjmJDwwy77s6b/Oouy4a3nPEsmX7FRizANYEpD63zxNvwC+qR
         pyWG1ofMuLC2iHPa5brKpWBRsIa55U47HfSVBtkW+TO9g2+oCd8Vnx0WkplBLQRJgLao
         r+OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475873; x=1780080673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        b=OWDbvOch7Gs3mWr4iaRpuL3Dnaf8z7dPMJvFW+pwnNjOdhqJQLb8uXrTU1sHLWTW+1
         pEhId2A9M5uP0KIaTkQnEVmlzSt23I/QELYq/MObxOBR6XvAuAKSZQQQvijYRcnlmMB6
         P3bBCdRuweIIonroBXb2rghws9rdPNjX/xJbR50HIHuVGD2qBtlw9K7XrJSDXHR+Dj3n
         VTQtmSl1+FjvsWDZ1scDMMcromGEnkwXA/EpybfW+KkzmY8BtcQEIo4zIhMwrUBrETbl
         tUn0K6EBGWGgLZL23lGO5/1wcCUy3MqfzKPElIf4jmrqhPj6mnk4DFgNqYD3UVhJnr3T
         2GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475873; x=1780080673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        b=AVOHzFtUk3edRs4tWKFZFgpBm2VtAPS8HNCXHbekUC5FQGyKLeIVaxsweOATfMFVCR
         Bztw31o5JYoDsG3nCrwTe73WjCCYokyHW4s9zW0n02TLiDEeY52eZ6nu0/bmtMx3dUae
         eaPjzunT9cMkoh8zL2tjd4LBASd2ePCIk+hbB1Ns9Ui35cFRA/CQM2mPf2AEt9EkzbWT
         JcqhlB5DaIPuTcoWg5fDKjTG3rg2RQ0Cjl0wztSzE07r4vCs+YCXKEUmB94OqW/+t/yR
         drcDatk2SAtN+vL5R6JsaMzgwwSMxN4gIf6uzJrmralg4IvmjmF/xMD7NxndrYzUvRdt
         Hoeg==
X-Forwarded-Encrypted: i=1; AFNElJ9XybBdyNMNy8jnKXY4Qrrit1f5gFQcAMzmccweJKj8fuNl3oGQbgok9s1q4YTYW5mZgJAho6sRDTWzXUK7G5gcLeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywow/PMTKFBa2AMtH6XAUGSCOZ1s3jP/qnb49o68ZKMy/RcMpbs
	ydIslzzo86GtjSpWYSE6eNYBeAU8OdEyObeqnLEKv9NJHwZ+ay16vQxKVTnLoDmKWoWrBOqy8U2
	eBgA4DE58uejqrLaa1IzeeUAZP44kXcQ=
X-Gm-Gg: Acq92OFV1IgT0lc2NexawoC8Vf6+t3+Ku4xgC/0bagHl8r1WdcmYwd2rMUqMoGSnXFj
	uJ8w+vaveYuNrZ04zm5gggbNyn1rxMwiNBTE/nSqSrxjQFz5gWtJT9y4tMSSIXIWpTvsZ05rC9X
	+C19CtOBr5RbfH0zvpbV6VTJvojyZ0k7CfxRTnRY93L1ix/2TZKtmZlefOl+pKt2/DbkalMhTbu
	ALn1ix+B3sL1EKLAv9Y3zJH9gFVTiHTois9cQaY/nPayV+NKjwUb2kGkLXnEfeQwi85TKEDrj8x
	T5fd4mRgpvSuYeWDJ1HDUbA=
X-Received: by 2002:a17:90a:d886:b0:36a:4074:9aa6 with SMTP id
 98e67ed59e1d1-36a676f061fmr4828318a91.6.1779475873188; Fri, 22 May 2026
 11:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-4-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:54 -0700
X-Gm-Features: AVHnY4JGBKgO-D9rh-r2mLuvpt2Gi6GNwx6KmQza1ziCp-WvOj25OuoFjc-AZSo
Message-ID: <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>
Subject: Re: [PATCHv3 03/12] uprobes/x86: Allow to copy uprobe trampolines on fork
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When we do fork or clone without CLONE_VM the new process won't
> have uprobe trampoline vma objects and at the same time it will
> have optimized code calling that trampoline and crash.
>
> Fixing this by allowing vma uprobe trampoline objects to be copied
> on fork to the new process.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 6824376e253d..11ec6b89b135 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(u=
nsigned long vaddr)
>                 return ERR_PTR(vaddr);
>
>         return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
DONTCOPY|VM_IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,

so on fork we'll get sys_uprobe invocations which will go into uprobe
trampoline and syscall will just keep returning -EPROTO, is that
right?

what would happen in the similar situation for process with int3
uprobe being forked/cloned? Will it inherit int3 as well, and then
will keep hitting interrupts that would just do nothing?

is there a way to restore original memory page for clones? this
behavior (unless I'm misunderstanding) seems suboptimal
performance-wise

>                                 &tramp_mapping);
>  }

>
> --
> 2.53.0
>
