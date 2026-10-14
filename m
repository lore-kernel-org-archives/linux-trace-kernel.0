Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF78361DBF;
	Wed, 14 Oct 2026 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950772; cv=none; b=CtZ4s562ddH5f6M8AE62q9EAYA7T+DHEMdZDlmD8cZ+xcP7vPJFx6v0hLmfuhPYGKsxkUV0ydCOMCltmqZ+Xhowu7NRdZju1/8W14v+FqyIhoAc3XsEowDKUr98zz/p63mkxM72aBycUuat8ZC37+6WNtafwxryyohpXBaM+u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950772; c=relaxed/simple;
	bh=LH2w2e58s0hMh/1Ujw4HzDq1xyZUpLVa95o5G0UmSU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhcJ6bfrXMvgDc6kbc5dBtWPT9UXOuwfsfyXOG/BTHxvV+14ZP21fS9CrryLXdJUkGLHIlhJ2yXPGX14ni872AWOZ1R6jirD9k9w+Y1tMKtW2t14mWqblBpBa4DclC1B1fxKkSLIGxO22FqWEN6cW1KGbqMxAHGgp6JCXKGIfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Ad1cpx1U; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Ad1cpx1U"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4j4HfQ2T6zz9DPn;
	Wed, 14 Oct 2026 06:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791950702;
	bh=LH2w2e58s0hMh/1Ujw4HzDq1xyZUpLVa95o5G0UmSU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ad1cpx1U6z8j2+N6hb7YzJmrIzkAqvtdWE7PFP4Orlbs1VO9gIHMFvZXLPOx3yvRc
	 pD4mo2j2Pd2KmYWs10BoYKiJHPrOUCVG2CynwgIMbtambWOmiA4or2/D/q/76VJywz
	 Ju5yxWXpye8e/6asQeUius1lFi2wVTIaBuX1qAHuDKCkNLgtbOXHWxw5JPrJ59gjoa
	 g6aJJv98vL2FTTb0Fv0fqIhjnSEdluh5F5hDjWzcUc5ir1KyEnGZi7/GR1AmXvKirM
	 PMKHes+GxgOWITnGutH9ZTIXXBD/HrwZCcxH7dp+VWe/AtDzhyYB2jnNlJFisdB+xa
	 wMd5wa+DZdymw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4j4HfQ1msjz7x0H;
	Wed, 14 Oct 2026 06:05:02 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j4HfP2HLSz8svC;
	Wed, 14 Oct 2026 06:05:01 +0200 (CEST)
Received: from [192.168.44.19] (unknown [185.238.219.103])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0491C5FAB2;
	Wed, 14 Oct 2026 06:04:53 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 185.238.219.103) smtp.mailfrom=linux@leemhuis.info smtp.helo=[192.168.44.19]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1dcf2ee8-02f7-41af-b1f4-bff3a16a2c90@leemhuis.info>
Date: Wed, 14 Oct 2026 06:04:52 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Sang-Heon Jeon <ekffu200098@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
 <178913599508.248794.10388592925402087434.stgit@devnote2>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <178913599508.248794.10388592925402087434.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179195069455.2974564.12429534590425620214@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 0491C5FAB2
X-NC-CID: w5HpWYNoY9cxHDgAmgfF+y8E30IDI+j8dB0WDZ/1Wi62gDjJixg=

On 9/11/26 16:13, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use init_xbc_with_error() for all bootconfig initialization in the
> bootconfig tool instead of showing errors in different way.
> 
> This simplifies the code logic and make it easy to maintain.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Masami, Andrew, this patch is now twice in -next:

