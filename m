Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D114D2BB;
	Tue, 18 Jun 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699210; cv=none; b=I0cP1H2myu6FP7uhakiGPb9AdJL6d1sXWJkPD3XbDo6Ewdei11jV2qdebW+dcpwIOn7No4eWJv0NCBdgBr4uQkJWRAcBNJVVoVp5hUgIzeSxfCo4iC7mxcJxYA1UaN+iiLBg5mW58cnneI1NuA6g2fo9DJhCujUyadXpQzJ5pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699210; c=relaxed/simple;
	bh=Pm+8c2oq+pxKwk88oQ4kb5hp6lv+Fu4iSSGi4aX+9vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=eKaEVk/0CjOP3bQIMmGtf2PxL8z9RxmXBzuz0cWL8dhjwB33BZ4IEpqT99/9GZGauKHZfpgELO4sFTvaAAT1VPu95fFCGdmLo+0YJRguHDnuM1fhvbp1xEyPttu/UvZnPNGX75BZu5w2QqdLmXmJzFntyv6oxqZm8X+mNXJAv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXTbp1IA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXTbp1IA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F5C3277B;
	Tue, 18 Jun 2024 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718699210;
	bh=Pm+8c2oq+pxKwk88oQ4kb5hp6lv+Fu4iSSGi4aX+9vU=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=KXTbp1IAFiSehwcdqRRBeCUVn4XdHSwZW3FTXtyjRK6G4N3v4AoBkG0ltEp/+ATsx
	 v02n1fmZn4u8hvPgd2Sx/7wp29r68MY39e4huZxsChZhesVnyYgyfFrr2WTEpzP6Ve
	 /IuFCDZKl+RgzGEqbeW7crWqwlu+DJcmSiu4JRbwna6o9nRW8aaBZ0L7LuLOGFfxi/
	 Ad+HUhKxCQiTeMEdLFEqjAQMexfWih5bBvEUzEA36PDkGU7xUA7vTYRUdRT2gJSqdt
	 PFDbM9DSbOGdsRlRDU6hxkZBSBdQWNRD6gM1md0B7G4B9g1BdwdgeDJAQ7vRW2+33L
	 rGzJ9QDtYjKcg==
Message-ID: <852a66f0-7dc4-4736-abd3-7be9efaa3435@kernel.org>
Date: Tue, 18 Jun 2024 10:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: build: use correct lib name for libtracefs feature
 detection
To: Daniel Wagner <dwagner@suse.de>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240617-rtla-build-v1-1-6882c34678e8@suse.de>
Content-Language: en-US, pt-BR, it-IT
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240617-rtla-build-v1-1-6882c34678e8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Arnaldo

On 6/17/24 20:38, Daniel Wagner wrote:
> Use libtracefs as package name to lookup the CFLAGS for libtracefs. This
> makes it possible to use the distro specific path as include path for
> the header file.
> 
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

