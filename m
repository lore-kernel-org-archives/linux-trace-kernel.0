Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B51F8666
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457611; cv=none; b=Fo5YkMO3nLGx1Jeic6Yu96jBJ1JCucW66U9zIY7QUHozZcdWABZ2LPy1mbkr4Hrquz5MH1mi86T+zbZymV1WgvOwrCbCFhpsAfGsQKgtdra7DNirFVN2cSbISVNaGLCYzNJcLWDT7rurYrtcA/REJ/+foaaZfb/JtoLbjWGPsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457611; c=relaxed/simple;
	bh=0XdEASmtmfz9ugCuznpyGWkBxXlxScjrZhwK9HX/gI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfdcV02EgG3lQTgsSTnOft9ragLxfjmujVbmf5tmWVMd6md6DyeIcEt3HOwoh8t4B529mRwL2WHWYRhZb1jTDfFETCo8M9ZrLejCmjMhuDjjM+dFkyKCSpLNdZOfqIuZG+DJuIWi+3FiQMtmrBGGU1Dgyq6Z4C0a5XZZudqjrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h8D+aXGv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h8D+aXGv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6aee68a57so819553066b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734457608; x=1735062408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNjkq2KN6DEBaEhuyWIj4iGu8iK40oTJn7fFygqcUbo=;
        b=h8D+aXGv/l1hkacfTj1q8+LfAiUXTKcVt7GFAKNdfQ/fDNux/9jJ3xi3M5PyYBnBmM
         XtWI2A/ykiWmljz39CqCW2pc8zhn1e3DadJ4tKDowAkwI7hoaa+2cwGbHm7kbbzyhHpl
         SXtZWkHE3KXOqU2qPQ4FRi03mXWInXTmuSLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457608; x=1735062408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNjkq2KN6DEBaEhuyWIj4iGu8iK40oTJn7fFygqcUbo=;
        b=cua5gBgCcObo4669eig8+gbrb5vnHOxaKxzHWJfDiDqoko1iBNt3wyZIt/v9b/G1EZ
         qBtpPbF7EwV1CaZFxQeKRXY8zvzT8+z8oTVuIX+qyrDQXm9KTkyOAoTcR/JpAMgAWab7
         RUfCvZCX0j3nA0Fo9y6g9h+o7sW41KsJkkenF5r5iZTI/DIG7ds4u8XtA9hSr02etAxQ
         TCpfdGmdpUZ8PjMcyDcysZPMDtH0A5rHM2GU/NbPIMLcfSN3RWF7aNIv5sOjMtScKPEr
         /q6Ftb/e3ex/i4lqTBAWsfemhebmm876nPFzHImsT/RqwtCAkCDri4I5pMJGfV8dqi7l
         Dj5A==
X-Forwarded-Encrypted: i=1; AJvYcCV42Cj6vL5QJDNZyxz4T8zgD7+5OHL97cWtYcXOwgMCFgAgp3HK2yD8wWBW26otZi1AltaxN3T/eX89N0VK3Qn5Yuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdeERmKQCqzGj+W1qSfD7W1AqhDY3RaHjUbIcm08Uy5Ipj4Fo
	6QNT13kvFdKUXeo3emDVp0z1MySnHBNxSM3xi/a/rNYSoDOBIOP+mrAoqVWNZLAq0lknpnBE6EK
	X1p8=
X-Gm-Gg: ASbGncvnV5UjcvdV87pZsxbomkmtzWxDVuPwXoqYWJSTM3fzVMysDMbEV8MOGkRoTFI
	8sgjzUcubCh0RBJmhd1MuGG3D0BkVzdW0n99x5VC6CJSTUA7BxtZBdKBZFLOdJxhTDUqj6KUzAp
	ZAYdAayHyOD8d0Rpt8KY8h67uG+irhUy77oIlqtD1eM19P1ImRNDf8mVsk5m/3cx4xcv8+s52ye
	HIU1yVHi5JJYrukKLMUwlcR10vH7Q+6hgmFoacadxPZcqwFYTBjeKHp+NgomJms0rY1zO2wxW0H
	NrjFppi31noSvy2WlkEYB6MwWY74J30=
X-Google-Smtp-Source: AGHT+IEFk03Q+LdBMwIOy1jg6FS44UvjYsLeQ2YRlsUM2Wntqs5kwHr/W5YWH1tnUDxFmCFr16FeDg==
X-Received: by 2002:a17:907:9712:b0:aa6:90a8:f5ff with SMTP id a640c23a62f3a-aab77ee5b69mr1579277166b.50.1734457607654;
        Tue, 17 Dec 2024 09:46:47 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635960esm472818266b.123.2024.12.17.09.46.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:46:47 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67ac42819so903761566b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:46:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbvPv7JNN1adge3HxEv/QpcO9iv7JurvR5lz+TdWqF9auiW04C4D/0qHX45VT8m4d7XS+ndz0Q+sSEdlAicjROkG0=@vger.kernel.org
X-Received: by 2002:a17:906:c102:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aab77ee6592mr1643616666b.53.1734457606608; Tue, 17 Dec 2024
 09:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
In-Reply-To: <20241217173520.314190793@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 09:46:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
Message-ID: <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 09:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Add uname into the meta data and if the uname in the meta data from the
> previous boot does not match the uname of the current boot, then clear the
> buffer and re-initialize it.

This seems broken.

The problem is not that the previous boot data is wrong.

The problem is that you printed it *out* wrong by trying to interpret
pointers in it.

Now you basically hide that, and make it harder to see any data from a
bad kernel (since you presumably need to boot into a good kernel to do
analysis).

The real fix seems to have been your 3/3, which still prints out the
data, but stops trying to interpret the pointers in it.

Except you should also remove the last_text_delta / last_data_delta
stuff. That's all about exactly that "trying to interpret bogus
pointers". Instead you seem to have actually just *added* a case of
that in your 3/3.

           Linus
