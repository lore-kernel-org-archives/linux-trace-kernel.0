Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054C386548
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257356; cv=none; b=oQl/tUfWYVlIQAWVUKpw4flZmAeuFdgG3PrSYF2fUt4/W44GnE5YBviH8tYdJUT9lkS5EGP6qhVCcJG8FOHBCKyxR+WS1TY3n6j2RQ+cOh70aQq+kzi45QOFs1A8I/eF4i0dxVLLAh8pNWfnPw64zutPzSjB1XttLffvjyRlSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257356; c=relaxed/simple;
	bh=j0lRr4uQumusVhShbHT3x45ZVIVLWydOil2E35eDUjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptpq1f6yWyGSWto7/bwYhoMDl4b5xfrujjTlpqYziiKO1giv5Q3IBke7kjBQ0L+TJux0rEmuBVX2mr7oeCg4NmBBammIcsYLFTeH5qR6afFPqz7Ano/J5iecHmzftsPr4flGoIf/ETdTTkb5tcS8za8LYKLBOc3SUkl7lPkEhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EH/+n3Ib; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EH/+n3Ib"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso37018055e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774257353; x=1774862153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YU6TG7BhEYw/Kb5KtuLrMQYWwx5oDAgZWzaduafFFDk=;
        b=EH/+n3IbDYeUe3Xt3TaZhtYSDfk8zIDwBkoCrjcd1hL3ic/cSRlaSwlzISkOFYOl9Y
         W6D+9aJWr8QXyTSKrqOsDxvgbvQzWQYlR04fhR/7AJuFy9JcjCrEj3Ti2BSpRpnzBxYC
         QiJqvUWpbgEiYR14KVU3rb7l6AHeOHeDvhzrxZOpyKQxAGAuZBih7NiBLdQWbIrDO4ga
         N/eBROkcNWqINWdrZ22L5oiWt/z58IyK9+YzifgOZ79SNnIF0cEzbIMd1L5A8YkqWg8X
         NNRbSVdEa+arZaVU8WaxlWBTo09/jTsOb2rqX5eG29N1hkoLwW8HVBZwgWyPIU59LzkS
         PpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774257353; x=1774862153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU6TG7BhEYw/Kb5KtuLrMQYWwx5oDAgZWzaduafFFDk=;
        b=dlQD4ZTZaPQBWGsA0rMVjSbXpaFc4QjY8JdshrrkojLq/TtIIRZydC9I8SDWUb29bC
         u8QEgMQSQcI/qS/1YLehpbxmuTI3kHChLuuavRNNxEh14chVSfgCd+anOEMOs5BmjlmC
         nSKdnf7yGUpovBv4qyJEBGhQvZzUF7yriNnKVMRehuueIWbdbf+FumovMbCdv8NDTw7k
         BCbLAEc0AbTVB80QUSUK/J5NsxwTvCAztEQ0jyKd7ttCnRknPK4UMP5d+YDJt626jlGU
         mLu71lxmNpQzYqhCikSuygd66QVI4fOc1sz6cqba77xSjhVGrWMSPbHobVcjlfNSdCDb
         ovRg==
X-Forwarded-Encrypted: i=1; AJvYcCWLiv7eCYFT5to7uE/GUEbbjTEnrGvJ1cYs2d26do3ke8KZk3N3jQVEHURFiJR9/ir6X0qKOG4gJOl+QFPA0qUiUMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/E8Py2UMM2ubGeijKd/zWD+Wvg/xYBbn6/wK6c18XqKEEwL9
	slGm0SeTbo5dYFWvLaKQmWOvzIv21VwLws3FkoxbcOXIJzWfY7Sx0oiwXiq5dhCBzg==
X-Gm-Gg: ATEYQzxITs4IbECjpeMcvXArgwBjE2hWeSNTL9ekPxkVbG9NJ40liO/FKxaGN+yzURn
	8KlEj3p+bngYSqo6Zp8e2m5FAcnC9TJc1HwBtVF9Kn39pxn+d+lm/lY0n8FDuBdkdGL93tAzf/d
	xCziFub81GEbgVffvw5jiahstEFDB6YyzyENrnS0AScz9v2UySbeWAAZXVuyYab0a7nkj592jEC
	uL58GklGQcqDRowbgZve9CandSjhMpQ0kCgAzD9sCC+jChK2zYd+C8nZKhe0ZmfOLjw0Ot5JB6E
	xXf5SHpE1fiG9XU3nt+ENM6Z9XMb6IK4LHquLqGv5yclRmGD/HyWLKcOzVj45z0t65fJId3vSvt
	D33C7l2SUmOVhpG9lTi4WnRjr6MKiL2LxaYP5umGl2qykfftfs7o2c0z+9waANZpH501Ozf/DdJ
	PJjPuHoKOzf3pOL2OJa1Rp449y6pUv0B6hRuQKzavZgknjDJiw15Z6eF1WTk4raKdYhFA=
X-Received: by 2002:a05:600c:3f1b:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-487059c2eb3mr76504415e9.27.1774257352602;
        Mon, 23 Mar 2026 02:15:52 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48703e26408sm277752545e9.11.2026.03.23.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:15:52 -0700 (PDT)
Date: Mon, 23 Mar 2026 09:15:48 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH] tracing: Adjust cmd_check_undefined to show unexpected
 undefined symbols
Message-ID: <acEExHx9GPrhxHzk@google.com>
References: <20260320-cmd_check_undefined-verbose-v1-1-54fc5b061f94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-cmd_check_undefined-verbose-v1-1-54fc5b061f94@kernel.org>

On Fri, Mar 20, 2026 at 02:29:33PM -0700, Nathan Chancellor wrote:
> When the check_undefined command in kernel/trace/Makefile fails, there
> is no output, making it hard to understand why the build failed. Capture
> the output of the $(NM) + grep command and print it when failing to make
> it clearer what the problem is.
> 
> Fixes: a717943d8ecc ("tracing: Check for undefined symbols in simple_ring_buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
> Commit a717943d8ecc ("tracing: Check for undefined symbols in
> simple_ring_buffer") and its follow up fixes are in the kvmarm tree so
> this should go there as well. This is the rebased version of my
> suggestion in the original thread:
> 
> https://lore.kernel.org/20260311221816.GA316631@ax162/
> ---
>  kernel/trace/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c5e14ffd36ee..d662c1a64cd5 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -174,7 +174,13 @@ UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitize
>  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
>  
>  quiet_cmd_check_undefined = NM      $<
> -      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST))`"
> +      cmd_check_undefined = \
> +          undefsyms=$$($(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST)) || true); \
> +          if [ -n "$$undefsyms" ]; then \
> +              echo "Unexpected symbols in $<:" >&2; \
> +              echo "$$undefsyms" >&2; \
> +              false; \
> +          fi
>  
>  $(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
>  	$(call if_changed,check_undefined)
> 
> ---
> base-commit: e3d585ed3ff891a00c2284fef4be9cf8581735ab
> change-id: 20260320-cmd_check_undefined-verbose-7d15f13f615d
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
>

