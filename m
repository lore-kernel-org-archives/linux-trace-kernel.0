Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1F47A0B4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054602; cv=pass; b=ehnsXFjJcXCi8Xq5JcaZBDf7vHCbqcGU68YdQNSKQ1gyzknPIWE+KmcRTKxFRgMfpxbB2KJBQOsmeH9hbHr6yHUWRjvUaZk2QoIYZvkBk/nXkdMcKtbtSfgGA7oQuIawBoodiFD5WM0N2MVoiiNusRKLMDQHbugzzGP8ZS6NznE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054602; c=relaxed/simple;
	bh=X5nfkx4/Qm3d1skqkseBbH+/HkmCh60oDdKDOFooGbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfkxXLLJhxeDx7CbvEMoKV6tdbBbV2AOH7FErjFpsuNZJarHHEasklXeryMe3wtgPK73yFDaRnpYWm0zdl1Zln+nw8YHsI3bjR1ArHN4BGbRZYdN3sEePIbvdkoZSDwRIDLNVZTuYPexJcoNIWnhYK5JMwoEnB2zQyuN+WxBzZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMWfKyj8; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMWfKyj8"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso3280312f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 07:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775054600; cv=none;
        d=google.com; s=arc-20240605;
        b=E1u3hksLuI6XfG7XpUn+89o4TtMlqRew3WaQvQhP0Lppp1kt4OlB5GlfGf5wLpjMI3
         XKFttGfeYMfqjYkcunayEnHc4nmlu6hfBnDbJM3yZ9c1TQ6iOQAacOKCQ/hKCqPmllIv
         RsoQX2Hfuq+JeW+mZlhnPPlfWlNa53EOA5FQ2dAxl4K6vXerYtVKINIa7xibUfaIoR5Z
         dLOvaceQcKwQG/ED2chStk3EByCRKPJqzCobl0TSjbUFZ+pKf56Me2jXGwxAWe5NSRLr
         bq9UEPGKzs8UNM4rJHhU27hKW1O+6UHmOT0/ZcmUqb1KTsJW+dlBDYMZkGAWYG66nUVj
         ds0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        fh=RZ3oHHANMy3IqBYQ3BGIrO72wFEwC8BbBhCDa8WwvCo=;
        b=Ef7tBE7SCicYBn81ytdHRW7aNJOV7L07/MtMXN6s67IH2mCRRX+VX0Y0i4vTJFK719
         4hIjzTQRLV8FFm5DCLohLGPdW69e74vZAWou1R8/oA/lInKAtOcWJgcVJmf9EAHt+Sf/
         9Wdn5HbXoeeSOXxeOWyvRKje6ydgX9sU34tUkxGKedy8XY2gbtqu7te4DmafO2ApH5kR
         mVqeH3+7zLMlmBSVCt0qC1LLaAlqAF2E86PW3OCOsf8KKSzgObUmzBp0rCg1bwh5iABN
         pZyVNwmLF/iaX9BMvngzcJ7HieHfkxr0Tv7HlMfo0e95ZJCQrNxIikOKph4U5DnFVer1
         yLsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775054600; x=1775659400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        b=FMWfKyj8jMCudcGedDgnHv3Ck97vQwgToDPyXH5qTJAR9Ir+2lRUQQ6HAR5+nhy9ia
         g1eZmT51K5MCzfVGThjxFy/ev5mzfKZ9fpxv3DAJDI189/HWV+KOGeTJrxEysZebdOEb
         xX7xgfHSQZpeTi3g4rVxsy/BYJhd3OPZ4+FfCb0rK+1R1WjKLM1WhuHaT8QGGaVZoyoV
         li8fmg8R/QjvBfO0v21Ok2FtpOZ6Pn5PUdBqTYSyZAb0MqTj7qwnP+VafqPkh5Y8lJ4P
         DjaeyqU7cYg9wGvmj5ElZbO6pbGMigf9LtjSgZR4NcqyR+DHmQt+nveaAFhvgF4pPm8N
         3Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054600; x=1775659400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCEkWUgf5f/vT3IihkMjMEhZxsSNLlsM4yI7619bxWg=;
        b=flURfQOsOGRGB784EX82fAe/fCoVXJSc897ZufzvNUASN1uKera1JjLkR8KVk/edEh
         pi8vFRuJAkBD/mVsxmJEgrt9ZA6/56W8A9PIaP7tRTjWk4NQmcrlUL2RmL4FyyF9CYLx
         oV0l/z5yKT7YbEucClgBluaN6xgLRJ0vVgtDkBnWmGb4OywfiJyKae+7fHAfT3TlFNdm
         CfF+umln5HRUCANgOM6o/1+9MD7iW4yu8dOG5jdS3uWbVRM7ZoyopW92j9ASPlN4bcwg
         5HZi/SwXP2PUH1YE5OnnHzaFB6z639voBOKYUhaW5G2GosXe1QFARK+I+MvevAZUnXLJ
         K72g==
