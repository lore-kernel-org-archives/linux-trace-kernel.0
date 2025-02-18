Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413E1AED5C;
	Tue, 18 Feb 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878497; cv=none; b=E+9nsG+NHoOHCz/HV2J+M6Hg3zdJJ226CbVEmXL9V3L+TnAYBwk8lJgzfNAtntWxZucVHy00I6tJnvFwIWUpnqj44QLQ2Ds6/jGd+BxFK1HzhH57STh8mx8HTzF8D7NwbrqsgmCfEN3xOW6CQXYqFSTM2Fy8/VmjFP7lJE2JKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878497; c=relaxed/simple;
	bh=qy+ADcRDpL7IcB8ffbDmM4cQ3ihRFC1+NBOrsZ+ZJ44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUuV7/6oCgHJz4YoHO9wBROJ5+90Z4KV3vQHdX+IGXYz/NPgk84LYczMsDR2FhxXiYaOJSWdMuUSRye1UP4XpiwDybcxvz9FLgMYEW9cQH641g9zepcCW6JI7l0yOgiQ/ELA1iKnbtG1UVN1r+CDM6Q4cD3Q18hGj0vpoEABPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI1KhgME; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI1KhgME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D933C4CEE2;
	Tue, 18 Feb 2025 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739878497;
	bh=qy+ADcRDpL7IcB8ffbDmM4cQ3ihRFC1+NBOrsZ+ZJ44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DI1KhgME/ddB6KlXcskIiRYbGU1w4l6iNpN8f1ZQ2Aam1GA/Cv3Sd1BttW2yt3Cb/
	 qZrGBncfQ1smTx0kuyfi0m73PoYaqQzwfxtyRx8Tzg37EpdCUHgD20E++R0w6E95Oi
	 gFcikLuOBnYTMTKSwzLJE71FVoOkRmchRLr/NzyZzeEXPBSBuMe2Lve5ZGX5JVb2vp
	 dXRfYlBkhIeuwby7Tj4YxEHhypwt8uYd+ej2DRtbzTxRjyNQnv0m221wC9uDyFAPIq
	 HkUr8Xn5bqXJI6YuUdCzcSa8JvTwvYkl7TDnZ+FlFiUMmBn2cN6/HRzMB4NEib2cPO
	 6DVBgAFVfq4Bw==
Date: Tue, 18 Feb 2025 13:34:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release function
Message-ID: <Z7RwWyD67BxWPnK8@kernel.org>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
 <173928522350.906035.5626965043208329135.stgit@devnote2>
 <Z7Q1xY3jhWjaSdeh@kernel.org>
 <20250218174257.61018735a30268b5e21e50e3@kernel.org>
 <Z7RXGX/TyAvETRgc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RXGX/TyAvETRgc@kernel.org>

On Tue, Feb 18, 2025 at 11:47:11AM +0200, Mike Rapoport wrote:
> On Tue, Feb 18, 2025 at 05:42:57PM +0900, Masami Hiramatsu wrote:
> > Hi Mike,
> > 
> > 
> > Thanks! but I can not use free_reserved_area() here because it uses
> > virt_to_page(). Here we only know the physical address in the map.
> > I think we can use free_reserved_page() instead. Is that OK?
> 
> For reserve_mem ranges virt_to_phys() will work, they are allocated from the

I meant phys_to_virt() of course :)

> memory that is covered by the direct map.

-- 
Sincerely yours,
Mike.
