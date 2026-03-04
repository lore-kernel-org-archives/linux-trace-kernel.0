Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720036308C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617089; cv=pass; b=fjC1jCeHUTa1SxVf2KzGziHRSzbMixC+hvjkDO7w7AIOGi4OYOcbb80R692JVaa82DWiRB/npHNYVSBeTpujYBhLA1IEZohx4nB7mYwPFXvdLgosvSXg44lk0+RP8r4EMJU217aeY5DO3inSmmRGaENThXUq7n5yHQTP7t/9dv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617089; c=relaxed/simple;
	bh=qIyf7lr4hxsi9VFBXmnT+2w0PHpkvq3nIaCelbYSReQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXrZ4yagLI1S16P+LyHQeT8kbQZ31Cf8XtPhcnBCa+gtHB09om6A/YDTNEhjxA+jtKM8E2VGm5Whd7D7E1faF0NP72YzzF7+JyhMEFO03V29R8HypGgpK/bMtbCxs5X1IA8nz7Gkhfn7F65h7xIuWZdo1DzS+s+jO/Bsbj8Ilrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m861x2gu; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m861x2gu"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c9ebd1369so6128296d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 01:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772617087; cv=none;
        d=google.com; s=arc-20240605;
        b=VdjTpFhA9UuRdGzhokxIZM3QN71cHNaQDTDnwKJg+FBhju5iauKiiQhSwlT2qAed4m
         6X1Ek6z0XrTayAJx9gGn9NLGXl/Nuxf7Kw4fKzdQEKbCOahB/DJxXIEAqJhxK9WbIJmi
         KP1s2Q6VWOO2LYOublbUJsQQjjVIIbQSRAscKLXK/cJZBcszkGPXYZqXHLP+jqhKsWi8
         FHPmVwWetU4xBzOvoMJAPtyxP24RbpHKCdBRMdGfSiao7YFOvQagRzUCkStiZ+/8aBQ0
         3yE1O8G74Pt0KqCUwQBUjTVDhd/YIEUuYyKvuQ9tKWaT56NKUVPrUteWktPQCCfGXMnz
         DAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSoWVMiMiGZDKyHbYW8WHJlBkGfGWHpKNcMMdMJrR0Y=;
        fh=KR9xDZ7uabWoGl8pmQLlQMTwvGa3ie+lQpTlMbukhl0=;
        b=XDoBRk1eXeQvmfUu2U/CeD1wsG2Bg0N6eol76wl5sly3yWhleEClaKCJ8vX4eR3lQQ
         EHxM5UZvsKiwUdUaoh+nUFhXFME8n6UL3nApKg1Kiu8ugKLAwxWiLuoX1h/Nmaz2vAuu
         zehOdcHmB++RJ7ZCrCPtqbc7oxmi+ZGUpEz3ofTTpMzcGMqW8zA/sQWkJLLVy2JXyfbr
         HyfL+JeifyQDe1az9i52BBKzSXKedyXWmLJJY0xW/h6DYXSV0a/2g+pPApyrVDcmVBXI
         pqDFxD7SM/hPhcgx+hXPOlpCegpVcBDcDgfRhoQlgG7l7uTCh9kvlR/UN3yZty7bdf5U
         Bdbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772617087; x=1773221887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSoWVMiMiGZDKyHbYW8WHJlBkGfGWHpKNcMMdMJrR0Y=;
        b=m861x2guvRUXZXbEOjSI1NtzMCrGMA3CEjmj3Bhorcn7+gpIOgm0R8orapMJRh49Z2
         0du5+4B6dlgKr2V1AD9LTGcZX2FR0DU+yERVEIPiUB/dHGW8+XI0QyYOcihiOBOQIafE
         Y0bko02aUEIQDdWRgNXdJWHqURKnTjIZL1fsLJSqmNgjygj5XAHRmXLs13eAcaw0G5Qh
         ZiIItIFlX2OVqR7kGhWf46UFpfwpijwt+VyUZJaP3bKhaACXO0Vn7oq29WSYxD2yOc+o
         SPv1EdCrVts1jP5Q1GM1rGnNGYuCqQ1jYWjiai4rxTNMTu3XBv5l18vcIwQoyPdmDkT2
         MjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617087; x=1773221887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSoWVMiMiGZDKyHbYW8WHJlBkGfGWHpKNcMMdMJrR0Y=;
        b=bQ+JWkZEiUQjBD3iE6NAjuhcox2rSD8D+j4QcWAVV7nvjp8tUQy8McVxPYDcmmND4B
         Pa7Y57hBJeVjCduiq1aWTxvNK14x6ItuvA1RZxQyro1/zpOviDZ5WSEJ+jLKa27HdBK5
         nRWelr+RuIoqSST04wNe72dI3w/0E7Wm/KfhhI7SOPJ2jfcngs6Px71pie7xBU3JeOwu
         blceo0yWIM21AJbORykSCFqDQ2WapN2B7YeeAO2K1DtOA+79kWW/jf0nWVSl5aa+y6zL
         IIIBeb8tmNoUbvgnBUWgUNJiGKUPBO0m4/C0ZE/Af+Xnif8ly5VAtPtZnqUifgHodkZA
         JmqA==
