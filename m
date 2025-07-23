Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655E1DF24F;
	Wed, 23 Jul 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285071; cv=none; b=jHbFiqQYCtvy6G0Q1ETKkwFdZiCaLJQwfrYS6kew4wQ/i1vzCg9hXt/v9Y4EGJB3k4khNsegnDcuaq8suJeeUecs2GXArcCHo1QiEqGOz08+GEnp4FPh+QBT96yJCSil1t1TRiFFgVQMiMigwsh7f1JqwUHidr3Omvdhc65mhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285071; c=relaxed/simple;
	bh=GkaLzbRmFC1Xm8xfzJ9FdN3snJHt4yOsk0bZUbSNsDA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hJqcEXnd5yo6ViaVllCRw/s+6E/vThMv8n/HN5ZnYhvUKJQGfMYWG2d3CPDWxPFbgbTKyy+4gIZjt7xocdHv9W7UBFKyn9fREV0iti1JDNRy0XPKSbKEMQsDkgOIoqpBAT7DHCcSJ/23uhlsnqXGZGrU86F16NkEr13yf4KutEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYe3g8ss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYe3g8ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04058C4CEE7;
	Wed, 23 Jul 2025 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285071;
	bh=GkaLzbRmFC1Xm8xfzJ9FdN3snJHt4yOsk0bZUbSNsDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYe3g8ss9GLl7NVkp32MA8JIVZZt4Np4NFz5Hfh9U7Etmttw4ZDJySVRByir0p/kJ
	 nHBZUzN0q11u28UmSSjeDabHtVaAWvLyZSa69Q1jOj6ZJsUwJXRSYjHCq5YD6WKZv/
	 ZQSnAIwBrYoemZFPOYAQkq3GERtDMQrVLueDzPq8A7UP109lGNx8HSBCA8xtLw77L4
	 znazvut00D4zSgU9qPqLw0s9e+qynnYtiVHj/M6b46khRWNr/e8m7tqSmx284C9+O7
	 iRytOmoDV1JJfQpRuI81LLmplhYucC3zuV2IyVhlE+hKb5DVNi0W2tSEb6aBwZOF8t
	 jxAqTJG9jSSTA==
Date: Thu, 24 Jul 2025 00:37:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ben Hutchings <benh@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix unaligned access when building footer
Message-Id: <20250724003747.be2a733e2e7fcf8a9e263cc4@kernel.org>
In-Reply-To: <aIC-NTw-cdm9ZGFw@decadent.org.uk>
References: <aIC-NTw-cdm9ZGFw@decadent.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 12:49:25 +0200
Ben Hutchings <benh@debian.org> wrote:

> Currently we add padding between the bootconfig text and footer to
> ensure that the footer is aligned within the initramfs image.
> However, because only the bootconfig data is held in memory, not the
> full initramfs image, the footer may not be naturally aligned in
> memory.
> 
> This can result in an alignment fault (SIGBUS) when writing the footer
> on some architectures, such as sparc.

Aah, got it. 

> 
> Build the footer in a struct on the stack before adding it to the
> buffer.
> 
> References: https://buildd.debian.org/status/fetch.php?pkg=linux&arch=sparc64&ver=6.16%7Erc7-1%7Eexp1&stamp=1753209801&raw=0
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>  tools/bootconfig/main.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 4988e23a1422..57c669d2aa90 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -11,6 +11,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <endian.h>
> +#include <assert.h>
>  
>  #include <linux/bootconfig.h>
>  
> @@ -363,7 +364,12 @@ static int delete_xbc(const char *path)
>  
>  static int apply_xbc(const char *path, const char *xbc_path)
>  {
> -	char *buf, *data, *p;
> +	struct {
> +		uint32_t size;
> +		uint32_t csum;
> +		char magic[BOOTCONFIG_MAGIC_LEN];
> +	} footer;

Don't we need __attribute__((__packed__)) for the footer?

Thank you,

> +	char *buf, *data;
>  	size_t total_size;
>  	struct stat stat;
>  	const char *msg;
> @@ -433,17 +439,13 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	size += pad;
>  
>  	/* Add a footer */
> -	p = data + size;
> -	*(uint32_t *)p = htole32(size);
> -	p += sizeof(uint32_t);
> +	footer.size = htole32(size);
> +	footer.csum = htole32(csum);
> +	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> +	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE);
> +	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
>  
> -	*(uint32_t *)p = htole32(csum);
> -	p += sizeof(uint32_t);
> -
> -	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> -	p += BOOTCONFIG_MAGIC_LEN;
> -
> -	total_size = p - data;
> +	total_size = size + BOOTCONFIG_FOOTER_SIZE;
>  
>  	ret = write(fd, data, total_size);
>  	if (ret < total_size) {


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
