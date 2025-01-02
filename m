Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231D1B4F09
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jan 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735846234; cv=none; b=oiVRSefaC3wWBmtvl8faamBdC69nQTsBZBHBtw7GLzuiPDqe7AwZlGqY4Je839qcGiJE0rI2vVoHNGPk307dseAgDBEeW9Jnwa2+ID+/ZHTenTMBOrHDWCrJ1lxxWpcucoDDnjda3ZGaeJmyS253IkG2s2d6jD2dyFWRKktBQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735846234; c=relaxed/simple;
	bh=uovgF/lPK6er1So/gVnn/fh0FzkKPM0lYUu800eNqng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVs29TPWrEaADLWQlJQVZtG1lWNxZLcSwCG2IYgJCzEs9R2L6FauE4i+DC2x2w/kr66Ph1x3wDI9843fSNCXSF3Pgj6P/Gbl6vo2QcXigS3I4Jcgs5jYF/G25KZlt/kjaLzAa0okNTrfXsd8K5k8O8fOa+bXd58VukipNMKL6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cBdzmdO0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBdzmdO0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so3972443a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jan 2025 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735846230; x=1736451030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkRRoUTAoPCUhgTT5UTFQy+df5m2Y91ZttoTEhYnYYg=;
        b=cBdzmdO06JIL3NrFFf/mzBLFnKVyrggdVTNJPeZxeuAwTwi3zZ/sFwnsg9+pY79Gqi
         CedvvWCHz9yJJJzHPOXY/voEbumhNTTrjhtubnPlmEgRAX82M/uUX2R/RtReZSVm9AAj
         /LhlCztFs0XQUAdCTjHzIH5KMD1cDS1Ck8SiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735846230; x=1736451030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkRRoUTAoPCUhgTT5UTFQy+df5m2Y91ZttoTEhYnYYg=;
        b=Z8Q9cBqfmx3zFBCU1c4CIGleW4+D124RBMddnAFKUZlL93CKzib3qIslPZfMbyfPrj
         026wHTOeyetQ+zNoBcEADCp02eHV7LMNYhleJA82aTmTPUPpyPj87AQsDKYvVSxVpDWy
         6JsxChFMNaXEykn0OpnCrmPiWKX8nuSJa9oqywAc1T/E2pH3w9pJgAyHEVJ4jqKM7gi4
         VUHwMgTk7PxIOAOAN4MfUDDPtQhiJyZ+317j/BzDbD0+hEXL/+fCEiYlIIzviEFemUIv
         0EF4PpZUpgZSUeJmJhvoGYNtzrWOmz3URRil5xdKsoAp/NHQteefY5FSmNSPobUyDlKK
         7txQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvl5QgrUiEbANIl5PaEDB7AiSEgCq6dTH7Ny81DkJYZE8nos3GiNrLCYMuq/+1Y19qG96lOkRrbtGGofM76FCe66Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLA08k37+JSyesx7pah7O+wqPmrQJXJt6jTlSHIo8Sz33Y3O28
	nTu3V21Z8bDx2QTDx2JC8m1MBlxHSzBnIJeNE7W29Dyf9HQwhcxNNu6w0bcgDoG0NII43A9w6UT
	qjvE=
X-Gm-Gg: ASbGncvj25q1xbJHsfq7Vpy2Ac9TOz4nZHH1ftTz9SPbkaDPhFxjZkE7RPige05YUgO
	XBGMRCgH7LwXRNBCR5sfMtRPFk8IKsOTh1+3STV4wV3ifFISSuJOf5A3NRGYSeT/n93yr6ZwR3s
	reqHZZTyxhq0FX/lgECl9iaR5CS6OUHpCUxzTJTTncKJUuUX3ckeq01yf2vrbT9hBmoXYudNh6H
	LJpFsYi5QKtKguyMu/m+oKg4hyzw+t71DM0nknn0zEhtmOaFQpTOF11zX2a4yzZRUyIT8/WuzUE
	JVyuiqrWHXwhL7YskUcsrLlMuXkE1qA=
X-Google-Smtp-Source: AGHT+IFo2JwGkmvmu5quewXXk81vDSINkPcH8MBo1eVkGwQIOJ86Rf78hSSy8WIRVW3PUJieUmG+rg==
X-Received: by 2002:a05:6402:348e:b0:5d3:d9f5:bf08 with SMTP id 4fb4d7f45d1cf-5d81dd5438cmr44801292a12.7.1735846230452;
        Thu, 02 Jan 2025 11:30:30 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d8f51faaf8sm3121418a12.2.2025.01.02.11.30.29
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 11:30:29 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1972688566b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jan 2025 11:30:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbZSdA9vQ5PtUXE+Wh4psZFTZPlQQhNUcUvWz3E3k8WV39SJAPH3fzDPupHeqvpjQ4lJA1ToSMwMfqAWxzwKAs+iQ=@vger.kernel.org
X-Received: by 2002:a17:906:c14c:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-aac33691020mr4123756466b.49.1735846228960; Thu, 02 Jan 2025
 11:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102185845.928488650@goodmis.org>
In-Reply-To: <20250102185845.928488650@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Jan 2025 11:30:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
Message-ID: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders for
 weak functions in available_filter_functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jan 2025 at 10:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Where the file created by "nm -S" is read, recording the address
> and the associated sizes of each function. It then is sorted, and
> before sorting the mcount_loc table, it is scanned to make sure
> all symbols in the mcounc_loc are within the boundaries of the functions
> defined by nm. If they are not, they are zeroed out, as they are most
> likely weak functions (I don't know what else they would be).

Please just do this by sorting non-existent functions at the end,
instead of just zeroing them out.

That makes the mcount_loc table dense in valid entries. We could then
just rewrite the size of the table (or just add a variable containing
the size, if you don't want to change ELF metadata - but you're
already sorting the table, so why not?)

Because:

> Then on boot up, when creating the ftrace tables from the mcount_loc
> table, it will ignore any function that matches the kaslr_offset()
> value.

Why even do that? Why not just make the mcount_loc table be proper in
the first place.

             Linus
