Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437167B3FE;
	Fri, 21 Jun 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964072; cv=none; b=srP539PoEUMFtIn9KUEjp6B6+dYvy6wS2M2yJBKkcurYx1Qhol8u1qqtTtwtL3a8ETiVJ8cIigTgbMIPLzraFqBObmhHSCkUo89vyUB8P/5qFYMEtJzVO2gE4J72pBxY1HyswOLMYjUtH5wHvIh55uuc30DKvIaFUnXdG/UwyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964072; c=relaxed/simple;
	bh=wPKrzkQ1p8mxJySrPba8vAdcRuxTOwxPvYU6pQ0puRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Rw95Ph+rlCo3DBZ6K+6PlrfTMqb5RB8JJckntWsY8WH7FtHdoiPbjRp7dyR+MzQF2oNjOHH33bESF5zDa/RLHP7ZRAeOAefAu7hqqYy5yrgi7U5aZJsaHpJHLiZljZfknkHZrrkKiZ7/Fcu4WbsvOdC/dq0EOL09DijlPPNdax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THiLSBar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THiLSBar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81F2C2BBFC;
	Fri, 21 Jun 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964071;
	bh=wPKrzkQ1p8mxJySrPba8vAdcRuxTOwxPvYU6pQ0puRA=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=THiLSBar9RgNeSnoVA7TX3onY5xEvoRaTYbd3uAduIfmO5aJKmA30yFnx5GXFYc8J
	 L0weo5p2kk2n+7kkkpe5VTVjMjt8n8XyMiBbVUWneRDRc0H/VbzlXyGFG45dWQVpA5
	 WhLgDH7MKsphS54/KYZOig6/KCCcZevBAfSOGsaUy0EtmM23pLyX8oF1EMYSdEGJiX
	 jK+N7KDKf8dgeF2EYoxKwqw0nakfa3cHaDQOZhcv+QdwEQyT3nw6TkMXnqWXizRQJR
	 QzH4G5lGcssMjRcXiYX+P5ZylG8ZMmfWVI546wf1fwUM1mn2Q2YuHejXV30uhguMNP
	 m0V2ISasAwWYQ==
Message-ID: <240fbd1f-6d39-4b46-ad56-5b1c41286956@kernel.org>
Date: Fri, 21 Jun 2024 12:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: build: use correct lib name for libtracefs feature
 detection
To: Daniel Wagner <dwagner@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240617-rtla-build-v1-1-6882c34678e8@suse.de>
Content-Language: en-US, pt-BR, it-IT
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240617-rtla-build-v1-1-6882c34678e8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/24 20:38, Daniel Wagner wrote:
> Use libtracefs as package name to lookup the CFLAGS for libtracefs. This
> makes it possible to use the distro specific path as include path for
> the header file.

So, I added it to my review branch and tested it. It is fine!

But, as the most important user of this build system is perf, I think
it is safer to ask them to review, test, and integrate it.

I Cc'ing some perf people here, but it might be worth sending a v2 with
all perf crew in Cc.

It is also worth checking which Fixes to use between:

b758a61b391f perf tools: Enable libtracefs dynamic linking
a87834d19aa2 perf build: Fix broken feature check for libtracefs due to external lib changes

To avoid breaking older perf versions.

For rtla,

Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Our downstream packaging stop working. After a bit of didding I found out that
> the libtracefs feature detection is not completely right.
> 
> https://build.opensuse.org/build/benchmark/SLE_15_SP5/x86_64/rtla/_log
> ---
>  tools/build/feature/Makefile          | 2 +-
>  tools/build/feature/test-libtracefs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index ed54cef450f5..489cbed7e82a 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -213,7 +213,7 @@ endif
>  	$(BUILD) -ltraceevent
>  
>  $(OUTPUT)test-libtracefs.bin:
> -	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null) -ltracefs
> +	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
>  
>  $(OUTPUT)test-libcrypto.bin:
>  	$(BUILD) -lcrypto
> diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
> index 8eff16c0c10b..29a757a7d848 100644
> --- a/tools/build/feature/test-libtracefs.c
> +++ b/tools/build/feature/test-libtracefs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <tracefs/tracefs.h>
> +#include <tracefs.h>
>  
>  int main(void)
>  {
> 
> ---
> base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> change-id: 20240617-rtla-build-83020baf9277
> 
> Best regards,

