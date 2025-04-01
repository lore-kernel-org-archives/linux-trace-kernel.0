Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFD35949
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471902; cv=none; b=HqGhKE5Dp2trT/mDq6fiit+v0rNSXwcxqhJkFEHLL6CbE2XbQTDuFU3hHUmmTU/8vb+aaKEgRv/mUXesjBRFAwfY9MWUheBNhyBuSmW3CMrp8n+9ZyxnJTlSUZuo7c/HMwc5g5+afFKvC4WHAF27zqehfh3xtSnLR7A1OxGGykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471902; c=relaxed/simple;
	bh=rn9IIVgH6dOcVB1hi9HKWEctsQtCMvhHl7Q7sdyUXRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/yGsugAc4pa7UZW9IpUeQAGZxTdIGO+O5jBJq1gBTCYJ+tPee1oYfl6wAkgaHoXkfldgf9ZndzrBhH1GRzLme6tk2PimBBYa5kO9ld3ba+Y+k3zsvLvnZyINCPnS1dRVkq0FWnige/xdHTkt3EhX/AxbW40TMMT9D996M99pXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GHbll4y9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GHbll4y9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so805430966b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743471898; x=1744076698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIYG5OfWPexo+K985CDcAL4PXpvK2Cy/CrlETrEV2S8=;
        b=GHbll4y9QnouFoSHatRrJAs6MvAS+RpC34theo6Hozv2+CHGSfKZ5/zmO2X3VGJsyb
         twY4kdzR/E+MdNpmW9y8S9Fp8m40x6GKVHSoq+FihYUHFXvr+tjJ9O9RBwIKb60UkX31
         U59gw8cGfM1QNjsIosUHiok9mDn9Q5svn0cdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471898; x=1744076698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIYG5OfWPexo+K985CDcAL4PXpvK2Cy/CrlETrEV2S8=;
        b=VNTgKg8sC1n6TuBcMPYa+3qhjprgsG7NGObmVC1EwjsmHTfeNPSIhCc1z/ncZaPn6S
         8ifYkUW3vTKTQJFG++Amh6KVcseKH2xykghLm/TPt3iU05HS3NYgho1kjfnXB8sdxpW7
         MD++hyrWkV2ExUDKjmn/fpiT/lqKE7OzpbDZLFAELw2DO2PnPomtFdZUCEyTLvp3Xpec
         tt+l7DUtvKFqO/5wpIOIdJbAODZP/G6C+q5hVFfaELhi0NClHq5Th7ok8ApXFZ5NS10P
         CixNaKGV1nxAWVY/e4FCo0Bkgm1ueyQgMOXph9dS/+EZdY99eZ9bx9Z1CqDMUusw3at3
         jhbg==
X-Forwarded-Encrypted: i=1; AJvYcCWFTrk5063dXTTbYAMTUySkyl/7a4sKxGLXfxVAqz6JDMPZUxQvFrXw7X/whykP1+OwrXBlGxhxABOXBF5Bql4PQbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNPheizpVoryLOOogevZSCG8FxAio1CgAXCNGs53+eax0lIkg
	xFC+jMTQUcJ8e6J2zDXNK5Uf21wNtEqcZbY44DAU5hCHSsF71slCfs/nFOaQRMvI5pypY2ajhBT
	UFgg=
X-Gm-Gg: ASbGncspHy87/XQ1LmDAbaXR2dhSQzK5PuqgxNuVAPdHsSZHeEnvYjb8l3Z3PQGZsde
	TC9J0y5NAnvDRACpyLl5bX9jwTg8qG7nri8gcJ7W86c4qzcLjl2cRaFDcbgeKWsOSMNiI5IvWL5
	iF+5GatV3cjJATO/VOK6ATP7dc1Zb8L3q2FawomE0Yuf7N7gvMaIgrXmgbgCzjXQz5cj9EL/Q4S
	PBO2wJC6nW1piHK5HBtHAOIAwvx8LyAW8xfIH7uBu9oX313as/5EfTFQMN6dc/DeMHAwz/tfq9T
	e8/ZU9gzwBiJO7CcdH5uH8LNG+SplleTKIQ/8cnsblwNBvq0G3Zs7/aDO/HjAhE7XO6IOBBzPbn
	g8OUeuYqAzi/QCgDFC8A=
X-Google-Smtp-Source: AGHT+IFlCMTeOksAIufG0JkkximITvQdGCD/ldD+KdB/Yn4OAowPlMeJMljSvhbXHaMvucSso37oAA==
X-Received: by 2002:a17:907:3d87:b0:ac1:dc6d:af30 with SMTP id a640c23a62f3a-ac738c1b732mr978603466b.39.1743471898332;
        Mon, 31 Mar 2025 18:44:58 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bb92sm708021566b.12.2025.03.31.18.44.57
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:44:57 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso9804164a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:44:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjsBAErd91xmNJnub90xcPafGJJeZ2X1I8jUJoQgZSSiuXPWNVvfZXT9mQUVExI42HOHIlc0RVrJiCsKP233nbDvA=@vger.kernel.org
X-Received: by 2002:a17:906:6a0b:b0:ac6:da00:83f4 with SMTP id
 a640c23a62f3a-ac738c6f29emr856911466b.53.1743471896732; Mon, 31 Mar 2025
 18:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
 <20250331203014.5108200c@gandalf.local.home> <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
 <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com> <20250331213616.18ccfa37@gandalf.local.home>
In-Reply-To: <20250331213616.18ccfa37@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:44:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKgKBeNBVFin4XYXLNSNDPnL1kdidigV6qfQ+6tY8cHA@mail.gmail.com>
X-Gm-Features: AQ5f1JrFwQtqaUhBPYTqFQvZ7sPYYUNGY-kB3mWrogAzqyhted5P9oPz7tJDnec
Message-ID: <CAHk-=wiKgKBeNBVFin4XYXLNSNDPnL1kdidigV6qfQ+6tY8cHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 18:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Just so I'm clear. Are you suggesting to add flush_dcache_range() to
> cacheflush.h and using that?

No, let's wait for it to be actually considered a problem.

And I think Jann is right that for kernel ranges you should use
flush_kernel_vmap_range() anyway.

Oh how I hate incoherent data caches.

           Linus
