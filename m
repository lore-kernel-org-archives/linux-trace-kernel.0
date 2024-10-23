Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33417F7;
	Wed, 23 Oct 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673388; cv=none; b=eK27yOM37hhgEqGbHXATSc+VKMKquVxTa/qiiKHXXH53Oyc5X7nXelsM6QeFi5EB3PzVRmOhpf1+t3Gd2qcSUR12FmQ9y5R6EA55gEKFShoyAu9R7dB2SsUuoa7AIV8dv5E328hZJekqat3yKh9ykhfsxRd8VoQD6Uz/cEYOO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673388; c=relaxed/simple;
	bh=LbO3NbepQkvZk7yCTg035pexaVjgPBDZmBLuQhHYH40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fOv+V7TcZ5S1n0U5e/oqNVM9YtXHbUXLVgc4irevDWiN45DhFR4OISiPD8/ZRAUZgVlWpWjNr4ndSHGqXoCdurRhaFxJuUQz6p3RfFOPfVLSIYaOLryXVnnULerSH/w8O+ZajSSbHtSQurhOBtqOXbM4EXlNNb1kvVuq/7Wkqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZMmn3+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZMmn3+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB44C4CEC6;
	Wed, 23 Oct 2024 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673387;
	bh=LbO3NbepQkvZk7yCTg035pexaVjgPBDZmBLuQhHYH40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZMmn3+n4j1CNsLy1QLuB05dT9u9rS+PPdrTPy8VVpXISB0padJvdTeXoB9x6Hwv4
	 AU974L3tZ5PkctyWTs2fGgDWjUzBztuMVWlKVgyjaM+oiJI5vk9KGE4k+LgpTBUqOd
	 7DAXg1wn24wiDVAV1BdtTK5MLPSX9rWOM+l9KlKW6rWcSwhOk8uV4K1CJRCPTSiYvo
	 s8qRiGPN+f1tA/EL/hG8deU+Ri5WOykQYD+c+nJfDb5FSaOtUo9CLg4u+zpkQnFdKF
	 2Ny1VDz/5znszIyT57l2Io5RTq/pGdTyhVxcu81EG2leknegld/uVC+Kf+MuuTtmD2
	 bC2DA3rme0YGg==
Date: Wed, 23 Oct 2024 17:49:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
 linux-trace-kernel@vger.kernel.org, yuran.pereira@hotmail.com,
 jason.wessel@windriver.com, daniel.thompson@linaro.org,
 dianders@chromium.org, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 2/2] trace: kdb: Replace simple_strtoul with kstrtoul
 in kdb_ftdump
Message-Id: <20241023174944.e85832349ef91ebff9cab31e@kernel.org>
In-Reply-To: <20241021211724.GC835676@lichtman.org>
References: <20241021211724.GC835676@lichtman.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:17:24 +0000
Nir Lichtman <nir@lichtman.org> wrote:

> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
> 
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
> 
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoint and kstrtol.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  kernel/trace/trace_kdb.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 59857a1ee44c..eadda6e05526 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -96,23 +96,20 @@ static int kdb_ftdump(int argc, const char **argv)
>  {
>  	int skip_entries = 0;
>  	long cpu_file;
> -	char *cp;
> +	int err;
>  	int cnt;
>  	int cpu;
>  
>  	if (argc > 2)
>  		return KDB_ARGCOUNT;
>  
> -	if (argc) {
> -		skip_entries = simple_strtol(argv[1], &cp, 0);
> -		if (*cp)
> -			skip_entries = 0;
> -	}
> +	if (argc && kstrtoint(argv[1], 0, &skip_entries))
> +		return KDB_BADINT;
>  
>  	if (argc == 2) {
> -		cpu_file = simple_strtol(argv[2], &cp, 0);
> -		if (*cp || cpu_file >= NR_CPUS || cpu_file < 0 ||
> -		    !cpu_online(cpu_file))
> +		err = kstrtol(argv[2], 0, &cpu_file);
> +		if (err || cpu_file >= NR_CPUS || cpu_file < 0 ||
> +			!cpu_online(cpu_file))
>  			return KDB_BADINT;
>  	} else {
>  		cpu_file = RING_BUFFER_ALL_CPUS;
> -- 
> 2.39.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
