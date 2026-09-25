Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDC364E9E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303485; cv=none; b=UiTU3aORUiuxnFA6jt0Z4Z2fM9zHFkbxXJVufIQ0f5JjDsFWcQkIOtSdvltOmPlq1C1pRgdeaVirokRvAeXfgi9u3cyg+LWBM1NgejEgloCZjMpJ5A6zySwQGMsJixoLSITGOD38J94i1+/9H9N76JdqKX0zmejubmniT/Z/s/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303485; c=relaxed/simple;
	bh=XXqqfvuuz044nX/aEKeET9DgPsS/vggZM8IWukabHXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNPBjI1BP3S0EW8JsDyWQxmSZhVjxGDKERrkduCCYm8sRjH3JtSrkg3oRrA11hRGOzy7yARSmYxr8jHofTQeB2bhlwx7PkkCqVjYYOkaRmrFdPMW68Fidd5qdCRY0tjrwMYhPAsaQO6gW7fKu22cdX8f+Ka3UnfROwUAVq7F1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXfm3+ZQ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXfm3+ZQ"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78e1a94b8so325a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 19:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790303482; x=1790908282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s1QRu+lGJsmT+0vXomkywkgzh7zQTksmtyo4pAVpxeg=;
        b=lXfm3+ZQIzqzFssRwsi4aaRGcIKocP5Y8oEmPh4t+Il2/+jY5bPod0LhGukGJn6TRu
         nGAaxRsZ1XGsj9XYWLgx/elBUGg2gxipP0UAUOzDVLpba/UpAhU+wXbA8JOuhoRnzNfQ
         kaGyN+15i2zfDq8GHP4tGw3DEyCNQ4x+BvRX4yj6HZXfE1EfPwtqXceREDZ/bdxbQWZW
         fromew1d4B+2pg5UvcZInUf6PSIJYma+VG8ICZtNqIkVHbr0FSvGHqyDQRIx1ly1SPbF
         RDXdVT/MNc67N+mMKBMJkPueTO61PFcQCpYltreYkqI30lxJLkK/4ewtWyLc+1LWzBrl
         MjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790303482; x=1790908282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1QRu+lGJsmT+0vXomkywkgzh7zQTksmtyo4pAVpxeg=;
        b=yK22qJ8JxHUghe1f86q1VIQOqser2hJCnYuercohTY+TfyMM0rwedmZUHtEolagH8y
         Y6uwArc6pdUh8YMpYusCkveUy+oozNTe0rU/QAPEMkm197Ic+/JiEERpEsrMqK9R4hYD
         DBswbNS7XtRbS2qQduKfJKtnL4QM+U2LyT8rXuFnoY0e/J6nSdpvrBjgNh4WklrEFzrN
         tADq1cf+Ft++XppzZYwBMkZylPQpKtNyGnlVzq7pu+zem7g65+hD+2IaYfxzzcqEyz7F
         xfAhkR7SflcPKBU0idP85BLT4qoOlS52W+qs+t1XiQtxkDqnpJ41pJ8t1ftZXxwY3yLr
         1Lvw==
X-Forwarded-Encrypted: i=1; AKwUvBziZwfaKxvOGdShWR7QLBMqUQtHyy3USV8pP6AXmWgV99ZHhSc6YghbZMPDLBUV5U8zlHf6UU03PW58/8cl1ViI1i4=@vger.kernel.org
X-Gm-Message-State: AFuF++nUzMEIGAwUHh0MdbcGg431dB/PkKThWWnyy9PtMnN8Q3WJFxLL
	/M1divH66I+MCe5xiFXQQie77gEdGaA5ihxKoHetRLA9Rsu5c04ol0vM
X-Gm-Gg: AYBFou1RPOBZEFCWxGJoibcZY/vI+Bb2VHUQzGw8E4jLt+LqhblNIVrgOcWCEunyRSj
	BKlU0RGW0TQuQwvFxvK5b9eWBC3hhdZDfmj+FiQJ8p6ndX6DIIrkN2A73+oqlKVF7t+2pWFupbj
	Tfc9zu12rr/m9ayB4lUw0S1KSsgmxlTpjsaO6m9sHJQHlc5GjFJJ7L/a15bZziP4TDcxK4d1OQL
	LeIDbWJQrf3fRjqBoQf1L4s6DTd5PKIGwCzeg7PFEylcYgpbK/1ng+eJOMYpAfbH/ZgvFDg/v5R
	It+9fkDG0qFNqZK0/OzJyP3b0e5Dmk89ubuW/yj3uBI7nuMMYotYA7+HmzxZ/sllwT5q1A+PFbz
	cxVxblKD1hI3QhoxkecCpYnixFizkthYyBClkeDEs8/tXkYCmraCnhKXyasAsUXR0EZqgrNqUpC
	fZoF+3vXJvURB6HrPnN/oFgBF7oONtkG5revXu+3AQz3UwPraFHQlmuPD46hNAbw1v9Tov7cluH
	/1QVc2hgsbQ
X-Received: by 2002:a17:90b:2745:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3a098ae7053mr3838065a91.6.1790303482142;
        Thu, 24 Sep 2026 19:31:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99e5711sm1386356a91.17.2026.09.24.19.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 19:31:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 19:31:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing: Fix empty symbol names in
 simple_ring_buffer undef check
Message-ID: <157373a2-171a-4682-bccb-de4e17577e10@roeck-us.net>
References: <20260923074213.3077182-1-vdonnefort@google.com>
 <20260923074213.3077182-2-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923074213.3077182-2-vdonnefort@google.com>

On Wed, Sep 23, 2026 at 08:42:11AM +0100, Vincent Donnefort wrote:
> Sparc64 emits empty symmbol names. Skips them when establishing the
> allowlist and when extracing undefined symbols.
> 
> Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net/
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/trace/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f934ff586bd4..0e1846f7dda3 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -146,11 +146,11 @@ KASAN_SANITIZE_undefsyms_base.o := y
>  
>  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
>  		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
> -		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> +		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '$$2 {print $$2}')
>  
>  quiet_cmd_check_undefined = NM      $<
>        cmd_check_undefined = \
> -          undefsyms=$$($(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST)) || true); \
> +          undefsyms=$$($(NM) -u $< | awk '$$2 {print $$2}' | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST)) || true); \
>            if [ -n "$$undefsyms" ]; then \
>                echo "Unexpected symbols in $<:" >&2; \
>                echo "$$undefsyms" >&2; \
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
