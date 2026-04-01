Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC145348A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052534; cv=pass; b=dODozBl5Kfdw5YiQyZ1UTz9pCmcGsu+WUpHaBotlSK3RY/t4b6FON2z0jUESn1gjg3+0feDfTjPmypVAGrRcEcuQwTZVJE4fia39gfBD08TBrV1xXC407RCotastu5Y6uw21a63Vpdg6YFzA2qVIwS4djIObQkRtP24PgMUcuSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052534; c=relaxed/simple;
	bh=hirgCt1PZAXwyuuObnGxxAhuWbF5pVndJu+2sUatshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FANXRagTYTLD9FBzSuSJy2w6heULqe+HncnoRzeyCmXyQKJldGmy5EJBtZ6++u1CFh1V4gJq+OA/BKdGwl5vQkFqRHMGuD0bkkXwR3PW+29BKjEgdfPqF/NM3TIUQR1MlKad7Ec/SBasjW6AyIyHed+HnvB2jdEDXTk010yoF7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiHg6Se8; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiHg6Se8"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2345906f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775052529; cv=none;
        d=google.com; s=arc-20240605;
        b=ZPccKpDcy4nCuMtjw6lrz3Gbi++sCuvj21/84QfF8oZ1hCVUrVmdaIf0ReCa9fICk0
         eZnalEkuBSteaWClZO865tUCIjJR8w9SJ7Q/KQrpXU24iewipCsFWqYEFu6l21V1WZJM
         N8Shi+8MbQU+95UV7R7aO1ZwO4x/UmlpobMLXgfN9NYjifB4s9IbfJ0xPM12KVeEh97r
         t7DBGavLUHWvrLfL8AdnD86KuLkE4fa4q/wAUA2Zbw0RThOokbiWmZYdMQChL3aSoz8i
         lxPTwOtmqeRBYZFfMsVRTggLNs1axuh/g/2K1FlcWdwIni2L8vG15AaRnHxy0ogeYQMY
         keFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        fh=MnQHD/VcUQ/DC5CgpeYqJoke4Qxl0VljB7tGQF9j6GI=;
        b=RKa2CpBba0ZL6PBRJRF04z9IpPSPURrv35eQsDw7wcX7XxvQkg+wSVPMu3QYlcOoQ8
         4VP9Y7uqjXo7isuhRR860RO6KlzZfyOdGY21IcmHWwghNyVm8C/MWVCAt4GA5z1Zhgap
         fTnzcBqYKLoGrpBrkOXDYhEO+WCMAdpnb6ZC29NhL3NIST/vVWtTCtPd5SSdNd4Q+OQ7
         ElAg/aCiJnEe3ktD+ZCgGzVbUrod++ka5oEMjGQ3USaFajycNUpMzI7KhmzseirouFxp
         h8oYtFm35sjKXJvxiBITI9nEIdzLjuFewNaXE7RxI3USV91FExkaBl8ZMqluMSutj91+
         bweQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052529; x=1775657329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        b=QiHg6Se8TROA6PrwUEDZ40hAU/jZ8ZBH9/O3d5DS/Cdm4w5K474tLqfoNb/B6pdsGJ
         QuNl/OLMoL3xcR6iBgwDIuYt14y2m78ruK2Tj1JtjzoyROsnjebTMVn8tMYC8OpQwXUi
         HZ9dCUdKJGqXnJPcQCLGEH0I1PoU44d4eMDjHEXt9r7U3JC2vD9UHoj74m63mAeiUmoV
         UgeNWK9R7Rd9LhKEDn8UEQJ1VPYKgGAO3fVEC4Av4DlDsfl0Wd1X0D1pZdxhcSYH3WC/
         Ip5/9/jiY0Djn+byEckdkEShjH9mL+psGLU0prQaRf66W7G+FrlthFSuALE9PdE+qUl1
         Yixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052529; x=1775657329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1hIUDWQSXTMNI+xukBaLoexapmPDMcad1HRGKU7yJ0=;
        b=mJuL092HGbzcLoUl/BWmOPfblzdUoDYJmcUImHHrRtLbB8FhbPWPjt1fS1+VwDFS8U
         sUo6v8Oqbm8nc/wsAYQ8nm1BQUTIyfIExTeK4OuB7IYpjPFvVrG4Kw7NlYZe0hf2j8gH
         DIlqugTW9RAnQySo5WvmkgBleKuUZVtmwEY67vDPsdqpvb9TEvnMH28fk+NLOPpXbK1B
         QcNsdVo60pJURjkQg5em6ImQOd+reA11EG0Gpg9ur/lCMcjNddSAxGqiVhC4ebDyzlgY
         Y0RD0A+7DuSgdIx+bKoJjUpjipDaVtNGRK9lXX3tyvzjpbPLG8Qnha2H3YO9Up31lGbp
         ue3w==
