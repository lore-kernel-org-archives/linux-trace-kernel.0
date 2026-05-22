Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5836728D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475881; cv=pass; b=fB3ofRjKPsRwVOlWRwieW6UHslFyvlIGiUR09MPS+Xll+atydUk4SGQuvB5173Kflu/+mVqJlC5wzNg+H+/TxbVooQiSq3qKB7P5CTlBdREf4Qnb78VW60mESqqVMoHd52atHcQVBSU72pMVGzKv1sKMjIwvqaIFSTH6i6uywrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475881; c=relaxed/simple;
	bh=9z43nsKfJPyDKxJZ1fFGdLcfiKwE6x911r+pE9P8b1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aq89YuqmYJD2Klj+osNHiWwNoRYpnkGNkwqFRzJ27d3bno3tfO2HAZs2PvHRGUhYZvipyqy2nfeHN3GzG9ZUeXftfJ4/Km0ItxWslci5wc+fTe4T/HGQCiAN8V9FQ7ZUZa3/yKIggCtIvJ5F6S3JRh5GyJ0whP1nH/RfJgy8TAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjWFvhQ7; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjWFvhQ7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b4583f0a1aso52689905ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475880; cv=none;
        d=google.com; s=arc-20240605;
        b=g0XRWQvlhuVpBEsM9LZpjNuXdL3QVN53wS60Ob763TpJUZdFifCOE9iX9Eb5RON8Wc
         muobGzRN/uHKKVLzdsom3mXHy9+LB47f6b9QiuKCAnUn8ap27pbSQhYabHMQ/mDmIbYK
         O0nae8mrg/xyrEEv41clt7eM7/OO1GVJUHrr8T+7zsoEuGQ728vlWnvdClKph/WG3Ot/
         baAgpwkGZC0/UQMzsB6WP6AXUdoWiEesf+cz3w4EtB/ZTGQQnxrunO5pgRgY4upKDE+Y
         FOu7CiE6LHsVc9sMiVgatz4zGUXbt3YH9vsChx7J6KsjrV038m71jQpBiYEmLUKJ/8gt
         bH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        fh=7t3ipHShYUrlT3HE3/ckzHlI5NzKMCcTyQOTTAzdE8M=;
        b=iw0ewMTrYZLka+mRyvJTTqVFXJkBj1wHsJRlOD5gOPZ0pNAphYsV4gYIa2CRntw3He
         Xcen1aZLfRjkW6TKz/5NtL88JgTpJkHshMlVLDJk5Lp+xaDWZY5vwHXcEnzOI/xMe0A5
         4R4kqHc2VqClBxmeVRAhU1LrxPa8dynYb/xZ1+wmtCa7JON8+AOhMReQ6/RC8l3oXamn
         w2weyR3X/6+A5hJg/vWIIQZ062pPYTB5U5RXcZf+tSvWSqmtnrChhmfsoB+0TWY04wD0
         ea0W+D3Il08x06C//gghaj5mJUDFRCy+1hsyVwJ/2R6n17KBUlUmJtoSnM91MvBzFKCA
         TX4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475880; x=1780080680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        b=qjWFvhQ72bR7RNCY0TKHMrzNKFH1kKR5qp+4QiD+KVVngsi6IySw9JoWJ25cy6q/KH
         iTbbMow75WeLAML2dDtEF/EaGy3RQW7MmlrvYfgdSCLduJUtaJ6qTuwh3vafKb/hl8c3
         FBwSNhSgKeq4c69l4d7rWzfrjs/Mj1kf8n5mJPUVuwD84WJrVpt8NaIIbPO7HzWCeiuA
         O19ldELI9hXz0k4fs4xxQfCb6AF64HHTzv4n24YZxJ/Ri9ReKtldHbzpn2g3u6HIPSQF
         9yaDGY6akD6t6baAa0Qb7nuzc86tLbouEJr5o7iapzyTEtgAoLlceWYs4I6K2uKpc251
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475880; x=1780080680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        b=BxKdp8ZfOfSeVz0D24hxNfLHeNnoMxJ0bOPFTI1maOVkK53MA//ithHtDD/e7dOSpp
         RMHX0n3zUf3C4MHpXYKCAyUYBzu6ldXY/S6gksTRT8NklwM3ElroDWgW1C2+0SsYypjD
         81qaRYJpNt1HIZbZ7uRiiehVmJUGs2EChiSs7UdRp/JzJz2sG2ks4eiwRlo97EQfqWFZ
         NTFyR5fATfL8Ak47WW65kAMOzPaZnEhCcne7L6K/Tuk0eB8nM7rZ9y9cmtMCI6ZE/DnV
         Jml5xE6V+78iyEeMuWaS8tMqNiiAgb90OmyR/9DO5e4bh6FFH4riheLakGQhn7Ya0X+s
         6bMw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q96QInxL6ZPBW5uRzaq8RN1BGkz3oyn4hlFjumdt+ywlZnQpFJ5UiVO6ryCPr4VPwksKIGTH1kPrh3pn5f1LiYyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya++2hjCxPUCJu+XjhFe2oNc4tvmrOxjQ6APFw7aUeKJRuPAy6
	p/SsTIS7U0R81juTfhiEGWzQuccXtGLBgX0KgvdcFPOxuuUDt8Pw9lwgY28ZkTG+ASeazQil/QI
	XQLiDy3JoJ8Rmy8nvpjosUhxtmkzKbDQ=
X-Gm-Gg: Acq92OHIxSon3OjSSwRztKT81MadvngTWW90+J4d61vn8QkSEFngsgsptppj7VlTu9l
	XIKxW4PKPNa6D6k9peDHsOI6/6bOPkQw8F9j5L1jJPZ8NzQRD31BQCAQHhRMLRL1c6sRk3uPuD5
	EayJPDQ7lF9LARlpl56HDcyXzE3dhb5fM/lNqnC2/KNSQNjU/PqXsDcdi+e+wxvscAjB9HevC89
	wqztCNDa0bE2HZrYjstuws+S0MH8h6/ZeOZWvIM3R+X/3KXTig9YP9MgCwry3f0DQwhqxUD4rYM
	SbRbEGxEIvXT0fqBKemo00s=
X-Received: by 2002:a17:90b:564f:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-36a674d88edmr4333745a91.9.1779475879901; Fri, 22 May 2026
 11:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-3-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:58 -0700
X-Gm-Features: AVHnY4KWVpkBrOSue6VVsgOwf2DPF4XM-24nyQisnEZqeRMi2MKFAftQwgEohR0
Message-ID: <CAEf4BzZOJn4ynhqQv+n2L3Cb+=teptBD4jLg5axSXQGD9T9pvw@mail.gmail.com>
Subject: Re: [PATCHv3 02/12] uprobes/x86: Remove struct uprobe_trampoline object
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Removing struct uprobe_trampoline object and it's tracking code,
> because it's not needed. We can do same thing directly on top of
> struct vm_area_struct objects.
>
> This makes the code simpler and allows easy propagation of the
> trampoline vma object into child process in following change.
>
> Note the original code called destroy_uprobe_trampoline if the
> optimiation failed, but it only freed the struct uprobe_trampoline
> object, not the vma.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 102 ++++++++------------------------------
>  include/linux/uprobes.h   |   5 --
>  kernel/events/uprobes.c   |  10 ----
>  kernel/fork.c             |   1 -
>  4 files changed, 20 insertions(+), 98 deletions(-)
>

nice cleanup

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]
