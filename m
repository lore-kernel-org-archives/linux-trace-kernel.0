Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECF1F1917
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464303; cv=none; b=PaSe8cnjpA/kFd+gJXxw/VbR7unFqBnaBLNu8qTZkwTCctgIkVyeJ6kYXaPiDVrW/sRofNHpSxJVVSAReDk47LfRc7krbjvXcvflvbMiX/OSAo7xXHV8tHRgPRxjGE/rKRAxXvtJMGBUBTNwFdw69A/HbaizhTIXiofHehqfAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464303; c=relaxed/simple;
	bh=BlX5PFVtVorWrjZZejf5sVJZU99ayY7KutQE4SAHvtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4OH3pF1Yz7Y5khc+vZs4B9YPxmKQ+kcowONNfssCNnnGSqLOFqnIGPvP3KQkCgG6u7NXrTECO3wi8DMSyJE6dp94XECRbV/8XsYJWS1tUUyL5oqhN+U5yLUrcdsZWwV08meRuw055XOmgv8dLIcx/Fu+6BhCAc7NsSLhA3jtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=awOMHWXS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="awOMHWXS"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso68369a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734464299; x=1735069099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=awOMHWXSH8tMTe7l8UF4WqLJn/AqsmzwUz03RjNJ3xwQVEkM20GsVnt1zX04iaTXbW
         J657jqG2wwM7Z59qdfNKweuw7CM/fhNSGZfHUom5xGeeYaScMtiB3lFLcVbt+EDhFaln
         IL8QEqCnqlqqQDM9PAqfyqeNdXPOkTNwJ3Lq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464299; x=1735069099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoM1B1YX2SDxMKP/fkuxJP48vkpnRndLUKOmCSwzkQ8=;
        b=GbhtlWdrJLaQJQS9I1AofTaGmnZ1DQrqkXnI+FXRdI+EvxFzlw1xuTHT2o1IIXpxz4
         awU4s4k8Ah1jRcjF/a5fjceMCK6tI+5P5hr9cccYVTv9eGw1Fp0DtIXYA5bl9lrtUKX4
         +YAPcQBS7+HccLFbXhd4QrFGor0/Ou8AQL+ZfIlKI1NxMBzrg7MBYAPySD3uzL1xjjCk
         qTIZgfvRUKsQ/+KiI0V3uDiUr4VVDLO5HRH2/u7LYATOdecyUWLMXMmacA7gDdHsEaZl
         3OY7g9F7/Tv91pzWe1ChBbsS9FVRXWJa+POY856XkII5nYPM1ufosY1P3GoOStvcbpDp
         FmdA==
X-Forwarded-Encrypted: i=1; AJvYcCUqkkpgupvFE1nYKkLWY8yseclT3mdksI8hDx+hLWK/z8PGQ/b+jFwqaZ2wSI8PKuRYvNtWSFBkq5emz+M/qd7XdXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3VaWFTzQTYQjjIlIAZ9SXDf6MEH3HdtJCD1NwUevIMJdt1X4
	9tJiRsa2hoHOZeMZfysnS5VlUypth/A+Tn6fCu9pvP/eiCbNZ6DcbKwNtgTa/XThi9ATGLlNlmF
	Z4ws=
X-Gm-Gg: ASbGncsm274O6zqq0z3/ew1Guv14aMrBW/h/nQRijgTwQiP4DoSsV5bZovPAGLPlUTM
	6YrZ/9g2EPu4QG5wanC59RzNDOB3lO3xA+MrYZytPzra8kwyj+Gyw/bLyBR7kP9F2mFobV8E7Gk
	4nncOvW0on+g83NbhJbPVsIThgyxddfnaVVQneUuOvK8DzGNy4b8/BAe4+ubbIC6BbAq9n3jGjG
	mNpjkv739Cba+asno/Ohn5kPB7e3PanM4HoPzYTVBWRdRvrF96zDeh244dFNl7j0YC7io7iwpVC
	ayHKkxgKfE06U1j+rqrHLQCaeVC3n+Y=
X-Google-Smtp-Source: AGHT+IG1+L1rXDCg6YN74JEfPjD77Xmaj0M2sad1DNPT6PVbYTp1iUTv+tW3MoN6FniupUmtD+ybvw==
X-Received: by 2002:a05:6402:3715:b0:5d0:e461:68e6 with SMTP id 4fb4d7f45d1cf-5d7d56348edmr4650477a12.17.1734464298917;
        Tue, 17 Dec 2024 11:38:18 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae14f1sm4567558a12.52.2024.12.17.11.38.16
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:38:17 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa662795ca3so5877966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJOMuHJtMOubTt+LeQ38bAYnPgbVZ/KBWHEOHaxXtkRbGHX9x1JbNWmRFiWryS5Vag7uwePrBV64pUvEGRCiYpQTY=@vger.kernel.org
X-Received: by 2002:a17:907:608c:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aabdc8bd564mr467326366b.17.1734464296273; Tue, 17 Dec 2024
 11:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home>
In-Reply-To: <20241217140153.22ac28b0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 11:38:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Message-ID: <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 11:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But instead, I'll replace the text/data_deltas with a kaslr offset (it will
> only be exported if the trace contains data from a previous kernel so not
> to export the current kaslr offset).

Right - never export the KASRL offset for the *current* kernel, but
the same interface that exports the "previous kernel trace data" can
certainly export the KASLR for that previous case.

> Then, on our production systems, we'll save the meta data of the events we
> enable (this can include module events as well as dynamic events) and after
> a crash, we'll extract the data along with the saved data stored on disk,
> and be able to recreate the entire trace.

Yes. And if you save the module names and load addresses, you can now
hopefully sort out things like %s (and %pS) from modules too.

Although maybe they don't happen that often?

            Linus
