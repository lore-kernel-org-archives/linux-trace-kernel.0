Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D71F8F10
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478364; cv=none; b=q9k+oAncSARymEJ+0crSSTiCgoBcXX0kh/H6FjWGhM3aeSJEdZ8A2Dx+ksZf2sbe4Wcu4MhoNIyGF4zQGAAsE/xzM3JWqd56JsfGiTyQsXjXoZfmirXqSRdtW5J7i2hZXlkkKydBkA++JJQgIeKadKLeuLA5AwMeU8gVyzpGj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478364; c=relaxed/simple;
	bh=Mj7k5dGfa3oPLPtKzMGI12Y2IRONSBuekyU421EVVfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1bRY9d74BhRA6soesJ2lQ8BZQX8IzDDXXy1lRb5AUsBrm7xlp9TgL3Advw2gI6884VycdKdAIx51Mk7AmlD9c7bci9X/kkvq/3ZQ1OlfxAKBv8BWzDJ+79LxOL5XeLoH7zaVLnqs7hdcbS2I/CkfrVgpyNsdkyYWAYhvX3TT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KoUG4k5Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KoUG4k5Y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so2891282a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734478361; x=1735083161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8StnlEH6OZ/sVqGukX7lbgEpcDL09QcbZqzfMEHuBU0=;
        b=KoUG4k5Y1QpQemJD8syjTgFlv5JWQkl3KcWaQC2OVdBZDQjUVZMjpmQkIzRLTzJau8
         RMCezGUFIVfUODkavwtgrVpVaH3HGFt/mF5oFMhk8jbqJ4HvtZEtvg/ttTTjw/yDs2CH
         /Nyug0a05ROBMFre7ZiSGFR2qgzTYKjVC1RzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734478361; x=1735083161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8StnlEH6OZ/sVqGukX7lbgEpcDL09QcbZqzfMEHuBU0=;
        b=cd6bYgn273uMJt1762QSJzwbcO/5k/fGQm0ULvd1gDwieH5rsBEEL2FvOgB4MPA8Qn
         xbeK59X6sA8T4/Isrp121NTPTgnAopBGQPMXpDj0h4BwA04fg8l/7vLGGu4FM+vQzxxC
         zELuLRo9MbqYemnYlVfz8Q472bJKpgbfUfxwPAlIbRURLCZ9EYvTSh++R6EtZN6vu3YB
         oJF/3fMuD92CLmlk+yQbdJwPoaQq+r/EXAu5nt7kkOZat6m3fvySPJo3HnlFVHi15UWG
         8nqOGOp7Crg8uyRlJgO3KiaFbXkvW+1xD54It0MsJmyUIkMkHC/0YRX3h52rpplqF96u
         rMZw==
X-Forwarded-Encrypted: i=1; AJvYcCVhZpp1E7i8FQ1/ESmKizaTcZDgK9SNTbQkbOfUaVK1y2eTYnp8mPfTfSCCcntet14q6CHrDGT8kcf0scrs91jowmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l6JssfEhMnwof2wWJu0fHzriBtm2BaoDnyZs5RIeCujR4jC3
	zLqB1PoOBmXPsv1henZAQ8y2V+JajsiNOH4pCLEB2Cb/F1fHV8WQTb7AxcjXxkC93pi1Tfjbkwe
	cZpo=
X-Gm-Gg: ASbGncuM/jPaEpHKj1uCiTnTQRbgIWWGlmG2au7RAeIutsyXSw8PRNmpeCvrs1Eajp9
	g0l+hmOS1vDJi4jzHW/JfHNEB04gc1d2xfz8+eMUGlZ8QtNdRv2ZOERiM5BoNH4XC+jqU4wwjI4
	jM6dsv8AB//U708ZU8/y7ugZAR9y+y4NbzTyEC6ME0yLnpCdTTbx8hH2twNk8YN9K4WLHWBjSS3
	OZzMFvzy73+JbCoavKUcKZ0K8w1QlNtSPi2SSox33zhtIcNufT9zkCYjjTzDaKrrlOXpDWMzjBP
	+cbBKv4rsqlHqrlX3VoKbzjlwg2ZBn8=
