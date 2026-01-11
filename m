Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3034C830
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156603; cv=none; b=H/ZjYJjStS3IDb6xiqoJ8wsaFcuFeWuc5TIVh3H97YSFWbkjf92Uu6AeEO0GU8mXDc4Xrp1JOWGWHU1ERhmD76aB3ItxCTI63Rt2O73d5lxWlP8tTIVbxFV86UDnSK0QP0gjofqdEfzy73H/L3W7paUsL/3FeETaw9Q738xLNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156603; c=relaxed/simple;
	bh=s/2mrktI9Ze/2SxG4pvtO+MzDmST8OXEJGxy5Z2VVIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9Qtx2LJeDt7egqxgbFYo6UoddrrNi2EvQElP3F/KsqPEymttGaySgkGqJhHYVfHy/O0/MOH2LaXpdekMe7R3Bbn1DdvgaoYsuA9FrmB2HHMbT0xQyf87BW41jXNQr1GudQGY3HpQUhEI26kvpN1T6kiVMFtySNKrdyFKqXCl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWfSZSG1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWfSZSG1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b175c4bb64so326683eec.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768156601; x=1768761401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/2mrktI9Ze/2SxG4pvtO+MzDmST8OXEJGxy5Z2VVIo=;
        b=HWfSZSG1DwyI9KgyARQXYfnU/eDoVYzZ2+lJv6slS3YX7/MEg1Y3agCltHqi1Fhykz
         9s8S4q6QUaemnKzxMEwvcyF2Yh0dUZwPOQlS6CbI74Q1Gzi5VHuGlbxh9p1/8rwuOeCz
         t0uZKU5Zc1+VtzyCieUAp81OOukusrDCN4hgozLjMrdV5fSDRkQT3LTbGyEYrFHih8rN
         eXSNqXoyclpPZeNzNY99/w5aljydAW/+Q7OmLetUC8TQ2GKQauIzGd678p6kPkIEF/N1
         b8mbqyex1+W6Y0fS9tL9gGnEwlIAVKyjJy7QvdASWcSVoGKF5/WRz1xBL4WA3/cXHG13
         4tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768156601; x=1768761401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/2mrktI9Ze/2SxG4pvtO+MzDmST8OXEJGxy5Z2VVIo=;
        b=ME3lLaZ5mYphM9n9vrvyw8KNAAR3gjcP64IQjIMH72XQgCiFPWeNHXt/8abTBzXQ8o
         s6rqMZvT0doOLYPrW8cjKsoBK2KMRIbzwrqfGlD/Fzd2QioWnamz1KZtR12MH62+En5I
         tJkL1oIX9E9lmqKTX6c/12c0+Rj8kEcN0oYWnm1Lcyf2gG5XxWr0S2p5QFgbfV7sIzjo
         IL+Fbn0vxa/JZTAHaF9NbKSAiY2aZW7v56YZNNkcBTNwttmNCorofcS4elDfWR88FzAc
         RE/UxF1p9I7X+SmYOTEfcnBesZDsuzxWIOwtaXYqMju4uwcNtm7cg66ct+rqN4m2FHEP
         lHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHl0c3pTA/8nDUpwGlufI5Z0+5RcPkSltJ4xHs8SjfkuZr4a75JiuVXxF8+O3HkXocKlQkXuaFOatZodmi9w7Xlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SQGj+zCqVUmJclyrAo8aseAknVhPXSRXcXMaYUn0MLeGmBoq
	Jiv937aGfm6XWAQPOp4ub3atAgONLPRpqELUQJBeK4/V3OCnVhxN8m2pNkNhATczJP5yBrotSPp
	7lte+DyDydEQoIbbhYG58j93gIp+Eq/w=
X-Gm-Gg: AY/fxX4Uk2YRbk2mci9hStPWwtC7usMFJ7I1H/GpM1w/jhdmrHC2UrK/gAg/UvGTjSo
	+NVSkDqFdzoBV5Oo8QzirmbVgvhp+7MTimqVSwcMzIyoQtQSW+qJdusTYKn7etfAEgplzps4L7r
	sCwfR4H71Y/IW/dhXkKLrqkekKHyousGocSnbSBpgw8+QDyCUmrmxxXxDqsjKa/HoI3gi9g6bp3
	4qXXjMxpe0MGylncgigxXr8Vqrxx+C5v6j7fepAtflavN/UykVyMThwbyLiEa51xFOzLJYGm0Lm
	Sadw3mQ8FFZYHQm8Cg0sxRAvVH5IbAL9rFer3vDNdkHxvuGlMQ0qYK52ubHsWbSNVJ4qB/PtsZF
	DDHbBMBNvs297
X-Google-Smtp-Source: AGHT+IE4EwaPa9ooRjyX4oxDU8VuHQuoSPv4fj7pnzy1JGMxtuVoPjp77WRf4mi8/tlp22EgG9bSonPh3MCxbrBEs3I=
X-Received: by 2002:a05:7300:e58b:b0:2ae:5bd5:c241 with SMTP id
 5a478bee46e88-2b17d33c615mr7255089eec.7.1768156601499; Sun, 11 Jan 2026
 10:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
In-Reply-To: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Jan 2026 19:36:29 +0100
X-Gm-Features: AZwV_QjoMCnwZkgR_IdVUEJ9xXA_WXm00K5QWe9g-cTbHjbniGvfAm82AqWYloI
Message-ID: <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> I'm proposing to include them under the existing entries, as that seems
> like the most obvious place to include them. However, there are multiple
> ways to do this. If you prefer to have them elsewhere, I would also be
> happy to create a new entry with me as maintaining them, or I'm also
> willing to be listed as R: under the entry. Regardless of how we list
> them in MAINTAINERS, I will be around if anything comes up. Let me know
> what you all prefer.

I think this was meant to go after the `---`?

Whatever Steven et al. are happy with, this looks fine, thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
