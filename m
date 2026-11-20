Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189395;
	b=FVXfhQuVYo3TaAq+UnYij/7ex173kAKEnuc4YwEsaqYn3MzsQYdbuwd2mHe5oIlGx+kx
	 rdLeq7yp2cIOJ0eUpvfoZnw6OSKs9hCkABPmmnYtxFdCxzhCsGlJs0UQw8AvF3JP4g2lK
	 wfEkCtmGRddm3wmHmddjklWh1WDo0BojZ3iGVoeqBSs4EVD9/9W0klXoeIzYE3V74TYBz
	 ZBatNtE2vjHVK6BkittQ9P9gjj8MKX2NAQMHFCzqSR62h72NgA3fV7OsAmwraAHtnVX6k
	 i92zs+FtWMxc7Gh8s+2TIyWfb02orMe7aqHoDYk4stVBy8lLX5jd1fE9sWF05H34NeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZEN1RjVeah5bf6s6B3kHtNiItihaG3NYeroyXdt03ho=;
	b=xg0qNxB4yW09mfu07bVI7Xmg/D8yyAer9D8HRMF0Nxh7vCghSmkqrKNapXdIQ/xyGV5+
	 3bd0haLbiFl3t44TospFXQQy2nHvQhdGxqziIFuPuamnR6SzbaEIG9vn6TEp86e12ajvS
	 DjUX2FwKz4pbXi4kRc28tKf34BqtXI7Ndmb0lKeNGZjSJ0vRl66sqwnQpm0Ak6tLBe+Jb
	 phLcCJLM+00eaFS275+i/WUp7+CjtVOLAdUMBr2SFDpsYEuL7ljyC8D/ciTQMvb1tz1o/
	 uJa5XkpNfGvB3XxhImHUSLRImB1APj/IP7auPEptaHjO1uX3ihhP41rvEmiJKoF1p9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9C2wMA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7F606A339;
	Fri, 20 Nov 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9C2wMA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A65D1F000C6;
	Fri, 20 Nov 2026 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189394;
	bh=ZEN1RjVeah5bf6s6B3kHtNiItihaG3NYeroyXdt03ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9C2wMA7eQRGwrD3Nqb4fsp/BRvb3GbdR01xpJ4hmIul8G5a9l8X5SY9dtcCL/LLO
	 InTebZZ9cObO3FIO/PCyVyLD7T2bl1I25s7gQUx0DlTF5JtTgntu2Ne6WOv49Fr05N
	 P+oHQhYjh9PfG5bnL311/h4mZMXnxmE+vo0m3nWC55+g5noA75PoLGZcFKxRkeYCz+
	 afCA5vrTrRp4Omp0mmuVEV8hi3SiDVMI3rUrDB7Us0m5PZg03oU6PetuzN6rjACSB1
	 DTfv34Ju9LrRVYotlQj4J0bVA0vTZTg7qDzpatR1HqTeBt3mGxuP2M2ZIhoaelgGr5
	 DrS/tDZllfoFQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Preserve structured histogram filter strings
Date: Sat, 21 Nov 2026 00:43:11 +0900
Message-ID: <undine-1795189391477787363-17dbbdcc692ec995@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <1218ce4d98a4c6ab6df6279c34d973b9d033755e.1795042969.git.edumucelli@gmail.com>
References: <1218ce4d98a4c6ab6df6279c34d973b9d033755e.1795042969.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 00:02:52 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> print_one_histogram() expands the hist.filter value through an unquoted
> command substitution. Field splitting collapses repeated whitespace in
> quoted filter strings, and pathname expansion replaces literal wildcard
> characters with filenames. The generated command is already incorrect
> before run_cmd() evaluates it.
>
> Print the filter with printf and a quoted command substitution so that
> structured histogram filters reach the generated command unchanged.
>
> Fixes: f134ebb28126 ("tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>

OK, looks good to me. Let me pick it.

Thanks!

> ---
> Hi Masami,
>
> Thanks for picking up the run_cmd() quoting fix. I had this small
> follow-up ready in case that patch went in.
>
> Here's the thread for that patch.
> https://lore.kernel.org/all/97454eceb5d56bf956740b8998972767bcfe6c70.1793216183.git.edumucelli@gmail.com/
>
> This uses the structured hist.filter option documented here:
> https://docs.kernel.org/trace/boottime-trace.html#ftrace-histogram-options
>
> I tested numbered and unnumbered histograms in a temporary tracefs
> instance on my Ubuntu machine, running kernel 7.0.0-38-generic. Repeated
> spaces and tabs were collapsed, and a wildcard expanded to filenames.
> With the fix, the generated and installed filters matched the input.
>
> The run_cmd() quoting fix was present in both versions of this test.
> This additional change fixes the string while the histogram command is
> being generated, before it reaches run_cmd().
>
> Feedback is welcome.
>
> Thanks,
> Eduardo
>
>  tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: 0ad31c3252d4c626a93ae6251340ef86b18342d0
>
> diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
> index 6a3535a2c..0992e54c6 100755
> --- a/tools/bootconfig/scripts/bconf2ftrace.sh
> +++ b/tools/bootconfig/scripts/bconf2ftrace.sh
> @@ -163,7 +163,7 @@ print_one_histogram() { # prefix
>  	print_hist_actions ${1} "onmatch" "event"
>  
>  	if xbc_has_key "${1}.filter"; then
> -		echo -n " if "`xbc_get_val ${1}.filter`
> +		printf ' if %s' "$(xbc_get_val ${1}.filter)"
>  	fi
>  }
>  
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
