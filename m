Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD61F8925
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459904; cv=none; b=aeNejLXobPH2UCgAg5njfrq57s6IPjJKUxff8scODxjd/LTmHiEUulWcT/NlS1FFsHAa19td4bun5Uat7gIeHmkRqffD07P68H1Y1Y4WHGziOZpIt+COMfzTr8sFiegjs6h84OtiRhCpyzJ5fQlr+ZaiY1LoOcyr8axD8KjQc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459904; c=relaxed/simple;
	bh=N8eTVIG15b8Txm2GjUbLWrnQoyTPsXqcDWfT1rBo99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0D31VCD8+Dp/vD2NdfClx4Iz7WrDRXuISgXDNyYgFsO4v0JeiKf+kr8bQqHp+imumdy8blN3aSP1G2Nbedi2P60TvJDJUiPBYZHEJxfY/W1g2T97j/Su0Qqimy7l6HzWuHifkhLshR5L5Kf3KvftwXxunc9MK3UA8IKFlhrKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CWaon+pX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CWaon+pX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so12071193a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459901; x=1735064701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=CWaon+pXh2WH3naUUPmx9BkpNvqaepXtcHpsn3V7q5DwfqDcXVsTH8n+HO7ayhLbKV
         FBIQZIijkHK1nzR5SNkkHJXZpBcU/fr5XM77KGXy89H+8WLq7ElYb1WlHc6Wk9cy8dO3
         rkAXf9cK4SeSPBLidEKQdIOgh7Sa+iycKjfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459901; x=1735064701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=Bctv6MW9hs3cMblLu7154m7HeWXVTi9XdclHTTqlnCMvsRnBox5OEFHIw6PMJt8xFc
         l+d+7cIsatK5jgirFs5hvdgQedRPhKziU/yxYgwXNY2JmdbVvYYGmKhSJXNB0im8aTOF
         zKOOnzHnkP8toZj5ixIo1L6uratx/FQy5bgx/i4ofccRbilkAdNcup9OZSEtcCZif5SY
         9TkLPorEfwH150VFT4vhm26i8crIBki4fKSwXMR9NujnKdmxwMZ/n3aX5IVRNpq5m0ei
         1tJcHQP94jxs2x3hdONZZWoQCtHOruOG6u+Lxlnkc8fAi1/+JZO4BvR+UM0Bz5Wc1bdy
         hmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWsEOwX+G61KpoYSPd6Qbn+l4oaesvQGnt6cKd/DXNvoHuttjO07MWNJUFwd284i8NSQfUlcJHUnDPcSjJx1t6ljOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1RdZguV+ZpEJMlnq45nQed79Z7Vrs35Y8SyLqlIGvpW88Chl
	JUeJVxoirx/lfiWhqwjqJkm6rJl7QeGyshWPCT8QieeiWyV28KOJUkD5hQEp7zBA4ssGTY78Kf7
	/3p4=
X-Gm-Gg: ASbGnct7XWX2Y8j0lcb+Kn5AH93CeCfyktA1H4ndb27AwF9vqUYj+NTl5vM8r0m+Dk+
	nEhoVj/GbIp9GoXOA61U/h/S3r7Uvu8Jkvl8x9R6MlGeCUEyKjwFQMeTh9nhe/95XAiRp3LdV9b
	ZntuzgceLynGWo1rjiEwQKS8BPpsrIKGZkIo/RUwmCKyZkVO8ckW7/D9TuCW5A6BLfy0pIKz2Fn
	cTZf0kBs7oaYbkcq4FKo7yZ16DdFpEk76BDNh5bVdTi2H6PyCERN8RTdhJPeAZvwmYUacCxfI/l
	AeK5craC70pNAIUz488gl6lkbmbqrMU=
X-Google-Smtp-Source: AGHT+IG/mT6qOE1dce0B4vleKsgs1yM8BAy4Zg6EBTkGM762KI56y1FBvFwh9w+mqs7kiwt9686Csw==
X-Received: by 2002:a17:906:309a:b0:aa6:9eac:4b83 with SMTP id a640c23a62f3a-aabdc8b28dfmr402566966b.12.1734459900377;
        Tue, 17 Dec 2024 10:25:00 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96087b41sm466596166b.87.2024.12.17.10.24.59
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:24:59 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa662795ca3so1272376566b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:24:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI5W58CP2cYgKvOm1RXOAAcb47/bJBsChtZjpdRFXqV9x0FfIpJ37MNm6ywp6GfDx12TGOPPff3jsN9MOpMijjhWY=@vger.kernel.org
X-Received: by 2002:a17:906:eec7:b0:aa6:841e:ec40 with SMTP id
 a640c23a62f3a-aabdca5bf6cmr338877266b.26.1734459899304; Tue, 17 Dec 2024
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
In-Reply-To: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:24:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What *woiuld* have been an acceptable model is to actually modify the
> boot-time buffers in place, using actual real heuristics that look at
> whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
> of the previous boot.
>
> But you never did that. All this delta code has always been complete
> and utter garbage, and complete hacks.

Actually, I think the proper model isn't even that "modify boot time
buffers in place" thing.

The proper model was probably always to just do the "give the raw
data, and analyze the previous boot data in user mode". Don't do
"delta between old and new kernel", print out the actual KASLR base of
the old kernel, and let user mode figure it out. Because user mode may
actually have the old and different vmlinux image too - something that
kernel mode *never* has.

                   Linus