X-Google-Smtp-Source: AGHT+IEyZbez310bDRkhkFmMyXPqBfVlgBb+bJp2/AfGHpUFOuuzNLnGcQzEDoIAhD6f51RsLyao7w==
X-Received: by 2002:a17:907:72cd:b0:aab:934a:686e with SMTP id a640c23a62f3a-aabf474841emr45724666b.17.1734478360692;
        Tue, 17 Dec 2024 15:32:40 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b267dsm490508566b.179.2024.12.17.15.32.38
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:32:39 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso9746637a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNWcqCdn9H3NoEPqtP5VcXjk/7Gwk1rcpsSy6jrYx8T1UOodqPAuihQWmzOg+nLjoAO0xOU9FOSccYTkCtLRVpwNA=@vger.kernel.org
X-Received: by 2002:a17:907:94cf:b0:aab:dee6:a3a2 with SMTP id
 a640c23a62f3a-aabf48f990bmr43732266b.47.1734478358083; Tue, 17 Dec 2024
 15:32:38 -0800 (PST)
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
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home>
In-Reply-To: <20241217175301.03d25799@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 15:32:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
Message-ID: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 14:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Where the buf value holds the binary storage from vbin_printf() and written
> in trace_vbprintk(). Yeah, it looks like it does depend on the arguments
> being word aligned.

So the thing is, they actually aren't word-aligned at all.

Yes, the buffer is ostensibly individual words, and the buffer size is
given in words, and 64-bit data is saved/fetched as two separate
words.

But if you look more closely, you'll see that the way the buffer is
managed is actually not as a word array at all, but using

        char *str, *end;

instead of word pointers. And the reason is because it does

        str = PTR_ALIGN(str, sizeof(type));
        ...
        str += sizeof(type);

so byte-sized data is *not* given a word, it's only given a single
char, and then if it's followed by an "int", the pointer will be
aligned at that point.

It does mean that the binary buffers are a bit denser, but since %c
and %hhd etc are VERY unusual (and often will be mixed with int-sized
data), that denser format isn't commonly an actual advantage.

And the reason I noticed this? When I was trying to clean up and
simplify the vsnprintf() code to not have so many different cases, the
*regular* number handling for char/short/int-sized cases ends up being
just one case that looks like this:

        num = get_num(va_arg(args, int), fmt.state, spec);

because char/short/int are all just "va_arg(args, int)" values.

Then the actual printout depends on that printf_spec thing (and, in my
experimental branch, that "fmt.state", but that's a local trial thing
where I split the printf_spec differently for better code generation).

So basically the core vfsprintf case doesn't need to care about
fetching char/short/int, because va_args always just formats those
kinds of arguments as int, as per the usual C implicit type expansion
rules.

But the binary printf thing then has to have three different cases,
because unlike the normal calling convention, it actually packs
char/short/int differently.  So with all those nice cleanups I tried
still look like this:

                case FORMAT_STATE_2BYTE:
                        num = get_num(get_arg(short), fmt.state, spec);
                        break;
                case FORMAT_STATE_1BYTE:
                        num = get_num(get_arg(char), fmt.state, spec);
                        break;
                default:
                        num = get_num(get_arg(int), fmt.state, spec);
                        break;

which is admittedly still a lot better than the current situation in
top-of-tree, which has separate versions for a *lot* more types.

So right now top-of-tree has 11 different enumerated cases for number printing:

        FORMAT_TYPE_LONG_LONG,
        FORMAT_TYPE_ULONG,
        FORMAT_TYPE_LONG,
        FORMAT_TYPE_UBYTE,
        FORMAT_TYPE_BYTE,
        FORMAT_TYPE_USHORT,
        FORMAT_TYPE_SHORT,
        FORMAT_TYPE_UINT,
        FORMAT_TYPE_INT,
        FORMAT_TYPE_SIZE_T,
        FORMAT_TYPE_PTRDIFF

and in my test cleanup, I've cut this down to just four cases:
FORMAT_STATE_xBYTE (x = 1, 2, 4, 8).

And the actual argument fetch for the *normal* case is actually just
two cases (because the 8-byte and the "4 bytes or less" cases are
different for va_list, but 1/2/4 bytes are just that single case).

But the binary printf argument save/fetch is not able to be cut down
to just two cases because of how it does that odd "ostensibly a word
array, but packed byte/short fields" thing.

Oh well. It's not a big deal. But I was doing this to see if I could
regularize the vsnprintf() logic and make sharing better - and then
just the binary version already causes unnecessary duplication.

If the *only* thing that accesses that word array is vbin_printf and
bstr_printf, then I could just change the packing to act like va_list
does (ie the word array would *actually* be a word array, and char and
short values would get individual words).

But at least the bpf cde seems to know about the crazy packing, and
also does that

        tmp_buf = PTR_ALIGN(tmp_buf, sizeof(u32));

in bpf_bprintf_prepare() because it knows that it's not *actually* an
array of words despite it being documented as such.

Of course, the bpf code only does the packed access thing for '%c',
and doesn't seem to know that the same is true of '%hd' and '%hhd',
presumably because nobody actually uses that.

Let's add Alexei to the participants. I think bpf too would actually
prefer that the odd char/short packing *not* be done, if only because
it clearly does the wrong thing as-is for non-%c argument (ie those
%hd/%hhd cases).

Who else accesses that odd "binary printed pseudo-word array"?

          Linus
