Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB627F4D4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208355; cv=none; b=j3M7425t5QwIx6/B1vLYMHivV4wNZ7WQ0U6wzJbQgo6p47X2kSm8ZbaSmjz9Ow/6iDv9rJSYCF/w/b6sie37ONrHDDeIy1WQs+2YacCK5MUzziNA3RH1p+jMalCyNVjilrN6avAyKke9VkLsacyIJp4rQ04fJ57M5u6sRHVfLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208355; c=relaxed/simple;
	bh=67Pku3+c2NeuyySmqR1lN0RI6V6rpW8eqkqkN9fw/q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcE96c+l7mHXAaOrZ74nUs6GFhZqV7ZVzN8RSEot9FHGmhrktBZeE5uSQDlc+Bu6yu8785k3HajIWxXjVuSDeCkU1KOd/ilBXgSgcYOGhddH0nLZXxmXbLrTbQVksFZahUihM2lBgSa6dULf2OOlMCe4CSddf5U4TA0jL/fm8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OJAvp6f8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OJAvp6f8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so8857556a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753208351; x=1753813151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBGZFJ3kbjo9dI0n0oCeE0hpcWFl6M0zU4XdxWUvP+U=;
        b=OJAvp6f8OT0/W+uSc8/DjSdyujx3CxMuIFlCVFER1J2Bt1721V3XpyGvatntS/CO+B
         ga0ofaA3FwaGSxiK8QMoKTaTAGiDIVq6DVFMMee9sAIypmh+8T1Z/z2JfoiOrawUgRH0
         Uksegpw1d4kOUEV4jRL0txvlBlY/Ue33w55/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208351; x=1753813151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBGZFJ3kbjo9dI0n0oCeE0hpcWFl6M0zU4XdxWUvP+U=;
        b=fSUj07/siIAZAyprztCAPbjiwPfdvgHPM5dznR2yI5kHJMoJnVZSgq7zdeAtNjxGLE
         t1BXSJxqIQnDpVZdPJq9/eik7Cv0BUH6tq7LMzwjktXtrpjaD4BUZWOl17AwQoenCDzD
         mosS3lA+1wDu6XZprJYY8iNi0HczcpBxHcdizYxdR/w4JFckIae4RHjvlgU8TqXbsFmr
         GXZZW4ZFsWTcgNYh2kiEqBlUQRaKNC9sVtetGZ6FZURO9sd3wHmLD4vEnXISAHB4Vbx1
         qObOM8QxxmuZEy9bp7IzTf7EPu2vS0jQ5o2laoGvOnSpkq9nYr/vdZHzhpJZl9xbMLie
         v1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzrLTXTvAirtkm5dTq/mtJgeCFjQGWekL8e5ErGTSWyT3wtKYPlKuL8vW2am2a7jiyWPtuFyV4yeatkCJRM8+c0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWQZG/1B2hRCXh7/Mu1kjaZwUXI8opwM0EtBSt67BeM1Z6s2h
	9Np+0ES7sgQcByUtIQG/V5eZcR38BU7/FjBOAtcxieBawj3aC+2JQYJyPDESnePIl8JulOrbBDV
	99Wcm774=
X-Gm-Gg: ASbGncsCH8eeuejRaH0mWkUPJKnW4Sro91BPiCsRaWuNCLdMfdX/CLVy9PInT7DWM5M
	ZiP2c4029RMye/N33Q6lIuoJV04bYLeJKnDIpep8hmXsLOHk6fX7q8H99mIe0V4GWjfk++i7rGr
	dh2YXS7ja1tLe633rGAbiDzbFfdoXPfwv3cMxkBeybXSqlLC/4DYnKk+dgXlMXFManZtQ+9jFhB
	xQQY7Y/FrCmE12yfzusyZhw0IWVAqLu1iFgKo00nFqGCtahx6Qiduw9fqC+R8o53cnXiWMKeAKc
	fT0/KhqIkRUY9WRU5OvBjEqcQxKkEpcdrXbhofR5QZpbf63gb7tMkOHjtk0PMVMeteYT6GxjUAz
	TYn2z9KDCDQxzjYMe44ajBruz4pfXhlLum9G22T5Xzk2gqk8Er4Vzx2eOsrJZLTYuoQ1QVcUO
X-Google-Smtp-Source: AGHT+IEXZ4P4F3V3qEaAkgRXIYA5VYltJVWzswH2rIoM99kgH83IujL5OXstAuNSnMh3kyQwq9NguQ==
X-Received: by 2002:a17:907:e2cd:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-ae9ce094418mr2268763266b.37.1753208351240;
        Tue, 22 Jul 2025 11:19:11 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d5255sm902224266b.40.2025.07.22.11.19.10
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:19:10 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0d7b32322so909445566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOio8fiUxD+b9BQwA1iTffRePMEHHS8LsXvwox8ci5llcTHWAxe4wbMIN3EiGY7WlFgtc0UsfUfEPov1qPLj6JfEY=@vger.kernel.org
X-Received: by 2002:a17:906:ef09:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-ae9ce0a4611mr2382909766b.39.1753207954651; Tue, 22 Jul 2025
 11:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722152053.343028095@kernel.org> <20250722152157.664260747@kernel.org>
 <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com> <20250722130429.7418520b@batman.local.home>
In-Reply-To: <20250722130429.7418520b@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 Jul 2025 11:12:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgSradO-F6XGH+fRRoO3wwzWjZ_m7Z+m2aTVPxwPrsog@mail.gmail.com>
X-Gm-Features: Ac12FXw8Msp8bQOIa9FS5M3JcUkZEknhZa0tiohcg9UvPiSIpJJwczeZXsjNy8o
Message-ID: <CAHk-=whgSradO-F6XGH+fRRoO3wwzWjZ_m7Z+m2aTVPxwPrsog@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 10:04, Steven Rostedt <rostedt@kernel.org> wrote:
>
> I kept this to verify that the build time worked too, as the runtime
> check is so much simpler and easier to implement.

Honestly, do it for your 8own private verification.

Don't sent out the patch and expect anybody else to care.

The static verification may make sense. Adding code to the kernel just
to then do runtime verification does NOT.

This is not a "criticcal correctness" issue. This is a "help make
people not waste memory pointlessly by having tracepoints that aren't
used"

There is *NO* reason to add kernel code for this. Zero. Nada. None.

               Linus
