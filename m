Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8922FFDEA;
	Sat, 12 Sep 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220920; cv=none; b=g4AEE5VDxxMC0hIN+lwLJy1bsO/a1pr8QzPYXS+z9PCyD4ALfQ5H4V051pD9ckpakhXWKLRSQNYPVgHOPLNvTj6UwNYm+D9HA5rmdyUkWyXqp+8cWhMSUiK7pdRMN6ZMMINSOc24GGf3EL0m86TGkczy/8eT/II5Od9ds/L4RZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220920; c=relaxed/simple;
	bh=gOxsz5HXT0QCByERbuD1MVZYSovffvRkqFf7umhpBxc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S2T3FGL//sLjKNKzQgZFWMoccV+LV7ssd9y0Hz1+ZV1NVBXhqKHKRQQU+x14uG3Dpkm0JoS4WH05PqSG0DsYKwZ8Q2cygs0gnzONVsM0P698TueSpfzfclwtcq3aamCs0TQNHD/KalMRRWjyZYQ0dY3HQRZ3j8XolOyeMEwCDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ/26ACE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ/26ACE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7D21F000FF;
	Sat, 12 Sep 2026 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789220919;
	bh=0VJ/mqw67OyMvnuaO2K3Ir8jJ5ldSDsZMgF3x779aBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UZ/26ACEkZcAzY6sFn3ZLsGshe3F1rBNIrPl7fQQefKof+NVcONv/Pf6U5/xvS4RQ
	 tz2zCXRjabth5zjM63h3IUgerHvKXqcyWA919XYYcqVTTaMToC4Q1MgCdp+HWshsb0
	 cuRWGK5/PLqQbv7GDorhVbExBkmA9pE2XXAQUOzE+zKEEBntc9i16fY2g8Hwstpqx3
	 0xFXetnFd2np1pEhjPE6kfc+VTm3T1lv1/g2Sj/JpGetRkxPB42aUSyGvS6P802fIJ
	 hC6jTauX9MvXhAHRsY3Nrka8ktIyyUd+/f3vw91VFEWi28U2VHsmTUqzMfS43fhadQ
	 40xR6qp0H3HKQ==
Date: Sat, 12 Sep 2026 22:48:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v2 0/4] bootconfig: Reject unexpected data after null
 character and cleanups
Message-Id: <20260912224835.4e5f73b44cee39387554cc70@kernel.org>
In-Reply-To: <20260911155911.1cccfa39dd2e3c6e3a84e03f@linux-foundation.org>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
	<20260911155911.1cccfa39dd2e3c6e3a84e03f@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 15:59:11 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 11 Sep 2026 23:12:56 +0900 "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here are v2 patches for bootconfig to rejects unexpected config data after
> > null character and other cleanups including tools/bootconfig to consolidate
> > bootconfig initialization with errors, and skipping internal tree sanity
> > check in kernel.
> > 
> > ...
> >
> 
> Thanks, I've updateed mm.git's mm-nonmm-unstable branch to this version,
> 
> > This version removes redundant buffer copy in init_xbc_with_error() [2/4]
> > and moves BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h[4/4].

OK, anyway I'll pick this series to bootconfig/for-next.

Thank you,

> 
> Here's how v2 altered mm.git:
> 
> 
>  include/linux/bootconfig.h |    4 ++++
>  init/main.c                |    2 +-
>  tools/bootconfig/main.c    |   14 +-------------
>  3 files changed, 6 insertions(+), 14 deletions(-)
> 
> --- a/include/linux/bootconfig.h~b
> +++ a/include/linux/bootconfig.h
> @@ -27,6 +27,10 @@ bool __init cmdline_has_extra_options(vo
>  #define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
>  #define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
>  
> +/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
> +#define BOOTCONFIG_FOOTER_SIZE	\
> +	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
> +
>  /**
>   * xbc_calc_checksum() - Calculate checksum of bootconfig
>   * @data: Bootconfig data.
> --- a/init/main.c~b
> +++ a/init/main.c
> @@ -278,7 +278,7 @@ static void * __init get_boot_config_fro
>  	int i;
>  
>  	if (!initrd_end || initrd_end < initrd_start ||
> -	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
> +	    initrd_end - initrd_start < BOOTCONFIG_FOOTER_SIZE)
>  		return NULL;
>  
>  	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> --- a/tools/bootconfig/main.c~b
> +++ a/tools/bootconfig/main.c
> @@ -17,10 +17,6 @@
>  
>  #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
>  
> -/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
> -#define BOOTCONFIG_FOOTER_SIZE	\
> -	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
> -
>  static void show_xbc_error(const char *data, const char *msg, int pos)
>  {
>  	int lin = 1, col, i;
> @@ -44,20 +40,12 @@ static void show_xbc_error(const char *d
>  
>  static int init_xbc_with_error(char *buf, int len)
>  {
> -	char *copy = malloc(len);
>  	const char *msg;
>  	int ret, pos;
>  
> -	if (!copy)
> -		return -ENOMEM;
> -
> -	memcpy(copy, buf, len);
> -	/* We do not terminate the copy with \0 for sanity checking */
> -
>  	ret = xbc_init(buf, len, &msg, &pos);
>  	if (ret < 0)
> -		show_xbc_error(copy, msg, pos);
> -	free(copy);
> +		show_xbc_error(buf, msg, pos);
>  
>  	return ret;
>  }
> _
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
