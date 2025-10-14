Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9B305E3B;
	Tue, 14 Oct 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413169; cv=none; b=e8OiYn4HlBJalgauRDkq3UAYC3uydnPpDiFjFx2NSs1cqqCZtFTsJjo42XhENJM3JEG1CLLiaMmcRisylACCJJTZt2IPScUjp4QAhykIDQU6ckrxAPf/Roo9s3ILg2gFzNJ5mT3NiH1uH2FUuuuqzEfHWrMzIezntZF/gMPkj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413169; c=relaxed/simple;
	bh=dfOYQM6FikiJqXtJ3vwVZvQNvGVdhXDXHbo+1aXobwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jj3Pc3H35PL2KTjWXRkJdvyTQgGJayMqIoLKQLALlT6OvZ2yvkDD0aCByiC1HMpFZnnniprQ6NMLk8K3nPsW6yx6rr3JAUi8N6Q6hX3tJojMGJPYmHeRURbc3uqMIG4o9rUhTSNcIBHyei8FToa0j+0sGmVMocUcuKrK9H5164c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wYe59u/k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wYe59u/k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=105Uww+adoxXuzqGylGVzTMbR/EmwHYlpG5NHdEuhcs=; b=wYe59u/kOs9UsHGf4hYvdZeqiW
	+eRP+XH341HXOUNe3mvNVS5mgB62btr7p5H4ZY3zM/OxdyLhUxwpRc9sJfMMmTpAn1FNcNFg5+g9V
	tJu2VP74nrK3geDOZkgfeXlGIj8QtiDV4Jqy6WsNXDYbKCBKM1F3Z0Y09mXflbNV3YS8ChcIxvFZz
	JLrcvboI0O7V69zPKq4t1Z7TQ3aMyZ6HMeqFln7YtWcvCJyptOo9WILzCQL3OY/Wp7+3BeRDfUFVw
	KU4/1L8W8zXsDHlYMQdL7zKvuxosr0VXN6k7lXkmwsvK982DjZqx8yY2uyow+1aNDTW8iItXx288o
	hPCeQkPw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Vsk-0000000F4Ha-0Nu3;
	Tue, 14 Oct 2025 03:39:26 +0000
Message-ID: <80c32643-d2ac-4a12-a213-be4657cd6243@infradead.org>
Date: Mon, 13 Oct 2025 20:39:25 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Gopi Krishna Menon <krishnagopi487@gmail.com>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251013092719.30780-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 2:27 AM, Bagas Sanjaya wrote:
> From: Gopi Krishna Menon <krishnagopi487@gmail.com>
> 
> Sphinx reports htmldocs errors:
> 
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".
> 
> common_*.rst files are snippets that are intended to be included by rtla
> docs (rtla*.rst). common_options.rst in particular contains
> substitutions which depend on other common_* includes, so building it
> independently as reST source results in above errors.
> 
> Rename all common_*.rst files to common_*.txt to prevent Sphinx from
> building these snippets as standalone reST source and update all include
> references accordingly.
> 
> Link: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions
> Suggested-by: Tomas Glozar <tglozar@redhat.com>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> Reviewed-by: Tomas Glozar <tglozar@redhat.com>
> Fixes: 05b7e10687c6 ("tools/rtla: Add remaining support for osnoise actions")
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Link: https://lore.kernel.org/r/20251008184522.13201-1-krishnagopi487@gmail.com
> [Bagas: massage commit message and apply trailers]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> This patch targets trace/fixes branch of linux-trace.git tree.
> 
>  .../{common_appendix.rst => common_appendix.txt}     |  0
>  ...mmon_hist_options.rst => common_hist_options.txt} |  0
>  .../rtla/{common_options.rst => common_options.txt}  |  0
>  ...escription.rst => common_osnoise_description.txt} |  0
>  ...snoise_options.rst => common_osnoise_options.txt} |  0
>  ...common_timerlat_aa.rst => common_timerlat_aa.txt} |  0
>  ...scription.rst => common_timerlat_description.txt} |  0
>  ...erlat_options.rst => common_timerlat_options.txt} |  0
>  ...common_top_options.rst => common_top_options.txt} |  0
>  Documentation/tools/rtla/rtla-hwnoise.rst            |  8 ++++----
>  Documentation/tools/rtla/rtla-osnoise-hist.rst       | 10 +++++-----
>  Documentation/tools/rtla/rtla-osnoise-top.rst        | 10 +++++-----
>  Documentation/tools/rtla/rtla-osnoise.rst            |  4 ++--
>  Documentation/tools/rtla/rtla-timerlat-hist.rst      | 12 ++++++------
>  Documentation/tools/rtla/rtla-timerlat-top.rst       | 12 ++++++------
>  Documentation/tools/rtla/rtla-timerlat.rst           |  4 ++--
>  Documentation/tools/rtla/rtla.rst                    |  2 +-
>  17 files changed, 31 insertions(+), 31 deletions(-)
>  rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)
>  rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)
>  rename Documentation/tools/rtla/{common_options.rst => common_options.txt} (100%)
>  rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)
>  rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)
>  rename Documentation/tools/rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt} (100%)
>  rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)
>  rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)
>  rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)


-- 
~Randy
