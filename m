Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C839FD9;
	Tue, 12 May 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544018; cv=none; b=rLhJQuJZekhdg6vY7RPvg/dPEDBd0F8uLBF3sWDxU4xgzpWvWvb3i18R5CjYD4/NJUY4IFByBBmX39N+AdYZaigTtfAZEzNnl6jKIC2tMno0YlxWJS0vJwbONAI3uN0yAsqALzjyOpmDjN9c+A9RqA+hrXec1mC5j1vPqoxKJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544018; c=relaxed/simple;
	bh=y7/1fl/gDBIOv0av7nWWplwKO8Os9Cu9AgnqqyT7uJI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rc+ZSoqxuG4qL4Ku/wGHC2jyJrPhSZnek4K5J/DN73RAZ/iiTOHb9zEGa4U9bPhSl314wNvs2bpFUH6Jc233rTEmwkzpcIGV47opE4efBGzNDTvxO5QFM6ReK24QdwSQagBh3uzMq05oV46MbKcYf46ceRF3S1+cMqfTVdGBQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlEAQ3u4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlEAQ3u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D4BC2BCB0;
	Tue, 12 May 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544017;
	bh=y7/1fl/gDBIOv0av7nWWplwKO8Os9Cu9AgnqqyT7uJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlEAQ3u4Nwfk3JOnJWzteEC9V8eEA7B73Oh/DT9KlQkKLShXgN8JsXqB+TLG3APEr
	 +VwFrdsVwmFzNTybD78cPUUGWjClExzMaSXiEQUPe9I0dqO6nIeBL/SUxwNty+W5tt
	 MDYeX+RnaZxcg4Q2qTnnogvu33y/CVtHSoJGFnzzLU5UYlPWMLSB/DwCWnYqB37/Sj
	 hS6ZR7BwhTVSCCc4HQU9cwTQs+clQQxG0c3QmEYiZ/N9XMHaH7Eu92PRRoq1oxXVLs
	 Y1dWCmdcevOpZkTtj1LCPcgj5t8a95XmXNDtNwgLkUNBLl2i8OPm714XfMhMia/ZcB
	 /vHv4biwyj7hQ==
Date: Tue, 12 May 2026 09:00:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, oss@malat.biz,
 kernel-team@meta.com
Subject: Re: [PATCH 2/2] tools/bootconfig: render kernel.* subtree as
 cmdline string with -C
Message-Id: <20260512090012.53721e4fd518f209e70ff656@kernel.org>
In-Reply-To: <20260508-bootconfig_using_tools-v1-2-1132219aa773@debian.org>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
	<20260508-bootconfig_using_tools-v1-2-1132219aa773@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 06:55:04 -0700
Breno Leitao <leitao@debian.org> wrote:

> Add a -C option that finds the "kernel" subtree of a bootconfig file
> and prints it as a flat, space-separated cmdline string by calling the
> shared xbc_snprint_cmdline() renderer. An empty or absent kernel.*
> subtree produces empty output and exits successfully.
> 
> This lets the kernel build embed a bootconfig file as a plain cmdline
> string at build time, so embedded bootconfig values can reach
> parse_early_param() during architecture setup without parsing the
> bootconfig at runtime.
> 
> The renderer is intentionally limited to the kernel.* subtree: that is
> the only thing the kernel build needs to embed; init.* and other
> subtrees keep going through the runtime parser.
> 
> Example of this new mode:
> 	# cat /tmp/test.bconf
> 	kernel {
> 		foo = bar
> 		baz = "hello world"
> 		arr = 1, 2
> 	}
> 	init.foo = nope
> 
> 	# ./tools/bootconfig/bootconfig -C /tmp/test.bconf
> 	foo=bar baz="hello world" arr=1 arr=2 %
> 

Nice! Looks good to me. Let me pick it.

Thanks,

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/bootconfig/main.c | 60 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 643f707b8f1da..e1bfab044fbcb 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -286,7 +286,41 @@ static int init_xbc_with_error(char *buf, int len)
>  	return ret;
>  }
>  
> -static int show_xbc(const char *path, bool list)
> +static int show_xbc_kernel_cmdline(void)
> +{
> +	struct xbc_node *root;
> +	char *buf = NULL;
> +	int len, ret;
> +
> +	root = xbc_find_node("kernel");
> +	if (!root)
> +		return 0;	/* no kernel.* keys: emit empty output */
> +
> +	len = xbc_snprint_cmdline(NULL, 0, root);
> +	if (len < 0) {
> +		pr_err("Failed to size cmdline output: %d\n", len);
> +		return len;
> +	}
> +	if (len == 0)
> +		return 0;
> +
> +	buf = malloc(len + 1);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = xbc_snprint_cmdline(buf, len + 1, root);
> +	if (ret < 0) {
> +		pr_err("Failed to render cmdline output: %d\n", ret);
> +		free(buf);
> +		return ret;
> +	}
> +
> +	fputs(buf, stdout);
> +	free(buf);
> +	return 0;
> +}
> +
> +static int show_xbc(const char *path, bool list, bool render_cmdline)
>  {
>  	int ret, fd;
>  	char *buf = NULL;
> @@ -322,11 +356,14 @@ static int show_xbc(const char *path, bool list)
>  		if (init_xbc_with_error(buf, ret) < 0)
>  			goto out;
>  	}
> -	if (list)
> +	if (render_cmdline)
> +		ret = show_xbc_kernel_cmdline();
> +	else if (list)
>  		xbc_show_list();
>  	else
>  		xbc_show_compact_tree();
> -	ret = 0;
> +	if (ret > 0)
> +		ret = 0;
>  out:
>  	free(buf);
>  
> @@ -486,7 +523,10 @@ static int usage(void)
>  		" Options:\n"
>  		"		-a <config>: Apply boot config to initrd\n"
>  		"		-d : Delete boot config file from initrd\n"
> -		"		-l : list boot config in initrd or file\n\n"
> +		"		-l : list boot config in initrd or file\n"
> +		"		-C : render the kernel.* subtree as a flat cmdline\n"
> +		"		     string (suitable for embedding in a kernel image)\n"
> +		"		     and print it to stdout\n\n"
>  		" If no option is given, show the bootconfig in the given file.\n");
>  	return -1;
>  }
> @@ -495,10 +535,11 @@ int main(int argc, char **argv)
>  {
>  	char *path = NULL;
>  	char *apply = NULL;
> +	bool render_cmdline = false;
>  	bool delete = false, list = false;
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hda:l")) != -1) {
> +	while ((opt = getopt(argc, argv, "hda:lC")) != -1) {
>  		switch (opt) {
>  		case 'd':
>  			delete = true;
> @@ -509,14 +550,17 @@ int main(int argc, char **argv)
>  		case 'l':
>  			list = true;
>  			break;
> +		case 'C':
> +			render_cmdline = true;
> +			break;
>  		case 'h':
>  		default:
>  			return usage();
>  		}
>  	}
>  
> -	if ((apply && delete) || (delete && list) || (apply && list)) {
> -		pr_err("Error: You can give one of -a, -d or -l at once.\n");
> +	if ((!!apply + !!delete + !!list + !!render_cmdline) > 1) {
> +		pr_err("Error: You can give one of -a, -d, -l or -C at once.\n");
>  		return usage();
>  	}
>  
> @@ -532,5 +576,5 @@ int main(int argc, char **argv)
>  	else if (delete)
>  		return delete_xbc(path);
>  
> -	return show_xbc(path, list);
> +	return show_xbc(path, list, render_cmdline);
>  }
> 
> -- 
> 2.53.0-Meta
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
