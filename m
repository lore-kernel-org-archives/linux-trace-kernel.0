Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16918871F;
	Mon, 29 Jun 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782772338; cv=none; b=fGpot0ijp8ipv6Hhvdyu1iuVoswE23RPmSkfbPS0i4nl4Dh2YcaHQEWemcRST9auIh9q8kvkzimSDaDCSXPYTparQtnoJLGIbmaCE9dbMtV3ZDeNAvdQq8Wr4Miq0k1X92s5RSuLDrdb7WGWgI3egQvf3SYRw2wGvotPc88V3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782772338; c=relaxed/simple;
	bh=IXrpKVvAGTKjMpceWk5fUweh3BAp8LTUBT3p1WLWfxo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MSROXhIrgaqwHy5nZHN+9OUc48QAWDBY8kauJOPGz2YlOtPHyTdSOtWU/fMghnkNtHhWhP8LezyKH5DAoQaMR3bsun0Pl2rZNyLWBl9SJ0iTGU64XqE/FRQy/xPY+8pHMQRT3WBJSlrGpJIhvK93brKbvorffdcSXbP1vDk1e88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjNsIWKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjNsIWKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616801F000E9;
	Mon, 29 Jun 2026 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782772337;
	bh=pNIootMACp5Mc2ZXQFXywYqm5t/dy3sZdSpdHUXYKic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OjNsIWKaQi53tNU7SKNp444fLcKcTTwQT5+VnkHcfqAiir5KZ4zykg1ovEIfBMKlS
	 5ynroOAsNTo7qOUIHBripxDjuQipAyy0XT1S7gE+7jCU5YSgFCe8jlK1kdH7KhWqdF
	 v5YseNTfMUC78pns4BbxQ/Ixv9fA/H1UL+kM4HMZh0u94/np4gBJZvdfR9bu/64OuA
	 OishKAmSNe0tGmUFmXK6Duf6r/veGgUuhY9VSM+ZPq0wA/3CzMthh8dU0uSS2wAFLC
	 aqS/UaGF0+9+RySDFlmqlUK3+1Vtb1vpoeg0qDRopitVQrjze7Q8zt2FrsMv0YgnlJ
	 P8Im2HHb0JUJQ==
Date: Tue, 30 Jun 2026 07:32:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 04/11] perf/probe: Ignore comment lines in
 dynamic_events/kprobe_events file
Message-Id: <20260630073211.2a505d1f31e5fae1bf03b81a@kernel.org>
In-Reply-To: <178271361825.1176915.16095297120719039761.stgit@devnote2>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
	<178271361825.1176915.16095297120719039761.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Arnaldo, Namhyung,

I forgot to CC this. Can I pick this patch via linux-trace tree,
or would you pick this?
This is a part of typecast series [1] only for debugging.

[1] https://lore.kernel.org/all/178271361825.1176915.16095297120719039761.stgit@devnote2/

Thanks,

On Mon, 29 Jun 2026 15:13:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since dynamic_events/kprobe_events files show the fetcharg debug
> information as comment lines, its reader needs to ignore it.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-file.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 4032572cbf55..4d12693a83b3 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -197,6 +197,8 @@ struct strlist *probe_file__get_rawlist(int fd)
>  		idx = strlen(p) - 1;
>  		if (p[idx] == '\n')
>  			p[idx] = '\0';
> +		if (buf[0] == '#')
> +			continue;
>  		ret = strlist__add(sl, buf);
>  		if (ret < 0) {
>  			pr_debug("strlist__add failed (%d)\n", ret);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
