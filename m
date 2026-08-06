Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED147F769
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048944; cv=pass; b=odWjFLPhBd/7Y0HP/YfoDp1XLhdVu8NhzOaLTeuv/4bI9/bQgtBS3DmDYZthWwMwRb8uQPu2ksQzfRaXVP7egxgs/5sUviCYslunILcYqWZ5UiT4574G1MuO/b+W9/+zx/bEhKlNOnUtlqpw7qBydDmOCYL45ArrD6F9OCXlfwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048944; c=relaxed/simple;
	bh=IEAKiadDDfRNm1Z+dbK3Nd06wHGzWvoim664DT4WGyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3lgEgdSTijFJ52YaGPoDBZO9PmwUhi9fRNUXOxGb55sC5cpvHCEZ5FUQllZAUxzkFzTYkgjJa9qv5Oy0CPxd0m6YdCf7agcO5I9VSMFaIXtzd7TUBt4mH+SNOYd2iTw45RU/TxngKy7Y/eNbhwpHL26xzqz1S/xgXIefILbUC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GchDjg/W; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GchDjg/W"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1077121a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 13:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048943; cv=none;
        d=google.com; s=arc-20260327;
        b=BGdJ6JYASNtHEEmEvdLGXB8wuUNH+NRt1ud9j7WXvcV8E4skdafW/VIT5u4acDoKaO
         Lo0tKy5Z6U7cWxRbDC1vcS2LIt6LXH25EdXnQT39ibEhtnzObmdVSphPUUz4XJtvWFXa
         6OjpW4dxc+XQMBSHYvx8UA0hHAPz4z2TpucGmHXYGU5LrGopNJiC72QiKIeGii/twPmh
         FlRy1xu4Vg41yw99gmm3K6KiCJOi+3rHagvw7XuiNJb/zEA9SUVroRrblhbneyaKO4+1
         VCsuJMgnu6JRxZ2OMG5gZiCDmyDlx4URO306gNrhc+XBL1CrTHO3ShcybSvXwMEEn/vE
         Oelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQ1FfzBkBhxgzhysNoqlk9Ugh62yE+uGqtILaSuzzOQ=;
        fh=blkD10Nub4LHLgPCTmBha52J1XB+mR/RjcxcN5HVzPQ=;
        b=WJoIh4zNC6EzG6TTk3oc+sT4oZcHzxbzx7+zHm1SSBchsYAWlYoFvHWs92kpMZDvT3
         l/O+bCnXYG/hORtEyAZUpdgIKFHH/gg3L1k6RqvlGqPkQlY7hVVRwIAdgd/Y/IEa/EIs
         9NDRpVdBF77I5DveHvz/Tzm+zflOA9AZ+HO84iGDO5WybZJ8iP+puM9fmRQ0ConVJEge
         /Ijj+0txO3oeBZ2EIUqQ6U1HNeccEb6zl19OsEGG2bFwsYvUJFtXP8j+hJXTD+H0vVPO
         nr3x9FEMXLYEL+cVgfecfWY63dNljtEGHB2+LgmSkcVlldrl7ZrRV/Rw55vOSw4k5RtR
         zwIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786048943; x=1786653743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQ1FfzBkBhxgzhysNoqlk9Ugh62yE+uGqtILaSuzzOQ=;
        b=GchDjg/WCojDDgQiXFg4q2koveZmYske+fc39H8B59+hvyb7+khIAz8j6Cy5kzEISF
         jvBk9erst9DuaAolbCfrCVRxg5T+fl6I/7/c9yoA5wILg/fjetlLuZ6hMPn0nsip+B8g
         pB1BG+WijX4IRqzd/03qa0XZ6NWuAGYdmI2w98ZGjKNMKyYEtCHeOxcwY2cl6RFqtRXN
         nOYKve7+WjgCV27rmW9tqe9ct51hlc7WAP0SiMvBia9LRgujq/zFyjthsk4aEoLs446D
         +jjng8ze9fjhUN/c+JXyJuBYdFlzMvyrWRYEUhgkAp3w4/2n3kpxje+7Ins82OGxFQDY
         i09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786048943; x=1786653743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQ1FfzBkBhxgzhysNoqlk9Ugh62yE+uGqtILaSuzzOQ=;
        b=eLJnwi/MV7Kxp22RXu+Un1vAWcgU9GnVmHmWzwBFe8nw4LfLbvbMlBPlPJ0JyUH6NN
         6zXbEiy3dh47BPLP9BQ/YWOFlFL6nVgPTm9ATCBUqC/41ux+vIkB1L6vq/d0GrrjZDIs
         rW/Lha+yAMRPpnddZ54hcsJffzUKOA7+K7vId+iv88Ex2J5zKK8i2/RP5VtMh/gLmnJX
         7HovGJUKIA1C97g45pLI+I4OXA3xIoaUA3jGhghfw0C0nuQFQk5KjZzrdgR33XJKUHql
         8qOMBQzEtC3Bb/oV38HyoE25M8BllUUCFUy0svkrqLs03YOP1i6UAM7AqCAeDalr3/tc
         geRw==
