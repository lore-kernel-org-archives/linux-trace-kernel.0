Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FE257852
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002237; cv=none; b=uZfciV5VfLTOQmHO2ACPRysEUFntFBvVBv9XAKI2PHXqrjRgTeittae/3TftPkIbzw+1wuDw11R4PoyxHtkL2tQisTl3gfI5vznUy6gZIVlDuFeQTFbXEqX+29JozRegyw5HbKuIdKSlcbE8Vbj4lgXoSVOrPMbK86Qn3ljmytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002237; c=relaxed/simple;
	bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3c1o+k2yTNKRIDZJfrMKlpBwvfplIUzwAdUJ/1DP8CgsQucXMxVy0QXMJKkjTEoTTDPEi3pT12ZolWe5vWranB2P6z1/Sk4AqqZGWvQxxLfLz8anPGDgNuqOCosiLuXzg5TK5KnGiCwKvFTV4c+U4JbiIiP4zbuyfS1ZP+vdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7/foJwi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7/foJwi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so138570f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763002232; x=1763607032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=A7/foJwih5tODU6mGE56M+xIRYocWBiG/pexRxN3jFMXT3bAERCE0iR2tVvnmJNPPv
         zqhOV+8gk2MU4zrJ3u6AcjImkwQjQL/V/TQqstpSF8eeCj2SjSDJ2ZWug+hQb90IrMVE
         ySH8bacZznHRMx6UULqycj+tOxEB21GmrHiEN7dsAVmYb5JPcAGlXjD5jeD3CguyLNnq
         8/yuElRV8rX4D76Yh/sGXTHuutKpGxqQPk+BrE5cp8UsuzyZpzt1tCkb7CL6jjDint21
         PUCbdNIrr9Yjq9HOCtdmub1ZNUK5uQ+bevYHj7m4UXpYDnm4YCOqQZHdKn3LzgG3tCYT
         coVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002232; x=1763607032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=UWitJXRc5qJpsqgCbA3Pp0cljw/fhGNOhNwbeuvmD/xC6IlswyNYN+K5zG19wmVHUo
         Ee0tAneqbfZEdM0pKCFOnJ2oyq9HJVGMG5bosdZkw8J2jXSaUvbVT/7Qs0jBsgCAwhIP
         CtnRTRYdqS+l9h50zv89r/dkoYP1aUjZtNCYZ2nRgdWM7fMnDEyk44zznZCVWzf9ckmf
         SS5HQkYaMLwBUye5FeH7ion1J7fK0RVIeKvTmagptkSWqUy6bcjVelwVICWE4QMK3boM
         kaFDN4ctHUnJKGiCbh4WHX1CWwcR1TKaSxlmyxOP3+ZRLyqGgOZzRoRw6boBH5Fka9Fv
         CHFg==
X-Forwarded-Encrypted: i=1; AJvYcCVazRrT1i/YcuOTDYwkbx+hHYEIJwR6BvF8XAlkn1vLa7Zrqu8rqc0S4dS/klhk1W6E8h8kPrwdYTLlwUu5Nl2MeL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyTAf7Tk5+tGxkRVWSv4HmSHMMIVsGXoEsH1hR5KILIRyv979A
	zrEfHoQZVZEaJik4I51k0aUcdNQxqao9XWOodoQvaQri/3BbPaiJel9jdxdTHkQDg+T2fhM0S9q
	66rgnnDJcfNEDf/Z34G2/6dDpBh1YaiU=
X-Gm-Gg: ASbGncu0ITaXNbTJ+YZv8U517foktGkQZ80/2kLCPhysDTbjvPk6apbj59SPmGYtgbu
	H71vpRJno7aOAWrqUnXQFGuZ34snJJ22X4UkUTtxX4eQ1ioSSeX8uOCgiN0afiG9Dz/vHHDMCvc
	8eRc7oZOdG9CaGBzRP36XkES5DwScxkSx6hZUPXFqOwkgvVTj89njlesTBBLcJ6c0qaTqFs8mrO
	goUikf2nTJOE+1/9muuNP9NPDu8O1JrIPStb35lOw3B6h3UyBDfpVKjEs8dwFPCA7WcDr3Qw//s
	NsVTCJBnYZuxmvpFvw==
X-Google-Smtp-Source: AGHT+IEGxkHsLlDeqqKYYxVV4qPNOdwbtTL8tifx+l6rLgWuNnhOTSmN/RLFv9iuIJNS51+mPUGAeqeerVG2TSOJBiA=
X-Received: by 2002:a05:6000:4310:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-42b52814d8dmr1346241f8f.17.1763002232446; Wed, 12 Nov 2025
 18:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112142003.182062-1-pmladek@suse.com> <20251112142003.182062-6-pmladek@suse.com>
In-Reply-To: <20251112142003.182062-6-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 18:50:21 -0800
X-Gm-Features: AWmQ_blTyug6l3_C6LlEH8I8hAO4t3AT5lTjYea505BxtYynZkMNHSFE3MVvFng
Message-ID: <CAADnVQKUffyGCmpoGcvSTF1hwN58c7X=Ebvn70Y2Z0ZWJS0p=g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:21=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> bpf_address_lookup() has been used only in kallsyms_lookup_buildid().
> It was supposed to set @modname and @modbuildid when the symbol was
> in a module.
>
> But it always just cleared @modname because BPF symbols were never in
> a module. And it did not clear @modbuildid because the pointer was
> not passed.
>
> The wrapper is not longer needed. Both @modname and @modbuildid

is no longer

> are newly always initialized to NULL in kallsyms_lookup_buildid().

are now?

> Remove the wrapper and rename __bpf_address_lookup() to
> bpf_address_lookup() because this variant is used everywhere.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

other than typos in the commit log it lgtm.

Acked-by: Alexei Starovoitov <ast@kernel.org>
