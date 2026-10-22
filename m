Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691821;
	b=mEHERToe1O6JrFdW5tpuafl7V5sI7JFHJKi648y4WRJQ/ZA9i1cIKZNgHsLap8pBAEEx
	 F2z4tdhZy5VLI0+A4i2AW0QJNkK01Uwbbpgostglq4bYLb0yK+Frvq2tx0gVIfFuPmhIz
	 O9okTUwcxre7NXSdF0pzff8FwcPTdbTqZ8gFtHDvE0MwQ2680rr045uQL5Xre/aTwSQsu
	 0h0K/w+Xg+0/TqZp0OYioadq+KSALbJewZP1EQDTa1jfT0hNqqfl+6i4WZwC91Z9BTBRH
	 Kl1A9dH0zGaMTZO19wSciFpvwhBLValgXIq5j3hi2UfVuA6J2OdE7G97yY9JsBb7RyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
	b=hAELkulHcivo4kEKR3MY9yN7MGvL3s68EAU8BWL4u3m3GP1XjGir1k6j5k6inkEEoQjl
	 KHzfwFkc19sjdd4dY0oMN9PpG3BoEWKi4qkeVKBtli2LcG5oKy+e6v9JgdKd9/fz0dywg
	 BmrKeBICjJgfIM2kOYMTiGiufA5P6omCaPQAYxW4EnIfokC3VPuKNnY0uKXvoXLLNmlbY
	 04icJvrRKzx+wx76jDLfr5SEAXoh5LFgpUyZ9Ne/AFwKWyO0jIm+YYPGsLGeHu2qoaLJw
	 MeDAU9/jQGzPYk/M9j+DexXDt2ednI1MB35Yr6EOY7Cf/QZQ9+u4uAN82YKA5ocvYnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1B606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 17:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8623790f8so6855ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 10:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691819; cv=none;
        d=google.com; s=arc-20260327;
        b=NiDwRElPDMipCMQuDZcTOu4mOcgk5C8uCekwWDqoPvgnH4glKkU1TF2QqX7oIyJvLG
         txlm0ciuYf116/z9rohdjMHwBRFWqYK9LPRkzDWr/AArf6QMI9P9eDCwqHnhWQ+Q/2Ex
         CfobatBu6BduMjHJbjuBFURJG89ztkcnoVZXT/QB6jWDz8NbJ3+COk3vBXQQprorpKZO
         8xdg7SmhVrHmKB/iJ6BSDGcSApuZkHt7lqbxc5EfmZ7uH+TbS16yyLYkFfbiQkEvHx7Z
         ZnBaOFeky1cWnjLIpKu7ILWR9tiKHJ51B84Mj6rszCm3D1mm4xThvZ0ggjKDdMM22hSh
         RNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        fh=zXfWz/4Z4XqoUALr1mv0uIqMlBF6buj/nrPDF7ZPnCY=;
        b=HnJyqwPjP0avo6r+Zlza5VWMW8U8u2+BcL2nLTGAf8e/7+5XV64fmnT2+oEM9NPAdo
         GWqEMzU6vYZqU3tHZzUOR3QZpBQ3L43rkkRXtIhJ37EYdv4v+D21WYZ9NISkLQUXNahD
         ocdIeCLCXtQ45jDwmzTp0GTTReHhCtzQ+U+zwZKAjUr2BhvN2iZnZoLUiGjQwOBiNhme
         rhvKRFNeHy+bju7hm11KpjGHx2qLxlsHsP2noozjZj+V3ZLtYY3sR5TkbYpd2m+gXaYI
         Acg5W4/AJaytE5OWJQJQbdMoFcPMKSylDMV/WMc98zbjJAFTd+4elgHtUlaLJuSf0BBg
         ThKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691819; x=1793296619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=YFdp+eNtUuEUTvr6WJyWDSWbgr6375Hv/W+rTk2td6itbHuLtatk8TV3FBePVM7v0W
         +q+UbeyAt0FTXceQoOBjMY/Ttfd7dUv8kQJ8yreK2BjsATGe11z1rwVU5iXiMvJ3Dqg+
         9CVMbQvVQ+s09u+L4/Qu3i27gNo0YA03TQrfaezeGuyKv2F88/DFShOTND6gd0rdAtjo
         9OgISODKkk6HDUFhd6tONLgbIZKHIQ/LSOJPxFqDhy86TBHzPOEa0QWqIRCc/4wp5rla
         DJdBFgmSiM6TL4oYHtefgccGo7BRzxU0mdcGk/pGx1FgArFziiCHYZrSeVpxvNTcWRgI
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691819; x=1793296619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=Y1Crxk0Ctmm4VwppyjjIcJv0Ot9cuu4qJwfeDUOV0r/Xb/HAez0QvMiAblyIph3+AK
         ASotOgeVplDg6q73m/nrt4yU9eExEogKOArCopbt/V9w/ScXKg0Gt0PGRJ/QGdZiwAOn
         M8fAGsDo3cAI7KB4siG+1RdeO55qnUybfeltggk3EEfnr7a5KqmNV2VUFRvwIcxScTEn
         Tu7Tm7QB6T1JAC+s30czDZmwD6uOlNhwCpPMwKxXjR2v0Tw57RMXsP8XSo1Qnrwq5VId
         D+5384UAiDp73pXfOJm3jLOzdHgEzN0d7zUDSk4KixSf1bXsMUdICJoznLmzOHnSxfQi
         mX1g==