X-Forwarded-Encrypted: i=1; AJvYcCWWkM3iO6rLp2CMSGHnxtfgre8YNXw6E9qPbmcMmNwumlZVgs1klbsCHFrXPAt5GnlydZlU5S+y4QaT/y3sYD/MdNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9fSk8CrZ89JQNIRPrMoas+V5XIkZwZ8M+dh2W7KHRV6N62rw
	uC4X5I4BcZmBycem/kE3xs1IyZQtaBWjjr0zWmfqY/Fbmoryu7oJxVtkb/v0aHupLjKD4TAs9+u
	fwuHi4Ptzz4PF/Byg6fcI4t2OuGhVfZY=
X-Gm-Gg: ATEYQzz4CyjXuJEwrU1P9/LjGVUA48RkNvTRxR9/bTM+ypGj6moHkFPRPE7lCtKhGPC
	y1KPJ2zXM06nT6tTrEqQl1Oe8dRgEAQwFkmlEy44HYKNq3BSxS+1hgbhjRcJv6GuXEUnNlBPn/a
	fcgNdMHQnoKcjVBOeI2gjTeSgwKPFzj4CcYWRfBdufIArusItmS9HrlfKn1FHJbhm5lxrSO8iGe
	WJCNE5gdB5ykyABRsFMzaTZMTy07HOfcoaAtaKpEEsQJ/5cXuQKbvCIaaiJxDGbjWM3CmBEImTh
	lXKKZQrzHO1sntROweViIpk4m6+t3UORuP7TBo83akOBmiw+ug2XX2Oge1w=
X-Received: by 2002:a05:6000:2909:b0:43d:29a:e42a with SMTP id
 ffacd0b85a97d-43d150c211dmr6936101f8f.29.1775052529247; Wed, 01 Apr 2026
 07:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0hLyMuPHiZfnVc@computer> <20260401134921.362148-1-varunrmallya@gmail.com>
In-Reply-To: <20260401134921.362148-1-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 16:08:12 +0200
X-Gm-Features: AQROBzAyPknqbXnEAJ3AwqA7IYVLrAYRqJiT7mIsqGERF9toiQ9NeCx7u4QvpN8
Message-ID: <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
To: Varun R Mallya <varunrmallya@gmail.com>, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 15:49, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
>
> This causes a "sleeping function called from invalid context" splat:
>
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
>
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
>
> Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")

Please use the right format.
Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")

You can add the follow to your .gitconfig to generate the fixes tag.
[alias]
    fixes = log -1 --format='Fixes: %h (\"%s\")'

> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..af7079aa0f36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>         if (!is_kprobe_multi(prog))
>                 return -EINVAL;
>
> +       /* kprobe_multi is not allowed to be sleepable. */
> +       if (prog->sleepable)
> +               return -EINVAL;
> +

Looks ok to me, Jiri, could you also take a look?

>         /* Writing to context is not allowed for kprobes. */
>         if (prog->aux->kprobe_write_ctx)
>                 return -EINVAL;
> --
> 2.53.0
>