X-Forwarded-Encrypted: i=1; AJvYcCWhpEIY+BxyFVKQERRdrMbxmukgO+Zj7FPXUiT/43i24Xdm8NKOFiTCMmPqk01g1o7IIbqQT98XpRLBPM8k8o+ENpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysoBIwOl+RCOOW6q10WQfo9KgZdWeE5i87NGJG2CRXaYurX/3s
	qEp2dnCJxk25d3FHYZpRsSb9giKuOB8vJCwH989ehyGHE0YbEnHDrgmv1Wphvb5D7MztA1t1/rv
	DBesWe8AMK4X3RecW5X/GcIqTJ78ackw=
X-Gm-Gg: ATEYQzxT2rViuIbqjOQrXo6wGDRoETTEDbRef4O6bBPReXuLnsboQuQMIVbfsZNW5ev
	GZg6WjJ3+pCrcIam9jT3jIzc8Augn8juVPLmdGCUOOC/IkvBSsOylF5sX1lPiuw04C4GrlbUvC9
	SnDK1xkTlCLxpBQCbWRtGTfIwGAaVCNia2Kbn7Y8dcBcsc5ZmYnkaKseJvXlhr8SrHVPgqs8/b0
	a9s/mdxZFSvKTYlZSgScSnuP8AtpxkU5rChIFu4WWdCoXt46BnQXUXhtpYoB12k471G3dKpAkpq
	mq+iyDde
X-Received: by 2002:a05:690e:b4d:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64cf9b4dbadmr1056672d50.20.1772617087103; Wed, 04 Mar 2026
 01:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260304090249.GN606826@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Mar 2026 17:37:31 +0800
X-Gm-Features: AaiRm52htbg0ND_HGI_ixpgdscO5PJ-QCcYa836Kj2xlWc6TFIXTFpuK3WHlUGw
Message-ID: <CALOAHbC1AHc2eZrzafz7ynrW7NFPrVmervCY_jjWsRTo0gBwQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 5:03=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > Introduce mutex_lock_nospin(), a helper that disables optimistic spinni=
ng
> > on the owner for specific heavy locks. This prevents long spinning time=
s
> > that can lead to latency spikes for other tasks on the same runqueue.
>
> This makes no sense; spinning stops on need_resched().

Hello Peter,

The condition to stop spinning on need_resched() relies on the mutex
owner remaining unchanged. However, when multiple tasks contend for
the same lock, the owner can change frequently. This creates a
potential TOCTOU (Time of Check to Time of Use) issue.

  mutex_optimistic_spin
      owner =3D __mutex_trylock_or_owner(lock);
      mutex_spin_on_owner
          // the __mutex_owner(lock) might get a new owner.
          while (__mutex_owner(lock) =3D=3D owner)

We observed high CPU pressure in production when this scenario occurred.

Below are the benchmark results when running 10 concurrent tasks:

for i in `seq 0 9`; do
        time cat /sys/kernel/debug/tracing/available_filter_functions
> /dev/null &
done

- before this patch

real    0m4.636s    user 0m0.001s    sys 0m3.773s
real    0m5.157s    user 0m0.001s    sys 0m4.362s
real    0m5.205s    user 0m0.000s    sys 0m4.538s
real    0m5.212s    user 0m0.001s    sys 0m4.700s
real    0m5.246s    user 0m0.001s    sys 0m4.501s
real    0m5.254s    user 0m0.003s    sys 0m4.335s
real    0m5.260s    user 0m0.003s    sys 0m4.525s
real    0m5.267s    user 0m0.004s    sys 0m4.482s
real    0m5.273s    user 0m0.002s    sys 0m4.215s
real    0m5.285s    user 0m0.003s    sys 0m4.373s


- after this patch

real    0m4.733s    user 0m0.002s    sys 0m0.511s
real    0m4.740s    user 0m0.001s    sys 0m0.509s
real    0m4.862s    user 0m0.001s    sys 0m0.513s
real    0m4.884s    user 0m0.000s    sys 0m0.507s
real    0m4.888s    user 0m0.003s    sys 0m0.513s
real    0m4.888s    user 0m0.000s    sys 0m0.511s
real    0m4.886s    user 0m0.003s    sys 0m0.508s
real    0m4.952s    user 0m0.000s    sys 0m0.513s
real    0m4.973s    user 0m0.001s    sys 0m0.510s
real    0m5.042s    user 0m0.002s    sys 0m0.515s

The results show that system time dropped dramatically from ~4.5
seconds to ~0.5 seconds, confirming that the patch can help reduce the
issue.

Please correct me if I've misunderstood anything.

--=20
Regards
Yafang
