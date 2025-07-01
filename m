Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9578F5D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Jul 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335594; cv=none; b=m/0EYaUYqjYM9vDtS/naxIDj+YYAnhwV07QtOHAyOyXW1z5CjhJOuyrS3S+E3K/RAuRLKkKDUfiMFaSWPAuE5klhwQGng4AqeHvizCGdiphRDqbdyEVyo4981Y1DAZIm7ihyMqu/LMm5tjOB0CB1FKthYBbW7f6qyd5KXnGmpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335594; c=relaxed/simple;
	bh=XrwXszs+4CKh3uvk7NsR2H8vx1ReZK1MCq5Q7S9Pyfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGf9jWTLCj7xbtsMtKyPoZ5FTMvXP155mENPEwhnNn6HiGweX0x6oPifIPq/VQNOQmT4eVbUTzqIOxfYVFttEA/B3kBWtlnRqNEyYEKaoL5b4q+6tFajMhvUwmLABYrZnOZUVhu1jnyV4T3SIRKAxS6BEZWw6ariYYN1wUltuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FoUNe/L7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FoUNe/L7"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad574992fcaso465015066b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751335591; x=1751940391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fN4lVWlc90R79Gu5dER97dXUSpIGy23I1H05DCfQFHA=;
        b=FoUNe/L77KQY/JcKHutwuE216lXD2ALSlzoZv6xF1E8HCibUylC1YE+eiHLxZDZbG9
         siEPqcZ+vhBXNfwS4SKR3NrIMi6uAdsWKzzj8NO/7p/D9Dx8HzmeJRFvZsCoTUpZQSIc
         I2dPxkMe9tvrpttFpJfQtKJj9VGcBB6NjZ0yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751335591; x=1751940391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN4lVWlc90R79Gu5dER97dXUSpIGy23I1H05DCfQFHA=;
        b=v/CLIZEQaeWHrJoYLtZBTpseu+tUlAXjStoGYG5N7qZotpsy83bYBgGKZMN69Vjqs5
         Oq1WWSlE5gnWAN4fSedxjoHWHpaOHRoV7gAZielNgE3CSXKzPcqBXff7R4shjjplFExg
         ZR4MfVg66CXnvoKnNiH2KKYz6SkltH4NKU79oLba9CUTG6OVvoC3MAQWnx1N1BCD2Mg8
         pCB5lRvYBGxW9Jxr8xp5Q5/vf1WOLL8/Wn4XAuvdK/Bu2TyQlNMwHKewUZNDD9zQK7Z7
         I7426OkCrcEyRXIMkQklSSOQvbIZ+rXtyW3IT584m5K1ikeVu3u23lW7k3G3xAMD+GHq
         g2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOhQD6qHAtyr0afFCIfowJmHXjIyR3itgR2YNsA+ZQKZ8IdUfM8jQKkUtdDM6GBXyL1CfWgMB0PIm3ZpXiKwu3+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWzBx7A549s5KQ7vbnBggnAclhUinUdfoC7bBoorVZfoujO0+
	2nkMUzdRCG9zal+HsKK8TSC3sWAe8WBzTS9TpmbMFiJh52KfM0HlsaICFv0yvuZAcY3azXX6IyV
	NdM9cuJ8=
X-Gm-Gg: ASbGncv/GQKzGJYX/1uvHJg/twVKYv1WLpJKnFWQjqrnvvkYdZFSasXpkw6pHvkkreN
	E3FOFO4ScirMdl7d1eBEW+ppPxk21DWX6J+QnOZwCLZ6jJCM23GmU4TBb297gPc5ZHjtPQpIoij
	sfzsdikCnyqTwkvYfwCNoc8bIgEwGCYfQ8C/TUnXWmACo/8z2+8w2lbACefP2d3gpogfcgVBw/j
	tn0XN7LFn14yKANWUWGA1N5vzEcpiEnf0N7Ri2+uD2PcT5JqawK6evo3GFUtzGjLkyCUOtghaaO
	VxVeaX2jgxDHEqgrIaZD7UbRmQIpAWn2ZJ5LPTWqcQMGrTM08dYiS6I3gRoX6JvE3o+k9KppXfP
	Yc0y4Jle4x8ci2F94xzgDw2quyumVpmKPlBJC
X-Google-Smtp-Source: AGHT+IGNQ/X1hemK+iacAimAfU1N1yyk7hKxv5Jl7pgZqzS08kbUgA3cIepg5q7AHczgTS06CI78Vg==
X-Received: by 2002:a17:907:c807:b0:add:f0a2:d5d8 with SMTP id a640c23a62f3a-ae34fd1847bmr1454201466b.11.1751335590975;
        Mon, 30 Jun 2025 19:06:30 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bce2sm760600766b.123.2025.06.30.19.06.29
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:06:29 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so3341932a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:06:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ9fHabbjqiD2vEU3MFq+bpmuf1wZLQ3J2LxAhpL65DpeBRZ1PcJV82oHYesLOqGQ0e78o54nAsFaH3IJ7vUAqQo0=@vger.kernel.org
X-Received: by 2002:a05:6402:50cf:b0:607:2d8a:9b2a with SMTP id
 4fb4d7f45d1cf-60c88ed9d2bmr13448124a12.31.1751335588910; Mon, 30 Jun 2025
 19:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org>
In-Reply-To: <20250701005321.942306427@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Jun 2025 19:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
X-Gm-Features: Ac12FXyRoMfhGWW7-qb33RWCFdUsK39k_kEcOT1weCLo6TBUE8tUjRhvy0zUkHM
Message-ID: <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding infrastructure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This is the first patch series of a set that will make it possible to be able
> to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> doing this.

You have a '[1]' to indicate there's a link to what SFrames are.

But no such link actually exists in this email. Hmm?

           Linus