X-Forwarded-Encrypted: i=1; AKwUvBwdsp4uTsXqXBgedkYNfb2Azl1q4s8hrvMQ0yEksg8Q7psAID0QQsVQjn+wogJvLbdOQveW79w00dw5KJ8HzlcuX5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdB5aSLaQqbVpP26D4cRQ4xg89SDQXhpTz4d/oFXvHgbPszT9A
	ql6o21Bilc0wzbEyNPKZt6GNXpvAt9abHzlcn9jBUM8qzp4doCU/VWI+Qa8oWmg61aW8Qw/IuKp
	SfQZgLD5k5KWbIS+Ias2qit8dTIGmUP5AlTYdhJPf
X-Gm-Gg: AYBFou27qc3U/LJDM0EDMzBKGCo8x7WHi/QVPhj/brfOg7OEfkYfBg5QeQlSyb8JQ32
	lbQtzSOANHtUVSg+YzdbE0tFxXamj9z/Wj0482miERfmjdnEUVRoM3hLFJBx3h6qk5yZWbRuZpg
	40+ny/f9CPFRB+x00SXEWXLDgjuhhOGJCJIeAHb3lBwFSBLhSyEyxFYIXGyzc8mXuWXEulGkTfy
	wec9DWEoOWFjA2tRNf7kEBQjk+xvMn0qeTbIOtYx281vPqFyOtoSZ93/J04k47oQPM+kAYNBb88
	LZmCzbJGOy7BCfaiBYMHxJaLH1SEuLkjhUxz5IhK99cz82o3BUW+1uYcIlEXZ6XGeHvbmfof54M
	U59YKb+l7i9ZBqWT7ASzPAqjETV5mdtOsr9rGsZEvXAbGSgRQ7sY7GQq3JLQlMYr4YErylJQeRC
	1aBv3rF+2sngjTXpVWibZM+Q==
X-Received: by 2002:a17:902:cece:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2ea7c856829mr195125ad.13.1792691818910; Thu, 22 Oct 2026
 10:56:58 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 19:56:22 +0200
X-Gm-Features: AclHuK-YCNtnPegYnn9KvUKugGxObkR7MWrtu-3qSRj9_sjY2T5TwF4c4QpzRSk
Message-ID: <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
	liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, hughd@google.com, kees@kernel.org, mingo@redhat.com, 
	tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprob=
e *auprobe, struct mm_struct
>         if (IS_ERR(tramp))
>                 return PTR_ERR(tramp);
>         ret =3D swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -       if (WARN_ON_ONCE(ret) && new_mapping)
> +       if (ret && new_mapping)
>                 WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NU=
LL));

Not an issue with your patch, just FYI regarding this preexisting
WARN_ON_ONCE():
A failing small GFP_KERNEL allocation could theoretically cause
do_munmap() to fail; the VMA tree has the ugly quirk that you can't
reliably _remove_ elements without memory allocation.
