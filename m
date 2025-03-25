Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791B13D531
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927041; cv=none; b=MnbG5DSTslu7nhYNLo0J6pFU8oRY8XHcQPFzFFgCpNDDJ4DWS2lXSBzDq6WVKtHKM7gzofot6gxJ1YFUTFo3epZNlL9KSnL0lM8F3aN90Ww573i4lwmA7gBA967KgBJ5Gc+zekdNdNtnY9UgqFneGyjfksV4j+D4n+F0b/ubDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927041; c=relaxed/simple;
	bh=65b8JL3QiWTKeKBfEBVH44md18wFG9lSlt3v7c17M2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csj6vRDv2nsFcCsDbhGSK01y4eZ/kRM0cFWkYawZabHBsrL4sm/buOc85mmN2Rt7ZoMk39x5m83/ZX0+yzB+wMGuJf10YirN1tH/9sNBViFetLC1Q9JSvdv0mH/hr071VuBjm48VZ92UDXUZyYeGCMMqXH0mfywX0aXuxuf2SN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=BXuG+nfI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BXuG+nfI"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307325f2436so59237631fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742927036; x=1743531836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65b8JL3QiWTKeKBfEBVH44md18wFG9lSlt3v7c17M2Q=;
        b=BXuG+nfIVBQKt4nsX7We9WBJrFHhkQoFD3UiaxFmKXnexLI27QvQW1/XlzikSbK5UC
         Hry8bBSaFV2eMXLiycVu1o2qQDUb0PFgdW+et6PnFxTS+G89Opmv+kb2+WWcS7MxzXVO
         zhvv0ybM9IvtqGPPKTEieAPmMd58P5EKyfY5UkMXZANatUWpSgbEQUjDGpxLt6DNiNGb
         3S9ukDT3b8yfcVK+xyntDiuqY9licuLqJ6s2MTqDsCdzEsYGq2t8uYuumTaCHcH0oOwU
         lMFH7XmQhkQCBaxB3MJxaY2JnEMeeQak/LGnJ0+sWeABqlIaRnJzVd0cJMb2ZRfzwcI3
         sFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927036; x=1743531836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65b8JL3QiWTKeKBfEBVH44md18wFG9lSlt3v7c17M2Q=;
        b=PWve6nsCTU8DdfXuK4LCKFq9rvFApzzxT7gcvVKoFicBpsuPosqYLj9NU+jgFbmrc2
         0zX9nTkUktKwsChGQf6eANXicWUjTG22azycxbz3/Cp565OUGTaQvBaJ8miz4Jkp3omg
         OPltwlYOfrlxno0NE3Uj0p9UPGpAwjm5jRhR/EzHfBy6DoihQSwa8odBSFyq8SbU3IXu
         93+tbeJiybzgVsLZ1stQYEI4nDf48qGNo/h8HlAcikztZURkJT9GwVSWfjEnhU4ZUn8B
         93CdxJGOiq24iEYVpfNNOXgogr367X5/pyOMt7UTg08GNtFIi1+X8zS+l/qVw8LGeLdp
         +Bbg==
X-Forwarded-Encrypted: i=1; AJvYcCWXIesD1bhf8iAP0Uy1CWwV9FQk4aBCrZ6xQPKexqH/odYlfjKtMZnU7eG30CqGnNFgE2r24mW68OwsV3A87rtApKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnC/dvPVIufoei8sMsT28WhraJ4RaRpLPrOkEPdZOe79tKKkqB
	beXDfsBDVlKYbRtKBXpocBWzhPkhZMz/fy0aoexavpk4RXKTGNKm5djKH2AwRek1A4m+vpVnBwc
	PPRX/KPn/4HZN2sXV+Qr+9kzF7MdcTeoUX+Je
X-Gm-Gg: ASbGncvzGsovRNuxT0oJAa0T9IBAhht73b0F8XN7NjTJWb0C+TJ2odDxQ6f8N86G4+E
	sYsJZLyuWzVMSGnY8WsU0iLVdVJyGCGTPDXA6u1Z0dS4pQB3lixQDCz7u8MTPGDjjzHvxOeg3o4
	EYgqYJTYJZuQ96NuyZ+VEmwpsc
X-Google-Smtp-Source: AGHT+IF9RxS4S3ZYwnHOo47Ip6fqtNlg+M542A4F5vWChfstuJMVGYjOnb9YalcfHbnBzH4AKPQpfgZYjRIRkAGXJ60=
X-Received: by 2002:a05:651c:547:b0:30c:1358:6400 with SMTP id
 38308e7fff4ca-30d7e202feemr70006651fa.5.1742927036063; Tue, 25 Mar 2025
 11:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home> <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
 <2025032424-custard-volley-bbb6@gregkh> <20250324150703.69665622@gandalf.local.home>
 <2025032548-happily-saxophone-4079@gregkh> <20250325081551.270947fe@gandalf.local.home>
 <CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com>
 <20250325140223.534df027@gandalf.local.home> <CABEuK15DRcNDj4Gscw3xuonJ5uCrqb34qB-+MzyAmxZn=h_X=Q@mail.gmail.com>
 <20250325141933.222e7349@gandalf.local.home>
In-Reply-To: <20250325141933.222e7349@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 25 Mar 2025 13:23:45 -0500
X-Gm-Features: AQ5f1Jp9YWW2mqIdTVHxQ8ugcCObE4mz8rQHI_uoRa7sMXOoDi_PFVBeu_BgtKU
Message-ID: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, linux-trace-kernel@vger.kernel.org, 
	Kevin Mitchell <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 11:18:52 -0700 (PDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> Note, that config only enables the runtime verification. Which means you
> need to run the kernel for the check if it worked. It is not a build time
> feature. And since it checks at run time, it does add a small overhead (t=
o
> iterate all functions), where you may not want it enabled in production.

Right, sounds good. I'll test it with CONFIG_FTRACE_SORT_STARTUP_TEST
and send the patch via a stable- thread if it succeeds.

Sahil


On Tue, Mar 25, 2025 at 1:18=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Mar 2025 13:10:17 -0500
> Sahil Gupta <s.gupta@arista.com> wrote:
>
> > That sounds good to me. I didn't use CONFIG_FTRACE_SORT_STARTUP_TEST,
> > but I manually verified the section was sorted by checking the ELF
> > using a Python script. Maybe that is something we can consider adding
> > as a build step in the future?
>
> Note, that config only enables the runtime verification. Which means you
> need to run the kernel for the check if it worked. It is not a build time
> feature. And since it checks at run time, it does add a small overhead (t=
o
> iterate all functions), where you may not want it enabled in production.
>
> -- Steve
