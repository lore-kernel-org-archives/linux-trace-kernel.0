Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA21804A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561879; cv=none; b=ZECxu6Z1bP8QEtHJfpha8FahntyiO2UP+OhC2UhHNzYDlduYI4p4f9Bd0lHB1SJXVSdsMprnrx6deWD5+5dOALf5UB9eEi003lvhfPvvDM1vfo6TlHmQg97928t4ukVRebO2l8K8XpU653heirmngnVkTEHbinJRXkguYVqSSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561879; c=relaxed/simple;
	bh=F2cRwTeL5Q02MUSGx0I7upITT+Oj9nP6G9v3ZnYL8d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvs/uFKX4bcvJSW23cP9VU+xZjunW8GKulK1kyuPH16nzuBo6f7hEiz7F7TiY+PjgJgxEw8XPylKIySfjLSJz/NVGR6A6DAImhTkcbRhV6j2hXrFKjyRtSQ7BftqDSUA131iutGAd207F1QIqTvQIVgpYNT1lUYeyl6E/w7K0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KnwLr/Ls; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KnwLr/Ls"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso18353366b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751561875; x=1752166675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPbWJ5gECIxcFGRGN+7adOfD7zhRX4GszEmCOYZfHT0=;
        b=KnwLr/LsNUolyvDinrwhQB+usO5dGsNN9tJU0LQIpONhFKyMM7Ma/58lVc0nlvZHPg
         8wBxj7tt0Sbbxu3/rWS+bLtGqx7byDBi9Y/1fRHJ5/qkIy9DDamKo1yWSE6ehpQBXXlj
         aZIaPo36SnTEc0DBcYBRt1d1AMfsmdR9ySq0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561875; x=1752166675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPbWJ5gECIxcFGRGN+7adOfD7zhRX4GszEmCOYZfHT0=;
        b=r0zm6CQSKRd79faLQ9WaN1jzX34TyhiB+dUhFl1fZIwpoTccl2zOHZrC/pQt+ZwAhS
         KOsO+LZF2EsjFxlXof3FnuBODPGThH25Pr5wVVPamtQqUTzHm/18m7vULK3XnhVaHQoq
         V1eHCTOMaT3fhxU4sciYhbVBIEdV959RrOCKv7UgPNZEKF8FJ2hGlXjqPxEtrDjbntBE
         wYoSoIypXcegqQuh6FrG7Tl+N0SRwZPHKiE0xLd2vMmlFb+R3ivDj4TlwskjfANvqQ0q
         hwINue+DBAEnwaE5MhnePorrYqAAp0KG4nvgtq3nWTODEoA8XaW71LP4RnNcIynIxH08
         Lb1w==
X-Forwarded-Encrypted: i=1; AJvYcCVvgy56F0hj+k2tO4Zc0sGevxH+1nlMNLp7usNn2TLrpK9i8uqUJC19yHm9GsMznK/NcWy3kSLfzVr6BRuHELjNJv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoW5JZUfKJwHI567qCZDlwyJ/gg+Nj2UK5l01BLgLX2W4cDACJ
	jO2EuMX3nPFvIHhXA9e9S2dl22HaAAWx1CTsLcKg4XyCsd7LFPU3wq/FPLzyzP8g/czA2q6DvOb
	wSXu5wrYUuQ==
X-Gm-Gg: ASbGncvJkrLHlKNbCipxlSqX2jrjBR6SiFpckLREVxmbDym90XogK2D4DlJ4fGrJYyD
	9Y9IH2nGSbmHISm58E7dxHmzgO/5EdEdlKqafLOuudKT6NXUrImt4hlld9aooYokqhiVyc+ETrp
	XZgWW3Jzun7JWzS7jmX8V29tKsRARGokguSsY0PdBGe1mGWT78NmWmeVsC/UFP2PImh6uw2zfG7
	QAF15ysF09eAhy6qIZEQNMx7txYqGnXKojzgmdNVo55HeE1aQJ6aR/rHjloIC8UpdbxJ2WkZzFR
	6hYwA5gwYrqGC2BcOWuQYb2be6ZGyUK9Km1TRWPkQVokA2BAtRW4IoGisdNjUqJvCLoGHAdaaPl
	qQ+rN/FTulSv3vO+tt0ARthpm8Vz32ZMYhuZaUrPvvdmPa1Q=
X-Google-Smtp-Source: AGHT+IE6V/83CsI4vIW3kLThrTAFdrIBjof1V9IxmiOflxq240uFUPkUJDuV8/ETmI46QAqEr9vCBw==
X-Received: by 2002:a17:907:3d8f:b0:ade:4593:d7cd with SMTP id a640c23a62f3a-ae3c2abad80mr853426666b.13.1751561875003;
        Thu, 03 Jul 2025 09:57:55 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692bd11sm7151766b.47.2025.07.03.09.57.54
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 09:57:54 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso18347166b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 09:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkcjwCD50kwgoVaeDvHE4p+FQWUPOv9A8+ghBsaRQXkSgDX33neW9HmW29LjoKLal3cXC8EyEC8/IF/Tmzq6d35yM=@vger.kernel.org
X-Received: by 2002:a17:907:7f05:b0:ae0:dfa5:3520 with SMTP id
 a640c23a62f3a-ae3c2c53817mr841638166b.31.1751561873784; Thu, 03 Jul 2025
 09:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703115222.2d7c8cd5@batman.local.home>
In-Reply-To: <20250703115222.2d7c8cd5@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Jul 2025 09:57:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
X-Gm-Features: Ac12FXx0_b_6E6Blsv0QKfQcWy3HLbRStARf9mJgYWm5joFulPTlFaOEYVysL7s
Message-ID: <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 08:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Remove the prompt to pick DYNAMIC_FTRACE and simply enable it if the
> architecture supports it.

I don't disagree with removing pointless Kconfig options, but if we do
this, we should do it properly.

Because now we have that entirely pointless "HAVE_DYNAMIC_FTRACE*" set
of config options. Which with this patch would be just stupid and
extra indirection that makes things harder to see.

IOW, with this patch we'd have

 (a) architectures that support dynamic ftrace will do

        select HAVE_DYNAMIC_FTRACE
        select HAVE_DYNAMIC_FTRACE_WITH_REGS

     (or whatever combination)

and then

 (b) kernel/trace/Kconfig will just turn that into the proper
DYNAMIC_FTRACE_xyz macros

and when this no longer involves any questions, there is absolutely
*zero* reason I can see for that pointless indirection through another
config variables.

Yes, yes, there's still the "depends on FUNCTION_TRACER" that
technically is a "reason" for that indirection, but it seems to be a
reall ybad one.

IOW, I think that if we do this, we should just get rid of the
"HAVE_DYNAMIC_FTRACE{_XYZ}" config variables entirely, and just make
architectures say

        select DYNAMIC_FTRACE if FUNCTION_TRACER

because the "HAVE_xyz" config variables seem to add no actual value,
only confusion.

Or am I missing some reason for still having that extra config
variable indirection?

             Linus
