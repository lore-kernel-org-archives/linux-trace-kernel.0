Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B71C4A0A;
	Mon,  7 Jul 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886682; cv=none; b=fiv4ZD5grJiX8UpD1rM/zNMGuZr+m9kRlI93IoktaBatD2KElh2/dG7vZXC66pHD7OfN5E3TBdU+X3ZQYThxK+H2snZKWaWGe4NYMA9ZSmRwnel89RWlmja4f8bH7+V3kpKAqoc8PPySWoJe4yYzq7nvQMiynxwwPI4RvreHy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886682; c=relaxed/simple;
	bh=Z0DzFa6Ck8MY9mheY3wDTdFe9/hvBRhpNbyrSmBtew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5ZbY1RMs0XvGrT4iQfWrEkHrM9HQm7ThTurLy/V9eAolRh8OkgfEdqp1hD2g5eeHtDkG+9Ox526BpE6yEk9QMq212R1mpjXoZgQ6hSNFG7oem8JJ6AvHw3pzbW8EKEz3zwKERVGu++Qc6WnZxBRb6CYQlFeFx1pYN0SvncizUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qezQPJ3w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qezQPJ3w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y28+p4hX9PEUMHUlBkI77beYKGWjbFcITsIbtfbTURs=; b=qezQPJ3wjgMr442XMPlt9n2Ksu
	W9LQMhSj5LhBqQ8d/2ilKfw/Xh5faImKUfSTZdYh6ljTF4E3OLJydHHiIcupLMTP05tFfBEQA0sbF
	gT9oR+Zh2Lsy+lTfffMLvfmMsqqNYxllbjKHnDUdez6wLV57ImIeAnx4b3JGg5NzFTB5cd+EEHjWr
	IoomUVw1wsJXd7cyIvpG1vJkS/D5iUI7eec0+9Y72SE9cAIOPaVWikrOH6Zyy4lMd93gJUhMjMSoq
	X0hpjXyRXFPvq88lj2eojs0O3NityG+y9vwZDjbcWWLq8S52H1vlmG52cXp6QfWtjxl1HwrQPnkWo
	1XK13jmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYjkV-00000008TRB-2rx3;
	Mon, 07 Jul 2025 11:11:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACA4C300399; Mon, 07 Jul 2025 13:11:02 +0200 (CEST)
Date: Mon, 7 Jul 2025 13:11:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
Message-ID: <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704134943.3524829-4-rppt@kernel.org>

On Fri, Jul 04, 2025 at 04:49:38PM +0300, Mike Rapoport wrote:
>  static bool execmem_cache_free(void *ptr)
>  {
>  	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
>  	unsigned long addr = (unsigned long)ptr;
>  	MA_STATE(mas, busy_areas, addr, addr);
>  	void *area;
> +	int err;
> +
> +	guard(mutex)(&execmem_cache.mutex);
>  
>  	area = mas_walk(&mas);
> +	if (!area)
>  		return false;
>  
> +	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> +	if (err)
> +		goto err_slowpath;
>  
>  	schedule_work(&execmem_cache_clean_work);
>  
>  	return true;
> +
> +err_slowpath:
> +	mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> +	execmem_cache.pending_free_cnt++;
> +	schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> +	return true;
>  }

This is a bit if an anti-pattern, using guard() and error goto. Since
there is only the one site, its best to write it like so:

static bool execmem_cache_free(void *ptr)
{
	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
	unsigned long addr = (unsigned long)ptr;
	MA_STATE(mas, busy_areas, addr, addr);
	void *area;
	int err;

	guard(mutex)(&execmem_cache.mutex);

	area = mas_walk(&mas);
	if (!area)
		return false;

	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
	if (err) {
		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
		execmem_cache.pending_free_cnt++;
		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
		return true;
	}

	schedule_work(&execmem_cache_clean_work);
	return true;
}

And now I have to ask what happens if mas_store_gfp() returns an error?
