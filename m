Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32A57CBC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913813; cv=none; b=pm5F837+QVZY6XIq6luLSs9//T951/cTKVGnjg8U+0OX14pIl4l5vaYpsPFKLs0VAZpWTrQIIAz/nhYWcqVvIdCByJV98IwnTFMQzbJjgnTzecIHJXu7FiUrP6yTrrCW8ej5JfnpBQzlN0PwG5qIIUWor0+E+vN7U+bOhFKWt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913813; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/yfMsE+UMnAWCrdJtGTrxHIGok8gijREnxQhmivWym+ZihF1VbeDaI6nY35R0wd2WP6NLbPx7Svh9uNC4+N+Y3MpEJik/XQy1gadI1gIPqev4vyrTY/OPoEW7iQpS72aM27eGZQlQoQSTitX7vpTdGRpyxdWzLdPs79pJ0Rtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vt6hGsg8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vt6hGsg8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f15790b472so1283671fa.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913810; x=1723518610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=Vt6hGsg8tkeVi0W2Xbo+GM0jM3j+HYRG6Rox3/TRTDwNVT7wkm0brw7CzdCMhxmcsN
         MmuzchUm9+i9yxsf5mvvEzdvyi5lHBRu2duGKq+cLF3CTfXvpcKJZZ80UApX+EByeqc8
         eR7SUZtjdP4hZ7kCBKuGIb3jVFoeyp+g92EiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913810; x=1723518610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=EMBpoeqXENQ1rUAQGrbpsIuJG3F/G5vrOYGWv4vg3poc848McQfFFkd1oSQDfFblwv
         pp2/rOMq/TQLFbSqfnyNeLDqjBng46emVOhqxGnklmxOCnBhViBFtse2kK/9P5gogYvu
         Xm1ZJ4c8t1/IxBPf1XHkeOVR0uxrs4GjuPmDJai0BMeK/zyOgBSidj+mwUyRyQSnXbpB
         DCgvQKQkJGBtRn+GxsH/xs4yG+zIJPiEfbPk+Md9F9GFRZQpcwDMSQ1Z06uJzuLmWeLL
         7shh2sDZ4NI+7j5RzPzD8lGG64fmFdihIK4X1TaycMSMWKC8Rn+Vz1mightotlmoOFq/
         uBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMTJO74//Q9Q84xmN2wzRChgHCGqisrJFfy+S8W5oKa3TJJfEibvPH41qnJFhT5auYKKezxl7if3wyYTSct+j9fD1AMIFvpXWDJqzkY9QX7rZ
X-Gm-Message-State: AOJu0YwJOylMYrZcfsPPHTUrEzTVMGpI0jodCKO3vei1GN7gJIXwiOhE
	qTc7mhsRAKrxqYJLRNPGzkYchGSPz6e/JcHx3NQWGSwrNIx9XjdecMBbjs7wiMrXyMiXiR54/R0
	ZLX3ynw==
X-Google-Smtp-Source: AGHT+IGICBEQwGAeQokG1cjj4Rf+ZxWsyBWgTa5CPadzbCZAbmemyOGd+wy3RrukJJhyfGAvuvwd8w==
X-Received: by 2002:a05:6512:baa:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-530bb6c7bd9mr8720724e87.56.1722913809481;
        Mon, 05 Aug 2024 20:10:09 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b836a804a2sm5572181a12.0.2024.08.05.20.10.08
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so4329966b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKhQAqjruwmRBpygc5tHTkr5sNK4IMMOSpoYp2h9aa/AZp11plHlLxXXvXHCaIAV57th7IT3UZZXjP9hYuHzOmjQtp3w66fA9m8gy52vQkifAx
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus
