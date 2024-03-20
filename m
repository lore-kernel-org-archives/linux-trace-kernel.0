Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D84C8A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894932; cv=none; b=kFOft3i9CZp7Dzpw4ewMOKytqXzvpk3okL0FesM6a0UMS+AQ3VclEtKjFgeTXWDetQrunj2OCQtTRtMn+GSQVerx8dUuoETZVzqfzfgRfO1X8cjYzZVZ69K2lmLymZlPZ35vwN1ibcoBCE3taqwHv/pBBpAbqD1zDWNnyjl5BEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894932; c=relaxed/simple;
	bh=1o1U/hYDLGxcTlL8MA5lcT+IV4KO9u5uC4rIDNmOgk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7kduxb5pp2LRjvZ88E/ofoApk0epbMsYPq5Ravlm7+/Gf+PyMSq94b1MKVwPiC3yb2V/966czjiM9FDU7axws5IjaLG3s0UIa+n9RhHj9VbrVchiebqxcLTEQDPAUXg2IV7f2RU740prBOico6tZC9Mt+fKfTEK45+F2dJMg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUHgELVC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUHgELVC"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c897ac777aso140365239f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894930; x=1711499730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iivMpJVqhfyzonHOxre7J+bRKHRX9ehBdH0rm4sUurE=;
        b=WUHgELVC1AUjL/5vOlXKtEl4H51fIg+3uBRF+lX8fyz45oRlUA4RCAwmo08GVz6L+m
         tpncx3bUTh+E4yBfk4diddflMbIrb9/ZFRUrDjM0UJBfg37XjVI2ELMvGibBUxSvgiUH
         GH097XxMJvAkedwGwl3pTqgFEp8i7wi6XUsLkwEwmj5L3sWDIKDc8d/E37zfCUafPA8R
         5UuOMCwDGHWZjpjArxK4hoGMfPxy5zBlsLfP0D9d1WVI6CPC/C1R2KDsMHfEyRBRyO1k
         UtcL/xap0ESLkWMOsq0q4tcyf4hsMmAri9CD71sg9tE9woClIglhfunSd60nwHELPgXE
         kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894930; x=1711499730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iivMpJVqhfyzonHOxre7J+bRKHRX9ehBdH0rm4sUurE=;
        b=d8BJwcaCvXRALl412laRbd2IAxF3+ZjcuucCpid/4AKvRRMdfgLzd0eM1/vWc2DfZr
         bB1WJ4f+agFL//FvPMZeLW1d9zC4NJpiZIDrsLPhpxb18rqoeYjRIR8YRw/5GkCAvIhy
         wk3f10ml7fqCblazLRz9S3ZFJqRNjbjAGdmXIXfejClh28dHnjs2Y/tP5SUASgHvvJvF
         r49hEsGGwL8J/fY1yE27VYnPB949sH5Za+zm6I7NmXEFu/fQ+7215XoNY0dKDL0tEWQW
         oTCFxtkpTN5do9/mmpQjXSiaEx1qw7NosHDEbJaiDIjM0xnK8CsG2TEndJFUlcmqbTKS
         gWzg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDOcS77polpx5aAAgHN+ws7Ku2V0i1SE+BIiXvKbdlym5DklmrxSmafsBWesUM3xpWF3kgrAADkbKVrUXp2M3/NA6oq+YVQFt+HyxHxKD3djj
X-Gm-Message-State: AOJu0Yx+oaS69Tp3YbxGxAeI8v2X7I4vyvT/TU6A3y+cK5VbNyEo0o8K
	fmOdGWBD0Jc3orHL7L8FdxsLJPQDxHnjxh+NPlQHAMVBr1Z+uAINXLi/ZvYY2w==
X-Google-Smtp-Source: AGHT+IHL5M1Y99f/4ysXVs8RyF/LnwoomQGXivL3Tqb5JP1fIdQh86qmd50vXgbwJFBJRpBWgsNT+Q==
X-Received: by 2002:a6b:7119:0:b0:7cc:7d9f:b659 with SMTP id q25-20020a6b7119000000b007cc7d9fb659mr4478105iog.12.1710894930542;
        Tue, 19 Mar 2024 17:35:30 -0700 (PDT)
Received: from google.com (26.103.132.34.bc.googleusercontent.com. [34.132.103.26])
        by smtp.gmail.com with ESMTPSA id w13-20020a6bf00d000000b007cbfbda1bd5sm2588952ioc.53.2024.03.19.17.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:35:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 00:35:25 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, ndesaulniers@google.com, morbo@google.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler_types: Ensure __diag_clang() is always
 available
Message-ID: <qn6cklc5fvjg4cnvavyncj73qmc6k5eyzrmpqsrkpaihi35per@3k2sodhtlcnt>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
 <20240319-tracing-fully-silence-wstring-compare-v1-1-81adb44403f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-1-81adb44403f5@kernel.org>

Hi,

On Tue, Mar 19, 2024 at 09:07:52AM -0700, Nathan Chancellor wrote:
> Attempting to use __diag_clang() and build with GCC results in a build
> error:
> 
>   include/linux/compiler_types.h:468:38: error: 'ignore' undeclared (first use in this function); did you mean 'inode'?
>     468 |         __diag_ ## compiler(version, ignore, option)
>         |                                      ^~~~~~
> 
> This error occurs because __diag_clang() is only defined in
> compiler-clang.h, which is only included when using clang as the
> compiler. This error has not been seen before because __diag_clang() has
> only been used in __diag_ignore_all(), which is defined in both
> compiler-clang.h and compiler-gcc.h.
> 
> Add an empty stub for __diag_clang() in compiler_types.h, so that it is
> always defined and just becomes a no-op when using GCC.
> 
> Fixes: f014a00bbeb0 ("compiler-clang.h: Add __diag infrastructure for clang")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/linux/compiler_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3e64ec0f7ac8..fb0c3ff5497d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -461,6 +461,10 @@ struct ftrace_likely_data {
>  #define __diag_GCC(version, severity, string)
>  #endif
>  
> +#ifndef __diag_clang
> +#define __diag_clang(version, severity, string)
> +#endif
> +
>  #define __diag_push()	__diag(push)
>  #define __diag_pop()	__diag(pop)
>  
> 
> -- 
> 2.44.0

Thanks
Justin