e732d7c18d4d6a ("tools/bootconfig: consolidate xbc_init() to error
message wrapper") [merged via: "9eae8e94e61f20 ("Merge branch
'mm-nonmm-stable' of
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")"; next-20261012]

78715511921cc8 ("tools/bootconfig: Consolidate xbc_init() to error
message wrapper") [merged via: "71ee85976d09e8 ("Merge branch 'for-next'
of
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git")";
next-20261013]

Which I guess it what caused this build error for me:
""">> main.c:53:13: error: redefinition of ‘show_xbc_error’
>>    53 | static void show_xbc_error(const char *data, const char *msg, int pos)
>>       |             ^~~~~~~~~~~~~~
>> main.c:20:13: note: previous definition of ‘show_xbc_error’ with type ‘void(const char *, const char *, int)’
>>    20 | static void show_xbc_error(const char *data, const char *msg, int pos)
>>       |             ^~~~~~~~~~~~~~
>> main.c:74:12: error: redefinition of ‘init_xbc_with_error’
>>    74 | static int init_xbc_with_error(char *buf, int len)
>>       |            ^~~~~~~~~~~~~~~~~~~
>> main.c:41:12: note: previous definition of ‘init_xbc_with_error’ with type ‘int(char *, int)’
>>    41 | static int init_xbc_with_error(char *buf, int len)
>>       |            ^~~~~~~~~~~~~~~~~~~
>> main.c:41:12: warning: ‘init_xbc_with_error’ defined but not used [-Wunused-function]
>> make: *** [Makefile:21: bootconfig] Error 1
"""
Ciao, Thorsten

> ---
> Changes in v2:
>  - Remove redundant buffer copy in init_xbc_with_error().
> ---
>  tools/bootconfig/main.c |  100 ++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index aff169ba75b8..652e491b9c33 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -21,6 +21,39 @@
>  #define BOOTCONFIG_FOOTER_SIZE	\
>  	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
>  
> +static void show_xbc_error(const char *data, const char *msg, int pos)
> +{
> +	int lin = 1, col, i;
> +
> +	if (pos < 0) {
> +		pr_err("Error: %s.\n", msg);
> +		return;
> +	}
> +
> +	/* Note that pos starts from 0 but lin and col should start from 1. */
> +	col = pos + 1;
> +	for (i = 0; i < pos; i++) {
> +		if (data[i] == '\n') {
> +			lin++;
> +			col = pos - i;
> +		}
> +	}
> +	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
> +
> +}
> +
> +static int init_xbc_with_error(char *buf, int len)
> +{
> +	const char *msg;
> +	int ret, pos;
> +
> +	ret = xbc_init(buf, len, &msg, &pos);
> +	if (ret < 0)
> +		show_xbc_error(buf, msg, pos);
> +
> +	return ret;
> +}
> +
>  static int xbc_show_value(struct xbc_node *node, bool semicolon)
>  {
>  	const char *val, *eol;
> @@ -197,7 +230,6 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	int ret;
>  	uint32_t size = 0, csum = 0, rcsum;
>  	char magic[BOOTCONFIG_MAGIC_LEN];
> -	const char *msg;
>  
>  	ret = fstat(fd, &stat);
>  	if (ret < 0)
> @@ -249,52 +281,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  		return -EINVAL;
>  	}
>  
> -	ret = xbc_init(*buf, size, &msg, NULL);
> -	/* Wrong data */
> -	if (ret < 0) {
> -		pr_err("parse error: %s.\n", msg);
> -		return ret;
> -	}
> -
> -	return size;
> -}
> -
> -static void show_xbc_error(const char *data, const char *msg, int pos)
> -{
> -	int lin = 1, col, i;
> -
> -	if (pos < 0) {
> -		pr_err("Error: %s.\n", msg);
> -		return;
> -	}
> -
> -	/* Note that pos starts from 0 but lin and col should start from 1. */
> -	col = pos + 1;
> -	for (i = 0; i < pos; i++) {
> -		if (data[i] == '\n') {
> -			lin++;
> -			col = pos - i;
> -		}
> -	}
> -	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
> +	ret = init_xbc_with_error(*buf, size);
>  
> -}
> -
> -static int init_xbc_with_error(char *buf, int len)
> -{
> -	char *copy = strdup(buf);
> -	const char *msg;
> -	int ret, pos;
> -
> -	if (!copy)
> -		return -ENOMEM;
> -
> -	ret = xbc_init(buf, len, &msg, &pos);
> -	if (ret < 0)
> -		show_xbc_error(copy, msg, pos);
> -	free(copy);
> -
> -	return ret;
> +	return ret < 0 ? ret : size;
>  }
>  
>  static int show_xbc_kernel_cmdline(void)
> @@ -423,9 +412,8 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	char *buf, *data;
>  	size_t total_size;
>  	struct stat stat;
> -	const char *msg;
>  	uint32_t size, csum;
> -	int pos, pad;
> +	int pad;
>  	int ret, fd;
>  
>  	ret = load_xbc_file(xbc_path, &buf);
> @@ -438,6 +426,13 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  		size++;
>  	csum = xbc_calc_checksum(buf, size);
>  
> +	/* Verify the data format */
> +	ret = init_xbc_with_error(buf, size);
> +	if (ret < 0) {
> +		free(buf);
> +		return ret;
> +	}
> +
>  	/* Backup the bootconfig data */
>  	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
>  	if (!data) {
> @@ -446,15 +441,6 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	}
>  	memcpy(data, buf, size);
>  
> -	/* Check the data format */
> -	ret = xbc_init(buf, size, &msg, &pos);
> -	if (ret < 0) {
> -		show_xbc_error(data, msg, pos);
> -		free(data);
> -		free(buf);
> -
> -		return ret;
> -	}
>  	printf("Apply %s to %s\n", xbc_path, path);
>  	xbc_get_info(&ret, NULL);
>  	printf("\tNumber of nodes: %d\n", ret);

