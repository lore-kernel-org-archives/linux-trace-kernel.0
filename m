Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438553E170C;
	Tue, 12 May 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591148; cv=none; b=tDWObDKQHWY8C5ei6MXCquZr9EM6enGsLJEz998ylvjCpy9upZdRECLo2YoTjjsBuRk+AHjXeYpoK0Gwk9pw1GSpbGar7DRnqUSvHpwtk7sKEU8ruN/f1FMJYuDkXf0wgWn3dZ4Htp2tn4h3/I6zeZAU7iACc2fh31o+TRryKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591148; c=relaxed/simple;
	bh=n8gaZFTUvxz2GlSH8if4QoMEk3XrJLJ4wMVxRfHKC3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXlfBf7LAydGXhxJ6Wrx8oqFwryWydjD6dWFJLuf58L2xi0iRWjhEWlUeo0HQVB9x3x9M8AF7uTauBKcw902DFzMpU6sK/FGtSMhB1LtgVwAyQO/3CjtUfmMyrQ4f85TREgbOMnDLiqGz3ZslfsF6yrPGtATKrCh2tzyatLkUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TbbFtDMD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TbbFtDMD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kX9NKZc878QSw9T/nFa6vS4SRnKB4jXUSRuipp9+zYg=; b=TbbFtDMDVxiioURi9D9kuOtmSW
	cETUFLucu9DUzw9+DFDImtEfVW+HvJknB/Dq48RIfpjP4PQlqAg9JFBMhrVoToz8+GTLWlAASsAXn
	ECD4xyOtJEmCmJUBNAgqD3vjN7uWz0KWGF0kz1WFu8d/z7UnCdqN6TBK1JVMjREfUBDl9GG/CHRca
	2rkx13nLibDxOjebq7bdpGIKLvXmYE5AFJuia/D3KYSUaC4bCBYFYytHaUM9AVGOo2AkGGGrsngHC
	3nKTh5Rz9hHXUsdXjzh35vu3bmCu4vZ4jl4+z378xsCu174PkJk5KB95Jb+zJBe/eweGM5wskKdCM
	PxVEDF6Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMmnj-002ObZ-1U;
	Tue, 12 May 2026 13:05:31 +0000
Date: Tue, 12 May 2026 06:05:25 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 3/4] mm/memory-failure: add panic option for
 unrecoverable pages
Message-ID: <agMlebHmui2quDBr@gmail.com>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-3-183012ba7d4b@debian.org>
 <8d4940bc-d8c4-4e7f-a35d-979e6a781966@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4940bc-d8c4-4e7f-a35d-979e6a781966@kernel.org>
X-Debian-User: leitao

On Tue, May 12, 2026 at 10:22:38AM +0200, David Hildenbrand (Arm) wrote:
> 
> > @@ -1281,6 +1292,18 @@ static void update_per_node_mf_stats(unsigned long pfn,
> >  	++mf_stats->total;
> >  }
> >  
> > +static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
> > +				      enum mf_result result)
> > +{
> > +	if (!sysctl_panic_on_unrecoverable_mf || result != MF_IGNORED)
> > +		return false;
> > +
> > +	if (type == MF_MSG_KERNEL)
> > +		return true;
> > +
> > +	return false;
> 
> return type == MF_MSG_KERNEL;
> 
> might be simpler.

Ack, I will update once we decide about the other pendencies.
