Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837685;
	b=xEcMbFYNdn+4EazBw6r2S7PtU93vTj7C0wdXgo4o5UrdzYEwBcDLAsxneKTFFyHm6WBO
	 PlnfcRtYwZt2qpYLtxNjOuYug2LrNgcDkuvMQBToubVQh3Lkf2lFg1KQIDKdFZgp1xmt4
	 bfcZcMPh1pc6bJFyBmfSMaT7ro38jyI4IonzqE04jUyjeaECbsJ0iYQ0cKKU8Z1DiVu5c
	 1nbXljX9FBO06LkM93syfZ1xVMngQESIZliM5oOCdqNcGsr0lTBvZpboh51BoyjdpRTHi
	 M/ASgp8JfdIChaokot++xIvpwi29SdiR9A3EffwORB5M3fUP780xdnUtxEnN6IdQ0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
	b=GP/lKgZCLSqFWjci1iQjpxdMpcYmvLza4oWqOA2yRMivjARhTRfWLxj9gQ/K/jhGghO4
	 irdoS3/fTkL8v8jmxHKEXT0OopXAL1riBW4Kp6/GGKN9uUgdFzf26UveS8cniRrHPAUIJ
	 3UWUliGmex+URCfaR1QvhOO16nndQaECDIlljC0Tr4rvtJmwGeaoySY0DB9xXRpVB/6ji
	 R9JEA8Jx0ktzK8EubDINscHS2i+9kJ7IxsclHdw46H1LwptB4QMWvqsQ4ksneGHQlkgfU
	 CrUMMNs+lHCg+NZ/cJJhfE6SMdhqCgYt8DaRQNocF14LyBxHUZ7VnZgBUFdx+BuBuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V6qybNv7;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F51606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 10:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V6qybNv7
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dee593f18so1180405f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792837684; x=1793442484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
        b=V6qybNv7xo0fC7ai3ZiY835zdKjAQDhIU7NdoTyXea2t7zlKgfDV4x2XB7n0pnam3F
         Ni7k89DraHY3DpkpWSecWSop9BPvuPLTGKdHb1+SfRqbrSeOngxyZP90iaq96bou6V+8
         MIoD1H7gvTvBiS/I+eAZwFLiZwzWV0yRUxrHGxqdxOv+e5zWpldyIW1jRUw05Cjv6qe1
         6IyEy7FkFuHnKtHb+5nYhR1t1hkssKbbMpWur1VObrDOtKVGhVSI+IrT2IcSX5UQQLOj
         USczm0QIvEKKCisyCIbIvNeR26YWY5JO8H4CoIfSIkrOsZcRecDBKUE1ZeEK/tUL1QVu
         g9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837684; x=1793442484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
        b=qupvGfuDRLucwyz+XxeEEw9WBIez56CLm5fIQgf3bZT1tUFe8uriTXhyWWscof+Woz
         QFpTbu0WqEwbb7vkuUtoTHLUyQdZ13uSUu29+LrfCyEzLv9eIlqtr4GsfxNEBhbFcRhn
         at11Qy4A52MjjE86wJ+VJi8T1BhJs3FOo9oYwYnU/cTP49k+K77p1TT3nakIIGB6bAij
         hBJ51cxy2cMFryLjFbIZXzl8ITi4Qo0sIUS6kMnrmMuXRcf2/gmiidfmoKrIqGA3Q4Fp
         7kZ2wgKw3taQksFhN/C6ZZqJWuHh5t5pwutLkgGOUoIUL6J21V9nMW2bbTKvDBEjIQMR
         TceQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOV1DsB0VwgbwqkSS1SD+TgFnIamVjLEkSPT3i3y5IQqON0+F+1AX7zD9bxZyRv8jxlYuk1n5aCwhILCNO3oupqmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgNv9hamroNPRoudXSFIqY0sg2J3onPyWh6yr52Y2YXAyGo0tS
	ES+wbb/ZogYIahP/3BlUnqQOXing8J07EAuILrxtlSTQ4sWgtntfz5t7F2zhCdC3
X-Gm-Gg: AYBFou0WE4UlhB+LoU666e2bl7kYmohvvZlHdU5czkjuAvEU6jg6to936BZtsXzh9Tq
	cwJa2/SnjYC0b8PUP8vVogVshmmn0bf3bLitkyePq86NavTDuuV6B3Hs/j4Wq0O/n8F7OVw2og1
	pJTtj3fPa/tJfyNJdfB0c96btUBXItAd2g6sgQtKzX0xHuSz8YDJI1dJexFnPZ6cS0DsEFAo8oB
	U1NtqJ3wrNxbM1gyZ8L5n5fCmipupEBUmrZ3P+9MLFezKmRWKsg6DUxGZMPNfg2j+x0DKdt+atm
	Sc7BhOR2Su1x08OVEVnLhgzNvmQnLoL04km8JacLiUt21ddjoLG1KfPvnWi+5IsQIWMVLxTq+62
	76tqAt/E+la9XeU9Is0ljmCr2L1C/+Q4r4VeqMp0+f3xpt6VKVYIpKLU4QrwINeijVX9ejfaGvR
	sMFN7iBHDfOijQZgRSqeftJgYVGife+1/D9SR6WTUkbBMT8qA+ZyZZa+402Hd44vpMAIgnpnyVB
	YNHrPc/ATORkQaRMRqYWEM6TtWDq3kyWmZb3iYP1tzlCN8UeNkzNzC1srTgAqjUYg4OCQdjkY3Q
	IJzc/VR23605VF8vHuITF4UjmN/xdH9n/hkEO2d52MGXxmDsiY4eMPejnpV3RksGOqLMDGYz+qM
	3st4yC4vJSupglNrxrLSk9+MZNUksboFxy7x57gYkeMWrH4ifJuArIkue
X-Received: by 2002:a5d:5d10:0:b0:48d:e62f:db70 with SMTP id ffacd0b85a97d-48e3eb9c239mr2514461f8f.48.1792837683543;
        Sat, 24 Oct 2026 03:28:03 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9da9-5f01-d5f0-7ecf-afa4-4bc6.310.pool.telefonica.de. [2a02:3100:9da9:5f01:d5f0:7ecf:afa4:4bc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3a1csm3506285f8f.16.2026.10.24.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:28:02 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:27:59 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
Message-ID: <atyGqz5lcvYQvCYp@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>

On Fri, Oct 23, 2026 at 06:05:30PM +0100, Gabriele Monaco wrote:
> On Thu, 2026-10-22 at 07:07 +0200, Karl Mehltretter wrote:
> > This RFC adds events at the generic hardirq and serving-softirq
> > boundaries. The irqstate RV monitor checks their order and agreement with
> > live kernel state. irqexit follows the owner of a preempt_schedule_irq()
> > invocation across task switches and CPU migration.
> > 

> 
> Hi Karl,
> 
> thanks for your contribution!
> I'm probably not going to have much time to look at this soon as I have a few
> holidays planned and other series to review first. But it looks interesting.
> 
> What points my eyes is that you didn't include any schematic graph in the
> documentation.
> Some folks don't like RST, but I find having a textual representation of the
> model there easy to understand what you're trying to do without having to build
> the models.
> We use graph-easy for that (and adapt things if the model is too complex).
> 
> Do not send a V2 just for this, but please keep that in mind for next time.
> 

Hi Gabriele,

thanks for the encouragment! Yes I continue working on this RFC and use
it to check for my related early irq cleanup series. I will use your doc
suggestion.

I will wait for further input and liekly post a v2 in a week or two.

Any broad strategic direction for me and my LLM are always welcome.

Regards,
Karl