X-Forwarded-Encrypted: i=1; AJvYcCVinPsv+hMn+0AUwTAWaXqK0vn2Kn2docDZ7DDJfULcy3xIsfQurlG4sJZ2lUrbBhYYUpcVH+uqe5UkdRtcx7LDW3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrJUwT3HmOg7bglWtT+J0PrapoaMf6/1uWHAlkrFGJkF0fmq6
	Q8qglR+pJk0giSwwbBZiioIHznees6OEzSlFWAIXcqJQd7BTKq6x+Znlq//nvIt31ajkLjYd8Iq
	XNRWGRKROETCn21EgswPH2RRpkehHblI=
X-Gm-Gg: ATEYQzzAeqF4HaX9peIjVn5RP4SFy3bDA8PFbRvooCP/hYBPgSsPKNavJXGFtOajVYN
	Y7IoxhFtietJOMXQeaVPS8J6lxNLF6p1O1RGmV8i6DGDArSYiS9VQrbj8GGxnQgMni2zECENHhU
	JEr4wvttVHcRZsAyywMVfibt6Vn8nCdNHSVtbVKt1XsjC85p0dIOQpOHwwMjARiBnbz3imHk8Gc
	2nyNsNgj0js1FqP+KwFRodf2LvKbGoXSgOJtilLITOzY07hRdtUgnBsSTKkBekrC0sqjrBb/HKV
	w+2NHYTozdggFlymOvE+835TOL/XNzDaGvvCzaGdJdhFiiTI9eUIbHF4Dqw=
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43d1505b105mr7181347f8f.11.1775054599060; Wed, 01 Apr 2026
 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0hLyMuPHiZfnVc@computer> <20260401134921.362148-1-varunrmallya@gmail.com>
 <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
In-Reply-To: <CAP01T75D7p2smSyoFvyZykgC5bJdobL_cqtk6-w+LmP4NP9SpQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 16:42:42 +0200
X-Gm-Features: AQROBzBw2x8878imdwPXOOGBOW_LkGML6dkWFLRsSFWWVlrdf0uthfaebSWVysg
Message-ID: <CAP01T74EV11nW1y_DbzO13UMPDx-aq11KHOfdjqT35QdN414Cw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
To: Varun R Mallya <varunrmallya@gmail.com>, jolsa@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 16:08, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 1 Apr 2026 at 15:49, Varun R Mallya <varunrmallya@gmail.com> wrote:
> >
> > kprobe.multi programs run in atomic/RCU context and cannot sleep.
> > However, bpf_kprobe_multi_link_attach() did not validate whether the
> > program being attached had the sleepable flag set, allowing sleepable
> > helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> > context.
> >
> > This causes a "sleeping function called from invalid context" splat:
> >
> >   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
> >   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
> >   preempt_count: 1, expected: 0
> >   RCU nest depth: 2, expected: 0
> >
> > Fix this by rejecting sleepable programs early in
> > bpf_kprobe_multi_link_attach(), before any further processing.
> >
> > Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")
>
> Please use the right format.
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>
> You can add the follow to your .gitconfig to generate the fixes tag.
> [alias]
>     fixes = log -1 --format='Fixes: %h (\"%s\")'
>
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > ---
> >  kernel/trace/bpf_trace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0b040a417442..af7079aa0f36 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (!is_kprobe_multi(prog))
> >                 return -EINVAL;
> >
> > +       /* kprobe_multi is not allowed to be sleepable. */
> > +       if (prog->sleepable)
> > +               return -EINVAL;
> > +
>
> Looks ok to me, Jiri, could you also take a look?
>
> >         /* Writing to context is not allowed for kprobes. */
> >         if (prog->aux->kprobe_write_ctx)
> >                 return -EINVAL;
> > --
> > 2.53.0
> >

Also, please add a selftest.

pw-bot: cr
