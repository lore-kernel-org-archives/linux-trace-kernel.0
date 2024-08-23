Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64830188A1A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432017; cv=none; b=NfehXZ1A+TcCxPXfwuq1YlcuxZ2rvC98Sf0SE7kXA3UuJyN2T2W+AMZF/iCFvP68xR+/GlPwc2n4HvMxSiT/Zwt/Qak4+M+eE8MVdapdezFDkkhwZ36ze6xzoNkCJNA/MSGe1q+MW0lJfED6Rm7ETtsVQKOXR0UCRnUjyqpphhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432017; c=relaxed/simple;
	bh=aDkpA7sHahzJz4O9pRbiLPc1/ZZRyODcWl1oN47eeaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EofMOv9iMqR21IMUEBpQBfFdb1ufFdUAJO17ZGhXfGvlkbfXIrxU6++7zpJs/28wiDnRJwR0a6fzhSPW8ZeRg4wqQpZBwhuTcUbf/uD26gLW7S6IXtDOWfRQDVqMGK7GmUi1j2N/fHHKj8tOF5HWXIgoGLVJjF3JTD8BDIEUqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIQRBdnK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIQRBdnK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20353e5de9cso5475ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724432015; x=1725036815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9vuB8hri5qT5waMZfq5Z57S5cjCFURsSroxNeC6uFQ=;
        b=GIQRBdnKjWLO8NZRXd4rPBJAyQlTM03PH68eiSIHsTjzD+G5iGqRsC2n4p8wUzHrJk
         6Kft7nS6zjObwTLPotD9xGN3Ui3WOT0wNAw+Lc0V/JIonTqF1DcR7qyuY8cqKVnXuQKx
         T2bPuVdDkLUWKn2KSLGUrhgp1m3ZEauSNGx5n0cz2qVRhOIvuL7FxRL75jooefqYrITO
         iusgdNojqs8tYVM4owqLhCaw4d4CJl2mCF51uEIiFRfXQtRbfTEeW0HecQvFPKqfrIsj
         B5pwddchk8Ha/PoFLoMuvhzJ2c/HUZpo0PThI2E6NdVlk0pZ/ePP9RApvUqiXWd1cicZ
         fJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432015; x=1725036815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9vuB8hri5qT5waMZfq5Z57S5cjCFURsSroxNeC6uFQ=;
        b=GZZfSXRPZXPlIWCAJMe9w8ZjGAS750fUfmZsLtp55kMJFBkQV200uywgIRMf9rNxVG
         l48bfS7UZaGFZx9mWUIri47uJCQtIG/yKwCXHFLaCUmzELWJbHVmi8VV7c+Rx3aeYc5Q
         8JPJOmHOhkBpOyXIVJihjWRZnyxHdvrVeadJ44MDGsE1Fh0xPO0uWtmf+I0nIIUFoG95
         W5HevbPup6iC7E21KrUftA3E6JXsBGu40JXsA5lnjlRXVMo6rP82LoSE8osh8s1ONFKT
         KWDyYYGz3we1wMl7qe3e+TQ3EWNYHOYE5LJYwipS4hzUVOFJM6q4ZJVcL1ESwUgu1ltH
         7ekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMd6ju2/XGUWMCyeRLsad77ScCtvW8XCSZcSCPIZlctVZbljZz+52WtbpIyuILdkKZ6E26FSjWO0WuChOwRTd0E/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NFB4YiQa13pXHIa/WjAYIG/2AsCxKFZfZNefTiYwTi76Wscf
	Nd4M/cM+X+ww+uaJvdeyL5ffdvWA8Zw9Z5PInGJyFJrhZrXij4BJI8qfwU/p4g==
X-Google-Smtp-Source: AGHT+IFANpB3IAM/PQyhB7gp4T27UHfGZDu+u0nU1K65J/w+iVbYyN/ffreaJCEYq84wnORw5ooKPQ==
X-Received: by 2002:a17:902:e84f:b0:201:cdd1:b65d with SMTP id d9443c01a7336-2039a253467mr3509205ad.28.1724432015199;
        Fri, 23 Aug 2024 09:53:35 -0700 (PDT)
Received: from google.com (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b2048fsm4349250a91.54.2024.08.23.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:53:34 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:53:29 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Kris Van Hees <kris.van.hees@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Nick Alcock <nick.alcock@oracle.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH v8 2/4] kbuild: generate offset range data for builtin
 modules
Message-ID: <20240823165329.GA3911831@google.com>
References: <20240821040700.1919317-1-kris.van.hees@oracle.com>
 <20240822181942.2626536-1-kris.van.hees@oracle.com>
 <20240822181942.2626536-3-kris.van.hees@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822181942.2626536-3-kris.van.hees@oracle.com>

Hi Kris,

On Thu, Aug 22, 2024 at 02:19:39PM -0400, Kris Van Hees wrote:
> diff --git a/scripts/generate_builtin_ranges.awk b/scripts/generate_builtin_ranges.awk
> new file mode 100755
> index 000000000000..68df05fd3036
> --- /dev/null
> +++ b/scripts/generate_builtin_ranges.awk
> @@ -0,0 +1,505 @@
> +#!/usr/bin/gawk -f
> +# SPDX-License-Identifier: GPL-2.0
> +# generate_builtin_ranges.awk: Generate address range data for builtin modules
> +# Written by Kris Van Hees <kris.van.hees@oracle.com>
> +#
> +# Usage: generate_builtin_ranges.awk modules.builtin vmlinux.map \
> +#		vmlinux.o.map > modules.builtin.ranges
> +#
> +
> +# Return the module name(s) (if any) associated with the given object.
> +#
> +# If we have seen this object before, return information from the cache.
> +# Otherwise, retrieve it from the corresponding .cmd file.
> +#
> +function get_module_info(fn, mod, obj, s) {
> +	if (fn in omod)
> +		return omod[fn];
> +
> +	if (match(fn, /\/[^/]+$/) == 0)
> +		return "";
> +
> +	obj = fn;
> +	mod = "";
> +	fn = substr(fn, 1, RSTART) "." substr(fn, RSTART + 1) ".cmd";
> +	if (getline s <fn == 1) {
> +		if (match(s, /DKBUILD_MODFILE=['"]+[^'"]+/) > 0) {
> +			mod = substr(s, RSTART + 16, RLENGTH - 16);
> +			gsub(/['"]/, "", mod);
> +		}
> +	}

This doesn't work with built-in Rust modules because there's no
-DKBUILD_MODFILE flag passed to the compiler. The .cmd files do have
RUST_MODFILE set though, so presumably you could match that too?

Sami
