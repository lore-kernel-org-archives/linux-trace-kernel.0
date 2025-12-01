Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00921883E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615694; cv=none; b=CsEs9Mk426LjtXo2slaL2zgIS1Vjoe2Hhza4f99cKkIfQo+HvT1t+dwkov6BiIvcUNrZ1BtbGs0Y9Xi8PbkGoSn2yngKkr2KvJbjjv6s+btHdPGFa5Bcs4gHwEGC3CVklBqLf/C0RExleqxqNm0QU8XSQJ2QO9vpfQJld6q+niY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615694; c=relaxed/simple;
	bh=dWJOrNJ8c11W6SAEUphyoYaYBQYmWlpJIwa3abF1KJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mcwGNk14ZYqLRpBeZMvTppAxtJMxKh5ymqOL6UEN/cHMiOrK5nKGpbV1YJCNb9n/XNiYMpUyUfHDNivab7c8XMASgmedeJDurbd325ZDuVcTscun5YJub68encihZYuwzgFTr0AtVqLRkTJ/iElt998XWeH98/cm1XAjuIvb1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QpS10j4C; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QpS10j4C"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso1049178f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 11:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764615690; x=1765220490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzJeas8LPFGypXbCtT1+U1OrcCvq4t/9azfoNFwruuE=;
        b=QpS10j4CU3kIqGJIHWBflKwNjBx1tp3VbsqmaBaK6MaaIt7mEMEhH2OFHbAyC22mm4
         Wub2nokX7k7IeoDIFCiR+puTPcFUPu+TwMTpG+448YzuE8qShaCWuQp6fxO2zJ9683oI
         1YdRLwImzO8BKHEJxuDantihbImx+v8ts9VBLZyVWK6Q+sfehSuAFgG9HVzaWL977pmO
         RPK8bpYY+zGAB6lXgPZJgEzvusx73PEoB/8B3+ROY8SZJ3o9INhDVlRp4JuD/k7IGPfP
         ajPT7HNd41M99rHPv90e8yg7ff8xzyIIKin1P+qJrG+53TPSvrlHG3RuM90GBNV8R4Mf
         IPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615690; x=1765220490;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzJeas8LPFGypXbCtT1+U1OrcCvq4t/9azfoNFwruuE=;
        b=RZZMGKvnRCzhveU8PVVvjsUIpvQBcF1Tpp+qYXZ6/CNfGMj+ILsZYGjQO1isNSra5H
         ER3ZI5UIzSECKNYVOG7F/DWCYa+W2ogpqkzVCpZLiN4yPx7GCp0m6GJCLPLzjEzyDAtA
         b810gzCmRTRU5LXcrz+60czqdcYJah/0hYTiTo5Ab4k7qT8MWlr4fgZZWDZW5agTfrcy
         +X1oheppoO5dAeZ/PllqZX848olU3x4iY14NK1Ar1c89Uk1GWLHRoNB/xUY0JqPMkuqM
         Pr6qRe5mrY5+Ee1TLkXRb7eNwZgvr9w/WLQKzzAkWjRw2lYjXcKtvbWkld514Ep+lwUT
         EdGg==
X-Forwarded-Encrypted: i=1; AJvYcCVl5z0j8ezSDFR1OEwzewAzQsOsyX2znprZExkIjsMw8KOKSuC3/ZUAML01nQ9Tg813rTtl93KlJvkZCiusuq5Xkv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGm7sCLxTBieLaHAmnYXm/nduw+rJsWHomCgSx8dp0C2asmN7
	ONCTpT6KSFkECRjjfKlBW2PlZLQTYM19XFZYiDC8tgziuCMxr2v9eUk0gqv2wi/HnhM=
X-Gm-Gg: ASbGnctkygUgbWFm1v990eClrjziBF1xBZF3KykX1FhaJ2DEffvfr57C1GVyBxIEgqk
	XWB3OomHhP/Has8W6GnomtPED1bRshuv+e8CQWQ3jtdmghdaTFnb9UywwQbd+k+PWtjI+Fw8A5M
	5vTPsRtLvlQVljmsglt+LMOxsZLcJ0acG0MjSsTR6vGqa9sw0ooHo0geS5wNvkuYuvq+qBrxc66
	S32H1n3VFqOx+Lt5EIbrqzrHn7EF1BYeEgdf/vmAfu9evGxzjhSvA4OGG/P0qCrpQH493jIzuU/
	VM2ouga5hTycXgVmC4VuUUDtXGkJVp34TGibQQPWJjV3J6z8cgFVZj05JhJsv8zg6/87O31/NMJ
	X/JZFaY+OxD6iUXPT5g54R4byf9mIHaBgVWbkTKXMY459APbMynwBKTfyK4vvG8kB1lPWJ//rI9
	28v3m+JLJrM6QTu8ysytbPleOMDDaBwQ==
X-Google-Smtp-Source: AGHT+IH5FuCKsYMYPN+g8M+3ojhMVERFE+79odP4YJ9nnFhLMkIpgzWhG8yjjilqJh37A6fSs2EzPw==
X-Received: by 2002:a05:6000:2085:b0:429:ed90:91dd with SMTP id ffacd0b85a97d-42cc1ab6bf9mr43260446f8f.6.1764615688217;
        Mon, 01 Dec 2025 11:01:28 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c304csm27574737f8f.8.2025.12.01.11.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 11:01:27 -0800 (PST)
Message-ID: <c45058d5-d690-4731-85d1-434971c16f92@suse.com>
Date: Mon, 1 Dec 2025 20:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
Content-Language: en-US
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251129195304.204082-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 8:53 PM, Yury Norov (NVIDIA) wrote:
> The macro is related to sysfs, but is defined in kernel.h. Move it to
> the proper header, and unload the generic kernel.h.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  include/linux/kernel.h      | 12 ------------
>  include/linux/moduleparam.h |  2 +-
>  include/linux/sysfs.h       | 13 +++++++++++++
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> [...]
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 6907aedc4f74..4e390a84a8bc 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -4,7 +4,7 @@
>  /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
>  #include <linux/init.h>
>  #include <linux/stringify.h>
> -#include <linux/kernel.h>
> +#include <linux/sysfs.h>

If you are removing the kernel.h include from
include/linux/moduleparam.h, I think it would be good to update the file
to ensure that all necessary includes are now listed directly.

The following items are present in moduleparam.h:

* __UNIQUE_ID(), __used(), __section(), __aligned(), __always_unused()
  -> linux/compiler.h,
* THIS_MODULE -> linux/init.h,
* __stringify() -> linux/stringify.h,
* u8, s8, u16, ... -> linux/types.h,
* static_assert() -> linux/build_bug.h,
* VERIFY_OCTAL_PERMISSIONS() -> linux/sysfs.h,
* ARRAY_SIZE() -> linux/array_size.h.

I suggest then updating the includes in include/linux/moduleparam.h to:

#include <linux/array_size.h>
#include <linux/build_bug.h>
#include <linux/compiler.h>
#include <linux/init.h>
#include <linux/stringify.h>
#include <linux/sysfs.h>
#include <linux/types.h>

-- 
Thanks,
Petr