X-Forwarded-Encrypted: i=1; AHgh+RqBGkyVJop415KVQ7mhjGptpglWUCSpEYZnE66vAUyLeu1FFH9WY/TxpsDrbYXHJ8zLC86kmQhWb61YTEnErB67L0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mWGeNcsDLlZ5T84ZRNHLhCQnFfnEbaH3FnEKd8KzOjy45fKn
	ORJtxeHUW79oTt6tgj6qtlXh+x16ZgPvoEd6ImM0ycOwHDofydl1fgmwN189XYYqUi+7LHqPp0Z
	CGnzusgIDyJIdzbPSKPfC37FP/ETSjsc=
X-Gm-Gg: AR+sD12NSabYrDRhZ5lezyln6c/T6OoV5lyQcClQo5LpCfeFvX9hB2OKueWS8N/s0jL
	UPYEV7yStCjJmYfXg3mgWz/G8AV1ZzIqRRGsoPfBtDhA+jHYczSCpnGZfqFea2aTPbL543A1AO8
	kToxVMRhN4y4lDebSkDUZndqIdaJgHIx9nMHW6czvLRvDx4z9WxyEYOPE2X8o6bZpBFRUeHj8t2
	XxDwv/VEGSQhOCe8A5zxY7jQ3fPhCJtjK43o3sup5pACObkf5Tz4ULRzJSXkupsJyHWyzOEc6p0
	CZz3sgQxm/tUlK/81e7xFKxqho7wnlgGYDmPTRHBOjKwfrgheugPTuYgZA7LPrZGWujH6eVpA+9
	9Y4+/NYbeQTBnXRiV2kdZ1SwrplTCyxESop3ddz+sNQ==
X-Received: by 2002:a17:90b:4a52:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-3908976ebe5mr2158790a91.7.1786048942551; Thu, 06 Aug 2026
 13:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com> <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
 <anRpdyApCza3MYVi@redhat.com> <anSNg4EA-tUc3C7W@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
 <anSpyzXNCF_e3NFc@redhat.com>
In-Reply-To: <anSpyzXNCF_e3NFc@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Aug 2026 13:42:07 -0700
X-Gm-Features: AUfX_mzLzfnMr5JzhO_LfD8itd6PObYZ2vjgmz7RdHZl9DJIxyA6-AdybXOhwG8
Message-ID: <CAEf4BzY50c1ZxyNoE4619qiK9ZpZuLOkNawgGqQKZ3i9RgJWDg@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable vmas
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/06, Sumanth Korikkar wrote:
> >
> > On Thu, Aug 06, 2026 at 01:01:11PM +0200, Oleg Nesterov wrote:
> > >
> > > But your change in install_breakpoint() essentually reverts that comm=
it?
> > > If uprobe_register() -> register_for_each_vma() finds a VM_MAYEXEC vm=
a
> > > without VM_EXEC valid_vma() will return true, but then install_breakp=
oint()
> > > will fail anyway.
> >
> > Initially non exec vma will be ignored via uprobe_register(),
> > install_breakpoint() will reject non vma mappings initially.
> >
> > As far as I understand,  if mprotect(PROT_EXEC) is performed later by a
> > process, it adds VM_EXEC flag to vma and calls vma_complete() via
> > vma_modify_flags(). uprobe_mmap() will then call install_breakpoint()
> > and now it should succeed because VM_EXEC is set.
>
> Heh, I am stupid the 2nd time in the same thread ;)
>
> Sumanth, thanks for correcting me! It seems that I forgot everything abou=
t
> these code paths.
>
> Then this change makes more sense, but the VM_EXEC check needs the commen=
t
> to explain this all.
>
> However, I personally still don't think it's worth "fixing". But I leave =
the
> decision to Andrii and Jiri who (unlike me) understand how USDT's are use=
d.
>

I agree, I don't see what needs to be fixed here.

> Oleg.
>
