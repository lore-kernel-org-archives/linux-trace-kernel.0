Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89219D8A2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153919; cv=none; b=U1xTKTuGuocEsV07NyzXK9URqthxhgkqg9J8powQSqIiyeWMYpUeB85ma2ycrzz41+r1kwvrhUJVpxl1JniHZn/mQ7sE2MZqf2eZAB0wZKkZwzu1gmVMobx9H+Ep3YEuMZUlebPV8pjLlHq9mWxMchp3BD6yMpRgC2D8yFR0O18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153919; c=relaxed/simple;
	bh=uKsWEy5y9VSiG6NkzSuXx6HrcjOJV5515mwFzVhA0fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYJRVMhpSm27FWGYxuPi9KJrNgcYRv4vfDz1ZPJl4Fjvw0hVQQqTlcQBLlpCWR8NymPbz9XiK3BVRQol1mHvO2QQHxL8oh1/EyYY1QcZQ89PZtF5YfIPtDPQL7lkB5HtqVe/m4UDQ0mrnPlYLs0BJOgl+pijeCodDo73xv7Ozoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cduuu6q6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cduuu6q6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso586527f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752153916; x=1752758716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/eGn7NuVMyg3g4kV1aRC05vflk6dbUfw0/9TsPqLpQ=;
        b=cduuu6q6KKXwSk7dmq9imGdNfCneaOSXsmgLU0aUCILl2B0lATP2lcrGuCfsqIpANs
         +XrW72Vb6+i7SdPGrcShBHwIk9YP4z7rigEGumgZ9w231XBDHWCw4RbxXfoEuU/mbvt6
         aBNjRl7t0/URhN+ZOkNP30bi9lKzwUtdAGkEq+QgJvWs2mfBl3cic2zEU24h0V5CWa0M
         3hU3uGbJgc30kVX3BrV0Jpb8Lwler/MmcHqbHhdJ2K4tuDgw1eM6ShDIQrQmSMOeeqgK
         5wjN/qVpCuiyfpDrVpNAvvqRfS78V9hAbu5nggS8TRsC2IMT3dTsYBdO2bY8G+umxkxK
         uNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153916; x=1752758716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/eGn7NuVMyg3g4kV1aRC05vflk6dbUfw0/9TsPqLpQ=;
        b=d019H5ARIiMY5rE4JLPDHE+YR++OqqLpV3qd2ltCPB5EwxI5Bu0Xse8H/dxD0AreFi
         oDpVhI7Noap5lEBJWDJakerQd/srXN11tKi9rXZzJcfTeEYCUn2+EGqG3e24ZeDf9ZoG
         KCM7dF1uZ5WVyiY50VdlrPKBrqwJ3BQEW3F+Osrbjlo7WYaAA551M02UryMi3VwMqSrq
         kf6NWnfy78022Pw0oE2IVtFhtqC0z0MBJHWVlwoAtaoQgauU34kFbejHL0egm4Y121lt
         u4mg4Z1T/65bR2jD9hWrxq4cO5sNXL4dn4QXmuQWFCIOZlZ3+nVJg/UCYyKjf/7BnVUU
         FGsg==
X-Forwarded-Encrypted: i=1; AJvYcCUWOZT7H1wAkCgaDZ3fQZAZbQS3TcHvBfCrtH73OEtn+lyutFxMnicAIgBwwr/Y7n8QORsjG79bZT3tVjNOfk8z10U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPE49QkddyyUPhukd7V3TbegDoPIEz6a7NwgrkOh5V1xZ1oDU
	YQ/qgB7JUPjOSVU4JfYuDcY0CfI4jjssL46VVqDxsVI23r3BJjv5xiTydPe2FnR2idg=
X-Gm-Gg: ASbGnctroD7GVFDCIadmP7QBoq0bvJcKOtU1VbSIvAezu+WC3HxLJoK7OMX/rM1LqZD
	NlViPw0UjwZG9QgMbUW94yWwjAjJ8MdQynNpXGkwmzo+6T5sye0J9KzxFI0RFEtXhHuHIwtdPZU
	APzUszDdw3+VBN3TQsIzuB1eFkIt4fH4WZSJTZb+dY4HhNxULq/T8G/9kdfZvt5yhD6xI9ur5vm
	jRt+RckFYqcrL4wRL2D30jPi8qp0DxKQHPgywAsiWkIRI7npjxsD7YRbzJlUGDoL7AodhjfhfLI
	ie2kuNH+y/egL13SyArfHZnxYhKJhSBslez0rmpsIRpCjKbzEFNmxDIgmdywlP7gwA==
X-Google-Smtp-Source: AGHT+IFdiG+P1ZqYFxIeseud+QzQaQn7SlSZAoLSnUGAXEZP6QmXVIjqwZeJ+t0ffyU7gMkR+isFPA==
X-Received: by 2002:a05:6000:25c1:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b5e453e795mr6244295f8f.53.1752153915596;
        Thu, 10 Jul 2025 06:25:15 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm1942182f8f.34.2025.07.10.06.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:25:15 -0700 (PDT)
Message-ID: <0d6bcd81-3b27-414f-a626-350cba268c92@suse.com>
Date: Thu, 10 Jul 2025 15:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] execmem: introduce execmem_alloc_rw()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Daniel Gomez <da.gomez@samsung.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Yann Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
References: <20250709134933.3848895-1-rppt@kernel.org>
 <20250709134933.3848895-3-rppt@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250709134933.3848895-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 3:49 PM, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Some callers of execmem_alloc() require the memory to be temporarily
> writable even when it is allocated from ROX cache. These callers use
> execemem_make_temp_rw() right after the call to execmem_alloc().
> 
> Wrap this sequence in execmem_alloc_rw() API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

> @@ -165,6 +149,28 @@ struct execmem_info *execmem_arch_setup(void);
>   */
>  void *execmem_alloc(enum execmem_type type, size_t size);
>  
> +/**
> + * execmem_alloc_rw - allocate writatble executable memory

Nit: writatble -> writable.

-- 
Thanks,
Petr
